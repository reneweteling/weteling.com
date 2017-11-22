class SiteController < ApplicationController
  def home
    @projects = Project.limit(5).for_site
    @contact_form = ContactForm.new
  end

  def cv
  end

  def cv_print
    render layout: 'pdf'
  end

  def cv_pdf
    html = render_to_string template: '/site/cv_print', layout: 'pdf'
    return render html: html if params[:type] == 'html'

    kit = PDFKit.new(html, :page_size => 'A4', :orientation => 'Portrait')
    send_data kit.to_pdf, filename: "CV Rene Weteling - #{Date.today.to_s.parameterize}.pdf", type: 'application/pdf'
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
