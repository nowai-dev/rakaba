class BoardsController < ApplicationController
	before_filter :change_board	
	
	def index
		@threads = RThread.get_page 1
	end
end
