require 'sinatra/activerecord'
require 'yaml'
Dir["app/lib/**/*.rb"].each{ |f| File.absolute_path(f); require File.absolute_path(f)}

module Passwd
  class Api < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    attr_accessor :current_user

    before do
      session[:csrf] ||= SecureRandom.hex(32)

      response.set_cookie 'authenticity_token', {
        value: session[:csrf],
        expires: Time.now + (60 * 60 * 24 * 180), # that's 180 days
        path: '/',
        httponly: true
        # secure: true # if you have HTTPS (and you should) then enable this
        }
      # this is a Rack method, that basically asks
      #   if we're doing anything other than GET
      if !request.safe?
        # check that the session is the same as the form
        #   parameter AND the cookie value
        if session[:csrf] == params['_csrf'] && session[:csrf] == request.cookies['authenticity_token']
          # everything is good.
        else
          halt 403, 'CSRF failed'
        end
      end
    end

    def self.api_for(resource)
      config = YAML.load File.read('config/passwd.yml')
      "/api/#{config[:api_version]}#{resource}"
    end

    get api_for('/entries') do
      authenticate!
      current_user.entries.to_json
    end

    post api_for('/login') do
      params = json_params
      puts params.inspect
      user = User.authenticate(params[:email], params[:password])
      if user
        user.to_json
      else
        render_no_access
      end
    end

    private
    def authenticate!
      puts params.inspect
      @current_user = User.find_by_token(params[:private_token])
      puts "current_user: #{current_user.inspect}"
      render_no_access unless current_user
      current_user
    end

    def json_params
      JSON.parse(request.body.read).symbolize_keys
    end

    def render_no_access
      halt 403, {message: "Access Denied"}.to_json
    end

  end
end

