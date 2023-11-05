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
              <span>
                <i class="fas fa-user" />
              </span>
              <p class="ml-4 text-xl font-semibold">{{ user.name }}</p>
            </div>
            <div class="flex items-center">
              <span>
                <i class="fas fa-envelope" />
              </span>
              <p v-if="user.email !== null" class="ml-4 text-xl font-semibold">{{ user.email }}</p>
              <p v-else class="ml-4 text-xl font-semibold">未設定</p>
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
            class="text-base text-white text-right text-bold font-roboto leading-normal hover:underline mb-6"
            >
            パスワードを変更する
        </router-link>
          <section>
            <div class="bg-white p-4 rounded-lg shadow-md">
              <h2 class="text-xl font-semibold">LINE連携は公式アカウントから</h2>
              <hr class="my-3" />
              <LineFriendAddButton />
            </div>
          </section>
      </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import { useStore } from 'vuex'
import LineFriendAddButton from 'components/LineFriendAddButton'

const store = useStore()

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
const deleteUser = () => {
  try {
    const result = confirm('本当に削除しますか？')
    if (!result) return
    store.dispatch('users/deleteUser')
  } catch (err) {
    store.commit('flashMessage/setFlashMessage', err.response)
  }
}
</script>

