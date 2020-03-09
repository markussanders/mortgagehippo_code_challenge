require "rails_helper"

RSpec.describe BalanceMailer, type: :mailer do
  describe "low_balance" do
    let(:mail) { BalanceMailer.low_balance }

    it "renders the headers" do
      expect(mail.subject).to eq("Low balance")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("Hi")
    end
  end

end
