require File.expand_path('../../../../../../spec_helper', __FILE__)

describe "CodeTree::Producing::Producer#apply_args_conventions" do
  
  let(:producer)  { ::CodeTree::producer }

  context "whitout options at all (not provided, no default)" do
    let(:extension) { module Ext; def hello() "hello"; end end; Ext }
  
    subject { producer.add_extension(extension) }
    it      { should == producer                }
    it      { should be_kind_of(extension)      }
    it      { should respond_to(:hello)         }
    specify { producer.extension_options[extension].should be_nil }
  end

  context "with default options only" do
    let(:extension) { 
      module ::Ext
        def self.prepare_options(options)
          { :who => "blambeau", :times => 3 }.merge(options)
        end
        def hello() 
          extension_options[Ext][:who]*extension_options[Ext][:times]
        end
      end; 
      ::Ext 
    }
    subject { producer.add_extension(extension) }
    it      { should == producer                }
    it      { should be_kind_of(extension)      }
    it      { should respond_to(:hello)         }
    specify { 
      subject.extension_options[extension].should == { :who => "blambeau", :times => 3 } 
      subject.hello.should == "blambeaublambeaublambeau"
    }
  end


  context "with both" do
    let(:extension) { 
      module ::Ext
        def self.prepare_options(options)
          { :who => "blambeau", :times => 3 }.merge(options)
        end
        def hello() 
          extension_options[Ext][:who]*extension_options[Ext][:times]
        end
      end; 
      ::Ext 
    }
    subject { producer.add_extension(extension, :times => 1) }
    it      { should == producer                }
    it      { should be_kind_of(extension)      }
    it      { should respond_to(:hello)         }
    specify { 
      subject.extension_options[extension].should == { :who => "blambeau", :times => 1 } 
      subject.hello.should == "blambeau"
    }
  end

end