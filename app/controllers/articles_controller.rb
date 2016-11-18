class ArticlesController < ApplicationController
  # before_action :authenticate_user!, except: [:index]

  def index
    @articles = Article.all
    @search = Article.ransack(params[:q])
    @articles = @search.result
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  def show
    @article = Article.find(params[:id])
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @revision = Article.new(article_params)

    @article.revisions << Revision.new(editior_id: current_user.id, article_id: @article.id )

    if @revision.save
      redirect_to @revision
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to '/'
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :author_id)
    end

end