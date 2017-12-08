class HyperMailer < ApplicationMailer
default from: 'no-reply@jungle.com'

  def receipt(order)
    @order = order
    @products
    mail(to: 'sixisnot@hotmail.com', subject: 'Receipt for Order#{@order.id}')
  end
end
