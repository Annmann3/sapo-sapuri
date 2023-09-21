<template>
</template>

<script>
export default {
  name: 'LineCallback',
  async mounted() {
    const { auth_token, client_id, uid, expiry, change_provider } = this.$route.query
    debugger
    if (change_provider === 'true') {
      await this.$store.dispatch('users/updateProvider', { provider: 'line', uid: uid })
    } else {
      const headers = {
        'access-token': auth_token,
        'client': client_id,
        'uid': uid,
        'expiry': expiry,
      }
      await this.$store.dispatch('users/oauthSignin', headers)
      this.$router.push('/')
    }
  }
}
</script>
