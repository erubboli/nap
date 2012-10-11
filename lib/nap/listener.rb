require 'torquebox'

# Start a new thread that listen from hornetq
# and bridge the message to the REST endpoint
def listen(q,base_url)

    Thread.new do
        queue = TorqueBox::Messaging::Queue.start("/queues/#{q}", durable: false)
        conn = Faraday.new(:url => base_url)

        loop do
            queue.receive_and_publish do |msg|
                method = (msg[:method] || 'GET').downcase.to_sym
                data = queryize(msg[:params])
                url = url_for(base_url, msg) 
                conn.send(method,url,data)
            end
        end

    end
end
