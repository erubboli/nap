require 'torquebox'
require 'faraday'
require 'multi_json'
require 'pry'

# Start a new thread that listen from hornetq
# and bridge the message to the REST endpoint
def listen(q,base_url)
    logger = TorqueBox::Logger.new
    logger.info "listen for #{q} redirect to #{base_url}"

    Thread.new do
        queue = TorqueBox::Messaging::Queue.start("/queues/#{q}", durable: false)

        loop do
            queue.receive_and_publish do |msg|
                method = (msg[:method] || 'GET').downcase.to_sym
                data = queryize(msg[:params])
                url = url_for(base_url, msg)
                conn = Faraday.new(:url => url)
                set_json = lambda { |req| req.headers['Accept'] = 'application/json' }
                response = if data.nil? || data == ''
                    conn.send(method,url,&set_json)
                else
                    conn.send(method,url,data,&set_json)
                end
                [200,nil,response.env[:body]]
            end
        end

    end
end
