class CakeController < ApplicationController

    get '/cakes' do
     
        @session = session
        @cakes_for_me = []
        @cakes_by_me = []
        Cake.all.each do |cake|
            if belongs_to_current_user_as_receiver?(cake, @session)
                @cakes_for_me << cake
            end
            if belongs_to_current_user_as_giver?(cake, @session)
                @cakes_by_me << cake
            end
        end
        erb :'/cakes/index'
    end

    get '/cakes/new' do
        @users = User.all
        erb :'/cakes/new'
    end

    get '/cakes/:id/edit' do
        @cake = Cake.find(params["id"])
        @users = User.all
        erb :'/cakes/edit'
    end

    get '/cakes/:id' do
       
        @cake = Cake.find(params["id"])
        erb :'/cakes/show'
    end

    post '/cakes' do

        @cake = Cake.create(params["cake"])

    
        redirect "/cakes/#{@cake.id}"
    end

    patch '/cakes/:id' do
        
        @cake = Cake.find(params["id"])

        @cake.update(name: params["cake"]["name"],recipe: params["cake"]["recipe"],cook_time: params["cake"]["cook_time"],receiver_id: params["cake"]["receiver_id"],giver_id: params["cake"]["giver_id"])

        @cake.save

        redirect "/cakes/#{@cake.id}"
    end

    delete '/cakes/:id' do
        Cake.delete(params["id"])
        redirect "/cakes"
    end
end