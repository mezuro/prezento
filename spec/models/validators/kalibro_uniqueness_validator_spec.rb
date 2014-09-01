require 'rails_helper'

describe KalibroUniquenessValidator, :type => :model do
  describe 'methods' do
    describe 'validate_each' do
      context 'without saved projects' do
        before :each do
          Project.expects(:all).returns([])
          Project.expects(:request).returns(42)
        end

        subject { FactoryGirl.build(:project) }
        it 'should contain no errors' do
          subject.save
          expect(subject.errors).to be_empty
        end
      end

      context 'with name already taken by another project' do
        before :each do
          @subject = FactoryGirl.build(:project)
          Project.expects(:all).returns([FactoryGirl.build(:project, id: @subject.id + 1)])
        end

        it 'should contain errors' do
          @subject.save
          expect(@subject.errors[:name]).to eq(["There is already a Project with name #{@subject.name}! Please, choose another one."])
        end
      end
    end
  end
end
