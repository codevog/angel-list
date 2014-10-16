module AngellistApi
  class Client
    module Tags

      def get_tag_users(id, options = {})
        get("1/tags/#{id}/users", options)
      end

    end
  end
end
