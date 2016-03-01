require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

ActiveRecord::Base.establish_connection(
	"adapter" => "sqlite3",
	"database" => "./bbs.db"
)

class Comment < ActiveRecord::Base
end

helpers do
	include Rack::Utils
	alias_method :h, :escape_html
end

get "/" do
	@comments = Comment.order("id desc").all
	erb :index
end

post "/new" do
	Comment.create({:body => params[:body]})
	redirect '/'
	erb :index
end

post "/delete" do
	Comment.find(params[:id]).destroy
end

