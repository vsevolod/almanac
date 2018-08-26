# frozen_string_literal: true

module Factory
  def create_post(attributes = {})
    attributes = {
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph
    }.merge(attributes)

    Post.create(attributes)
  end
end

RSpec.configure do |config|
  config.include Factory
end
