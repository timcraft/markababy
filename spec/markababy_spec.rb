require 'minitest/autorun'
require 'markababy'

describe Markababy do
  it 'should render a tag without attributes or content correctly' do
    Markababy.capture { br }.must_equal '<br>'
  end

  it 'should render a tag with content correctly' do
    Markababy.capture { title 'Untitled' }.must_equal '<title>Untitled</title>'
  end
end
