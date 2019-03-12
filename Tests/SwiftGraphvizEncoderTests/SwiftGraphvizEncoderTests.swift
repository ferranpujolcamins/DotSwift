import XCTest
@testable import SwiftGraphvizAttributes
@testable import SwiftGraphvizEncoder

class SwiftGraphvizEncoderTests: XCTestCase {

    func testExample() {
        let nodeA = Node(id: 0, label: "A")
        let nodeB = Node(id: 1, label: "B")
        let nodeC = Node(id: 2, label: "C")

        let graph = Graph(nodes: [nodeA, nodeB, nodeC], edges: [])

        let file = GraphvizEncoder(type: .digraph).encode(graph)

        XCTAssertEqual(file, """
        digraph {
            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];
        }
        """)
    }

    func testExample2() {
        let nodeA = Node(id: 0, label: "A")
        let nodeB = Node(id: 1, label: "B")
        let nodeC = Node(id: 2, label: "C")

        let graph = Graph(nodes: [nodeA, nodeB, nodeC], edges: [Edge(u: nodeA, v: nodeB, label: "e")])

        let file = GraphvizEncoder(type: .digraph).encode(graph)

        XCTAssertEqual(file, """
        digraph {
            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];

            0 -> 1;
        }
        """)
    }

    func testExample3() {
        let nodeA = Node(id: 0, label: "A")
        let nodeB = Node(id: 1, label: "B")
        let nodeC = Node(id: 2, label: "C")

        let graphAttributes = [AnyGraphAttribute(
            Attributes.bgcolor(value: ColorList([Color.name("blue")]))
        )]

        let graph = Graph(nodes: [nodeA, nodeB, nodeC], edges: [Edge(u: nodeA, v: nodeB, label: "e")])

        let file = GraphvizEncoder(type: .graph, graphAttributes: graphAttributes).encode(graph)

        XCTAssertEqual(file, """
        graph {
            bgcolor = "blue";

            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];

            0 -- 1;
        }
        """)
    }

    func testExample4() {
        let nodeA = Node(id: 0, label: "A")
        let nodeB = Node(id: 1, label: "B")
        let nodeC = Node(id: 2, label: "C")

        let graph = Graph(nodes: [nodeA, nodeB, nodeC], edges: [Edge(u: nodeA, v: nodeB, label: "e")])

        let file = GraphvizEncoder(
            type: .digraph,
            graphAttributes: [
                AnyGraphAttribute(Attributes.bgcolor(value: ColorList([Color.name("blue")]))),
                AnyGraphAttribute(Attributes.fontname(value: "Arial")),
            ],
            nodeAttributes: { (node) -> [AnyNodeAttribute] in
                if node.id != 2 {
                    return []
                }
                return [
                    AnyNodeAttribute(Attributes.color(value: ColorList([Color.name("red")])))
                ]
            },
            edgeAttributes: { (edge) -> [AnyEdgeAttribute] in
                return [
                    AnyEdgeAttribute(Attributes.color(value: ColorList([Color.name("red")])))
                ]
            })
            .encode(graph)

        XCTAssertEqual(file, """
        digraph {
            bgcolor = "blue";
            fontname = "Arial";

            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C", color = "red"];

            0 -> 1 [color = "red"];
        }
        """)
    }
}
