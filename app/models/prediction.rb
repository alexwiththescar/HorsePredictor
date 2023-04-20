class Prediction
  def initialize(random_forest_trainer)
    @trainer = random_forest_trainer
    @encoders = random_forest_trainer.encoders
  end

  def predict(race_data)
    feature_rows = extract_feature_rows(race_data)
    processed_data = @encoders.transform_features(feature_rows)
    predictions = @trainer.model.predict(processed_data)

    race_data["runners"].each_with_index do |runner, index|
      runner["predicted_position"] = predictions[index]
    end

    race_data["runners"].sort_by { |runner| runner["predicted_position"] }
  end

  private

  def extract_feature_rows(race_data)
    race_data["runners"].map do |runner|
      {
        course: race_data["course"],
        type: race_data["race_type"],
        pattern: race_data["class"],
        going: race_data["going"],
        jockey: runner["jockey"],
        trainer: runner["trainer"],
        sire: runner["sire"],
        dam: runner["dam"],
        owner: runner["owner"],
        horse: runner["name"]
      }
    end
  end
end
