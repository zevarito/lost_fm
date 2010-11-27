require File.expand_path(File.dirname(__FILE__) + '/../test_helper.rb')

class ArtistsUnit < Test::Unit::TestCase

  context "Searching Authors" do

    def setup
      @lfm = LastFM.new("b25b959554ed76058ac220b7b2e0a026", "434343k4j3kj4k3jk4j3kj4k3j4k34k3")

      # @lfm.artist.search(:artist => 'radiohead', :limit => 1)
      url = "http://ws.audioscrobbler.com/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&method=artist.search&artist=radiohead&limit=1"
      body = <<-EOT
        <?xml version="1.0" encoding="utf-8"?>
        <lfm status="ok">
          <results for="radiohead" xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/">
            <opensearch:Query role="request" searchTerms="radiohead" startPage="1" />
            <opensearch:totalResults>1265</opensearch:totalResults>
            <opensearch:startIndex>0</opensearch:startIndex>
            <opensearch:itemsPerPage>1</opensearch:itemsPerPage>
            <artistmatches>
              <artist>
                <name>Radiohead</name>
                <listeners>3022847</listeners>
                <mbid>a74b1b7f-71a5-4011-9441-d0b5e4122711</mbid>
                <url>http://www.last.fm/music/Radiohead</url>
                <streamable>1</streamable>
                <image size="small">http://userserve-ak.last.fm/serve/34/24256385.png</image>
                <image size="medium">http://userserve-ak.last.fm/serve/64/24256385.png</image>
                <image size="large">http://userserve-ak.last.fm/serve/126/24256385.png</image>
                <image size="extralarge">http://userserve-ak.last.fm/serve/252/24256385.png</image>
                <image size="mega">http://userserve-ak.last.fm/serve/500/24256385/Radiohead.png</image>
              </artist>
            </artistmatches>
          </results>
        </lfm>
      EOT
      FakeWeb.register_uri(:get, url, :body => body)


      # @lfm.artist.search(:artist => 'radiohead', :limit => 2)
      url = "http://ws.audioscrobbler.com/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&method=artist.search&artist=radiohead&limit=2"
      body = <<-EOT
        <?xml version="1.0" encoding="utf-8"?>
        <lfm status="ok">
          <results for="radiohead" xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/">
            <opensearch:Query role="request" searchTerms="radiohead" startPage="1" />
            <opensearch:totalResults>1265</opensearch:totalResults>
            <opensearch:startIndex>0</opensearch:startIndex>
            <opensearch:itemsPerPage>1</opensearch:itemsPerPage>
            <artistmatches>
              <artist>
                <name>Radiohead</name>
                <listeners>3022847</listeners>
                <mbid>a74b1b7f-71a5-4011-9441-d0b5e4122711</mbid>
                <url>http://www.last.fm/music/Radiohead</url>
                <streamable>1</streamable>
                <image size="small">http://userserve-ak.last.fm/serve/34/24256385.png</image>
                <image size="medium">http://userserve-ak.last.fm/serve/64/24256385.png</image>
                <image size="large">http://userserve-ak.last.fm/serve/126/24256385.png</image>
                <image size="extralarge">http://userserve-ak.last.fm/serve/252/24256385.png</image>
                <image size="mega">http://userserve-ak.last.fm/serve/500/24256385/Radiohead.png</image>
              </artist>
              <artist>
                <name>Pearl Jam</name>
                <listeners>3022847</listeners>
                <mbid>a74b1b7f-71a5-4011-9441-d0b5e4122711</mbid>
                <url>http://www.last.fm/music/Radiohead</url>
                <streamable>1</streamable>
                <image size="small">http://userserve-ak.last.fm/serve/34/24256385.png</image>
                <image size="medium">http://userserve-ak.last.fm/serve/64/24256385.png</image>
                <image size="large">http://userserve-ak.last.fm/serve/126/24256385.png</image>
                <image size="extralarge">http://userserve-ak.last.fm/serve/252/24256385.png</image>
                <image size="mega">http://userserve-ak.last.fm/serve/500/24256385/Radiohead.png</image>
              </artist>
            </artistmatches>
          </results>
        </lfm>
      EOT
      FakeWeb.register_uri(:get, url, :body => body)

      # @lfm.artist.search(:artist => "dsd3i43jijffdfd", :limit => 5)
      url = "http://ws.audioscrobbler.com/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&method=artist.search&artist=dsd3i43jijffdfd&limit=5"
      body = <<-EOT
      <?xml version="1.0" encoding="utf-8"?>
        <lfm status="ok">
        <results for="dsd3i43jijffdfd" xmlns:opensearch="http://a9.com/-/spec/opensearch/1.1/">
          <opensearch:Query role="request" searchTerms="dsd3i43jijffdfd" startPage="1" />
          <opensearch:totalResults>0</opensearch:totalResults>
          <opensearch:startIndex>0</opensearch:startIndex>
          <opensearch:itemsPerPage>2</opensearch:itemsPerPage>
          <artistmatches></artistmatches>
        </results>
      </lfm>
      EOT
      FakeWeb.register_uri(:get, url, :body => body)

    end

    test "Search one artist with limit 1" do
      artists = @lfm.artist.search(:artist => 'radiohead', :limit => 1)
      assert_equal "Radiohead", artists.first.name
      assert_equal 1, artists.size
    end

    test "Search one artist with limit 2" do
      artists = @lfm.artist.search(:artist => 'radiohead', :limit => 2)
      assert_equal "Radiohead", artists.first.name
      assert_equal "Pearl Jam", artists.last.name
      assert_equal 2, artists.size
    end

    test "Search for a query without results" do
      assert_equal 0, @lfm.artist.search(:artist => "dsd3i43jijffdfd", :limit => 5).size
    end
  end
end
