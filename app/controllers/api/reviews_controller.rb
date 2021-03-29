class Api::ReviewsController < ApplicationController
  # TODO uncomment after backend testing
  #  before_action :require_logged_in

  def create
    @review = current_user.reviews.new(review_params)

    if @review.save
      render :show
    else
      render json: @review, status: 422
    end
  end

  def index
    @reviews = Review.all
    render :index
  end

  def show
    @review = Review.find_by(id: params[:id])

    if @review
      render :show
    else
      render json: ["Review not found"], status: 404
    end
  end

  private
    def review_params
      params.require(:review).permit(:rating, :body, :product_id)
    end
end