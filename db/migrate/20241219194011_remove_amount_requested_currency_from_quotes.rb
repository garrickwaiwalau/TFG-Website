class RemoveAmountRequestedCurrencyFromQuotes < ActiveRecord::Migration[7.2]
  def change
    remove_column :quotes, :amount_requested_cents, :integer
    change_column_null :quotes, :amount_requested_currency, true
  end
end
