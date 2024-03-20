# spec/controllers/tasks_controller_spec.rb
require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      task = Task.create!(title: "Test Task", description: "Test description")
      get :show, params: { id: task.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new task" do
        expect {
          post :create, params: { task: { title: "New Task", description: "New description" } }
        }.to change(Task, :count).by(1)
      end

      it "renders a JSON response with the new task" do
        post :create, params: { task: { title: "New Task", description: "New description" } }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(task_url(Task.last))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the new task" do
        post :create, params: { task: { title: nil, description: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { title: "Updated Task" }
      }

      it "updates the requested task" do
        task = Task.create!(title: "Test Task", description: "Test description")
        patch :update, params: { id: task.to_param, task: new_attributes }
        task.reload
        expect(task.title).to eq("Updated Task")
      end

      it "renders a JSON response with the task" do
        task = Task.create!(title: "Test Task", description: "Test description")
        patch :update, params: { id: task.to_param, task: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the task" do
        task = Task.create!(title: "Test Task", description: "Test description")
        patch :update, params: { id: task.to_param, task: { title: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested task" do
      task = Task.create!(title: "Test Task", description: "Test description")
      expect {
        delete :destroy, params: { id: task.to_param }
      }.to change(Task, :count).by(-1)
    end
  end
end

