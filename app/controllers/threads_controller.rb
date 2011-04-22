class ThreadsController < ApplicationController
  before_filter :change_board

  def create
    return not_found if not request.post?
    params[:r_thread].merge!({
      ip:         request.remote_ip,
      _id:        Ids.get_id(@board[:alias]),
      bump:       Time.now,
      board_id:   @board.id,
      file_info:  Hash.new,
      author_id:  1
    })
    thread = RThread.new params[:r_thread]
    if thread.valid?
      if thread.file?
        thread.save
        if params[:goto] == 'thread'
          return render text: url_for(action: 'show', id: thread._id)
        else
          return render text: url_for(
            controller: 'boards', 
            action:     'index', 
            alias:      @board[:alias]
          )
        end
      else
        return render text: t('errors.no_picture')
      end
    else
      return thread.errors.to_a.join '<br />'
    end
  end

  def show
    @thread = RThread.find_by__id params[:id].to_i
  end

  def update
    return not_found if not request.post?
  end
end
