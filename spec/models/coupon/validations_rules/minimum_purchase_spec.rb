# frozen_string_literal: true

describe Coupon::ValidationRules::MinimumPurchase do
  describe '#met?' do
    let(:transaction){ double('transaction', price: 70.0) }

    subject{ described_class.new(criteria: subject_price) }

    context 'when a transaction has a price greater than the criteria' do
      let(:subject_price) { '69.99' }

      it 'returns true' do
        expect(subject.met?(transaction: transaction)).to eq(true)
      end
    end

    context 'when a transaction has a price equal to the criteria' do
      let(:subject_price) { '70.00' }

      it 'returns true' do
        expect(subject.met?(transaction: transaction)).to eq(true)
      end
    end

    context 'when a transaction has a price less than the criteria' do
      let(:subject_price) { '70.01' }

      it 'returns false' do
        expect(subject.met?(transaction: transaction)).to eq(false)
        expect(subject.error_message).to \
          eq("Coupon only valid for purchases of at least $#{subject_price}")
      end
    end
  end
end
