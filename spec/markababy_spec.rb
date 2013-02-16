require 'minitest/autorun'
require 'markababy'
require 'active_support/core_ext/string/output_safety'

class ExampleContext
  def baconize(word)
    "#{word} bacon!"
  end
end

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
    Markababy.capture { input :type => :text, :size => 40 }.must_equal '<input type="text" size="40">'
  end

  it 'should render tags with an attribute array correctly' do
    Markababy.capture { input [{:type => :text}, :disabled] }.must_equal '<input type="text" disabled>'
  end

  it 'should render tags with attributes and content correctly' do
    Markababy.capture { div 'O hai', :class => 'name' }.must_equal '<div class="name">O hai</div>'
  end

  it 'should render nested tags correctly' do
    Markababy.capture { h1 { span 'Chunky bacon!' } }.must_equal '<h1><span>Chunky bacon!</span></h1>'
  end

  it 'should allow output target to be specified' do
    output = []

    Markababy.markup(:output => output) { hr }

    output.join.must_equal '<hr>'
  end

  it 'should allow context for method lookup to be specified' do
    output = Markababy.capture(:context => ExampleContext.new) { h1 baconize('Super chunky') }

    output.must_equal '<h1>Super chunky bacon!</h1>'
  end

  it 'should provide a method for rendering text content' do
    output = Markababy.capture { h1 { text 'Hello '; strong 'World' } }

    output.must_equal '<h1>Hello <strong>World</strong></h1>'
  end

  it 'should respect the html_safe? method' do
    Markababy.capture { text 'Hello&nbsp;World'.html_safe }.must_equal 'Hello&nbsp;World'

    output = Markababy.capture { h1 'Hello <strong>World</strong>'.html_safe }

    output.must_equal '<h1>Hello <strong>World</strong></h1>'
  end

  it 'should provide an option for including a doctype declaration' do
    output = Markababy.capture(:doctype => true) { html { body { p 'INSERT CONTENT HERE' } } }

    output.must_equal "<!DOCTYPE html>\n<html><body><p>INSERT CONTENT HERE</p></body></html>"
  end

  it 'should provide access to constants' do
    Something = Class.new

    Markababy.capture { h1 Something }.must_equal('<h1>Something</h1>')
  end
end
