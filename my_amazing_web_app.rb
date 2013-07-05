require 'twilio-ruby'
require 'sinatra'
# require 'slim'
# require 'sinatra/flash'
require 'pry'
# require 'rack-coffee'
# require 'config.ru'

enable :sessions
set :session_secret, 'super secret'
# set :port, 20773
# use Rack::Flash

get '/' do
  erb :index
end
 
post '/submit' do
  # binding.pry
  if params['answer1'] == '21 million' && params['answer2'] == '2008' && params['answer'] == "1 billion US dollars"
  @message = "#{params[:full_name]} your answers were 1) #{params[:answer1]} 2) #{params[:answer2]} 3)#{params[:answer]} and you scored 100% "
  # binding.pry
  elsif params['answer1'] == '21 million' && params['answer2'] == '2008' && params['answer'] != "1 billion US dollars"
  @message = "#{params[:full_name]} your answers were 1) #{params[:answer1]} 2) #{params[:answer2]} 3)#{params[:answer]} and you scored 66.6% "
  # binding.pry
  elsif params['answer1'] != '21 million' && params['answer2'] == '2008' && params['answer'] == "1 billion US dollars"
  @message = "#{params[:full_name]} your answers were 1) #{params[:answer1]} 2) #{params[:answer2]} 3)#{params[:answer]} and you scored 66.6% "
  # binding.pry
  elsif params['answer1'] == '21 million' && params['answer2'] != '2008' && params['answer'] == "1 billion US dollars"
  @message = "#{params[:full_name]} your answers were 1) #{params[:answer1]} 2) #{params[:answer2]} 3)#{params[:answer]} and you scored 66.6% "
  # binding.pry
  elsif params['answer1'] == '21 million' && params['answer2'] != '2008' && params['answer'] != "1 billion US dollars"
  @message = "#{params[:full_name]} your answers were 1) #{params[:answer1]} 2) #{params[:answer2]} 3)#{params[:answer]} and you scored 33.3% "

  elsif params['answer1'] != '21 million' && params['answer2'] != '2008' && params['answer'] == "1 billion US dollars"
  @message = "#{params[:full_name]} your answers were 1) #{params[:answer1]} 2) #{params[:answer2]} 3)#{params[:answer]} and you scored 33.3% "

  elsif params['answer1'] != '21 million' && params['answer2'] == '2008' && params['answer'] != "1 billion US dollars"
  @message = "#{params[:full_name]} your answers were 1) #{params[:answer1]} 2) #{params[:answer2]} 3)#{params[:answer]} and you scored 33.3% "
  
  else
  @message = 'You scored 0, listen harder next time!'
  end
  # Change these to match your Twilio account settings 
  @account_sid = "AC90ac63932da17a7495ae86ce14a10f8a"
  @auth_token = "f032751ec043326954be6d67b3b09a2d"
  
  # Set up a client to talk to the Twilio REST API
  @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    
  @account = @client.account
  @sms = @account.sms.messages.create({
    :from => '+441173251793', 
    :to => params['phone_number'],
    :body => @message
  })
  
 
  redirect '/'
end
