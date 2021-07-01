
function initialize() {
    if (navigator.geolocation) {
        $("#latlng").html("");
        $("#errormsg").html("");
        navigator.geolocation.getCurrentPosition(function(pos) {
            lat = pos.coords.latitude;
            lng = pos.coords.longitude;

          //  $("#latlng").html("위도 : " + lat + "<br/> 경도 : " + lng);

            var mapOptions = {
                zoom: 17,
                mapTypeId: google.maps.MapTypeId.ROADMAP,
                center: new google.maps.LatLng(lat, lng)
            };

            map = new google.maps.Map(document.getElementById('map'), mapOptions);
     

//            var myIcon = new google.maps.MarkerImage("http://google-maps-icons.googlecode.com/files/restaurant.png", null, null, null, new google.maps.Size(17, 17));
//            var marker = new google.maps.Marker({
//                position: new google.maps.LatLng(lat, lng),
//                map: map,
//                draggable: false,
//                icon: myIcon
//            });
            //            markers.push(marker);

            //클릭했을 때 이벤트
            google.maps.event.addListener(map, 'click', function(event) {
               alert(event.latLng);
               // $("#latlng").html("");
              //  $("#errormsg").html("");

               $("#latlng").html(event.latLng);
           
                placeMarker(event.latLng);
                infowindow.setContent("latLng: " + event.latLng); // 인포윈도우 안에 클릭한 곳위 좌표값을 넣는다.
                infowindow.setPosition(event.latLng);             // 인포윈도우의 위치를 클릭한 곳으로 변경한다.
            });
            //클릭 했을때 이벤트 끝
            //인포윈도우의 생성
//            var infowindow = new google.maps.InfoWindow(
//             { content: '<br><b>원하는 위치을 클릭</b>하면 좌표값생성<br> <b>복사하여 좌료값 입력</b>하십시요',
//                 size: new google.maps.Size(50, 50),
//                 position: myLatlng
//             });
//            infowindow.open(map);




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


// 마커 생성 합수
function placeMarker(location) {
    var clickedLocation = new google.maps.LatLng(location);
    var marker = new google.maps.Marker({ position: location, map: map });
    map.setCenter(location);
}
