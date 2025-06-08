String fixImageUrl(String rawUrl) {
  if (rawUrl.startsWith("/images")) {
    return "http://10.0.2.2:4000$rawUrl"; // ✅ Fix local image paths
  } else if (rawUrl.contains("localhost")) {
    return rawUrl.replaceAll("localhost", "10.0.2.2"); // ✅ Convert localhost for emulator
  } else {
    return rawUrl;
  }
}