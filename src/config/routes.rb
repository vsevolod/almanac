# frozen_string_literal: true

Rails.application.routes.draw do
  mount API::Root => '/'
end
