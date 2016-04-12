module Webhooks
  class GitLab < Base
    def valid_request?
      request.headers['X-Gitlab-Event'] == 'Push Hook'
    end

    def webhook_address
      begin
        request.params.fetch(:project).fetch(:git_http_url)
      rescue KeyError
        return nil
      end
    end

    def webhook_branch
      branch_from_ref(request.params[:ref])
    end
  end
end
