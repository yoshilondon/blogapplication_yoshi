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
      redirect_to article_path(@article), notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
    # @article.save : データベースに値を保存する
  end

  def edit
    @article = Article.find(params[:id])
  end

  private
  def article_params
    # ホームから投稿されたデータの中からタイトルとコンテンツを抜き出す。
    params.require(:article).permit(:title, :content)
    # strong parameter 最初にprivateを付ける
  end
end