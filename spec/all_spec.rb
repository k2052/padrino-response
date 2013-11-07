require File.expand_path(File.dirname(__FILE__) + '/spec_helper.rb')
  
describe 'Main Controller' do
	before do
		header 'Accept', 'application/json'
	end

  it 'should return an error resp' do
  	get '/error'
  	last_response.status.should eq 400
  	resp = MultiJson.load last_response.body
  	resp['success'].should eq false
  	resp['message'].should eq 'Error'
  end
  
  it 'should return a success resp' do
  	get '/success'
  	last_response.status.should eq 200
  	resp = MultiJson.load last_response.body
  	resp['success'].should eq true
  end
 
  it 'should return a 404' do
  	get '/not-found'
		last_response.status.should eq 404
	end

  it 'should return no-content' do
  	get '/no-content'
  	last_response.status.should eq 204
  end

	it 'should create a new human' do
	  post '/new', human: {name: 'Bob'}
		last_response.status.should eq 302
		resp = MultiJson.load last_response.body
		resp['human']['name'].should eq 'Bob'
	end

	it 'should fail to update a human' do
	  put '/fail-update', human: {name: 'Bob'}
		last_response.status.should eq 400
	end

	it 'should fail to create a human' do
	  post '/fail-create', human: {name: 'Bob'}
		last_response.status.should eq 400
	 end
end
