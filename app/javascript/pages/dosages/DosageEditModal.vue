<template>
  <div class="bg-blue-200 flex">
    <div class="flex-col flex ml-auto mr-auto items-center w-full">
      <h1 class="font-bold text-2xl my-10 text-white">
        編集
      </h1>
      <form
        action=""
        class="mt-2 flex flex-col w-11/12"
      >
        <div class="flex flex-wrap items-stretch w-full mb-4 relative h-15 bg-white items-center rounded mb-6 pr-10">
          <label for="nutrient_id" />
          <select
            id="nutrient_id"
            v-model.lazy="nutrient_id"
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
          <label for="amunt" />
          <input
            id="dosage"
            v-model="amount"
            type="number"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 border-grey-light rounded rounded-l-none px-3 self-center relative  font-roboto text-xl outline-none"
            placeholder="服用量"
          >
        </div>
        <div class="flex flex-wrap items-stretch w-full relative h-15 bg-white items-center rounded mb-4">
          <label for="dosage_at" />
          <Datepicker
            v-model="dosage_at"
            text-input
            auto-apply
            class="flex-shrink flex-grow leading-normal border-0 border-grey-light h-15 px-3 relative self-center font-roboto text-xl outline-none"
          />
        </div>
        <BaseButton
        :bgcolor="'bg-sky-400 hover:bg-sky-500'"
        @click="submitDosage"
        >
          更新
        </BaseButton>
        <BaseButton
          :bgcolor="'bg-rose-400 hover:bg-rose-500'"
          @click="deleteDosage"
        >
          削除
        </BaseButton>
        <BaseButton
          :bgcolor="'bg-gray-400 hover:bg-gray-500'"
          @click="closeModal"
          >
          キャンセル
        </BaseButton>
      </form>
    </div>
  </div>
</template>

<script>
import Datepicker from '@vuepic/vue-datepicker'
import '@vuepic/vue-datepicker/dist/main.css'
import BaseButton from '../../components/BaseButton'

export default {
  name: 'DosageEditModal',
  components: {
    Datepicker,
    BaseButton,
    },
  props: {
    dosage: {
      type: Object,
      required: true,
      id: { type: Number, required: true },
      amount: { type: Number, required: true },
      nutrient_id: { type: Number, required: true },
      dosage_at: { type: Date, required: true },
      user_id: { type: Number, required: true },
    },
  },
  emits: ['update:dosage', 'updateDosage', 'deleteDosage', 'closeEditModal'],
  data() {
    return {
      options: [
        {id: 1, name: 'ビタミンC'},
      ],
    }
  },
  computed: {
    nutrient_id: {
      get() {
        return this.dosage.nutrient_id
      },
      set(nutrient_id) {
        return this.updateValue({ nutrient_id })
      },
    },
    amount: {
      get() {
        return this.dosage.amount
      },
      set(amount) {
        return this.updateValue({ amount })
      },
    },
    dosage_at: {
      get() {
        return this.dosage.dosage_at
      },
      set(dosage_at) {
        return this.updateValue({ dosage_at })
      },
    }
  },
  mounted() {
  },
  methods: {
    updateValue(diff) {
      // propsのコピー変更分を加える
      this.$emit('update:dosage', {...this.dosage, ...diff})
    },
    submitDosage() {
      this.$emit('updateDosage')
    },
    deleteDosage() {
      this.$emit('deleteDosage', this.dosage)
    },
    closeModal() {
      this.$emit('closeEditModal')
    },
  },
}
</script>
