require 'thor'
require 'date'

module VpassAggr
  class CLI < Thor
    class_option :division, :type => :string, :aliases => '-d', :default => 'year', :desc => 'specify time division'
    class_option :period,   :type => :array,  :aliases => '-p', :default => [Date.today.year], :desc => 'specify period'

    desc 'sum', 'show aggregation to sum'
    def sum()
      division = options[:division]
      period   = options[:period]

      check_args(division, period)
      
      aggr = Aggregate.new(division, period)

      if division == 'year'
        puts aggr.sum_year
      elsif division == 'month'
        puts aggr.sum_month
      else
        puts aggr.sum_day
      end
    end

    desc 'payto', 'show aggregation to payto'
    def payto()
      division = options[:division]
      period   = options[:period]

      check_args(division, period)

      aggr = Aggregate.new(division, period)

      if division == 'year'
        puts aggr.payto_year
      elsif division == 'month'
        puts aggr.payto_month
      else
        puts aggr.payto_day
      end
    end

    private

    def check_args(division, period)
      if not %w/year month day/.include?(division)
        raise ArgumentError
      else
        period.each do |p|
          if p !~ /20[0-9][0-9]/
            raise ArgumentError
          end
        end
      end
    end
  end
end
