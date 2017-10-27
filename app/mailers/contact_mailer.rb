class ContactMailer < ApplicationMailer
  default from: 'server@weteling.com'
  
  def confirm_mail(contact_form)
    @contact_form = contact_form
    mail(to: @contact_form.email, subject: 'Copy of your email to Rene Weteling')
  end

  def contact_mail(contact_form)
    @contact_form = contact_form
    mail(to: 'rene@weteling.com', subject: "Mail via de site: #{@contact_form.subject}")
  end
end





