# -*- encoding : utf-8 -*-

require 'spec_helper'

describe Organ do
  it 'can use factory girl...' do
    organ = FactoryGirl.create(:tasa_arvotyoryhma)
    organ.name.should  == 'Tasa-arvotyöryhmä'
    organ.organization.name.should  == 'Kemian laitos'
    organ.organization.parent.parent.name.should == 'Spartan Teknillinen Yliopisto'
  end
end
