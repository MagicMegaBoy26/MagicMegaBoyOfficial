# MagicMegaBoyOfficial

This repo contains two Saints Row: The Third (Classic) Lua mods.

## Mods

### 1) Downed on Q + Team Revive
**Path:** `mods/downed_on_q_revive`

**Behavior**
- Press **Q** to force the player into the downed (incapacitated) state without dying.
- Nearby bots on the player’s team will attempt to revive the player.

### 2) Disable Regen + Infinite Health
**Path:** `mods/no_regen_no_infinite_health`

**Behavior**
- Disables health regeneration.
- Disables any invulnerability/infinite health so normal damage applies.

## Install/Usage (Generic)
These scripts are written in Lua with common SR3 scripting patterns. Depending on your loader (e.g., a Lua script loader or a mod framework), you may need to adapt the API calls and packaging format.

1. Drop each mod folder into your loader’s mods/scripts directory.
2. Ensure the loader points at each mod’s `entry` file (`main.lua`).
3. Launch the game and verify:
   - Pressing **Q** downs the player and prompts a same-team bot revive.
   - Health no longer regenerates and damage applies normally.

## Notes
- If you use a framework with different API names, search/replace the `SR3.*` calls to match your environment.
