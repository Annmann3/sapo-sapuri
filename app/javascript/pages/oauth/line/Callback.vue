<script setup>
import { onMounted } from 'vue'
import { useRoute, useRouter } from 'vue-router'
import { useStore } from 'vuex'

const route = useRoute()
const router = useRouter()
const store = useStore()

onMounted(async() => {
  const {auth_token, client_id, uid } = route.query
  const headers = {
    'access-token': auth_token,
    'client': client_id,
    'uid': uid,
  }
  try {
    await store.dispatch('users/oauthSignin', headers)
    router.push({ path: '/graph' })
  } catch(err) {
    store.commit('flashMessage/setFlashMessage', err.response)
    router.push({ path: '/' })
  }
})
</script>
