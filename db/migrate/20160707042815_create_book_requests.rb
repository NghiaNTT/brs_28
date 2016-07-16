class CreateBookRequests < ActiveRecord::Migration
  def change
    create_table :book_requests do |t|
      t.references :user, tindex: true, foreign_key: true
      t.string :title
      t.string :author
      t.string :isbn
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
