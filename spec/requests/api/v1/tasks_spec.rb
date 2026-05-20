require 'rails_helper'

RSpec.describe "Tasks APIs", type: :request do

  let(:user) do
    User.create!(
      name: "zeba",
      email: "taskuser@test.com",
      password: "1234",
      password_confirmation: "1234",
      role: "admin"
    )
  end

  let(:token) do
    JWT.encode(
      {
      user_id: user.id
    },Rails.application.secret_key_base
    )
  end

  describe "POST /api/v1/tasks" do


    it "creae a task for authorised user" do
      post "/api/v1/tasks",
      params: {
        title: "Build Task API",
        description: "create task module",
        due_date: "2026-06-06",
        status: "in_progress"
      }, headers: {
        "Authorization" => "Bearer #{token}"
      }
      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)

      expect(json["title"]).to eq("Build Task API")
      expect(json["status"]).to eq("in_progress")
      
    end
    it "returns unauthorized without token" do

      post "/api/v1/tasks",
      params: {
        title: "Unauthorized Task",
        status: "pending"
      }

      expect(response).to have_http_status(:unauthorized)

      json = JSON.parse(response.body)

      expect(json["error"]).to eq("Unauthorized")

    end
  end

    describe "GET /api/v1/tasks" do

    it "returns tasks for authenticated user" do

      user.tasks.create!(
        title: "Existing Task",
        description: "Task description",
        status: "completed"
      )

      get "/api/v1/tasks",
      headers: {
        "Authorization" => "Bearer #{token}"
      }

      expect(response).to have_http_status(:ok)

      json = JSON.parse(response.body)

      expect(json.length).to eq(1)
      expect(json[0]["title"]).to eq("Existing Task")

    end
  end



end