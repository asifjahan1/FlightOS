# SkyNav

**SkyNav** is a professional, offline-first Electronic Flight Bag (EFB) and Aviation Navigation Platform designed specifically for desktop environments (Linux/Windows/macOS). Inspired by industry standards like Garmin Pilot and ForeFlight, SkyNav provides pilots and aviation enthusiasts with a highly immersive, real-time navigation experience.

---

## The "Real Vibe" - Dynamic Liveness & Simulation

SkyNav is designed to feel **alive and authentic** from the very moment you launch it. To provide a professional demonstration and a seamless user experience, we have implemented a cutting-edge dynamic simulation engine.

Here is exactly how the "Liveness" works in real-time when the app is launched on a desktop without native GPS hardware:

1. **Intelligent Geolocation:** 
   Instead of falling back to a hardcoded or random location, SkyNav instantly fetches your **actual real-world physical location** using an IP-based Geolocation API.
2. **Dynamic Nearest-Airport Spawning:** 
   A plane doesn't just spawn in the middle of a city or over a house. SkyNav queries its internal onboard SQLite aviation database (`AirportDao`) to find the **nearest real-world airport** to your physical location (within a 60-mile radius). 
3. **Authentic Flight Initiation:**
   Your aircraft (the blue ownship marker) spawns exactly on the coordinates of that nearest airport, simulating a real-world departure. The flight simulation then begins from that precise location, retaining its state across app restarts so your flight is continuous.
4. **Live ADS-B Traffic (Real-Time):** 
   Because you are spawned in your actual local airspace, SkyNav's `OpenSkyTrafficService` connects to the OpenSky Network and streams **real aircraft currently flying over your city at this exact moment**. If you see a plane on the SkyNav map, it is physically flying near you in real life!

This ensures that whether a client opens the app in Dhaka, New York, or London, the app intelligently adapts to their environment, spawns them at their local airport, and surrounds them with local live traffic.

---

## Key Features

* **Real-Time Map Engine:** Powered by `flutter_map` for smooth, high-performance offline vector/raster tile rendering on Linux.
* **Offline Aviation Database:** Bundled with a robust SQLite (`drift`) database containing global Airports, Runways, and Communication Frequencies.
* **Airspace & Terrain Proximity:** Continuously monitors your flight path against complex airspace polygons and topographical data to provide real-time TAWS (Terrain Awareness) and Airspace entry alerts.
* **Live Weather Integration:** Fetches real-time METAR and TAF aviation weather reports for nearby airports.
* **Kiosk & Multi-Window Ready:** Built with `window_manager` to support seamless desktop kiosk deployments.

---

## Getting Started (Linux)

### Prerequisites

Because SkyNav relies heavily on high-performance local databases (for airports and future MBTiles offline charts), you must ensure your Linux system has the SQLite C-library installed:

```bash
sudo apt-get update
sudo apt-get install libsqlite3-dev
```

### Running the App

```bash
# Get dependencies
flutter pub get

# Generate Drift database files and Injectable service locators
flutter pub run build_runner build --delete-conflicting-outputs

# Run on Linux Desktop
flutter run -d linux
```

## Architecture

SkyNav follows **Clean Architecture** principles, utilizing:
- **BLoC (Business Logic Component)** for strict, reactive state management.
- **GetIt & Injectable** for robust dependency injection.
- **Drift** for type-safe, reactive SQLite database operations.
- **Dio** for robust networking and API calls.
