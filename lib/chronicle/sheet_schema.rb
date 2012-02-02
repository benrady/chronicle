
require 'java'

module SheetSchema
  SMALL_FONT = 36
  LARGE_FONT = 64
  IMAGE_OFFSET = 85

  RIGHT_COLUMN_EDGE = 2150
  RIGHT_COLUMN_INSET = 2055
  RIGHT_COLUMN_OUTSET = 2250
  HEADER_BASELINE = 600
  LIST_COUNT = 7

  class << self

    def find(g)
      # This is probably a better indicator of two vs three tier
      if g.getRGB(2045, 505) == Color.black.getRGB
        return SheetSchema.season2[:three_tier]
      end
      return SheetSchema.season3[:two_tier]
    end

    def season2
      list_first = 2493
      list_second = 2524
      {
        :three_tier => {
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

    private 

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
        :chronicle_number => large_text_centered(255),
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
        :coords => [left,first_baseline],
        :height => second_baseline-first_baseline,
        :size => LIST_COUNT
      }]
    end
  end
end
