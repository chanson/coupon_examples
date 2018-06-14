# frozen_string_literal: true

describe Coupon::ValidationRules::NewSubscriber do
  describe '#met?' do
    let(:user){ double('user', subscribed?: subscribed) }

    subject{ described_class.new }

    context 'when a user has previously subscribed' do
      let(:subscribed) { true }

      it 'returns false' do
        expect(subject.met?(user: user)).to eq(false)
      end
    end

    context 'when a user has not previously subscribed' do
      let(:subscribed) { false }

      it 'returns true' do
        expect(subject.met?(user: user)).to eq(true)
      end
    end

    context 'when a nil user is provided' do
      it 'returns false' do
        expect(subject.met?(user: nil)).to eq(false)
      end
    end
  end
end
