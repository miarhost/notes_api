class CreateNotes < ActiveRecord::Migration[7.0]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :content
      t.string :type

      t.timestamps
    end
    add_index :notes, :content, name: 'content', type: :fulltext
  end
end
