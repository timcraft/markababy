module Markababy
  def self.capture(&block)
    [].tap { |output| Builder.new(output, &block) }.join
  end

  class Builder < BasicObject
    def initialize(output, &block)
      @output = output

      instance_eval(&block)
    end

    def method_missing(sym, *args, &block)
      @output << "<#{sym}>"
    end
  end
end
