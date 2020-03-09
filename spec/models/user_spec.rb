require 'spec_helper'

RSpec.describe User, type: :model do 
    subject { User.new(is_admin: true, name: 'Markus', email: 'markus.sanderst@gmail.com')}

    before { subject.save }

    it "has a name" do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it "has an API key" do
        subject.api_key = nil
        expect(subject).to_not be_valid
    end

    it "is created with a valid API key" do
        subject.api_key = ""
        expect(subject).to_not be_valid 
    end

    it "has an email if user type is admin" do
        subject.is_admin = true
        subject.email = nil
        expect(subject).to_not be_valid
    end

end