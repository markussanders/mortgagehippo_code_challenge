class ApplicationMailer < ActionMailer::Base
  default from: 'coin.machine.notifications@gmail.com'
  layout 'mailer'
end
