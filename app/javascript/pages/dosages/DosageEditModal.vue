<template>
  <div class="bg-blue-200/0.5 flex">
    <div class="flex-col flex ml-auto mr-auto items-center w-full">
      <h1 class="font-bold text-2xl my-10 text-white">
        編集
      </h1>
      <form
        action=""
        class="mt-2 flex flex-col w-11/12"
      >
        <div class="flex flex-wrap items-stretch w-full mb-4 relative h-15 bg-white items-center rounded mb-6 pr-10">
          <div class="flex -mr-px justify-center w-15 p-4">
            <span
              class="flex items-center leading-normal bg-white px-3 border-0 rounded rounded-r-none text-2xl text-gray-600"
            >
              <i class="fas fa-envelope" />
            </span>
          </div>
          <label for="dosage" />
          <input
            id="dosage"
            :value="dosage['dosage']"
            type="number"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 border-grey-light rounded rounded-l-none px-3 self-center relative  font-roboto text-xl outline-none"
            placeholder="服用量"
            @input="dosage.dosage"
          >
        </div>
        <div class="flex flex-wrap items-stretch w-full relative h-15 bg-white items-center rounded mb-4">
          <div class="flex -mr-px justify-center w-15 p-4">
            <span
              class="flex items-center leading-normal bg-white rounded rounded-r-none text-xl px-3 whitespace-no-wrap text-gray-600"
            > 
              <i class="fas fa-lock" />
            </span>
          </div>
          <label for="dosage_at" />
          <input
            id="dosage_at"
            :value="dosage.dosage_at"
            type="datetime-local"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 px-3 relative self-center font-roboto text-xl outline-none"
            placeholder="dosage.dosage_at"
            @input="$(emit)"
          >
          <div class="flex -mr-px">
            <span
              class="flex items-center leading-normal bg-white rounded rounded-l-none border-0 px-3 whitespace-no-wrap text-gray-600"
            >
              <i class="fas fa-eye-slash" />
            </span>
          </div>
        </div>
        <button
          type="button"
          class="bg-blue-400 py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4 mb-20"
          @click="$emit('update:dosage', dosage)"
        >
          更新
        </button>
        <button
          type="button"
          class="bg-blue-400 py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4 mb-20"
          @click="$emit('update:dosage', dosage)"
        >
          閉じる
        </button>
        {{ dosage }}
      </form>
    </div>
  </div>
</template>

<script>
export default {
  name: 'DosageEditModal',
  props: {
    dosage: {
      id: { type: Number, required: true },
      dosage: { type: Number, required: true },
      nutrient_id: { type: Number, required: true },
      dosage_at: { type: Date, required: true },
      user_id: { type: Number, required: true },
    },
  },
  emits: ['update:dosage', 'updateDosage','close-edit-modal'],
  methods: {
    updateDosage(dosage) {
      debugger
      this.$emit('update:dosage', dosage)
      this.$emit('updateDosage')
    }
  }
}
</script>
