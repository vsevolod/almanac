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
      count.times do
        create_post(
          user_ip: ips.sample,
          user_id: users.sample.id,
          marks_count: SecureRandom.rand(10) + 1,
          average_mark: SecureRandom.rand * 4 + 1
        )
      end
    end
  end

  def for_positive(arg, &block)
    return if arg <= 0

    block.call(block)
  end
end

FakeDatabaseData.new.seed
