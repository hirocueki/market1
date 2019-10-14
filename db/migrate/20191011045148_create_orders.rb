class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.date :delivery_date, null:false
      t.integer :delivery_time, null: false
      t.integer :shipping_status, null: false, default: 0
      t.integer :tax, null: false, default: 10

      t.timestamps
    end
  end
end
