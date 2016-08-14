class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes/new' do
    erb :new
  end

  post '/recipes' do
    @recipe = Recipe.create(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    @recipes = Recipe.all
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes' do
    if params[:message]
      @recipe = params[:message]
    end
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/:id' do
    @recipe = Recipe.find(params[:id])
    erb :show
  end

  get '/recipes/:id/edit' do
    @recipe = Recipe.find(params[:id])
    erb :edit
  end

  patch '/recipes/:id' do 
    @recipe = Recipe.update(params[:id], ingredients: params[:ingredients], name: params[:name], cook_time: params[:cook_time])
    redirect to "/recipes/#{params[:id]}"
  end

  delete '/recipes/:id/delete' do 
    @deleted_recipe = Recipe.find(params[:id]).name
    Recipe.destroy(params[:id])
    redirect to "/recipes?message=#{@deleted_recipe}"
  end

  get '/' do
    @recipes = Recipe.all
    erb :index
  end
end