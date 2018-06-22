#!/usr/bin/env python2.7

## print to console from flask route, cf. https://stackoverflow.com/a/33383239/2592915
#from __future__ import print_function
#import sys

from flask import Flask, request, Response
from urlparse import urlparse
import os
import shutil
import subprocess
import tempfile

CACHE_DIR = '/app/cache'
DEFAULT_RESULT_FORMAT = 'csv' #'json'

if not os.path.exists(CACHE_DIR):
    os.makedirs(CACHE_DIR)

app = Flask(__name__)


@app.route('/')
def handle_get():
    return display_help()


@app.route('/', methods=['POST'])
def scan_project():
    if not request.is_json:
        return "Post data must be json format"
    request_data = request.get_json()

    if 'source_url' not in request_data:
        return display_help()
    source_url = request_data['source_url']

    commit_id = 'HEAD'
    if 'commit_id' in request_data:
      commit_id = request_data['commit_id']

    format_param = DEFAULT_RESULT_FORMAT
    if 'format' in request_data:
        format_param = request_data['format']

    license_info_filename = CACHE_DIR + '/' + get_project_name(source_url) + "-" + commit_id \
                            + "." + format_param
    if not os.path.exists(license_info_filename):
        dir = git_fetch(source_url, commit_id)

        if 'pre_tasks' in request_data:
          #print(request_data['pre_tasks'], file=sys.stderr)
          subprocess.check_call(request_data['pre_tasks'], cwd=dir)

        find_licenses(dir, license_info_filename, format_param)

        # TODO: save json report for filebeat (requires format: csv/json)

        shutil.rmtree(dir, ignore_errors=True)

    with open(license_info_filename, "r") as license_info_file:
        license_info = license_info_file.readlines()

    mimetype = "application/{0}".format(format_param)
    return Response(license_info, mimetype=mimetype)


def display_help():
    return 'Please submit a POST request with json content.  {"source_url":"<url>", "commit_id":"<commit>"}'


def git_fetch(source_url, commit):
    project_name = get_project_name(source_url)
    git_repo_dir = tempfile.mkdtemp(prefix=project_name, suffix="-" + commit)
    subprocess.check_call(['git', 'clone', source_url, git_repo_dir])
    if commit != 'HEAD':
        subprocess.check_call(['git', 'checkout', commit], cwd=git_repo_dir)
    return git_repo_dir


def get_project_name(source_url):
    parsed_url = urlparse(source_url)
    _, project_name = os.path.split(parsed_url.path)
    project_name = os.path.splitext(project_name)[0]
    return project_name


def find_licenses(source_dir, output_file, format_param):
    # csv 2 json? https://stackoverflow.com/questions/19697846/how-to-convert-csv-file-to-multiline-json
    cmd = "license_finder report --prepare --format={0} --save={1}".format( format_param, output_file)
    output = subprocess.check_output(['bash', '-lc', cmd], cwd=source_dir, stderr=subprocess.STDOUT)
    if not os.path.exists(output_file):
        raise Warning(output)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
