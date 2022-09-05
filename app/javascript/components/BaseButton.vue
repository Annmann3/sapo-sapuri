<template>
  <button
    type="button"
    class="py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4"
    :class="bgcolor"
    @click="submitDosage"
  >
    <slot />
  </button>
</template>

<script>
export default {
  name: 'BaseButton',
  props: {
    bgcolor: { type: String, required: true },
  },
}
</script>
