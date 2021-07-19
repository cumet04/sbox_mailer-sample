class Mail
  TYPE_ACTION_MAILER = 'action_mailer'
  TYPE_SENDGRID = 'sendgrid'
  
  attr_reader :mail_params, :template_params

  def initialize(type, mail_params, template_params, can_send)
    @type = type
    @mail_params = mail_params
    @template_params = template_params
    @can_send = can_send && !BlackList.include?(@mail_params[:to])
  end

  def self.send(mails)
    type = mails.first.type

    batch_size = 1000
    while batch = mails.shift(batch_size) do
      targets = batch.filter do |mail|
        raise "mixed type" if mail.type != type
        mail.can_send
      end

      if mails.first.type == TYPE_ACTION_MAILER
        ActionMailerSender.send(targets)
      elsif mails.first.type == TYPE_SENDGRID
        SendGridSender.send(targets)
      else
        raise "unexpected type"
      end
    end
  end

  def send
    Mail.send([self])
  end
end
