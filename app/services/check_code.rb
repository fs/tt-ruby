require 'pty'

class CheckCode
  CMD = 'bin/run_submission'
  PATH = Rails.root.join('tmp/submissions')
  CPU_TIME = 5

  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def read(&block)
    stdout_or_errors.each(&block)
  end

  private

  def stdout_or_errors
    if submission_saved?
      Enumerator.new(&method(:check_code))
    else
      submission.errors.full_messages
    end
  end

  def submission_saved?
    if submission.save
      File.open(temp_file_path, 'w') do |file|
        file.write(submission.source_code)
      end
    end

    submission.valid?
  end

  def temp_file_path
    dir = File.join(PATH, submission.id.to_s)
    FileUtils.mkdir_p(dir) unless File.directory?(dir)

    File.join(dir, 'task.rb')
  end

  def check_code(block)
    master, slave = PTY.open
    spawn cmd,
      out: slave,
      rlimit_cpu: CPU_TIME,
      rlimit_rttime: CPU_TIME
    slave.close

    master.each { |line| block << line }
  rescue Errno::EIO
  end

  def cmd
    "#{CMD} --file #{temp_file_path}"
  end
end
