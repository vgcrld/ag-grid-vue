<template>
  <div id="app">
    <h1>Hello from ag-Grid!</h1>
    <ag-grid-vue style="width: 1000px; height: 500px;"
      class="ag-theme-balham"
      :columnDefs="columnDefs"
      :rowData="rowData">
    </ag-grid-vue>
  </div>
</template>

<script>
import { AgGridVue } from "ag-grid-vue";

export default {
  name: 'App',
  data() {
    return {
      columnDefs: null,
      rowData: null
    }
  },
  components: {
    AgGridVue
  },
  beforeMount() {
    this.columnDefs = [
      { headerName: 'Make', field: 'make',   sortable: true, filter: true },
      { headerName: 'Model', field: 'model', sortable: true, filter: true },
      { headerName: 'Price', field: 'price', sortable: true, filter: true },
    ],
    this.rowData = [
      { make: 'Toyota', model: 'Celica', price: 35000 },
      { make: 'Ford', model: 'Mondeo', price: 32000 },
      { make: 'Porsche', model: 'Boxter', price: 72000 },
    ]
  }

}
</script>

<style lang="scss">
  @import "../node_modules/ag-grid-community/dist/styles/ag-grid.css";
  @import "../node_modules/ag-grid-community/dist/styles/ag-theme-balham.css";
</style>
