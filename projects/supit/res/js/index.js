//maps
var mymap = L.map('mapid').setView([45.806, 15.982], 12);

L.tileLayer('https://api.tiles.mapbox.com/v4/{id}/{z}/{x}/{y}.png?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6ImNpejY4NXVycTA2emYycXBndHRqcmZ3N3gifQ.rJcFIG214AriISLbB6B5aw', {
    maxZoom: 18,
    attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, ' +
        '<a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, ' +
        'Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
    id: 'mapbox.streets'
}).addTo(mymap);

var marker = L.marker([45.806, 15.982]).addTo(mymap);
marker.bindPopup("<b>Fenomen</b><br>Augusta senoe, 78").openPopup();

var marker2 = L.marker([45.83, 16.1]).addTo(mymap);
marker2.bindPopup("<b>Fenomen</b><br>Anke krizmanic, 2");

//app
new Vue({
    el: '#app',
    data() {
        return {
            info: null
        }
    },
    mounted() {
        axios
            .get('https://www.fulek.com/VUA/SUPIT/GetCategoriesAndFoods')
            .then(response => (this.info = response.data))
    }
})