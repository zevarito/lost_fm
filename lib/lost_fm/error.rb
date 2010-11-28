module LostFM::Error

  class LostFM::Exception < Exception; end;

  LASTFM_API_ERRORS = {
    "2"   => "InvalidService",
    "3"   => "InvalidMethod",
    "4"   => "AuthenticationFailed",
    "5"   => "InvalidFormat",
    "6"   => "InvalidParameters",
    "7"   => "InvalidResourceSpecified",
    "9"   => "InvalidSessionKey",
    "10"  => "InvalidApiKey",
    "11"  => "ServiceOffline",
    "13"  => "InvalidMethodSignatureSupplied",
    "26"  => "SuspendedApiKey"
  }

  def self.included(klass)
    define_error_classes
  end

  def self.define_error_classes
    LASTFM_API_ERRORS.each {|_, error_class| eval "class #{error_class} < LostFM::Exception; end;"}
  end

  def check_for_errors!(result)
    raise eval("#{error_class_for(result)}"), "#{error_message_for(result)}" if result.error
  end

  def error_class_for(result)
    LASTFM_API_ERRORS.keys.include?(result.error.to_s) ? "LostFM::" + LASTFM_API_ERRORS[result.error.to_s] : "LostFM::Exception"
  end

  def error_message_for(result)
    result.message.gsub(/^.*\s-\s/, '')
  end
end
