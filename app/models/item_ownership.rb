class ItemOwnership < ActiveRecord::Base
  validates_presence_of :user_id, :item_id

  belongs_to :item
end
