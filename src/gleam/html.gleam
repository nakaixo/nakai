import gleam/html/attrs.{Attr}
import gleam/html/doctype.{Doctype}

pub type Node {
  Comment(content: String)
  Element(tag: String, attrs: List(Attr), children: List(Node))
  LeafElement(tag: String, attrs: List(Attr))
  Text(content: String)
}

pub fn doctype(decl: String) -> Doctype {
  Doctype(decl)
}

pub fn space() -> Node {
  Text(" ")
}

// Shorthand functions for common elements
pub fn a(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "a", attrs: attrs, children: children)
}

pub fn body(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "body", attrs: attrs, children: children)
}

pub fn div(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "div", attrs: attrs, children: children)
}

pub fn head(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "head", attrs: attrs, children: children)
}

pub fn html(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "html", attrs: attrs, children: children)
}

pub fn h1(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h1", attrs: attrs, children: children)
}

pub fn h2(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h2", attrs: attrs, children: children)
}

pub fn h3(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h3", attrs: attrs, children: children)
}

pub fn h4(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h4", attrs: attrs, children: children)
}

pub fn h5(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h5", attrs: attrs, children: children)
}

pub fn h6(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "h6", attrs: attrs, children: children)
}

pub fn img(attrs: List(Attr)) -> Node {
  LeafElement(tag: "img", attrs: attrs)
}

pub fn li(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "li", attrs: attrs, children: children)
}

pub fn link(attrs: List(Attr)) -> Node {
  LeafElement(tag: "link", attrs: attrs)
}

pub fn ol(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "ol", attrs: attrs, children: children)
}

pub fn p(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "p", attrs: attrs, children: children)
}

pub fn section(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "section", attrs: attrs, children: children)
}

pub fn title(title: String) -> Node {
  Element(tag: "title", attrs: [], children: [Text(title)])
}

pub fn ul(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "ul", attrs: attrs, children: children)
}

pub fn hr(attrs: List(Attr)) -> Node {
  LeafElement(tag: "hr", attrs: attrs)
}

pub fn pre(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "pre", attrs: attrs, children: children)
}

pub fn blockquote(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "blockquote", attrs: attrs, children: children)
}

pub fn span(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "span", attrs: attrs, children: children)
}

pub fn code(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "code", attrs: attrs, children: children)
}

pub fn em(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "em", attrs: attrs, children: children)
}

pub fn strong(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "strong", attrs: attrs, children: children)
}

pub fn i(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "i", attrs: attrs, children: children)
}

pub fn b(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "b", attrs: attrs, children: children)
}

pub fn u(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "u", attrs: attrs, children: children)
}

pub fn sub(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "sub", attrs: attrs, children: children)
}

pub fn sup(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "sup", attrs: attrs, children: children)
}

pub fn br(attrs: List(Attr)) -> Node {
  LeafElement(tag: "br", attrs: attrs)
}

pub fn dl(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "dl", attrs: attrs, children: children)
}

pub fn dt(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "dt", attrs: attrs, children: children)
}

pub fn dd(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "dd", attrs: attrs, children: children)
}

pub fn iframe(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "iframe", attrs: attrs, children: children)
}

pub fn canvas(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "canvas", attrs: attrs, children: children)
}

pub fn math(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "math", attrs: attrs, children: children)
}

pub fn form(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "form", attrs: attrs, children: children)
}

pub fn input(attrs: List(Attr)) -> Node {
  LeafElement(tag: "dl", attrs: attrs)
}

pub fn textarea(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "textarea", attrs: attrs, children: children)
}

pub fn button(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "button", attrs: attrs, children: children)
}

pub fn select(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "select", attrs: attrs, children: children)
}

pub fn option(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "option", attrs: attrs, children: children)
}

pub fn nav(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "nav", attrs: attrs, children: children)
}

pub fn article(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "article", attrs: attrs, children: children)
}

pub fn aside(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "aside", attrs: attrs, children: children)
}

pub fn header(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "header", attrs: attrs, children: children)
}

pub fn footer(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "footer", attrs: attrs, children: children)
}

pub fn main(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "main", attrs: attrs, children: children)
}

pub fn figure(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "figure", attrs: attrs, children: children)
}

pub fn figcaption(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "figcaption", attrs: attrs, children: children)
}

pub fn table(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "table", attrs: attrs, children: children)
}

pub fn colgroup(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "colgroup", attrs: attrs, children: children)
}

pub fn col(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "col", attrs: attrs, children: children)
}

pub fn tbody(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "tbody", attrs: attrs, children: children)
}

pub fn thead(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "thead", attrs: attrs, children: children)
}

pub fn tfoot(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "tfoot", attrs: attrs, children: children)
}

pub fn td(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "td", attrs: attrs, children: children)
}

pub fn th(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "th", attrs: attrs, children: children)
}

pub fn fieldset(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "fieldset", attrs: attrs, children: children)
}

pub fn legend(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "legend", attrs: attrs, children: children)
}

pub fn label(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "label", attrs: attrs, children: children)
}

pub fn datalist(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "datalist", attrs: attrs, children: children)
}

pub fn optgroup(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "optgroup", attrs: attrs, children: children)
}

pub fn output(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "output", attrs: attrs, children: children)
}

pub fn progress(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "progress", attrs: attrs, children: children)
}

pub fn meter(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "meter", attrs: attrs, children: children)
}

pub fn audio(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "audio", attrs: attrs, children: children)
}

pub fn video(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "video", attrs: attrs, children: children)
}

pub fn source(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "source", attrs: attrs, children: children)
}

pub fn track(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "track", attrs: attrs, children: children)
}

pub fn embed(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "embed", attrs: attrs, children: children)
}

pub fn object(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "object", attrs: attrs, children: children)
}

pub fn param(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "param", attrs: attrs, children: children)
}

pub fn ins(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "ins", attrs: attrs, children: children)
}

pub fn del(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "del", attrs: attrs, children: children)
}

pub fn small(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "small", attrs: attrs, children: children)
}

pub fn cite(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "cite", attrs: attrs, children: children)
}

pub fn dfn(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "dfn", attrs: attrs, children: children)
}

pub fn abbr(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "abbr", attrs: attrs, children: children)
}

pub fn time(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "time", attrs: attrs, children: children)
}

pub fn var(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "var", attrs: attrs, children: children)
}

pub fn samp(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "samp", attrs: attrs, children: children)
}

pub fn kbd(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "kbd", attrs: attrs, children: children)
}

pub fn s(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "s", attrs: attrs, children: children)
}

pub fn q(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "q", attrs: attrs, children: children)
}

pub fn mark(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "mark", attrs: attrs, children: children)
}

pub fn ruby(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "ruby", attrs: attrs, children: children)
}

pub fn rt(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "rt", attrs: attrs, children: children)
}

pub fn rp(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "rp", attrs: attrs, children: children)
}

pub fn bdi(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "bdi", attrs: attrs, children: children)
}

pub fn bdo(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "bdo", attrs: attrs, children: children)
}

pub fn wbr(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "wbr", attrs: attrs, children: children)
}

pub fn details(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "details", attrs: attrs, children: children)
}

pub fn summary(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "summary", attrs: attrs, children: children)
}

pub fn menuitem(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "menuitem", attrs: attrs, children: children)
}

pub fn menu(attrs: List(Attr), children: List(Node)) -> Node {
  Element(tag: "menu", attrs: attrs, children: children)
}
