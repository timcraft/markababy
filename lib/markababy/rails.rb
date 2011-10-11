require 'action_view'

module Markababy
  module RailsTemplateHandler
    def self.call(template)
      "self.output_buffer = ''; Markababy.capture(output: self.output_buffer, context: self) do\n#{template.source}\nend"
    end

    def self.extended(base)
      base.register_default_template_handler :rb, self
    end
  end

  ActionView::Template.extend RailsTemplateHandler
end
