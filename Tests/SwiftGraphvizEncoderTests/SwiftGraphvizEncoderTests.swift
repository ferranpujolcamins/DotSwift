import XCTest
@testable import SwiftGraphvizEncoder

class SwiftGraphvizEncoderTests: XCTestCase {

    func testExample() {
        let nodeA = Node(id: 0, label: "A")
        let nodeB = Node(id: 1, label: "B")
        let nodeC = Node(id: 2, label: "C")
        let vertices = [
            nodeA,
            nodeB,
            nodeC
        ].map { AttributedLine($0) }

        let edges = [Renderable]()

        let file = DotFile(
            type: .digraph,
            graphAttributes: LinesBlock([]),
            vertices: LinesBlock(vertices),
            edges: LinesBlock(edges)
            ).render()

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
        let vertices = [
            nodeA,
            nodeB,
            nodeC
        ].map { AttributedLine($0) }

        let edges = [
            Edge(u: nodeA, v: nodeB, label: "e")
        ].map { AttributedLine($0) }

        let file = DotFile(
            type: .digraph,
            graphAttributes: LinesBlock([]),
            vertices: LinesBlock(vertices),
            edges: LinesBlock(edges)
        ).render()

        XCTAssertEqual(file, """
        digraph {
            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];

            0 -> 1;
        }
        """)
    }
}
