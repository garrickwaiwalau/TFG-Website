class ContactController < ApplicationController
  def contact
    @contact = Contact.new
    # logging
    Rails.logger.info "Contact page accessed"
  end

  def submit
    @contact = Contact.new(contact_params)

    # logging
    Rails.logger.info "Contact data : #{@contact}"

    if @contact.save
      # Send the email
      UserMailer.contact_form(@contact).deliver_now

      # logging
      Rails.logger.info "Contact data # #{@contact.id} saved"

      # Redirect or render a success page
      redirect_to contact_path, notice: "Your message has been sent successfully! Your reference number is: #{@contact.reference_number}.".html_safe
    else
      # logging
      Rails.logger.warn "Contact data unable to save"

      puts @contact.errors.full_messages # Log the validation errors
      redirect_to contact_path, alert: "There was an issue with your submission."
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :services, :email, :phone, :subject, :message)
  end
end
