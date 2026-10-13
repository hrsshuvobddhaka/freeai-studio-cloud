export async function onRequestPost({ request, env }) {
  let body;
  try {
    body = await request.json();
  } catch {
    return Response.json({ error: "Request body must be valid JSON." }, { status: 400 });
  }
  const story = typeof body.story === "string" ? body.story.trim() : "";
  const genre = typeof body.genre === "string" ? body.genre.slice(0, 80) : "Drama";
  const sceneCount = Number.isInteger(body.sceneCount) ? Math.min(12, Math.max(1, body.sceneCount)) : 5;
  if (!story) return Response.json({ error: "গল্প বা আইডিয়া লিখুন।" }, { status: 400 });
  if (story.length > 12000) return Response.json({ error: "গল্পটি ১২,০০০ অক্ষরের মধ্যে রাখুন।" }, { status: 413 });

  // Future: call an AI provider here using server-side secrets stored in
  // Cloudflare Pages > Settings > Variables and Secrets. Never expose secrets
  // in index.html or commit them to GitHub.
  return Response.json({
    ok: true,
    message: "Cloudflare backend connected; AI model is not connected yet.",
    received: { storyLength: story.length, genre, sceneCount }
  }, { headers: { "Cache-Control": "no-store" } });
}
