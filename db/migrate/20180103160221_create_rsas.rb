class CreateRsas < ActiveRecord::Migration[5.1]
  def change
    create_table :rsas do |t|
      t.text :n
      t.text :e
      t.text :d
      t.text :messages
      t.text :encrypt_messages
      t.text :decrypt_messages

      t.timestamps
    end
  end
end
