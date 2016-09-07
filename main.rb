require 'sinatra'
require 'sinatra/reloader'
require 'active_record'

=begin
get '/hello/:name'do
    "hello #{params[:name]}"
end

get '/hello/:name'do |n|
    "hello #{n}"
end

get '/hello/:fname/?:lname?'do |f,l|
    "hello #{f} #{l}"
end

get'/from/*/to/*' do|f,t|
   "from #{f} to #{t}"
end

get %r{/users/([0-9]*)} do|i|
   "user id = #{i}"
end

get '/:name' do |n|
    # "hello #{n}"
    @name = n
    @title = "main index"
    erb :index
end

=end

=begin

before '/admin/*' do
   @msg = "admin area!"
end

before do
   @author = "taguchi"
end

after do
    logger.info "page displayed successfully"
end

helpers do

   def strong(s)
       "<strong>#{s}</strong>"
   end

end

get '/' do
    @title = "main index"
    @content = "main content by " + @author
    erb :index
end

get '/about' do
    @title = "about this page"
    @content = "this page is ... by " + strong(@author)
    @email = "taguchi @gmail.com"
  erb :about
end

=end

ActiveRecord::Base.establish_connection(
    "adapter" => "sqlite3",
    "database" => "./bbs.db"
)

helpers do
  include Rack::Utils
  alias_method :h, :escape_html
end

class Comment < ActiveRecord::Base
end
get '/' do
    @comments = Comment.order("id desc").all
  erb :index
end

post '/new' do
    Comment.create({:body => params[:body]})
    redirect '/'
end

post '/delete' do
    Comment.find(params[:id]).destroy
end
