data: {
    products: []
},

created() {
    fetch('json/74l63.json')
        .then(response => response.json())
        .then(json => {
            this.products = json.products
        })
}
