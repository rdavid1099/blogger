class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find( params[:id] )
    @comment = Comment.new
    @comment.article_id = @article.id
  end

  def create
    @article = Article.new( article_params )
    if @article.save
      flash.notice = "Article Saved!"
      redirect_to article_path(@article)
    else
      render :new
    end
  end

  def new
    @article = Article.new
  end

  def edit
    @article = Article.find( params[:id] )
  end

  def update
    @article = Article.find( params[:id] )
    @article.update( article_params )
    if @article.save
      flash.notice = "Article '#{@article.title}' Updated"
      redirect_to article_path(@article)
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find( params[:id] )
    @article.destroy
    flash.notice = "Article Deleted!"
    redirect_to articles_path
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :tag_list)
  end
end
