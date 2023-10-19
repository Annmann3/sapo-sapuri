<template>
  <form
    action=""
    class="mt-2 flex flex-col"
  >
    <div class="flex flex-wrap items-stretch relative h-15 bg-white items-center rounded mb-4">
      <label for="dosageDate" />
      <Datepicker
        v-model="dosageDate"
        :allowed-dates="allowedDates"
        ignore-time-validation
        text-input
        :enable-time-picker="false"
        :format="format"
      />
    </div>
    <div class="flex flex-wrap items-stretch relative h-15 bg-white items-center rounded mb-4">
      <label for="dosageTime" />
      <Datepicker
        v-model="dosageTime"
        text-input
        time-picker
      />
    </div>
    <div class="flex flex-wrap items-stretch relative h-15 bg-white items-center rounded mb-4">
      <label for="dosageAmount" />
      <input
        id="dosageAmount"
        v-model="dosageAmount"
        type="number"
        name="dosageAmount"
        class="flex-shrink flex-grow flex-auto leading-normal w-px flex-1 border h-10 border-grey-light rounded rounded-r-none px-3 relative"
        placeholder="服用量"
      />
    </div>
    <BaseButton
    :bgcolor="'bg-blue-400 hover:bg-blue-500'"
    @click="submitDate"
    >
      服用
    </BaseButton>
  </form>
</template>

<script>
import { ref, computed } from 'vue'
import BaseButton from 'components/BaseButton'
import Datepicker from '@vuepic/vue-datepicker'
import '@vuepic/vue-datepicker/dist/main.css'

export default {
  name: 'DosageForm',
  components: {
    BaseButton,
    Datepicker,
  },
  emits: ['caliculate'],
  //datepickerの設定はsetupで行う
  setup(props, context) {
    const dosageAmount = ref(500)
    const dosageDate = ref(new Date())
    const dosageTime = ref({
      hours: new Date().getHours(),
      minutes: new Date().getMinutes(),
    })

    const submitDate = () => {
      const dosageAt = new Date(dosageDate.value)
      dosageAt.setHours(dosageTime.value.hours)
      dosageAt.setMinutes(dosageTime.value.minutes)
      context.emit('caliculate', dosageAt, dosageAmount.value )
    }

    const allowedDates = computed(() => {
      const yesterday = new Date(new Date().setDate(new Date().getDate() - 1))
      const tommorow = new Date(new Date().setDate(new Date().getDate() + 1))
      return [yesterday, tommorow]
    })

    const format = (date) => {
      const year = date.getFullYear()
      const month = date.getMonth() + 1
      const day = date.getDate()
      return `${year}/${month}/${day}`
    }


    return {
      dosageDate,
      dosageTime,
      submitDate,
      allowedDates,
      format,
      dosageAmount,
    }
  },
}
</script>
