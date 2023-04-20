require_relative 'encoders'

class Winnings
  def initialize
    @model = nil
    @training_data = Importer.new('public/training/training.csv').import
    @trainer = nil
    @encoders = Encoders.new(@training_data)
  end

  def train
    @trainer = RandomForestTrainer.new(@training_data)
    @trainer.train
    @model = @trainer.model
  end

  def predict
    race_card_path = 'public/racecard/racecard.json'
    race_card = JSON.parse(File.read(race_card_path))

    winners = {}
    race_card['GB'].each do |course_name, race_info|
      race_info.each do |race_time, race_data|
        features = preprocess_race_data(race_data)
        next if features.nil?

        horse_names = features.map { |h| h[:horse] }.uniq
        horse_probabilities = {}

        horse_names.each do |name|
          horse_features = features.select { |h| h[:horse] == name }
          horse_probability = @model.predict(horse_features)
          horse_probabilities[name] = horse_probability.sum
        end

        winning_horse = horse_probabilities.max_by { |_k, v| v }[0]
        winners[race_time] = winning_horse
      end
    end

    winners
  end

  private

  def preprocess_race_data(race_data)
    course_name = race_data['course']
    if valid_course?(course_name)
      puts "VALID course name :#{course_name}"
      features = []
      race_data['runners'].each do |runner|
        feature_row = {}
        feature_row[:date] = race_data['date']
        feature_row[:course] = course_name
        feature_row[:type] = race_data['distance_round']
        feature_row[:pattern] = race_data['pattern']
        feature_row[:age_band] = runner['age_band']
        feature_row[:dist] = runner['distance']
        feature_row[:going] = race_data['going']
        feature_row[:ran] = race_data['field_size']
        feature_row[:pos] = runner['pos']
        feature_row[:draw] = runner['draw']
        feature_row[:horse] = runner['name']
        feature_row[:age] = runner['age']
        feature_row[:sex] = runner['sex_code']
        feature_row[:lbs] = runner['lbs']
        feature_row[:jockey] = runner['jockey']
        feature_row[:trainer] = runner['trainer']
        feature_row[:sire] = runner['sire']
        feature_row[:dam] = runner['dam']
        feature_row[:owner] = runner['owner']

        features << feature_row
      end
      features = @encoders.transform_features(features)

    else
      puts "Invalid course name :#{course_name}"
      return nil
    end

    features
  end

  def valid_course?(course_name)
    @training_data.any? { |row| row[:course] == course_name }
  end
end
