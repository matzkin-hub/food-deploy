# frozen_string_literal: true

class TasklistsController < ApplicationController # rubocop:disable Style/Documentation
  before_action :set_tasklist, only: %i[show edit update destroy]

  def index
    @tasklists = Tasklist.order(:checked, created_at: :desc)
  end

  def show; end

  def new
    @tasklist = Tasklist.new
  end

  def edit; end

  def create
    @tasklist = current_user.tasklists.build(tasklist_params)
    if @tasklist.save
      redirect_to tasklists_path, notice: 'タスクを登録しました'
    else
      flash.now[:alert] = 'タスクを登録できませんでした'
      render :new, status: :unprocessable_content
    end
  end

  def update
    if @tasklist.update(tasklist_params)
      redirect_to tasklists_path, notice: 'タスクを更新しました'
    else
      flash.now[:alert] = 'タスクを更新できませんでした。'
      render :edit, status: :unprocessable_content
    end
  end

  def destroy
    @tasklist.destroy!
    redirect_to tasklists_path, notice: 'タスクを削除しました。'
  end

  private

  def tasklist_params
    params.expect(tasklist: %i[title quantity checked])
  end

  def set_tasklist
    @tasklist = Tasklist.find(params[:id])
  end
end
