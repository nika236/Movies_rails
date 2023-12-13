class ReviewsController < ApplicationController
  before_action :set_review ,only:[:show, :update]
  before_action :set_movie , only: [:update, :create]

  def show
  end


  def create
    @review = @movie.reviews.build(review_params)
    @review.user = current_user
    if @review.save
      flash[:notice] = "Your Comment Published"
      redirect_to @movie
    else
      render 'movies/show', status: :unprocessable_entity
    end
  end


  def update
    if @review.update(review_params)
      flash[:notice] = "Comment Changed"
      redirect_to @review.movie
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    flash[:notice] = "Deleted"
    redirect_back fallback_location: movies_path
  end

  private

  def set_review
    @review = Review.find_by(id: params[:id])

    unless @review
      flash[:alert] = "Review Not Found"
      redirect_to movies_path
    end
  end

  def set_movie
    @movie = Movie.find_by(id: params[:movie_id])

    unless @movie
      flash[:alert] = "Movie Not Found"
      redirect_to movies_path
    end
  end

  def review_params
    params.require(:review).permit(:context, :rating,:movie_id, :user_id)
  end


end
