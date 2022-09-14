class AddPublisheddateToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :published_date, :DATE
  end
end
