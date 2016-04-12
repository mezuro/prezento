module Webhooks
  class Base
    attr_reader :request, :repository

    def initialize(request, repository)
      @request = request
      @repository = repository
    end

    # Returns true if and only if the remote addresses in the request and repository match.
    def valid_address?
      repository.address == webhook_address
    end

    # Returns true if and only if the branch in the request and repository match.
    def valid_branch?
      repository.branch == webhook_branch
    end

    # Returns true if the request parameters, as determined by the particular hook service, are valid
    # It will usually check headers, IP ranges, signatures, or any other relevant information.
    def valid_request?; raise NotImplementedError; end

    # Extracts the remote address from the webhook request.
    def webhook_address; raise NotImplementedError; end

    # Extracts the branch from the webhook request.
    def webhook_branch; raise NotImplementedError; end

    protected

    # Converts a git ref name to a branch. This is an utility function for webhook formats that only provide the ref
    # updated in their information. Returns nil if the passed parameter is not a valid ref.
    # The expected format is 'refs/heads/#{branch_name}'. Anything else will be rejected.
    def branch_from_ref(ref)
      return nil if !ref

      ref = ref.split('/')
      return nil if ref.size != 3 || ref[0..1] != ['refs', 'heads']

      ref.last
    end
  end
end
