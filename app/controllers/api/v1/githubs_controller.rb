module Api
  module V1
    class GithubsController < ApplicationController
      before_action :parse_response_with_user_data, only: [:index]
      before_action :parse_response_with_repos, only: [:index]

      GITHUB_API_URL = "https://api.github.com/users/"
      NOT_FOUND_RESPONSE_MESSAGE = "Not Found"
      NAME_DOESNT_EXIST = "No name"

      def index
        if @response_with_user_data['message'] != NOT_FOUND_RESPONSE_MESSAGE
          render json: { 
                        message: "Loaded data",
                        data: {
                                name: @response_with_user_data['name'] || NAME_DOESNT_EXIST, 
                                repos: map_repos_names(@user_repos_response)
                              }
                        }, status: :ok          
        else 
          render json: { message: NOT_FOUND_RESPONSE_MESSAGE}, status: :not_found
        end
      end

      private
        def parse_response_with_user_data
          @response_with_user_data = JSON.parse send_request_for_user_data
        end

        def parse_response_with_repos
          @user_repos_response = JSON.parse send_request_for_repos
        end

        def send_request_for_user_data
          HTTParty.get("#{GITHUB_API_URL}#{params[:search]}")
          .body
          .gsub(':', ':')
        end        

        def send_request_for_repos
          HTTParty.get("#{GITHUB_API_URL}#{params[:search]}/repos")
          .body
          .gsub(':', ':')
        end

        def map_repos_names user_repos_response
          user_repos_response.map do |repo|
            repo['name']
          end
        end
    end
  end
end