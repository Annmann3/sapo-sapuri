<template>
</template>

<script>
export default {
  name: 'LineCallback',
  async mounted() {
    const { auth_token, client_id, uid, expiry } = this.$route.query
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
</script>
