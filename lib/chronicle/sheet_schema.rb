
module SheetSchema
  module Season2
    TWO_TIER = {}
    THREE_TIER = {}
  end

  module Season3
    RIGHT_COLUMN_EDGE = 2150
    RIGHT_COLUMN_INSET = 2055
    RIGHT_COLUMN_OUTSET = 2250
    HEADER_BASELINE = 600
    IMAGE_OFFSET = 85
    SMALL_FONT = 36
    LARGE_FONT = 64

    TWO_TIER = {
      :player_name => [:text, {
        :coords => [169, HEADER_BASELINE], :font_size => SMALL_FONT
      }],
      :character_name => [:text, {
        :coords => [692, HEADER_BASELINE], :font_size => SMALL_FONT
      }],
      :society_number => [:text, {
        :coords => [1225, HEADER_BASELINE], :font_size => SMALL_FONT
      }],
      :character_number => [:text, {
        :coords => [1522, HEADER_BASELINE], :font_size => SMALL_FONT
      }],
      :faction => [:text, {
        :coords => [1680, HEADER_BASELINE], :font_size => SMALL_FONT
      }],
      :chronicle_number => [:text, {
        :coords => [RIGHT_COLUMN_EDGE, 255], :font_size => LARGE_FONT
      }],
      :slow => [:check, [2115, 333]],
      :normal => [:check, [2240, 333]],
      :starting_xp => [:text, {
        :coords => [RIGHT_COLUMN_EDGE, 790], :font_size => LARGE_FONT
      }],
      :xp_gained => [:text, {
        :coords => [RIGHT_COLUMN_EDGE, 928], :font_size => LARGE_FONT
      }],
      :xp_gained_initial => [:image, [2265, 928-IMAGE_OFFSET]],
      :xp_total => [:text, {
        :coords => [RIGHT_COLUMN_EDGE, 1067], :font_size => LARGE_FONT
      }],
      :starting_fame => [:text, {
        :coords => [RIGHT_COLUMN_INSET, 1325], :font_size => LARGE_FONT
      }],
      :starting_prestige => [:text, {
        :coords => [RIGHT_COLUMN_OUTSET, 1325], :font_size => LARGE_FONT
      }],
      :prestige_gained => [:text, {
        :coords => [RIGHT_COLUMN_EDGE, 1464], :font_size => LARGE_FONT
      }],
      :prestige_gained_initial => [:image, [2265, 1464-IMAGE_OFFSET]],
      :prestige_spent => [:text, {
        :coords => [RIGHT_COLUMN_EDGE, 1602], :font_size => LARGE_FONT
      }],
      :final_fame => [:text, {
        :coords => [RIGHT_COLUMN_INSET, 1740], :font_size => LARGE_FONT
      }],
      :final_prestige => [:text, {
        :coords => [RIGHT_COLUMN_OUTSET, 1740], :font_size => LARGE_FONT
      }],
      :starting_gold => [:text, {
        :coords => [RIGHT_COLUMN_INSET, 1979], :font_size => LARGE_FONT
      }],
      :gold_gained => [:text, {
        :coords => [RIGHT_COLUMN_INSET, 2117], :font_size => LARGE_FONT
      }],
      :gold_gained_initial => [:image, [2265, 2117-IMAGE_OFFSET]],
      :day_job => [:text, {
        :coords => [RIGHT_COLUMN_INSET, 2256], :font_size => LARGE_FONT
      }],
      :day_job_initial => [:image, [2265, 2256-IMAGE_OFFSET]],
      :items_sold_total => [:text, {
        :coords => [RIGHT_COLUMN_INSET, 2395], :font_size => LARGE_FONT
      }],
      :subtotal => [:text, {
        :coords => [RIGHT_COLUMN_INSET, 2532], :font_size => LARGE_FONT
      }],
      :items_bought_total => [:text, {
        :coords => [RIGHT_COLUMN_INSET, 2670], :font_size => LARGE_FONT
      }],
      :gold_total => [:text, {
        :coords => [RIGHT_COLUMN_INSET, 2829], :font_size => LARGE_FONT
      }],
      :event => [:text, {
        :coords => [200, 3054], :font_size => SMALL_FONT
      }],
      :event_code => [:text, {
        :coords => [635, 3054], :font_size => SMALL_FONT
      }],
      :date => [:text, {
        :coords => [1000, 3054], :font_size => SMALL_FONT
      }],
      :gm_signature => [:image, [1304, 3054-IMAGE_OFFSET]],
      :gm_society_number => [:text, {
        :coords => [2075, 3054], :font_size => SMALL_FONT
      }],
      :items_sold_desc => [:list, {
        :coords => [181,2539],
        :height => 2571-2539,
        :size => 7
      }],
      :items_sold_amount => [:list, {
        :coords => [795,2539],
        :height => 2571-2539,
        :size => 7
      }],
      :items_sold_cost => [:text, {
        :coords => [815, 2859], :font_size => SMALL_FONT
      }],
      :items_bought_desc => [:list, {
        :coords => [1085,2539],
        :height => 2571-2539,
        :size => 7
      }],
      :items_bought_amount => [:list, {
        :coords => [1700,2539],
        :height => 2571-2539,
        :size => 7
      }],
      :items_bought_cost => [:text, {
        :coords => [1725, 2859], :font_size => SMALL_FONT
      }]
    }
    THREE_TIER = {}
  end
end

