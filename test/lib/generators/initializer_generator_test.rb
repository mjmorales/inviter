require 'test_helper'
require 'generators/inviter/initializer/initializer_generator'

class InitializerGeneratorTest < Rails::Generators::TestCase
  tests Inviter::InitializerGenerator
  destination Rails.root.join('tmp/generators')
  setup :prepare_destination

  test "generator runs without errors" do
    assert_nothing_raised do
      run_generator ["arguments"]
    end
  end
end
