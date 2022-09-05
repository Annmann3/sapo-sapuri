<template>
  <div class="bg-blue-200 flex">
    <div class="flex-col flex ml-auto mr-auto items-center w-full">
      <h1 class="font-bold text-2xl my-10 text-white">
        服用登録
      </h1>
      <form
        action=""
        class="mt-2 flex flex-col w-11/12"
      >
        <div class="flex flex-wrap items-stretch w-full mb-4 relative h-15 bg-white items-center rounded mb-6 pr-10">
          <label for="nutrient_id" />
          <select
            id="nutrient_id"
            v-model.lazy="dosage.nutrient_id"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 border-grey-light rounded rounded-l-none px-3 self-center relative  font-roboto text-xl outline-none"
          >
            <option
              v-for="option in options"
              :key="option.id"
              :value="option.id"
            >
              {{ option.name }}
            </option>
          </select>
        </div>
        <div class="flex flex-wrap items-stretch w-full mb-4 relative h-15 bg-white items-center rounded mb-6 pr-10">
          <label for="amount" />
          <input
            id="amount"
            v-model.lazy="dosage.amount"
            type="number"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 border-grey-light rounded rounded-l-none px-3 self-center relative  font-roboto text-xl outline-none"
            placeholder="服用量"
          >
        </div>
        <div class="flex flex-wrap items-stretch w-full relative h-15 bg-white items-center rounded mb-4">
          <label for="dosage_at" />
          <Datepicker
            v-model="dosage.dosage_at"
            text-input
            auto-apply
            class="flex-shrink flex-grow leading-normal border-0 border-grey-light h-15 px-3 relative self-center font-roboto text-xl outline-none"
          />
        </div>
        <button
          type="button"
          class="bg-blue-400 py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4 mb-20"
          @click="submitDosage"
        >
          登録
        </button>
        <button
          type="button"
          class="bg-blue-400 py-4 text-center px-17 md:px-12 md:py-4 text-white rounded leading-tight text-xl md:text-base font-sans mt-4 mb-20"
          @click="closeModal"
        >
          キャンセル
        </button>
      </form>
    </div>
  </div>
</template>

<script>
import Datepicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css'

export default {
  name: 'DosageCreateModal',
  components: { Datepicker },
  emits: ['createDosage', 'closeCreateModal'],
  data() {
    return {
      dosage: {
        nutrient_id: 1,
        amount: '',
        dosage_at: new Date(), // vuepicはこのオブジェクトに沿った形式を取得してくれる
      },
      options: [
        {id: 1, name: 'ビタミンC'},
      ],
    }
  },
  methods: {
    submitDosage() {
        this.$emit('createDosage', this.dosage)
    },
    closeModal() {
      this.$emit('closeCreateModal')
    },
  },
}
</script>
