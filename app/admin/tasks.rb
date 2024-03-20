# app/admin/task.rb

ActiveAdmin.register Task do
  permit_params :title, :description

  index do
    selectable_column
    id_column
    column :title
    column :description
    actions
  end

  form do |f|
    f.inputs 'Task Details' do
      f.input :title
      f.input :description
    end
    f.actions
  end
end
