require File.expand_path(File.dirname(__FILE__) + '/../test_helper.rb')

class ArtistsUnit < Test::Unit::TestCase

  def setup
    @lfm = LastFM.new("b25b959554ed76058ac220b7b2e0a026", "434343k4j3kj4k3jk4j3kj4k3j4k34k3")
  end

  context "Searching Authors" do
    test "Ask for radiohead" do
      result = @lfm.artist.search(:artist => 'radiohead', :limit => 1)
      assert_equal "Radiohead", result["results"]["artistmatches"]["artist"]["name"]
      assert_equal 1, result["results"]["artistmatches"].size
    end
  end
end
