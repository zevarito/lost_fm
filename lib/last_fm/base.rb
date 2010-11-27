class LastFM
  include LastFM::Meta

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
    begin
      url       = URI.parse(uri)
      req       = Net::HTTP::Get.new(url.path+"?"+url.query)
      response  = Net::HTTP.start(url.host, url.port) {|http| http.request(req) }
      result    = XmlSimple.xml_in(response.body, 'keeproot' => false, 'forcearray' => false)
      Hashie::Mash.new result
    rescue Exception => ex
      puts "Request failed for #{uri}. Exception: #{ex}"
    end
  end

  def last_fm_query method, params
    klass = self.class.to_s.gsub("LastFM::","").downcase
    "#{api_path}method=#{klass}.#{method}&#{params.to_query_params}"
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

class Artist < LastFM
  def initialize; end

  def get(uri)
    result = super(uri)
    result.results.artistmatches.artist.is_a?(Array) ? result.results.artistmatches.artist : [result.results.artistmatches.artist].compact
  end
end
