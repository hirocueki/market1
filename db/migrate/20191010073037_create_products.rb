class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :image, null: false, default: ''
      t.integer :price, null: false
      t.text :description, null: false
      t.boolean :displayed, null: false, default: true
      t.integer :order_index, null: false

      t.timestamps
    end
  end
end
