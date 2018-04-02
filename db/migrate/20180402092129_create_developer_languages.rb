class CreateDeveloperLanguages < ActiveRecord::Migration[5.1]
  def change
    create_table :developer_languages do |t|
      t.belongs_to :developer, index: true
      t.belongs_to :language, index: true

      t.timestamps
    end
  end
end
