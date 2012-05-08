class TotalCalculator
  ITEM_REGEX = /(.+)\s(\d*)([gscp]p)/i

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

  def convert_to_gp(amount, units)
    case units
      when 'cp' then amount / 100.0
      when 'sp' then amount / 10.0
      when 'pp' then amount * 10
      else amount 
    end
  end

  def parse_items(items)
    descriptions = []
    amounts = []
    total = 0
    items.split("\n").each do |item|
      m = ITEM_REGEX.match(item)
      if m
        item_desc, price, units = m.captures
        descriptions << item_desc
        amounts << "#{price} #{units}"
        total += convert_to_gp(price.to_i, units.downcase)
      else
        STDERR.puts "'#{item}' is a not a valid buy/sell entry"
      end
    end
    return descriptions, amounts, total
  end

  def parse_trades(info)
    info[:items_bought_desc], info[:items_bought_amount], info[:items_bought_cost] = parse_items(info[:buy_list])
    info[:items_sold_desc], info[:items_sold_amount], info[:items_sold_cost] = parse_items(info[:sell_list])
    info[:items_bought_total] = info[:items_bought_cost]
    info[:items_sold_total] = info[:items_sold_cost] / 2
  end

  def validate(info)
    required_fields = [
      :buy_list,
      :character_name,
      :chronicle_number,
      :day_job,
      :event,
      :event_code,
      :faction,
      :gm_society_number,
      :gold_gained,
      :player_name,
      :prestige_gained,
      :prestige_spent,
      :sell_list,
      :society_id,
      :starting_fame,
      :starting_gold,
      :starting_prestige,
      :starting_xp,
      :xp_gained
    ]

    required_fields.all? { |field| info.has_key? field }
  end

  # FIXME should throw a nice exception if any required fields are missing
  def calculate_totals(info)
    parse_trades(info)
    info[:day_job] = 
      if info[:day_job].empty? 
        0
      else
        info[:day_job]
      end
    info[:subtotal] = subtotal(info)
    info[:gold_total] = gold_total(info)
    info[:final_fame] = final_fame(info)
    info[:final_prestige] = final_prestige(info)
    info[:xp_total] = xp_total(info)
    parse_character_id(info)
    info
  end
end
