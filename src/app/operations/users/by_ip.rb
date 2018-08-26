# frozen_string_literal: true

module Operations
  module Users
    module ByIP
      module_function

      def call
        ActiveRecord::Base.connection.execute(sql_query).to_a
      end

      def sql_query
        user_ids_with_ips = <<-SQL
          SELECT user_ip, user_id
            FROM posts
           WHERE posts.user_id IS NOT NULL
        GROUP BY user_ip, user_id
        SQL

        <<-QUERY
            SELECT user_ids_with_ips.user_ip, array_to_json(array_agg(users.login)) as logins
              FROM (#{user_ids_with_ips}) as user_ids_with_ips
        INNER JOIN users ON users.id = user_ids_with_ips.user_id
          GROUP BY user_ids_with_ips.user_ip
          HAVING count(*) > 1
        QUERY
      end
    end
  end
end
