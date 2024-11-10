class NotifierMailer < ApplicationMailer
  default from: 'no-reply@example.com'

  def item_sold_email(seller, post)
    @seller = seller
    @post = post
    mail(to: @seller.email, subject: 'あなたの商品が購入されました。')
  end

  def item_cancel_email(seller, post)
    @seller = seller
    @post = post
    mail(to: @seller.email, subject: 'あなたの商品がキャンセルされました。')
  end

  def talk_email(receiver, post)
    @receiver = receiver
    @post = post
    mail(to: @receiver.email, subject: '相手からチャットのコメントが来ました。')
  end

end
