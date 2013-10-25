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

    describe 'update' do
      before :each do
        @qt = FactoryGirl.build(:project)
        @qt_params = Hash[FactoryGirl.attributes_for(:project).map { |k,v| [k.to_s, v.to_s] }] #FIXME: Mocha is creating the expectations with strings, but FactoryGirl returns everything with sybols and integers
      end

      context 'with valid attributes' do
        before :each do
          @qt.expects(:save).returns(true)
        end

        it 'should return true' do
          @qt.update(@qt_params).should eq(true)
        end
      end

      context 'with invalid attributes' do
        before :each do
          @qt.expects(:save).returns(false)
        end

        it 'should return false' do
          @qt.update(@qt_params).should eq(false)
        end
      end
    end

    describe 'repositories' do
      subject { FactoryGirl.build(:project) }
      let(:repository) { FactoryGirl.build(:repository) }

      it 'should call repositories_of on the Repository model' do
        Repository.expects(:repositories_of).with(subject.id).returns([repository])

        subject.repositories.should include(repository)
      end
    end
  end

  describe 'validations' do
    subject {FactoryGirl.build(:project)}
    context 'active model validations' do  
      before :each do
        Project.expects(:all).at_least_once.returns([])
      end
      it { should validate_presence_of(:name) }
    end

    context 'kalibro validations' do
      before :each do
        Project.expects(:request).returns(42)
      end

      it 'should validate uniqueness' do
        KalibroUniquenessValidator.any_instance.expects(:validate_each).with(subject, :name, subject.name)
        subject.save
      end
    end
  end
end
