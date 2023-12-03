# frozen_string_literal: true

require 'news-api'
class MyNewsItemsController < SessionController
  before_action :set_representative
  before_action :set_representatives_list
  before_action :set_issues_list
  before_action :set_news_item, only: %i[edit update destroy]

  def new
    @news_item = NewsItem.new
    @issue = ''
  end

  def edit; end

  def search
    newsapi = News.new(Rails.application.credentials[:NEWS_API_KEY])
    @issue = params['issue']
    articles = newsapi.get_everything(q:        "#{@representative.name} #{@issue}",
                                      sortBy:   'relevancy',
                                      page:     1,
                                      pageSize: 5)
    @news_items = articles.map do |art|
      NewsItem.new do |news|
        news.title = art.title
        news.link = art.url
        news.description = art.description
        news.representative_id = @representative.id
        news.issue = @issue
      end
    end
    session[:news_items] = @news_items.map(&:serializable_hash)
  end

  def create
    selected_index = params[:news_item_id].to_i
    selected_article = session[:news_items][selected_index]

    @news_item = NewsItem.new(
      title: selected_article.title,
      link: selected_article.link,
      description: selected_article.description,
      representative_id: @representative.id,
      issue: selected_article.issue,
      rating: params[:rating]
    )

    if @news_item.save
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully created.'
    else
      render :new, error: 'An error occurred when creating the news item.'
    end
  end

  def update
    if @news_item.update(news_item_params)
      redirect_to representative_news_item_path(@representative, @news_item),
                  notice: 'News item was successfully updated.'
    else
      render :edit, error: 'An error occurred when updating the news item.'
    end
  end

  def destroy
    @news_item.destroy
    redirect_to representative_news_items_path(@representative),
                notice: 'News was successfully destroyed.'
  end

  private

  def set_representative
    @representative = Representative.find(
      params[:representative_id]
    )
  end

  def set_representatives_list
    @representatives_list = Representative.all.map { |r| [r.name, r.id] }
  end

  def set_issues_list
    @issues_list = ['Free Speech', 'Immigration', 'Terrorism', 'Social Security and Medicare', 'Abortion',
                    'Student Loans', 'Gun Control', 'Unemployment', 'Climate Change', 'Homelessness', 'Racism',
                    'Tax Reform', 'Net Neutrality', 'Religious Freedom', 'Border Security', 'Minimum Wage', 'Equal Pay']
  end

  def set_news_item
    @news_item = NewsItem.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def news_item_params
    params.require(:news_item).permit(:news, :title, :description, :link, :representative_id)
  end
end
