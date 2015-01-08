function showFront() {
    dizmo.showFront();
}

function showBack() {
    dizmo.showBack();
}

dizmo.onShowBack(function() {
                 // You can add your own code here that will be executed when the back side is shown.
                 });

dizmo.onShowFront(function() {
                  // You can add your own code here that will be executed when the front side is shown.
                  });

function getSunMoonData(lat,lon) {
    var _today = new Date();
    var mm=_today.getMonth()+1 // since January returns 0
    var dd=_today.getDate();
    if(dd<10) {
        dd='0'+dd
    }
    if(mm<10) {
        mm='0'+mm
    }
    var today=_today.getFullYear()+"-"+mm+"-"+dd;
    
    $.ajax({
           method: "GET",
           url: "http://api.met.no/weatherapi/sunrise/1.0/?lat="+lat+";lon="+lon+";date="+today,
           dataType: 'xml',
           success: function (response) {
           xmlParser(response);
           }
           });
}

function xmlParser(response){
    var out="";
    
    out+="<p>Sunrise: "+$(response).find('sun').attr('rise')+" Sunset: "+$(response).find('sun').attr('set')+"</p>";
    out+="<p>Moonphase: "+$(response).find('moon').attr('phase')+" Moonrise: "+$(response).find('moon').attr('rise')+" Moonset: "+$(response).find('moon').attr('set')+"</p>";
    
    $('#displaydata').append(out);
}
function jsonParser(response){
    var lat=response[0].lat;
    var lon=response[0].lon;
    getSunMoonData(lat,lon);
}

document.addEventListener('dizmoready', function() {
                          console.log("ready");
                          $.ajax({
                                    method: "GET",
                                    url: "http://nominatim.openstreetmap.org/search?q=zurich&format=json",
                                    success: function (response) {
                                        jsonParser(response);
                                    }
                                 });
                          });


