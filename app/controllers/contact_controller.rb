class ContactController < ApplicationController
  def contact
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      # Send the email
      UserMailer.contact_form(@contact).deliver_now

      # Redirect or render a success page
      redirect_to contact_path, notice: "Your message has been sent successfully!"
    else
      puts @contact.errors.full_messages # Log the validation errors
      redirect_to contact_path, alert: "There was an issue with your submission."
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:first_name, :last_name, :email, :phone, :subject, :message)
  end
end
