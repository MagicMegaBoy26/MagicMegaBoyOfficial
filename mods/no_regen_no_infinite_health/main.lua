-- Saints Row: The Third (Classic)
-- Disable Regen + Infinite Health
-- NOTE: API calls are based on common SR3 Lua scripting patterns and may need
--       adaptation to your specific scripting loader.

local MOD = {}

local function get_player()
  return SR3.GetPlayer()
end

local function disable_regen(player)
  SR3.Ped.SetHealthRegenEnabled(player, false)
  SR3.Ped.SetHealthRegenRate(player, 0)
end

local function disable_infinite_health(player)
  SR3.Ped.SetInvulnerable(player, false)
  SR3.Ped.SetDamageMultiplier(player, 1.0)
end

local function enforce_damageable()
  local player = get_player()
  if player == nil then
    return
  end

  disable_regen(player)
  disable_infinite_health(player)
end

function MOD.init()
  enforce_damageable()
  SR3.Events.OnTick(enforce_damageable)
end

return MOD
