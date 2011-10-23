require 'markababy/builder'
require 'cgi'

module Markababy
  def self.capture(options = {}, &block)
    [].tap { |output| markup(options.merge(output: output), &block) }.join
  end

  def self.markup(options = {}, &block)
    options[:escape] = CGI.method(:escapeHTML)

    options[:output] = $stdout unless options.has_key?(:output)

    options[:output] << doctype if options[:doctype]

    Builder.new(options, &block)
  end

  def self.doctype
    @doctype ||= "<!DOCTYPE html>\n".freeze
  end

  if defined?(Rails)
    require 'markababy/rails_template_context'
    require 'markababy/rails_template_handler'
    require 'markababy/railtie'
  end
end
