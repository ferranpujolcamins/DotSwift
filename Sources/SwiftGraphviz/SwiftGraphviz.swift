import Foundation

enum DoubleOrPoint {
    case double(Double)
    case point(Point)

    init(_ value: Double) {
        self = .double(value)
    }

    init(_ value: Point) {
        self = .point(value)
    }
}

enum Add<T> {
    case plus(T)
    case none(T)
}

protocol Attribute {
    associatedtype T

    static var name: String { get }
    var value: T { get }
}

extension Attribute {
    static var name: String {
        return String(describing: type(of: self))
    }
}

protocol GraphAttribute: Attribute {}
protocol NodeAttribute: Attribute {}
protocol EdgeAttribute: Attribute {}

typealias ArrowType = String

struct Rect {
    let lowerLeft: Point
    let upperRight: Point

    init(lowerLeft: Point, upperRight: Point) {
        self.lowerLeft = lowerLeft
        self.upperRight = upperRight
    }

    init(_ llx: Double, _ lly: Double, _ upx: Double, _ upy: Double) {
        self.init(lowerLeft: Point(llx, lly), upperRight: Point(llx, lly))
    }
}

struct Point {
    let x: Double
    let y: Double

    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
}

enum Color {
    case rgba(r: Double, g: Double, b: Double, a: Double)
    case hsv(h: Double, s: Double, v: Double)
    case name(String)
}

enum DirType {
    case forward
    case back
    case both
    case none
}

enum Target {
    case _graphviz
    case undefined
}

typealias AddDouble = Add<Double>
typealias LblString = String
typealias PortPos = ()
typealias LayerList = [String]
typealias LayerRange = ()

enum OutputMode {
    case breadthfirst
    case nodesfirst
    case edgesfirst
}

enum PackMode {
    case node
    case clust
    case graph
    //case array
}

enum PageDir {
    case BL
    case BR
    case TL
    case TR
    case RB
    case RT
    case LB
    case LT
}

enum QuadType {
    case normal
    case fast
    case none
}

enum RankDir {
    case same
    case min
    case source
    case max
    case sink
}

typealias Shape = ()

enum SmoothType {
    case none
    case avg_dist
    case graph_dist
    case power_dist
    case rng
    case spring
    case triangle
}

struct StartType {
    enum Style {
        case regular
        case _self
        case random
    }
    enum Seed {
        case see(UInt)
        case time
    }
    let style: Style?
    let seed: Seed?

    static func random() -> StartType {
        return StartType(style: .random, seed: .time)
    }
}
typealias Style = ()
typealias PointList = Array<Point>
typealias ViewPort = ()
typealias ColorList = ()
typealias AddPoint = Add<Point>

