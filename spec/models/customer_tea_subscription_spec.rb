require 'rails_helper'

RSpec.describe CustomerTeaSubscription, type: :model do
  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should belong_to(:tea) }
    it { should belong_to(:subscription) }
  end

  describe 'enums' do
    it { should define_enum_for(:status) }
  end
end
