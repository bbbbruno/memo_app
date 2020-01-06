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
  id = SecureRandom.hex(5)
  id = SecureRandom.hex(5) if File.exist?("db/memo_#{id}")
  data = { title: params[:title], content: params[:content], created_at: Time.now, id: id }
  @memo = Memo.new(data)
  @memo.save
  redirect '/'
  erb :index
end

get '/:id' do |id|
  @title = 'show'
  @memo = Memo.find(id)
  erb :show
end

get '/:id/edit' do |id|
  @title = 'edit'
  @memo = Memo.find(id)
  erb :edit
end

put '/:id' do |id|
  @memo = Memo.find(id)
  @memo.title = params[:title]
  @memo.content = params[:content]
  @memo.save
  erb :show
end

delete '/:id' do |id|
  Memo.destroy(id)
  redirect '/'
  erb :index
end
