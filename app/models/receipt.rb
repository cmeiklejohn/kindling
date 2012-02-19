class Receipt < ActiveRecord::Base
  validates_presence_of :email, :body 

  belongs_to :item

  def lines
    body.split("\n")
  end

  def reject!
    update_attribute(:rejected, true)
  end

  def process!
    update_attribute(:processed, true)
  end

  def for_item!(item_id)
    update_attribute(:item_id, item_id)
  end
end
