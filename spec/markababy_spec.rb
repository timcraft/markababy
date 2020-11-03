require 'markababy'
require 'active_support/core_ext/string/output_safety'

class ExampleContext
  def baconize(word)
    "#{word} bacon!"
  end
end

RSpec.describe 'Markababy.capture' do
  it 'renders tags without attributes or content' do
    expect(Markababy.capture { br }).to eq('<br>')
  end

  it 'renders tags with content' do
    expect(Markababy.capture { title 'Untitled' }).to eq('<title>Untitled</title>')
  end

  it 'escapes content' do
    expect(Markababy.capture { h1 'Apples & Oranges' }).to eq('<h1>Apples &amp; Oranges</h1>')
  end

  it 'renders tags with an attribute hash' do
    output = Markababy.capture { input :type => :text, :size => 40 }

    expect(output).to match(/<input .+>/)
    expect(output).to match(/ type="text"/)
    expect(output).to match(/ size="40"/)
  end

  it 'renders tags with an attribute array' do
    expect(Markababy.capture { input [{:type => :text}, :disabled] }).to eq('<input type="text" disabled>')
  end

  it 'renders tags with attributes and content' do
    expect(Markababy.capture { div 'O hai', :class => 'name' }).to eq('<div class="name">O hai</div>')
  end

  it 'renders nested tags' do
    expect(Markababy.capture { h1 { span 'Chunky bacon!' } }).to eq('<h1><span>Chunky bacon!</span></h1>')
  end

  it 'provides an option for specifying the output target' do
    output = []

    Markababy.markup(:output => output) { hr }

    expect(output.join).to eq('<hr>')
  end

  it 'provides an option for specifying the method lookup context' do
    output = Markababy.capture(:context => ExampleContext.new) { h1 baconize('Super chunky') }

    expect(output).to eq('<h1>Super chunky bacon!</h1>')
  end

  it 'provides an method for rendering text content inside a tag' do
    output = Markababy.capture { h1 { text 'Hello '; strong 'World' } }

    expect(output).to eq('<h1>Hello <strong>World</strong></h1>')
  end

  it 'does not escape content that has been marked as html safe' do
    expect(Markababy.capture { text 'Hello&nbsp;World'.html_safe }).to eq 'Hello&nbsp;World'

    output = Markababy.capture { h1 'Hello <strong>World</strong>'.html_safe }

    expect(output).to eq('<h1>Hello <strong>World</strong></h1>')
  end

  it 'provides an option for including a doctype declaration' do
    output = Markababy.capture(:doctype => true) { html { body { p 'INSERT CONTENT HERE' } } }

    expect(output).to eq("<!DOCTYPE html>\n<html><body><p>INSERT CONTENT HERE</p></body></html>")
  end

  it 'provides access to constants' do
    Something = Class.new

    expect(Markababy.capture { h1 Something }).to eq('<h1>Something</h1>')
  end
end
