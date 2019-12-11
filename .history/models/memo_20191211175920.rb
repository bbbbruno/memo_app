# frozen_string_literal: true

class Memo
  attr_accessor :title, :content

  def initialize(title, content)
    @title = title
    p content
    p content.encode('utf-8')
    p content.to_s
    @content = content.encode('utf-8')
  end

  def save
    File.open("db/#{title}.rb", 'w') do |f|
      f.puts "{ title: '#{title}', content: '#{content.encode('utf-8')}' }"
    end
  end
end
