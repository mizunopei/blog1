class UsersController < ApplicationController
  def show
    user = User.find(params[:id])
    @nickname = user.nickname
    @articles = user.articles.page(params[:page]).per(5).order('created_at desc')
  end
end
