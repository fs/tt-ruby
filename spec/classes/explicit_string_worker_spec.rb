require 'spec_helper'

describe StringWorker do
  let(:input_string) { Faker::Lorem.sentence }
  let(:string_worker) { StringWorker.new(input_string) }
  let(:fs_string_worker) { FsStringWorker.new(input_string) }

  subject { string_worker }

  context 'it works with random word' do
    it 'changes the random word' do
      expect(subject.replace).to eq(fs_string_worker.replace)
    end
  end
end
