module Concerns
  module AngelApiListHandler
    extend ActiveSupport::Concern

    module ClassMethods

      def simple_list_handler(method, id, options={}, &block)
        ids = []
        # first page invoke
        options[:access_token] = AngellistApi.access_token
        _array_name = options.delete(:array_name)
        p 'Begin request'
        _response = AngellistApi.send(method, id, options)
        p "End request "
        if block_given?
          yield(_response[_array_name], ids, 1)
        end

        # next pages invoke
        if _response['last_page'].to_i > 1
          (2.._response['last_page']).each do |page_number|
            options[:page] = page_number
            p 'Begin request'
            _response = AngellistApi.send(method, id, options)
            p "End request "
            if block_given?
              yield(_response[_array_name], ids, page_number)
            end
          end
        end
        ids
      end

    end


  end
end