enum Attributes {

/// Factor damping force motions. On each iteration, a nodes movement is limited to this factor of its potential motion. By being less than 1.0, the system tends to ``cool'', thereby preventing cycling.
struct Damping: GraphAttribute {
    let value: Double
}

/// Spring constant used in virtual physical model. It roughly corresponds to an ideal edge length (in inches), in that increasing K tends to increase the distance between nodes. Note that the edge attribute len can be used to override this value for adjacent nodes.
struct K: GraphAttribute {
    let value: Double
}

/// Hyperlinks incorporated into device-dependent output. At present, used in ps2, cmap, i*map and svg formats.
///
/// For all these formats, URLs can be attached to nodes, edges and clusters. URL attributes can also be attached to the root graph in ps2, cmap and i*map formats. This serves as the base URL for relative URLs in the former, and as the default image map file in the latter.
///
/// For svg, cmapx and imap output, the active area for a node is its visible image. For example, an unfilled node with no drawn boundary will only be active on its label. For other output, the active area is its bounding box. The active area for a cluster is its bounding box. For edges, the active areas are small circles where the edge contacts its head and tail nodes. In addition, for svg, cmapx and imap, the active area includes a thin polygon approximating the edge. The circles may overlap the related node, and the edge URL dominates. If the edge has a label, this will also be active. Finally, if the edge has a head or tail label, this will also be active.
///
/// Note that, for edges, the attributes headURL, tailURL, labelURL and edgeURL allow control of various parts of an edge. Also note that, if active areas of two edges overlap, it is unspecified which area dominates.
struct URL: GraphAttribute & NodeAttribute & EdgeAttribute {
    let value: String
}

/// A string in the xdot format specifying an arbitrary background. During rendering, the canvas is first filled as described in the bgcolor attribute. Then, if _background is defined, the graphics operations described in the string are performed on the canvas.
struct _background: GraphAttribute {
    let value: String
}

/// Indicates the preferred area for a node or empty cluster when laid out by patchwork.
struct area: NodeAttribute {
    let value: Double
}

/// Style of arrowhead on the head node of an edge. This will only appear if the dir attribute is "forward" or "both". See the [limitation](https://www.graphviz.org/doc/info/attrs.html#h:undir_note).
struct arrowhead: EdgeAttribute {
    let value: ArrowType
}

/// Multiplicative scale factor for arrowheads.
struct arrowsize: EdgeAttribute {
    let value: Double
}

/// Style of arrowhead on the tail node of an edge. This will only appear if the dir attribute is "back" or "both". See the [limitation](https://www.graphviz.org/doc/info/attrs.html#h:undir_note).
struct arrowtail: EdgeAttribute {
    let value: ArrowType
}

/// Bounding box of drawing in points.
struct bb: GraphAttribute {
    let value: Rect
}

/// When attached to the root graph, this color is used as the background for entire canvas. When a cluster attribute, it is used as the initial background for the cluster. If a cluster has a filled style, the cluster's fillcolor will overlay the background color.
///
/// If the value is a colorList, a gradient fill is used. By default, this is a linear fill; setting style=radial will cause a radial fill. At present, only two colors are used. If the second color (after a colon) is missing, the default color is used for it. See also the gradientangle attribute for setting the gradient angle.
///
/// For certain output formats, such as PostScript, no fill is done for the root graph unless bgcolor is explicitly set. For bitmap formats, however, the bits need to be initialized to something, so the canvas is filled with white by default. This means that if the bitmap output is included in some other document, all of the bits within the bitmap's bounding box will be set, overwriting whatever color or graphics were already on the page. If this effect is not desired, and you only want to set bits explicitly assigned in drawing the graph, set bgcolor="transparent".
struct bgcolor: GraphAttribute {
    let value: ColorList
}

/// If true, the drawing is centered in the output canvas.
struct center: GraphAttribute {
    let value: Bool
}

/// Specifies the character encoding used when interpreting string input as a text label. The default value is "UTF-8". The other legal value is "iso-8859-1" or, equivalently, "Latin1". The charset attribute is case-insensitive. Note that if the character encoding used in the input does not match the charset value, the resulting output may be very strange.
struct charset: GraphAttribute {
    enum Value {
        case utf_8
        case iso_8859_1
        case latin1
    }
    let value: Value
}

/// Mode used for handling clusters. If clusterrank is "local", a subgraph whose name begins with "cluster" is given special treatment. The subgraph is laid out separately, and then integrated as a unit into its parent graph, with a bounding rectangle drawn about it. If the cluster has a label parameter, this label is displayed within the rectangle. Note also that there can be clusters within clusters. At present, the modes "global" and "none" appear to be identical, both turning off the special cluster processing.
struct clusterrank: GraphAttribute {
    enum Value {
        case local
        case global
        case none
    }
    let value: Value
}

/// Basic drawing color for graphics, not text. For the latter, use the fontcolor attribute.
///
/// For edges, the value can either be a single color or a colorList. In the latter case, if colorList has no fractions, the edge is drawn using parallel splines or lines, one for each color in the list, in the order given. The head arrow, if any, is drawn using the first color in the list, and the tail arrow, if any, the second color. This supports the common case of drawing opposing edges, but using parallel splines instead of separately routed multiedges. If any fraction is used, the colors are drawn in series, with each color being given roughly its specified fraction of the edge.
struct color: EdgeAttribute & NodeAttribute {
    let value: ColorList
}

/// This attribute specifies a color scheme namespace. If defined, it specifies the context for interpreting color names. In particular, if a color value has form "xxx" or "//xxx", then the color xxx will be evaluated according to the current color scheme. If no color scheme is set, the standard X11 naming is used. For example, if colorscheme=bugn9, then color=7 is interpreted as "/bugn9/7".
struct colorscheme: EdgeAttribute & NodeAttribute & GraphAttribute {
    let value: String
}

/// Comments are inserted into output. Device-dependent.
struct comment: EdgeAttribute & NodeAttribute & GraphAttribute {
    let value: String
}

/// If true, allow edges between clusters. (See lhead and ltail below.)
struct compound: GraphAttribute {
    let value: Bool
}

/// If true, use edge concentrators. This merges multiedges into a single edge and causes partially parallel edges to share part of their paths. The latter feature is not yet available outside of dot.
struct concentrate: GraphAttribute {
    let value: Bool
}

/// If false, the edge is not used in ranking the nodes.
struct constraint: EdgeAttribute {
    let value: Bool
}

/// If true, attach edge label to edge by a 2-segment polyline, underlining the label, then going to the closest point of spline.
struct decorate: EdgeAttribute {
    let value: Bool
}

/// This specifies the distance between nodes in separate connected components. If set too small, connected components may overlap. Only applicable if pack=false.
struct defaultdist: GraphAttribute {
    let value: Double
}

/// Set the number of dimensions used for the layout. The maximum value allowed is 10.
struct dim: GraphAttribute {
    let value: Int
}

/// Set the number of dimensions used for rendering. The maximum value allowed is 10. If both dimen and dim are set, the latter specifies the dimension used for layout, and the former for rendering. If only dimen is set, this is used for both layout and rendering dimensions.
///
/// Note that, at present, all aspects of rendering are 2D. This includes the shape and size of nodes, overlap removal, and edge routing. Thus, for dimen > 2, the only valid information is the pos attribute of the nodes. All other coordinates will be 2D and, at best, will reflect a projection of a higher-dimensional point onto the plane.
struct dimen: GraphAttribute {
    let value: Int
}

/// Set edge type for drawing arrowheads. This indicates which ends of the edge should be decorated with an arrowhead. The actual style of the arrowhead can be specified using the arrowhead and arrowtail attributes. See [limitation](https://www.graphviz.org/doc/info/attrs.html#h:undir_note).
struct dir: EdgeAttribute {
    let value: DirType
}

/// Only valid when mode="ipsep". If true, constraints are generated for each edge in the largest (heuristic) directed acyclic subgraph such that the edge must point downwards. If "hier", generates level constraints similar to those used with mode="hier". The main difference is that, in the latter case, only these constraints are involved, so a faster solver can be used.
struct diredgeconstraints: GraphAttribute {
    enum Value {
        case True
        case False
        case Hier

