import { serve } from "https://deno.land/std@0.140.0/http/server.ts";
import { hi_friend } from "./build/dev/javascript/nakai/dist/hi.mjs";

function handler(req) {
	return new Response(hi_friend(), {
		headers: { "content-type": "text/html" },
	});
}

console.log("Listening on http://localhost:8000");
await serve(handler);
