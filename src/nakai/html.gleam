import nakai/html/attrs.{Attr}
import nakai/html/doctype.{Doctype}

pub type Node(a) {
  Head(children: List(Node(a)))
  Comment(content: String)
  Element(tag: String, attrs: List(Attr(a)), children: List(Node(a)))
  LeafElement(tag: String, attrs: List(Attr(a)))
  Text(content: String)
  Component(factory: fn() -> Node(a))
  Fragment(children: List(Node(a)))
  Nothing
}

pub fn doctype(decl: String) -> Doctype {
  Doctype(decl)
}

pub fn space() -> Node(a) {
  Text(" ")
}

// Shorthand functions for common elements
pub fn a(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "a", attrs: attrs, children: children)
}

pub fn body(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "body", attrs: attrs, children: children)
}

pub fn div(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "div", attrs: attrs, children: children)
}

pub fn head(_attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Head(children)
}

pub fn html(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "html", attrs: attrs, children: children)
}

pub fn h1(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "h1", attrs: attrs, children: children)
}

pub fn h2(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "h2", attrs: attrs, children: children)
}

pub fn h3(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "h3", attrs: attrs, children: children)
}

pub fn h4(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "h4", attrs: attrs, children: children)
}

pub fn h5(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "h5", attrs: attrs, children: children)
}

pub fn h6(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "h6", attrs: attrs, children: children)
}

pub fn img(attrs: List(Attr(a))) -> Node(a) {
  LeafElement(tag: "img", attrs: attrs)
}

pub fn li(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "li", attrs: attrs, children: children)
}

pub fn link(attrs: List(Attr(a))) -> Node(a) {
  LeafElement(tag: "link", attrs: attrs)
}

pub fn ol(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "ol", attrs: attrs, children: children)
}

pub fn p(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "p", attrs: attrs, children: children)
}

pub fn section(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "section", attrs: attrs, children: children)
}

pub fn title(title: String) -> Node(a) {
  Element(tag: "title", attrs: [], children: [Text(title)])
}

pub fn ul(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "ul", attrs: attrs, children: children)
}

pub fn hr(attrs: List(Attr(a))) -> Node(a) {
  LeafElement(tag: "hr", attrs: attrs)
}

pub fn pre(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "pre", attrs: attrs, children: children)
}

pub fn blockquote(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "blockquote", attrs: attrs, children: children)
}

pub fn span(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "span", attrs: attrs, children: children)
}

pub fn code(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "code", attrs: attrs, children: children)
}

pub fn em(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "em", attrs: attrs, children: children)
}

pub fn strong(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "strong", attrs: attrs, children: children)
}

pub fn i(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "i", attrs: attrs, children: children)
}

pub fn b(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "b", attrs: attrs, children: children)
}

pub fn u(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "u", attrs: attrs, children: children)
}

pub fn sub(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "sub", attrs: attrs, children: children)
}

pub fn sup(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "sup", attrs: attrs, children: children)
}

pub fn br(attrs: List(Attr(a))) -> Node(a) {
  LeafElement(tag: "br", attrs: attrs)
}

pub fn dl(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "dl", attrs: attrs, children: children)
}

pub fn dt(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "dt", attrs: attrs, children: children)
}

pub fn dd(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "dd", attrs: attrs, children: children)
}

pub fn iframe(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "iframe", attrs: attrs, children: children)
}

pub fn canvas(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "canvas", attrs: attrs, children: children)
}

pub fn math(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "math", attrs: attrs, children: children)
}

pub fn form(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "form", attrs: attrs, children: children)
}

pub fn input(attrs: List(Attr(a))) -> Node(a) {
  LeafElement(tag: "dl", attrs: attrs)
}

pub fn textarea(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "textarea", attrs: attrs, children: children)
}

pub fn button(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "button", attrs: attrs, children: children)
}

pub fn select(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "select", attrs: attrs, children: children)
}

pub fn option(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "option", attrs: attrs, children: children)
}

pub fn nav(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "nav", attrs: attrs, children: children)
}

pub fn article(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "article", attrs: attrs, children: children)
}

pub fn aside(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "aside", attrs: attrs, children: children)
}

pub fn header(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "header", attrs: attrs, children: children)
}

pub fn footer(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "footer", attrs: attrs, children: children)
}

pub fn main(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "main", attrs: attrs, children: children)
}

pub fn figure(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "figure", attrs: attrs, children: children)
}

pub fn figcaption(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "figcaption", attrs: attrs, children: children)
}

pub fn table(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "table", attrs: attrs, children: children)
}

pub fn colgroup(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "colgroup", attrs: attrs, children: children)
}

pub fn col(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "col", attrs: attrs, children: children)
}

pub fn tbody(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "tbody", attrs: attrs, children: children)
}

pub fn thead(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "thead", attrs: attrs, children: children)
}

pub fn tfoot(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "tfoot", attrs: attrs, children: children)
}

pub fn td(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "td", attrs: attrs, children: children)
}

pub fn th(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "th", attrs: attrs, children: children)
}

pub fn fieldset(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "fieldset", attrs: attrs, children: children)
}

pub fn legend(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "legend", attrs: attrs, children: children)
}

pub fn label(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "label", attrs: attrs, children: children)
}

pub fn datalist(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "datalist", attrs: attrs, children: children)
}

pub fn optgroup(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "optgroup", attrs: attrs, children: children)
}

pub fn output(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "output", attrs: attrs, children: children)
}

pub fn progress(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "progress", attrs: attrs, children: children)
}

pub fn meter(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "meter", attrs: attrs, children: children)
}

pub fn audio(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "audio", attrs: attrs, children: children)
}

pub fn video(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "video", attrs: attrs, children: children)
}

pub fn source(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "source", attrs: attrs, children: children)
}

pub fn track(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "track", attrs: attrs, children: children)
}

pub fn embed(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "embed", attrs: attrs, children: children)
}

pub fn object(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "object", attrs: attrs, children: children)
}

pub fn param(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "param", attrs: attrs, children: children)
}

pub fn ins(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "ins", attrs: attrs, children: children)
}

pub fn del(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "del", attrs: attrs, children: children)
}

pub fn small(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "small", attrs: attrs, children: children)
}

pub fn cite(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "cite", attrs: attrs, children: children)
}

pub fn dfn(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "dfn", attrs: attrs, children: children)
}

pub fn abbr(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "abbr", attrs: attrs, children: children)
}

pub fn time(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "time", attrs: attrs, children: children)
}

pub fn var(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "var", attrs: attrs, children: children)
}

pub fn samp(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "samp", attrs: attrs, children: children)
}

pub fn kbd(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "kbd", attrs: attrs, children: children)
}

pub fn s(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "s", attrs: attrs, children: children)
}

pub fn q(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "q", attrs: attrs, children: children)
}

pub fn mark(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "mark", attrs: attrs, children: children)
}

pub fn ruby(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "ruby", attrs: attrs, children: children)
}

pub fn rt(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "rt", attrs: attrs, children: children)
}

pub fn rp(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "rp", attrs: attrs, children: children)
}

pub fn bdi(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "bdi", attrs: attrs, children: children)
}

pub fn bdo(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "bdo", attrs: attrs, children: children)
}

pub fn wbr(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "wbr", attrs: attrs, children: children)
}

pub fn details(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "details", attrs: attrs, children: children)
}

pub fn summary(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "summary", attrs: attrs, children: children)
}

pub fn menuitem(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "menuitem", attrs: attrs, children: children)
}

pub fn menu(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  Element(tag: "menu", attrs: attrs, children: children)
}
