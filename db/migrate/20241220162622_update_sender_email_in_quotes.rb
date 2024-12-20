class UpdateSenderEmailInQuotes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :quotes, :sender_email, false
  end
end
