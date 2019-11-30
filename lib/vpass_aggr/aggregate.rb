require 'csv'

module VpassAggr
  class Aggregate
    attr_reader :division, :period, :config
    def initialize(division, period)
      @division = division
      @period   = period
      @config = Config.new
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
        data = CSV.read(c, encoding: 'SHIFT_JIS:UTF-8').last
        sum << "#{month},#{data[5]}"
      end
      sum
    end

    def payto
    end
  end
end
