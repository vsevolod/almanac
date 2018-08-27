# frozen_string_literal: true

require './spec/support/factory'

class FakeData
  include Factory
  extend Dry::Initializer

  option :users_count, default: -> { 100 }
  option :posts_count, default: -> { 200_000 }
  option :ips_count,   default: -> { 50 }
  option :ips,         default: -> { [] }

  attr_reader :ips

  private

  def seed_ips(count)
    for_positive(count) do
      @ips = Array.new(count) { Faker::Internet.ip_v4_address }
    end
  end

  def for_positive(arg)
    return if arg <= 0

    yield
  end
end

class FakeDatabaseData < FakeData
  option :users,       default: -> { [] }

  attr_reader :users


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

class FakeCurlData < FakeData
  API_URI = 'http://almanac_api_1:3000/api/v1'
  HEADERS = '-H  "accept: application/json" -H  "Content-Type: application/json"'

  option :marks_count, default: -> { 50_000 }
  option :logins,      default: -> { [] }

  attr_reader :logins

  def seed
    seed_logins(users_count - User.count)
    seed_ips(ips_count)
    seed_posts(posts_count - Post.count)
    seed_marks(marks_count - Mark.count)
  end

  private

  def seed_logins(count)
    for_positive(count) do
      @logins = Array.new(count) { character }
    end
  end

  def seed_posts(count)
    threads_count = 4

    for_positive(count) do
      (count / threads_count).times do
        Array.new(threads_count) do
          Thread.new { create_custom_post }
        end.join(&:each)
      end
    end
  end

  def seed_marks(count)
    threads_count = 2

    for_positive(count) do
      (count / threads_count).times do
        post_ids = Post.order('RANDOM()').limit(threads_count).pluck('id')

        Array.new(threads_count) do |index|
          post_id = post_ids[index]
          Thread.new { evaluate_random_post(post_id) }
        end.join(&:each)
      end
    end
  end

  def create_custom_post
    url = "#{API_URI}/posts"

    attributes = {
      title: Faker::Lorem.sentence,
      content: Faker::Lorem.paragraph,
      user: {
        login: logins.sample,
        ip: ips.sample
      }
    }

    system("curl -X PUT '#{url}' #{HEADERS} -d '#{attributes.to_json}'")
  end

  def evaluate_random_post(post_id)
    url = "#{API_URI}/posts/#{post_id}/evaluate"

    attributes = { value: SecureRandom.rand(4) + 1 }

    system("curl -X POST '#{url}' #{HEADERS} -d '#{attributes.to_json}'")
  end
end


FakeDatabaseData.new.seed if ENV['DB_SEED']
FakeCurlData.new.seed if ENV['CURL_SEED']
