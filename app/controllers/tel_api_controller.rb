class TelApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  UNSUB_KEYWORDS = ['unsub', 'unsubscribe', 'quit', 'stop', 'Stop', 'Quit', 'Unsubscribe', 'Unsub', 'Unsubscribe.', 'Unsub.', 'Stop.', 'Quit.']
  HELP_TEXT = "help"
  UNSUBSCRIBE_MESSAGE = "You have been unsubscribed. :("
  
  def receive_text
    message_body = params["Body"]
    message_body.strip!
    from_number = params["From"]
    
    user = User.find_or_create_by_phone_number(from_number)
    unsubscribe = check_for_unsubscribe(message_body)
    
  
  def message_unit(unit, message)
    
  end
  
  def message_user(user, message)
    
  end
  
  def get_directory
    
  end
  
  def get_help
    HELP_TEXT
  end
  
  def check_for_unsubscribe(body)
    unsubscribe = false
    UNSUB_KEYWORDS.each do |kw|
      if body == '#' + kw
         unsubscribe = true
      end
    end
    return unsubscribe
  end
  
end
