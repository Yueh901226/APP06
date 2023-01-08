class StoriesController < ApplicationController
    #沒登入的會被踢到登入頁面
    before_action :authenticate_user! 
    # find_storyc函數只能用在edit update delete 方法中
    before_action :find_story, only: [:edit, :update, :destory]
    
    def index
        @stories = current_user.stories.order(created_at: :desc)
    end

    def new
        @story = current_user.stories.new
    end

    def create
        @story = current_user.stories.new(story_params)
        if @story.save
            redirect_to stories_path, notice: '新增成功'
        else
            render:new
        end
    end
    
    def edit

    end

    def update
        if @story.update(story_params)
            redirect_to stories_path, notice: '故事新增成功'
        else
            render :edit
        end
    end


    private

    def find_story
        # 從這使用者所有的文章中找到對的ID
        @story = current_user.stories.find(params[:id])    
    end

    def story_params
        params.require(:story).permit(:title, :content)
    end
end
