
require 'sinatra/base'


class JonApp < Sinatra::Base 
  get '/' do
    erb :index
  end
end
