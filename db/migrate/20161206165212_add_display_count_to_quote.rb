class AddDisplayCountToQuote < ActiveRecord::Migration[5.0]
  def change
    add_column :quotes, :display_count, :integer
  end
end
