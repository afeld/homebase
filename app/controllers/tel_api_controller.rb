class TelApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  UNSUB_KEYWORDS = ['unsub', 'unsubscribe', 'quit', 'stop', 'Stop', 'Quit', 'Unsubscribe', 'Unsub', 'Unsubscribe.', 'Unsub.', 'Stop.', 'Quit.']
  
  
end
