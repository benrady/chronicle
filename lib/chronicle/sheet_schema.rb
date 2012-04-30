require 'java'

java_import java.awt.Color

class SheetSchema < Hash
  SMALL_FONT = 36
  LARGE_FONT = 64
  IMAGE_OFFSET = 85

  RIGHT_COLUMN_EDGE = 2150
  RIGHT_COLUMN_INSET = 2055
  RIGHT_COLUMN_OUTSET = 2250
  HEADER_BASELINE = 600
  LIST_COUNT = 7

  def initialize(name)
    schema = yield self
    merge!(gm_info.merge(header).merge(schema).merge({:schema_name => name}))
  end

  def header(baseline=HEADER_BASELINE)
    {
      :player_name => [:text, {
        :coords => [169, baseline], :font_size => SMALL_FONT
      }],
      :character_name => [:text, {
        :coords => [692, baseline], :font_size => SMALL_FONT
      }],
      :society_number => [:text, {
        :coords => [1225, baseline], :font_size => SMALL_FONT
      }],
      :character_number => [:text, {
        :coords => [1522, baseline], :font_size => SMALL_FONT
      }],
      :faction => [:text, {
        :coords => [1680, baseline], :font_size => SMALL_FONT
      }]
    }
  end

  def gm_info
    {
      :event => small_font_text(200, 3054),
      :event_code => small_font_text(635, 3054),
      :date => small_font_text(1000, 3054),
      :gm_signature => [:image, [1304, 3054-IMAGE_OFFSET]],
      :gm_society_number => small_font_text(2075, 3054),
    }
  end

  def small_font_text(left, baseline)
    [:text, {
      :coords => [left, baseline], :font_size => SMALL_FONT
    }]
  end

  def initials(baseline)
    [:image, [2265, baseline-IMAGE_OFFSET]]
  end

  def large_text_centered(baseline)
    [:text, {
      :coords => [RIGHT_COLUMN_EDGE, baseline], :font_size => LARGE_FONT
    }]
  end

  def large_text_amount(baseline, inset=RIGHT_COLUMN_INSET)
    [:text, {
      :coords => [inset, baseline], :font_size => LARGE_FONT
    }]
  end

  def list(left, first_baseline, second_baseline)
    [:list, {
      :coords => [left, first_baseline],
      :height => second_baseline - first_baseline,
      :size => LIST_COUNT
    }]
  end

  def chronicle_number(offset)
    merge!({:chronicle_number => large_text_centered(offset)})
  end

  def experience(offset)
    merge!({
      :starting_xp => large_text_amount(offset),
      :xp_total => large_text_amount(offset + 250),
    })
  end

  def experience_season3(offset)
    merge!({
      :starting_xp => large_text_amount(offset),
      :xp_total => large_text_amount(offset + 277),
    })
  end

  def prestige(offset)
    merge!({
      :starting_prestige => large_text_amount(offset),
      :prestige_gained => large_text_amount(offset + 137),
      :prestige_gained_initial => initials(offset + 137),
      :final_prestige => large_text_amount(offset + 271),
    })
  end

  def fame(offset)
    merge!({
      :starting_fame => large_text_amount(offset), # 1326
      :starting_prestige => large_text_amount(offset, RIGHT_COLUMN_OUTSET),
      :prestige_gained => large_text_amount(offset + 138),
      :prestige_gained_initial => initials(offset + 138),
      :prestige_spent => large_text_amount(offset + 274),
      :final_fame => large_text_amount(offset + 413),
      :final_prestige => large_text_amount(offset + 413, RIGHT_COLUMN_OUTSET),
    })      
  end

  def gold(offset)
    merge!({
      :starting_gold => large_text_amount(offset),
      :gold_gained => large_text_amount(offset + 136),
      :gold_gained_initial => initials(offset + 136),
      :items_sold_total => large_text_amount(offset + 273),
      :subtotal => large_text_amount(offset + 413),
      :items_bought_total => large_text_amount(offset + 550),
      :gold_spent => large_text_amount(offset + 825),
      :gold_total => large_text_amount(offset + 963),
    })
  end

  def gold_season3(offset) # 1978
    merge!({
      :starting_gold => large_text_amount(offset),
      :gold_gained => large_text_amount(offset + 136),
      :gold_gained_initial => initials(offset + 136),
      :day_job => large_text_amount(offset + 273),
      :day_job_initial => initials(offset + 273),
      :items_sold_total => large_text_amount(offset + 413),
      :subtotal => large_text_amount(offset + 550),
      :items_bought_total => large_text_amount(offset + 692),
      :gold_total => large_text_amount(offset + 850)
    })
  end

  def items(list_first, list_second)
    merge!({
      :items_sold_desc => list(181, list_first, list_second),
      :items_sold_amount => list(795, list_first, list_second),
      :items_sold_cost => [:text, {
        :coords => [815, 2812], :font_size => SMALL_FONT
      }],
      :items_bought_desc => list(1085, list_first, list_second),
      :items_bought_amount => list(1700, list_first, list_second),
      :items_bought_cost => [:text, {
        :coords => [1725, 2812], :font_size => SMALL_FONT
      }]
    })
  end

  class << self

    def calculate_checksum(img)
      (0..img.height-1).reduce do |checksum, y|
        checksum + img.getRGB(2050, y)
      end
    end

    def find(img)
      checksum = calculate_checksum(img)
      find_schema(checksum)
    end

    def find_schema(checksum)
      season_three_two_tier = SheetSchema.new("Season 3, two tier") do |s|
          s.chronicle_number(245) 
          s.experience_season3(780)
          s.fame(1315)
          s.gold_season3(1968)
          s.items(2538, 2570)
        end 

      season_zero_two_tier = SheetSchema.new("Season 0, Two Tier") do |s| 
        s.chronicle_number(205) 
        s.experience(720)
        s.prestige(1244)
        s.gold(1785)
        s.items(2488, 2519)
      end

      three_tier = SheetSchema.new("Three Tier") do |s|
        s.chronicle_number(245) 
        s.experience(760)
        s.prestige(1272)
        s.gold(1785)
        s.items(2488, 2519)
      end

      sheet_checksums = {
      #-10965565657
      -6613165945 => season_three_two_tier,
      -6613231738 => season_three_two_tier,
      -6648234899 => season_three_two_tier,
      -7565500974 => SheetSchema.new("Season Zero, Two Tier") do |s|
          s.chronicle_number(277) 
          s.experience(720)
          s.prestige(1244)
          s.gold(1785)
          s.items(2488, 2519)
        end,

      -7636425827 => season_zero_two_tier,
      -7720795533 => season_three_two_tier,
      -8030796133 => season_three_two_tier,
      -8097904993 => season_three_two_tier,
      -8120274613 => season_three_two_tier,
      -8142644233 => season_three_two_tier,
      -8159020407 => season_zero_two_tier,
      -8170606258 => season_three_two_tier,
      -8193036675 => three_tier,
        -8224746833 => SheetSchema.new("Season Zero, Two Tier") do |s| 
          s.chronicle_number(255) 
          s.experience(760)
          s.prestige(1270)
          s.gold(1785)
          s.items(2488, 2519)
        end,
      -8260084738 => season_three_two_tier,
      -8367763491 => three_tier,
      -8427856888 => season_three_two_tier,
      -8506756877 => three_tier,
      #-8530837373
      #-8561891673
      #-8583779234
      #-8664375658
      #-8796554577
      #-9175055510
      }

      return sheet_checksums[checksum] if sheet_checksums.has_key? checksum
      return {}
    end

    def season0
      list_first = 2493
      list_second = 2524
      {
        :two_tier => {
          :schema_name => "Season 0 - Two Tier",
          :starting_xp => large_text_amount(720),
          :xp_total => large_text_amount(970),
          :starting_prestige => large_text_amount(1249),
          :prestige_gained => large_text_amount(1386),
          :prestige_gained_initial => initials(1386),
          :final_prestige => large_text_amount(1520),
          :starting_gold => large_text_amount(1795),
          :gold_gained => large_text_amount(1931),
          :gold_gained_initial => initials(1931),
          :items_sold_total => large_text_amount(2068),
          :subtotal => large_text_amount(2208),
          :items_bought_total => large_text_amount(2345),
          :gold_spent => large_text_amount(2620),
          :gold_total => large_text_amount(2758),
          :items_sold_desc => list(181, list_first, list_second),
          :items_sold_amount => list(795, list_first, list_second),
          :items_sold_cost => [:text, {
            :coords => [815, 2812], :font_size => SMALL_FONT
          }],
          :items_bought_desc => list(1085, list_first, list_second),
          :items_bought_amount => list(1700, list_first, list_second),
          :items_bought_cost => [:text, {
            :coords => [1725, 2812], :font_size => SMALL_FONT
          }]
        }.merge(gm_info).
          merge(header),
        :three_tier => {
          :schema_name => "Season 0 - 3 Tier",
          :starting_xp => large_text_amount(770),
          :xp_total => large_text_amount(1020),
          :starting_prestige => large_text_amount(1279),
          :prestige_gained => large_text_amount(1416),
          :prestige_gained_initial => initials(1416),
          :final_prestige => large_text_amount(1550),
          :starting_gold => large_text_amount(1795),
          :gold_gained => large_text_amount(1931),
          :gold_gained_initial => initials(1931),
          :items_sold_total => large_text_amount(2068),
          :subtotal => large_text_amount(2208),
          :items_bought_total => large_text_amount(2345),
          :gold_spent => large_text_amount(2620),
          :gold_total => large_text_amount(2758),
          :items_sold_desc => list(181, list_first, list_second),
          :items_sold_amount => list(795, list_first, list_second),
          :items_sold_cost => [:text, {
            :coords => [815, 2812], :font_size => SMALL_FONT
          }],
          :items_bought_desc => list(1085, list_first, list_second),
          :items_bought_amount => list(1700, list_first, list_second),
          :items_bought_cost => [:text, {
            :coords => [1725, 2812], :font_size => SMALL_FONT
          }]
        }.merge(gm_info).
          merge(header)
      }
    end
    
    def season2
      list_first = 2493
      list_second = 2524
      {
        :three_tier => {
          :schema_name => "Three Tier",
          :starting_xp => large_text_amount(770),
          :xp_total => large_text_amount(1020),
          :starting_prestige => large_text_amount(1279),
          :prestige_gained => large_text_amount(1416),
          :prestige_gained_initial => initials(1416),
          :final_prestige => large_text_amount(1550),
          :starting_gold => large_text_amount(1795),
          :gold_gained => large_text_amount(1931),
          :gold_gained_initial => initials(1931),
          :items_sold_total => large_text_amount(2068),
          :subtotal => large_text_amount(2208),
          :items_bought_total => large_text_amount(2345),
          :gold_spent => large_text_amount(2620),
          :gold_total => large_text_amount(2758),
          :items_sold_desc => list(181, list_first, list_second),
          :items_sold_amount => list(795, list_first, list_second),
          :items_sold_cost => [:text, {
            :coords => [815, 2812], :font_size => SMALL_FONT
          }],
          :items_bought_desc => list(1085, list_first, list_second),
          :items_bought_amount => list(1700, list_first, list_second),
          :items_bought_cost => [:text, {
            :coords => [1725, 2812], :font_size => SMALL_FONT
          }]
        }.merge(gm_info).
          merge(header)
      }
    end

    def season3
      list_first = 2539
      list_second = 2571
      {
        :two_tier => {
          :schema_name => "Season 3 - Two Tier",
          :slow => [:check, [2115, 333]],
          :normal => [:check, [2240, 333]],
          :starting_xp => large_text_amount(790),
          :xp_gained => large_text_amount(928),
          :xp_gained_initial => initials(928),
          :xp_total => large_text_amount(1067),
          :starting_fame => large_text_amount(1325),
          :starting_prestige => large_text_amount(1325, RIGHT_COLUMN_OUTSET),
          :prestige_gained => large_text_amount(1464),
          :prestige_gained_initial => initials(1464),
          :prestige_spent => large_text_amount(1602),
          :final_fame => large_text_amount(1740),
          :final_prestige => large_text_amount(1740, RIGHT_COLUMN_OUTSET),
          :starting_gold => large_text_amount(1979),
          :gold_gained => large_text_amount(2117),
          :gold_gained_initial => initials(2117),
          :day_job => large_text_amount(2256),
          :day_job_initial => initials(2256),
          :items_sold_total => large_text_amount(2395),
          :subtotal => large_text_amount(2532),
          :items_bought_total => large_text_amount(2670),
          :gold_total => large_text_amount(2829),
          :items_sold_desc => list(181, list_first, list_second),
          :items_sold_amount => list(795, list_first, list_second),
          :items_sold_cost => [:text, {
            :coords => [815, 2859], :font_size => SMALL_FONT
          }],
          :items_bought_desc => list(1085, list_first, list_second),
          :items_bought_amount => list(1700, list_first, list_second),
          :items_bought_cost => [:text, {
            :coords => [1725, 2859], :font_size => SMALL_FONT
          }]
        }.merge(gm_info).
          merge(header)
      }
    end
  end
end
