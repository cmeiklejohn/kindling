class CreateItemOwnerships < ActiveRecord::Migration
  def change
    create_table :item_ownerships do |t|
      t.integer :item_id
      t.integer :user_id
      t.timestamps
    end

    add_index :item_ownerships, [:item_id, :user_id]
  end
end
