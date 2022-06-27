(self["webpackChunkapp"] = self["webpackChunkapp"] || []).push([["tailwind"],{

/***/ "./app/javascript/packs/tailwind.config.js":
/*!*************************************************!*\
  !*** ./app/javascript/packs/tailwind.config.js ***!
  \*************************************************/
/***/ (function(module, __unused_webpack_exports, __webpack_require__) {

module.exports = {
  purge: ['./app/javascript/**/*.vue', './app/javascript/packs/**/*.js'],
  darkMode: false,
  // or 'media' or 'class'
  theme: {
    extend: {}
  },
  variants: {
    extend: {}
  },
  plugins: [__webpack_require__(/*! @tailwindcss/forms */ "./node_modules/@tailwindcss/forms/src/index.js"), __webpack_require__(/*! @tailwindcss/ui */ "./node_modules/@tailwindcss/ui/index.js")]
};

/***/ })

},
/******/ function(__webpack_require__) { // webpackRuntimeModules
/******/ var __webpack_exec__ = function(moduleId) { return __webpack_require__(__webpack_require__.s = moduleId); }
/******/ __webpack_require__.O(0, ["vendors-node_modules_tailwindcss_forms_src_index_js-node_modules_tailwindcss_ui_index_js"], function() { return __webpack_exec__("./app/javascript/packs/tailwind.config.js"); });
/******/ var __webpack_exports__ = __webpack_require__.O();
/******/ }
]);
//# sourceMappingURL=tailwind.js.map