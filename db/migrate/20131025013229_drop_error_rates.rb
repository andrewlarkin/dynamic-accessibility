class DropErrorRates < ActiveRecord::Migration
  def change
    drop_table :error_rates
  end
end
