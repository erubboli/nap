require 'sinatra'

post "/register-queue" do
    listen(params[:queue],params[:url])
end

#TODO: to be implemented
get "/registered-queue" do
    #
end
