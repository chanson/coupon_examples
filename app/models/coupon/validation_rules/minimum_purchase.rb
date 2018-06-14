# frozen_string_literal: true

class Coupon::ValidationRules::MinimumPurchase < Coupon::ValidationRule
  ERROR_MESSAGE = 'Coupon only valid for purchases of at least $%<min_price>s'

  def met?(transaction:, **_args)
    min_price = criteria.to_f
    transaction.price.to_f >= min_price
  end

  def error_message
    ERROR_MESSAGE % { min_price: criteria }
  end
end
