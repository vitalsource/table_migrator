require 'active_record'

# When setting up your system for testing, store
# the MySQL password in an environment variable
# > export TABLE_MIGRATOR_KEY='secret'


ActiveRecord::Base.establish_connection({
  :adapter => 'mysql',
  :host => 'localhost',
  :username => 'table_migrator',
  :password => ENV["TABLE_MIGRATOR_KEY"],
  :database => 'table_migrator_test'
})

def create_users
  ActiveRecord::Schema.define do
    create_table "users", :force => true do |t|
      t.string :name, :null => false
      t.string :email
      # t.string :short_bio
      t.timestamps
    end

    add_index :users, :updated_at
    # add_index :users, :name
    # add_index :users, :email
  end
end

def create_news_stories
  ActiveRecord::Schema.define do
    create_table "news_stories", :force => true do |t|
      t.integer :user_id
      t.text :story
      # t.string :actors
      t.datetime :create_at, :null => false
    end

    add_index :news_stories, :user_id
    add_index :news_stories, :created_at
  end
end
