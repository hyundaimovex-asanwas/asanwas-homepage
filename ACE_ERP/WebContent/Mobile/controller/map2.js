
var poly;
var map;
var lat;
var lng;
function fnInitPage() {
     
        if (navigator.geolocation) {
            $("#latlng").html("");
            $("#errormsg").html("");
            navigator.geolocation.getCurrentPosition(function(pos) {
                lat = pos.coords.latitude;
                lng = pos.coords.longitude;

                var mapOptions = {
                    zoom: 17,
                    mapTypeId: google.maps.MapTypeId.ROADMAP,
                    center: new google.maps.LatLng(lat, lng)
                };

                map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions);

                var polyOptions = {
                    strokeColor: '#000000',
                    strokeOpacity: 1.0,
                    strokeWeight: 3
                };
                poly = new google.maps.Polyline(polyOptions);
                poly.setMap(map);

                // Add a listener for the click event
                google.maps.event.addListener(map, 'click', addLatLng);

            }, function(error) {
                switch (error.code) {
                    case 1:
                        $("#errormsg").html("User denied the request for Geolocation.");
                        break;
                    case 2:
                        $("#errormsg").html("Location information is unavailable.");
                        break;
                    case 3:
                        $("#errormsg").html("The request to get user location timed out.");
                        break;
                    case 0:
                        $("#errormsg").html("An unknown error occurred.");
                        break;
                }
            });
        }
        else {
            $("#errormsg").html("Geolocation is not supported by this browser.");
        }
    }

    function placeMarker(location) {
        var marker = new google.maps.Marker({
            position: location,
            map: map
        });

        map.setCenter(location);
    }

    function addLatLng(event) {

        var path = poly.getPath();
       // calculateDistances(map.center,event.latLng);
        alert(calcDistance(lat, lng, event.latLng.k, event.latLng.B));
        // Because path is an MVCArray, we can simply append a new coordinate
        // and it will automatically appear.
        path.push(event.latLng);

        // Add a new marker at the new plotted point on the polyline.
        var marker = new google.maps.Marker({
            position: event.latLng,
            title: '#' + path.getLength(),
            map: map
        });
    }

    function calcDistance(lat1, lon1, lat2, lon2) {
        var EARTH_R, Rad, radLat1, radLat2, radDist;
        var distance, ret;


        EARTH_R = 6371000.0;
        Rad = Math.PI / 180;
        radLat1 = Rad * lat1;
        radLat2 = Rad * lat2;
        radDist = Rad * (lon1 - lon2);

        distance = Math.sin(radLat1) * Math.sin(radLat2);
        distance = distance + Math.cos(radLat1) * Math.cos(radLat2) * Math.cos(radDist);
        ret = EARTH_R * Math.acos(distance);

        var rtn = Math.round(Math.round(ret) / 1000);

        if (rtn <= 0) {
            rtn = Math.round(ret) + " m";
        } else {
            rtn = rtn + " km";
        }

        return rtn;
    }

    function calculateDistances(origin1, destinationA) {
        var service = new google.maps.DistanceMatrixService();
        service.getDistanceMatrix(
    {
        origins: [origin1],
        destinations: [destinationA],
        travelMode: google.maps.TravelMode.DRIVING,
        unitSystem: google.maps.UnitSystem.METRIC,
        avoidHighways: false,
        avoidTolls: false
    }, callback);
    }

    function callback(response, status) {
        if (status != google.maps.DistanceMatrixStatus.OK) {
            alert('Error was: ' + status);
        } else {
            var origins = response.originAddresses;
            var destinations = response.destinationAddresses;
            var outputDiv = document.getElementById('outputDiv');
            outputDiv.innerHTML = '';
           // deleteOverlays();

            for (var i = 0; i < origins.length; i++) {
                var results = response.rows[i].elements;
                //addMarker(origins[i], false);
                for (var j = 0; j < results.length; j++) {
                  //  addMarker(destinations[j], true);
                    outputDiv.innerHTML += origins[i] + ' to ' + destinations[j]
            + ': ' + results[j].distance.text + ' in '
            + results[j].duration.text + '<br>';
                }
            }
        }
    }


    google.maps.event.addDomListener(window, 'load', fnInitPage);