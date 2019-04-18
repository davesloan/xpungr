# frozen_string_literal: true

module Xpungr
  module Model
    extend ActiveSupport::Concern

    included do
      def archive!
      end
    end
  end
end
