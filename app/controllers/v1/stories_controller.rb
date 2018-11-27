# frozen_string_literal: true

module V1
  class StoriesController < ApplicationController
    before_action :set_column
    before_action :set_story, only: [:show, :update, :destroy]

    # GET /v1/columns/:column_id/stories
    def index
      @stories = Story.where column_id: @column.id

      render json: @stories
    end

    # GET /v1/columns/:column_id/stories/1
    def show
      render json: @story
    end

    # POST /v1/columns/:column_id/stories
    def create
      @story = Story.new(story_params.merge(column_id: @column.id))

      if @story.save
        render json: @story,
               status: :created,
               location: v1_column_story_path(@column, @story)
      else
        render json: @story.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/columns/:column_id/stories/1
    def update
      if @story.update(story_params)
        render json: @story
      else
        render json: @story.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v1/columns/:column_id/stories/1
    def destroy
      @story.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:column_id])
    end

    # Only allow a trusted parameter "white list" through.
    def story_params
      params.require(:story).permit(:name, :description, :due_date, :status)
    end

    def set_story
      @story = Story.find(params[:id])
    end
  end
end
