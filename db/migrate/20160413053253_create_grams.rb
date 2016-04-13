class CreateGrams < ActiveRecord::Migration
  def change
    create_table :grams do |t|
    	# text field for messages
    	t.text :message

      t.timestamps
    end
  end
end
