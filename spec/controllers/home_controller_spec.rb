require 'rails_helper'

describe HomeController, :type => :controller do
  context 'actions' do
    context 'index' do
      describe 'Rendering' do
        before :each do
          get :index
        end
        it {is_expected.to render_template(:index)}
      end

      describe 'Language auto-detection' do
        it 'should automatically use the language specified in the request headers' do
          request.env['HTTP_ACCEPT_LANGUAGE'] = 'pt-BR'
          get :index
          expect(I18n.locale).to eq(:pt)
        end

        it 'should use a different region if still the best match' do
          request.env['HTTP_ACCEPT_LANGUAGE'] = 'en-GB'
          get :index
          expect(I18n.locale).to eq(:en)
        end

        it 'should use the default language if no available language matches the requested one' do
          request.env['HTTP_ACCEPT_LANGUAGE'] = 'de'
          get :index
          expect(I18n.locale).to eq(:en)
        end

        after do
          I18n.locale = I18n.default_locale
        end
      end
    end
  end

  context 'helpers' do
    describe 'latest_repositories' do
      let(:repositories) { mock }

      it 'should fetch the latest content' do
        Repository.expects(:latest).with(5).returns(repositories)
        expect(subject.latest_repositories(5)).to be(repositories)
      end
    end

    describe 'latest_projects' do
      let(:projects) { mock }

      it 'should fetch the latest content' do
        Project.expects(:latest).with(5).returns(projects)
        expect(subject.latest_projects(5)).to be(projects)
      end
    end

    describe 'latest_configurations' do
      let(:configurations) { mock }

      it 'should fetch the latest content' do
        KalibroConfiguration.expects(:latest).with(5).returns(configurations)
        expect(subject.latest_configurations(5)).to be(configurations)
      end
    end
  end
end
