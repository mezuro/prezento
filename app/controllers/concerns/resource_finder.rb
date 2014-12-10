module ResourceFinder
  extend ActiveSupport::Concern

  def find_resource(klass, id)
    begin
      klass.find(id)
    rescue KalibroGatekeeperClient::Errors::RecordNotFound
      respond_to do |format|
        format.html { render file: "#{Rails.root}/public/404", layout: false, status: :not_found }
      end

      return
    end
  end
end