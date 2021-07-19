class App
  def send_hoge_ad_batch
    User.hoge_target_scope.find_in_batch do |batch|
      Mail.send(
        batch.map { |user| HogeAdMailer.generate(user) }
      )
    end
  end

  def buy
    order = Order.generate!(params.require(:order).permit(buy_params))
    BuyNotifyMailer.generate(order).send
    render json: {status: :ok}
  end
end
