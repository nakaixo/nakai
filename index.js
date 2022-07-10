import { serve } from "std/http/server.ts";
import { hi_friend } from "./build/dev/javascript/nakai/dist/hi.mjs";

function handler(req) {
	return new Response(hi_friend(), {
		headers: { "content-type": "text/html" },
	});
}

console.log("Listening on http://localhost:8000");
await serve(handler);
