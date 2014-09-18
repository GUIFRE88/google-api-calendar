module Google
  module APICalendar
    class Client
      attr_reader :api_client, :discovered_api

      def initialize(options = {})
        @api_client = Google::APIClient.new(options)
        @discovered_api = @api_client.discovered_api('calendar', 'v3')
      end

      def calendars
        result = @api_client.execute(api_method: @discovered_api.calendar_list.list)
        Google::Model::Calendar.json_to_calendars(result.data.to_hash['items'])
      end

      def get_calendar(id)
        Google::Model::Calendar
      end
    end
  end
end