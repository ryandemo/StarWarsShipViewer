# Custom Inits in Models
This note is a part of the [Codebase Walkthrough](./CodebaseWalkthrough.md).

Our models are in `Starship.swift`. The main one here is `Starship`:
```swift
struct Starship: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
}
```
We've created this from the JSON response for a starship. You can see the request body here: [Death Star GET Request](https://swapi.co/api/starships/9). A preview is below:
```json
{
	"name": "Death Star",
	"model": "DS-1 Orbital Battle Station",
	"manufacturer": "Imperial Department of Military Research, Sienar Fleet Systems",
	"cost_in_credits": "1000000000000",
}
```
Notice that `cost_in_credits` is in snake case while `costInCredits` in our `Starship` `struct` is in lowerCamelCase. Swift's `Codable` protocol, which `Starship` conforms to, allows for automatic generation of the correct JSON keys when you turn on a specific option. However, you can do it manually if need be.

Custom coding keys can be implemented with an `enum`:
```swift
struct Starship: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String
    
    // You can use this enum if you want more customization in your key names.
    private enum CodingKeys: String, CodingKey {
        case costInCredits = "cost_in_credits"
        case name, model, manufacturer
    }
}
```
For even more custom inits, you can create an `init` function.
```swift
struct Starship: Codable {
    let name: String
    let model: String
    let manufacturer: String
    let costInCredits: String

    init?(jsonData: Data) {
        guard let jsonDict = try? JSONSerialization.jsonObject(with: jsonData, options: .allowFragments),
            let dict = jsonDict as? [String: Any],
            let name = dict["name"] as? String,
            let model = dict["model"] as? String,
            let manufacturer = dict["manufacturer"] as? String,
            let costInCredits = dict["cost_in_credits"] as? String else {
                return nil
        }
        self.name = name
        self.model = model
        self.manufacturer = manufacturer
        self.costInCredits = costInCredits
    }
}
```
