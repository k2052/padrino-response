require "padrino-response/version"   
require "padrino/helpers/response"

module Padrino
  module Response
    class << self
       def registered(app)
         app.helpers Padrino::Helpers::ResponseHelpers
       end
       alias :included :registered
     end
  end
end
