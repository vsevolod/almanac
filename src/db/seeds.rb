# frozen_string_literal: true

require './spec/support/factory'

class FakeDatabaseData
  include Factory
  extend Dry::Initializer

  option :users_count, default: -> { 100 }
  option :posts_count, default: -> { 200_000 }
  option :ips_count,   default: -> { 50 }
  option :users,       default: -> { [] }
  option :ips,         default: -> { [] }

  attr_reader :users, :ips

  def seed
    ActiveRecord::Base.transaction do
      seed_users(users_count - User.count)
      seed_ips(ips_count)
      seed_posts(posts_count - Post.count)
    end
  end

  private

  def seed_users(count)
    for_positive(count) do
      @users = Array.new(count) { create_user }
    end
  end

  def seed_ips(count)
    for_positive(count) do
      @ips = Array.new(count) { Faker::Internet.ip_v4_address }
    end
  end

  def seed_posts(count)
    for_positive(count) do
      count.times { create_custom_post }
    end
  end

  def for_positive(arg)
    return if arg <= 0

    yield
  end

  def create_custom_post
    attributes = { user_ip: ips.sample, user_id: users.sample.id }

    if lower_than_one < 0.9
      attributes[:marks_count] = SecureRandom.rand(10) + 1
      attributes[:average_mark] = lower_than_one * 4 + 1
    end

    create_post(attributes)
  end

  def lower_than_one
    SecureRandom.rand
  end
end

FakeDatabaseData.new.seed
