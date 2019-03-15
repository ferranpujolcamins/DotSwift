import DotSwiftEncoder
import SwiftGraph

extension DOTEncoder {
    func encode<G>(_ graph: G) -> String where G: SwiftGraph.Graph,
        G.V: CustomStringConvertible, G.E: DOTPrintableEdge,
        G.Element == G.V { // Why do we even need this constraints?

        let nodes = graph.enumerated().map { arg -> Node in
            let (i, v) = arg
            return Node(id: i, label: v.description)
        }

        let edges = graph.edgeList().map {
            Edge(
                u: Node(id: $0.u, label: graph[$0.u].description),
                v: Node(id: $0.v, label: graph[$0.v].description),
                directed: $0.directed,
                label: $0.dotLabel()
            )
        }
        return encode(Graph(nodes: nodes, edges: edges))
    }
}

protocol DOTPrintableEdge {
    func dotLabel() -> String?
}

extension DOTPrintableEdge {
    func dotLabel() -> String? {
        return nil
    }
}

extension UnweightedEdge: DOTPrintableEdge {}

extension WeightedEdge: DOTPrintableEdge where W: CustomStringConvertible {
    func dotLabel() -> String? {
        return weight.description
    }
}
