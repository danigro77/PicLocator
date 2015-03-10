$(function() {
    var $find_button = $('button.find_pics');
    $find_button.on('click', function (event) {
        var $latitude_input = $('input.latitude');
        var $longitude_input = $('input.longitude');
        var $radius_input = $('input.radius');
        var latitude = clean_string($latitude_input.val());
        var longitude = clean_string($longitude_input.val());
        var radius = clean_string($radius_input.val());
        get_data(latitude, longitude, radius);
    });

    var get_data = function (latitude, longitude, radius) {
        var url = "images/";
        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: url,
            dataType: "json",
            data: {latitude: latitude, longitude: longitude, radius: radius},
            success: function (result) {
                $.each(result, function (index, picture) {
                    $('.images').append("<img src='" + picture['url'] + "' />");
                });
            },
            error: function () {
                window.alert("Something went wrong. Please check your input.");
            }
        });
    };

    var clean_string = function(str) {
        return str.replace(/ /g,'').replace(/,/g,'.')
    };
});