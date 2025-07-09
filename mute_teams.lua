-- Define the target application name
local teamsAppName = "Microsoft Teams"

-- Define the function that will be triggered by the hotkey
local function toggleTeamsMute()
  -- Find the application object for Microsoft Teams
  local teamsApp = hs.application.find(teamsAppName)

  -- Check if the application is running
  if teamsApp then
    -- Get all windows belonging to the Teams application
    local allWindows = teamsApp:allWindows()

    -- If there is more than 1 window, we assume a meeting is active.
    -- The main window is always present, a second one is the call/meeting.
    if #allWindows > 1 then
      -- Send the mute/unmute shortcut to the application
      hs.eventtap.keyStroke({"cmd", "shift"}, "M", 0, teamsApp)
      hs.alert.show("Toggled Teams Mute (Meeting)")
    else
      -- Only the main window was found, so no meeting is active
      hs.alert.show("No active Teams meeting found")
    end
  else
    -- If Teams isn't running, show an alert
    hs.alert.show("Microsoft Teams is not running")
  end
end

-- Bind the F10 key to trigger our function
hs.hotkey.bind({}, "F10", toggleTeamsMute)

-- Optional: Add a message to the Hammerspoon console when the script loads
-- hs.alert.show("Teams Mute script loaded")


-- -- Define the target application name
-- local teamsAppName = "Microsoft Teams"

-- -- Define the function that will be triggered by the hotkey
-- local function toggleTeamsMute()
--   -- Find the application object for Microsoft Teams
--   local teamsApp = hs.application.find(teamsAppName)

--   -- Check if the application is running
--   if teamsApp then
--     -- If it's running, create and post the Command+Shift+M key combination directly to the app
--     hs.eventtap.keyStroke({"cmd", "shift"}, "M", 0, teamsApp)
--     hs.alert.show("Toggled Teams Mute")
--   else
--     -- If Teams isn't running, show an alert
--     hs.alert.show("Microsoft Teams is not running")
--   end
-- end

-- -- Bind the F10 key to trigger our function
-- hs.hotkey.deleteAll({""}, "F10")
-- hs.hotkey.bind({}, "F10", toggleTeamsMute)