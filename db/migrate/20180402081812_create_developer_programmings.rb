class CreateDeveloperProgrammings < ActiveRecord::Migration[5.1]
  def change
    create_table :developer_programmings do |t|
      t.belongs_to :developer, index: true
      t.belongs_to :programming_language, index: true

      t.timestamps
    end
  end
end
