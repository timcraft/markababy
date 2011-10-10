require 'cgi'

module Markababy
  def self.capture(&block)
    [].tap { |output| Builder.new(output, CGI.method(:escapeHTML), &block) }.join
  end

  class Builder < BasicObject
    def initialize(output, escape, &block)
      @output = output

      @escape = escape

      instance_eval(&block)
    end

    def method_missing(sym, *args, &block)
      if args.empty?
        @output << "<#{sym}>"
      else
        content = args.map { |arg| @escape[arg] }.join

        @output << "<#{sym}>#{content}</#{sym}>"
      end
    end
  end
end
