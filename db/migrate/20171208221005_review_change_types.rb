class ReviewChangeTypes < ActiveRecord::Migration
  def change
    remove_column :reviews, :product_id, :string
    remove_column :reviews, :user_id, :string
    remove_column :reviews, :rating, :string
    add_column :reviews, :product_id, :integer
    add_column :reviews, :user_id, :integer
    add_column :reviews, :rating, :integer
  end
end
