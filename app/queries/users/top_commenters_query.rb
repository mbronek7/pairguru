module Users
  class TopCommentersQuery
    def self.call
      User.joins(:comments)
        .select("users.name AS name, users.id AS id, users.email AS email, count(users.id) AS count")
        .where("comments.created_at >= ?", 1.week.ago)
        .group("id")
        .order("count DESC")
        .limit(10)
    end
  end
end
