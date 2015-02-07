class CommentsController < ApplicationController
  before_action :set_article
  def index
    @comments = @article.comments
  end
  def new
    @comment = Comment.new
  end
  def show
    @comment = @article.comments.find(params[:id])
  end
  def create
    @comment = @article.comments.create(comment_params)
    if @comment.save
      flash[:success] = 'Comment successfully created.'
      redirect_to article_comments_path(@article)
    else
      render 'new'
    end
  end
  def edit
    @comment = @article.comments.find(params[:id])
  end
  def update
    @comment = Comment.find(params[:id])
    if @comment.update(comment_params)
      flash[:success] = 'Comment successfully updated.'
      redirect_to article_comments_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    flash[:success] = 'Comment successfully deleted.'
    redirect_to article_comments_path(@article)
  end

private
  def set_article
    @article = Article.find(params[:article_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

end
