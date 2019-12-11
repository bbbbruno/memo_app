# frozen_string_literal: true

class Memo
  attr_accessor :title, :content

  def initialize(title, content)
    @title = title
    p content.gsub(/\R/, "\n")
    @content = content.gsub(/\R/, "\n")
  end

  def save
    File.open("db/#{title}.rb", 'w') do |f|
      f.print "data = { title: \"#{title}\", content: \"#{content}\" }"
    end
  end

  def self.find(title)
    data = File.open("db/#{title}.rb").read
    self.new(data[:title], data[:content])
  end
end