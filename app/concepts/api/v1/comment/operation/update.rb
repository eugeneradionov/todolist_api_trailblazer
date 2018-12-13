class Api::V1::Comment::Update < Trailblazer::Operation
  step Model(Comment, :find, :id)
  step :params_options!
  step Api::V1::Step::ParseParams.new
  step Contract::Build(constant: Api::V1::Comment::Contract::Update)
  step Contract::Validate()
  step Contract::Persist()

  def params_options!(options, **)
    options[:params_fetch] = :comment
    options[:params_permit] = %i[body attachment]
  end
end
