import DotSwiftAttributes

public struct Node {
    let id: Int
    let label: String
}

public struct Edge {
    let u: Node
    let v: Node

    let label: String
}

public struct Graph {
    var nodes: [Node]
    var edges: [Edge]
}

public struct DOTEncoder {
    public typealias GraphAttributes = [GraphAttributeProtocol]
    public typealias NodeAttributes = (Node) -> [NodeAttributeProtocol]
    public typealias EdgeAttributes = (Edge) -> [EdgeAttributeProtocol]

    let type: GraphType
    let graphAttributes: GraphAttributes
    let nodeAttributes: NodeAttributes?
    let edgeAttributes: EdgeAttributes?

    init(type: GraphType,
         graphAttributes: GraphAttributes = [],
         nodeAttributes: NodeAttributes? = nil,
         edgeAttributes: EdgeAttributes? = nil) {

        self.type = type
        self.graphAttributes = graphAttributes
        self.nodeAttributes = nodeAttributes
        self.edgeAttributes = edgeAttributes
    }

    func encode(_ graph: Graph) -> String {
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
            let content = render(edge)
            return AttributedLine(content: content, attributes: (edgeAttributes?(edge) ?? []).map { AnyAttribute($0)} )
        }
    }

    private func render(_ node: Node) -> (content: String, attributes: [AnyNodeAttribute]) {
        return (
            content: String(format: "%i", node.id),
            attributes: [AnyNodeAttribute(Attributes.label(node.label))]
        )
    }

    private func render(_ edge: Edge) -> String {
        switch type {
        case .graph:
            return "\(edge.u.id) -- \(edge.v.id)"
        case .digraph:
            return "\(edge.u.id) -> \(edge.v.id)"
        }
    }
}
