// Minimal service worker for the /admin PWA.
// Network-only: enough to make the app installable without caching dynamic admin data.
const VERSION = 'admin-sw-v1';

self.addEventListener('install', (event) => {
  self.skipWaiting();
});

self.addEventListener('activate', (event) => {
  event.waitUntil(self.clients.claim());
});

self.addEventListener('fetch', (event) => {
  // Pass-through. Required for installability on some browsers.
  return;
});
