require 'rails_helper'

describe PagesController, type: :controller do

  describe 'GET #index' do
    context 'with active login session' do
      xit 'populates an array of the current user conversations' do
      end

      xit "redirect to conversations :index" do
      end

      xit 'populates an arry of public conversations' do
      end
    end

    context 'without active login session' do
      it "populates a collection of public conversations" do
        first_conversation = create(:conversation)
        second_conversation  = create(:conversation)
        first_message = create(:message)
        second_message = create(:message)
        second_conversation.messages << second_message
        first_conversation.messages << first_message
        get :index
        expect(assigns(:public_conversations)).to match_array(
          [first_conversation, second_conversation])
      end

      it "renders the :index template" do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
