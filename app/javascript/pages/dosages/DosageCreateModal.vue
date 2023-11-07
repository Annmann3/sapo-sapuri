<template>
  <div class="bg-blue-200 flex rounded-lg shadow-md">
    <div class="flex-col flex ml-auto mr-auto items-center w-full mb-6">
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
              auto-apply
              class="leading-normal border-0 border-grey-light h-15 px-3 relative self-center font-roboto text-xl outline-none"
            />
          </div>
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
          <div class="flex-col items-center justify-center w-full">
            <div class="text-center mb-2">
              <BaseButton
              :bgcolor="'bg-blue-400 hover:bg-blue-500'"
              class="w-1/2 mb-2"
              @click="submitDosage"
              >
                登録
              </BaseButton>
            </div>
            <div class="text-center">
              <BaseButton
                :bgcolor="'bg-gray-400 hover:bg-gray-500'"
                class="w-1/2 mb-2"
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

<script setup>
import { ref, defineEmits, computed} from 'vue';
import VueDatePicker from '@vuepic/vue-datepicker';
import '@vuepic/vue-datepicker/dist/main.css';
import BaseButton from '../../components/BaseButton';

const emits = defineEmits(['createDosage', 'closeCreateModal']);

const currentDateTime = new Date();
const dosage = ref({
  nutrient_id: 1,
  amount: '500',
  dosage_at: new Date()
});
const time = ref({
  hours: currentDateTime.getHours(),
  minutes: currentDateTime.getMinutes(),
});
const date = ref(new Date());
const options = [
  { id: 1, name: 'ビタミンC' },
];

const allowedDate = computed(() => {
  const today = new Date();
  today.setDate(today.getDate() + 1);
  return today;
});

const closeModal = () => {
  emits('closeCreateModal');
};

const submitDosage = () => {
  const dosageAt = new Date(date.value)
  dosageAt.setHours(time.value.hours);
  dosageAt.setMinutes(time.value.minutes);

  const dosageParams = {
    nutrient_id: dosage.value.nutrient_id,
    amount: dosage.value.amount,
    dosage_at: dosageAt,
  };
  emits('createDosage', dosageParams);
};
</script>
