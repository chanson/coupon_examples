# frozen_string_literal: true

class Coupon::ValidationRules::ItemType < Coupon::ValidationRule
  ERROR_MESSAGE = 'This coupon cannot be applied to the plan you selected'

  serialize :criteria, Array

  def met?(transaction:, **_args)
    criteria.include?(transaction.item_type_id)
  end
end
