# Description:
#   Generates a buzzword bingo card for you to use
#
# Commands:
#   hubot buzzword bingo - Generates a list of 5 random buzzwords
#
bingo_size = 5
buzzwords = [
  "Synergy",
  "Beleive in Better",
  "Cross Platform",
  "Single Codebase",
  "Blackjack",
  "Scalable",
  "Benchmark",
  "Paradigm",
  "Proactive",
  "Strategy",
  "World Class",
  "Disruptive",
  "Penetration",
  "Customer Value",
  "Restructuring",
  "Ground Breaking",
  "Dynamic",
  "Cutting Edge",
  "Optimize",
  "Unique"
]
module.exports = (robot) ->
  robot.respond /buzzword bingo/i, (msg) ->
    bingo_card = []
    while (bingo_card.length < bingo_size)
      buzzword = msg.random buzzwords
      if (buzzword not in bingo_card)
        bingo_card.push buzzword
    msg.send bingo_card.toString()
