describe Coupon::Validator do
  let(:user) { double('user', id: 1) }
  let(:expired?) { false }
  let(:conversion_limit_reached?) { false }
  let(:rules){ [] }
  let(:coupon) do
    double(
      'coupon',
      id: 1,
      code: 'valid',
      expired?: expired?,
      conversion_limit_reached?: conversion_limit_reached?,
      validation_rules: rules,
      recurring?: false
    )
  end
  let(:transaction) { double('transaction') }
  let(:coupon_validator) do
    Coupon::Validator.new(coupon: coupon, user: user, transaction: transaction)
  end

  describe 'valid?' do
    context 'is passes all validations' do
      it 'returns true' do
        expect(coupon_validator.valid?).to eq(true)
      end
    end

    context 'promo is expired' do
      let(:expired?) { true }

      it 'returns false' do
        expect(coupon_validator.valid?).to eq(false)
      end
    end

    context 'conversion limit reached' do
      let(:conversion_limit_reached?) { true }

      it 'returns false' do
        expect(coupon_validator.valid?).to eq(false)
      end
    end

    context 'promo code has unmet rules' do
      let(:unmet_rule){
        double(
          'coupon_validation_rule',
          met?: false,
          error_message: 'Error'
        )
      }
      let(:rules){ [unmet_rule] }

      it 'returns false' do
        expect(coupon_validator.valid?).to eq(false)
      end
    end
  end

  describe 'error' do
    context 'no errors' do
      it 'returns nil' do
        expect(coupon_validator.error).to eq(nil)
      end
    end

    context 'promo is expired' do
      let(:expired?) { true }

      it 'returns error' do
        expect(coupon_validator.error).to eq('Coupon expired')
      end
    end

    context 'conversion limit reached' do
      let(:conversion_limit_reached?) { true }

      it 'returns error' do
        expect(coupon_validator.error).to eq('Coupon limit exceeded')
      end
    end

    context 'promo code has unmet rules' do
      let(:unmet_rule_1) {
        double(
          'coupon_validation_rule',
          met?: false,
          error_message: 'Error 1'
        )
      }
      let(:unment_rule_2) {
        double(
          'coupon_validation_rule',
          met?: false,
          error_message: 'Error 2'
        )
      }
      let(:rules){ [unmet_rule_1, unment_rule_2] }

      it 'returns the error messages' do
        expect(coupon_validator.error).to eq('Error 1; Error 2')
      end
    end
  end
end
