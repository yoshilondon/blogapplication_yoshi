class ArticlesController < ApplicationController
  before_action :set_article, only: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    @articles = Article.all
  end

  def show
  end

  def new
    @article = current_user.articles.build
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      redirect_to article_path(@article), notice: '保存できました'
    else
      flash.now[:error] = '保存に失敗しました'
      render :new
    end
    # @article.save : データベースに値を保存する
  end

  def edit
    @article = current_user.articles.find(params[:id])
  end

  def update
    @article = current_user.articles.find(params[:id])
    if @article.update(article_params)
      redirect_to article_path(@article), notice: '更新出来ました'
    else
      flash.now[:error] = '更新出来ませんでした'
      render :edit
    end
  end

  def destroy
    article = current_user.articles.find(params[:id])
    article.destroy!
    redirect_to root_path, notice: '削除に成功しました'
  end

  private
  def article_params
    # ホームから投稿されたデータの中からタイトルとコンテンツを抜き出す。
    params.require(:article).permit(:title, :content)
    # strong parameter 最初にprivateを付ける
  end

  def set_article
    @article = Article.find(params[:id])
  end
end
