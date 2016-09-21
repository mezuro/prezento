require 'rails_helper'

describe Repository do
  describe 'methods' do
    describe 'attributes' do
      subject { FactoryGirl.build(:repository) }

      context 'when there are attributes' do
        let!(:repository_attributes) { FactoryGirl.build(:repository_attributes) }

        before :each do
          RepositoryAttributes.expects(:find_by_repository_id).returns(repository_attributes)
        end

        it 'is expected to return the repository attributes' do
          expect(subject.attributes).to eq(repository_attributes)
        end
      end

      context 'when there are no attributes' do
        before :each do
          RepositoryAttributes.expects(:find_by_repository_id).returns(nil)
        end

        it 'is expected to return the repository attributes' do
          expect(subject.attributes).to be_nil
        end
      end
    end

    describe 'destroy' do
      let!(:repository) { FactoryGirl.build(:repository) }

      context 'when attributes exist' do
        let!(:repository_attributes) { FactoryGirl.build(:repository_attributes, repository_id: repository.id) }
        before :each do
          KalibroClient::Entities::Processor::Repository.any_instance.expects(:destroy).returns(repository)
        end

        it 'is expected to be destroyed' do
          repository.expects(:attributes).twice.returns(repository_attributes)
          repository_attributes.expects(:destroy)
          repository.destroy
        end

        it 'is expected to clean the attributes memoization' do
          # Call attributes once so it memoizes
          RepositoryAttributes.expects(:find_by).with(repository_id: repository.id).returns(repository_attributes)
          expect(repository.attributes).to eq(repository_attributes)

          # Destroying
          repository.destroy

          # The expectation call will try to find the attributes on the database which should be nil since it was destroyed
          RepositoryAttributes.expects(:find_by).with(repository_id: repository.id).returns(nil)
          expect(repository.attributes).to_not eq(repository_attributes)
        end
      end

      context 'when attributes is nil' do
        before do
          repository.expects(:attributes).returns(nil)
          KalibroClient::Entities::Processor::Repository.any_instance.expects(:destroy).returns(repository)
        end

        it 'is expected to not try to destroy the attributes' do
          repository.destroy
        end
      end
    end
  end

  describe 'class method' do
    describe 'latest' do
      let!(:repository) { FactoryGirl.build(:repository) }
      let!(:another_repository) { FactoryGirl.build(:repository, id: 2) }
      let!(:repository_attributes) { FactoryGirl.build(:repository_attributes) }

      before :each do
        repository.expects(:attributes).returns(repository_attributes)
        another_repository.expects(:attributes).returns(repository_attributes)
      end

      context 'without private repositories' do
        before :each do
          Repository.expects(:all).returns([repository, another_repository])
        end

        it 'is expected to return the two repositories ordered' do
          expect(Repository.latest(2)).to eq([another_repository, repository])
        end

        context 'when no parameter is passed' do
          it 'is expected to return just the most recent repository' do
            expect(Repository.latest).to eq([another_repository])
          end
        end
      end

      context 'with private repositories' do
        let(:private_repository) { FactoryGirl.build(:repository, id: 3) }
        let(:private_attributes) { FactoryGirl.build(:repository_attributes, :private) }

        before :each do
          private_repository.expects(:attributes).returns(private_attributes)

          Repository.expects(:all).returns([repository, another_repository, private_repository])
        end

        it 'is expected to return only the public ones' do
          expect(Repository.latest(2)).to eq([another_repository, repository])
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
