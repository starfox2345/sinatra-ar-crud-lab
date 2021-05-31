
require_relative '../../config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/articles' do
    @articles = Article.all
    #This is a reader that displays all of the contents in article.rb model.
    erb :index
  end

  get '/articles/new' do
    @article = Article.new
    #This creates new articles in the localhost:9393/articles/new route
    erb :new
  end

  post '/articles' do
    @article = Article.create(title: params[:title], content: params[:content])
    #This is creating another object with a title and content using article model
    redirect to "/articles/#{@article.id}"
  end

  get '/articles/:id' do
    @article = Article.find(params[:id])
    erb :show
  end

  get '/articles/:id/edit' do
    @article = Article.find(params[:id]) 
    #use find and not find_by because we're finding an id and not a list of contents
    erb :edit
  end

  patch "/articles/:id" do
    @article = Article.find(params[:id])
    @article.update(params[:article])
    redirect to "/articles/#{@article.id}"
  end

  delete '/articles/:id' do
    # Article.all.clear - lesson learned. This doesn't work.
    # Article.clear - doesn't work too
    Article.delete(params[:id])

  end

end
