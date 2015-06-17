require 'httparty'
require 'logger'

#
# This is a possibly helpful class for interacting with the API
#
# board = Board.create 100
# board.population                    => [{"hair" => "brown"...}]
# board.person_has? 'hair', 'brown'   => true
# board.is_person? 4                  => false
#

class GuessServer
  include HTTParty
  base_uri "local.host:3000"
  logger ::Logger.new(STDERR)
end

class Board < Struct.new(:id, :population)
  TEAM_NAME = 'my-team'

  def self.create(size)
    r = GuessServer.get "/boards/#{TEAM_NAME}/new?size=#{size}"
    new r['id'], r['population']
  end

  def person_has?(k,v)
    r = GuessServer.get "/boards/#{id}/person?#{k}=#{v}"
    case r.code
    when 200 then true
    when 204 then false
    else
      raise r
    end
  end

  def is_person?(person_id)
    r = GuessServer.get "/boards/#{id}/person/#{person_id}"
    case r.code
    when 200 then true
    when 204 then false
    else
      raise r
    end
  end

  def delete!
    GuessServer.delete("/boards/#{id}")
  end

end