        init(_ value: Bool) {
            if value {
                self = .True
            } else {
                self = .False
            }
        }
    }
    let value: Value
}

/// Distortion factor for shape=polygon. Positive values cause top part to be larger than bottom; negative values do the opposite.
struct distortion: NodeAttribute {
    let value: Double
}

/// This specifies the expected number of pixels per inch on a display device. For bitmap output, this guarantees that text rendering will be done more accurately, both in size and in placement. For SVG output, it is used to guarantee that the dimensions in the output correspond to the correct number of points or inches.
struct dpi: GraphAttribute {
    let value: Double
}

/// If edgeURL is defined, this is the link used for the non-label parts of an edge. This value overrides any URL defined for the edge. Also, this value is used near the head or tail node unless overridden by a headURL or tailURL value, respectively. See [limitation](https://www.graphviz.org/doc/info/attrs.html#h:undir_note).
struct edgeURL: EdgeAttribute {
    let value: String
}

/// Synonym for edgeURL.
typealias edgehref = edgeURL

/// If the edge has a URL or edgeURL attribute, this attribute determines which window of the browser is used for the URL attached to the non-label part of the edge. Setting it to "_graphviz" will open a new window if it doesn't already exist, or reuse it if it does. If undefined, the value of the target is used.
struct edgetarget: EdgeAttribute {
    let value: Target
}

/// Tooltip annotation attached to the non-label part of an edge. This is used only if the edge has a URL or edgeURL attribute.
struct edgetooltip: EdgeAttribute {
    let value: String
}

/// Terminating condition. If the length squared of all energy gradients are < epsilon, the algorithm stops.
struct epsilon: GraphAttribute {
    let value: Double
}

/// Margin used around polygons for purposes of spline edge routing. The interpretation is the same as given for sep. This should normally be strictly less than sep.
struct esep: GraphAttribute {
    let value: Add<DoubleOrPoint>
}

/// Color used to fill the background of a node or cluster assuming style=filled, or a filled arrowhead. If fillcolor is not defined, color is used. (For clusters, if color is not defined, bgcolor is used.) If this is not defined, the default is used, except for shape=point or when the output format is MIF, which use black by default.
///
/// If the value is a colorList, a gradient fill is used. By default, this is a linear fill; setting style=radial will cause a radial fill. At present, only two colors are used. If the second color (after a colon) is missing, the default color is used for it. See also the gradientangle attribute for setting the gradient angle.
///
/// Note that a cluster inherits the root graph's attributes if defined. Thus, if the root graph has defined a fillcolor, this will override a color or bgcolor attribute set for the cluster.
struct fillcolor: EdgeAttribute & NodeAttribute {
    let value: ColorList
}

/// If false, the size of a node is determined by smallest width and height needed to contain its label and image, if any, with a margin specified by the margin attribute. The width and height must also be at least as large as the sizes specified by the width and height attributes, which specify the minimum values for these parameters.
///
/// If true, the node size is specified by the values of the width and height attributes only and is not expanded to contain the text label. There will be a warning if the label (with margin) cannot fit within these limits.
///
/// If the fixedsize attribute is set to shape, the width and height attributes also determine the size of the node shape, but the label can be much larger. Both the label and shape sizes are used when avoiding node overlap, but all edges to the node ignore the label and only contact the node shape. No warning is given if the label is too large.
struct fixedsize: NodeAttribute {
    enum Value {
        case True
        case False

