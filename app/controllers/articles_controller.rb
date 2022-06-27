class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to article_path(@article)
    else
      render :new
    end
    # @article.save : データベースに値を保存する
  end

  private
  def article_params
  # ホームから投稿されたデータの中からタイトルとコンテンツを抜き出す。
    params.require(:article).permit(:title, :content)
  end
end