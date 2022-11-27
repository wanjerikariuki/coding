class CreateShorts < ActiveRecord::Migration[7.1]
  def change
    create_table :shorts do |t|
      t.string :original_url
      t.string :short_url
      t.string :sanitize_url

      t.timestamps
    end
  end
end
