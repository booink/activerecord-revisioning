if defined?(Rails::Railtie)
  require "activerecord/revisioning/railtie"
else
  raise 'activerecord-revisioning is not compatible with Rails 2.* or older'
end

module ActiveRecord
  module Revisioning
  end
end
