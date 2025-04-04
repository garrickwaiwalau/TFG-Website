class PortalController < ApplicationController
  def portal
    # logging
    Rails.logger.info "Portal page accessed"
  end

  def upload
    Rails.logger.info "Uploading shipment file"
    # Rails.logger.debug "Params received: #{params.inspect}"
    allowed_format = "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
    @@max_file_size_mb = 10 # 10MB limit
    max_size = @@max_file_size_mb * 1024 * 1024 # Convert MB to bytes

    if params[:file].present?
      file = params[:file]

      # limit maximum file size
      if file.size > max_size
        redirect_to portal_path, alert: "File is too large. Maximum size allowed is #{@@max_file_size_mb}MB." and return
      end

      if file.content_type == allowed_format
        # Process the file
        begin
          ImportExcelService.new(file).process
          Rails.logger.info "Shipment file uploaded successfully"
        rescue StandardError => e
          Rails.logger.error "Error during file processing: #{e.message}"
          redirect_to portal_path, alert: e.message
        rescue => e
          Rails.logger.error "Error during file processing: #{e.message}"
          redirect_to portal_path, alert: "An error occurred while importing the file."
        end

        # Upload to OneDrive
        begin
          one_drive = OneDriveService.new
          response = one_drive.upload_file(file.path, file.original_filename)

          if response
            # Delete local temp file after upload
            file.tempfile.close
            file.tempfile.unlink if file.tempfile
            Rails.logger.info "Shipment file uploaded to OneDrive successfully"
            redirect_to portal_path, notice: "File imported successfully!"
          else
            Rails.logger.error "Shipment file failed to upload to OneDrive"
            redirect_to portal_path, notice: "File imported successfully!", alert: "File failed to upload to OneDrive! Please contact IT support."
          end
        rescue => err
          Rails.logger.error "Error during file uploading: #{err.message}"
          redirect_to portal_path, notice: "File imported successfully!", alert: "File failed to upload to OneDrive! Please contact IT support."
        end
      else
        redirect_to portal_path, alert: "Invalid file format. Only .xlsx files are allowed."
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
