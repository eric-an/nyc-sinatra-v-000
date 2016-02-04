class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"figures/index"
  end

  get '/figures/new' do
    erb :"figures/new"
  end

  post '/figures/new' do
    @figure = Figure.new(name: params[:figure][:name])
    @figure.title_ids = params[:figure][:title_ids]
    @figure.landmark_ids = params[:figure][:landmark_ids]
    
    @figure.landmarks << Landmark.create(name: params[:new_landmark], year_completed: params[:new_landmark_year])
    @figure.titles << Title.create(name: params[:new_title])
    
    if @figure.save
      erb :"figures/show", locals: {message: "Successfully created figure."}
    else
      redirect "/figures/new"
    end
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :"figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    erb :"figures/edit"
  end

  post '/figures/:id/edit' do
    @figure = Figure.find(params[:id])
    @figure.name = params[:figure][:name]
    @figure.title_ids = params[:figure][:title_ids]
    @figure.landmark_ids = params[:figure][:landmark_ids]
    
    @figure.titles << Title.create(name: params[:title][:name])
    @figure.landmarks << Landmark.create(name: params[:landmark][:name], year_completed: params[:landmark][:year_completed])
    
    if @figure.save
      redirect "/figures/#{@figure.id}", locals: {message: "Successfully edited figure."}
    else
      redirect "/figures/new"
    end
  end
end