class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :item_ownerships
  has_many :items, :through => :item_ownerships

  def acquire!(item)
    items << item
  end

  def self.for_receipt(receipt)
    User.find_by_email(receipt.email)
  end
end
