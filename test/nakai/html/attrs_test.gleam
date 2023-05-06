import nakai/html/attrs
import gleeunit/should

pub fn attr_names_test() {
  attrs.type_("text")
  |> should.equal(attrs.Attr("type", "text"))

  attrs.http_equiv("content-security-policy")
  |> should.equal(attrs.Attr("http-equiv", "content-security-policy"))
}
