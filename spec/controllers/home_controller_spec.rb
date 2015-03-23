require 'rails_helper'

describe HomeController, :type => :controller do
  context 'Method' do
    context '#index' do
      before :each do
        Project.expects(:latest).with(5).returns([])
      end

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
      end
    end
  end
end
