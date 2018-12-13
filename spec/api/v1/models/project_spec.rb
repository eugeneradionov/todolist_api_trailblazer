RSpec.describe Project, type: :model do
  it { is_expected.to have_many :tasks }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_length_of(:name).is_at_most(200) }
end
