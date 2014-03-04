require 'spec_helper'

describe CheckCode do
  let(:submission) { double(id: 1, source_code: 'source') }

  describe '#initialize' do
    let(:temp_path) { File.join(described_class::PATH, '1', 'task.rb') }

    before do
      allow(FileUtils).to receive(:mkdir_p)
      allow(File).to receive(:write)

      @service = described_class.new(submission)
    end

    context "when directory doesn't exist" do
      it 'creates directory' do
        expect(FileUtils).to have_received(:mkdir_p)
          .with(File.dirname(temp_path))
      end
    end

    it 'creates tmp file with source code' do
      expect(File).to have_received(:write)
        .with(temp_path, 'source')
    end

    it 'memorizes path to file' do
      expect(@service.temp_path).to eq temp_path
    end
  end

  describe '#read' do
    let(:service) { described_class.new(submission) }

    before do
      service.stub(:perform) { |block| block << 'result' }
    end

    it 'yields block with result' do
      expect { |b| service.read(&b) }.to yield_with_args('result')
    end
  end
end
