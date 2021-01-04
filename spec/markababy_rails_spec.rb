require 'rails'
require 'action_controller/railtie'
require 'action_view/railtie'
require 'markababy'

class DummyApplication < Rails::Application
  config.eager_load = false
  config.active_support.deprecation = :log
end

DummyApplication.initialize!

class DummyController < ActionController::Base
  append_view_path 'spec/views'
end

RSpec.describe 'Rendering the DummyController index template' do
  it 'returns the correct markup' do
    assigns = {message: 'Controller says hello!'}

    output = '<html><head><title>Controller says hello!</title></head><body><p>12,345,678</p></body></html>'

    expect(DummyController.render(template: 'index', assigns: assigns)).to eq(output)
  end
end
