<template>
  <div class="map-container">
    <div class="map-wrapper">
      <l-map
        ref="map"
        :zoom="zoom"
        :center="center"
        :use-global-leaflet="false"
        @ready="onMapReady"
      >
        <l-tile-layer
          url="https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png"
          layer-type="base"
          name="OpenStreetMap"
        ></l-tile-layer>
        <l-marker
          v-for="(college, index) in colleges"
          :key="college.id"
          :title="college.name"
          :lat-lng="college.coordinates"
          :icon="getMarkerIcon(index)"
          @click="handleMarkerClick(college)"
           :options="getMarkerOptions(college, index)"
        >
          <l-popup :options="{ autoOpen: true }"> {{ college.name }}</l-popup>
        </l-marker>
      </l-map>
    </div>

    <div v-if="loading" class="loading">Loading...</div>
    <div v-if="error" class="error">{{ error }}</div>
  </div>
</template>

<script setup>
import { ref, onMounted, nextTick } from "vue";
import { useRoute, useRouter } from "vue-router";
import { LMap, LTileLayer, LMarker, LPopup } from "@vue-leaflet/vue-leaflet";
import L from "leaflet";
import "leaflet/dist/leaflet.css";

import markerIcon2x from "leaflet/dist/images/marker-icon-2x.png";
import markerIcon from "leaflet/dist/images/marker-icon.png";
import markerShadow from "leaflet/dist/images/marker-shadow.png";

delete L.Icon.Default.prototype._getIconUrl;
L.Icon.Default.mergeOptions({
  iconRetinaUrl: markerIcon2x,
  iconUrl: markerIcon,
  shadowUrl: markerShadow,
});

const zoom = ref(5);
const center = ref([-25.2744, 133.7751]);
const colleges = ref([]);
const loading = ref(false);
const error = ref(null);
let addressMap =  null;
const route = useRoute();
const router = useRouter();
const getMarkerOptions = (college, index) => ({
  title: college.name,
  alt: `${index + 1}: ${college.name}`,
  riseOnHover: true,
  keyboard: true
});

const getCollegeIds = () => {
  const collegeIds = route.query.collegeIds;
  if (!collegeIds) {
    throw new Error("Missing 'collegeIds' parameter.");
  }
  return collegeIds.split(",").filter(Boolean);
};

const geocodeAddress = async (address) => {
  const response = await fetch(
    `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(
      address
    )}`
  );
  const data = await response.json();
  if (!data.length) throw new Error(`Address not found: ${address}`);
  return [parseFloat(data[0].lat), parseFloat(data[0].lon)];
};

const adjustMapView = () => {
  if (addressMap && colleges.value.length > 0) {
    const bounds = colleges.value.map((c) => c.coordinates);
    addressMap.flyToBounds(bounds, {
      padding: [50, 50]
    });
  }
};

const handleMarkerClick = (college) => {
  router.push({
    name: "secondaryDetail",
    query: { id: college.id },
  });
};

const getMarkerIcon = (index) => {
  return L.icon({
    iconUrl: "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png",
    shadowUrl:
          "https://cdnjs.cloudflare.com/ajax/libs/leaflet/0.7.7/images/marker-shadow.png",
    iconSize: [25, 41],
    iconAnchor: [12, 41],
    popupAnchor: [1, -34],
    shadowSize: [41, 41],
  });
};

const onMapReady = (mapInstance) => {
  addressMap = mapInstance;
};

const fetchColleges = async () => {
  try {
    loading.value = true;
    const collegeIds = getCollegeIds();

    const response = await fetch(
      `/api/getSecondaryCollegesByids?ids=${collegeIds.join(",")}`
    );
    if (!response.ok) throw new Error("API request failed.");

    const data = await response.json();
    colleges.value = await Promise.all(
      data.data.map(async (college) => ({
        ...college,
        coordinates: await geocodeAddress(college.name),
      }))
    );
    nextTick(adjustMapView);
  } catch (err) {
    error.value = err.message;
  } finally {
    loading.value = false;
  }
};

onMounted(async () => {
  await fetchColleges();
});
</script>

<style scoped>
.map-wrapper {
  height: 600px;
  width: 80%;
  margin:0 auto;
  margin-top: 100px;
  border: 1px solid #ddd;
  border-radius: 4px;
}

.map-container {
  height: 100vh;
  width: 100%;
}

.marker-popup {
  min-width: 200px;
  padding: 10px;
}

.loading,
.error {
  position: fixed;
  top: 20px;
  left: 50%;
  transform: translateX(-50%);
  padding: 10px 20px;
  background: rgba(0, 0, 0, 0.8);
  color: white;
  border-radius: 5px;
}

.error {
  background: #ff4444;
}
</style>
