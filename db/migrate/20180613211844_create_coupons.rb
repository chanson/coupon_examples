class CreateCoupons < ActiveRecord::Migration[5.2]
  def change
    create_table :coupons do |t|
      t.datetime :archived_at
      t.string :code
      t.integer :conversion_limit
      t.decimal :discount_amount, default: 0
      t.datetime :expiration_date
      t.integer :recurrences
      t.boolean :recurring, default: false
      t.timestamps

      t.index :code
    end
  end
end
