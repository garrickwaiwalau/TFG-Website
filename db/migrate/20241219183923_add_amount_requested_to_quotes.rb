class AddAmountRequestedToQuotes < ActiveRecord::Migration[7.2]
  def change
    add_column :quotes, :amount_requested_cents, :integer, default: 0
  end
end
