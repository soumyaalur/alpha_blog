class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]

  def show
  end

  def index
    @articles = Article.all 
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
   @article = Article.new(article_params)
   if @article.save
      flash[:notice] = "Article was created successfully!"
      redirect_to article_path(@article) # can also be writte
      #as redirect_to @article
      #i wrote if for my understanding that after saving it will be going to the show page

   else
    render 'new'
   end
  end
  
  def update
    if @article.update(article_params)

      flash[:notice] = " Article was updated sucessfully!"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path#verb for index listing is articles and we add_path 
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title,:description)
  end
end 
