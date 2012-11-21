require File.expand_path(File.join(File.dirname(__FILE__), '../test_helper.rb'))

require 'active_record/connection_adapters/abstract/schema_definitions'
require 'table_migrator'

class ChangeTableStrategyTest < Test::Unit::TestCase
  ChangeTableStrategy = ::TableMigrator::ChangeTableStrategy
  Table = ::ActiveRecord::ConnectionAdapters::Table
  Connection = ActiveRecord::Base.connection

  context "An instance of ChangeTableStrategy" do
    setup do
      create_users unless Connection.schema_cache.table_exists?(:users)
      @strategy = ChangeTableStrategy.new( :users, {}, ActiveRecord::Base.connection ) {}
    end

    should "return a strategy object" do
      assert_equal TableMigrator::ChangeTableStrategy, @strategy.class
    end

    should "represent 'Users' model" do
      assert_equal :users, @strategy.table
    end

    should "report 'users_old' for old table name" do
      assert_equal 'users_old', @strategy.old_table
    end

    should "report 'new_users' for new table name" do
      assert_equal 'new_users', @strategy.new_table
    end

    should "responds for all Table methods" do
      TableMigration.migrates(:users).change_table do |t|
        Table.instance_methods.each do |table_method|
          assert t.respond_to?(table_method), "Does not respond to table method '#{table_method}'"
        end
      end
    end

    should "have correct existing columns list" do
      expected_columns = Connection.columns(:users).map {|c| c.name }.sort
      assert_equal expected_columns, @strategy.column_names.sort
    end
  end
end


