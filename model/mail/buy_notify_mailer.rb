class BuyNotifyMailer
  TYPE = Permission::NOTIFY

  def generate(order)
    to_user = order.buyer
    Mail.new(
      Mail::TYPE_ACTION_MAILER,
      {
        template_id: 'buy_notifiy_mail',
        to: to_user.email,
        from: 'awesome service<noreply@example.com>',
        subject: 'Thanks for purchase'
      },
      args(order),
      to_user.permission.can?(TYPE)
    )
  end

  private

  def args(order)
    {
      user_name: order.buyer.name,
      items: order.lines.map { |line| {
        name: line.product.name,
        count: line.count,
        per_price: line.product.price,
        total_price: line.total_price
      } }
    }
  end
end
