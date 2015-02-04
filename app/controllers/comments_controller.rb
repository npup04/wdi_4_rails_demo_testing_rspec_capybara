class CommentsController < ApplicationController
  def index
    @article = Article.find(params[:id])
    @comments = @article.comments
  end
end
