class OrderNotifierMailer < ApplicationMailer
default from: 'Sergey Sivkov <shop@localhost>'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier_mailer.received.subject
  #
  def received
    @order = order

    mail to: order.email, subject: 'Подтверждение заказа в Shop Online'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier_mailer.shipped.subject
  #
  def shipped(order)
    @order = order

    mail to: order.email, subject: 'Заказ из Shop Online отправлен'
  end
end
