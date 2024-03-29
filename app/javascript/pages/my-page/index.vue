<template>
  <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.13.0/css/all.min.css"
      >
      <div class="p-4 space-y-4 bg-blue-200 items-center mx-auto text-gray-700">
        <h1 class="text-2xl font-bold my-10 text-white text-center">マイページ</h1>

        <section v-if="!visibleEditForm">
          <div class="bg-white p-4 rounded-lg shadow-md">
            <h2 class="text-xl font-bold">ユーザー情報</h2>
            <hr class="my-3" />
            <div class="flex items-center">
              <span class="text-3xl">
                <i class="fas fa-user" />
              </span>
              <p class="ml-4 text-xl font-semibold">{{ user.name }}</p>
            </div>
            <div class="flex items-center">
              <span class="text-3xl">
                <i class="fas fa-envelope" />
              </span>
              <p v-if="user.email !== null" class="ml-4 text-xl font-semibold">{{ user.email }}</p>
              <p v-else class="ml-4 text-xl font-semibold">未設定</p>
            </div>
            <div class="flex items-center">
              <span class="text-3xl fill-current text-green-500">
                <i class="fab fa-line" />
              </span>
              <p v-if="user['line_linked?']" class="ml-4 text-xl font-semibold">連携済み</p>
              <p v-else class="ml-4 text-xl font-semibold">未連携</p>
            </div>
          </div>
          <div class="flex my-2">
            <button class="bg-blue-500 text-white px-4 py-2 rounded-md" @click="handleShowEditForm">編集する</button>
            <button class="bg-red-500 text-white px-4 py-2 rounded-md" @click="deleteUser">アカウントを削除する</button>
          </div>
        </section>


        <section v-if="visibleEditForm">
          <div class="bg-white p-4 rounded-lg shadow-md">
            <h2 class="text-xl font-semibold">ユーザー情報の編集</h2>
            <hr class="my-3" />
            <form @submit.prevent="updateUser">
              <div class="flex items-center">
                <span>
                  <i class="fas fa-user" />
                </span>
                <label for="name"/>
                  <input id="name" v-model="editedUser.name" class="border text-xl" type="text" />
              </div>
              <div v-if="user.email !== null" class="flex items-center">
                <span>
                  <i class="fas fa-envelope" />
                </span>
                <label v-if="user.provider !== 'line'" for="email">メールアドレス:</label>
                <input v-if="user.provider !== 'line'" id="email" v-model="editedUser.email" class="border text-xl" type="email" />
              </div>
            </form>
          </div>
          <div class="flex">
            <button type="button" class="bg-blue-500 text-white px-4 py-2 rounded-md" @click="updateUser">更新</button>
            <button class="bg-gray-400 text-white px-4 py-2 rounded-md" @click="handleShowEditForm">キャンセル</button>
          </div>
        </section>

        <router-link
            :to="{ path: '/password' }"
            class="text-base text-white text-right text-bold text-xl font-roboto leading-normal hover:underline mb-6"
            >
            パスワードを変更する
        </router-link>
          <section v-if="!user['line_linked?']">
            <div class="bg-white p-4 rounded-lg shadow-md">
              <h2 class="text-xl font-semibold">LINE連携は公式アカウントから</h2>
              <hr class="my-3" />
              <LineFriendAddButton />
              <div class="p-4 bg-gray-50 rounded border-4 border-double border-gray-600">
                <h3 class="text-xl font-semibold text-gray-700 mb-2">連携方法</h3>
                <ol class="list-disc">
                  <li>ユーザー登録後に公式アカウントを友だち追加する</li>
                  <li>「アカウント連携する」ボタンを押して完了</li>
                  <li>メールアドレスで登録した方はその後に出てくる「連携する」を押してログインしてください</li>
                </ol>
              </div>
            </div>
          </section>
          <section v-else>
            <div class="bg-white p-4 rounded-lg shadow-md">
              <h2 class="text-xl font-semibold">LINEアカウントの情報を削除する</h2>
              <hr class="my-3" />
              <BaseButton
                  :bgcolor="'bg-red-500 hover:bg-red-600'"
                  @click="deleteLineAccount"
                  >
                  LINEアカウント情報を削除する
              </BaseButton>
              <div class="mt-3 p-4 bg-gray-50 rounded border-4 border-double border-gray-600">
                <h3 class="text-xl font-semibold text-gray-700 mb-2">注意</h3>
                <ol class="list-disc">
                  <li>LINEアカウントを削除するにはメールアドレスとパスワードの登録が必要です</li>
                  <li>メールアドレスを登録後に「パスワードを変更する」からパスワード設定してください</li>
                </ol>
              </div>
            </div>
          </section>
      </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useStore } from 'vuex'
import { useRouter } from 'vue-router'
import LineFriendAddButton from 'components/LineFriendAddButton'
import BaseButton from 'components/BaseButton'

const store = useStore()
const router = useRouter()

const editedUser = ref({
  name: '',
  email: ''
})

const visibleEditForm = ref(false)

const user = store.state.users.authUser

onMounted(() => {
  editedUser.value = {
    name: user.name,
    email: user.email
  }
})

const handleShowEditForm = () => {
  visibleEditForm.value = !visibleEditForm.value
}

const updateUser = () => {
  try {
    store.dispatch('users/updateUser', editedUser.value)
  } catch (err) {
    store.commit('flashMessage/setFlashMessage', err.response)
  }
}
const deleteUser = async() => {
  try {
    const result = confirm('本当に削除しますか？')
    if (!result) return
    await store.dispatch('users/deleteUser')
    router.push({ path: '/' })
  } catch (err) {
    store.commit('flashMessage/setFlashMessage', err.response)
  }
}

const deleteLineAccount = async() => {
  try {
    const result = confirm('本当に削除しますか？')
    if (!result) return
    await store.dispatch('users/deleteSocialAccount', 'line')
    router.push({ path: '/' })
  } catch (err) {
    store.commit('flashMessage/setFlashMessage', err.response)
  }
}
const userFast = computed(() => store.state.users.authUser)
</script>

