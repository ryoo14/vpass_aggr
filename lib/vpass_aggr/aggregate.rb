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
      csv_files = {}
      period.each do |p|
        csv_path = "#{config.data_dir}/#{p}/*.csv"
        csv_files[p] = Dir.glob(csv_path)
      end
      sum = ['year,sum']
      csv_files.sort.each do |year, monthly_data|

        # vpassからエクスポートしたデータは最下行に月の支払い総額が記録されているので、lastで取得する
        # データの文字コードはshift-jisなので、utf-8にエンコードする
        monthly_sum = 0
        monthly_data.each do |md|
          data = CSV.read(md, encoding: 'SHIFT_JIS:UTF-8').last
          monthly_sum += data[5].to_i
        end

        sum << ["#{year},#{monthly_sum}"]
      end
      sum
    end

    def sum_month
      csv_files = []
      period.each do |p|
        csv_path = "#{config.data_dir}/#{p}/*.csv"
        csv_files += Dir.glob(csv_path)
      end
      sum = ['month,sum']
      csv_files.sort.each do |c|
        month = File.basename(c, '.csv')

        # vpassからエクスポートしたデータは最下行に月の支払い総額が記録されているので、lastで取得する
        # データの文字コードはshift-jisなので、utf-8にエンコードする
        monthly_sum = CSV.read(c, encoding: 'SHIFT_JIS:UTF-8').last
        sum << "#{month},#{monthly_sum[5]}"
      end
      sum
    end
  end
end
