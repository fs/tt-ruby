class CheckCode
  CMD = 'bin/run_submission'
  PATH = Rails.root.join('tmp/submissions')

  attr_reader :submission

  def initialize(submission)
    @submission = submission
  end

  def read
    if submission_saved?
      Enumerator.new(&method(:check_code))
    else
      submission.errors.full_messages
    end
  end

  private

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
    IO.popen(cmd) do |stdin|
      stdin.each { |line| block << line }
    end
  rescue Errno::EIO
  end

  def cmd
    "#{CMD} --file #{temp_file_path}"
  end
end
