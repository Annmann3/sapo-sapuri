<template>
  <div />
</template>

<script>
import { mapActions, mapGetters} from 'vuex'

export default {
  name: 'DosagesIndex',
  data() {
    return {
      dosage: {
        dosage: '',
        dosage_at: '',
      }
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
    setdosage() { 
      console.log(this.dosageList)
    },
  },
}
</script>
