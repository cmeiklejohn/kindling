class AddProductUrlToItems < ActiveRecord::Migration
  def change
    add_column :items, :product_url, :string
  end
end
