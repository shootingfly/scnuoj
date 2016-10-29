require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) { create :user }

	describe '#phone' do
		context 'valid phone' do
			addresses = %w( 15603006662 )
			addresses.each do |valid_address|
				let(:user) { build(:user, phone: valid_address) }
				it { expect(user.valid?).to eq true}
			end
		end

		context 'null' do
			let(:user) { build(:user, phone: ' ') }
			it { expect(user.valid?).to eq false }
		end

		context 'error format' do
			addresses = %w( invalid_phone_format 123 $$$ () sadasd)
			addresses.each do |invalid_address|
				let(:user) { build(:user, phone: invalid_address) }
				it { expect(user.valid?).to eq false }
			end
		end

		context 'repeat' do
			let(:user_with_same_username) { build(:user, username: user.username) }
			it { expect(user_with_same_username.valid?).to eq false }
		end
	end
end