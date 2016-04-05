require 'rails_helper'
require 'webhooks'

RSpec.describe Webhooks::GitLab do
  let(:request) { FactoryGirl.build(:gitlab_webhook_request).request }
  let(:repository) { FactoryGirl.build(:repository) }
  subject { described_class.new(request, repository) }

  describe 'valid_request?' do
    context 'with the correct Gitlab header value' do
      it 'is expected to return true' do
        expect(subject.valid_request?).to be(true)
      end
    end

    context 'with an incorrect Gitlab header value' do
      let(:request) { FactoryGirl.build(:gitlab_webhook_request, headers: { 'X-Gitlab-Event' => 'Merge Hook' }).request }
      it 'is expected to return false' do
        expect(subject.valid_request?).to be(false)
      end
    end

    context 'without a GitLab header' do
      let(:request) { FactoryGirl.build(:gitlab_webhook_request, headers: {}).request }
      it 'is expected to return false' do
        expect(subject.valid_request?).to be(false)
      end
    end
  end

  describe 'webhook_address' do
    context 'the git URL is present' do
      it 'is expected to return the  URL' do
        expect(subject.webhook_address).to eq(request.params[:project][:git_http_url])
      end
    end

    context'the git URL is not present' do
      it 'is expected to return nil' do
        request.expects(:params).returns({})
        expect(subject.webhook_address).to be_nil
      end
    end
  end

  describe 'webhook_branch' do
    context 'the git ref is present' do
      it 'is expected to return the branch from the ref' do
        expect(subject.webhook_branch).to eq('master')
      end
    end

    context 'the git ref is not present' do
      it 'is expected to return nil' do
        request.expects(:params).returns({})
        expect(subject.webhook_branch).to be_nil
      end
    end
  end
end
