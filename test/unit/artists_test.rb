require File.expand_path(File.dirname(__FILE__) + '/../test_helper.rb')

class ArtistsUnit < Test::Unit::TestCase

  context "Searching Authors" do

    def setup
      @lfm = LastFM.new("b25b959554ed76058ac220b7b2e0a026", "434343k4j3kj4k3jk4j3kj4k3j4k34k3")

      # @lfm.artist.search(:artist => 'radiohead', :limit => 1)
      url = "http://ws.audioscrobbler.com/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&method=artist.search&artist=radiohead&limit=1&format=json"
      body = <<-EOT
        {
          "results" : {
            "opensearch:Query" : {
              "#text"       : "",
              "role"        : "request",
              "searchTerms" : "radiohead",
              "startPage"   : "1"
            },
            "opensearch:totalResults" : "1265",
            "opensearch:startIndex"   : "0",
            "opensearch:itemsPerPage" : "1",
            "artistmatches" : {
              "artist" : {
                "name"       : "Radiohead",
                "listeners"  : "3022847",
                "mbid"       : "a74b1b7f-71a5-4011-9441-d0b5e4122711",
                "url"        : "http:\/\/www.last.fm\/music\/Radiohead",
                "streamable" : "1",
                "image"      : [
                  { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/34\/8461967.jpg",             "size" : "small" },
                  { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/64\/8461967.jpg",             "size" : "medium" },
                  { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/126\/8461967.jpg",            "size" : "large" },
                  { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/252\/8461967.jpg",            "size" : "extralarge" },
                  { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/500\/8461967\/Radiohead.jpg", "size" : "mega"}
                ]
              }
            },
            "@attr" : {
              "for" : "radiohead"
            }
          }
        }
      EOT
      FakeWeb.register_uri(:get, url, :body => body)


      # @lfm.artist.search(:artist => 'radiohead', :limit => 2)
      url = "http://ws.audioscrobbler.com/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&method=artist.search&artist=radiohead&limit=2&format=json"
      body = <<-EOT
        {
          "results" : {
            "opensearch:Query" : {
              "#text"       : "",
              "role"        : "request",
              "searchTerms" : "radiohead",
              "startPage"   : "1"
            },
            "opensearch:totalResults" : "1265",
            "opensearch:startIndex"   : "0",
            "opensearch:itemsPerPage" : "2",
            "artistmatches" : {
              "artist" : [
                {
                  "name"       : "Radiohead",
                  "listeners"  : "3022847",
                  "mbid"       : "a74b1b7f-71a5-4011-9441-d0b5e4122711",
                  "url"        : "http:\/\/www.last.fm\/music\/Radiohead",
                  "streamable" : "1",
                  "image"      : [
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/34\/8461967.jpg",             "size" : "small" },
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/64\/8461967.jpg",             "size" : "medium" },
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/126\/8461967.jpg",            "size" : "large" },
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/252\/8461967.jpg",            "size" : "extralarge" },
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/500\/8461967\/Radiohead.jpg", "size" : "mega"}
                  ]
                },
                {
                  "name"       : "Pearl Jam",
                  "listeners"  : "3022847",
                  "mbid"       : "a74b1b7f-81a5-4011-9441-d0b5e4122711",
                  "url"        : "http:\/\/www.last.fm\/music\/Radiohead",
                  "streamable" : "1",
                  "image"      : [
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/34\/8461967.jpg",             "size" : "small" },
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/64\/8461967.jpg",             "size" : "medium" },
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/126\/8461967.jpg",            "size" : "large" },
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/252\/8461967.jpg",            "size" : "extralarge" },
                    { "#text" : "http:\/\/userserve-ak.last.fm\/serve\/500\/8461967\/Radiohead.jpg", "size" : "mega"}
                  ]
                }
              ]
            },
            "@attr" : {
              "for" : "radiohead"
            }
          }
        }
      EOT
      FakeWeb.register_uri(:get, url, :body => body)

      # @lfm.artist.search(:artist => "dsd3i43jijffdfd", :limit => 5)
      url = "http://ws.audioscrobbler.com/2.0/?api_key=b25b959554ed76058ac220b7b2e0a026&method=artist.search&artist=dsd3i43jijffdfd&limit=5&format=json"
      body = <<-EOT
        {
          "results" : {
            "opensearch:Query" : {
              "#text"       : "",
              "role"        : "request",
              "searchTerms" : "dsd3i43jijffdfd",
              "startPage"   : "1"
            },
            "opensearch:totalResults" : "0",
            "opensearch:startIndex"   : "0",
            "opensearch:itemsPerPage" : "5",
            "artistmatches"           : "\n",
            "@attr" : {
              "for" : "dsd3i43jijffdfd"
            }
          }
        }
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
