require 'sinatra/base'

class NapHTTPServer < Sinatra::Application
    post "/register-queue" do
        listen(params[:queue],params[:url])
    end

    #TODO: to be implemented
    get "/registered-queue" do
        #
    end
end
