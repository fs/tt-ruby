require 'spec_helper'

describe '/submissions' do

  describe 'update' do
    let(:submission) { create(:submission) }
    let(:params) do
      { submission: { source_code: 'source' } }
    end

    before do
      put("/submissions/#{submission.id}.json", params)
    end

    subject { response }

    context 'with valid data' do
      it { should be_success }
    end

    context 'with invalid data' do
      let(:params) { super().deep_merge(submission: { source_code: '' }) }

      subject { JSON.parse(response.body)['errors'] }

      it { should == ["Source code can't be blank"] }
    end
  end
end
