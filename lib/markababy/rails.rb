require 'markababy'
require 'action_view'

module Markababy
  class RailsTemplateContext
    def initialize(controller)
      @controller = controller

      @ivars = @controller.instance_variables - @controller.class.new.instance_variables
    end

    def respond_to_missing?(sym, include_private = false)
      @ivars.include?(:"@#{sym}") || @controller.respond_to?(sym)
    end

    def method_missing(sym, *args, &block)
      if args.empty? && block.nil? && @ivars.include?(ivar = :"@#{sym}")
        @controller.instance_variable_get(ivar)
      elsif @controller.respond_to?(sym)
        @controller.send(sym, *args, &block)
      else
        super sym, *args, &block
      end
    end
  end

  module RailsTemplateHandler
    def self.call(template)
      "self.output_buffer = ''\n" +
      "Markababy.capture(output: self.output_buffer, context: Markababy::RailsTemplateContext.new(self)) do\n" +
      "#{template.source}\n" +
      "end\n"
    end

    def self.extended(base)
      base.register_default_template_handler :rb, self
    end
  end

  ActionView::Template.extend RailsTemplateHandler
end
