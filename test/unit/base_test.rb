require File.expand_path(File.dirname(__FILE__) + '/../test_helper.rb')

class BaseUnit < Test::Unit::TestCase

  context "Initializing lib" do
    test "Initialize with key and secrect" do
      assert_kind_of LostFM, LostFM.new('aaaaa', 'bbbbb')
    end
  end
end
