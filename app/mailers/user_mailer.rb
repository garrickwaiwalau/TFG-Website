class UserMailer < ApplicationMailer
  def contact_form(contact)
    @contact = contact
    mail(to: ENV["CONTACT_FORM_RECIPIENT"].split(", "), subject: "New Contact Form Submission ##{@contact.reference_number}")

    # Garrick.lau@trustfreightglobal.com
    # admin@trustfreightglobal.com
    # ["Garrick.lau@trustfreightglobal.com", "admin@trustfreightglobal.com"]
  end

  def quote_form(quote)
    @quote = quote
    mail(to: ENV["QUOTE_FORM_RECIPIENT"].split(", "), subject: "New Quote Form Submission ##{@quote.reference_number}")
    # Garrick.lau@trustfreightglobal.com
    # admin@trustfreightglobal.com
    # ["Garrick.lau@trustfreightglobal.com", "admin@trustfreightglobal.com"]
  end
end