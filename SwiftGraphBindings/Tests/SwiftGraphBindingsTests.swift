import XCTest
import SwiftGraph
import DotSwiftEncoder

@testable import SwiftGraphBindings

class SwiftGraphBindingsTests: XCTestCase {
    func testWeightedGraphDirected() {
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

    func testUnweightedGraphDirected() {
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

    func testWeightedGraphUndirected() {
        let g = WeightedGraph<String, String>(vertices: ["A", "B", "C"])
        g.addEdge(from: "A", to: "B", weight: "AB", directed: false)
        g.addEdge(from: "A", to: "B", weight: "AB2", directed: false)
        g.addEdge(from: "A", to: "A", weight: "AA", directed: false)
        g.addEdge(from: "A", to: "C", weight: "AC", directed: false)
        g.addEdge(from: "B", to: "C", weight: "BC", directed: false)

        let dotString = DOTEncoder(type: .digraph).encode(g)
        XCTAssertEqual(dotString, """
        digraph {
            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];

            0 -> 1 [label = "AB", dir = "none"];
            0 -> 1 [label = "AB2", dir = "none"];
            0 -> 0 [label = "AA", dir = "none"];
            0 -> 2 [label = "AC", dir = "none"];
            1 -> 2 [label = "BC", dir = "none"];
        }
        """)
    }

    func testUnweightedGraphUndirected() {
        let g = UnweightedGraph<String>(vertices: ["A", "B", "C"])
        g.addEdge(from: "A", to: "B", directed: false)
        g.addEdge(from: "A", to: "B", directed: false)
        g.addEdge(from: "A", to: "A", directed: false)
        g.addEdge(from: "A", to: "C", directed: false)
        g.addEdge(from: "B", to: "C", directed: false)

        let dotString = DOTEncoder(type: .digraph).encode(g)
        XCTAssertEqual(dotString, """
        digraph {
            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];

            0 -> 1 [dir = "none"];
            0 -> 1 [dir = "none"];
            0 -> 0 [dir = "none"];
            0 -> 2 [dir = "none"];
            1 -> 2 [dir = "none"];
        }
        """)
    }

    func testUnweightedGraphMixe() {
        let g = UnweightedGraph<String>(vertices: ["A", "B", "C"])
        g.addEdge(from: "A", to: "B", directed: false)
        g.addEdge(from: "A", to: "B", directed: false)
        g.addEdge(from: "A", to: "A", directed: true)
        g.addEdge(from: "A", to: "C", directed: false)
        g.addEdge(from: "B", to: "C", directed: true)

        let dotString = DOTEncoder(type: .digraph).encode(g)
        XCTAssertEqual(dotString, """
        digraph {
            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];

            0 -> 1 [dir = "none"];
            0 -> 1 [dir = "none"];
            0 -> 0;
            0 -> 2 [dir = "none"];
            1 -> 2;
        }
        """)
    }

    func testWeightedGraphMixed() {
        let g = WeightedGraph<String, String>(vertices: ["A", "B", "C"])
        g.addEdge(from: "A", to: "B", weight: "AB", directed: false)
        g.addEdge(from: "A", to: "B", weight: "AB2", directed: true)
        g.addEdge(from: "A", to: "A", weight: "AA", directed: false)
        g.addEdge(from: "A", to: "C", weight: "AC", directed: true)
        g.addEdge(from: "B", to: "C", weight: "BC", directed: false)

        let dotString = DOTEncoder(type: .digraph).encode(g)
        XCTAssertEqual(dotString, """
        digraph {
            0 [label = "A"];
            1 [label = "B"];
            2 [label = "C"];

            0 -> 1 [label = "AB", dir = "none"];
            0 -> 1 [label = "AB2"];
            0 -> 0 [label = "AA", dir = "none"];
            0 -> 2 [label = "AC"];
            1 -> 2 [label = "BC", dir = "none"];
        }
        """)
    }
}
