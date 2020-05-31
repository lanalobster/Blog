class CommentsController < ApplicationController

  def new
    @comment = Comment.new
  end

  def edit
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  
  def show
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
  end

  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])

    if @comment.update(comment_params)
      flash[:notice] = "Comment was updated"
      redirect_to @article
    else
      flash[:notice] = "Comment was not updated"
      render 'edit'
    end
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    @user = current_user
    @comment.user = @user
    if @comment.save
      flash[:notice] = "Comment was successfully created"
      redirect_to article_path(@article)
    else
      render 'form'
    end
  end

  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end

  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
