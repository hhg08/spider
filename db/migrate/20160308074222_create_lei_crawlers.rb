class CreateLeiCrawlers < ActiveRecord::Migration
  def change
    create_table :lei_crawlers do |t|
      t.string :p_list_type
      t.string :game_type
      t.string :g_title

      t.timestamps null: false
    end
  end
end
