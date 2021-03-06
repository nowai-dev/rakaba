class CreateRThreads < ActiveRecord::Migration
  def self.up
    create_table :r_threads do |t|
      t.text      :message
      t.string    :title
      t.string    :board
      t.integer   :rid
      t.integer   :replies_count,   default: 0
      t.integer   :user_id
      t.integer   :ip_id
      t.boolean   :hidden,          default: false
      t.boolean   :sticky,          default: false
      t.datetime  :bump
      t.string    :file_name
      t.string    :file_type
      t.integer   :file_size
      t.timestamps
    end

    add_index :r_threads, [:rid, :board], unique: true
    add_index :r_threads, :ip_id
    add_index :r_threads, :board
    add_index :r_threads, :user_id
  end

  def self.down
    drop_table :r_threads
  end
end
