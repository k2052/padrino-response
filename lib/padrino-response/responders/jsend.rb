module Padrino
  module Responders
    class Jsend < Default
      include Padrino::Response::StatusCodes
      attr_accessor :options, :object, :class

      def initialize
        @options = {}
      end

      def jsend?
        return true
      end

      def put_or_post(message_type, error_detour)
        message = message( message_type )
        if valid?
          if request.xhr?
            ajax_obj = {
              :status => :success,
              :data => {
                object.class.to_s.singularize.downcase => object
              }
            }
          end
          if location
            if request.xhr?
              ajax_obj[:data][:redirect] = location
              return ajax_obj.to_json
            else
              notify(:notice, message)
              redirect location
            end
          else
            try_render
          end
        else
          if request.xhr?
            ajax_obj = {
              :status => :fail,
              :data => {
                :errors => object.errors
              }
            }
            ajax_obj[:data][:redirect] = location if location
            return ajax_obj.to_json
          else
            notify(:error, message)
            try_render error_detour
          end
        end
      end

      def delete
        message = message(:destroy)

        if request.xhr?
          ajax_obj = {
            :status => :success,
            :data => {
              :message => message
            }
          }
        end

        if location
          if request.xhr?
            ajax_obj[:data][:redirect] = location
            return ajax_obj.to_json
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
          if request.xhr?
            {:status => :success, :data => { :redirect => location } }.to_json
          else
            redirect location
          end
        else
          try_render
        end
      end
    end
  end
end