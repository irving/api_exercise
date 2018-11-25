# frozen_string_literal: true

module V1
  class ColumnsController < ApplicationController
    before_action :set_board
    before_action :set_column, only: [:show, :update, :destroy]

    # GET /v1/boards/:board_id/columns
    def index
      @columns = Column.all

      render json: @columns
    end

    # GET /v1/boards/:board_id/columns/1
    def show
      render json: @column
    end

    # POST /v1/boards/:board_id/columns
    def create
      @column = Column.new(column_params.merge(board_id: @board.id))

      if @column.save
        render json: @column,
               status: :created,
               location: v1_board_column_path(@board, @column)
      else
        render json: @column.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v1/boards/:board_id/columns/1
    def update
      if @column.update(column_params)
        render json: @column
      else
        render json: @column.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v1/boards/:board_id/columns/1
    def destroy
      @column.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_column
      @column = Column.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def column_params
      params.require(:column).permit(:name)
    end

    def set_board
      @board = Board.find(params[:board_id])
    end
  end
end