        case shape

        init(_ value: Bool) {
            if value {
                self = .True
            } else {
                self = .False
            }
        }
    }

    let value: Value
}

/// Color used for text.
struct fontcolor: EdgeAttribute & NodeAttribute & GraphAttribute {
    let value: Color
}

/// Font used for text. This very much depends on the output format and, for non-bitmap output such as PostScript or SVG, the availability of the font when the graph is displayed or printed. As such, it is best to rely on font faces that are generally available, such as Times-Roman, Helvetica or Courier.
///
/// How font names are resolved also depends on the underlying library that handles font name resolution. If Graphviz was built using the fontconfig library, the latter library will be used to search for the font. See the commands fc-list, fc-match and the other fontconfig commands for how names are resolved and which fonts are available. Other systems may provide their own font package, such as Quartz for OS X.
///
/// Note that various font attributes, such as weight and slant, can be built into the font name. Unfortunately, the syntax varies depending on which font system is dominant. Thus, using fontname="times bold italic" will produce a bold, slanted Times font using Pango, the usual main font library. Alternatively, fontname="times:italic" will produce a slanted Times font from fontconfig, while fontname="times-bold" will resolve to a bold Times using Quartz. You will need to ascertain which package is used by your Graphviz system and refer to the relevant documentation.
///
/// If Graphviz is not built with a high-level font library, fontname will be considered the name of a Type 1 or True Type font file. If you specify fontname=schlbk, the tool will look for a file named schlbk.ttf or schlbk.pfa or schlbk.pfb in one of the directories specified by the fontpath attribute. The lookup does support various aliases for the common fonts.
struct fontname: EdgeAttribute & NodeAttribute & GraphAttribute {
    let value: String
}

/// Allows user control of how basic fontnames are represented in SVG output. If fontnames is undefined or "svg", the output will try to use known SVG fontnames. For example, the default font "Times-Roman" will be mapped to the basic SVG font "serif". This can be overridden by setting fontnames to "ps" or "gd". In the former case, known PostScript font names such as "Times-Roman" will be used in the output. In the latter case, the fontconfig font conventions are used. Thus, "Times-Roman" would be treated as "Nimbus Roman No9 L". These last two options are useful with SVG viewers that support these richer fontname spaces.
struct fontnames: GraphAttribute {
    enum Value {
        case svg
        case ps
        case gd
    }
    let value: Value
}

/// Directory list used by libgd to search for bitmap fonts if Graphviz was not built with the fontconfig library. If fontpath is not set, the environment variable DOTFONTPATH is checked. If that is not set, GDFONTPATH is checked. If not set, libgd uses its compiled-in font path. Note that fontpath is an attribute of the root graph.
struct fontpath: GraphAttribute {
    let value: String
}

/// Font size, in points, used for text.
struct fontsize: EdgeAttribute & NodeAttribute & GraphAttribute {
    let value: Double
}

/// If true, all xlabel attributes are placed, even if there is some overlap with nodes or other labels.
struct forcelabels: GraphAttribute {
    let value: Bool
}

/// If a gradient fill is being used, this determines the angle of the fill. For linear fills, the colors transform along a line specified by the angle and the center of the object. For radial fills, a value of zero causes the colors to transform radially from the center; for non-zero values, the colors transform from a point near the object's periphery as specified by the value.
///
/// If unset, the default angle is 0.
struct gradientangle: NodeAttribute & GraphAttribute {
    let value: Int
}

/// If the end points of an edge belong to the same group, i.e., have the same group attribute, parameters are set to avoid crossings and keep the edges straight.
struct group: NodeAttribute {
    let value: String
}

/// If headURL is defined, it is output as part of the head label of the edge. Also, this value is used near the head node, overriding any URL value. See [limitation](https://www.graphviz.org/doc/info/attrs.html#h:undir_note).
struct headURL: EdgeAttribute {
    let value: String
}

/// Position of an edge's head label, in points. The position indicates the center of the label.
struct head_lp: EdgeAttribute {
    let value: Point
}

/// If true, the head of an edge is clipped to the boundary of the head node; otherwise, the end of the edge goes to the center of the node, or the center of a port, if applicable.
struct headclip: EdgeAttribute {
    let value: Bool
}

/// Synonym for headURL.
typealias headhref = headURL

/// Text label to be placed near head of edge. See [limitation](https://www.graphviz.org/doc/info/attrs.html#h:undir_note).
struct headlabel: EdgeAttribute {
    let value: LblString
}

/// Indicates where on the head node to attach the head of the edge. In the default case, the edge is aimed towards the center of the node, and then clipped at the node boundary. See [limitation](https://www.graphviz.org/doc/info/attrs.html#h:undir_note).
struct headport: EdgeAttribute {
    let value: PortPos
}

/// If the edge has a headURL, this attribute determines which window of the browser is used for the URL. Setting it to "_graphviz" will open a new window if it doesn't already exist, or reuse it if it does. If undefined, the value of the target is used.
struct headtarget: EdgeAttribute {
    let value: Target
}

/// Tooltip annotation attached to the head of an edge. This is used only if the edge has a headURL attribute.
struct headtooltip: EdgeAttribute {
    let value: String
}

/// Height of node, in inches. This is taken as the initial, minimum height of the node. If fixedsize is true, this will be the final height of the node. Otherwise, if the node label requires more height to fit, the node's height will be increased to contain the label. Note also that, if the output format is dot, the value given to height will be the final value.
///
/// If the node shape is regular, the width and height are made identical. In this case, if either the width or the height is set explicitly, that value is used. In this case, if both the width or the height are set explicitly, the maximum of the two values is used. If neither is set explicitly, the minimum of the two default values is used.
struct height: NodeAttribute {
    let value: Double
}

/// Synonym for URL.
typealias href = URL

/// Allows the graph author to provide an id for graph objects which is to be included in the output. Normal "\N", "\E", "\G" substitutions are applied. If provided, it is the responsibility of the provider to keep its values sufficiently unique for its intended downstream use. Note, in particular, that "\E" does not provide a unique id for multi-edges. If no id attribute is provided, then a unique internal id is used. However, this value is unpredictable by the graph writer. An externally provided id is not used internally.
///
/// If the graph provides an id attribute, this will be used as a prefix for internally generated attributes. By making these distinct, the user can include multiple image maps in the same document.
struct id: GraphAttribute & NodeAttribute & EdgeAttribute {
    let value: String
}

/// Gives the name of a file containing an image to be displayed inside a node. The image file must be in one of the recognized formats, typically JPEG, PNG, GIF, BMP, SVG or Postscript, and be able to be converted into the desired output format.
///
/// The file must contain the image size information. This is usually trivially true for the bitmap formats. For PostScript, the file must contain a line starting with %%BoundingBox: followed by four integers specifying the lower left x and y coordinates and the upper right x and y coordinates of the bounding box for the image, the coordinates being in points. An SVG image file must contain width and height attributes, typically as part of the svg element. The values for these should have the form of a floating point number, followed by optional units, e.g., width="76pt". Recognized units are in, px, pc, pt, cm and mm for inches, pixels, picas, points, centimeters and millimeters, respectively. The default unit is points.
///
/// Unlike with the shapefile attribute, the image is treated as node content rather than the entire node. In particular, an image can be contained in a node of any shape, not just a rectangle.
struct image: NodeAttribute {
    let value: String
}

/// Specifies a list of directories in which to look for image files as specified by the image attribute or using the IMG element in HTML-like labels. The string should be a list of (absolute or relative) pathnames, each separated by a semicolon (for Windows) or a colon (all other OS). The first directory in which a file of the given name is found will be used to load the image. If imagepath is not set, relative pathnames for the image file will be interpreted with respect to the current working directory.
struct imagepath: GraphAttribute {
    let value: [String]
}

/// Attribute controlling how an image is positioned within its containing node. This only has an effect when the image is smaller than the containing node. The default is to be centered both horizontally and vertically.
struct imagepos: NodeAttribute {
    enum Value {
        /// Top Left
        case tl
        /// Top Centered
        case tc
        /// Top Right
        case tr
        /// Middle Left
        case ml
        /// Middle Centered (the default)
        case mc
        /// Middle Right
        case mr
        /// Bottom Left
        case bl
        /// Bottom Centered
        case bc
        /// Bottom Right
        case br
    }
    let value: Value
}

/// Attribute controlling how an image fills its containing node. In general, the image is given its natural size, (cf. dpi), and the node size is made large enough to contain its image, its label, its margin, and its peripheries. Its width and height will also be at least as large as its minimum width and height. If, however, fixedsize=true, the width and height attributes specify the exact size of the node.
///
/// During rendering, in the default case (imagescale=false), the image retains its natural size. If imagescale=true, the image is uniformly scaled (i.e., its aspect ratio is preserved) to fit inside the node. At least one dimension of the image will be as large as possible given the size of the node. When imagescale=width, the width of the image is scaled to fill the node width. The corresponding property holds when imagescale=height. When imagescale=both, both the height and the width are scaled separately to fill the node.
///
/// In all cases, if a dimension of the image is larger than the corresponding dimension of the node, that dimension of the image is scaled down to fit the node. As with the case of expansion, if imagescale=true, width and height are scaled uniformly.
struct imagescale: NodeAttribute {
    enum Value {
        case True
        case False

