class IndexController < ApplicationController
  # http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

  def index
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      # Send the email
      UserMailer.contact_form(@contact).deliver_now

      # Redirect or render a success page
      redirect_to index_path, notice: "Your message has been sent successfully! Your reference number is: #{@contact.reference_number}.".html_safe
    else
      puts @contact.errors.full_messages # Log the validation errors
      redirect_to index_path, alert: "There was an issue with your submission."
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :subject, :message)
  end
end
