# frozen_string_literal: true

module Xpungr
  module Model
    extend ActiveSupport::Concern

    included do
      class_attribute :xpungr_primary_key, :xpungr_archive_to, :xpungr_block_deletes, :xpungr_cascade

      def archive!
        # do some fancy stuff here
      end
    end

    module ClassMethods
      def xpunge(to:, primary_key:, cascade: {}, block_deletes: false)
        self.xpungr_archive_to = to
        self.xpungr_primary_key = primary_key
        self.xpungr_block_deletes = block_deletes
        self.xpungr_cascade = cascade
      end
    end
  end
end
