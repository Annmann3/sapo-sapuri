<template>
  <div class="relative rounded-xl overflow-auto">
    <table class="border-collapse w-full border border-slate-500 bg-white text-sm shadow-sm">
      <thead class="bg-blue-400">
        <tr>
          <th
            v-for="(value, index) in dosageKeys"
            :key="index"
            class="w-1/2 border border-slate-300 dark:border-slate-600 font-semibold p-4 text-slate-900 dark:text-slate-200 text-left"
          >
            {{ value }}
          </th>
          <th
            class="w-1/2 border border-slate-300 dark:border-slate-600 font-semibold p-4 text-slate-900 dark:text-slate-200 text-left"
          />
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="dosage in dosages"
          :key="dosage.id"
        >
          <td class="border border-slate-300 dark:border-slate-700 p-4 text-slate-500 dark:text-slate-400">
            {{ dosage.id }}
          </td>
          <td class="border border-slate-300 dark:border-slate-700 p-4 text-slate-500 dark:text-slate-400">
            {{ dosage.nutrient_id }}
          </td>
          <td class="border border-slate-300 dark:border-slate-700 p-4 text-slate-500 dark:text-slate-400">
            {{ dosage.user_id }}
          </td>
          <td class="border border-slate-300 dark:border-slate-700 p-4 text-slate-500 dark:text-slate-400">
            {{ dosage.amount }}
          </td>
          <td class="border border-slate-300 dark:border-slate-700 p-4 text-slate-500 dark:text-slate-400">
            {{ formatDayjs(dosage.dosage_at) }}
          </td>
          <td class="border border-slate-300 dark:border-slate-700 p-4 text-slate-500 dark:text-slate-400">
            <button
              class="hover:text-black"
              @click="$emit('show-edit-modal', dosage)"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                class="icon icon-tabler icon-tabler-edit"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                stroke-width="2"
                stroke="currentColor"
                fill="none"
                stroke-linecap="round"
                stroke-linejoin="round"
              >
                <path
                  stroke="none"
                  d="M0 0h24v24H0z"
                  fill="none"
                />
                <path d="M7 7h-1a2 2 0 0 0 -2 2v9a2 2 0 0 0 2 2h9a2 2 0 0 0 2 -2v-1" />
                <path d="M20.385 6.585a2.1 2.1 0 0 0 -2.97 -2.97l-8.415 8.385v3h3l8.385 -8.415z" />
                <path d="M16 5l3 3" />
              </svg>
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import dayjs from 'dayjs'
dayjs.locale('ja')

export default {
  name: 'DosagesTable',
  props: {
    dosages: {
      type: Array,
      required: true,
      id: { type: Number, required: true },
      amount: { type: Number, required: true },
      nutrient_id: { type: Number, required: true },
      dosage_at: { type: Date, required: true },
     },
  },
  emits: ["show-edit-modal"],
  data() {
    return {
      dosageKeys: ['id', 'nutrient_id', 'user_id', 'amount', 'dosage_at']
    }
  },
  methods: {
    formatDayjs(date) {
      return dayjs(date).format('MM/DD HH:mm')
    },
  }
}
</script>
