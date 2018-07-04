require 'open3'

# Run a shell command
class Cmd
  def self.run(command, working_directory = '.')
    stdout, stderr, status = Open3.capture3(command, chdir: working_directory)
    msg ="#{command}\n#{[stderr, stdout].join("\n")}"
    Rails.logger.debug(msg)
    raise StandardError, stderr unless status.success?
    stdout
  end
end
