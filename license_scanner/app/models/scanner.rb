require 'fileutils'
# Wrapprer for 'license_finder'
class Scanner
  def self.call(url, commit)
    name = project_name(url)
    file_name = "#{LICENSE_CACHE_DIR}/#{name}-#{commit}.csv"
    unless File.exist?(file_name)
      Dir.mktmpdir do |dir|
        Dir.chdir dir
        git_fetch(url, commit)
        find_licenses(file_name)
      end
    end
    File.read(file_name)
  end

  LICENSE_CACHE_DIR = ENV.fetch('LICENSE_CACHE_DIR') { '/tmp/license_scanner/cache' }.freeze
  LICENSE_ARGS = ENV.fetch('LICENSE_ARGS') { '-r --prepare-no-fail' }.freeze
  LICENSE_COLUMNS = ENV.fetch('LICENSE_COLUMNS') { 'package_manager name version homepage licenses license_links' }.freeze

  class << self
    private

    def project_name(url)
      _p, project_name = URI(url).path.split('/', 2)
      project_name.chomp!('.git')
      project_name
    end

    def git_fetch(url, commit)
      Cmd.run("git clone #{url} .")
      Cmd.run("git checkout #{commit}") unless commit == 'HEAD'
    end

    COMMAND = 'license_finder report %s --format=csv --save=%s --columns=%s'.freeze

    def find_licenses(file_name)
      FileUtils.mkdir_p File.dirname(file_name)
      cmd = COMMAND % [LICENSE_ARGS, file_name, LICENSE_COLUMNS]
      Cmd.run(cmd)
    end
  end
end
