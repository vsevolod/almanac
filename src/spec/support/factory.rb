# frozen_string_literal: true

module Factory
  module_function

  def create_post(attributes = {})
    attributes = {
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph
    }.merge(attributes)

    Post.create(attributes)
  end

  def create_user(attributes = {})
    attributes = {
      login: character
    }.merge(attributes)

    User.create(attributes)
  end

  def character
    [Faker::BackToTheFuture,
     Faker::BojackHorseman,
     Faker::BreakingBad,
     Faker::DrWho,
     Faker::DragonBall,
     Faker::DumbAndDumber,
     Faker::Dune,
     Faker::Fallout,
     Faker::FamilyGuy].sample.character
  end
end
