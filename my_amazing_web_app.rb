require 'twilio-ruby'
require 'sinatra'
require 'rack-flash'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
  erb :index
end

post '/submit' do
  @message = "Someone thought your image was #{params[:answer]}"
  
  # Change these to match your Twilio account settings 
  @account_sid = "AC90ac63932da17a7495ae86ce14a10f8a"
  @auth_token = "f032751ec043326954be6d67b3b09a2d"
  
  # Set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    
  @account = @client.account
  @sms = @account.sms.messages.create({
    :from => '+441173251793', 
    :to => '+447867986492',
    :body => @message
  })
  
  flash[:notice] = "SMS sent: #{@message}"
  redirect '/'
end
