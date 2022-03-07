class ReviewsController < ApplicationController
  def new
    @review = Review.new(booking_id: params[:booking_id])
  end

  def create
    @review = Review.new(review_params)
    @user = current_user
    if @review.valid?
      @review.save
      redirect_to booking_path(id: @review.booking_id)
    else
      @review = Review.new
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    @reviews = Review.all
  end

  def show
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment, :booking_id)
  end
end
