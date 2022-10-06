type AttrDef =
	| { variant: "Attr"; name: string }
	| { variant: "ConstAttr"; name: string; value: string };

const makeAttrSource = (def: AttrDef) => {
	const { name, variant } = def;

	if (variant === "Attr")
		return `
pub fn ${name.replaceAll("-", "_")}(value: String) -> Attr(a) {
  Attr(name: "${name}", value: value)
}
`;

	if (variant === "ConstAttr")
		return `
pub fn ${name}() -> Attr(a) {
  Attr(name: "${name}", value: "${def.value}")
}
`;
};

const base = await fetch(new URL("./attrs.gleam", import.meta.url)).then(
	(response) => response.text(),
);
const attrList = await fetch(new URL("./attrs.json", import.meta.url))
	.then((response) => response.json())
	.then((list: AttrDef[]) => list.sort((a, b) => a.name.localeCompare(b.name)));

const prefix = `





// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * THIS FILE IS GENERATED. DO NOT EDIT IT.                                             *
// * You're probably looking for ./codegen/attrs.gleam, or ./codegen/attrs.json.         *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *





`;

let output = prefix + base;
for (const attr of attrList) {
	output += makeAttrSource(attr);
}

let te = new TextEncoder();

Deno.writeFile(
	new URL("../src/nakai/html/attrs.gleam", import.meta.url).pathname,
	te.encode(output),
);

Deno.writeFile(
	new URL("./attrs.json", import.meta.url).pathname,
	te.encode(JSON.stringify(attrList, null, 2)),
);
