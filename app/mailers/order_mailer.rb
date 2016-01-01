class OrderMailer < ApplicationMailer

  default from: 'zamowienia@sandbox804f7c5b265e414fa6fea420895c4621.mailgun.org'

  def order_email(order)
    @order = order.reload
    mail(to: Rails.configuration.x['mailer']['admin_addresses'], subject: "Zamówienie #{order.id} #{order.user.name}")
  end
end
