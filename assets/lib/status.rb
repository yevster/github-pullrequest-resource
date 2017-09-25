require 'octokit'

class Status
  def initialize(state:, detail_url:, sha:, repo:, title:, description:, context: 'concourse-ci')
    @detail_url = detail_url
    @context = context
    @repo    = repo
    @sha     = sha
    @state   = state
    @title   = title.nil? ? 'concourse-ci' : title
    @description = description.nil? ? "Concourse CI build #{@state}" : description
  end

  def create!
    Octokit.create_status(
      @repo.name,
      @sha,
      @state,
      context: "#{@title}/#{@context}",
      description: @description,
      target_url: detail_url
    )
  end

  private


end
