module Markababy
  class Railtie < Rails::Railtie
    initializer 'markababy.action_view' do |app|
      ActiveSupport.on_load(:action_view) do
        ActionView::Template.register_default_template_handler :rb, RailsTemplateHandler
      end
    end
  end
end
