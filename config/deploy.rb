require 'capistrano/ext/multistage'

set :stages , %w{production development testing}

set :default_stage, "production"

default_run_options[:pyt] = true



