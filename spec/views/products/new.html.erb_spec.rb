require 'spec_helper'

describe "products/new" do
  before(:each) do
    assign(:product, stub_model(Product,
      :reference => "MyString",
      :quantity => 1
    ).as_new_record)
  end

  it "renders new product form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => products_path, :method => "post" do
      assert_select "input#product_reference", :name => "product[reference]"
      assert_select "input#product_quantity", :name => "product[quantity]"
    end
  end
end
