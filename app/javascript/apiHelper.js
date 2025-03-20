export function getMetaValue(metaName) {
  const element = document.querySelector(`meta[name="${metaName}"]`);
  return element.getAttribute("content");
}

export async function fetchPATCHRequest(url, body) {
  const headers = new Headers();
  const csrf = getMetaValue("csrf-token");
  headers.append("Content-Type", "application/json");
  headers.append("X-CSRF-Token", csrf);

  return fetch(url, {
    method: "PATCH",
    headers: headers,
    body: JSON.stringify(body),
  });
}
