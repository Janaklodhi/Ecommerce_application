class ChangePriceToFloatInOrderItems < ActiveRecord::Migration[7.1]
  def change
    change_column :order_items, :price, :float
  end
end