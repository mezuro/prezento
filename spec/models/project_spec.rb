require 'spec_helper'

describe Project do
  describe 'methods' do
    describe 'persisted?' do
      before :each do
        @subject = FactoryGirl.build(:project)
        Project.expects(:exists?).with(@subject.id).returns(false)
      end

      it 'should return false' do
        @subject.persisted?.should eq(false)
      end
    end

    describe 'latest' do
      before :each do
        @qt      = FactoryGirl.build(:project)
        @kalibro = FactoryGirl.build(:another_project)

        Project.expects(:all).returns([@qt, @kalibro])
      end

      it 'should return the two projects ordered' do
        Project.latest(2).should eq([@kalibro, @qt])
      end

      context 'when no parameter is passed' do
        it 'should return just the most recent project' do
          Project.latest.should eq([@kalibro])
        end
      end
    end
  end
end
