require 'rails_helper'

describe Project, :type => :model do
  describe 'methods' do
    describe 'latest' do
      before :each do
        @qt      = FactoryGirl.build(:project)
        @kalibro = FactoryGirl.build(:another_project)

        Project.expects(:all).returns([@qt, @kalibro])
      end

      it 'should return the two projects ordered' do
        expect(Project.latest(2)).to eq([@kalibro, @qt])
      end

      context 'when no parameter is passed' do
        it 'should return just the most recent project' do
          expect(Project.latest).to eq([@kalibro])
        end
      end
    end
  end
end
