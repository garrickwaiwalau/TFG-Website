class RemoveCargoRequiredDateFromQuotes < ActiveRecord::Migration[7.2]
  def change
    remove_column :quotes, :to_cargo_required, :date
  end
end
