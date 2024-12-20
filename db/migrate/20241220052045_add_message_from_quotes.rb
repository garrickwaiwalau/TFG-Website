class AddMessageFromQuotes < ActiveRecord::Migration[7.2]
  def change
    add_column :quotes, :message, :text
  end
end
