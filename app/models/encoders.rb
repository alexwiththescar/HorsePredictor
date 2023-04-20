class Encoders
  attr_reader :course_encoder, :type_encoder, :pattern_encoder, :age_band_encoder, :going_encoder,
              :sex_encoder, :jockey_encoder, :trainer_encoder, :sire_encoder, :dam_encoder, :owner_encoder, :horse_encoder, :transform_row

  def initialize(training_data)
    @training_data = training_data
    @encoders = {} # Add this line to initialize the variable as an empty hash
    @categorical_columns = %i[course type pattern going jockey trainer sire dam owner]
    @categorical_columns.each do |column|
      @encoders[column] = Rumale::Preprocessing::LabelEncoder.new
    end
  end

  def fit_encoders
    @course_encoder.fit(@training_data.map { |row| row[:course] })
    @type_encoder.fit(@training_data.map { |row| row[:type] })
    @pattern_encoder.fit(@training_data.map { |row| row[:pattern] })
    @age_band_encoder.fit(@training_data.map { |row| row[:age_band] })
    @going_encoder.fit(@training_data.map { |row| row[:going] })
    @sex_encoder.fit(@training_data.map { |row| row[:sex] })
    @jockey_encoder.fit(@training_data.map { |row| row[:jockey] })
    @trainer_encoder.fit(@training_data.map { |row| row[:trainer] })
    @sire_encoder.fit(@training_data.map { |row| row[:sire] })
    @dam_encoder.fit(@training_data.map { |row| row[:dam] })
    @owner_encoder.fit(@training_data.map { |row| row[:owner] })
    @horse_encoder.fit(@training_data.map { |row| row[:horse] })
  end

  def transform_row(row)
    transformed_row = []

    row.each do |column, value|
      if @categorical_columns.include?(column)
        encoder = @encoders[column]
        transformed_value = encoder.transform([value])[0] if encoder
      elsif column == :date
        transformed_value = Date.parse(value).to_time.to_i
      else
        transformed_value = value.to_f
      end

      transformed_row << transformed_value if transformed_value
    end

    transformed_row
  end

  def transform_features(feature_rows)
    feature_rows.map { |row| transform_row(row) }
  end

  def dist_to_furlongs(dist_str)
    furlongs_pattern = /(\d+)f/
    miles_pattern = /(\d+)m/

    furlongs = dist_str.match(furlongs_pattern) ? dist_str.match(furlongs_pattern)[1].to_i : 0
    miles = dist_str.match(miles_pattern) ? dist_str.match(miles_pattern)[1].to_i : 0

    total_furlongs = (miles * 8) + furlongs
    total_furlongs
  end

  def to_numeric(value)
    Float(value)
  rescue ArgumentError
    puts '=========='
    puts value
    puts '=========='
    0.0
  end
end
