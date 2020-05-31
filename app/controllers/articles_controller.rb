class ArticlesController < ApplicationController
 
  def index
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end
 
  def show
    @article = Article.find(params[:id])
  end
  
  def new
    @article = Article.new
  end

  def edit
    @article = Article.find(params[:id])
  end

  def create
    @article = Article.new(article_params)
    @user = current_user
    @article.user = @user
    if @article.save
      flash[:notice] = "Article was successfully created"
      redirect_to @article
    else
      render 'new'
    end
  end

  def update
    @article = Article.find(params[:id])
  
    if @article.update(article_params)
      flash[:notice] = "Article was updated"
      redirect_to @article
    else
      flash[:notice] = "Article was not updated"
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:notice] = "Article was deleted"
    redirect_to articles_path
  end

  private
  def article_params
    params.require(:article).permit(:title, :text)
  end
end
