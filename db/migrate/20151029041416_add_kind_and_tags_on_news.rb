class AddKindAndTagsOnNews < ActiveRecord::Migration
  def change
  	add_column :news, :kind, :string, after: :link 
  	add_column :news, :tags, :string, after: :kind 
  end
end
