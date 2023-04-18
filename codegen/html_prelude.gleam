import nakai/html/attrs.{Attr}

pub type Node(a) {
  /// Can be used anywhere in the document, and will set the doctype of the document
  /// being rendered. Usually not necessary, as documents have a default of `<!DOCTYPE html>`.
  /// ## Example
  /// ```gleam
  /// html.Html([], [
  ///   html.Doctype("html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\"")
  /// ])
  /// ```
  Doctype(content: String)
  /// Used for setting attributes on the root `<html>` element of the document. Children
  /// will be render in-place, equivalent to using `html.Fragment(children)`.
  /// ## Example
  /// ```gleam
  /// html.Html([html.Attr("lang", "en-US")], [
  ///   ...
  /// ])
  /// ```
  Html(attrs: List(Attr(a)), children: List(Node(a)))
  /// Used for placing content in the `<head>` of the document. Useful for elements like
  /// `<meta>`, `<title>`, `<link>`, etc.
  /// ## Example
  /// ```gleam
  /// html.Fragment([
  ///   html.Head([
  ///     html.title("List of puppies"
  ///   ]),
  ///   html.div([], [
  ///     ...
  ///   ])
  /// ])
  /// ```
  Head(children: List(Node(a)))
  /// An HTML comment, which will be included in the document.
  /// ## Example
  /// ```gleam
  /// html.Comment("You've uncovered my secrets!")
  /// // <!-- You've uncovered my secrets! -->
  /// ```
  Comment(content: String)
  Element(tag: String, attrs: List(Attr(a)), children: List(Node(a)))
  LeafElement(tag: String, attrs: List(Attr(a)))
  Text(content: String)
  UnsafeText(content: String)
  /// An "transparent" container that will render it's children, but does not add anything
  /// itself to the document. If you've ever used `React.Fragment` or `<>` and `</>` in
  /// JSX/React, this is that.
  /// ## Example
  /// ```gleam
  /// html.ul([], [
  ///   // some puppies are hard-coded
  ///   html.li_text([], "August"),
  ///   // some are loaded from a server
  ///   html.Fragment(puppies_fetched_from_api |> list.map(html.li_text([], _)))
  /// ])
  /// // <ul>
  /// //   <li>August</li>
  /// //   <li>Dot</li>
  /// //   <li>Mody</li>
  /// //   <li>Spot</li>
  /// //   <li>Toby</li>
  /// // </ul>
  /// ```
  Fragment(children: List(Node(a)))
  /// Renders absolutely nothing. For when you may or may not have something to render,
  /// and need a way to say "I've got nothing."
  /// ## Example
  /// ```gleam
  /// html.div([], [
  ///   case my_cool_feature {
  ///     Enabled -> super_cool_stuff()
  ///     Disabled -> html.Nothing
  ///   }
  /// ])
  Nothing
}

/// The HTML [`<title>`](https://developer.mozilla.org/en-US/docs/Web/HTML/Element/title) element
pub fn title(text: String) -> Node(a) {
  Element("title", [], [Text(text)])
}
