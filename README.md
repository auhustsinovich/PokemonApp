# PokemonApp

`PokemonApp` is an application that allows users to get a list of Pokémon and view additional information about each of them using the PokeAPI..

## Description

The application consists of two screens:

A screen with a list of Pokémon
A screen with additional information about the selected Pokémon
When the application is launched, the screen with the list of Pokémon opens. You can view a list of all Pokémon, scroll it up or down, and find a specific Pokémon using the search bar.

When you select a Pokémon from the list, the screen with additional information about the selected Pokémon opens. On this screen, you can see the Pokémon's name, type, height, weight, and other information.

## How it Works

The application uses the PokeAPI to get a list of Pokémon and additional information about each Pokémon.

The PokeAPI provides various endpoints that can be used to obtain information about Pokémon. In the application, we use the following endpoints:

https://pokeapi.co/api/v2/pokemon - to get a list of Pokémon

https://pokeapi.co/api/v2/pokemon/{pokemon-name} - to get additional information about a specific Pokémon
We use the URLSession library to perform HTTP requests to the PokeAPI.

## Installation

1. Clone the repository to your local machine.
2. Open the project in Xcode.
3. Build and run the application on your desired simulator or device.

## License

[MIT](https://choosealicense.com/licenses/mit/)
