# frozen_string_literal: true

class CreateCouponValidationRules < ActiveRecord::Migration[5.2]
  def change
    create_table :coupon_validation_rules do |t|
      t.integer :coupon_id
      t.text :criteria
      t.string :type
      t.timestamps

      t.index :coupon_id
      t.index :type
    end
  end
end
