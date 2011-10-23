require 'minitest/autorun'
require 'rails/all'
require 'markababy'

class DummyApplication < Rails::Application
  config.active_support.deprecation = :log
end

DummyApplication.initialize!

class DummyController < AbstractController::Base
  # cf. http://amberbit.com/blog/render-views-partials-outside-controllers-rails-3

  include AbstractController::Rendering
  include AbstractController::Layouts
  include AbstractController::Helpers

  self.view_paths = 'spec/views'

  def index
    @message = 'Controller says hello!'

    render template: 'index'
  end
end

describe DummyController do
  it 'should return the correct markup' do
    output = '<html><head><title>Controller says hello!</title></head><body><p>12,345,678</p></body></html>'

    DummyController.new.index.must_equal output
  end
end
