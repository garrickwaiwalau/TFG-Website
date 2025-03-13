# app/services/import_excel_service.rb
require "zip"

class ImportExcelService
  def initialize(file)
    @file = file
  end

  def process
    xlsx = Roo::Spreadsheet.open(@file.path)
    sheet = xlsx.sheet(0) # Assuming the data is in the first sheet
    idx = 0
    standard_ocean_status = ENV["STANDARD_OCEAN_STATUS"].split(", ") # Convert ENV string to an array
    standard_air_status = ENV["STANDARD_AIR_STATUS"].split(", ") # Convert ENV string to an array

    # Macro detection
    Zip::File.open(@file.path) do |zip_file|
      zip_file.each do |entry|
        if entry.name.include?("vbaProject.bin") # VBA macros exist
          raise StandardError, "Excel files with macros are not allowed."
        end
      end
    end

    # Iterate over each row, starting from row 2 (to skip headers)
    sheet.each_row_streaming(offset: 1, pad_cells: true) do |row|
      # Extract data from the row
      column_1_value = row[0]&.value # Mode
      column_2_value = row[1]&.value # Type
      column_3_value = row[2]&.value # Reference File Number
      column_4_value = row[3]&.value # AWB / HBL Number
      column_5_value = row[4]&.value # MBL Number
      column_6_value = row[5]&.value # Container Number
      column_7_value = row[6]&.value # Vessel / Flight No
      column_8_value = row[7]&.value # Voyage
      # column_9_value = row[8]&.value # SL
      column_10_value = row[9]&.value # Loading Port
      column_11_value = row[10]&.value # ETD Port (Departure)
      column_12_value = row[11]&.value # Actual Sailing  Date
      column_13_value = row[12]&.value # Final Port of Arrival
      column_14_value = row[13]&.value # ETA Port (Arrival)
      column_15_value = row[14]&.value # Actual Port Arrival Date
      column_16_value = row[15]&.value # Final Destination
      # column_17_value = row[16]&.value # CN / CP
      column_18_value = row[17]&.value # ETA Final Destination
      column_19_value = row[18]&.value # Actual Arrival Date at Final Destination
      column_20_value = row[19]&.value # Status
      # column_21_value = row[20]&.value # Pre-Alert Sending Date (**NOT IN USE**)
      column_22_value = row[21]&.value # Container Size
      column_23_value = row[22]&.value # Piece(s)
      column_24_value = row[23]&.value # Weight in KGS (G.W.)
      column_25_value = row[24]&.value # Volume (CBM)
      column_26_value = row[25]&.value # PIC
      column_27_value = row[26]&.value # SHIPMENT STATUS SEND DATE
      column_28_value = row[27]&.value # SHIPPER
      column_29_value = row[28]&.value # CONSIGNEE
      column_30_value = row[29]&.value # PO NUMBER
      column_31_value = row[30]&.value # Recipient Email for Pre-Alert sending.
      column_32_value = row[31]&.value # AGENT
      column_33_value = row[32]&.value # DIVISION
      column_34_value = row[33]&.value # TYPE
      column_35_value = row[34]&.value # TYPE #
      column_36_value = row[35]&.value # FILE pass to OP

      idx = idx + 1

      gross_weight_value = column_24_value.to_f
      cbm_value = column_25_value.to_f

      # Conditional logic to decide which table to insert data into
      if column_1_value&.downcase == "ocean"
        # Insert into OceanShipment
        ocean_shipment_data = {
          shipment_type: column_2_value,
          tracking_id: column_3_value + "@" + column_4_value,
          reference_number: column_3_value,
          hbl_number: column_4_value,
          mbl_number: column_5_value,
          po_number: column_30_value,
          shipper: column_28_value,
          consignee: column_29_value,
          vessel: column_7_value,
          voyage: column_8_value,
          container_number: column_6_value,
          container_size: column_22_value,
          pcs: column_23_value,
          gross_weight: (gross_weight_value * 100).ceil / 100.0, # Always rounds up
          cbm: (cbm_value * 100).ceil / 100.0, # Always rounds up
          pol: column_10_value,
          pod: column_13_value,
          dest: column_16_value,
          etd: column_11_value,
          atd: column_12_value,
          eta: column_14_value,
          ata: column_15_value,
          dest_eta: column_18_value,
          dest_ata: column_19_value,
          status: column_20_value,
          pic: column_26_value,
          status_send_date: column_27_value,
          pre_alert_email: column_31_value,
          agent: column_32_value,
          division: column_33_value,
          internal_type_1: column_34_value,
          internal_type_2: column_35_value,
          file_pass_to_op: column_36_value
        }

        # Debug use
        # Rails.logger.info "Debugging with shipment data : #{ocean_shipment_data}"

        begin
          # Checking for values
          # Checking for status
          unless standard_ocean_status.include?(column_20_value)
            raise StandardError, "Invalid status value on Row #{idx}: '#{column_20_value}' is not allowed."
          end

          # Find the record by reference_number or initialize a new one
          ocean_shipment = OceanShipment.find_or_initialize_by(reference_number: column_3_value)
          ocean_shipment.assign_attributes(ocean_shipment_data) # Update the attributes
          ocean_shipment.save! # Save the record
          Rails.logger.info "Ocean Shipment record #{ocean_shipment.new_record? ? 'created' : 'updated'} successfully for Reference Number: #{column_3_value}"
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error "Validation failed for Ocean Shipment: #{e.message}"
          raise
        rescue StandardError => e
          Rails.logger.error "Error creating/updating Ocean Shipment record: #{e.message}"
          raise
        end
      elsif column_1_value&.downcase == "air"
        # Insert into AirShipment
        air_shipment_data = {
          tracking_id: column_3_value + "@" + column_4_value,
          reference_number: column_3_value,
          hawb_number: column_4_value,
          mawb_number: column_5_value,
          po_number: column_30_value,
          shipper: column_28_value,
          consignee: column_29_value,
          flight_number: column_7_value,
          pcs: column_23_value,
          gross_weight: (gross_weight_value * 100).ceil / 100.0, # Always rounds up
          cbm: (cbm_value * 100).ceil / 100.0, # Always rounds up
          pol: column_10_value,
          pod: column_13_value,
          dest: column_16_value,
          etd: column_11_value,
          atd: column_12_value,
          eta: column_14_value,
          ata: column_15_value,
          status: column_20_value,
          pic: column_26_value,
          agent: column_32_value,
          division: column_33_value,
          internal_type_1: column_34_value,
          internal_type_2: column_35_value,
          file_pass_to_op: column_36_value
        }

        # Debug use
        # Rails.logger.info "Debugging with shipment data : #{air_shipment_data}"

        begin
          # Checking for values
          # Checking for status
          unless standard_air_status.include?(column_20_value)
            raise StandardError, "Invalid status value on Row #{idx}: '#{column_20_value}' is not allowed."
          end

          # Find the record by reference_number or initialize a new one
          air_shipment = AirShipment.find_or_initialize_by(reference_number: column_3_value)
          air_shipment.assign_attributes(air_shipment_data) # Update the attributes
          air_shipment.save! # Save the record
          Rails.logger.info "Air Shipment record #{air_shipment.new_record? ? 'created' : 'updated'} successfully for Reference Number: #{column_3_value}"
        rescue ActiveRecord::RecordInvalid => e
          Rails.logger.error "Validation failed for Air Shipment: #{e.message}"
          raise
        rescue StandardError => e
          Rails.logger.error "Error creating/updating Air Shipment record: #{e.message}"
          raise
        end
      else
        # Handle rows that don't match your conditions
        Rails.logger.warn "Mode can only be Ocean or Air!"
        raise StandardError, "Invalid mode value on Row #{idx}: '#{column_1_value}' is not allowed."
      end
    end
  end
end
