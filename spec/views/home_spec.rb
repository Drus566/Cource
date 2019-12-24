require "rails_helper"

RSpec.describe "application/home" do
  it "display home with cource" do
    assign(:cource, '12.566')
    render
    expect(rendered).to match /12.566/
  end
end