require File.expand_path('../../fixtures', __FILE__)
shared_examples_for("A domain") do
  
  it{ should respond_to(:domain)        }
  it{ should respond_to(:is_value?)     }
  it{ should respond_to(:parse_literal) }
  it{ should respond_to(:to_literal)    }
  it{ should respond_to(:str_coerce)    }
  it{ should respond_to(:ruby_coerce)   }
  it{ should respond_to(:coerce)        }
  
  
end