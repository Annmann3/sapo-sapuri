<template>
  <div class="bg-blue-200 flex rounded-lg shadow-md">
    <div class="flex-col flex ml-auto mr-auto items-center w-full mb-6">
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
        <div class="flex flex-wrap items-stretch w-full relative mb-4 justify-evenly">
          <div class="w-2/5 mr-1">
            <label for="dosage_date" class="block text-gray-700 text-xl"/>
            <VueDatePicker
              v-model="date"
              uid="dosage_date"
              :enable-time-picker="false"
              :max-date="allowedDate"
              :format="'yyyy/MM/dd'"
              auto-apply
              class="leading-normal border-0 border-grey-light h-15 px-3 relative self-center font-roboto text-xl outline-none"
            />
          </div>
          <div class="w-2/5 ml-l">
            <label for="dosage_time" class="block text-gray-700 text-xl"/>
            <VueDatePicker
              v-model="time"
              uid="dosage_time"
              time-picker
              text-input
              auto-apply
              class="leading-normal border-0 border-grey-light h-15 px-3 relative self-center font-roboto text-xl outline-none"
            />
          </div>
        </div>
        <div class="flex flex-wrap items-stretch w-full mb-4 relative h-15 bg-white items-center rounded mb-6 pr-10">
          <label for="amount" />
          <input
            id="amount"
            v-model="amount"
            type="number"
            class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border-0 h-10 border-grey-light rounded rounded-l-none px-3 self-center relative  font-roboto text-xl outline-none"
            placeholder="服用量"
          >
        </div>
        <div class="flex flex-wrap justify-center w-full">
          <BaseButton
          :bgcolor="'bg-blue-400 hover:bg-blue-500'"
          class="w-1/2 mb-2"
          @click="submitDosage"
          >
            更新
          </BaseButton>
          <div class="flex flex-wrap justify-center w-full">
            <BaseButton
              :bgcolor="'bg-red-400 hover:bg-red-500'"
              class="w-1/4"
              @click="deleteDosage"
            >
              削除
            </BaseButton>
            <BaseButton
              :bgcolor="'bg-gray-400 hover:bg-gray-500'"
              class="w-1/4"
              @click="closeModal"
              >
              キャンセル
            </BaseButton>
          </div>
        </div>
      </form>
    </div>
  </div>
</template>

<script>
import VueDatePicker from '@vuepic/vue-datepicker'
import '@vuepic/vue-datepicker/dist/main.css'
import BaseButton from '../../components/BaseButton'

export default {
  name: 'DosageEditModal',
  components: {
    VueDatePicker,
    BaseButton,
    },
  props: {
    dosage: {
      type: Object,
      required: true,
      id: { type: Number, required: true },
      amount: { type: Number, required: true },
      nutrient_id: { type: Number, required: true },
      dosage_at: { type: String, required: true },
      user_id: { type: Number, required: true },
    },
  },
  emits: ['update:dosage', 'updateDosage', 'deleteDosage', 'closeEditModal'],
  data() {
    return {
      options: [
        {id: 1, name: 'ビタミンC'},
      ],
      date: '',
      time: '',
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
    },
    allowedDate() {
      const today = new Date()
      today.setDate(today.getDate() + 1)
      return today
    },
  },
  mounted() {
    this.date = this.formatDate(this.dosage.dosage_at)
    this.time = this.formatTime(this.dosage.dosage_at)
  },
  methods: {
    updateValue(diff) {
      // propsのコピー変更分を加える
      this.$emit('update:dosage', {...this.dosage, ...diff})
    },
    submitDosage() {
      // 日付と時刻を組み合わせて `dosage_at` を更新
      const dosageAt = new Date(this.date)
      dosageAt.setHours(this.time.hours)
      dosageAt.setMinutes(this.time.minutes)
      this.updateValue({ dosage_at: dosageAt })
      this.$emit('updateDosage')
    },
    deleteDosage() {
      this.$emit('deleteDosage', this.dosage)
    },
    closeModal() {
      this.$emit('closeEditModal')
    },
    formatDate(date) {
      return date.split('T')[0]
    },
    formatTime(date) {
      const time = date.split('T')[1]
      return {
        hours: time.split(':')[0],
        minutes: time.split(':')[1],
      }
    },
  },
}
</script>
