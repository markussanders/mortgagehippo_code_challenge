require 'spec_helper'

RSpec.describe Coin, type: :model do 
    subject { Coin.new(name: 'bitcoin', value: 1000 )}

    before { subject.save }

    it "has a name" do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it "has a value" do
        subject.value = nil
        expect(subject).to_not be_valid
    end

    it "value is an integer" do
        subject.value = 3.2
        expect(subject).to_not be_valid 
    end

end