class ArticlesController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  def index 
    @articles = Article.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new 
  end

  def create 
    Article.create(title: article_params[:title], content: article_params[:content], user_id: current_user.id)
    redirect_to action: :index
  end

  def destroy
    article = Article.find(params[:id])
    article.destroy if article.user_id == current_user.id
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    article = Article.find(params[:id])
    article.update(article_params) if article.user_id == current_user.id
  end

  def show
    @article = Article.find(params[:id])
  end

  private
  def article_params
    params.permit(:title, :content)
  end

  def move_to_index
    redirect_to action: :index unless user_signed_in?
  end

end
