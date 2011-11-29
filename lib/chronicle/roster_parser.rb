class RosterParser
  COLUMNS = [
    :timestamp, 
    :player_name, 
    :society_id, 
    :starting_xp, 
    :starting_fame, 
    :starting_prestige,
    :starting_gold,
    :character_name,
    :buy_list,
    :sell_list,
    :email_address,
    :faction,
    :skype_id,
    :day_job,
    :gold_gained,
    :xp_gained,
    :prestige_gained,
    :prestige_spent
  ]

  def player_info(cells)
    info = {}
    COLUMNS.each do |col|
      info[col] = cells.shift
    end
    calculate_totals(info)
  end

  def subtotal(info)
    info[:starting_gold].to_i + info[:gold_gained].to_i + info[:day_job].to_i + info[:items_sold_total].to_i
  end

  def final_fame(info)
    info[:starting_fame].to_i + info[:prestige_gained].to_i
  end

  def final_prestige(info)
    info[:starting_prestige].to_i + info[:prestige_gained].to_i - info[:prestige_spent].to_i
  end

  def xp_total(info)
    info[:starting_xp].to_i + info[:xp_gained].to_i
  end

  def gold_total(info)
    info[:subtotal] - info[:items_bought_total].to_i
  end

  def parse_character_id(info)
    info[:society_number], info[:character_number] = info[:society_id].split('-')
  end

  def calculate_totals(info)
    info[:day_job] = info[:day_job?] || 0
    info[:items_sold_total] = 0
    info[:subtotal] = subtotal(info)
    info[:gold_total] = gold_total(info)
    info[:final_fame] = final_fame(info)
    info[:final_prestige] = final_prestige(info)
    info[:xp_total] = xp_total(info)
    parse_character_id(info)
    info
  end
end
