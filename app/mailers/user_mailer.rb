class UserMailer < ApplicationMailer
  default from: "no-reply@trustfreightglobal.com"
  def contact_form(contact)
    @contact = contact
    mail(to: ENV["CONTACT_FORM_RECIPIENT"].split(", "), subject: "New Contact Form Submission ##{@contact.reference_number}")
  end

  def quote_form(quote)
    @quote = quote
    mail(to: ENV["QUOTE_FORM_RECIPIENT"].split(", "), subject: "New Quote Form Submission ##{@quote.reference_number}")
  end

  def pre_alert_email(ocean_shipment)
    @ocean_shipment = ocean_shipment
    mail(to: @ocean_shipment.pre_alert_email.split(";"), cc: "Import-TOR@trustfreight.ca", subject: "PRE-ALERT / Trust Freight / Ocean Shipment Status / #{@ocean_shipment.reference_number} / #{@ocean_shipment.hbl_number}")
  end
end
