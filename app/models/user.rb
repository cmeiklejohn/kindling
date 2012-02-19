class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :encryptable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me
end
