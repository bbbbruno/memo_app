# frozen_string_literal: true

require 'fileutils'
require 'yaml'

class Memo
  attr_accessor :title, :content, :created_at, :id

  def initialize(title: '', content: '', created_at:, id:)
    @title = title
    @content = content.gsub(/\R/, "\n")
    @created_at = created_at
    @id = id
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

    def find(id)
      data = File.open("db/memo_#{id}.yml") { |f| YAML.load(f) }
      self.new(data)
    end

    def destroy(id)
      FileUtils.rm("db/memo_#{id}.yml")
    end
  end

  def save
    data = { title: title, content: content, created_at: created_at, id: id }
    YAML.dump(data, File.open("db/memo_#{id}.yml", 'w'))
  end
end
