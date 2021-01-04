module Markababy
  class RailsTemplateContext
    def initialize(controller)
      @controller = controller

      @ivars = @controller.instance_variables.map(&:to_sym)
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
end
