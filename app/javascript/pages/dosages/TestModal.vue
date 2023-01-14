<template>
  <Modal
    v-if="isVisible"
    @close-modal="isVisible=false"
  >
    HELLO MODAL
  </Modal>
  <button
    @click="isVisible=!isVisible"
  >
    HELLO
  </button>
  <p>
    {{ isVisible }}
  </p>
</template>
<script>
import Modal from '../../components/TheModal.vue'

export default {
  name: 'ModalTest',
  components: { Modal },
  data() {
    return {
      isVisible: false
    }
  },
  methods: {
    handleCloseModal() {
      this.isVisible = false 
    },
  }
}
</script>
