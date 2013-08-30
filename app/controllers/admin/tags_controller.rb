#encoding: utf-8

class Admin::TagsController < Admin::BaseController
  load_resource
  before_filter :admin_only, except: :show

  def index
    @tags = Tag.order('name DESC').page(params[:page])
  end

  def new
  end

  def create
    ck_tag = Tag.where(name: params[:tag][:name]).first
    if ck_tag.nil?
      if @tag.save
        @tag.category_tags.create(category_id: params[:category_id])
        redirect_to admin_tags_path
      else
        flash[:notice] = '不能为空'
        render 'new'
      end
    else
      unless CategoryTag.where(tag_id: ck_tag.id, category_id: params[:category_id]).exists?
        ck_tag.category_tags.create(category_id: params[:category_id])
      end
      redirect_to admin_tags_path
    end
  end

  def edit
    @category = Category.find(params[:category_id])
  end

  def update
    if params[:old_name] != params[:tag][:name]
      ck_tag = Tag.where(name: params[:tag][:name]).first
      if ck_tag.nil?
        new_tag = Tag.create(params[:tag])
        @tag.category_tags.where(category_id: params[:old_category_id]).first.destroy
        new_tag.category_tags.create(category_id: params[:category_id])
        redirect_to admin_tags_path
      else
        if CategoryTag.where(tag_id: ck_tag.id, category_id: params[:category_id]).exists?
          @tag.category_tags.where(category_id: params[:old_category_id]).first.destroy
        else
          @tag.category_tags.where(category_id: params[:old_category_id]).first.
            update_attributes({tag_id: ck_tag.id, category_id: params[:category_id]})
        end
        redirect_to admin_tags_path
      end
    else
      if params[:old_category_id] != params[:category_id] && !CategoryTag.where(tag_id: @tag.id, category_id: params[:category_id]).exists?
        @tag.category_tags.where(category_id: params[:old_category_id]).first
          .update_attributes(category_id: params[:category_id])
      end
      redirect_to admin_tags_path
    end
  end

  def destroy
    @tag.category_tags.where(category_id: params[:category_id]).first.destroy
    redirect_to admin_tags_path
  end
end
