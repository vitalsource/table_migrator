require 'active_record'

# When setting up your system for testing, store
# the MySQL password in an environment variable
# > export TABLE_MIGRATOR_KEY='secret'

db_attrs = {
    :adapter => 'mysql',
    :host => 'localhost',
    :username => 'root',
    :password => ENV["TABLE_MIGRATOR_KEY"]
}

ActiveRecord::Base.establish_connection(db_attrs)

ActiveRecord::Base.connection.execute("DROP DATABASE IF EXISTS table_migrator_test")
ActiveRecord::Base.connection.execute("CREATE DATABASE table_migrator_test")

ActiveRecord::Base.establish_connection(
    db_attrs.merge(
        {
            :database => 'table_migrator_test'
        }
    )
)

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
