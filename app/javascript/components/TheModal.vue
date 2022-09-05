<template>
  <div class="fixed top-0 left-0 w-full h-full bg-black/50 z-10">
    <div class="mx-auto mt-24 px-3 md:px-24">
      <slot />
    </div>
  </div>
</template>
<script>
export default {
  name: 'TheModal',
  emits: ['closeModal'],
}
</script>
<style scoped>

.modal__box {
position: absolute;
top: 50%;
left: 50%;
display: flex;
flex-direction: column;
justify-content: space-between;
width: 500px;
height: 200px;
padding: 32px;
background-color: #fff;
border-radius: 4px;
transform: translate(-50%, -50%);

}

</style>
