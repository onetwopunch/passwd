require 'sinatra/activerecord'
Dir["app/lib/**/*.rb"].each{ |f| require File.absolute_path(f)}

class PasswdAPI < Sinatra::Base
	register Sinatra::ActiveRecordExtension

end

