require 'rails_helper'

RSpec.describe ProxyController, type: :controller do
  let(:url) { "https://avatars2.githubusercontent.com/u/5470001" }

  it "should return a 403 if no signature is specified" do
    get :image, params: { request: Base64.encode64({ url: url }.to_json) }
    expect(response.status).to eq(403)
  end

  it "should return a 403 if a wrong signature is specified" do
    get :image, params: { request: Base64.encode64({ url: url, signature: "wrong_signature" }.to_json) }
    expect(response.status).to eq(403)
  end

  it "should return an image (no resize, no quality compression)" do
    signature = ProxyService.new.sign({ url: url })
    get :image, params: { request: Base64.encode64({ url: url, signature: signature }.to_json) }
    expect(response.status).to eq(200)
  end

  it "should return an image (resize)" do
    params =  { url: url, width: 100, height: 100 }
    signature = ProxyService.new.sign(params)
    get :image, params: { request: Base64.encode64(params.merge(signature: signature).to_json) }
    expect(response.status).to eq(200)
  end

  it "should return an image (compression)" do
    params =  { url: url, quality: 50 }
    signature = ProxyService.new.sign(params)
    get :image, params: { request: Base64.encode64(params.merge(signature: signature).to_json) }
    expect(response.status).to eq(200)
  end
end
