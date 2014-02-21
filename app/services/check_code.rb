require 'pty'

class CheckCode
  CMD = Rails.env.development? ?
    'bin/run_submission_dev' :
    'bin/run_submission'
  PATH = Rails.root.join('tmp/submissions')
  CPU_TIME = 5

  attr_reader :submission, :temp_path

  def initialize(submission)
    @submission = submission
    @temp_path = create_temp_source_file
  end

  def read(&block)
    Enumerator.new(&method(:perform)).each(&block)

    FileUtils.rm_rf(File.dirname(temp_path))
  end

  private

  def create_temp_source_file
    path = File.join(PATH, submission.id.to_s, 'task.rb')
    FileUtils.mkdir_p(File.dirname(path)) unless File.directory?(path)
    File.write(path, submission.source_code)

    path
  end

  def perform(block)
    master, slave = PTY.open
    spawn "#{CMD} --file #{temp_path}",
      out: slave,
      rlimit_cpu: CPU_TIME,
      rlimit_rttime: CPU_TIME
    slave.close

    master.each { |line| block << line }
  rescue Errno::EIO
  end
end
