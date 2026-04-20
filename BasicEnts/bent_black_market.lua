function p.__on_use(level, bp)
    ga_play_sound_menu("use")
    for i = 7, 9 do
        local ns = tostring(i)
        local ammo_max = game_wep_modes.get_ammo_max(i)
        ga_set_i("xar.player.gun" .. ns .. ".ammo", ammo_max)
    end
end
