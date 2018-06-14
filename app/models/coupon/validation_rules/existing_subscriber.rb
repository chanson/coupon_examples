# frozen_string_literal: true

class Coupon::ValidationRules::ExistingSubscriber < Coupon::ValidationRule
  ERROR_MESSAGE = 'Coupon only valid for current subscribers'

  def met?(user:, **_args)
    !!user && user.subscribed?
  end
end
