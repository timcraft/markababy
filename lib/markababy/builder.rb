unless defined?(BasicObject)
  require 'backports/basic_object'

  class BasicObject
    undef_method :p
  end
end

module Markababy
  class Builder < BasicObject
    def initialize(options, &block)
      @options = options

      @output = @options[:output]

      @escape = @options[:escape]

      @context = @options[:context]

      instance_eval(&block)
    end

    if ::Object.new.respond_to?(:respond_to_missing?)
      def context_responds_to?(name)
        @context.respond_to?(name)
      end
    else
      def context_responds_to?(name)
        @context.respond_to?(name) || (@context.respond_to?(:respond_to_missing?) && @context.respond_to_missing?(name))
      end
    end

    def method_missing(sym, *args, &block)
      if @context && context_responds_to?(sym)
        return @context.send(sym, *args, &block)
      end

      attributes, content = [], []

      args.flatten.each do |arg|
        if arg.respond_to?(:to_hash)
          arg.to_hash.each { |k, v| attributes << ' %s="%s"' % [@escape[k.to_s], @escape[v.to_s]] }
        elsif arg.respond_to?(:id2name)
          attributes << ' %s' % @escape[arg.to_s]
        elsif arg.respond_to?(:html_safe?) && arg.html_safe?
          content << arg.to_s
        else
          content << @escape[arg.to_s]
        end
      end

      @output << (attributes.empty? ? "<#{sym}>" : "<#{sym}#{attributes.join}>")

      @output << content.join unless content.empty?

      instance_eval(&block) unless block.nil?

      @output << "</#{sym}>" unless content.empty? && block.nil?
    end

    def text(content)
      if content.respond_to?(:html_safe?) && content.html_safe?
        @output << content.to_s
      else
        @output << @escape[content.to_s]
      end
    end

    def self.const_missing(name)
      ::Object.const_get(name)
    end
  end
end
