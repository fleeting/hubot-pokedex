# Description
#   A wild Hubot appears. Hubot uses Pokédex.
#
# Configuration:
#   None
#
# Commands:
#   pokedex help - A quick list of the commands available.
#   pokedex select <PokemonName> - Query the Pokédex for information about a Pokémon.
#   pokedex select random - Query the Pokédex for information about a random Pokémon.
#
# Notes:
#
#
# Author:
#   James Fleeting <hello@jamesfleeting.com>

getPokemon = (robot, pokemon, cb) ->
  # API End Point -> http://pokeapi.co/docsv2/#pokemon
  robot.http("http://pokeapi.co/api/v2/pokemon/" + pokemon + "/").header('Content-Type', 'application/json').get() (err, res, body) ->
    if err
      robot.send "Encountered an error :( #{err}"
      return

    robot.logger.debug body
    pokemon = JSON.parse body

    getPokemonSpecies robot, pokemon.id, (pokemon_species) ->
      pokemon.species = pokemon_species
      cb pokemon

getPokemonSpecies = (robot, pokemon_id, cb) ->
  # API End Point -> http://pokeapi.co/docsv2/#pokemon-species
  # The /pokemon/ API endpoint doesn't contain the actual pokedex entry. Instead this is found in /pokemon-species/, so I had to do a second query. Species provides some other data that I might use in the future so the second query isn't a big deal for now.
  robot.http("http://pokeapi.co/api/v2/pokemon-species/" + pokemon_id + "/").header('Content-Type', 'application/json').get() (err, res, body) ->
    if err
      robot.send "Encountered an error :( #{err}"
      return

    robot.logger.debug body
    pokemon_species = JSON.parse body

    cb pokemon_species

module.exports = (robot) ->
  robot.hear /^pokemon ?$/im, (res) ->
    res.reply "I wanna be the very best\n
    Like no one ever was\n
    To catch them is my real test\n
    To train them is my cause\n

    I will travel across the land\n
    Searching far and wide\n
    Teach Pokémon to understand\n
    The power that's inside\n

    Pokémon (Gotta catch 'em all), it's you and me\n
    I know it's my destiny\n
    (Pokémon!)\n
    Ooh, you're my best friend\n
    In a world we must defend\n
    Pokémon (Gotta catch 'em all), a heart so true\n
    Our courage will pull us through\n
    You teach me, and I'll teach you\n
    Po-ké-mon\n
    (Gotta catch 'em all!)\n
    Gotta catch 'em all!\n
    Pokémon!"

  robot.hear /pokedex (.*) (.*)/i, (msg) ->
    action = msg.match[1].toLowerCase()
    query = msg.match[2].toLowerCase()
    robot.logger.debug "Action is #{action} with a query of #{query}. The full message was #{msg}."

    if action == 'select'
      # Get data about a Pokémon from the Pokédex.
      msg.send "Give me a second to query the Pokédex."

      getPokemon robot, query, (pokemon) ->
        pokemon_type = ""
        pokemon.types.forEach (item, index, array) ->
          if index != 0
            pokemon_type += ", "

          pokemon_type += item.type.name
          return

        pokemon_stats = "The base stats are "
        pokemon.stats.forEach (item, index, array) ->
          if index != 0
            pokemon_stats += ", "

          pokemon_stats += "#{item.stat.name} #{item.base_stat}"
          return

        pokedex_entry = pokemon.species.flavor_text_entries[1].flavor_text.replace(/\r?\n|\r/g, ' ')

        msg.send "You've found #{pokemon.name}, a #{pokemon_type} type Pokémon. #{pokedex_entry} #{pokemon_stats}."
    else
      msg.send "That isn't a valid Pokedéx command. For help try 'pokedex help'."

  robot.hear /^pokedex help ?$/im, (res) ->
    res.reply "The Pokédex is a digital encyclopedia created by Professor Oak as an invaluable tool to Trainers in the Pokémon world. It gives information about all Pokémon in the world that are contained in its database."
    res.send " * pokedex select <PokemonName>"
    res.send " * pokedex select random"
    res.send " * pokedex help"

  robot.hear /pokemon battle (.*)/i, (res) ->
    res.send "Pokémon battles are coming soon. Until then check out the Pokédex!"
