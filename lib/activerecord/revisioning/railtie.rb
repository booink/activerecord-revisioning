require 'activerecord/revisioning/base'

module ActiveRecord
  module Revisioning
    class Railtie < ::Rails::Railtie
      initializer 'Initialize params_inquirer' do
        ::ActiveRecord::Base.send :include, ActiveRecord::Revisioning::Base
      end
    end
  end
end
