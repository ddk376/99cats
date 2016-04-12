class CatsController < ApplicationController
  before_action :ensure_ownership, only: [:update, :edit]
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update(cat_params)
      redirect_to cat_url(@cat)
    else
      render :edit
    end
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.owner_id = current_user.id

    if @cat.save
      redirect_to cats_url
    else
      render :new
    end
  end

  def destroy
    cat = Cat.find(params[:id])
    cat.destroy

    redirect_to cats_url
  end

  private
  def ensure_ownership(cat)
    if cat.owner_id != current_user.id
      render :index 
    end
  end

  def cat_params
    params.require(:cats).permit(:name, :birth_date, :sex, :color, :description)
  end
end
