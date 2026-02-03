-- Saints Row: The Third (Classic)
-- Downed on Q + Team Revive
-- NOTE: API calls are based on common SR3 Lua scripting patterns and may need
--       adaptation to your specific scripting loader.

local MOD = {}

local DOWNED_HEALTH = 1
local REVIVE_SEARCH_RADIUS = 40.0

local function get_player()
  return SR3.GetPlayer()
end

local function is_downed(ped)
  return SR3.Ped.IsIncapacitated(ped)
end

local function set_downed_state(ped)
  SR3.Ped.SetHealth(ped, DOWNED_HEALTH)
  SR3.Ped.EnterIncapacitatedState(ped)
end

local function get_teammate_bots(player)
  local team = SR3.Ped.GetTeam(player)
  local nearby = SR3.World.GetPedsInRadius(SR3.Ped.GetPosition(player), REVIVE_SEARCH_RADIUS)
  local teammates = {}

  for _, ped in ipairs(nearby) do
    if ped ~= player
      and SR3.Ped.IsAlive(ped)
      and SR3.Ped.GetTeam(ped) == team
      and SR3.Ped.IsAIControlled(ped) then
      table.insert(teammates, ped)
    end
  end

  return teammates
end

local function pick_closest(player, peds)
  local player_pos = SR3.Ped.GetPosition(player)
  local closest = nil
  local closest_dist = math.huge

  for _, ped in ipairs(peds) do
    local dist = SR3.Math.Distance(player_pos, SR3.Ped.GetPosition(ped))
    if dist < closest_dist then
      closest = ped
      closest_dist = dist
    end
  end

  return closest
end

local function order_revive(player)
  local teammates = get_teammate_bots(player)
  local helper = pick_closest(player, teammates)

  if helper ~= nil then
    SR3.AI.TaskRevive(helper, player)
  end
end

local function on_q_pressed()
  local player = get_player()
  if player == nil then
    return
  end

  if not is_downed(player) then
    set_downed_state(player)
    order_revive(player)
  end
end

function MOD.init()
  SR3.Input.BindKey("Q", on_q_pressed)
end

return MOD
