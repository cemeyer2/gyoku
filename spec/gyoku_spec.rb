require "spec_helper"

describe Gyoku do

  describe ".xml_tag" do
    it "translates Symbols to lowerCamelCase by default" do
      tag = Gyoku.xml_tag(:user_name)
      expect(tag).to eq("userName")
    end

    it "does not translate Strings" do
      tag = Gyoku.xml_tag("user_name")
      expect(tag).to eq("user_name")
    end

    it "translates Symbols by a given key_converter" do
      tag = Gyoku.xml_tag(:user_name, :key_converter => :upcase)
      expect(tag).to eq("USER_NAME")
    end

    it "does not translates Strings with a given key_converter" do
      tag = Gyoku.xml_tag("user_name", :key_converter => :upcase)
      expect(tag).to eq("user_name")
    end
  end

  describe ".xml" do
    it "translates a given Hash to XML" do
      hash = { :id => 1 }
      xml = Gyoku.xml(hash, :element_form_default => :qualified)

      xml.should == "<id>1</id>"
    end

    it "accepts a key_converter for the Hash keys" do
      hash = { :user_name => "finn", "pass_word" => "secret" }
      xml = Gyoku.xml(hash, :key_converter => :upcase)

      xml.should include("<USER_NAME>finn</USER_NAME>")
      xml.should include("<pass_word>secret</pass_word>")
    end

    it "does not modify the original Hash" do
      hash = {
        :person => {
          :first_name => "Lucy",
          :last_name => "Sky",
          :order! => [:first_name, :last_name]
        },
        :attributes! => { :person => { :id => "666" } }
      }
      original_hash = hash.dup

      Gyoku.xml(hash)
      original_hash.should == hash
    end

    it 'should work' do
      hash = {:foo =>[ {"answer"=>"test", "csrOnly"=>false, "question"=>"What is your Mother's middle name?"},
                            {"answer"=>"test", "csrOnly"=>false, "question"=>"What is your Father's middle name?"},
                            {"answer"=>"test", "csrOnly"=>true, "question"=>"What was the model of your first car?"}]
      }
      xml = Gyoku.xml({"securityStuffs" => hash})
      puts xml
    end

  end

end
