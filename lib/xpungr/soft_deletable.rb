module Xpungr
  module SoftDeletable
    extend ActiveSupport::Concern

    included do
      class_attribute :xpungr_type, :xpungr_toggle_field, :xpungr_archive_table, :xpungr_cascade
      self.xpungr_type = :toggle
      self.xpungr_toggle_field = :expunged
      self.xpungr_archive_table = nil
      self.xpungr_cascade = {}
    end

    module ClassMethods
      def xpungr_via(type = :toggle, **options)
        if type == :toggle
          store_toggle_options(options)
        elsif type == :archive
          store_archive_options(options)
        else
          raise "Invalid xpungr type '#{type}'. Valid: :toggle, :archive"
        end

        store_cascade(options)
        self.xpungr_type = type
      end

      # column
      def store_toggle_options(options)
        if options[:column].present?
          self.xpungr_toggle_field = options[:column]
        else
          raise 'Invalid xpungr options. When :toggle is your type you must define :column as the name of the table column where you store the value indicating if the record is deleted or not.'
        end
      end

      # to
      def store_archive_options(options)
        if options[:to].present?
          self.xpungr_archive_table = options[:to]
        else
          raise 'Invalid xpungr options. When :archive is your type you must define :to as the name of the database table where you want to store the deleted records.'
        end
      end

      def store_cascade(options)
        self.xpungr_cascade = options[:cascade] if options[:cascade].present?
      end
    end
  end
end
