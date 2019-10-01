/// #Builder pattern from Gang Of Four
///
/// Sources:
/// * https://en.wikipedia.org/wiki/Builder_pattern
/// * https://www.tutorialspoint.com/design_pattern/builder_pattern.htm
///
/// ##About Builder
///
/// Builder pattern builds a complex object using simple objects step by step.

import Foundation

protocol Packaging {
    func pack() -> String
}

protocol Item {
    func name() -> String
    func packaging() -> Packaging
    func price() -> Double
}

/// Concrete Packaging
class Wrapper: Packaging {
    func pack() -> String {
        "Wrapper"
    }
}

class Bottle: Packaging {
    func pack() -> String {
        "Bottle"
    }
}

/// Concrete Item
class Burger: Item {
    func name() -> String {
        ""
    }
    
    func packaging() -> Packaging {
        Wrapper()
    }
    
    func price() -> Double {
        0.0
    }
}

class ColdDrink: Item {
    func name() -> String {
        ""
    }
    
    func packaging() -> Packaging {
        Bottle()
    }
    
    func price() -> Double {
        0.0
    }
}

/// Concrete classes extending concrete items.
class VegBurger: Burger {
    override func name() -> String {
        "Veggie burger"
    }
    
    override func price() -> Double {
        25.0
    }
}

class ChickenBurger: Burger {
    override func name() -> String {
        "Chicken burger"
    }
    
    override func price() -> Double {
        50.5
    }
}

class Coke: ColdDrink {
    override func name() -> String {
        "Coke"
    }
    
    override func price() -> Double {
        30.0
    }
}

class Pepsi: ColdDrink {
    override func name() -> String {
        "Pepsi"
    }
    
    override func price() -> Double {
        35.0
    }
}

/// Create a Meal class which can have X items.
class Meal {
    private var items = [Item]()
    
    func addItem(_ item: Item) {
        items.append(item)
    }
    
    func getTotalPrice() -> Double {
        return items.reduce(0) { result, item in
            return result + item.price()
        }
    }
    
    func showItems() {
        items.forEach({
            print("Item: \($0.name()), Packaging: \($0.packaging().pack()), Price: \($0.price())")
        })
    }
}

/// Create a Meal builder - Responsible for creating a set of defined meals.
class MealBuilder {
    func prepareVegMeal() -> Meal {
        let meal = Meal()
        meal.addItem(VegBurger())
        meal.addItem(Coke())
        return meal
    }
    
    func prepareNonVegMeal() -> Meal {
        let meal = Meal()
        meal.addItem(ChickenBurger())
        meal.addItem(Pepsi())
        return meal
    }
}

/// Test the builder

let mealBuilder = MealBuilder()
let vegMeal = mealBuilder.prepareVegMeal()

print("Veg meal:")
vegMeal.showItems()
print("Price: \(vegMeal.getTotalPrice())")

let nonVegMeal = mealBuilder.prepareNonVegMeal()
print("Non veg meal:")
nonVegMeal.showItems()
print("Price: \(nonVegMeal.getTotalPrice())")
