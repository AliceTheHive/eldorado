class HeadersController < ApplicationController
  
  before_filter :require_login, :except => [:index, :show]
  before_filter :can_edit, :only => [:edit, :update, :destroy]
  
  def index
    @headers = Header.paginate(:page => params[:page], :per_page => Topic::PER_PAGE, :order => 'created_at desc')
  end

  def show
    @header = Header.find(params[:id])
  end

  def new
    render :template => "headers/_new"
  end

  def edit
    @header = Header.find(params[:id])
  end

  def create
    @header = current_user.headers.build params[:header]
    if @header.save
      redirect_to @header
    else
      render :action => "_new"
    end
  end
  
  def update
    @header = Header.find(params[:id])
    if @header.update_attributes(params[:header])
      redirect_to @header
    else
      render :action => "edit"
    end
  end

  def destroy
    @header = Header.find(params[:id])
    @header.destroy
    redirect_to headers_url
  end
  
  def vote_up
    @header = Header.find(params[:id])
    @header.vote_up
    render :partial => 'votes'
  end
  
  def vote_down
    @header = Header.find(params[:id])
    @header.vote_down
    render :partial => 'votes'
  end
  
end
