require 'rubygems'
require 'net/http'
require 'hashie'
require 'json'

class LostFM
  VERSION = '0.0.1'
end

require File.dirname(__FILE__) + '/lost_fm/error'
require File.dirname(__FILE__) + '/lost_fm/meta'
require File.dirname(__FILE__) + '/lost_fm/base'

# File merb/core_ext/hash.rb, line 87
class Hash
  def to_query_params
    params = ''
    stack = []

    each do |k, v|
      if v.is_a?(Hash)
        stack << [k,v]
      else
        params << "#{k}=#{v}&"
      end
    end

    stack.each do |parent, hash|
      hash.each do |k, v|
        if v.is_a?(Hash)
          stack << ["#{parent}[#{k}]", v]
        else
          params << "#{parent}[#{k}]=#{v}&"
        end
      end
    end

    params.chop! # trailing &
    params
  end
end
