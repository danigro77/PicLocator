$(function() {
    var $find_button = $('button.find_pics');
    $find_button.on('click', function (event) {
        var $latitude_input = $('input.latitude');
        var $longitude_input = $('input.longitude');
        var $radius_input = $('input.radius');
        var latitude = $latitude_input.val();
        var longitude = $longitude_input.val();
        var radius = $radius_input.val();
        var pictures = get_data(latitude, longitude, radius);
    });

    var get_data = function (latitude, longitude, radius) {
        var url = "images/";
        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: url,
            dataType: "json",
            data: { latitude: latitude, longitude: longitude, radius: radius},
            success: function (result) {
                window.alert("success!!");
            },
            error: function () {
                window.alert("Something went wrong. Please check your input.");
            }
        });
    }
});