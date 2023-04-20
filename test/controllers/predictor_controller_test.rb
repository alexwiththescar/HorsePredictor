require "test_helper"

class PredictorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get predictor_index_url
    assert_response :success
  end
end
