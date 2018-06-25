#!/usr/bin/env python2.7
from flask import Flask, request, Response
import os
import shutil
import subprocess
import tempfile
from urlparse import urlparse

LICENSE_CACHE_DIR = os.getenv('LICENSE_CACHE_DIR', '/app/cache')
LICENSE_FORMAT = os.getenv('LICENSE_FORMAT', 'csv')
LICENSE_COLUMNS = os.getenv('LICENSE_COLUMNS', 'package_manager name version homepage licenses license_links')
LICENSE_DEBUG = os.getenv('LICENSE_DEBUG', 'false') == 'true'
LICENSE_ARGS = os.getenv('LICENSE_ARGS', '-r --prepare-no-fail')

if not os.path.exists(LICENSE_CACHE_DIR):
    os.makedirs(LICENSE_CACHE_DIR)

app = Flask(__name__)


@app.route('/')
def handle_get():
    return display_help()


@app.route('/', methods=['POST'])
def scan_project():
    if not request.is_json:
        return "Post data must be json format"
    request_data = request.get_json()
    if not {'source_url', 'commit_id'} <= set(request_data):
        return display_help()
    source_url = request_data['source_url']
    commit_id = request_data['commit_id']

    report_fmt = LICENSE_FORMAT
    if 'format' in request_data:
        report_fmt = request_data['format']

    columns = LICENSE_COLUMNS
    if 'columns' in request_data:
        columns = request_data['columns']

    license_info_filename = LICENSE_CACHE_DIR + '/' + get_project_name(source_url) + "-" + commit_id \
                            + "." + report_fmt
    if not os.path.exists(license_info_filename):
        dir = git_fetch(source_url, commit_id)
        find_licenses(dir, license_info_filename, report_fmt, LICENSE_COLUMNS)
        shutil.rmtree(dir, ignore_errors=True)

    with open(license_info_filename, "r") as license_info_file:
        license_info = license_info_file.readlines()

    mimetype = "application/{0}".format(report_fmt)
    return Response(license_info, mimetype=mimetype)


def display_help():
    return 'Please submit a POST request with json content.  {"source_url":"<url>", "commit_id":"<commit>"}'


def git_fetch(source_url, commit):
    project_name = get_project_name(source_url)
    git_repo_dir = tempfile.mkdtemp(prefix=project_name, suffix="-" + commit)
    call(['git', 'clone', source_url, git_repo_dir])
    if commit != 'HEAD':
        call(['git', 'checkout', commit], git_repo_dir)
    return git_repo_dir


def get_project_name(source_url):
    parsed_url = urlparse(source_url)
    _, project_name = os.path.split(parsed_url.path)
    project_name = os.path.splitext(project_name)[0]
    return project_name


def find_licenses(source_dir, output_file, report_fmt, columns):
    COMMAND = "license_finder report {3} --format={0} --save={1} --columns={2}"
    other_args = LICENSE_ARGS
    args = COMMAND.format(report_fmt, output_file, columns, other_args)
    result = call(['bash', '-lc', args], source_dir)
    if not os.path.exists(output_file):
        raise Warning(result)


def call(cmd, dir='.'):
    output = subprocess.check_output(cmd, cwd=dir, stderr=subprocess.STDOUT)
    app.logger.info(output)
    return output


if __name__ == '__main__':
    app.run(debug=LICENSE_FORMAT, host='0.0.0.0')
