<template>
  <h1 class="text-center font-bold text-2xl my-10 text-white">
    服用履歴
  </h1>
  <DosagesTable
    v-if="isVisibleDosageTable"
    :dosages="dosageList"
    @show-edit-modal="handleShowEditModal"
  />
  <DosageEditModal
    v-if="isVisibleDosageEditModal"
    v-model:dosage="newDosage"
    @update-dosage="updateDosage"
    @close-edit-modal="handleCloseEditModal"
  />
</template>

<script>
import { mapActions, mapGetters} from 'vuex'
import DosagesTable from './DosageTable'
import DosageEditModal from './DosageEditModal'

export default {
  name: 'DosagesIndex',
  components: {
    DosagesTable,
    DosageEditModal,
  },
  data() {
    return {
      dosages: [],
      newDosage: {},
      newDosaegebj: {},
      isVisibleDosageTable: true,
      isVisibleDosageEditModal: false,
    }
  },
  computed: {
    ...mapGetters('dosages', ['dosageList']),
  },
  mounted() {
    this.fetchDosages()
  },
  methods: {
    ...mapActions('dosages', ['fetchDosages', 'deleteDosage', 'updateDosage']),
    handleCloseTable() {
      this.isVisibleDosageTable = false
    },
    handleShowEditModal(dosage) { 
      //　参照元を変える
      this.newDosage = Object.assign({}, dosage)
      this.isVisibleDosageEditModal = true
    },
    handleCloseEditModal() {
      this.isVisibleDosageEditModal = false
    },
    async updateDosage() {
      debugger
      try {
        await this.updateDosage(this.newDosage)
        this.handleCloseEditModal()
      } catch(err) {
        console.log(err)
      }
   },
  },
}
</script>
