require 'spec_helper'

describe "products/edit" do
  before(:each) do
    @product = assign(:product, stub_model(Product,
      :reference => "MyString",
      :quantity => 1
    ))
  end

  it "renders the edit product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => products_path(@product), :method => "post" do
      assert_select "input#product_reference", :name => "product[reference]"
      assert_select "input#product_quantity", :name => "product[quantity]"
    end
  end
end
