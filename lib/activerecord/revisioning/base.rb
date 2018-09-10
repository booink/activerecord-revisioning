require 'revisioning'

module ActiveRecord
  module Revisioning
    module Base
      extend ActiveSupport::Concern

      class_methods do
        attr_accessor :shared, :revision_class_name, :related_with, :on

        def revisioning(options = {})
          extend RevisioningClassMethods
          include RevisioningInstanceMethods

          assign_options(options)

          if shared
            self.revision_class_name = "::Revisioning::Revision"
            require 'revisioning/revision'
            table_exists!(revision_class_name.constantize.table_name)
            has_many :revisions, as: :revisionable, class_name: revision_class_name, inverse_of: :revisionable
          else
            self.revision_class_name = "#{self.to_s}Revision"
            table_exists!(revision_class_name.tableize, self)
            has_many :revisions, class_name: revision_class_name
          end

          after_create :revision_create    if on.include?(:create)
          before_update :revision_update   if on.include?(:update)
          before_destroy :revision_destroy if on.include?(:destroy)
        end

        private

        def assign_options(options = {})
          if options[:shared].present?
            raise ArgumentError, 'specify boolean for shared' if [true, false].include?(options[:shared])
            self.shared = options[:shared]
          else
            self.shared = false
          end

          if options[:related_with].present?
            related_class_name = options[:related_with].to_s.classify
            raise ArgumentError, 'specify symbol of existing class as related_with' unless const_defined?(related_class_name)
            self.related_with = options[:related_with]
          end

          self.on = Array.wrap(options[:on])
          self.on = [:create, :update, :destroy] if on.empty?

          options[:only] = Array.wrap(options[:only]).map(&:to_s)
          options[:except] = Array.wrap(options[:except]).map(&:to_s)
          options[:max_audits] = Integer(options[:max_audits]).abs if options[:max_audits]
        end
      end
    end

    module RevisioningClassMethods
      def table_exists!(table_name, contracted = nil)
        return if ARGV.present? # ARGV is empty when rails s[erver] or rails c[onsole]
        unless ActiveRecord::Base.connection.table_exists?(table_name)
          message = "#{table_name} table not created. run `rails generate revisioning:revision"
          message << " #{contracted.to_s}" unless contracted.nil?
          message << " && rails db:migrate"
          #raise ::Revisioning::TableNotCreatedError, message
        end
      end
    end

    module RevisioningInstanceMethods
      def revision_create
        write_revision(behavior: 'create', revision_changes: audited_attributes, comment: audit_comment)
      end

      def revision_update
        unless (changes = revision_changes).empty? && audit_comment.blank?
          write_revision(behavior: 'update', revision_changes: changes, comment: audit_comment)
        end
      end

      def revision_destroy
        write_revision(behavior: 'destroy', revision_changes: audited_attributes, comment: audit_comment) unless new_record?
      end

      def write_revision(attrs)
        attrs[:related] = send(related_with) unless related_with.nil?
        self.audit_comment = nil

        if auditing_enabled
          run_callbacks(:audit) {
            audit = revisions.create(attrs)
            combine_audits_if_needed if attrs[:action] != 'create'
            audit
          }
        end
      end
    end
  end
end
