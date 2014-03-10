class CreateGalleries < ActiveRecord::Migration
  def change
    create_table :galleries do |t|
      t.string :name #it knows if you type string its talking about a column
    end
  end
end
