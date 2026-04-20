function p.get_max_level()
    return 500
end

function p.get_to_next_level_max(level)

end

function p.cap_max_level()

end

-- Returns true if can no longer level up
-- or get experiecnce (because the player is at their
-- max level)
function p.is_done()

end

function p.level_up_loop()

end

function p.level_up()

end

-- Something odd is that the player can only level up
-- when when they get experience via "game_xp.add".
-- That is, forcibly increasing xar.experience.total
-- will not cause the player to level up.
-- I might want to change this.

function p.add(raw, allow_powerup)
end

-- Should be called within the on_die function of an ment.
function p.ment_add(inst_id)

end
