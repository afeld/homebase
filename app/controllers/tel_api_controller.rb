class TelApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  HELP_TEXT = "help\n@all messgages everyone\n@[unit] messages a particular unit\n"
  UNSUBSCRIBE_MESSAGE = "You have been unsubscribed. :("
  
  def receive_text
    message_body = params["Body"].to_s.strip
    from_number = params["From"].to_s
    
    user = User.find_or_create_by_mobile_number(from_number)
    unit = user.unit || user.build_unit

    ix =
      # incomplete registration
      if user.building.nil?
        result = Geocoder.search(message_body).first
        if result
          building = Building.new_from_result(result)
          if building.valid?
            unit.building = building
            user.save!

            puts "building created: #{building.address}"
            Telapi::InboundXml.new do
              Sms(
                "What is your unit number?",
                from: TEL_NUMBER,
                to: from_number
              )
            end
          else
            puts "invalid address"
            Telapi::InboundXml.new do
              Sms(
                "Please enter your full, valid street address.",
                from: TEL_NUMBER,
                to: from_number
              )
            end
          end

        else
          puts "reg. failed"
          Telapi::InboundXml.new do
            Sms(
              "Please respond with your full address, including unit number.",
              from: TEL_NUMBER,
              to: from_number
            )
          end
        end

      elsif user.unit.number.nil?
        unit.number = message_body.sub(/^(#|apt\.?|ste\.?|suite|unit)\s*/i, '')
        unit.save!

        puts "user registered"
        Telapi::InboundXml.new do
          Sms(
            "Registered at ##{unit.number}, #{user.building.address}",
            from: TEL_NUMBER,
            to: from_number
          )
        end

      else # already registered
        case message_body.downcase
        when /^#?(unsub(scribe)?|quit|stop)\.?$/
          # unsubscribe
          user.destroy
          puts "user unsubscribed"
          Telapi::InboundXml.new
        when /^#help|(help$)/
          puts "help requested"
          Telapi::InboundXml.new do
            Sms(
              HELP_TEXT,
              from: TEL_NUMBER,
              to: from_number
            )
          end
        when /^#list|(list$)/
          user.building.list_users
        when /^@all/
          puts "messaging all residents of #{user.building.address}"
          user.building.message_all(message_body, user)
        when /^@(?<unit_number>\S+)/
          # TODO DM unit in building
        else
          # TODO follow-up (all or DM)
          user.message_building message_body
        end
      end

    render text: ix.response
  end
  
  def get_directory
    
  end
  
end
