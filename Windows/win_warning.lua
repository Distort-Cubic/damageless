function p.__render(wid)
    ga_set_sys_b("game.window.hud.hide_system_hud", false)
    ga_win_set_background(wid, std.vec(0.0, 0.0, 0.0), 1.0)
    ga_win_set_front_color(wid, std.vec(1.0, 0.0, 0.0))
    ga_win_set_char_size(wid, 0.04, 0.08)
    ga_win_txt_center(wid, 0.75, "Damageless Mod")
    ga_win_txt_center(wid, 0.5, "(warning message)")
    ga_win_set_char_size(wid, 0.02, 0.04)
    ga_win_txt_center(wid, 0.3, "Press 1 to Enable")
    ga_win_txt_center(wid, 0.12, "Or press 2 to Close")
end

function p.__process_input(wid)
    if (ga_win_key_pressed(wid, "1")) then
        ga_set_b("damageless.enabled", true)
        ga_set_b("damageless.warning", true)
        ga_window_pop()
    elseif (ga_win_key_pressed(wid, "2")) then
        ga_set_b("damageless.enabled", false)
        ga_set_b("damageless.warning", true)
        ga_window_pop()
    end
    return
end
