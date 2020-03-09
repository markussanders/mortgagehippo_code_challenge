require 'rails_helper'

RSpec.describe Transaction, type: :model do
  let!(:users) { create_list(:user, 2) }
  let(:user_id) { users.first.id }

  let!(:coins) { create_list(:coin, 2) }
  let(:coin_id) { coins.first.id }

  subject { Transaction.new(user_id: user_id, coin_id: coin_id)}

  before { subject.save }

  it "exists" do
    expect(subject).to be_valid
  end

end
