ActiveAdmin.register Brand do
  permit_params :name
  index do
    selectable_column
    id_column
    column :name
    column :created_at
    column :updated_at
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :created_at
      row :updated_at
    end
  end
end