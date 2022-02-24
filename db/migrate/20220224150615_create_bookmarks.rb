class CreateBookmarks < ActiveRecord::Migration[6.1]
  def change
    create_table :bookmarks do |t|
      t.text :comment
      t.references :movie, null: false, foreign_key: true, index: { unique: true}
      t.references :list, null: false, foreign_key: true, index: { unique: true}

      t.timestamps
    end
  end
end
