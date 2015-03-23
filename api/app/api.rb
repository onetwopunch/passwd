require 'sinatra/activerecord'
require 'yaml'
Dir["app/lib/**/*.rb"].each{ |f| File.absolute_path(f); require File.absolute_path(f)}

module Passwd
  class Api < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    attr_accessor :current_user

    def self.api_for(resource)
      config = YAML.load File.read('config/passwd.yml')
      "/api/#{config[:api_version]}#{resource}"
    end

    ## Login

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


    ## Entry CRUD

    get api_for('/entries') do
      authenticate!
      current_user.entries.to_json
    end

    get api_for('/entries/:entry_id') do
      authenticate!
      entry = Entry.find(params[:entry_id]) rescue nil
      render_not_found unless entry

      if current_user.entries.include? entry
        entry.to_json
      else
        render_no_access
      end
    end

    post api_for('/entries') do
      authenticate!
      params = json_params
      entry = Entry.create(user_id: current_user.id, username: params[:username],
                           description: params[:description], password: params[:password])
      entry.to_json
    end

    put api_for('/entries/:entry_id') do
      authenticate!
      entry = Entry.find(params[:entry_id]) rescue nil
      render_not_found unless entry
      params = json_params
      entry.update_attributes(username: params[:username],
                              description: params[:description], password: params[:password])
      entry.to_json
    end

    delete api_for('/entries/:entry_id') do
      authenticate!
      entry = Entry.find(params[:entry_id]) rescue nil
      render_not_found unless entry

      if current_user.entries.include? entry
        entry.destroy.to_json
      else
        render_no_access
      end
    end

    ## Helper methods

    private
    def authenticate!
      @current_user = User.find_by_token(params[:private_token])
      render_no_access unless current_user
      current_user
    end

    def json_params
      JSON.parse(request.body.read).symbolize_keys
    end

    def render_no_access
      halt 403, {message: "Access Denied"}.to_json
    end

    def render_not_found
      halt 404, {message: "Not Found"}.to_json
    end

  end
end
