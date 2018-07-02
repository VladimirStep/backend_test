RSpec.shared_examples 'success response' do
  it 'has status success' do
    expect(response).to have_http_status(:success)
  end

  it 'has content type application/json' do
    expect(response.content_type).to eq('application/json')
  end
end