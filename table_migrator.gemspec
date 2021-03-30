# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "table_migrator"
  s.version     = '0.1.3'
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Matt Freels", "Rohith Ravi", "Rick Olson",]
  s.email       = ["matt@freels.name"]
  s.homepage    = "http://github.com/freels/table_migrator"
  s.summary     = "Zero-downtime table migration in MySQL"
  s.description = <<-EOF
    TableMigrator is a method for altering large MySQL tables while incurring
    as little downtime as possible.  First, we create a new table like the
    original one, and then apply one or more ALTER TABLE  statements to the
    unused, empty table. Second we copy all rows from the original table into
    the new one.  All this time, reads and writes are going to the original
    table, so the two tables are not consistent. Finally, we acquire a write
    lock on the original table before copying over all new/changed rows, and
    swapping in the new table.
  EOF

  s.add_dependency "activerecord", ">= 3.2.0"

  s.add_development_dependency "rake", "~>0.9.2.2"
  s.add_development_dependency "shoulda"

  # WARNING : Compiling native extensions for gem requires installing C headers for MySQL
  s.add_development_dependency "mysql", '~>2.8.1'

  s.files        = Dir.glob("lib/**/*") +%w[README.md]
  s.require_path = 'lib'

end
