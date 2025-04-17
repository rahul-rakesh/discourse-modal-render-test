# frozen_string_literal: true

# name: minimal-modal-test
# about: TODO
# meta_topic_id: TODO
# version: 0.0.1
# authors: Discourse
# url: TODO
# required_version: 2.7.0

enabled_site_setting :minimal_modal_test_enabled

module ::MinimalModalTest
  PLUGIN_NAME = "minimal-modal-test"
end

require_relative "lib/minimal_modal_test/engine"

after_initialize do
  # Code which should run after Rails has finished booting
end
