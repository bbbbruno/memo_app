# frozen_string_literal: true

require 'fileutils'

class Memo
  attr_accessor :title, :content, :created_at

  def initialize(title: '', content: '', created_at:)
    @title = title
    @content = content.gsub(/\R/, "\n")
    @created_at = created_at
  end

  class << self
    def all
      Dir.open('db').each_child.with_object([]) do |f, a|
        a < Memo.new(eval(File.open(f.delte('.rb')).read))
      end.sort_by(&:created_at)
    end

    def find(title)
      data = eval(File.open("db/#{title}.rb").read)
      self.new(data[:title], data[:content])
    end

    def destroy(title)
      FileUtils.rm("db/#{title}.rb")
    end
  end

  def save
    File.open("db/#{title}.rb", 'w') do |f|
      f.print "{ title: \"#{title}\", content: \"#{content}\", created_at: \"#{created_at}\" }"
    end
  end
end