$(function() {
    var $find_button = $('button.find_pics');
    var last_element_class, latitude, longitude, radius;
    var last_element_id = -1;
    $find_button.on('click', function (event) {
        var $latitude_input = $('input.latitude');
        var $longitude_input = $('input.longitude');
        var $radius_input = $('input.radius');
        latitude = clean_string($latitude_input.val());
        longitude = clean_string($longitude_input.val());
        radius = clean_string($radius_input.val());
        get_data(latitude, longitude, radius, event);
    });

    $(window).on('scroll', function(event) {
        if($(window).scrollTop() + $(window).height() == $(document).height()) {
            get_data(latitude, longitude, radius, event);
        }
    });

    var get_data = function (latitude, longitude, radius, event) {
        var url = "images/";
        $.ajax({
            type: "GET",
            contentType: "application/json; charset=utf-8",
            url: url,
            dataType: "json",
            data: {latitude: latitude, longitude: longitude, radius: radius},
            success: function (result, evt) {
                console.log(result);
                $.each(result, function (index, picture) {
                    last_element_id++;
                    last_element_class = "image_"+last_element_id;

                    $('.images').append("<img class="+ last_element_class +" src='" + picture['url'] + "' />");
                });
                event.preventDefault();
            },
            error: function () {
                window.alert("Something went wrong. Please check your input.");
            }
        });
    };

    var clean_string = function(str) {
        return str.replace(/\s/g,'').replace(/,/g,'.')
    };
});