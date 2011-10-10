require 'minitest/autorun'
require 'markababy'

describe Markababy do
  it 'should render tags without attributes or content correctly' do
    Markababy.capture { br }.must_equal '<br>'
  end

  it 'should render tags with content correctly' do
    Markababy.capture { title 'Untitled' }.must_equal '<title>Untitled</title>'
  end

  it 'should escape content correctly' do
    Markababy.capture { h1 'Apples & Oranges' }.must_equal '<h1>Apples &amp; Oranges</h1>'
  end

  it 'should render tags with an attribute hash correctly' do
    Markababy.capture { input type: :text, size: 40 }.must_equal '<input type="text" size="40">'
  end

  it 'should render tags with an attribute array correctly' do
    Markababy.capture { input [{type: :text}, :disabled] }.must_equal '<input type="text" disabled>'
  end

  it 'should render tags with attributes and content correctly' do
    Markababy.capture { div 'O hai', class: 'name' }.must_equal '<div class="name">O hai</div>'
  end

  it 'should render nested tags correctly' do
    Markababy.capture { h1 { span 'Chunky bacon!' } }.must_equal '<h1><span>Chunky bacon!</span></h1>'
  end

  it 'should allow output target to be specified' do
    output = []

    Markababy.markup(output) { hr }

    output.join.must_equal '<hr>'
  end
end
