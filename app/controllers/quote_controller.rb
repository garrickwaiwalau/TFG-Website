class QuoteController < ApplicationController
  def quote
    @quote = Quote.new
    @quote.products.build
  end

  def submission
  end

  def create
    @quote = Quote.new(quote_params)
    if @quote.save
      # Send the email
      UserMailer.quote_form(@quote).deliver_now

      # Redirect or render a success page
      redirect_to quote_path, notice: "Your quote form has been sent successfully!"
    else
      puts @quote.errors.full_messages # Log the validation errors
      redirect_to quote_path, alert: "There was an issue with your submission."
    end

    # render turbo_stream: [
    #   turbo_stream.replace(
    #     "turbo_id",
    #     partial: "../..",
    #     locals: {
    #       # ...
    #     },
    #     ),
    #   turbo_stream.replace("flash-messages", partial: "application/flash"),
    # ]
  end

  private

  def quote_params
    params.require(:quote).permit(
      # Package / Cargo Information
      :mode_of_transport, # Mode of transportation (Air or Sea)
      :container_size, # Container size by sea (LCL/FCL)
      :quantity_by_sea, # Quantity by sea
      # Shipping Information
      :from_address, # Address from which goods are shipped
      :to_address, # Address to which goods are shipped
      :from_city, # City from which goods are shipped
      :to_city, # City to which goods are shipped
      :from_state_province, # State from which goods are shipped
      :to_state_province, # State to which goods are shipped
      :from_country, # Country from which goods are shipped
      :to_country, # Country to which goods are shipped
      :from_zip_postal, # Zip/postal code from which goods are shipped
      :to_zip_postal, # Zip/postal code to which goods are shipped
      :from_cargo_available, # Date which cargo available by
      # Contact Information
      :sender_title, # Sender title
      :sender_firstname, # Sender first name
      :sender_lastname, # Sender last name
      :sender_company, # Sender company
      :sender_address, # Sender address
      :sender_city, # Sender city
      :sender_state_province, # Sender state
      :sender_country, # Sender country
      :sender_zip_postal, # Sender zip/postal
      :sender_phone, # Sender phone number
      :sender_email, # Sender email
      # Others
      :amount_requested, # Insurance amount requested
      :amount_requested_currency, # Currency of insurance amount requested
      :marketing_use, # Where did you hear about us?
      :customs_clearance, # Do you require customs clearance?
      :existing_customer, # Are you an existing customer?
      :message, # Comment/ message area
      # Package / Cargo Information
      products_attributes: [:product_name, :product_quantity, :type_of_goods, :length, :width, :height, :weight] # product information by air
    )
  end

end