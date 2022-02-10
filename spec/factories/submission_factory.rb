FactoryBot.define do
  factory :submission do
    site_id { create(:site).id}
    participant_id { create(:participant).id }
    record_taken { Date.today }
    ai_tags  { {} }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'assets', 'test-image.jpg'), 'image/jpg') }
    type_name { "EMAIL" }

    factory :submission_with_insta_type do
      type_name { "INSTAGRAM" }
    end
  end
end