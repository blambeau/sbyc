require File.expand_path('../../../../../spec_helper', __FILE__)
describe "Logic::parse" do

  let(:type_system){ TypeSystem::Ruby               }
  let(:parser)     { Logic::Parser.new(type_system) }
  subject          { parser.parse(expr)             }
  
  describe "When called a single ordered variable" do
    let(:expr){ lambda{ (x > 0) } }
    it{ should be_kind_of(Logic::Ordered::Ranged) }
  end
  
  describe "When called a single ordered variable" do
    let(:expr){ lambda{ (x > 0) & (x < 10) } }
    it{ should be_kind_of(Logic::Ordered::Ranged) }
  end

  describe "When called on an empty solution single var expression" do
    let(:expr){ lambda{ (x < 0) & (x > 20) } }
    it{ should be_kind_of(Logic::Ordered::None) }
  end
  
  
end