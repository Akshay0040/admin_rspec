require 'rails_helper'

RSpec.describe 'Admin::Tasks', type: :feature do
  let(:admin_user) { create(:admin_user) }

  before do
    login_as(admin_user, scope: :admin_user)
  end

  describe 'Task management' do
    it 'allows an admin user to create a new task' do
      visit admin_tasks_path
      click_link 'New Task'
      fill_in 'Title', with: 'New Task'
      fill_in 'Description', with: 'This is a new task'
      click_button 'Create Task'

      expect(page).to have_content('Task was successfully created.')
    end

    it 'allows an admin user to edit a task' do
      task = create(:task)
      visit admin_tasks_path
      click_link 'Edit', href: edit_admin_task_path(task)
      fill_in 'Title', with: 'Updated Task'
      fill_in 'Description', with: 'This is an updated task'
      click_button 'Update Task'

      expect(page).to have_content('Task was successfully updated.')
    end

    it 'allows an admin user to delete a task' do
      task = create(:task)
      visit admin_tasks_path
      click_link 'Delete', href: admin_task_path(task)
      
      expect(page).to have_content('Task was successfully destroyed.')
      expect(Task.count).to eq(0)
    end
  end
end
