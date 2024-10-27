//: [Previous](@previous)

import Foundation

/*
 This program is about Basic and Abstract Data Types in Swift.
 1. Will create a program to calculate the Area of a Triangle and it's parameter
 */

// Creat a Point struct which denotes a Point in a 2-D coordinate system
struct Point {
    let x: Int
    let y: Int

    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

protocol GeometricalShapable {
    func area() -> Double
    func parameter() -> Double
}

protocol SidesShape: GeometricalShapable {
    func side(point1: Point, point2: Point) -> Double
    var points: [Point] { get }
}

extension SidesShape {
    func side(point1: Point, point2: Point) -> Double {
        let xSquare = pow(Double(point1.x - point2.x), 2)
        let ySquare = pow(Double(point1.y - point2.y), 2)
        let side = sqrt(xSquare + ySquare)
        return side
    }
}

// Create a Triangle struct which denited a Triangle using 3 Points.
struct Triangle: SidesShape {
    let points: [Point]

    init(points: [Point]) {
        self.points = points
    }

    func area() -> Double {
        let x1Y2Y3 = points[0].x * (points[1].y - points[2].y)
        let x2Y3Y1 = points[1].x * (points[2].y - points[0].y)
        let x3Y1Y2 = points[2].x * (points[0].y - points[1].y)
        let area = 0.5 * Double(abs(x1Y2Y3 + x2Y3Y1 + x3Y1Y2))
        return area
    }

    func parameter() -> Double {
        return side(point1: points[0], point2: points[1]) + side(point1: points[1], point2: points[2]) + side(point1: points[2], point2: points[1])
    }
}

// Create a Rectangle struct which denited a Triangle using 3 Points.
struct Rectangle: SidesShape {
    let points: [Point]

    init(points: [Point]) {
        self.points = points
    }

    func area() -> Double {
        let area = side(point1: points[0], point2: points[1]) * side(point1: points[1], point2: points[2])
        return area
    }

    func parameter() -> Double {
        return 2 * (side(point1: points[0], point2: points[1]) + side(point1: points[1], point2: points[2]))
    }
}

// Create a Square struct which denited a Triangle using 3 Points.
struct Square: SidesShape {
    let points: [Point]

    init(points: [Point]) {
        self.points = points
    }

    func area() -> Double {
        let area = pow(Double(side(point1: points[0], point2: points[1])), 2)
        return area
    }

    func parameter() -> Double {
        return 4 * side(point1: points[0], point2: points[1])
    }
}

protocol ZeroSideShape: GeometricalShapable {
    var radius: Double { get }
}

struct Circle: ZeroSideShape {
    var radius: Double

    init(radius: Double) {
        self.radius = radius
    }

    func area() -> Double {
        let area = (22/7) * pow(radius, 2)
        return area
    }

    func parameter() -> Double {
        return 2 * (22/7) * radius
    }
}

enum GeometricalShapes:Int, CaseIterable {
    case triangle = 0
    case rectangle
    case square
    case circle

    var numberOfPoints: Int {
        switch self {
            case .triangle:
                return 3
            case .rectangle, .square:
                return 4
            default:
                return 0
        }
    }

    var index: Int {
        return rawValue
    }

    var name: String {
        switch self {
            case .triangle:
                return "Triangle"
            case .rectangle:
                return "Rectangle"
            case .square:
                return "Square"
            case .circle:
                return "Circle"
        }
    }
}

struct GeometricalShapeReader {
    init () {
        print("Welcome to Geometrical Reader!")
    }

    func chooseShape() -> GeometricalShapes? {
        print("Please choose the shape from below options:")

        let allShapes = GeometricalShapes.allCases
        for shape in allShapes {
            print("\(shape.index + 1): \(shape.name)")
        }

        print("Type-in your choice:", separator: " ", terminator: " ")

        guard let chosenShape = readLine(), let shape = Int(chosenShape), shape >= 1 && shape <= allShapes.count  else { return chooseShape() }
        return GeometricalShapes(rawValue: shape - 1)
    }

    func read() -> GeometricalShapable {
        if let shape: GeometricalShapes = chooseShape() {
            var points: [Point] = []
            if (shape != .circle) {
                print("Please enter the coodinates of the \(shape.name) in 'x,y' format with whole numbers only. e.g: 2,3")
                points.reserveCapacity(shape.numberOfPoints)
                for _ in 1...shape.numberOfPoints {
                    points.append(readPoint())
                }
                switch shape {
                    case .triangle:
                        return Triangle(points: points)
                    case .rectangle:
                        return Rectangle(points: points)
                    case .square:
                        return Square(points: points)
                    default:
                        return Triangle(points: points)
                }
            } else {
                print("Please enter the radius of the \(shape.name):")
                return Circle(radius: readNumber())
            }
        } else {
            return read()
        }
    }

    private func readPoint() -> Point {
        print("Enter the first coordinate point in x,y format in numbers only:")
        let enteredPointInString = readLine()

        guard let point = enteredPointInString else {
            print("Please don't enter Empty values. Enter the values again.")
            return readPoint()
        }

        let arrayOfPoints = point.components(separatedBy: ",")
        if arrayOfPoints.count == 2, let x = Int(arrayOfPoints[0]), let y = Int(arrayOfPoints[1]) {
            return Point(x: x, y: y)
        }
        print("Please enter valid Coordinates")
        return readPoint()
    }

    private func readNumber() -> Double {
        print("Enter the radius of circle in number only with or without decimals:")
        let enteredNumber = readLine()

        guard let number = enteredNumber else {
            print("Please don't enter Empty values. Enter the values again.")
            return readNumber()
        }

        if let doubleNumber = Double(number) {
            return doubleNumber
        }
        print("Please enter valid radius")
        return readNumber()
    }
}


//let reader = GeometricalShapeReader()
//let triangle = reader.read()
let triangle = Triangle(points: [Point(x: 1, y: 2), Point(x: 2, y: 3), Point(x: 3, y: 4)])
print("Area: \(triangle.area())")
print("Parameter: \(triangle.parameter())")
//: [Next](@next)
