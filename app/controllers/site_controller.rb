class SiteController < ApplicationController
  def home
    @projects = Project.limit(5).for_site
    @contact_form = ContactForm.new
  end

  def cv
  end

  def cv_print
    render 'cv', layout: 'pdf'
  end

  def contact
    @contact_form = ContactForm.new(params.require(:contact_form).permit(:name, :email, :subject, :message))
    if @contact_form.valid?
      ContactMailer.contact_mail(@contact_form).deliver_now
      ContactMailer.confirm_mail(@contact_form).deliver_now
      @contact_form = ContactForm.new
      @sent = true
    end
  end
  
end
