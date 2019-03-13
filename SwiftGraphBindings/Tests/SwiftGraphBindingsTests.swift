import XCTest
import SwiftGraph
import DotSwiftEncoder

@testable import SwiftGraphBindings

class SwiftGraphBindingsTests: XCTestCase {
    func testWeightedGraph() {
        let g = WeightedGraph<String, String>(vertices: ["A", "B", "C"])
        g.addEdge(from: "A", to: "B", weight: "AB", directed: true)
        g.addEdge(from: "A", to: "C", weight: "AC", directed: true)
        g.addEdge(from: "B", to: "C", weight: "BC", directed: true)

        let dotString = DOTEncoder(type: .digraph).encode(g)
        XCTAssertEqual(dotString, """
        digraph {
            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];

            0 -> 1 [label = "AB"];
            0 -> 2 [label = "AC"];
            1 -> 2 [label = "BC"];
        }
        """)
    }

    func testUnweightedGraph() {
        let g = UnweightedGraph<String>(vertices: ["A", "B", "C"])
        g.addEdge(from: "A", to: "B", directed: true)
        g.addEdge(from: "A", to: "C", directed: true)
        g.addEdge(from: "B", to: "C", directed: true)

        let dotString = DOTEncoder(type: .digraph).encode(g)
        XCTAssertEqual(dotString, """
        digraph {
            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];

            0 -> 1;
            0 -> 2;
            1 -> 2;
        }
        """)
    }
}
