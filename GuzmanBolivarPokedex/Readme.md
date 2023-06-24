#  App Name: PokeApp

This app is simplified version of a Pokedex. With time, I will add more features to look as close as possible to a Pokedex. The features of this app:

- Show lists of Pokemons from the PokeAPI website (https://pokeapi.co/)
- You can select a Pokemon from this list and get more details about it. Some information is not available for certain pokemons. Usually in the stat numbers when you see 0 as number is because there is no information from the API for that specific field. 
- The list has a pagination system, so when you press the "Load More" text button, a new API request is made to the PokeAPI website, and more pokemons appear in realtime in the list. There is a limit on the amount of times you will be able to press the "Load More" button.
- In the Profile View, the app fetches randomly 6 pokemons from the first 151 pokemons. If you press the ReRoll button, a new API Request is made, and new 6 random pokemons will appear. If you like a particular team, you can press the "Save" text button to save those 6 pokemons locally. When you close and open the app again, you will be able to see the team of Pokemons you saved. 

## Capstone - Must Haves

- [X] The app has all features the Capstone Project requires

- [X] The app has a Readme file

- [X] The app has a LaunchScreen
*In the LaunchScreen file inside the Views folder you can see my LaunchScreen*

- [X] 1 List and 3 tabs
*I use a List in the PokeDetailsView. When you select a Pokemon in the List of Pokemons to see more details, you will be able to see the List. Additionally, the List of Pokemons itself (PokeListView) and ProfileView file both have LazyVGrids too.*

- [X] Each item contains: name, subtitle, description, and image
*Each item in the List of Pokemons view (PokeListView file) has some information about the Pokemon that further shares more details about it*

- [X] Each item takes you to a DetailView
*In the List of Pokemons, when you choose a pokemon (PokeListView file), it will take you to a DetailView (PokeDetailsView file)*

- [X] No third-party frameworks
*The app doesn't use third-party frameworks*

- [X] App code well-organized: MVVM, Kodeco's Swift Lint, no warnings nor error
*My app uses the MVVM architecture. Although, because it heavily relies on API calls and networking, I added additional Networking files that connect with the ViewModel and use the ViewModel file to connect with the View file. Hence, most of my app's logic is inside the Networking files*
*My app uses Kodeco's Swift Lint already*
*There are no warnings nor errors*

- [X] The app has: Custom app icon, Onboarding Screen, Custom Display Name, 1 SwiftUI Animation, Texts are styles with properties
*The app has a Custom App icon you can see once you add it in your cellphone*
*The first tab in the app has a short and simple onboarding screen*
*The app has a custom display name when you install the app*
*On the Onboarding Screen view you can see a SwiftUI animation*
*The texts in my app are styled with modifiers*

- [X] The app has more than 50% Testing Coverage
*My app has a 69.2% testing coverage*

- [X] There are no crashes nor UI issues

- [X] The app: works in Light and Dark mode, works in Portrait and Landscape mode
*My app works in Light and Dark mode (specially for the PokeList, PokeDetails, and ProfileView)*
*My app works in Portrait and Landscape mode*

- [X] The app has one or more Network calls, and uses Swift Concurrency
*The app has multiple network calls using Swift Concurrency. You can see them in the Network Folder. All my API call logic is inside those files. The PokeListView, PokeDetailsView, and ProfileView make use of API calls.*

- [X] Handles Network Errors
*My app uses a Network:Error enum and a HandleError function. You can see them at the beginning of my Networking files.*

- [X] One saving method
*In the ProfileView, you have the ability to save locally any random team of 6 pokemons. The app will tell you if it was saved. However, you will need to close and open the app to visualize the saved pokemons*






