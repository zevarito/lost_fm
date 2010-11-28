require File.expand_path(File.dirname(__FILE__) + '/../test_helper.rb')

class ErrorHandlingUnit < Test::Unit::TestCase

  context "Error Handling" do
    def setup
      @lfm = LostFM.new("b25b959554ed76058ac220b7b2e0a026", "434343k4j3kj4k3jk4j3kj4k3j4k34k3")
    end

    test "Unknown Error Code" do
      url = "http://ws.audioscrobbler.com/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&method=artist.search&limit=2&format=json"
      body = %( {"error":622,"message":"This Exception doesn't exist"} )
      FakeWeb.register_uri(:get, url, :body => body)

      @lfm = LostFM.new("b25b959554ed76058ac220b7b2e0a026", "434343k4j3kj4k3jk4j3kj4k3j4k34k3")
      assert_raise LostFM::Exception do
        @lfm.artist.search(:limit => 2)
      end
    end

    test "2 : Invalid service -This service does not exist" do
    end

    test "3 : Invalid Method - No method with that name in this package" do
    end

    test "4 : Authentication Failed - You do not have permissions to access the service" do
    end

    test "5 : Invalid format - This service doesn't exist in that format" do
    end

    test "6 : Invalid parameters - Your request is missing a required parameter" do
      url = "http://ws.audioscrobbler.com/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&method=artist.search&limit=1&format=json"
      body = %( {"error":6,"message":"You must supply either an artist name or a musicbrainz id"} )
      FakeWeb.register_uri(:get, url, :body => body)

      @lfm = LostFM.new("b25b959554ed76058ac220b7b2e0a026", "434343k4j3kj4k3jk4j3kj4k3j4k34k3")
      assert_raise LostFM::InvalidParameters do
        @lfm.artist.search(:limit => 1)
      end
    end

    test "7 : Invalid resource specified" do
    end

    test "9 : Invalid session key - Please re-authenticate" do
    end

    test "10 : Invalid API key - You must be granted a valid key by last.fm" do
    end

    test "11 : Service Offline - This service is temporarily offline. Try again later." do
    end

    test "13 : Invalid method signature supplied" do
    end

    test "26 : Suspended API key - Access for your account has been suspended, please contact Last.fm" do
    end

  end
end