        case width
        case height
        case both

        init(_ value: Bool) {
            if value {
                self = .True
            } else {
                self = .False
            }
        }
    }
    let value: Bool
}

/// For layout algorithms that support initial input positions (specified by the pos attribute), this attribute can be used to appropriately scale the values. By default, fdp and neato interpret the x and y values of pos as being in inches. (NOTE: neato -n(2) treats the coordinates as being in points, being the unit used by the layout algorithms for the pos attribute.) Thus, if the graph has pos attributes in points, one should set inputscale=72. This can also be set on the command line using the -s flag flag.
///
/// If not set, no scaling is done and the units on input are treated as inches. A value of 0 is equivalent to inputscale=72.
struct inputscale: GraphAttribute {
    let value: Double
}

/// Text label attached to objects. If a node's shape is record, then the label can have a special format which describes the record layout.
///
/// Note that a node's default label is "\N", so the node's name or ID becomes its label. Technically, a node's name can be an HTML string but this will not mean that the node's label will be interpreted as an HTML-like label. This is because the node's actual label is an ordinary string, which will be replaced by the raw bytes stored in the node's name. To get an HTML-like label, the label attribute value itself must be an HTML string.
struct label: EdgeAttribute & NodeAttribute & GraphAttribute {
    let value: LblString
}

/// If labelURL is defined, this is the link used for the label of an edge. This value overrides any URL defined for the edge.
struct labelURL: EdgeAttribute {
    let value: String
}

/// The value indicates whether to treat a node whose name has the form |edgelabel|* as a special node representing an edge label. The default (0) produces no effect. If the attribute is set to 1, sfdp uses a penalty-based method to make that kind of node close to the center of its neighbor. With a value of 2, sfdp uses a penalty-based method to make that kind of node close to the old center of its neighbor. Finally, a value of 3 invokes a two-step process of overlap removal and straightening.
struct label_scheme: GraphAttribute {
    let value: Int
}

/// This, along with labeldistance, determine where the headlabel (taillabel) are placed with respect to the head (tail) in polar coordinates. The origin in the coordinate system is the point where the edge touches the node. The ray of 0 degrees goes from the origin back along the edge, parallel to the edge at the origin.
///
/// The angle, in degrees, specifies the rotation from the 0 degree ray, with positive angles moving counterclockwise and negative angles moving clockwise.
struct labelangle: EdgeAttribute {
    let value: Double
}

/// Multiplicative scaling factor adjusting the distance that the headlabel(taillabel) is from the head(tail) node. The default distance is 10 points. See labelangle for more details. 
struct labeldistance: EdgeAttribute {
    let value: Double
}

struct labelfloat: EdgeAttribute {
    let value: Bool
}

struct labelfontcolor: EdgeAttribute {
    let value: Color
}

struct labelfontname: EdgeAttribute {
    let value: String
}

struct labelfontsize: EdgeAttribute {
    let value: Double
}

struct labelhref: EdgeAttribute {
    let value: String
}

struct labeljust: GraphAttribute {
    let value: String
}

struct labelloc: GraphAttribute & NodeAttribute {
    let value: String
}

struct labeltarget: EdgeAttribute {
    let value: String
}

struct labeltooltip: EdgeAttribute {
    let value: String
}

struct landscape: GraphAttribute {
    let value: Bool
}

struct layer: EdgeAttribute & NodeAttribute {
    let value: LayerRange
}

struct layerlistsep: GraphAttribute {
    let value: String
}

struct layers: GraphAttribute {
    let value: LayerList
}

struct layerselect: GraphAttribute {
    let value: LayerRange
}

struct layersep: GraphAttribute {
    let value: String
}

struct layout: GraphAttribute {
    let value: String
}

struct len: EdgeAttribute {
    let value: Double
}

struct levels: GraphAttribute {
    let value: Int
}

struct levelsgap: GraphAttribute {
    let value: Double
}

struct lhead: EdgeAttribute {
    let value: String
}

struct lheight: GraphAttribute {
    let value: Double
}

struct lp: EdgeAttribute & GraphAttribute {
    let value: Point
}

struct ltail: EdgeAttribute {
    let value: String
}

struct lwidth: GraphAttribute {
    let value: Double
}

struct margin: NodeAttribute & GraphAttribute {
    let value: Point
}

struct maxiter: GraphAttribute {
    let value: Int
}

struct mclimit: GraphAttribute {
    let value: Double
}

struct mindist: GraphAttribute {
    let value: Double
}

struct minlen: EdgeAttribute {
    let value: Int
}

struct mode: GraphAttribute {
    let value: String
}

struct model: GraphAttribute {
    let value: String
}

struct mosek: GraphAttribute {
    let value: Bool
}

struct newrank: GraphAttribute {
    let value: Bool
}

struct nodesep: GraphAttribute {
    let value: Double
}

struct nojustify: GraphAttribute & NodeAttribute & EdgeAttribute {
    let value: Bool
}

struct normalize: GraphAttribute {
    enum Value {
        case True
        case False
        case degrees(Double)

