function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Buy Station"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    for i = 2, 8 do
        local ns = tostring(i)
        local ammo_max = game_wep_modes.get_ammo_max(i)
        ga_set_i("xar.player.gun" .. ns .. ".ammo", ammo_max)
    end
end
