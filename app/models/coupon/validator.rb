class Coupon::Validator
  def initialize(coupon:, user:, transaction:)
    self.coupon = coupon
    self.user = user
    self.transaction = transaction
  end

  def valid?
    !coupon.expired? &&
    !coupon.conversion_limit_reached? &&
    rules_met?
  end

  def error
    return 'Coupon expired' if coupon.expired?
    return 'Coupon limit exceeded' if coupon.conversion_limit_reached?
    return errors.join('; ') unless rules_met?
    nil
  end

  private

  attr_accessor :coupon, :errors, :transaction, :user

  def rules_met?
    self.errors = []

    coupon.validation_rules.each do |rule|
      unless rule.met?(user: user, transaction: transaction)
        errors << rule.error_message
      end
    end

    errors.blank?
  end
end
