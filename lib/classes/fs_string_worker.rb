class FsStringWorker
  def initialize(input_string)
    @input_string = input_string
  end

  def replace
    words = @input_string.split(/\W+/)
    longest_word = words.max_by(&:length)
    if longest_word.count('m') > 0 && longest_word.count('m') > 0
      replaced_chars_in_word = longest_word.gsub(/[mn]/, 'm'=> 'n', 'n'=>'m')
      @input_string.gsub!(/#{longest_word}/, replaced_chars_in_word)
    end
    @input_string
  end
end
