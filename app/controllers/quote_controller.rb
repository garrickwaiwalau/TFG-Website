class QuoteController < ApplicationController
  def quote
    @quote = Quote.new
    @quote.products.build
    # logging
    Rails.logger.info "Quote page accessed"
  end

  def submit
    # Honeypot spam detection: Exit early if bot submission detected
    if quote_params[:honeypot_field].present?
      Rails.logger.warn "Spam detected via honeypot field."
      session[:spam_detected] = true

      return redirect_to quote_path
    end

    @quote = Quote.new(quote_params)
    # logging
    Rails.logger.info "Quote data : #{@quote}"

    if @quote.save
      # Send the email
      UserMailer.quote_form(@quote).deliver_now

      # logging
      Rails.logger.info "Quote data # #{@quote.id} saved"

      # Redirect or render a success page
      redirect_to quote_path, notice: "Your quote form has been sent successfully! Your reference number is: #{@quote.reference_number}.".html_safe
    else
      # logging
      Rails.logger.warn "Quote data unable to save"
      Rails.logger.error @quote.errors.full_messages # Log the validation errors

      redirect_to quote_path, alert: "There was an issue with your submission."
    end
  end

  private

  def quote_params
    params.require(:quote).permit(
      # Package / Cargo Information
      :mode_of_transport, # Mode of transportation (Air/ Ocean/ Trucking)
      # Air Shipment Details
      :commodity_air_truck, # Commodity
      # Ocean Shipment Details
      :shipment_type, # Shipment Type (LCL/FCL)
      :commodity_ocean, # Commodity
      :quantity_ocean, # Quantity by ocean
      :container_type, # Container type
      :packaging_type, # Packaging type
      :length_ocean, # Length by Ocean
      :width_ocean, # Width by Ocean
      :height_ocean, # Height by Ocean
      :weight_ocean, # Weight by Ocean
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
      :cargo_ready_date, # Cargo Ready Date
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
      :comment, # Comment/ message area
      :honeypot_field, # Honeypot field to avoid spams
      # Package / Cargo Information
      products_attributes: [ :quantity, :packagingType, :length, :width, :height, :weight ] # product information by air
    )
  end
end
