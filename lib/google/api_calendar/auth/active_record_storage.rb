module Google
  class APIClient
    ##
    # Represents cached OAuth 2 tokens stored on local disk in a
    # JSON serialized file. Meant to resemble the serialized format
    # http://google-api-python-client.googlecode.com/hg/docs/epy/oauth2client.file.Storage-class.html
    #
    class ActiveRecordStorage
      # @return [ActiveRecord::Base] Active record base model
      attr_accessor :model

      # @return [Signet::OAuth2::Client]
      attr_reader :authorization

      ##
      # Initializes the User object.
      #
      # @param [User] path
      #    Path to the credentials file.
      def initialize(model)
        @model = model
        self.load_credentials
      end


      def credentials
        # { "access_token" : "ya29.gACaavUttuRFVNzPZznw9SJp-SWIKd0lUG5lahGzTHOrjv4n2a2W4tOM",
        #     "authorization_uri" : "https://accounts.google.com/o/oauth2/auth",
        #     "client_id" : "166324685174-7ja8dnu2q2qd8o2ono985f5paqvi7ghr.apps.googleusercontent.com",
        #     "client_secret" : "zteUmmReRDLJPtR5lpa860mF",
        #     "expires_in" : 3600,
        #     "issued_at" : 1410729934,
        #     "refresh_token" : "1/0Ld4JimtogGzpBI_Nb-sXly4f9cJKqTalzcpwu65Ork",
        #     "token_credential_uri" : "https://accounts.google.com/o/oauth2/token"
        # }
        {
          access_token: @model.access_token,
          refresh_token: @model.refresh_token
        }
      end

      ##
      # Attempt to read in credentials from the specified file.
      def load_credentials
        @authorization = Signet::OAuth2::Client.new(credentials)
        @authorization.issued_at = Time.at(credentials['issued_at'])
        if @authorization.expired?
          @authorization.fetch_access_token!
          self.write_credentials
        end
      end

      ##
      # Write the credentials to the specified file.
      #
      # @param [Signet::OAuth2::Client] authorization
      #    Optional authorization instance. If not provided, the authorization
      #    already associated with this instance will be written.
      def write_credentials(authorization=nil)
        @authorization = authorization unless authorization.nil?

        unless @authorization.refresh_token.nil?
          hash = {}
          %w'access_token
           authorization_uri
           client_id
           client_secret
           expires_in
           refresh_token
           token_credential_uri'.each do |var|
            hash[var] = @authorization.instance_variable_get("@#{var}")
          end
          hash['issued_at'] = @authorization.issued_at.to_i

          File.open(self.path, 'w', 0600) do |file|
            file.write(hash.to_json)
          end
        end
      end
    end
  end
end