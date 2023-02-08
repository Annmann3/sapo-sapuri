class TesetController < ApplicationController
  def index
    @test = { test: 'test' }
  end

  def create
    byebug
    redirect_to '/api/vi/oauth/line'
  end
end
