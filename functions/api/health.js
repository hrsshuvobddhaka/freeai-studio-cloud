export async function onRequestGet() {
  return Response.json({
    ok: true,
    app: "FreeAI Studio",
    message: "Cloudflare Pages Functions backend is running.",
    aiGeneration: "not_connected"
  }, {
    headers: { "Cache-Control": "no-store" }
  });
}
