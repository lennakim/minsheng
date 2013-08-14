require "spec_helper"

describe ShopImagesController do
  describe "routing" do

    it "routes to #index" do
      get("/shop_images").should route_to("shop_images#index")
    end

    it "routes to #new" do
      get("/shop_images/new").should route_to("shop_images#new")
    end

    it "routes to #show" do
      get("/shop_images/1").should route_to("shop_images#show", :id => "1")
    end

    it "routes to #edit" do
      get("/shop_images/1/edit").should route_to("shop_images#edit", :id => "1")
    end

    it "routes to #create" do
      post("/shop_images").should route_to("shop_images#create")
    end

    it "routes to #update" do
      put("/shop_images/1").should route_to("shop_images#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/shop_images/1").should route_to("shop_images#destroy", :id => "1")
    end

  end
end
