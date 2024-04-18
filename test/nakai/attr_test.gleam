import gleeunit/should
import nakai/attr

pub fn attr_names_test() {
  attr.type_("text")
  |> should.equal(attr.Attr("type", "text"))

  attr.http_equiv("content-security-policy")
  |> should.equal(attr.Attr("http-equiv", "content-security-policy"))
}
