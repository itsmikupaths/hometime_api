class CreateApiKeys < ActiveRecord::Migration[7.1]
  def change
    create_table :api_keys do |t|
      t.string :key
      t.string :app_name

      t.timestamps
    end
  end
end
