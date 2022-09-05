<template>
  <div class="bg-yellow-300 shadow">
    <header class="container mx-auto text-white pb-1">
      <nav class="w-full">
        <div class="flex justify-between items-center fixed w-full left-0 h-16 bg-yellow-300 px-2 md:static">
          <router-link
            class="text-4xl font-semibolid md:text-xl"
            :to="{ path: '/' }"
          >
            Sapo-Sapuri
          </router-link>
          <div>
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
          :class="isOpen ? 'block' : 'hidden'"
          class="fixed left-0 w-full mt-16 bg-yellow-300 md:block md:static md:mt-0 shadow md:shadow-none"
        >
          <ul
            class="md:flex md:justify-end md:items-center"
          >
            <li 
              v-if="!authUser"
              class="border-b md:border-none"
            >
              <router-link
                class="block px-8 my-4 hover:bg-yellow-500 rounded"
                :to="{ path: '/login' }"
              >
                ログイン
              </router-link>
            </li>
            <li
              v-if="!authUser"
              class="border-b md:border-none"
            >
              <router-link
                class="block px-8 my-4 hover:bg-yellow-500 rounded"
                :to="{ path: '/register' }"
              >
                新規登録
              </router-link>
            </li>
            <li
              v-if="authUser"
              class="border-b md:border-none"
            >
              <router-link
                class="block px-8 my-4 hover:bg-yellow-500 rounded"
                :to="{ path: '/dosages' }"
              >
                服用履歴
              </router-link>
            </li>
            <li
              v-if="authUser"
              class="border-b md:border-none"
            >
              <button
                class="block px-8 my-4 hover:bg-yellow-500 rounded"
                type="button"
                @click="logout"
              >
                ログアウト
              </button>
            </li>
            <li
              v-if="authUser"
              class="border-b md:border-none"
            >
              <router-link
                class="block px-8 my-4 hover:bg-yellow-500 rounded"
                :to="{ path: '/graph' }"
              >
                グラフ
              </router-link>
            </li>
          </ul>
        </div>
      </nav>
    </header>
  </div>
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
        this.$router.push({ path: '/' })
      } catch (error) {
        console.log(error)
      }
    }
  }
}
</script>
