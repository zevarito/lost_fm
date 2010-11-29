class LostFM
  include LostFM::Meta
  include LostFM::Error

  def initialize(key = nil, secret = nil)
    if key.nil? || secret.nil?
      raise "You should provide a key and secret for use the api."
    else
      @@config = {:key => key, :secret => secret}
    end
  end

  def config
    @@config
  end

  def api_path
    "http://ws.audioscrobbler.com/2.0/?api_key=#{config[:key]}&"
  end

  def get uri
    url       = URI.parse(uri)
    req       = Net::HTTP::Get.new(url.path+"?"+url.query)
    response  = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }

    # avoid parser crash with a string containing a new line only
    result = Hashie::Mash.new JSON.parse(response.body.gsub(/"\n"/, "\"\""))

    check_for_errors!(result)

    result
  end

  def last_fm_query method, params
    klass = self.class.to_s.gsub("LostFM::","").downcase
    "#{api_path}method=#{klass}.#{method}&#{URI.escape(params.to_query_params)}&format=json"
  end

  def artist;      @artist           ||= Artist.new      end
  def album;       @track            ||= Album.new       end
  def event;       @event            ||= Event.new       end
  def geo;         @geo              ||= Geo.new         end
  def group;       @group            ||= Group.new       end
  def library;     @library          ||= Library.new     end
  def playlist;    @playlist         ||= Playlist.new    end
  def tag;         @tag              ||= Tag.new         end
  def tastometer;  @tastometer       ||= Tastometer.new  end
  def track;       @track            ||= Track.new       end
  def user;        @user             ||= User.new        end
end

class LostFM::Artist < LostFM
  def initialize; end

  def get(uri)
    results = super(uri).results
    if results.artistmatches.is_a?(String)
      []
    elsif results.artistmatches.artist.is_a?(Array)
      results.artistmatches.artist
    else
      [results.artistmatches.artist].compact
    end
  end
end

class LostFM::Album       < LostFM; def initialize; end end
class LostFM::Event       < LostFM; def initialize; end end
class LostFM::Geo         < LostFM; def initialize; end end
class LostFM::Group       < LostFM; def initialize; end end
class LostFM::Library     < LostFM; def initialize; end end
class LostFM::Playlist    < LostFM; def initialize; end end
class LostFM::Tag         < LostFM; def initialize; end end
class LostFM::Tastometer  < LostFM; def initialize; end end
class LostFM::Track       < LostFM; def initialize; end end
class LostFM::User        < LostFM; def initialize; end end
