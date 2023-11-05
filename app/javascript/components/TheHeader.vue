<template>
    <header class="md:flex md:justify-center">
      <nav class="z-10 text-white w-full fixed top-0 bg-yellow-300 shadow md:rounded-b-2xl md:flex md:justify-between opacity-95">
        <div class="flex justify-between md:flex-none items-center h-16 px-2">
          <div class="">
            <router-link
              class="text-3xl font-semibolid md:text-3xl"
              :to="{ path: '/' }"
            >
              SAPO-C
            </router-link>
          </div>
          <div class="">
            <button
              class="md:hidden"
              @click="isOpen = !isOpen"
            >
              <svg
                class="h-6 w-6 fill-current"
                viewBox="0 0 24 24"
              >
                <path
                  v-show="!isOpen"
                  d="M24 6h-24v-4h24v4zm0 4h-24v4h24v-4zm0 8h-24v4h24v-4z"
                />
                <path
                  v-show="isOpen"
                  d="M24 20.188l-8.315-8.209 8.2-8.282-3.697-3.697-8.212 8.318-8.31-8.203-3.666 3.666 8.321 8.24-8.206 8.313 3.666 3.666 8.237-8.318 8.285 8.203z"
                />
              </svg>                       
            </button>
          </div>
        </div>
        <div
          :class="isOpen ? '' : 'hidden'"
          class="left-0 md:block md:mt-0"
        >
          <ul
            class="md:flex md:justify-end"
          >
            <li 
              v-if="!authUser"
              class="border-b-2 border-t-2 border-color-white md:border-none"
            >
              <router-link
                class="block px-8 py-4 hover:bg-yellow-500 rounded"
                :to="{ path: '/login' }"
                @click="isOpen = false"
              >
                ログイン
              </router-link>
            </li>
            <li
              v-if="!authUser"
              class="border-b-2 md:border-none"
            >
              <router-link
                class="block px-8 py-4 hover:bg-yellow-500 rounded"
                :to="{ path: '/register' }"
                @click="isOpen = false"
              >
                新規登録
              </router-link>
            </li>
            <li
              v-if="authUser"
              class="border-b border-t visible md:invisible md:border-none"
            >
              <router-link
                class="block px-8 py-4 hover:bg-yellow-500 rounded"
                :to="{ path: '/my-page' }"
                @click="isOpen = false"
              >
                マイページ
              </router-link>
            </li>
            <!-- プロフィール画像がなければテキスト-->
            <li
              v-if="authUser"
              class="border-b hidden md:block md:border-none hover:bg-yellow-500"
            >
              <router-link
                class="block hover:bg-yellow-500 rounded"
                :to="{ path: '/my-page' }"
                @click="isOpen = false"
              >
                <img
                  v-if="authUser.image !== null"
                  class="rounded-full h-12 w-12 object-cover"
                  :src="authUser.image"
                  alt="プロフィール画像"
                />
                <p
                  v-else
                  class="block px-8 py-4 hover:bg-yellow-500 rounded"
                  >マイページ
                </p>
              </router-link>
            </li>
            <li
              v-if="authUser"
              class="border-b md:border-none hover:bg-yellow-500"
            >
              <router-link
                class="block px-8 py-4 rounded"
                :to="{ path: '/dosages' }"
                @click="isOpen = false"
              >
                服用履歴
              </router-link>
            </li>
            <li
              v-if="authUser"
              class="border-b md:border-none hover:bg-yellow-500"
            >
              <router-link
                class="block px-8 py-4 hover:bg-yellow-500 rounded"
                :to="{ path: '/graph' }"
                @click="isOpen = false"
              >
                グラフ
              </router-link>
            </li>
            <li
              v-if="authUser"
              class="border-b md:border-none hover:bg-yellow-500"
            >
              <button
                class="px-6 py-4 rounded"
                type="button"
                @click="logout"
              >
                ログアウト
              </button>
            </li>
          </ul>
        </div>
      </nav>
    </header>
</template>

<script>
import { mapActions, mapGetters } from 'vuex'

export default {
  name: 'TheHeader',
  data() {
    return {
      isOpen: false,
    }
  },
  computed: {
    ...mapGetters('users', ['authUser'])
  },
  methods: {
    ...mapActions('users',['signout']),
    async logout() {
      try {
        await this.signout()
        this.isOpen = false
        this.$router.push({ path: '/' })
      } catch (error) {
        console.log(error)
      }
    }
  }
}
</script>
