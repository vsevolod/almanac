# frozen_string_literal: true

module Factory
  def create_post
    Post.create(
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph
    )
  end
end

RSpec.configure do |config|
  config.include Factory
end
