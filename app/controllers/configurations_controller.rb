class ConfigurationsController < ApplicationController
  
  def show
  	@configuration = Configuration.find(params[:id])
  end

  def new
    @configuration = Configuration.new
  end

  def create
	@configuration = Configuration.new(configuration_params)
	if @configuration.save
		redirect_to @configuration,
		notice: 'Configuração criada com sucesso!'
	else
		render action: :new
	end
  end

  private

  def configuration_params
    params.
     require(:configuration).
      permit(:name, :description)
  end

end
