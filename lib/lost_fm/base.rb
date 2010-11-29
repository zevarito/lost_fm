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

private

  def config
    @@config
  end

  def api_path
    "http://ws.audioscrobbler.com/2.0/?api_key=#{config[:key]}&"
  end

  def class_name
    self.class.to_s.split("::").last
  end

  def last_fm_query method, params
    "#{api_path}method=#{class_name.downcase}.#{method}&#{URI.escape(params.to_query_params)}&format=json"
  end

  def get uri
    url       = URI.parse(uri)
    response  = Net::HTTP.start(url.host, url.port) {|http| http.get(url.path + "?" + url.query) }

    # avoid parser crash with a string containing a new line only
    result = Hashie::Mash.new JSON.parse(response.body.gsub(/"\n"/, "\"\""))

    check_for_errors!(result)

    reduce_results_complexity(result.results)
  end

  def reduce_results_complexity(results)
    return results if !respond_to?(:collection)

    if results[collection].is_a?(String)
      []
    elsif results[collection].send(class_name.downcase.to_sym).is_a?(Array)
      results[collection].send(class_name.downcase.to_sym)
    else
      [results[collection].send(class_name.downcase)].compact
    end
  end
end

class LostFM::Artist < LostFM
  def initialize; end
  def collection
    "artistmatches"
  end
end

class LostFM::Track < LostFM
  def initialize; end
  def collection
    "trackmatches"
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
class LostFM::User        < LostFM; def initialize; end end
