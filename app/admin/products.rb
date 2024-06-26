ActiveAdmin.register Product do
  permit_params :name, :description, :category_id, :subcategory_id, 
  :price, :image,  :stock_quantity, :color, :size, :brand_name

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :category do |product|
      product&.category&.category_type
    end
    column :image do |product|
      if product&.image&.attached?
        image_tag(product.image, width: 100 , height: 100)
      else
        "No image attached"
      end
    end
    column :price
    column :brand_name 
    column :color
    column :size
    column :stock_quantity
    column :created_at
    column :updated_at

    actions
  end

  filter :name
  filter :description
  filter :price
  filter :color
  filter :size
  filter :stock_quantity
  filter :created_at

  form do |f|
    f.inputs do
      f.input :category_id, as: :select, include_blank: "please select category", collection: Category.all.map { |f| [f.category_type.humanize, f.id] }
      f.input :subcategory_id, as: :select, include_blank: "please select subcategory", collection: Subcategory.all.map { |f| [f.name.humanize, f.id] }
      f.input :brand_name, as: :select, include_blank: "please select brand name", collection: Brand.all.map { |f| [f.name.humanize] }
      f.input :name
      f.input :price
      f.input :image, as: :file
      f.input :color
      f.input :size, as: :select, include_blank: "please select size"
      f.input :stock_quantity
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :name
      row :description
      row :category do |product|
        product&.category&.category_type if product.category
      end
      row :image do |product|
        if product&.image&.attached?
         image_tag(product.image, width: 100 , height: 100)
        else
         "No image attached"
        end
      end
      row :color
      row :size
      row :price
      row :brand_name
      row :stock_quantity
      row :created_at
      row :updated_at
    end
  end
end