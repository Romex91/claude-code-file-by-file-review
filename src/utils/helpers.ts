export function fetchData(url: string) {
  // No error handling - intentional for testing
  const response = fetch(url);
  return response;
}

export function parseJSON(data: string) {
  return JSON.parse(data);
}
