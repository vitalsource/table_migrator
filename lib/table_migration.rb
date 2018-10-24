require 'active_record'
require 'table_migrator/base'

migration_class =
  if ActiveRecord::VERSION::MAJOR >= 5
    ActiveRecord::Migration[5.2]
  else
    ActiveRecord::Migration
  end

class TableMigration < migration_class
  class << self
    attr_reader :table_migrator
    delegate :schema_changes,          :to => :table_migrator
    delegate :column_names,            :to => :table_migrator
    delegate :quoted_column_names,     :to => :table_migrator
    delegate :base_copy_query,         :to => :table_migrator
  end

  def self.change_table(*args, &block)
    migrates(*args) if table_migrator.nil?

    table_migrator.change_table(&block)
  end

  def self.create_table_and_copy_info
    table_migrator.create_table_and_copy_info
  end

  def self.migrates(table_name, config = {})
    default = {:migration_name => name.underscore}
    puts default.update(config).inspect
    @table_migrator = TableMigrator::Base.new(table_name, default.update(config))
  end

  def self.up
    table_migrator.up!
    raise "Dry Run!" if table_migrator.dry_run?
  end

  def self.down
    table_migrator.down!
    raise "Dry Run!" if table_migrator.dry_run?
  end
end
