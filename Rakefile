# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'dotenv'
require 'logger'

RSpec::Core::RakeTask.new(:spec)

task default: :spec

task(:configure) do
  require 'hello_sign/client'

  HelloSign::Client.configure do |c|
    c.logger = HelloSign::Logger.new(File.expand_path('../log/rake.log', __FILE__))
    c.request_logger = HelloSign::Logger.new(File.expand_path('../log/requests.log', __FILE__))
  end

  Dotenv.load
end

def table_for(title, headings, rows, &block)
  require 'terminal-table'

  if block_given?
    if block.arity == 1
      yield(self)
    else
      instance_eval(&block)
    end
  end

  table = Terminal::Table.new(title: title, headings: headings, rows: rows)
  puts "\n"
  puts table.to_s
  puts "\n"
end

def table_for_collection(collection, &block)
  table_record = collection.as_json_data_table

  title    = collection.as_title
  headings = table_record.headings
  rows     = table_record.rows_values

  table_for(title, headings, rows)
end

desc "List out API Routes"
task(routes: :configure) do
  require 'terminal-table'

  route_definitions = HelloSign::Client.routes

  row_display = ->(row,index) do
    [(index + 1), row.name, row.path]
  end

  #title    = "%s (%s)" % [directory.title, route_definitions.count]
  title    = "Routes"
  headings = ['#', 'Route Name', 'URL']
  rows     = route_definitions.each_with_index.map { |r,i| row_display.call(r,i) }

  table = Terminal::Table.new(title: title, headings: headings, rows: rows)
  puts "\n"
  puts table.to_s
  puts "\n"
end
