# frozen_string_literal: true

MinimalModalTest::Engine.routes.draw do
  get "/examples" => "examples#index"
  # define routes here
end

Discourse::Application.routes.draw { mount ::MinimalModalTest::Engine, at: "minimal-modal-test" }
