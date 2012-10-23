
# Return the HTTP data format from a hash
def queryize(params = {})
  params.map do |key, value|
    if value.is_a? Array
      value.map { |v| URI.encode("#{key}[]=#{v}") }
    else
      URI.encode("#{key}=#{value}")
    end
  end.join('&') unless params.nil?
end

# Change the URL according to the REST schema
def url_for(base_url,msg)
    if msg[:id]
        if base_url.end_with?('/')
            "#{base_url}#{msg[:id]}.json"
        else
            "#{base_url}/#{msg[:id]}.json"
        end
    else
        base_url
    end
end
