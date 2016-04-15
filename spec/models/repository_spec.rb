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
  end
end