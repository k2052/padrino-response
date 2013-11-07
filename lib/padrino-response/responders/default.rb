module Padrino
  module Responders
    class ResponderError < RuntimeError
    end
    class Default
      include Padrino::Response::StatusCodes
      attr_accessor :options, :object, :class

      def initialize
        @options = {}
      end
      
      # Jsend format?
      def jsend?
        return false
      end

      def respond
       set_status

        if self.class.request.put?
          put
        elsif self.class.request.post?
          post
        elsif self.class.request.delete?
          delete
        else
          default
        end
      end

      def put_or_post(message_type, error_detour)
        message = message(message_type)

        if valid?
          if location
            if api_request
              content = try_render
              redirect location, content
            else
              notify(:notice, message)
              redirect location
            end
          end
        else
          set_status 400
          if api_request
            return object.errors.to_json
          else
            notify(:error, message)
            try_render error_detour
          end
        end
      end

      def put
        put_or_post :update, 'edit'
      end

      def post
        put_or_post :create, 'new'
      end

      def delete
        message = message(:destroy)

        if location
          if api_request
            redirect location, {:message => message}.to_json
          else
            notify(:notice, message)
            redirect location
          end
        else
          try_render
        end
      end

      def default
        if location
          redirect location
        else
          try_render
        end
      end

      def message(type)
        return @options[:message]         if @options[:message]
        return @options[:error_message]   if @options[:error_message] and !valid
        return @options[:success_message] if @options[:success_message] and valid
  
        return object.errors.full_messages if !valid?

        object_notice      = "responder.messages.#{controller_name}.#{type}"
        alternative_notice = "responder.messages.default.#{type}"

        object_notice      = I18n.translate(object_notice, :model => human_model_name)
        alternative_notice = I18n.translate(alternative_notice, :model => human_model_name)

        return object_notice      unless object_notice.blank?
        return alternative_notice unless alternative_notice.blank?

        return 'No message found in locale'
      end

      def valid?
        valid = true
        # `valid?` method may override existing errors, so check for those first
        valid &&= object.valid? if object.respond_to?(:valid?)
        valid &&= (object.errors.count == 0) if object.respond_to?(:errors)
        return valid
      end

      def request
        self.class.request
      end

      def notify(kind, message, *args, &block)
        self.class.notify(kind, message, *args, &block)
      end

      def try_render(detour_name=nil)
        self.class.try_render(object, detour_name, self)
      end

      def redirect(*args)
        self.class.redirect(*args)
      end

      def api_request
        self.class.api_request
      end

      def human_model_name
        self.class.human_model_name(object)
      end

      def controller_name
        self.class.controller_name
      end

      def action_name
        self.class.action_name
      end

      def location
        @options[:location]
      end  
      
      def layout
        return @options[:layout] if @options.include?(:layout)   
      end

      def set_status(status=nil)
        if status.is_a?(Integer)
          self.class.status status
        elsif status.is_a?(String)
          self.class.status SYMBOL_TO_STATUS_CODE[status]
        else
          self.class.status SYMBOL_TO_STATUS_CODE[@options[:status]] if @options[:status]
        end
      end
    end
  end
end