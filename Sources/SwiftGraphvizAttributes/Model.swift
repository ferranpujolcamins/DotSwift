import Foundation

public protocol AttributeProtocol {
    var name: String { get }
    var valueString: String { get }
}

public protocol Attribute: AttributeProtocol {
    associatedtype T: CustomStringConvertible

    var name: String { get }
    var value: T { get }
}

public extension Attribute {
    var name: String {
        return String(describing: type(of: self))
    }

    var valueString: String {
        return value.description
    }
}

public protocol GraphAttributeProtocol: AttributeProtocol {}
public protocol NodeAttributeProtocol: AttributeProtocol {}
public protocol EdgeAttributeProtocol: AttributeProtocol {}

public protocol GraphAttribute: Attribute, GraphAttributeProtocol {}
public protocol NodeAttribute: Attribute, NodeAttributeProtocol {}
public protocol EdgeAttribute: Attribute, EdgeAttributeProtocol {}

public struct AnyAttribute: AttributeProtocol {
    let attribute: AttributeProtocol

    public init(_ attribute: AttributeProtocol) {
        self.attribute = attribute
    }

    public var name: String {
        return attribute.name
    }

    public var valueString: String {
        return attribute.valueString
    }
}

public struct AnyGraphAttribute: GraphAttributeProtocol {
    let attribute: GraphAttributeProtocol

    public init(_ attribute: GraphAttributeProtocol) {
        self.attribute = attribute
    }

    public var name: String {
        return attribute.name
    }

    public var valueString: String {
        return attribute.valueString
    }
}

public struct AnyNodeAttribute: NodeAttributeProtocol {
    let attribute: NodeAttributeProtocol

    public init(_ attribute: NodeAttributeProtocol) {
        self.attribute = attribute
    }

    public var name: String {
        return attribute.name
    }

    public var valueString: String {
        return attribute.valueString
    }
}

public struct AnyEdgeAttribute: EdgeAttributeProtocol {
    let attribute: EdgeAttributeProtocol

    public init(_ attribute: EdgeAttributeProtocol) {
        self.attribute = attribute
    }

    public var name: String {
        return attribute.name
    }

    public var valueString: String {
        return attribute.valueString
    }
}
