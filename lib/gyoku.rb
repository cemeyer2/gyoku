require "gyoku/version"
require "gyoku/hash"

module Gyoku

  # Converts a given Hash +key+ with +options+ into an XML tag.
  def self.xml_tag(key, options = {})
    XMLKey.create(key, options)
  end

  # Translates a given +hash+ with +options+ to XML.
  def self.xml(hash, options = {})
    if hash.is_a? ::Array
      key = options.delete(:key)
      key = "item" if key.nil?
      Array.to_xml hash.dup, key, options=options
    elsif hash.is_a? ::Hash
      Hash.to_xml hash.dup, options
    elsif hash.respond_to?(:to_xml)
      hash.to_xml
    else
      hash.to_s
    end
  end

end
