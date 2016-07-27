class JudgeJob < ActiveJob::Base
  @queue = :file_server

  def perform(code)
    logger.debug("#{code}")
  end
end
