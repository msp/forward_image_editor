RSpec::Matchers.define :include_module do |module_name|
  match do |klass|
    klass.included_modules.include?(module_name)
  end

  failure_message_for_should do |klass|
    "expected #{klass} to include Module #{module_name}"
  end

  failure_message_for_should_not do |klass|
    "expected #{klass} to not include Module #{module_name}"
  end

  description do
    "include module #{module_name}"
  end
end
