class Admin::CategoriesController < ApplicationController
      http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASS']
  def show
    @category = Category.find(params[:id])
  end
  def index
    @categories = Category.order(id: :desc).all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end
   def destroy
    @category = Category.find params[:id]
    @category.destroy
    redirect_to [:admin, :category], notice: 'Product deleted!'
  end

  private

    def category_params
      params.require(:category).permit(
        :name
      )
    end

end