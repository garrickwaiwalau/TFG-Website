class IndexController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @articles = Index.all
  end

  def show
    @article = Index.find(params[:id])
  end

  def new
    @article = Index.new
  end

  def create
    @article = Index.new(article_params)

    if @article.save
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Index.find(params[:id])
  end

  def update
    @article = Index.find(params[:id])

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end

    puts "update"
  end

  def destroy
    @article = Index.find(params[:id])
    @article.destroy

    redirect_to root_path, status: :see_other
  end

  private
    def article_params
      params.require(:article).permit(:title, :body, :status)
    end
end
