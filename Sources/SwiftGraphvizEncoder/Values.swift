import SwiftGraphvizAttributes

struct Node {
    let id: Int
    let label: String
}

struct Edge {
    let u: Node
    let v: Node

    let label: String
}

extension AttributedLine {
    init(_ node: Node) {
        self.init(
            content: String(format: "%i", node.id),
            attributes: [AnyAttribute(Attributes.label(node.label))]
        )
    }

    init(_ edge: Edge) {
        self.init(
            content: "\(edge.u.id) -> \(edge.v.id)",
            attributes: []
        )
    }
}
