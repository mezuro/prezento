require 'action_controller/test_case'

class RequestInfo
  attr_accessor :headers, :params

  def request
    req = ActionController::TestRequest.new
    headers.each { |k, v| req.headers[k] = v }
    params.each { |k, v| req.update_param(k, v) }
    req
  end
end

FactoryGirl.define do
  factory :request, class: RequestInfo do
    headers {}
    params {}
  end

  factory :gitlab_webhook_request, parent: :request do
    headers { { 'X-Gitlab-Event' => 'Push Hook' } }

    # Excerpt From http://doc.gitlab.com/ee/web_hooks/web_hooks.html
    params { {
      "object_kind" =>  "push",
      "ref" =>  "refs/heads/master",
      "project" => {
        "name" => "Kalibro Client",
        "description" => "",
        "git_ssh_url" => "git@example.com:mezuro/kalibro_client.git",
        "git_http_url" => "https://gitlab.com/mezuro/kalibro_client.git",
        "path_with_namespace" => "mezuro/kalibro_client",
        "default_branch" => "master",
        "url" => "git@example.com:mezuro/kalibro_client.git",
        "ssh_url" => "git@example.com:mezuro/kalibro_client.git",
        "http_url" => "https://gitlab.com/mezuro/kalibro_client.git"
      }
    } }
  end
end
