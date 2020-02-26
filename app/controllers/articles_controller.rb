class ArticlesController < ApplicationController
	before_action :find_article_id , except: [:index,:new,:create]

	def find_article_id
		@article=Article.find(params[:id])
	end

	def index
    @articles = Article.all
  	end
	def new
		 @article=Article.new
	end
	def show	 
	end
	def create
		@article = Article.new(article_params)#more specific to the parameters
 
	  if @article.save#store to the database , return true or false
		flash[:success] = "Article Created Successfully"
  		redirect_to @article # redirect to the show action or equivalent to article_path(@article)
		else
			render 'new' #render to the view temp new
		end
	end
	def edit
		
	end

	def update

	  if @article.update(article_params)
		flash[:success] = "Article Created Successfully"
    	redirect_to @article
  	else
    	render 'edit'
  	end
	end
	def destroy
		@article.destroy #delete the record from the  database

		redirect_to articles_path #go to the index templete

	end
	private
  	def article_params
    	params.require(:article).permit(:title, :text)
  	end
end