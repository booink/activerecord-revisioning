require 'activerecord/revisioning/base'

module ActiveRecord
  module Revisioning
    class Railtie < ::Rails::Railtie
      initializer 'Initialize activerecord-revisioning' do
        ::ActiveRecord::Base.send :include, ActiveRecord::Revisioning::Base
      end
    end
  end
end
