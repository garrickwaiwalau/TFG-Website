require "rest-client"
require "json"
require "cgi"

class OneDriveService
  CLIENT_ID = ENV["ONEDRIVE_CLIENT_ID"]
  CLIENT_SECRET = ENV["ONEDRIVE_CLIENT_SECRET"]
  TENANT_ID = ENV["ONEDRIVE_TENANT_ID"]
  DRIVE_ID = ENV["ONEDRIVE_DRIVE_ID"]

  REDIRECT_URI = "http://localhost:3000/auth/microsoft/callback"

  def initialize
    @token = get_access_token
  end

  def upload_file(file_path, file_name)
    # Define your folder path (containing spaces)
    folder_name = "Uploaded Shipment Files"

    # Encode spaces and special characters in the path
    file_name_timestamp = file_name.gsub(".xlsx", "_#{Time.now.strftime('%Y%m%d%H%M%S')}.xlsx")
    upload_file_path = "#{folder_name}/#{file_name_timestamp}"
    encoded_file_path = upload_file_path.gsub(" ", "%20")

    # Construct the correct URL
    url = "https://graph.microsoft.com/v1.0/drives/#{DRIVE_ID}/root:/#{encoded_file_path}:/content"

    file = File.open(file_path, "rb")

    response = RestClient.put(
      url,
      file.read,
      { Authorization: "Bearer #{@token}", content_type: "application/octet-stream" }
    )

    file.close
    JSON.parse(response.body)
  rescue RestClient::ExceptionWithResponse => e
    puts "OneDrive Upload Error: #{e.response}"
    nil
  end

  private

  def get_access_token
    url = "https://login.microsoftonline.com/#{TENANT_ID}/oauth2/v2.0/token"

    response = RestClient.post(
      url,
      {
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        grant_type: "client_credentials",
        scope: "https://graph.microsoft.com/.default"
      }
    )

    JSON.parse(response.body)["access_token"]
  end
end
