require 'rails_helper'

describe Project, :type => :model do
  describe 'methods' do
    describe 'persisted?' do
      before :each do
        @subject = FactoryGirl.build(:project)
        Project.expects(:exists?).with(@subject.id).returns(false)
      end

      it 'should return false' do
        expect(@subject.persisted?).to eq(false)
      end
    end

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
          expect(@qt.update(@qt_params)).to eq(true)
        end
      end

      context 'with invalid attributes' do
        before :each do
          @qt.expects(:save).returns(false)
        end

        it 'should return false' do
          expect(@qt.update(@qt_params)).to eq(false)
        end
      end
    end

    describe 'repositories' do
      subject { FactoryGirl.build(:project) }
      let(:repository) { FactoryGirl.build(:repository) }

      it 'should call repositories_of on the Repository model' do
        Repository.expects(:repositories_of).with(subject.id).returns([repository])

        expect(subject.repositories).to include(repository)
      end
    end

    describe 'project_ownership' do
      subject { FactoryGirl.build(:project) }
      let(:project_ownership) {FactoryGirl.build(:project_ownership)}

      before :each do
        ProjectOwnership.expects(:find_by_project_id).with(subject.id).returns(project_ownership)
      end

      it 'should return the project ownership' do
        expect(subject.ownership).to eq(project_ownership)
      end
    end
  end

  describe 'validations' do
    subject {FactoryGirl.build(:project)}
    context 'active model validations' do  
      before :each do
        Project.expects(:all).at_least_once.returns([])
      end
      it { is_expected.to validate_presence_of(:name) }
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
