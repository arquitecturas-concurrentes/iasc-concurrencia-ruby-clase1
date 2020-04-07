#!/bin/bash

# Replace with your home
INITIAL_HOME="/home/ernesto"

RUBY_VERSION="${2:-2.3.6}"
JRUBY_VERSION="${2:-9.2.6.0}"
JRUBY="$HOME/.rvm/rubies/jruby-$JRUBY_VERSION/bin/ruby"
MRI="$HOME/.rvm/rubies/ruby-$RUBY_VERSION/bin/ruby"

echo JRuby: `$JRUBY $1`
echo MRI: `$MRI $1`
