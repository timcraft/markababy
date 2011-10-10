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
      attributes, content = [], []

      args.flatten.each do |arg|
        if arg.respond_to?(:to_hash)
          arg.to_hash.each { |k, v| attributes << ' %s="%s"' % [@escape[k.to_s], @escape[v.to_s]] }
        elsif arg.respond_to?(:id2name)
          attributes << ' %s' % @escape[arg.to_s]
        else
          content << @escape[arg.to_s]
        end
      end

      if attributes.empty?
        @output << "<#{sym}>"
      else
        @output << "<#{sym}#{attributes.join}>"
      end

      unless content.empty?
        @output << content.join
      end

      unless block.nil?
        instance_eval(&block)
      end

      unless content.empty? && block.nil?
        @output << "</#{sym}>"
      end
    end
  end
end
