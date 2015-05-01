require 'aes'
require 'sinatra/activerecord'

class Entry < ActiveRecord::Base
  belongs_to :user
  before_save :encrypt

  def decrypted
    {
      description: description,
      username: username,
      password: decrypted_password
    }
  end

  def decrypted_password
    AES.decrypt(password, key)
  end

  def encrypt
    #encrypt using AES
    self.password = AES.encrypt(password, key)
  end

  private
  def key
    return "b7@16b33#46|96=555+52d8<196}d2809643f*60" + user.salt
  end


end
