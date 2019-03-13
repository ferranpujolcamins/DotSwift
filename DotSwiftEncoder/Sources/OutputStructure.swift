import DotSwiftAttributes

protocol Renderable {
    func render() -> String
}

extension String: Renderable {
    func render() -> String {
        return self
    }
}

extension AnyAttribute: Renderable {
    func render() -> String {
        return "\(name) = \"\(valueString)\""
    }
}

extension AnyGraphAttribute: Renderable {
    func render() -> String {
        return "\(name) = \"\(valueString)\";"
    }
}

extension AnyNodeAttribute: Renderable {
    func render() -> String {
        return "\(name) = \"\(valueString)\""
    }
}

extension AnyEdgeAttribute: Renderable {
    func render() -> String {
        return "\(name) = \"\(valueString)\""
    }
}

extension Array: Renderable where Element: Renderable {
    func render() -> String {
        return map { $0.render() }.joined(separator: ", ")
    }
}

struct AttributedLine: Renderable {
    var content: Renderable
    var attributes: [AnyAttribute]

    // Initialize an empty line
    public init() {
        content = ""
        attributes = []
    }

    // Initialize an AttributedLine: Renderable {
    public init(_ content: Renderable) {
        self.content = content
        self.attributes = []
    }

    public init(content: Renderable, attributes: [AnyAttribute]) {
        self.content = content
        self.attributes = attributes
    }

    func render() -> String {
        let joinedAttributes = attributes.render()
        if joinedAttributes.count == 0 {
            return content.render() + ";"
        }
        return content.render() + " [" + joinedAttributes + "]" + ";"
    }
}

struct IndentedLine: Renderable {
    let content: Renderable
    let indentation: Int

    func render() -> String {
        return String(repeating: " ", count: indentation) + content.render()
    }
}

struct LinesBlock: Renderable {
    let lines: [Renderable]

    init(_ lines: [Renderable]) {
        self.lines = lines
    }

    func indented(by indentation: Int) -> LinesBlock {
        return LinesBlock(lines.map { IndentedLine(content: $0, indentation: indentation) })
    }

    func render() -> String {
        return lines.map { $0.render() }.joined(separator: "\n")
    }
}

public enum GraphType: String {
    case graph
    case digraph
}

public struct DotFile: Renderable {
    let type: GraphType
    let graphAttributes: LinesBlock
    let nodes: LinesBlock
    let edges: LinesBlock

    func render() -> String {

        let innerLines = [graphAttributes, nodes, edges]
            .map { $0.indented(by: 4) }
            .map { $0.render() }
            .filter { $0.trimmingCharacters(in: .whitespaces).count > 0 }
            .joined(separator: "\n\n")

        return """
        \(type.rawValue) {
        \(innerLines)
        }
        """
    }
}

extension DotFile {
    func lineFor(node: Node) -> AttributedLine {
        return AttributedLine(
            content: String(format: "%i", node.id),
            attributes: [AnyAttribute(Attributes.label(node.label))]
        )
    }

    func lineFor(edge: Edge) -> AttributedLine {
        let arrow: String

        switch type {
        case .graph:
            arrow = "--"
        case .digraph:
            arrow = "->"
        }

        return AttributedLine(
            content: "\(edge.u.id) \(arrow) \(edge.v.id)",
            attributes: []
        )
    }
}
