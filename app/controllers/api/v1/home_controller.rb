class Api::V1::HomeController < ApplicationController
  def index
    render json: { message: "Rails API working!" }
  end
end