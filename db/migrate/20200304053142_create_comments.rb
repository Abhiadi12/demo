class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.string :description
      t.belongs_to :article , index: true
      t.belongs_to :user , index: true
      t.timestamps
    end
  end
end