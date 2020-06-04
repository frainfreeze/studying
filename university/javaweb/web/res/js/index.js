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
                total += (item.Cijena * item.qty);
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
        axios
            .get('http://localhost:8080/price_list.jsp')
            .then(response => (this.info = response.data));
    },
    methods: {
        activate:function(el){
            this.active_el = el;
        },
        addToCart(itemToAdd) {
            var found = false;

            // Check if the item was already added to cart
            // If so them add it to the qty field
            this.cartItems.forEach(item => {
                if (item.JeloId === itemToAdd.JeloId) {
                    found = true;
                    item.qty += parseInt(itemToAdd.qty);
                }
            });

            if (found === false) {
                this.cartItems.push(Vue.util.extend({}, itemToAdd));
            }

            itemToAdd.qty = 1;
        },
        clearCart() {
            this.cartItems = [];
        }
    }
})