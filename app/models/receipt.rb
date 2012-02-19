class Receipt < ActiveRecord::Base
  validates_presence_of :email, :body 

  belongs_to :item
end
