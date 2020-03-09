# Preview all emails at http://localhost:3000/rails/mailers/balance_mailer
class BalanceMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/balance_mailer/low_balance
  def low_balance
    transaction = Transaction.last
    balances = {'test': 4, 'bitcoin': 10, 'penny': 5}
    total_values = 1655

    BalanceMailer.low_balance(transaction, total_values, balances )
  end

end
