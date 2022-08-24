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

  title    = "Routes: %s" % [HelloSign::Client.api_host]
  headings = ['#', 'Route Name', 'URL']
  rows     = route_definitions.each_with_index.map { |r,i| row_display.call(r,i) }

  table = Terminal::Table.new(title: title, headings: headings, rows: rows)
  puts "\n"
  puts table.to_s
  puts "\n"
end

desc "List out Signature Requests"
task(signature_requests: :configure) do
  require 'terminal-table'

  request_collection = HelloSign::Requests::SignatureRequests.list

  request_collection.on(:success) do |resp|
    resp_body = resp.body

    list_info        = HelloSign::Models::ListInfo.new(resp_body.fetch('list_info', {}))
    model_collection = HelloSign::Models::SignatureRequests.new(resp_body.fetch('signature_requests', []))

    row_display = ->(row,index) do
      [(index + 1), row.id, row.title, row.created_at]
    end

    title    = "Signature Requests"
    headings = ['#', 'id', 'title', 'created_at']
    rows     = model_collection.each_with_index.map { |r,i| row_display.call(r,i) }

    puts "\n"

    puts "Page: %s\n" % [list_info.page]
    puts "Per Page: %s\n" % [list_info.per_page]
    puts "Total Pages: %s\n" % [list_info.total_pages]
    puts "Total Results: %s\n" % [list_info.total_results]

    table = Terminal::Table.new(title: title, headings: headings, rows: rows)
    puts "\n"
    puts table.to_s
    puts "\n"
  end

  request_collection.on(:error) do |resp|
    HelloSign::Client.logger.error { "Could not render signature requests due to: %s" % [resp.status] }
  end
end
