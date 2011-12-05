class TotalCalculator
  ITEM_REGEX = /([^0-9]*)\s(\d*)\s?([gscp]p)/i

  def player_info(info)
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

  def calculate_totals(info)
    parse_trades(info)
    info[:day_job] = info[:day_job?] || 0
    info[:subtotal] = subtotal(info)
    info[:gold_total] = gold_total(info)
    info[:final_fame] = final_fame(info)
    info[:final_prestige] = final_prestige(info)
    info[:xp_total] = xp_total(info)
    parse_character_id(info)
    info
  end
end
