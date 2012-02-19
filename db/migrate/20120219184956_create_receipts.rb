class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.string :email
      t.text :body
      t.integer :item_id
      t.boolean :processed, :default => false
      t.timestamps
    end

    add_index :receipts, :item_id
  end
end
