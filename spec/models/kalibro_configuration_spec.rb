require 'rails_helper'

describe KalibroConfiguration, :type => :model do
  describe 'methods' do
    describe 'class methods' do
      describe 'public_or_owned_by_user' do
        def build_attrs(kc_iter, *traits, **params)
          kalibro_configuration = kc_iter.next
          attr = FactoryGirl.build(:kalibro_configuration_attributes, *traits, params.merge(kalibro_configuration: kalibro_configuration))
          kalibro_configuration.stubs(:attributes).returns(attr)
          attr
        end

        let!(:kalibro_configurations) { FactoryGirl.build_list(:kalibro_configuration, 4, :with_sequential_id) }
        let!(:kc_iter) { kalibro_configurations.each }

        let!(:one_user) { FactoryGirl.build(:user) }
        let!(:other_user) { FactoryGirl.build(:another_user) }

        let!(:ones_private_attrs) { build_attrs(kc_iter, :private, user: one_user) }
        let!(:others_private_attrs) { build_attrs(kc_iter, :private, user: other_user) }
        let!(:ones_public_attrs) { build_attrs(kc_iter, user: one_user) }
        let!(:others_public_attrs) { build_attrs(kc_iter, user: other_user) }

        let!(:public_attrs) { [ones_public_attrs, others_public_attrs] }
        let(:public_kalibro_configurations) { public_attrs.map(&:kalibro_configuration) }

        let(:ones_or_public_attrs) { public_attrs + [ones_private_attrs] }
        let(:ones_or_public_kalibro_configurations) { ones_or_public_attrs.map(&:kalibro_configuration) }

        context 'when the kalibro configuration exists' do
          before :each do
            # Map the kalibro_configuration attributes to the corresponding Kalibro Configuration
            kalibro_configurations.each do |kc|
              KalibroConfiguration.stubs(:find).with(kc.id).returns(kc)
            end

            KalibroConfigurationAttributes.expects(:where).with(public: true).returns(public_attrs)
          end

          context 'when user is not provided' do
            it 'should find all public reading groups' do
              expect(KalibroConfiguration.public).to eq(public_kalibro_configurations)
            end
          end

          context 'when user is provided' do
            before do
              KalibroConfigurationAttributes.expects(:where).with(user_id: one_user.id, public: false).returns([ones_private_attrs])
            end

            it 'should find all public and owned reading groups' do
              expect(KalibroConfiguration.public_or_owned_by_user(one_user)).to eq(ones_or_public_kalibro_configurations)
            end
          end
        end

        context 'when the kalibro configuration does not' do
          before :each do
            # Map the kalibro_configuration attributes to the corresponding Kalibro Configuration
            kalibro_configurations.each do |kc|
              KalibroConfiguration.stubs(:find).with(kc.id).raises(Likeno::Errors::RecordNotFound)
            end

            KalibroConfigurationAttributes.expects(:where).with(public: true).returns(public_attrs)
          end

          it 'is expected to be empty' do
            expect(KalibroConfiguration.public).to be_empty
          end
        end
      end

      describe 'latest' do
        let!(:kalibro_configuration) { FactoryGirl.build(:kalibro_configuration, id: 1) }
        let!(:another_kalibro_configuration) { FactoryGirl.build(:another_kalibro_configuration, id: 2) }
        let!(:kalibro_configuration_attributes) { FactoryGirl.build(:kalibro_configuration_attributes) }

        before :each do
          kalibro_configuration.expects(:attributes).returns(kalibro_configuration_attributes)
          another_kalibro_configuration.expects(:attributes).returns(kalibro_configuration_attributes)

          KalibroConfiguration.expects(:all).returns([kalibro_configuration, another_kalibro_configuration])
        end

        it 'should return the two kalibro_configurations ordered' do
          expect(KalibroConfiguration.latest(2)).to eq([another_kalibro_configuration, kalibro_configuration])
        end

        context 'when no parameter is passed' do
          it 'should return just the most recent kalibro_configuration' do
            expect(KalibroConfiguration.latest).to eq([another_kalibro_configuration])
          end
        end
      end
    end

    describe 'destroy' do
      context 'when attributes exist' do
        let!(:kalibro_configuration_attributes) { FactoryGirl.build(:kalibro_configuration_attributes) }
        let!(:kalibro_configuration) { kalibro_configuration_attributes.kalibro_configuration }

        it 'should be destroyed' do
          kalibro_configuration.expects(:attributes).twice.returns(kalibro_configuration_attributes)
          kalibro_configuration_attributes.expects(:destroy)
          KalibroClient::Entities::Configurations::KalibroConfiguration.any_instance.expects(:destroy).returns(kalibro_configuration)
          kalibro_configuration.destroy
        end

        it 'is expected to clean the attributes memoization' do
          # Call attributes once so it memoizes
          KalibroConfigurationAttributes.expects(:find_by).with(kalibro_configuration_id: kalibro_configuration.id).returns(kalibro_configuration_attributes)
          KalibroClient::Entities::Configurations::KalibroConfiguration.any_instance.expects(:destroy).returns(kalibro_configuration)
          expect(kalibro_configuration.attributes).to eq(kalibro_configuration_attributes)

          # Destroying
          kalibro_configuration.destroy

          # The expectation call will try to find the attributes on the database which should be nil since it was destroyed
          KalibroConfigurationAttributes.expects(:find_by).with(kalibro_configuration_id: kalibro_configuration.id).returns(nil)
          expect(kalibro_configuration.attributes).to be_nil
        end
      end
    end
  end
end
