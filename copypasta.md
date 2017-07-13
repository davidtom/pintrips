<% user.events.each do |event| %>
  <script>
    function initMap() {
      var myLatLng = {lat: <%= event.location.lat %>, lng: <%= event.location.long %>};

      var marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        title: '<%= event.location.name %>'
      });
    }
  </script>
<% end %>




var map;
function initMap() {
  map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: 40.705255, lng: -74.013973},
    zoom: 1
  });
}
var myLatLng = {lat: <%= event.location.lat %>, lng: <%= event.location.long %>};

var marker = new google.maps.Marker({
  position: myLatLng,
  map: map,
  title: '<%= event.location.name %>'
});
