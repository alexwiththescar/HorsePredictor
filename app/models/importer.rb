class Importer
  attr_reader :csv_data

  def initialize(csv_file_path)
    @csv_file_path = csv_file_path
    @csv_data = []
  end

  def import
    read_csv
  end



  private

  def read_csv
    columns = [:date, :course, :type, :pattern, :age_band, :dist, :going, :ran, :pos, :draw, :horse, :age, :sex, :lbs, :jockey, :trainer, :sire, :dam, :owner]
    CSV.foreach(@csv_file_path, headers: true, header_converters: :symbol) do |row|
      row_data = row.to_hash.slice(*columns)
      @csv_data << row_data
    end
    @csv_data
  end

end