        init(_ value: Bool) {
            if value {
                self = .True
            } else {
                self = .False
            }
        }

        init(_ value: Double) {
            self = .degrees(value)
        }
    }
    let value: Value
}

struct notranslate: GraphAttribute {
    let value: Bool
}

struct nslimit: GraphAttribute {
    let value: Double
}

struct nslimit1: GraphAttribute {
    let value: Double
}

struct ordering: NodeAttribute & GraphAttribute {
    let value: String
}

struct nodeOrientation: NodeAttribute {
    let value: Double

    var name: String {
        return "orientation"
    }
}

struct graphOrientation: GraphAttribute {
    let value: String

    var name: String {
        return "orientation"
    }
}

struct outputorder: GraphAttribute {
    let value: OutputMode
}

struct overlap: GraphAttribute {
    enum Value {
        case True
        case False

        case scale
        case prism(UInt)
        case voronoi
        case scalexy
        case compress
        case vpsc
        case ipsep

        init(_ value: Bool) {
            if value {
                self = .True
            } else {
                self = .False
            }
        }
    }

    let value: Value
}

struct overlap_scaling: GraphAttribute {
    let value: Double
}

struct overlap_shrink: GraphAttribute {
    let value: Bool
}

struct pack: GraphAttribute {
    enum Value {
        case True
        case False
        case size(Int)

