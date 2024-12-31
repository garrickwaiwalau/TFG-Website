class IndexController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @contact = Contact.new
    # logging
    Rails.logger.info "Index page accessed"
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
      redirect_to index_path, notice: "Your message has been sent successfully! Your reference number is: #{@contact.reference_number}.".html_safe
    else
      # logging
      Rails.logger.warn "Contact data unable to save"

      puts @contact.errors.full_messages # Log the validation errors
      redirect_to index_path, alert: "There was an issue with your submission."
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :services, :email, :phone, :subject, :message)
  end
end
