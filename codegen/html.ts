type ElementDef = {
	variant: "LeafElement" | "Element";
	name: string;
};

const makeElementSource = (def: ElementDef) => {
	const { name, variant } = def;

	if (variant === "LeafElement")
		return `
pub fn ${name}(attrs: List(Attr(a))) -> Node(a) {
  ${variant}(tag: "${name}", attrs: attrs)
}
`;

	if (variant === "Element")
		return `
pub fn ${name}(attrs: List(Attr(a)), children: List(Node(a))) -> Node(a) {
  ${variant}(tag: "${name}", attrs: attrs, children: children)
}

pub fn ${name}_text(attrs: List(Attr(a)), text: String) -> Node(a) {
  ${variant}(tag: "${name}", attrs: attrs, children: [Text(text)])
}
`;
};

const base = await fetch(new URL("./html.gleam", import.meta.url)).then(
	(response) => response.text(),
);
const elementList = await fetch(new URL("./html.json", import.meta.url))
	.then((response) => response.json())
	.then((list: ElementDef[]) =>
		list.sort((a, b) => a.name.localeCompare(b.name)),
	);

const prefix = `





// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
// * THIS FILE IS GENERATED. DO NOT EDIT IT.                                             *
// * You're probably looking for ./codegen/html.gleam, or ./codegen/html.json.           *
// * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *





`;

let output = prefix + base;
for (const elm of elementList) {
	output += makeElementSource(elm);
}

let te = new TextEncoder();

Deno.writeFile(
	new URL("../src/nakai/html.gleam", import.meta.url).pathname,
	te.encode(output),
);

Deno.writeFile(
	new URL("./html.json", import.meta.url).pathname,
	te.encode(JSON.stringify(elementList, null, 2)),
);
