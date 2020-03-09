class BalanceMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.balance_mailer.low_balance.subject
  #
  def low_balance(transaction, total_values, balances)
    @coin = transaction.coin
    @total_values = total_values
    @balances = balances

    admins = User.where("is_admin = ?", true)
    admin_emails = admins.map { |a| a.email }

    mail to: "coin.machine.notifications@gmail.com",
      cc: admin_emails,
      subject: "Low balance alert for #{@coin.name}!"

  end
end
