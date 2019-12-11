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
      f.puts "{ title: '#{title}', content: '#{content.encode('utf-8')}' }"
    end
  end
end
