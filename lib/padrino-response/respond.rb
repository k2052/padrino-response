module Padrino
  module Response
    module Respond   
      def respond(*options)  
        if ::Padrino::Responders.constants.include?("#{controller_name.capitalize}")
          responder = ::Padrino::Responders.const_get("#{controller_name.capitalize}").new        
        elsif options.include?(:responder)
          responder = ::Padrino::Responders.const_get("#{options[:responder]}").new
        else
          responder = Padrino::Responders::Default.new
        end
        
        responder.object = options.shift if !options.first.is_a?(Hash)
        options = options.extract_options!
        responder.object = options.delete(:object) if options.include?(:object)
        responder.object ||= {}
        responder.options[:location] = options.shift if options.first.is_a?(String)             
        responder.options.merge!(options)
        responder.class   = self
        return responder.respond    
      end
      alias :resp :respond
    end
  end
end 
