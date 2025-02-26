class PortalController < ApplicationController
  # before_action :authenticate_user!, only: [:upload]
  def portal
    # logging
    Rails.logger.info "Portal page accessed"
  end

  def upload
    Rails.logger.info "Uploading shipment file"
    # Rails.logger.debug "Params received: #{params.inspect}"

    if params[:file].present?
      file = params[:file]
      begin
        ImportExcelService.new(file).process
        Rails.logger.info "Shipment file uploaded successfully"
        redirect_to portal_path, notice: "File imported successfully!"
      rescue StandardError => e
        Rails.logger.error "Error during file processing: #{e.message}"
        redirect_to portal_path, alert: e.message
      rescue => e
        Rails.logger.error "Error during file processing: #{e.message}"
        redirect_to portal_path, alert: "An error occurred while importing the file."
      end
    else
      Rails.logger.warn "No file provided for upload"
      redirect_to portal_path, alert: "Please upload a file."
    end
  end

  private

  def file_params
    params.permit(:file)
  end
end
