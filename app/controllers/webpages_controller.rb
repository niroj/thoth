class WebpagesController < ApplicationController
  before_action :set_webpage, only: [:show]

  # GET /webpages
  def index
    @webpages = Webpage.all

    render json: @webpages
  end

  # GET /webpages/1
  def show
    render json: @webpage
  end

  # POST /webpages
  def create
    @webpage = Webpage.new(webpage_params)

    if @webpage.save
      render json: {message: "The given url will be indexed shortly", webpage: @webpage.as_json(only: [:id, :url])}, status: :created, location: @webpage
    else
      render json: @webpage.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webpage
      @webpage = Webpage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def webpage_params
      params.require(:webpage).permit(:url)
    end
end
