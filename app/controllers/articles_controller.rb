class ArticlesController < ApplicationController

	def index
    @articles = Article.all#pointing out the entire article in our web app
  	end
	def new
		 @article=Article.new#create the object of the model
	end
	def show
		@article=Article.find(params[:id]) #point out to the specific resource present in your article of the web app.it is found in the url after the resource name
	end
	def create
		#render plain:params[:article].inspect
		# @article = Article.new(params[:article])#create the model give error
		@article = Article.new(article_params)#more specific to the parameters
 
  	if @article.save#store to the database , return true or false
  		redirect_to @article # redirect to the show action or equivalent to article_path(@article)
		else
			render 'new' #render to the view temp new
		end
	end
	def edit
		@article=Article.find(params[:id])
	end

	def update

		@article = Article.find(params[:id])
 
  	if @article.update(article_params)
    	redirect_to @article
  	else
    	render 'edit'
  	end
	end
	def destroy
		@article=Article.find(params[:id])
		@article.destroy #delete the record from the  database

		redirect_to articles_path #go to the index templete

	end
	private
  	def article_params
    	params.require(:article).permit(:title, :text)
  	end
end