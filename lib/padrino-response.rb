require 'padrino-core'
require 'padrino-gen'

FileSet.glob_require('padrino-response/*.rb', __FILE__)
FileSet.glob_require('padrino-response/{helpers,notifiers,responders}/*.rb', __FILE__)

module Padrino
  ##
  # This component is used to create slim controllers without unnecessery
  # and repetitive code.
  #
  module Response
    ##
    # Method used by Padrino::Application when we register the extension
    #
    class << self
      def registered(app)
        app.enable :sessions
        app.enable :flash
        app.helpers Padrino::Response::Helpers::Controller
        app.helpers Padrino::Response::Helpers::Simple
        app.set :notifier, Padrino::Response::Notifiers::FlashNotifier
        app.send :include, Padrino::Response::Respond
      end
      alias :included :registered
    end
  end
end

##
# Load our Padrino::Response locales
#
I18n.load_path += Dir["#{File.dirname(__FILE__)}/padrino-response/locale/**/*.yml"]

