json.extract! survey, :id, :title, :author, :created_at, :updated_at
json.url survey_url(survey, format: :json)
