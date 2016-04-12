require 'rails_helper'
require 'webhooks'

RSpec.describe Webhooks::Base do
  let(:request) { ActionController::TestRequest.new }
  let(:repository) { FactoryGirl.build(:repository) }

  subject { described_class.new(request, repository) }

  describe 'initialize' do
    it 'is expected to initialize request and repository' do
      expect(subject.request).to eq(request)
      expect(subject.repository).to eq(repository)
    end
  end

  describe 'valid_request?' do
    it 'is expected to not be implemented' do
      expect { subject.valid_request? }.to raise_error(NotImplementedError)
    end
  end

  describe 'webhook_address' do
    it 'is expected to not be implemented' do
      expect { subject.webhook_address }.to raise_error(NotImplementedError)
    end
  end

  describe 'webhook_branch' do
    it 'is expected to not be implemented' do
      expect { subject.webhook_branch }.to raise_error(NotImplementedError)
    end
  end

  describe 'valid_address?' do
    it 'is expected to return true if the repository and webhook addresses match' do
      subject.expects(:webhook_address).returns(repository.address)
      expect(subject.valid_address?).to eq(true)
    end

    it "is expected to return false if the repository and webhook addresses don't match" do
      subject.expects(:webhook_address).returns('test')
      expect(subject.valid_address?).to eq(false)
    end
  end

  describe 'valid_branch?' do
    it 'is expected to return true if the repository and webhook branches match' do
      subject.expects(:webhook_branch).returns(repository.branch)
      expect(subject.valid_branch?).to eq(true)
    end

    it "is expected to return false if the repository and webhook addresses don't match" do
      subject.expects(:webhook_branch).returns('test')
      expect(subject.valid_branch?).to eq(false)
    end
  end

  describe 'branch_from_ref' do
    cases = {
        nil => nil,
        'refs/heads/master' => 'master',
        'refs/tags/test' => nil,
        'test' => nil,
        '' => nil
    }

    cases.each do |input, output|
      it "is expected to return #{output.inspect} for #{input.inspect}" do
        expect(subject.send(:branch_from_ref, input)).to eq(output)
      end
    end
  end
end
