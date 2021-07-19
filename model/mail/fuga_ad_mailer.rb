class FugaAdMailer
  TYPE = Permission::AD

  def generate(to_user)
    Mail.new(
      Mail::TYPE_SENDGRID,
      {
        template_id: 'd-yyyyyy',
        to: to_user.email
      },
      args(to_user),
      to_user.permission.can?(TYPE)
    )
  end

  private

  def args(to_user)
    {
      user_name: to_user.name,
      login_url: login_url,
      coupon_code: CouponService.for(to_user).to_s,
    }
  end
end
