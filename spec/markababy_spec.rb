require 'minitest/autorun'
require 'markababy'

describe Markababy do
  it 'should render a tag without attributes or content correctly' do
    Markababy.capture { br }.must_equal '<br>'
  end
end
