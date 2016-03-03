class CreateCrawlers < ActiveRecord::Migration
  def change
    create_table :crawlers do |t|
      t.string :category
      t.string :v_type
      t.string :title

      t.timestamps null: false
    end
  end
end
