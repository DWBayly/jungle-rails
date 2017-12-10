class ReviewsController < ApplicationController
   def new
    @review = Review.new
  end
  def create
    puts review_params.permitted?
    @review = Review.new(review_params)
    @review.description = params[:review][:description]
    @review.rating =params[:review][:rating]
    @product = Product.find(params[:product_id])
    @review.product = @product
    @review.user_id = session[:user_id]
    if @review.save!
      redirect_to @product, notice: 'Review created!'
    else
      puts "IT FAILED"
      render @product
    end
  end
  private
    def review_params
      params.require(:review).permit(:product_id)
    end
end
