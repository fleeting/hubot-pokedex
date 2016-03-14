# hubot-pokedex [![GitHub version](https://badge.fury.io/gh/fleeting%2Fhubot-pokedex.svg)](https://badge.fury.io/gh/fleeting%2Fhubot-pokedex) [![Build Status](https://travis-ci.org/fleeting/hubot-pokedex.svg?branch=master)](https://travis-ci.org/fleeting/hubot-pokedex)

A wild Hubot appears. Hubot uses Pokédex.

See [`src/pokedex.coffee`](src/pokedex.coffee) for full documentation. Data pulled using http://pokeapi.co/.

## Installation

In hubot project repo, run:

`npm install SOON --save`

Then add **hubot-pokedex** to your `external-scripts.json`:

```json
[
  "hubot-pokedex"
]
```

## Sample Interaction

```
user1>> pokedex select pikachu
hubot>> You've found pikachu, a electric type Pokémon. This Pokémon has electricity-storing pouches on its cheeks. These appear to become electrically charged during the night while Pikachu sleeps. It occasionally discharges electricity when it is dozy after waking up. The base stats are speed 90, special-defense 50, special-attack 50, defense 40, attack 55, hp 35.
```
