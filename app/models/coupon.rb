# frozen_string_literal: true

class Coupon < ActiveRecord::Base
  has_many :validation_rules, class_name: 'Coupon::ValidationRule'

  validates :code, presence: true, uniqueness: true
  validates_numericality_of :discount_amount, greater_than_or_equal_to: 0
  validates_numericality_of :recurrences, greater_than: 0, allow_nil: true, if: :recurring?

  before_validation :upcase_code

  def self.find_by_code(code)
    find_by(code: code&.strip&.upcase)
  end

  def archived?
    archived_at.present?
  end

  def expired?
    !!expiration_date && Time.current > expiration_date.end_of_day
  end

  def conversion_limit_reached?
    false
  end

  private

  def upcase_code
    self.code = self.code.upcase
  end
end
