local password = "exp"

local card = {
  type = "AdaptiveCard",
  version = "1.3",
  body = { {
    type = "Input.Text",
    placeholder = "ضع باسورد السيرفر",
    id = "test"
  }, {
    type = "ActionSet",
    actions = { {
      type = "Action.Submit",
      title = "ارسال",
      style = "positive"
    } }
  } }
}

local attemp = 0

local function OnPlayerConnecting(name, setKickReason, deferrals)
    local player = source
    deferrals.defer()
    -- mandatory wait!
    Wait(0)

    local function callback(data,rawdata)
      if data.test == password then 
        deferrals.done()
      else
        if attemp >= 3 then 
          deferrals.done('انتهت المحاولات لديك')
        else
          attemp = attemp + 1
          deferrals.presentCard(card,callback)
        end
      end
    end


  deferrals.presentCard(card,callback)
    
end

AddEventHandler("playerConnecting", OnPlayerConnecting)