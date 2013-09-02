# encoding: utf-8
class NotificationsController < ApplicationController
  load_and_authorize_resource
  before_filter :authenticate_user!

  # GET /notifications
  def index
    @read_notifications = current_user.read_notifications
    @not_read_notifications = current_user.not_read_notifications

    respond_to do |format|
      format.html
    end
  end

  # GET /notifications/1
  # GET /notifications/1.json
  def show
    @notification = Notification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/new
  # GET /notifications/new.json
  def new
    @notification = Notification.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @notification }
    end
  end

  # GET /notifications/1/edit
  def edit
    @notification = Notification.find(params[:id])
  end

  # POST /notifications
  # POST /notifications.json
  def create
    @notification = Notification.new(params[:notification])
    @notification.sender = current_user.id

    respond_to do |format|
      if @notification.save
        format.html { redirect_to @notification, notice: 'Notification was successfully created.' }
        format.json { render json: @notification, status: :created, location: @notification }
      else
        format.html { render action: "new" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /notifications/1
  # PUT /notifications/1.json
  def update
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attributes(params[:notification])
        format.html { redirect_to @notification, notice: 'Notification was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @notification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notifications/1
  # DELETE /notifications/1.json
  def destroy
    @notification = Notification.find(params[:id])
    @notification.destroy

    respond_to do |format|
      format.html { redirect_to notifications_url }
      format.json { head :no_content }
    end
  end

  def own_sent
    @notifications = current_user.own_sent_notifications

    respond_to do |format|
      format.html
    end
  end

  def reply
    orgin_notification = Notification.find(params[:id])
    orgin_notification.is_read = true
    orgin_notification.save

    @notification = Notification.new(:sender => current_user.id, :receiver => orgin_notification.sender)
  end

  def have_read
    @notification = Notification.find(params[:id])

    respond_to do |format|
      if @notification.update_attribute(:is_read,true)
        format.html { redirect_to notifications_url, notice: "设为已读" }
      else
        format.html { redirect_to notifications_url, notice: "更新失败" }
      end
    end
  end
end
