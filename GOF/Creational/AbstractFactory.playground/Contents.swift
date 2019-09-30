/// #Abstract factory pattern from Gang Of Four
///
/// Sources:
/// * https://en.wikipedia.org/wiki/Abstract_factory_pattern
/// * https://www.tutorialspoint.com/design_pattern/abstract_factory_pattern.htm
///
/// ##About Abstract Factory
///
/// Abstract factory is a "Super"factory for creating other factories.

import Foundation

/// Protocol (Interface) for your classes.
protocol Shape {
    func draw()
}

/// ## Concrete implementation of protocol

class RoundedRectangle: Shape {
    func draw() {
        print("Drawing RoundedRectangle...")
    }
}

class RoundedSquare: Shape {
    func draw() {
        print("Drawing RoundedSquare...")
    }
}

class Rectangle: Shape {
    func draw() {
        print("Drawing Rectanle...")
    }
}

class Square: Shape {
    func draw() {
        print("Drawing Square...")
    }
}

/// ## Create a protocol for our Abstract Factory
/// The Abstract Factory can create different types of **Shape**s e.g. *Rectangle*, *RoundedSquare* or what ever conforms to **Shape**

protocol AbstractShapeFactory {
    func getShape(type: String) -> Shape?
}

/// ## Create a concrete implementation of AbstractShapeFactory
/// We have a protocol for how out ShapeFacotry should look like. We can then implement that protocol in a concrete class.

/// This factory will create instances of Shape.
class ShapeFactory: AbstractShapeFactory {
    func getShape(type: String) -> Shape? {
        if type.uppercased() == "SQUARE" {
            return Square()
        } else if type.uppercased() == "RECTANGLE" {
            return Rectangle()
        }
        
        return nil
    }
}

/// The *ShapeFactory* only creates instances of *Square* and *Rectangle* but what about *RoundedSquare* and *RoundedRectangle*?
/// We can create another factory for that, a **RoundedShapeFactory**. Which will conform to our **AbstractFactory** protocol.

class RounededShapeFactory: AbstractShapeFactory {
    func getShape(type: String) -> Shape? {
        if type.uppercased() == "SQUARE" {
            return RoundedSquare()
        } else if type.uppercased() == "RECTANGLE" {
            return RoundedRectangle()
        }
        
        return nil
    }
}

/// But how do we get instances of either **Square** or **RoundedSquare**?
/// - Since both **ShapeFactory** and **RoundedShapeFactory** conforms to our **AbstractShapeFactory** protocol we can create a factory which can create a factory for a shape type.

class FactoryProducer {
    class func getFactory(rounded: Bool) -> AbstractShapeFactory {
        if rounded {
            return RounededShapeFactory()
        } else {
            return ShapeFactory()
        }
    }
}

/// The big test.

let shapeFactory = FactoryProducer.getFactory(rounded: false)
shapeFactory.getShape(type: "SQUARE")?.draw()
shapeFactory.getShape(type: "RECTANGLE")?.draw()
let roundedFactory = FactoryProducer.getFactory(rounded: true)
roundedFactory.getShape(type: "SQUARE")?.draw()
roundedFactory.getShape(type: "RECTANGLE")?.draw()
