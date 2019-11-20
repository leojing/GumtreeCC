# GumtreeCC


## Overview - Features implemented

1. Search by city name or zip code
Implement a search to allow the user to enter a city name or zip code. The result of the search is to display the current weather information for the searched location.

2. Search by GPS
On the same search screen, also allow user to use GPS location instead to get current weather information.

3.  Most recent search location loads automatically
When you come back to the app after closing it, the weather for the most recent search is displayed.

4. Recent Searches
Implement a screen that lists recently searched locations. You can tap on a recent search location and see the current weather location.

5. Delete recent searches
Provide the ability to delete one or more recently searched locations.

The feature not implemented is below:
6. Multi-market
Implement the app in such a way that it can be shipped to two different countries with a different app name in each country.
Australia: "My Aussie Weather"
Canada: "My Eh Weather"
If possible, use a different color scheme for each country.


### Architeture
MVVM, use closure for data binding.

### APIService protocol
Consider about Unit test and refact with different server-framework(Like it was  using AFNetworking, but you are consider to do refactor and using Almofire instead.), I introduced APIService protocol.


### Unit Test  
Use XCTest framework to testing ViewModel and data model parsing with local  JSON files.



Thanks,
Jing LUO
