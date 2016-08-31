class WebpagesController < ApplicationController
  before_action :set_webpage, only: [:show, :update, :destroy]

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
      render json: @webpage, status: :created, location: @webpage
    else
      render json: @webpage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /webpages/1
  def update
    if @webpage.update(webpage_params)
      render json: @webpage
    else
      render json: @webpage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /webpages/1
  def destroy
    @webpage.destroy
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
