'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "b27ce653c19bf31854550d43061b16eb",
"version.json": "5f3bf9b06e991a0d1536d04a5f4baeb7",
"index.html": "af85432db4df7e10677ca6491c9897af",
"/": "af85432db4df7e10677ca6491c9897af",
"main.dart.js": "1a210e687d29409bed1c82d38047e4a1",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "cf2dc2b7ecd5062ef7134604f2ff1eef",
"icons/favicon-16x16.png": "cf2dc2b7ecd5062ef7134604f2ff1eef",
"icons/favicon.ico": "60645b6bd1fa2e84b040744ea85e9d17",
"icons/favicon-512x512.png": "2669d2caab172fee4f636b5b0fe19160",
"icons/favicon-96x96.png": "f9b1b75f71f9e37b79c77990459d9b6f",
"icons/favicon-32x32.png": "c42013a4bea835e6bd0c2f9958560e96",
"manifest.json": "349af8bb8c0fc9127ce52c362e45eca7",
"assets/AssetManifest.json": "8d5b32ba429e1eb4427a6c604e23b3bc",
"assets/NOTICES": "0abeab65a4a5f4be1f847b08db67f63e",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "a067e1d83045de6e4050b728eaaabe07",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "afc94d73db887ddd8934b8e254fea4d4",
"assets/fonts/MaterialIcons-Regular.otf": "4392daef6255f17ff76f27498f084dc3",
"assets/assets/images/icon.png": "2669d2caab172fee4f636b5b0fe19160",
"assets/assets/images/planet.png": "5d23400d253324999da5eaf9619e7511",
"assets/assets/images/portalv2.png": "2c799ba1bd37f712b662728e38c81168",
"assets/assets/images/graphic.png": "bd16d3bf710fc6878d121f391105a825",
"assets/assets/images/black_hole.png": "40cbd17f80ab62d10148a1a307a13542",
"assets/assets/images/title.webp": "449420a40081772f124727131b85f0a8",
"assets/assets/images/target.png": "059c05cd3de439aea6e0b6786c2934dc",
"assets/assets/images/black_hole_ring.png": "fa0b1def54c7e8444dc91ffb52c9068e",
"assets/assets/images/wormhole.webp": "b81d1a46a51dd046f33469066d23795d",
"assets/assets/images/portal.png": "07e5255e99c7eb35d592a062901b10d9",
"assets/assets/images/flag_cz.svg": "859f18a5acfd4e8d702a9b3d539dfd2d",
"assets/assets/images/flag_gb.svg": "6dcadf6916764560c2f1fec586e2c1de",
"assets/assets/images/ball_default.png": "a969605ee1fa5eb748f0d1d7e580937e",
"assets/assets/images/home.gif": "efb01a7f81953b667a5952b46b6c6ac4",
"assets/assets/images/black_hole_resized.png": "ea53ed81bd44724c9c138fab4e186c17",
"assets/assets/images/cursor.webp": "8a1b8fca3a882bc6e9fe3cf670c95b15",
"assets/assets/images/player.png": "15ff25269459ff6954cc9ca9afc45ab6",
"privacy.html": "cadacff288140e4c7592b0e4c9b625ca",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
