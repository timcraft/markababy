require 'cgi'

module Markababy
  def self.capture(options = {}, &block)
    [].tap { |output| markup(options.merge(output: output), &block) }.join
  end

  def self.markup(options = {}, &block)
    options[:escape] = CGI.method(:escapeHTML)

    options[:output] = $stdout unless options.has_key?(:output)

    Builder.new(options, &block)
  end

  class Builder < BasicObject
    def initialize(options, &block)
      @options = options

      @output = @options[:output]

      @escape = @options[:escape]

      @context = @options[:context]

      instance_eval(&block)
    end

    def method_missing(sym, *args, &block)
      if !@context.nil? && @context.respond_to?(sym)
        return @context.send(sym, *args, &block)
      end

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

    def text(content)
      @output << @escape[content.to_s]
    end
  end
end
