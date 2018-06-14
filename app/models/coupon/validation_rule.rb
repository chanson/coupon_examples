# frozen_string_literal: true

class Coupon::ValidationRule < ActiveRecord::Base
  EXISTING_SUBSCRIBER_TYPE = 'Coupon::ValidationRules::ExistingSubscriber'
  MINIMUM_PURCHASE_TYPE = 'Coupon::ValidationRules::MinimumPurchase'
  NEW_SUBSCRIBER_TYPE = 'Coupon::ValidationRules::NewSubscriber'
  SUBSCRIPTION_TYPE_TYPE = 'Coupon::ValidationRules::SubscriptionType'

  belongs_to :coupon

  validates_presence_of :coupon

  def error_message
    self.class::ERROR_MESSAGE
  end

  def met?(user:, transaction:)
    raise NotImplementedError
  end
end
