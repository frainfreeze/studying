// navbar burger toggle
document.addEventListener('DOMContentLoaded', () => {
    // Get all "navbar-burger" elements
    const $navbarBurgers = Array.prototype.slice.call(document.querySelectorAll('.navbar-burger'), 0);

    // Check if there are any navbar burgers
    if ($navbarBurgers.length > 0) {

        // Add a click event on each of them
        $navbarBurgers.forEach(el => {
            el.addEventListener('click', () => {

                // Get the target from the "data-target" attribute
                const target = el.dataset.target;
                const $target = document.getElementById(target);

                // Toggle the "is-active" class on both the "navbar-burger" and the "navbar-menu"
                el.classList.toggle('is-active');
                $target.classList.toggle('is-active');

            });
        });
    }

});

//smooth scrolling
window.smoothScroll = function (target) {
    var scrollContainer = target;
    do { //find scroll container
        scrollContainer = scrollContainer.parentNode;
        if (!scrollContainer) return;
        scrollContainer.scrollTop += 1;
    } while (scrollContainer.scrollTop == 0);

    var targetY = 0;
    do { //find the top of target relatively to the container
        if (target == scrollContainer) break;
        targetY += target.offsetTop;
    } while (target = target.offsetParent);

    scroll = function (c, a, b, i) {
        i++;
        if (i > 30) return;
        c.scrollTop = a + (b - a) / 30 * i;
        setTimeout(function () {
            scroll(c, a, b, i);
        }, 20);
    }
    // start scrolling
    scroll(scrollContainer, scrollContainer.scrollTop, targetY, 0);
}

//app
new Vue({
    el: '#menu',
    components: {
        VueGallerySlideshow
      },
    data() {
        return {
            info: null,  // menu info (json)
            active_el:1, //for side menu
            //for gallery
            images: [
                'res/img/food/1-min.jpg',
                'res/img/food/2-min.jpg',
                'res/img/food/3-min.jpg',
                'res/img/food/4-min.jpg',
                'res/img/food/5-min.jpg',
                'res/img/food/6-min.jpg',
                'res/img/food/7-min.jpg',
                'res/img/food/8-min.jpg',
                'res/img/food/9-min.jpg'
              ],
              index: null
        }
    },
    mounted() {
        axios
            .get('https://pastebin.com/raw/YXPTqtpQ')
            .then(response => (this.info = response.data));
    },
    methods: {
        activate:function(el){
            this.active_el = el;
        }
      }
})
