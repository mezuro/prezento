require 'rails_helper'

describe Repository do
  describe 'class method' do
    describe 'latest' do
      let!(:repository) { FactoryGirl.build(:repository, id: 1) }
      let!(:another_repository) { FactoryGirl.build(:another_repository, id: 2) }

      before do
        Repository.expects(:all).returns([repository, another_repository])
      end

      it 'should return the two repositorys ordered' do
        expect(Repository.latest(2)).to eq([another_repository, repository])
      end

      context 'when no parameter is passed' do
        it 'should return just the most recent repository' do
          expect(Repository.latest).to eq([another_repository])
        end
      end
    end

    describe 'public_or_owned_by_user' do
      let!(:user) { FactoryGirl.build(:user, :with_id) }

      let!(:owned_private_attrs)     { FactoryGirl.build(:repository_attributes, :private, user_id: user.id) }
      let!(:owned_public_attrs)      { FactoryGirl.build(:repository_attributes,           user_id: user.id) }
      let!(:not_owned_private_attrs) { FactoryGirl.build(:repository_attributes, :private, user_id: user.id + 1) }
      let!(:not_owned_public_attrs)  { FactoryGirl.build(:repository_attributes,           user_id: user.id + 1) }

      let!(:public_attrs) { [owned_public_attrs, not_owned_public_attrs] }
      let(:public_repositories) { public_attrs.map(&:repository) }

      let!(:owned_or_public_attrs) { public_attrs + [owned_private_attrs] }
      let!(:owned_or_public_repositories) { owned_or_public_attrs.map(&:repository) }

      let(:all_repositories) { owned_or_public_repositories + [not_owned_private_attrs.repository] }

      context 'when repositories exist' do
        before :each do
          all_repositories.each do |repository|
            described_class.stubs(:find).with(repository.id).returns(repository)
          end

          RepositoryAttributes.expects(:where).with(public: true).returns(public_attrs)
        end

        context 'when user is not provided' do
          it 'is expected to find all public repositories' do
            expect(described_class.public_or_owned_by_user).to eq(public_repositories)
          end
        end

        context 'when user is provided' do
          before do
            RepositoryAttributes.expects(:where).with(user_id: user.id, public: false).returns([owned_private_attrs])
          end

          it 'is expected to find all public and owned repositories' do
            expect(described_class.public_or_owned_by_user(user)).to eq(owned_or_public_repositories)
          end
        end
      end

      context 'when no repositories exist' do
        before :each do
          all_repositories.each do |repository|
            described_class.stubs(:find).with(repository.id).raises(Likeno::Errors::RecordNotFound)
          end

          RepositoryAttributes.expects(:where).with(public: true).returns(public_attrs)
        end

        it 'is expected to be empty' do
          expect(described_class.public_or_owned_by_user).to be_empty
        end
      end
    end
  end
end
