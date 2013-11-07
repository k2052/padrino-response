module Padrino
  module Response
    module Notifiers
      module FlashNotifier
        ##
        # Saves specified message as flash notification with specified type. 
        #
        # ==== Examples
        #
        #   notifier.say(self, :error, "Something went wrong")
        # 
        # ... will save message to <code>flash[:notice]</code>
        #
        def self.say(app, kind, message, *args, &block)
          app.flash[kind.to_sym] = message
        end
      end 
    end
  end 
end 
