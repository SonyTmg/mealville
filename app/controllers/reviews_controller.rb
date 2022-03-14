class ReviewsController < ApplicationController
  # Review form is in Host user's profile page, new action is not needed
  # def new
  #   @review = Review.new(booking_id: params[:booking_id])
  # end

  def create
    @review = Review.new(review_params)
    @user = current_user
    if @review.valid?
      @review.save
      redirect_to profile_path(id: @review.for_user_id)
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
    params.require(:review).permit(:rating, :comment, :for_user_id, :by_user_id)
  end
end
