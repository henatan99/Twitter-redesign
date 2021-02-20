require './rails_helper'

RSpec.describe UsersController do
    describe "GET #index" do
      subject { get :index }

      it "renders the index template" do
        expect(subject).to render_template(:index)
        expect(subject).to render_template("index")
        expect(subject).to render_template("gadgets/index")
      end

      it "does not render a different template" do
        expect(subject).to_not render_template("gadgets/show")
      end

      it "renders the application layout" do
        expect(subject).to render_template("layouts/application")
      end
  
      it "does not render a different layout" do
        expect(subject).to_not render_template("layouts/admin")
      end
    end
end