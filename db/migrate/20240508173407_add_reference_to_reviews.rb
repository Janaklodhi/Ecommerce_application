class AddReferenceToReviews < ActiveRecord::Migration[7.1]
  def change
    add_reference :reviews, :product, foreign_key: true
    add_reference :reviews, :user, foreign_key: true
  end
end