        init(_ value: Bool) {
            if value {
                self = .True
            } else {
                self = .False
            }
        }

        init(_ value: Int) {
            self = .size(value)
        }
    }
    let value: Value
}

struct packmode: GraphAttribute {
    let value: PackMode
}

struct pad: GraphAttribute {
    let value: Point
}

struct page: GraphAttribute {
    let value: Point
}

struct pagedir: GraphAttribute {
    let value: PageDir
}

struct penwidth: NodeAttribute & EdgeAttribute {
    let value: Double
}

struct peripheries: NodeAttribute {
    let value: Int
}

struct pin: NodeAttribute {
    let value: Bool
}

struct pos: EdgeAttribute & NodeAttribute {
    let value: Point
}

struct splineType {}

struct quadtree: GraphAttribute {
    let value: QuadType
}

struct quantum: GraphAttribute {
    let value: Double
}

struct rankdir: GraphAttribute {
    let value: RankDir
}

struct ranksep: GraphAttribute {
    let value: Double
}

struct doubleList {}

struct ratio: GraphAttribute {
    enum Value {
        case auto
        case expand
        case compress
        case fill
        case ratio(Double)
    }
    let value: Value
}

struct rects: NodeAttribute {
    let value: Rect
}

struct regular: NodeAttribute {
    let value: Bool
}

struct remincross: GraphAttribute {
    let value: Bool
}

struct repulsiveforce: GraphAttribute {
    let value: Double
}

struct resolution: GraphAttribute {
    let value: Double
}

struct root: NodeAttribute & GraphAttribute {
    let value: Bool
}

struct rotate: GraphAttribute {
    let value: Int
}

struct rotation: GraphAttribute {
    let value: Double
}

struct samehead: EdgeAttribute {
    let value: String
}

struct sametail: EdgeAttribute {
    let value: String
}

struct samplepoints: NodeAttribute {
    let value: Int
}

struct scale: GraphAttribute {
    let value: DoubleOrPoint
}

struct searchsize: GraphAttribute {
    let value: Int
}

struct sep: GraphAttribute {
    let value: AddDouble
}

struct addPoint {}

struct shape: NodeAttribute {
    let value: Shape
}

struct shapefile: NodeAttribute {
    let value: String
}

struct showboxes: EdgeAttribute & NodeAttribute & GraphAttribute {
    let value: Int
}

struct sides: NodeAttribute {
    let value: Int
}

struct size: GraphAttribute {
    let value: DoubleOrPoint
}

struct skew: NodeAttribute {
    let value: Double
}

struct smoothing: GraphAttribute {
    let value: SmoothType
}

struct sortv: NodeAttribute & GraphAttribute {
    let value: Int
}

struct splines: GraphAttribute {
    let value: Bool
}

struct start: GraphAttribute {
    let value: StartType
}

struct style: EdgeAttribute & NodeAttribute & GraphAttribute {
    let value: Style
}

struct stylesheet: GraphAttribute {
    let value: String
}

struct tailURL: EdgeAttribute {
    let value: String
}

struct tail_lp: EdgeAttribute {
    let value: Point
}

struct tailclip: EdgeAttribute {
    let value: Bool
}

struct tailhref: EdgeAttribute {
    let value: String
}

struct taillabel: EdgeAttribute {
    let value: LblString
}

struct tailport: EdgeAttribute {
    let value: PortPos
}

struct tailtarget: EdgeAttribute {
    let value: String
}

struct tailtooltip: EdgeAttribute {
    let value: String
}

struct target: EdgeAttribute & NodeAttribute & GraphAttribute {
    let value: String
}

struct tooltip: EdgeAttribute & NodeAttribute {
    let value: String
}

struct truecolor: GraphAttribute {
    let value: Bool
}

struct vertices: NodeAttribute {
    let value: PointList
}

struct viewport: GraphAttribute {
    let value: ViewPort
}

struct voro_margin: GraphAttribute {
    let value: Double
}

struct weight: EdgeAttribute {
    let value: Double
}

struct width: NodeAttribute {
    let value: Double
}

struct xdotversion: GraphAttribute {
    let value: String
}

struct xlabel: EdgeAttribute & NodeAttribute {
    let value: LblString
}

struct xlp: EdgeAttribute & NodeAttribute {
    let value: Point
}

struct z: NodeAttribute {
    let value: Double
}

}
