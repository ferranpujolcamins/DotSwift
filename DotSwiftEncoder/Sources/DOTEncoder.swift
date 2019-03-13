import DotSwiftAttributes

public struct Node {
    public let id: Int
    public let label: String

    public init(id: Int, label: String) {
        self.id = id
        self.label = label
    }
}

public struct Edge {
    public let u: Node
    public let v: Node

    public let label: String?

    public init(u: Node, v: Node, label: String?) {
        self.u = u
        self.v = v

        self.label = label
    }
}

public struct Graph {
    public var nodes: [Node]
    public var edges: [Edge]

    public init(nodes: [Node], edges: [Edge]) {
        self.nodes = nodes
        self.edges = edges
    }
}

public struct DOTEncoder {
    public typealias GraphAttributes = [GraphAttributeProtocol]
    public typealias NodeAttributes = (Node) -> [NodeAttributeProtocol]
    public typealias EdgeAttributes = (Edge) -> [EdgeAttributeProtocol]

    private let type: GraphType
    private let graphAttributes: GraphAttributes
    private let nodeAttributes: NodeAttributes?
    private let edgeAttributes: EdgeAttributes?

    public init(type: GraphType,
         graphAttributes: GraphAttributes = [],
         nodeAttributes: NodeAttributes? = nil,
         edgeAttributes: EdgeAttributes? = nil) {

        self.type = type
        self.graphAttributes = graphAttributes
        self.nodeAttributes = nodeAttributes
        self.edgeAttributes = edgeAttributes
    }

    public func encode(_ graph: Graph) -> String {
        return DotFile(
            type: type,
            graphAttributes: LinesBlock(graphAttributes.map { AnyGraphAttribute($0) }),
            nodes: LinesBlock(lines(for: graph.nodes)),
            edges: LinesBlock(lines(for: graph.edges))
        ).render()
    }

    private func lines(for nodes: [Node]) -> [AttributedLine] {
        return nodes.map { node in
            let (content, attributes) = render(node)
            return AttributedLine(content: content, attributes: (attributes + (nodeAttributes?(node) ?? [])).map { AnyAttribute($0)} )
        }
    }

    private func lines(for edges: [Edge]) -> [AttributedLine] {
        return edges.map { edge in
            let (content, attributes) = render(edge)
            return AttributedLine(content: content, attributes: (attributes + (edgeAttributes?(edge) ?? [])).map { AnyAttribute($0)} )
        }
    }

    private func render(_ node: Node) -> (content: String, attributes: [AnyNodeAttribute]) {
        return (
            content: String(format: "%i", node.id),
            attributes: [AnyNodeAttribute(Attributes.label(node.label))]
        )
    }

    private func render(_ edge: Edge) -> (content: String, attributes: [AnyEdgeAttribute]) {
        let content: String

        switch type {
        case .graph:
            content = "\(edge.u.id) -- \(edge.v.id)"
        case .digraph:
            content = "\(edge.u.id) -> \(edge.v.id)"
        }

        let attributes: [AnyEdgeAttribute]
        if let label = edge.label {
            attributes = [AnyEdgeAttribute(Attributes.label(label))]
        } else {
            attributes = []
        }

        return (
            content: content,
            attributes: attributes
        )
    }
}
