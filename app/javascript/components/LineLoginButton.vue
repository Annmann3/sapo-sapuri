<template>
  <div class="flex justify-center">

    <a
      :href="loginUrl"
      data-method="post"
      :data-params="obj"
    >
    <img
      :src="image"
    >
    </a>
  </div>
</template>

<script>
import image from 'images/btn_login_base.png'
import{ mapGetters  } from 'vuex'

export default {
  name: 'LineLoginButton',
  data() {
    return {
      image: image,
      omniauth_url: '',
      // フロント側認証後のリダイレクト先
      auth_origin_url: '',
      // ログイン中のユーザーの
      provider: '',
      uid: '',
      obj: {
        aisatu: 'Hello',
        where: 'i`m in.',
        numnum: 3,
        uid_nothing: null,
      }
    }
  },
  computed: {
    ...mapGetters('users',['authUser']),
    loginUrl() {
      // postパラメータで送るように修正する
      return this.omniauth_url
             + '?auth_origin_url='
             + encodeURI(this.auth_origin_url)
             + '&provider='
             + this.provider
    },
    dataParams() {
      return JSON.stringify(this.obj)
    }
  },
  mounted() {
    const host = window.location.origin
    this.omniauth_url = `${host}/api/v1/auth/line`
    this.auth_origin_url = `${host}/oauth/line/callback`

    if (this.authUser) {
      this.provider = this.authUser.provider
    }
  },
}
</script>

