class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.references :resource
    	t.date :date
    	t.string :title
    	t.string :link

      t.timestamps
    end
    add_index :news, :resource_id
  end
end
