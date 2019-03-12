import Foundation

public enum Add<T: CustomStringConvertible>: CustomStringConvertible {
    case plus(T)
    case none(T)

    public var description: String {
        switch self {
        case let .plus(value):
            return "+" + value.description
        case let .none(value):
            return value.description
        }
    }
}

public typealias ArrowType = String

public struct List<T: CustomStringConvertible>: CustomStringConvertible {
    let elements: [T]

    init(_ elements: [T]) {
        self.elements = elements
    }

    public var description: String {
        return elements.map { $0.description }.joined(separator: ", ")
    }
}

public struct Rect: CustomStringConvertible {
    public let lowerLeft: Point
    public let upperRight: Point

    init(lowerLeft: Point, upperRight: Point) {
        self.lowerLeft = lowerLeft
        self.upperRight = upperRight
    }

    init(_ llx: Double, _ lly: Double, _: Double, _: Double) {
        self.init(lowerLeft: Point(llx, lly), upperRight: Point(llx, lly))
    }

    public var description: String {
        return String(format: "%f,%f,%f,%f", lowerLeft.x, lowerLeft.y, upperRight.x, upperRight.y)
    }
}

public struct Point: CustomStringConvertible {
    public let x: Double
    public let y: Double

    init(_ value: Double) {
        self.init(value, value)
    }

    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }

    public var description: String {
        return String(format: "%f,%f", x, y)
    }
}

public enum Color: CustomStringConvertible {
    case rgb(r: Int, g: Int, b: Int)
    case rgba(r: Int, g: Int, b: Int, a: Int)
    case hsv(h: Double, s: Double, v: Double)
    case name(String)

    public var description: String {
        switch self {
        case let .rgb(r, g, b):
            return String(format: "#%2x%2x%2x", r, g, b)
        case let .rgba(r, g, b, a):
            return String(format: "#%2x%2x%2x%2x", r, g, b, a)
        case let .hsv(h, s, v):
            return String(format: "%f,%f,%f", h, s, v)
        case let .name(name):
            return name
        }
    }
}

public enum DirType: String, CustomStringConvertible {
    case forward
    case back
    case both
    case none

    public var description: String {
        return rawValue
    }
}

public typealias AddDouble = Add<Double>
public typealias LblString = String
public typealias EscString = String
public typealias LayerList = List<String>
public typealias LayerRange = String

public struct PortPos: CustomStringConvertible {
    public enum CompassPoint: String, CustomStringConvertible {
        case n
        case ne
        case e
        case se
        case s
        case sw
        case w
        case nw
        case c
        case __

        public var description: String {
            return rawValue
        }
    }

    public let portname: String?
    public let compassPoint: CompassPoint?

    init(compassPoint: CompassPoint) {
        portname = nil
        self.compassPoint = compassPoint
    }

    init(portname: String, compassPoint: CompassPoint?) {
        self.portname = portname
        self.compassPoint = compassPoint
    }

    public var description: String {
        switch (portname, compassPoint?.description) {
        case let (portname?, compassPoint?):
            return portname + ":" + compassPoint
        case (let portname?, nil):
            return portname
        case (nil, let compassPoint?):
            return compassPoint
        default:
            fatalError()
        }
    }
}

public enum OutputMode: String, CustomStringConvertible {
    case breadthfirst
    case nodesfirst
    case edgesfirst

    public var description: String {
        return rawValue
    }
}

public enum PackMode: String, CustomStringConvertible {
    case node
    case clust
    case graph
    // case array

    public var description: String {
        return rawValue
    }
}

public enum PageDir: String, CustomStringConvertible {
    case BL
    case BR
    case TL
    case TR
    case RB
    case RT
    case LB
    case LT

    public var description: String {
        return rawValue
    }
}

public enum QuadType: String, CustomStringConvertible {
    case normal
    case fast
    case none

    public var description: String {
        return rawValue
    }
}

public enum RankDir: String, CustomStringConvertible {
    case same
    case min
    case source
    case max
    case sink

    public var description: String {
        return rawValue
    }
}

public typealias Shape = String

public enum SmoothType: String, CustomStringConvertible {
    case none
    case avg_dist
    case graph_dist
    case power_dist
    case rng
    case spring
    case triangle

    public var description: String {
        return rawValue
    }
}

public struct StartType: CustomStringConvertible {
    public enum Style: String {
        case regular
        case _self
        case random
    }

    public enum Seed: CustomStringConvertible {
        case seed(UInt)
        case time

        public var description: String {
            switch self {
            case let .seed(s):
                return String(format: "%i", s)
            case .time:
                return "time"
            }
        }
    }

    public let style: Style?
    public let seed: Seed?

    static func random() -> StartType {
        return StartType(style: .random, seed: .time)
    }

    public var description: String {
        return (style?.rawValue ?? "") + (seed?.description ?? "")
    }
}

public typealias Style = String
public typealias PointList = List<Point>
public typealias ColorList = List<Color>
public typealias AddPoint = Add<Point>

public enum ViewPort: CustomStringConvertible {
    case position(w: Double, h: Double, z: Double, x: Double, y: Double)
    case node(w: Double, h: Double, z: Double, N: String)

    public var description: String {
        switch self {
        case let .position(w, h, z, x, y):
            return String(format: "%lf,%lf,%lf,%lf,%lf", w, h, z, x, y)
        case let .node(w, h, z, n):
            return String(format: "%lf,%lf,%lf,'%s'", w, h, z, n)
        }
    }
}
