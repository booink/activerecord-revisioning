module Revisioning
  class Revision < ActiveRecord::Base
    self.table_name = "revisioning_revisions"
    belongs_to :revisionable, polymorphic: true
  end
end
