require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Name2X::ModuleDelegate#name2name" do

  let(:delegate){ CodeTree::Name2X::ModuleDelegate.new(CodeTree) }

  [ [:Producing, :Producing],
    [:producing, :Producing],
    [:AstNode,   :AstNode],
    [:astNode,   :AstNode],
    [:ast_node,  :AstNode] ].each do |source, expected|
    describe "when called on #{source}, should return #{expected}" do
      subject{ delegate.name2name(source) }
      it { should == expected }
    end
  end
 
end