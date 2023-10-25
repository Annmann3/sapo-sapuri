
<script setup>
import { ref, onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useStore } from 'vuex'

const loading = ref(false)
const error = ref(null)
const route = useRoute()
const router = useRouter()
const store = useStore()

onMounted(async() => {
  debugger
  const {auth_token, client_id, uid } = route.query
  const headers = {
    'access-token': auth_token,
    'client': client_id,
    'uid': uid,
  }
  try {
    loading.value = true
    await store.dispatch('users/oauthSignin', headers)
    loading.value = false
    router.push({ path: '/graph' })
  } catch(err) {
    error.value = err.response
    store.commit('flashMessage/setFlashMessage', err.response)
    router.push({ path: '/' })
  }
})
</script>
