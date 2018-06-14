# frozen_string_literal: true

class Coupon::ValidationRules::NewSubscriber < Coupon::ValidationRule
  ERROR_MESSAGE = 'Coupon only valid for new subscribers'

  validate :one_subscriber_type_rule_per_coupon?

  def met?(user:, **_args)
    !!user && !user.subscribed?
  end

  private

  def one_subscriber_type_rule_per_coupon?
    return true unless coupon.validation_rules.existing_subscriber_rule?

    errors.add(:coupon, 'has conflicting subscriber type rules')
  end
end
