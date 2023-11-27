<template>
  <h1 class="text-center font-bold text-2xl my-10 text-white">
    服用履歴
  </h1>
  <BaseButton
  :bgcolor="'bg-blue-400 hover:bg-blue-500'"
  class="block mx-auto mb-3"
  @click="handleShowCreateModal"
  >
  服用記録を追加
  </BaseButton>
  <DosagesTable
    v-if="isVisibleDosageTable"
    :dosages="dosageList"
    @show-edit-modal="handleShowEditModal"
  />
  <transition-group name="fade">
    <div 
      v-if="isVisibleDosageEditModal"
      class="over-flow-visible"
    >
      <Modal>
        <DosageEditModal
          v-model:dosage="editDosage"
          @update-dosage="handleEditDosage"
          @delete-dosage="handleDeleteDosage"
          @close-edit-modal="handleCloseEditModal"
        />
      </Modal>
    </div>
    <div v-if="isVisibleDosageCreateModal">
      <Modal>
        <DosageCreateModal
          @create-dosage="handleCreateDosage"
          @close-create-modal="handleCloseCreateModal"
        />
      </Modal>
    </div>
  </transition-group>
</template>

<script>
import { mapActions, mapGetters} from 'vuex'
import DosagesTable from './DosageTable'
import DosageEditModal from './DosageEditModal'
import DosageCreateModal from './DosageCreateModal'
import Modal from '../../components/TheModal'
import BaseButton from '../../components/BaseButton'

export default {
  name: 'DosagesIndex',
  components: {
    DosagesTable,
    DosageEditModal,
    DosageCreateModal,
    Modal,
    BaseButton,
  },
  data() {
    return {
      dosages: [],
      editDosage: {},
      isVisibleDosageTable: true,
      isVisibleDosageEditModal: false,
      isVisibleDosageCreateModal: false,
    }
  },
  computed: {
    ...mapGetters('dosages', ['dosageList']),
  },
  mounted() {
    this.fetchDosages()
  },
  methods: {
    ...mapActions('dosages', ['fetchDosages', 'deleteDosage', 'updateDosage', 'createDosage']),
    handleCloseTable() {
      this.isVisibleDosageTable = false
    },
    handleShowEditModal(dosage) { 
      //　参照元を変える
      this.editDosage = Object.assign({}, dosage)
      this.isVisibleDosageEditModal = true
    },
    handleCloseEditModal() {
      this.isVisibleDosageEditModal = false
    },
    async handleEditDosage() {
      try {
        await this.updateDosage(this.editDosage)
        this.handleCloseEditModal()
      } catch(err) {
        this.$store.commit('flashMessage/setFlashMessage', err.response)
      }
   },
    handleShowCreateModal() {
      this.isVisibleDosageCreateModal = true
    },
    handleCloseCreateModal() {
      this.isVisibleDosageCreateModal = false
    },
    async handleCreateDosage(dosage) {
      try {
        await this.createDosage(dosage)
        this.handleCloseCreateModal()
      } catch(err) {
        this.$store.commit('flashMessage/setFlashMessage', err.response)
      }
    },
    async handleDeleteDosage(dosage) {
        try {
          await this.deleteDosage(dosage)
          this.handleCloseEditModal()
        } catch(err) {
          this.$store.commit('flashMessage/setFlashMessage', err.response)
        }
    },
  },
}
</script>

<style>
.fade-enter-active, .fade-leave-active {
    transition: opacity .5s;
    
}
.fade-enter, .fade-leave-to {
    opacity: 0;
}
</style>
