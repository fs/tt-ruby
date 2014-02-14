# You need create a class StringWorker that will work with strings
# The task is to replace 'a' and 'b' letters in the longest word of given string
# Your class also should match following specifications

# You should understand, that there are other specs and it is generated with
# random examples. So, please, do not try to cheate with code submitted =)

require 'spec_helper'

describe StringWorker do
  let(:input_string) { 'a fat black cat sat on a hat' }
  let(:string_worker) { StringWorker.new(input_string) }

  subject { string_worker }

  context 'when longest word has "a" and "b" letters' do
    it 'changes the longest word' do
      expect(subject.replace).to eq('a fat albck cat sat on a hat')
    end
  end

  context 'when longest word does not have "a" and "b" letters' do
    let(:input_string) { 'a fat super black cat sat on a hat' }

    it 'does not change the longest word' do
      expect(subject.replace).to eq(input_string)
    end
  end
end
