# markababy

[![Gem Version](https://badge.fury.io/rb/markababy.svg)](https://badge.fury.io/rb/markababy) [![Test Status](https://github.com/timcraft/markababy/actions/workflows/test.yml/badge.svg)](https://github.com/timcraft/markababy/actions/workflows/test.yml)


Ruby gem for generating HTML.


## Installation

    $ gem install markababy


## Example

Usage is similar to [Markaby](http://en.wikipedia.org/wiki/Markaby),
and easy to use directly from a Ruby script:

```ruby
require 'markababy'

Markababy.markup do
  html do
    head { title 'Boats.com' }
    body do
      h1 'Boats.com has great deals'
      ul do
        li '$49 for a canoe'
        li '$39 for a raft'
        li '$29 for a huge boot that floats and can fit 5 people'
      end
    end
  end
end
```

Use `Markababy.capture` if you want to capture
the output as a string instead of printing it to STDOUT.


## Rails template usage

Add markababy as a dependency to your Gemfile; do the bundle dance; then change
the extension on your template files from .erb to .rb and you can start writing
your templates in Ruby!

Controller instance variables and helpers will be available as methods.


## Less is more

Some differences from Markaby:

* No auto-stringification
* No element classes or IDs
* No validation
* No XHTML


## Alternatives

* https://github.com/timcraft/hom
* https://github.com/judofyr/tubby
* https://github.com/digital-fabric/rubyoshka
