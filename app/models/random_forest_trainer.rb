require_relative 'encoders'

class RandomForestTrainer
  attr_reader :model, :encoders

  def initialize(training_data)
    @training_data = training_data
    @model = nil
    @encoders = Encoders.new(@training_data)
  end

  def train
    features, labels = prepare_data
    @model = Rumale::Ensemble::RandomForestRegressor.new(n_estimators: 100, max_depth: 10, random_seed: 42)
    @model.fit(features, labels)
  end

  private

  def prepare_data
    features = []
    labels = []

    @training_data.each do |row|
      feature_row = @encoders.transform_row(row)
      features << feature_row
      labels << row[:pos].to_i
    end

    [features, labels]
  end
end