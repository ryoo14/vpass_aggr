require 'csv'

module VpassAggr
  class Aggregate

    attr_reader :division, :period, :config

    def initialize(division, period)
      @division = division
      @period   = period
      @config = Config.new
    end

    def sum_year
      pay_data_csvfiles = {}
      period.each do |p|
        pay_data_csvfiles_path = "#{config.data_dir}/#{p}/*.csv"
        pay_data_csvfiles[p] = Dir.glob(pay_data_csvfiles_path)
      end
      sum = ['year,sum']
      pay_data_csvfiles.sort.each do |year, monthly_data|

        # vpassからエクスポートしたデータは最下行に月の支払い総額が記録されているので、lastで取得する
        # データの文字コードはshift-jisなので、utf-8にエンコードする
        yearly_sum = 0
        monthly_data.each do |md|
          data = CSV.read(md, encoding: 'SHIFT_JIS:UTF-8').last
          yearly_sum += data[5].to_i
        end

        sum << ["#{year},#{yearly_sum}"]
      end
      sum
    end

    def sum_month
      pay_data_csvfiles = []
      period.each do |p|
        pay_data_csvfiles_path = "#{config.data_dir}/#{p}/*.csv"
        pay_data_csvfiles += Dir.glob(pay_data_csvfiles_path)
      end
      sum = ['month,sum']
      pay_data_csvfiles.sort.each do |c|
        month = File.basename(c, '.csv')

        # vpassからエクスポートしたデータは最下行に月の支払い総額が記録されているので、lastで取得する
        # データの文字コードはshift-jisなので、utf-8にエンコードする
        monthly_sum = CSV.read(c, encoding: 'SHIFT_JIS:UTF-8').last
        sum << "#{month},#{monthly_sum[5]}"
      end
      sum
    end

    # TODO: コピーしただけだからちゃんと書く
    def sum_day
      pay_data_csvfiles = []
      period.each do |p|
        year  = p[0..3]
        month = p[4..5]
        pay_data_csvfiles_path = "#{config.data_dir}/#{year}/#{month}.csv"
        pay_data_csvfiles += Dir.glob(pay_data_csvfiles_path)
      end
      sum = ['day,sum']
      pay_data_csvfiles.sort.each do |c|
        month = File.basename(c, '.csv')

        # vpassからエクスポートしたデータは最上行に集計に不要な名前やカード種別の情報があり、
        # 最下行に月の支払い総額が記録される
        # dailyの集計の場合はどちらも不要なので、切り捨てて集計する
        # データの文字コードはshift-jisなので、utf-8にエンコードする
        CSV.read(c, encoding: 'SHIFT_JIS:UTF-8').each do |cd|
        sum << "#{month},#{monthly_sum[5]}"
      end
      sum
    end

  end
end
