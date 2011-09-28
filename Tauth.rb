require 'rubygems'
require 'omniauth/oauth'
require 'sinatra'
require 'activerecord'


use Rack::Session::Cookie
use OmniAuth::Builder do
	provider :twitter, 'Consumer key', 'Consumer secret'
end
ActiveRecord::Base.establish_connection(YAML.load_file('database.yml'))
class User < ActiveRecord::Base
	def self.create_with_omniauth(auth)
		create! do |user|
			user.provider = auth["provider"]
			user.uid = auth["uid"]
			user.name = auth["user_info"]["name"]
		end
	end
end
		

enable :sessions
get '/' do
	@title = "Bienvenidos!"
	erb :home
end

post '/auth/:name/callback' do
	u = User.find_by_provider_and_uid(auth["provider"], auth["uid"] || User.create_with_omniauth(auth) )	
	if u
		auth = request.env['omniauth.auth']
		session[:user_id] = user.id
		
		redirect '/'
	else
		redirect '/'
	end                                    
end
