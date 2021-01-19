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
import axios from 'axios';

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

  // Use local docker for testing
  async beforeMount() {
    this.columnDefs = [
      { headerName: 'Make',  field: 'make',  sortable: true, filter: true },
      { headerName: 'Model', field: 'model', sortable: true, filter: true },
      { headerName: 'Price', field: 'price', sortable: true, filter: 'agNumberColumnFilter' },
    ];

    const res = await axios.get(":8123/?query=select * from aggrid.cars FORMAT JSON")
    this.rowData = res.data.data.map(r => {
      return { 
        make: r.make,
        model: r.model,
        price: r.price
      }
    })
  }

  // User for talking to galileo (__items)
  // async beforeMount() {
    // this.columnDefs = [
    //   { headerName: 'ID', field: 'item_id', sortable: true, filter: true },
    //   { headerName: 'Name', field: 'name', sortable: true, filter: true },
    //   { headerName: 'tags', field: 'tags', sortable: true, filter: true },
    //   { headerName: 'key', field: 'key', sortable: true, filter: true },
    //   { headerName: 'type', field: 'type', sortable: true, filter: true },
    //   { headerName: 'alias', field: 'alias', sortable: true, filter: true }
    // ];


    // const res = await axios.get(":8123/?query=select * from data__atsgroup.__items where type='tsminstance' FORMAT JSON")

    // this.rowData = res.data.data.map(r => {
    //   return { 
    //     item_id: r.item_id, 
    //     name: r.name,
    //     tags: r.tags,
    //     key: r.key,
    //     type: r.type,
    //     type: r.alias
    //     }
    // })
  // }

}

</script>

<style lang="scss">
  @import "../node_modules/ag-grid-community/dist/styles/ag-grid.css";
  @import "../node_modules/ag-grid-community/dist/styles/ag-theme-balham.css";
</style>
