class VideosController < ApplicationController
    before_action :find_video, only: [:edit, :update, :show, :delete]
      
    #Show all videos action
    def index
        @videos = Video.all
    end
     
    #New action for posting a video
    def new
        if current_user#.try(:admin?)
            @video = Video.new
        else
            redirect_to root_path
        end
     end
      
     #Create action saves the video into the database
    def create
        @video = Video.new
        if @video.save(video_params)
            flash[:notice] = "Successfully posted video!"
            redirect_to video_path(@video)
        else
            flash[:alert] = "Error posting new video!"
            render :new
        end
    end
    
    #Edit action retrieves the video and renders the edit page
    def edit
        if current_user#.try(:admin?)
        else
            redirect_to root_path
        end
    end
    
    #Update action updates the video with the new information
    def update
        if @video.update_attributes(video_params)
            flash[:notice] = "Successfully updated video!"
            redirect_to video_path(@video)
        else
            flash[:alert] = "Error updating video!"
            render :edit
        end
    end
    
    #The show action renders the individual video after finding the ID
    def show
    end
    
    #The destroy action permanently deletes the video from the database
    def destroy
        if @video.destroy
            flash[:notice] = "Successfully deleted video!"
            redirect_to videos_path
        else
            flash[:notice] = "Error updating video!"
        end
    end
    
    private
    
    def video_params
        params.require(:video).permit(:title, :preview, :starring, :description, :price)
    end
    
    def find_video
        @video = Video.find(params[:id])
    end
end
