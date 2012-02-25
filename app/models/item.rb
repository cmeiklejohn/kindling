class Item < ActiveRecord::Base
  validates_presence_of :title

  def self.for_product(options = {})
    self.find_or_create_by_title_and_product_url(options[:title], options[:product_url], options)
  end
end
