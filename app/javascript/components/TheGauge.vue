<template>
  <div class="status-gauge relative h-10 bg-gray-200 border border-gray-300 rounded overflow-hidden">
    <div
      class="gauge-bar h-full transition-width ease-out duration-500"
      :style="{ width: gaugeWidth }"
      :class="{ 'bg-green-500': achievementRate < 50, 'bg-yellow-700': achievementRate >= 50 }"
    ></div>
    <div class="gauge-label absolute top-0 left-1/2 transform -translate-x-1/2 leading-10 font-bold text-gray-700">
      {{ achievementRate }}%
    </div>
  </div>
</template>

<script>
export default {
  props: {
    achievementRate: {
      type: Number,
      required: true,
    },
  },
  computed: {
    gaugeWidth() {
      return `${this.achievementRate}%`;
    },
  },
};
</script>
