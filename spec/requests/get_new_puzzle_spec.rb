require 'rails_helper'

RSpec.describe 'GET /puzzles/[team]/new' do

  it 'should respond with correct JSON' do
    get "/puzzles/red-team/new?difficulty=5"
    expect(parsed_response).to include "id", "difficulty", "population"
    expect(parsed_response['difficulty']).to eq 5
  end
end