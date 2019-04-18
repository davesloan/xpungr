# frozen_string_literal: true

require 'rails/generators/base'

module Xpungr
  class ArchiveGenerator < Rails::Generators::NamedBase
    def create_archive
      create_file "app/models/archived/#{file_name}.rb" do <<-RUBY.strip_indent
        # frozen_string_literal: true

        module Archived
          class #{file_name.camelize}
            include Mongoid::Document
            include Mongoid::Attributes::Dynamic

            field :pid, type: Integer, as: :primary_id

            index({ pid: 1 }, { background: true })
          end
        end
        RUBY
      end
    end
  end
end
