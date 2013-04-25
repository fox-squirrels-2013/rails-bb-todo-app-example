#!/bin/bash

# Re-create db from scratch
bundle exec "rake db:drop ; rake db:create && rake db:migrate"

# Run the driver code
bundle exec ruby data.rb
