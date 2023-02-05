<template>
  <div class="flex justify-center">
    <a
      :href="loginUrl"
      data-method="post"
    >
    <img
      :src="image"
    >
    </a>
    <button
    type="button"
    @click="login"
    >
    console
    </button>
  </div>
</template>

<script>
import image from 'images/btn_login_base.png'

export default {
  name: 'LineLoginButton',
  data() {
    return {
      image: image,
      omniauth_url: '',
      // フロント側認証後のリダイレクト先
      auth_origin_url: ''
    }
  },
  computed: {
    loginUrl() {
      return this.omniauth_url
             + '?auth_origin_url='
             + encodeURI(this.auth_origin_url)
    }
  },
  mounted() {
    const host = window.location.origin
    this.omniauth_url = `${host}/api/v1/auth/line`
    this.auth_origin_url = `${host}/oauth/line/callback`
    console.log('omniauth_url', this.omniauth_url)
    console.log('auth_origin_url', this.auth_origin_url)
  },
  methods: {
    login() {
      console.log(this.loginUrl)
    }
  }
}
</script>

