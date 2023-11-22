# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MyEventsController, type: :controller do
  let(:valid_attributes) { attributes_for(:event) }
  let(:invalid_attributes) { { name: nil } }
  let(:county) { create(:county) }
  let(:event) { create(:event, valid_attributes) }

  describe 'GET #new' do
    it 'assigns a new event to @event' do
      get :new
      expect(assigns(:event)).to be_a_new(Event)
    end
  end

  describe 'GET #edit' do
    it 'assigns the requested event to @event' do
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq(event)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Event' do
        expect {
          post :create, params: { event: valid_attributes }
        }.to change(Event, :count).by(1)
      end

      it 'redirects to the events list' do
        post :create, params: { event: valid_attributes }
        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event was successfully created.')
      end
    end

    context 'with invalid params' do
      it 'does not create a new Event' do
        expect {
          post :create, params: { event: invalid_attributes }
        }.to change(Event, :count).by(0)
      end

      it 'renders the :new template' do
        post :create, params: { event: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) { { name: 'Updated Event Name' } }

      it 'updates the requested event' do
        put :update, params: { id: event.id, event: new_attributes }
        event.reload
        expect(event.name).to eq('Updated Event Name')
      end

      it 'redirects to the events list' do
        put :update, params: { id: event.id, event: new_attributes }
        expect(response).to redirect_to(events_path)
        expect(flash[:notice]).to eq('Event was successfully updated.')
      end
    end

    context 'with invalid params' do
      it 'does not update the event' do
        original_name = event.name
        put :update, params: { id: event.id, event: invalid_attributes }
        event.reload
        expect(event.name).to eq(original_name)
      end

      it 'renders the :edit template' do
        put :update, params: { id: event.id, event: invalid_attributes }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested event' do
      event
      expect {
        delete :destroy, params: { id: event.id }
      }.to change(Event, :count).by(-1)
    end

    it 'redirects to the events list' do
      delete :destroy, params: { id: event.id }
      expect(response).to redirect_to(events_url)
      expect(flash[:notice]).to eq('Event was successfully destroyed.')
    end
  end
end
