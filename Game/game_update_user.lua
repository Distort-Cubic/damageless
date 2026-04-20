-- In is intended that a modder override this file.
-- Called during a regular (non discrete) update.
-- This is called once per frame.
function p.update()
    -- more!!!
end

-- When the game is paused,
-- such as when in a menu.
function p.update_passive()
    -- more!!!
end

-- Gets called first during a (discrete) update cycle.
-- The the engine performs its own discrete update.
-- Then the update_discrete_post function gets called
-- There are 25 discrete updates per second.
function p.update_discrete_pre()
    -- more!!!
end

-- See function "p.update_discrete_pre".
function p.update_discrete_post()
    if (not ga_get_b("damageless.warning")) then
        ga_window_push("win_warning")
        return
    end
    if (ga_get_b("damageless.enabled")) then
        ga_set_i("xar.player.armor.regen_level", 0)
        ga_set_i("xar.player.health.regen_level", 0)
        ga_set_i("xar.player.health.extra_regen_level", 0)
        ga_set_i("xar.player.health.level", 0)
        if (ga_get_i("xar.player.gold.amount") > 200) then
            ga_set_i("xar.player.gold.amount", 1000000)
        end
        if (ga_get_sys_i("stats.in_dps_count") > 0) then
            ga_kill_player()
        end
        -- make sure i check for caps. 
        -- max signed integer
        local MAX = 9223372036854775807
        -- a reasonable max that probably wont crash the game? use for speed level if needed. 
        local imax = 300000000
        -- debug kinda 
        -- 2070933 is safe, but 2070934 ?
        local rmax = ga_get_i("damageless.empr")
        -- 0-9
        local max_ammo_regen_level = {nil, imax, nil, nil, nil, nil, nil, nil, nil, nil}
        local max_ammo_level = {imax, imax, imax, imax, imax, imax, imax, imax, imax, imax}
        local max_damage_level = {imax, imax, imax, imax, imax, imax, imax, imax, imax, imax}
        local max_fire_period_level = {nil, 16, 12, nil, 16, 56, 26, 14, nil, nil}
        local max_speed_level = {imax, 46, 11, nil, imax, 46, 100, nil, nil, imax}
        local max_freeze_time_level = {nil, nil, nil, 36, nil, nil, nil, nil, imax, nil}
        local max_radius_level = {nil, nil, nil, nil, 28, nil, nil, nil, rmax, imax}
        local max_num_level = {nil, nil, 8, imax, nil, nil, 10, nil, nil, nil}
        -- helper: only upgrade if player actually has it
        local function apply_if_owned(path, max)
            if max ~= nil then
                local cur = ga_get_i(path)
                if cur > 0 then
                    ga_set_i(path, max)
                    return true
                end
            end
        end

        for i = 1, 10 do
            local j = i - 1
            local base = "xar.player.gun" .. j .. "."

            -- FIRST PASS: apply rule "if > 0 → max"
            apply_if_owned(base .. "ammo_regen_level", max_ammo_regen_level[i])
            apply_if_owned(base .. "ammo_level", max_ammo_level[i])
            apply_if_owned(base .. "damage_level", max_damage_level[i])
            apply_if_owned(base .. "fire_period_level", max_fire_period_level[i])
            apply_if_owned(base .. "speed_level", max_speed_level[i])
            apply_if_owned(base .. "freeze_time_level", max_freeze_time_level[i])
            apply_if_owned(base .. "radius_level", max_radius_level[i])
            apply_if_owned(base .. "num_level", max_num_level[i])

            -- (this is where you customize behavior per gun)
            -- helper: force a stat to max if it exists
            local function force(path, max)
                if max ~= nil then
                    ga_set_i(path, max)
                end
            end

            if j == 1 then
                if ga_get_i(base .. "fire_period_level") > 0 or ga_get_i(base .. "speed_level") > 0 then

                    force(base .. "ammo_level", max_ammo_level[i])
                    force(base .. "ammo_regen_level", max_ammo_regen_level[i])
                    force(base .. "damage_level", max_damage_level[i])
                end
            end

            if j == 2 then
                if ga_get_i(base .. "fire_period_level") > 0 or ga_get_i(base .. "speed_level") > 0 or
                    ga_get_i(base .. "num_level") > 0 then

                    force(base .. "ammo_level", max_ammo_level[i])
                    force(base .. "damage_level", max_damage_level[i])
                end
            end

            if j == 3 then
                if ga_get_i(base .. "freeze_time_level") > 0 then
                    force(base .. "ammo_level", max_ammo_level[i])
                    force(base .. "damage_level", max_damage_level[i])
                end
            end

            if j == 4 then
                if ga_get_i(base .. "fire_period_level") > 0 or ga_get_i(base .. "radius_level") > 0 then

                    force(base .. "ammo_level", max_ammo_level[i])
                    force(base .. "damage_level", max_damage_level[i])
                    force(base .. "speed_level", max_speed_level[i])
                end
            end

            if j == 5 then
                if ga_get_i(base .. "fire_period_level") > 0 or ga_get_i(base .. "speed_level") > 0 then

                    force(base .. "ammo_level", max_ammo_level[i])
                    force(base .. "damage_level", max_damage_level[i])
                end
            end

            if j == 6 then
                local has_fire = ga_get_i(base .. "fire_period_level") > 0
                local has_speed = ga_get_i(base .. "speed_level") > 0
                local has_num = ga_get_i(base .. "num_level") > 0

                -- fire rate OR num → ammo + damage
                if has_fire or has_num then
                    force(base .. "ammo_level", max_ammo_level[i])
                    force(base .. "damage_level", max_damage_level[i])
                end

                -- speed → damage ONLY
                if has_speed then
                    force(base .. "damage_level", max_damage_level[i])
                end
            end

            if j == 7 then
                if ga_get_i(base .. "fire_period_level") > 0 then
                    force(base .. "ammo_level", max_ammo_level[i])
                    force(base .. "damage_level", max_damage_level[i])
                end
            end
        end
    end
end
