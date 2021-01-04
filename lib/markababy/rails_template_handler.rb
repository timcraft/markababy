module Markababy
  module RailsTemplateHandler
    def self.call(template, source)
      "self.output_buffer = ''\n" +
      "Markababy.capture(:output => self.output_buffer, :context => Markababy::RailsTemplateContext.new(self)) do\n" +
      "#{template.source}\n" +
      "end\n"
    end
  end
end
