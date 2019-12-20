# frozen_string_literal: true

require 'fileutils'
require 'yaml'

class Memo
  attr_accessor :title, :content, :created_at, :filename

  def initialize(title: '', content: '', created_at:, filename:)
    @title = title
    @content = content.gsub(/\R/, "\n")
    @created_at = created_at
    @filename = filename
  end

  class << self
    def all
      Dir.open('db').each_child.with_object([]) do |f, a|
        data = YAML.load_file("db/#{f}")
        a << new(data)
      end.sort_by(&:created_at)
      rescue
        retry
    end

    def find(filename)
      data = File.open("db/#{filename}.yml") { |f| YAML.load(f) }
      self.new(data)
    end

    def destroy(filename)
      FileUtils.rm("db/#{filename}.yml")
    end
  end

  def save
    data = { title: title, content: content, created_at: created_at, filename: filename }
    YAML.dump(data, File.open("db/#{filename}.yml", 'w'))
  end
end
