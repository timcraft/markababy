Markaby's little sister.

Usage is similar to Markaby, and easy to use directly from a Ruby script:

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

Use Markababy.capture if you want to capture the output as a string instead
of printing it to $stdout.

Some differences from Markaby:

* No auto-stringification
* No element classes or IDs
* No validation
* No XHTML
