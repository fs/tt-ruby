require 'spec_helper'

describe '/submissions' do

  describe 'create' do
    let(:params) do
      { submission: { email: 'my@example.com', source_code: 'source' } }
    end

    before do
      post('/submissions.json', params)
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
