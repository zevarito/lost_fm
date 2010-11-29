require File.expand_path(File.dirname(__FILE__) + '/../test_helper.rb')

class TrackUnit < Test::Unit::TestCase

  context "Searching Tracks" do

    def setup
      @lfm = LostFM.new("b25b959554ed76058ac220b7b2e0a026", "434343k4j3kj4k3jk4j3kj4k3j4k34k3")

      # @lfm.artist.search(:artist => 'radiohead', :limit => 1)
      url = "http://ws.audioscrobbler.com/2.0/?method=track.search&artist=radiohead&track=airbag&api_key=b25b959554ed76058ac220b7b2e0a026&limit=5&format=json"
        body = <<-EOT
        {"results":{"opensearch:Query":{"#text":"","role":"request","searchTerms":"airbag","startPage":"1"},"opensearch:totalResults":"296","opensearch:startIndex":"0","opensearch:itemsPerPage":"5","trackmatches":{"track":[{"name":"Airbag","artist":"Radiohead","url":"http:\/\/www.last.fm\/music\/Radiohead\/_\/Airbag","streamable":{"#text":"0","fulltrack":"0"},"listeners":"594122","image":[{"#text":"http:\/\/userserve-ak.last.fm\/serve\/34s\/49412849.png","size":"small"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/64s\/49412849.png","size":"medium"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/126\/49412849.png","size":"large"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/300x300\/49412849.png","size":"extralarge"}],"mbid":""},{"name":"Airbag (Live In Berlin)","artist":"Radiohead","url":"http:\/\/www.last.fm\/music\/Radiohead\/_\/Airbag+%28Live+In+Berlin%29","streamable":{"#text":"0","fulltrack":"0"},"listeners":"16226","image":[{"#text":"http:\/\/userserve-ak.last.fm\/serve\/34s\/26032835.jpg","size":"small"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/64s\/26032835.jpg","size":"medium"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/126\/26032835.jpg","size":"large"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/300x300\/26032835.jpg","size":"extralarge"}],"mbid":""},{"name":"Airbag (live)","artist":"Radiohead","url":"http:\/\/www.last.fm\/music\/Radiohead\/_\/Airbag+%28live%29","streamable":{"#text":"0","fulltrack":"0"},"listeners":"5759","mbid":""},{"name":"An Airbag Saved My Life (Early)","artist":"Radiohead","url":"http:\/\/www.last.fm\/music\/Radiohead\/_\/An+Airbag+Saved+My+Life+%28Early%29","streamable":{"#text":"0","fulltrack":"0"},"listeners":"2464","image":[{"#text":"http:\/\/userserve-ak.last.fm\/serve\/34s\/3993687.png","size":"small"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/64s\/3993687.png","size":"medium"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/126\/3993687.png","size":"large"},{"#text":"http:\/\/userserve-ak.last.fm\/serve\/300x300\/3993687.png","size":"extralarge"}],"mbid":""},{"name":"01 - airbag","artist":"Radiohead","url":"http:\/\/www.last.fm\/music\/+noredirect\/Radiohead\/_\/01+-+airbag","streamable":{"#text":"0","fulltrack":"0"},"listeners":"1649","mbid":""}]},"@attr":{"for":"airbag"}}}
          EOT
        FakeWeb.register_uri(:get, url, :body => body)
      end

      test "Search for a track scoped by artist" do
        tracks = @lfm.track.search(:artist => "radiohead", :track => "airbag", :limit => 5)
        assert_equal "Airbag", tracks.first.name
        assert_equal 5, tracks.size
      end
    end
  end
