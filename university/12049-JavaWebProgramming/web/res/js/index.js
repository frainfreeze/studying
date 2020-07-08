'use strict';

Vue.component('shopping-cart', {
    props: ['items'],
    data() {
        return {
            isShowModal: false
        }
    },
    computed: {
        Total: function () {
            var total = 0;
            this.items.forEach(item => {
                total += (item.Price * item.qty);
            });
            return total;
        }
    },

    methods: {
        removeItem(index) {
            this.items.splice(index, 1)
        }
    }
})

//app
new Vue({
    el: '#menu',
    data() {
        return {
            info: null,  // menu info (json)
            active_el:1, //for side menu

            //cart
            cartItems: [],
            isShowModal: false
        }
    },
    mounted() {
        axios.get('price_list.jsp').then(response => (this.info = response.data));
        console.log('start');
        var retrievedObject = localStorage.getItem('cart');
        if (JSON.parse(retrievedObject) != null)
            this.cartItems = JSON.parse(retrievedObject);
    },
    methods: {
        activate: function (el) {
            this.active_el = el;
        },
        addToCart(itemToAdd) {
            var retrievedObject = localStorage.getItem('cart');
            if (JSON.parse(retrievedObject) != null)
                this.cartItems = JSON.parse(retrievedObject);

            var found = false;

            // Check if the item was already added to cart
            // If so them add it to the qty field
            this.cartItems.forEach(item => {
                if (item.ItemId === itemToAdd.ItemId) {
                    found = true;
                    item.qty += parseInt(itemToAdd.qty);
                }
            });

            if (found === false) {
                this.cartItems.push(Vue.util.extend({}, itemToAdd));
            }

            itemToAdd.qty = 1;
            localStorage.clear();
            localStorage.setItem('cart', JSON.stringify(this.cartItems));
        },
        clearCart() {
            this.cartItems = [];
            localStorage.removeItem('cart');
        }
    }
})