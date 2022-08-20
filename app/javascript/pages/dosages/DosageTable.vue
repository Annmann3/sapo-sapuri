<template>
  <div class="relative rounded-xl overflow-auto">
    <table class="border-collapse w-full border border-slate-500 bg-white text-sm shadow-sm">
      <thead class="bg-blue-400">
        <tr>
          <th
            v-for="key in dosageKeys"
            class="w-1/2 border border-slate-300 dark:border-slate-600 font-semibold p-4 text-slate-900 dark:text-slate-200 text-left"
          >
            {{ key }}
          </th>
          <th
            class="w-1/2 border border-slate-300 dark:border-slate-600 font-semibold p-4 text-slate-900 dark:text-slate-200 text-left"
          />
        </tr>
      </thead>
      <tbody>
        <tr
          v-for="dosage in dosages"
        >
          <td
            v-for="data in dosage"
            class="border border-slate-300 dark:border-slate-700 p-4 text-slate-500 dark:text-slate-400"
          >
            {{ data }}
          </td>
          <td>
            <button
              @click="$emit('show-edit-modal', dosage)"
            >
              編集
            </button>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
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
      dosageKeys: ['id', 'nutrient_id', 'user_id', 'amount', 'dosage_at', 'created_at', 'updated_at']
    }
  },
}
</script>
