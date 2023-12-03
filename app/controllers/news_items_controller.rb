# frozen_string_literal: true

class NewsItemsController < SessionController
  before_action :set_representative
  before_action :set_news_item, only: %i[show]

  def index
    @news_items = @representative.news_items
  end

  def show; end

  def create_rating
    if @current_user.nil?
      render json: { error: 'You must be logged in to rate a news item' }, status: :unauthorized
      return
    end
    @news_item = NewsItem.find(params[:news_item_id])
    if Rating.where(user: @current_user, news_item: @news_item).exists?
      render json: { error: 'You have already rated this news item' }, status: :unprocessable_entity
    else
      @news_item.ratings.create!(user: @current_user, score: params[:rating].to_i)
      render json: { message: 'Rating created' }, status: :created
    end
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

end
