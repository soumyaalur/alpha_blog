class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]
  def show
  end

  def index
   @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
   @article = Article.new(article_params)
   @article.user = current_user
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

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] = "You can only edit or delete your own article"
      redirect_to @article
    end
  end
end 
