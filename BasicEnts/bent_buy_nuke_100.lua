function p.__get_can_use(level, bp)
    return true
end

function p.__get_use_msg(level, bp)
    return "Buy Nuke for 100 gold"
end

function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    local ammo_max = game_wep_modes.get_ammo_max(9)
    ga_set_i("xar.player.gun9.ammo", ammo_max)
end
