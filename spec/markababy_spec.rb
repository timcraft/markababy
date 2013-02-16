require 'minitest/autorun'
require 'markababy'
require 'active_support/core_ext/string/output_safety'

class ExampleContext
  def baconize(word)
    "#{word} bacon!"
  end
end

describe 'Markababy' do
  it 'renders tags without attributes or content' do
    Markababy.capture { br }.must_equal '<br>'
  end

  it 'renders tags with content' do
    Markababy.capture { title 'Untitled' }.must_equal '<title>Untitled</title>'
  end

  it 'escapes content' do
    Markababy.capture { h1 'Apples & Oranges' }.must_equal '<h1>Apples &amp; Oranges</h1>'
  end

  it 'renders tags with an attribute hash' do
    output = Markababy.capture { input :type => :text, :size => 40 }

    output.must_match(/<input .+>/)
    output.must_match(/ type="text"/)
    output.must_match(/ size="40"/)
  end

  it 'renders tags with an attribute array' do
    Markababy.capture { input [{:type => :text}, :disabled] }.must_equal '<input type="text" disabled>'
  end

  it 'renders tags with attributes and content' do
    Markababy.capture { div 'O hai', :class => 'name' }.must_equal '<div class="name">O hai</div>'
  end

  it 'renders nested tags' do
    Markababy.capture { h1 { span 'Chunky bacon!' } }.must_equal '<h1><span>Chunky bacon!</span></h1>'
  end

  it 'provides an option for specifying the output target' do
    output = []

    Markababy.markup(:output => output) { hr }

    output.join.must_equal '<hr>'
  end

  it 'provides an option for specifying the method lookup context' do
    output = Markababy.capture(:context => ExampleContext.new) { h1 baconize('Super chunky') }

    output.must_equal '<h1>Super chunky bacon!</h1>'
  end

  it 'provides an method for rendering text content inside a tag' do
    output = Markababy.capture { h1 { text 'Hello '; strong 'World' } }

    output.must_equal '<h1>Hello <strong>World</strong></h1>'
  end

  it 'does not escape content that has been marked as html safe' do
    Markababy.capture { text 'Hello&nbsp;World'.html_safe }.must_equal 'Hello&nbsp;World'

    output = Markababy.capture { h1 'Hello <strong>World</strong>'.html_safe }

    output.must_equal '<h1>Hello <strong>World</strong></h1>'
  end

  it 'provides an option for including a doctype declaration' do
    output = Markababy.capture(:doctype => true) { html { body { p 'INSERT CONTENT HERE' } } }

    output.must_equal "<!DOCTYPE html>\n<html><body><p>INSERT CONTENT HERE</p></body></html>"
  end

  it 'provides access to constants' do
    Something = Class.new

    Markababy.capture { h1 Something }.must_equal('<h1>Something</h1>')
  end
end
