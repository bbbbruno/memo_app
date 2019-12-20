# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'

require 'securerandom'

require_relative 'models/memo'

get '/' do
  @title = 'top'
  @memos = Memo.all
  erb :index
end

get '/new' do
  @title = 'new'
  erb :new
end

post '/' do
  data = { title: params[:title], content: params[:content], created_at: Time.now, filename: SecureRandom.hex(5) }
  @memo = Memo.new(data)
  @memo.save
  redirect '/'
  erb :index
end

get '/:filename' do |filename|
  @title = 'show'
  @memo = Memo.find(filename)
  erb :show
end

get '/:filename/edit' do |filename|
  @title = 'edit'
  @memo = Memo.find(filename)
  erb :edit
end

put '/:filename' do |filename|
  @memo = Memo.find(filename)
  @memo.title = params[:title]
  @memo.content = params[:content]
  @memo.save
  erb :show
end

delete '/:filename' do |filename|
  Memo.destroy(filename)
  redirect '/'
  erb :index
end
