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
    public let directed: Bool

    public let label: String?

    public init(u: Node, v: Node, directed: Bool, label: String?) {
        self.u = u
        self.v = v
        self.directed = directed

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
    public typealias AttributesForGraph = [GraphAttributeProtocol]
    public typealias AttributesForNodes = (Node) -> [NodeAttributeProtocol]
    public typealias AttributesForEdges = (Edge) -> [EdgeAttributeProtocol]

    private let type: GraphType
    private let graphAttributes: AttributesForGraph
    private let nodeAttributes: AttributesForNodes?
    private let edgeAttributes: AttributesForEdges?

    public init(type: GraphType,
         graphAttributes: AttributesForGraph = [],
         nodeAttributes: AttributesForNodes? = nil,
         edgeAttributes: AttributesForEdges? = nil) {

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
            attributes: [AnyNodeAttribute(NodeAttributes.label(node.label))]
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

        var attributes = [AnyEdgeAttribute]()
        if let label = edge.label {
            attributes.append(AnyEdgeAttribute(EdgeAttributes.label(label)))
        }
        if !edge.directed {
            attributes.append(AnyEdgeAttribute(EdgeAttributes.dir(.none)))
        }

        return (
            content: content,
            attributes: attributes
        )
    }
}
