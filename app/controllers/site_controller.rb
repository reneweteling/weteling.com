class SiteController < ApplicationController
  rescue_from ActionController::InvalidAuthenticityToken, with: :redirect_to_referer_or_path
  before_action :set_locale

  LOCALES = ['en', 'nl']

  def home
    @projects = Project.for_site.includes(:tags)
    @contact_form = ContactForm.new
    @subscriber = Subscriber.new
  end

  def cv
    @subscriber = Subscriber.new
  end

  def cv_print
    render layout: "pdf"
  end

  def cv_pdf
    html = render_to_string template: "/site/cv_print", layout: "pdf"
    return render html: html if params[:type] == "html"

    pdf = PDFKit.new(html, :page_size => "A4", :orientation => "Portrait").to_pdf
    send_data pdf, filename: "CV Rene Weteling - #{I18n.locale} - #{Date.today.to_s.parameterize}.pdf", type: "application/pdf"
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

  def subscribe
    @subscriber = Subscriber.new(params.require(:subscriber).permit(:first_name, :last_name, :email))
    if @subscriber.save
      # @subscriber.subscribe
      @subscriber = Subscriber.new
      @subscriber_sent = true
    end
  end

  def bbq
  end

  private

  def set_locale
    # locale set from param
    if params[:locale].present?
      session[:locale] = I18n.locale = params[:locale]
      return
    end

    # locale set from session
    return I18n.locale = session[:locale] if session[:locale].present?

    # locale set from browser
    locale = request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
    if LOCALES.include?(locale)
      session[:locale] = I18n.locale = locale
      return
    end

    I18n.locale = I18n.default_locale
  end

  def redirect_to_referer_or_path
    flash[:notice] = "Please try again."
    redirect_to request.referer
  end
end
