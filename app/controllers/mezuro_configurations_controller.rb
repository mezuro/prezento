class MezuroConfigurationsController < ApplicationController

  def index
    @configurations = MezuroConfiguration.all
  end
  
  def show
  	@configuration = MezuroConfiguration.find(params[:id])
  end

  def new
    @configuration = MezuroConfiguration.new
  end

  def create
  	@configuration = MezuroConfiguration.new(configuration_params)
  	if @configuration.save
  		redirect_to mezuro_configuration_path(@configuration.id),
  		notice: 'Configuração criada com sucesso!'
  	else
  		render action: :new
  	end
  end

  def edit
    @configuration = MezuroConfiguration.find(params[:id])
  end

  private

  def configuration_params
    params.
     require(:mezuro_configuration).
      permit(:name, :description)
  end

end

