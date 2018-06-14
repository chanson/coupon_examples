# frozen_string_literal: true

describe Coupon::ValidationRules::ItemType do
  describe '#met?' do
    let(:rule) { described_class.new(criteria: [1,2]) }
    let(:transaction) { double('transaction', item_type_id: item_type_id) }

    context 'when the item_type_id of the Transaction matches the criteria' do
      let(:item_type_id) { 2 }

      it 'returns true' do
        expect(rule.met?(transaction: transaction)).to eq(true)
      end
    end

    context 'when the item_type_id of the Transaction does not match the criteria' do
      let(:item_type_id) { 3 }

      it 'returns false' do
        expect(
          rule.met?(transaction: transaction)
        ).to eq(false)
      end
    end
  end
end
