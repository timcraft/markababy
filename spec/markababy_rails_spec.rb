require 'minitest/autorun'
require 'abstract_controller'
require 'markababy'
require 'markababy/rails'

class DummyController < AbstractController::Base
  # cf. http://amberbit.com/blog/render-views-partials-outside-controllers-rails-3

  include AbstractController::Rendering
  include AbstractController::Layouts
  include AbstractController::Helpers

  self.view_paths = 'spec/views'

  def index
    render template: 'index'
  end
end

describe DummyController do
  it 'should return the correct markup' do
    output = '<html><head><title>Hey!</title><p>12,345,678</p></head></html>'

    DummyController.new.index.must_equal output
  end
end
