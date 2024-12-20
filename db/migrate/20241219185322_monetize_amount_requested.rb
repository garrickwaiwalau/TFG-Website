class MonetizeAmountRequested < ActiveRecord::Migration[7.2]
  def change
    remove_column :quotes, :amount_requested_cents, :integer
    add_monetize :quotes, :amount_requested
  end
end
