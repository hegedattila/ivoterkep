    var map;
    var selfPos = null;
    var directionsDisplay;
    var directionsService;
    var geoCoder;
    var popup;
    var timeout;

    function initMap() {
        map = new google.maps.Map(document.getElementById('map'), {
            center: {
                lat: 47.532300,
                lng: 21.629500
            },
            zoom: 13,
            disableDoubleClickZoom: true,
            disableDefaultUI: true,
            gestureHandling: "greedy",
            clickableIcons: false,
            styles: [{
                    featureType: 'poi.business',
                    elementType: 'all',
                    stylers: [{
                            visibility: 'off'
                        }]
                }, {
                    featureType: 'poi.park',
                    elementType: 'labels.icon',
                    stylers: [{
                            visibility: 'off'
                        }]
                }]
        });
        
        directionsService = new google.maps.DirectionsService();
        directionsDisplay = new google.maps.DirectionsRenderer();
                
 //selfPos = addMarker({lat:47.5472978,lng:21.6383488}, '51baef', 'Ön itt áll'); // teszt!!

        map.addListener('dragend', timeoutAndRefresh);
        map.addListener('zoom_changed', timeoutAndRefresh);

        geoLocate();
        window.setTimeout(refreshList, 500);
        
        if(initSef){
            popUp = makePopUp('/____/pubMap/showPub/' + initSef);
        }
        
        geoCoder = new google.maps.Geocoder();
    }
    var markers = [];
    
    function timeoutAndRefresh(){
        if(timeout){
            clearTimeout(timeout);
        }
        timeout = setTimeout(refreshList, 500);
    }
    function geoCode(addr){
        geoCoder.geocode({ address: addr }, function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                map.setZoom(15);
            } else {
            // jaj
            }
        });
    }

    function calcRoute(pos) {
        if(!selfPos){
            alert('Sajnos ez nem jött össze! Nincs engedélyezve a helymeghatározás funkció a böngésződben. :( ');
            return;
        }
        if(popup){
            popup.close();
        }
        var origin = selfPos.getPosition();
      //  var bounds = new google.maps.LatLngBounds();
      //  bounds.extend(origin);
      //  bounds.extend(pos);
      //  map.fitBounds(bounds);
        var request = {
            origin: origin,
            destination: pos,
            travelMode: google.maps.TravelMode.WALKING
        };
        directionsService.route(request, function (response, status) {
            if (status === google.maps.DirectionsStatus.OK) {
                directionsDisplay.setDirections(response);
                directionsDisplay.setMap(map);
                directionsDisplay.setOptions( { suppressMarkers: true } );
            } else {
                alert('Sajnos ez nem jött össze :( ');
            }
        });
    }
    
    function getColoredMarker(color){
        return new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_letter&chld=%E2%80%A2|" + color,
            new google.maps.Size(21, 34),
            new google.maps.Point(0,0),
            new google.maps.Point(10, 34));
    }
    
    function refreshList() {
        if(map.getZoom() < 13){
            deleteMarkers();
            $('#result-container').html('Ebben a nagyításban nem tudjuk megjeleníteni a találatokat. Bocsi.');
            return;
        }
        var bounds = map.getBounds();
        $.post(
                '/____/pubMap/getList',
                {
                    date: $("#date").val(),
                    time: $("#time").val(),
                    maxPrice: $("#sliderInput").val(),
                    minLat: bounds.f.b,
                    minLong: bounds.b.b,
                    maxLat: bounds.f.f,
                    maxLong: bounds.b.f,
                    timeFilterEnabled: !$('#enabled').is(':checked')
                },
                function (data) {
                    deleteMarkers();
                    $('#result-container').empty();
                    $.each(data, function (key, val) {
                        addPubMarker(val);
                        addResultToList(val);
                    });
                }
        );
    }
    
    function addResultToList(res) {
        var entry = $('<div>')
                .addClass('result-entry')
                .html(res.name)
                .click(function(){
                    makePopUp('/____/pubMap/showPub/'+res.id);
                });
        $('#result-container').append(entry);
    }
    
    function addMarker(pos, color, name) {
        return new google.maps.Marker({
            position: pos,
            map: map,
            title: name,
            icon: getColoredMarker(color)
        });
    }
    
    function addPubMarker(res) {
        var color;
        switch(res.opened){
            case 'close':
                color = 'ed9482';
                break;
            case 'open':
                color = 'a0f280';
                break;
            case '1hour':
                color = 'f2dc63';
                break;
            default:
                color = 'FFFFFF';
        };
        var marker = addMarker({lat: Number(res.lat), lng: Number(res.lng)}, color, res.name);
        marker.addListener('click', function() {
            popup = makePopUp('/____/pubMap/showPub/'+res.id);
        });
        markers.push(marker);
    }

    // Sets the map on all markers in the array.
    function setMapOnAll(map) {
        for (var i = 0; i < markers.length; i++) {
            markers[i].setMap(map);
        }
    }

    function clearMarkers() {
        setMapOnAll(null);
    }

    function showMarkers() {
        setMapOnAll(map);
    }

    function deleteMarkers() {
        clearMarkers();
        markers = [];
    }
    
    function geoLocate(){
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function (position) {
                pos = {
                    lat: position.coords.latitude,
                    lng: position.coords.longitude
                };
                map.setCenter(pos);
                map.setZoom(15);
                if(selfPos){
                    selfPos.setMap(null);
                }
                selfPos = addMarker(pos, '51baef', 'Ön itt áll');
                
                directionsDisplay.setMap(map);
            },function(err) {
                console.warn(err.code+':'+err.message);
            });
            return true;
        } else {
            return false;
        }
    }
    
    window.onload = function() {
        $('#searchbox').keypress(function (e) {
            if (e.which == 13) {
                geoCode($(this).val());
            }
        });
        $('#locate-user').click(function () {
            if(!geoLocate()){
                alert('Sajnos ez nem jött össze! Nincs engedélyezve a helymeghatározás funkció a böngésződben. Bocsi! ');
            }
            refreshList();
        });
    };
    