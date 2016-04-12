class CatRentalRequestsController < ApplicationController
  def index
    @requests = CatRentalRequest.all
    render :index
  end

  def new
    @request = CatRentalRequest.new
    @cats = Cat.all

    render :new
  end

  def create
    @request = CatRentalRequest.new(request_params)
    @cats = Cat.all

    if @request.save
      redirect_to cat_rental_requests_url
    else
      render :new
    end
  end

  def edit
    @request = CatRentalRequest.new
    @cats = Cat.all

    render :edit
  end

  def update
    @request = CatRentalRequest.find(params[:id])

    if @request.update(request_params)
      redirect_to cat_rental_request(@request)
    else
      render :edit
    end
  end

  private
  def request_params
    params.require(:requests).permit(:start_date, :end_date, :cat_id)
  end
end
