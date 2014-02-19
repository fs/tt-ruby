RSpec::Matchers.define :be_a_submission_representation do |submission|
  match do |json|
    attributes = submission.attributes.slice('id')

    expect(json).to be
    expect(json).to RSpec::Matchers::BuiltIn::Include.new(attributes)
  end
end
