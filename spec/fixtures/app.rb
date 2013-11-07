require 'i18n'
require 'padrino'
require 'padrino-response'
require 'adapter/memory' 
require 'toystore'

class Human
	include Toy::Store
	adapter :memory, {}

	attribute :name, String
	attribute :dont_set, String
	validate :dont_set_should_be_blank

	def dont_set_should_be_blank
		unless self[:dont_set].blank?
			errors.add :base, "Don't set that!"
		end
	end
end

class App < Padrino::Application
  register Padrino::Response
  register Padrino::Helpers::TranslationHelpers
  
  controllers :main do
  	get :error, map: '/error' do
			error_resp Human.new, 'Error'
  	end

  	get :success, map: '/success' do
	  	success_resp Human.new name: 'Bob'
	  end

	  get :not_found, map: '/not-found' do
			resp status: :not_found
	  end

	  get :no_content, map: '/no-content' do
	  	resp status: :no_content
	  end

	  post :create, map: '/new' do
	  	@human = Human.create name: 'Bob'
	  	resp @human, location: '/success'
	  end

	  put :fail_update, map: '/fail-update' do
	  	@human = Human.create name: 'Bob'
	  	@human.update_attributes dont_set: 'Cats'
	  	resp @human
	  end

	  post :fail_create, map: '/fail-create' do
	  	@human = Human.create name: 'Bob', dont_set: 'Cats'
	  	resp @human
	  end
  end
end

Padrino.load!
Padrino.mount(App).to('/')
