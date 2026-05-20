require 'rails_helper'

RSpec.describe "Authentication APIs", type: :request do

  describe "POST /api/v1/signup" do
    it "creates a new user " do
      post "/api/v1/signup", params: {
        "name": "zeba",
        "email": "sss@test.com",
        "password": "1234",
        "password_confirmation": "1234",
        "role": "admin" 
      } 

      expect(response).to have_http_status(:created)
      json = JSON.parse(response.body)
      expect(json["user"]["email"]).to eq("sss@test.com")
      expect(json["token"]).not_to be_nil       
      
    end
    
  end

  describe "Post /api/v1/login" do
    it "logs in a  user" do
      User.create!(
        name: "zeba",
        email: "login@test.com",
        password: "1234",
        password_confirmation: "1234",
        role: "admin"        
      )

      post "/api/v1/login", params: {
        email: "login@test.com",
        password: "1234"
      }
      expect(response).to have_http_status(:ok)
      json = JSON.parse(response.body)
      expect(json["user"]["email"]).to eq("login@test.com")
      expect(json["token"]).not_to be_nil 
    end

  end




end
    