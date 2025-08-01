# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "V1::Lists" do
  describe "GET /index" do
    it "returns http success" do
      get "/v1/list/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/v1/list/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/v1/list/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/v1/list/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/v1/list/destroy"
      expect(response).to have_http_status(:success)
    end
  end
end
