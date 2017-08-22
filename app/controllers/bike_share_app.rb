require 'will_paginate'
require 'will_paginate/active_record'

class BikeShareApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  configure do
    register WillPaginate::Sinatra
  end

  get '/stations' do
    @stations = Station.all
    erb :'/station/index'
  end

  get '/stations/new' do
    erb :'/station/new'
  end

  post '/stations' do
    station = Station.new(params)
    station.save
    redirect '/stations'
  end

  get '/stations/:id' do |id|
    @station = Station.find(id)
    erb :'/station/show'
  end

  get '/stations/:id/edit' do
    @station = Station.find(params[:id])
    erb :'/station/edit'
  end

  put '/stations/:id' do |id|
    Station.update(id, params[:station])
    redirect "/stations/#{id}"
  end

  delete '/stations/:id' do |id|
    Station.destroy(id)
    redirect '/stations'
  end

  get '/stations-dashboard' do
    erb :'/station/dashboard'
  end

  get '/trips' do
    Trip.connection
    @pages = Trip.paginate(page: params[:page], :per_page => 30)
    @trips = Trip.order('start_date DESC').page(params[:page])
    erb :'/trip/index'
  end

  get '/trips/new' do
    erb :'/trip/new'
  end

  post '/trips' do
    trip = Trip.new(params)
    trip.save
    redirect '/trips'
  end

  get '/trips/:id' do |id|
    @trip = Trip.find(id)
    erb :'/trip/show'
  end

  get '/trips/:id/edit' do
    @trip = Trip.find(params[:id])
    erb :'/trip/edit'
  end

  put '/trips/:id' do |id|
    Trip.update(id, params[:trip])
    redirect "/trips/#{id}"
  end

  delete '/trips/:id' do |id|
    Trip.destroy(id)
    redirect '/trips'
  end

  get '/trips-dashboard' do
    erb :'/trip/dashboard'
  end

  get '/conditions' do
    @conditions = Condition.all
    erb :'/condition/index'
  end

  get '/conditions/new' do
    erb :'/condition/new'
  end

  post '/conditions' do
    condition = Condition.new(params)
    condition.save
    redirect '/conditions'
  end

  get '/conditions/:id' do |id|
    @condition = Condition.find(id)
    erb :'/condition/show'
  end

  get '/conditions/:id/edit' do
    @condition = Condition.find(params[:id])
    erb :'/condition/edit'
  end

  put '/conditions/:id' do |id|
    Condition.update(id, params[:condition])
    redirect "/condition/#{id}"
  end

  delete '/conditions/:id' do |id|
    Condition.destroy(id)
    redirect '/conditions'
  end

end
