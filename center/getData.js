$(document).ready(function() {
    var time = 500;
    var rate = 0.40;
    var bodyHeight = $(".main-content").height();
    var originHeight = [0, 0, 0, 0, 0, 0];

    $.ajax({
        type: "get",
        url: "http://115.28.17.113/vote/index.php/Index/get_M_data",
        success: function(msg) {
            msg = $.parseJSON(msg);
            cloneAndSetValue(msg);
            setPoll();
        }
    })

    // setCoordinate();
    // function setCoordinate() {
    //     var bodyHeight = $(".main-content").height();
    //     var fontHeight = parseInt($("#coordinate-model").css("font-size"));
    //     for(var i = 0; i <= bodyHeight; i = i + 100) {
    //         $("#coordinate-model").clone(true).removeClass('hide').removeAttr('id').text(i * rate).css("bottom", (i - fontHeight / 2) + "px").appendTo('.sidebar');
    //     }
    // }

    function cloneAndSetValue(msg) {
        var colorList = ['#5e0000', '#190066', '#ac7906', '#114160', '#2ea44e', '#1d7800','#8f0477','#959707','#0a8c81','#f73f06','#068e83'];
        for(var i = 0; i < msg.length; i++) {
            var candidateName = msg[i].id+"号<br />"+msg[i].name;
            $("#cube-model").clone(true).removeClass('hide').find('.vote-num-cube').css('background-color', colorList[i]).closest('.vote-cube').removeAttr('id').closest('.vote-cube').appendTo('.main-content');
            $("#name-model").clone(true).removeClass('hide').removeAttr('id').css('color', colorList[i]).html(candidateName).appendTo('.user-names');
        }
    }

    function setPoll() {
        setTimeout(poll, time);
    }

    function poll() {
        $.ajax({
            type: "get",
            url: "http://115.28.17.113/vote/index.php/Index/get_M_data",
            success: function(msg) {
                msg = $.parseJSON(msg);
                changeHeight(msg);
            }
        })
    }

    function changeHeight(msg) {
        var $cubeDiv = $(".vote-cube").not(".hide");
        var $cubes = $cubeDiv.find(".vote-num-cube");
        var $nums =  $cubeDiv.find(".nums");

        if(msg.length) {
            for(var i = 0; i < msg.length; i++) {
                if(msg[i].count <= bodyHeight * rate) {
                    var targetHeight = ~~(msg[i].count / rate);
                    if(targetHeight !== originHeight[i]) {
                        console.log(targetHeight + "  " + originHeight[i]);
                        originHeight[i] = targetHeight;
                        $cubes.eq(i).animate({height: targetHeight}, time / 2);
                    }
                }
                $nums.eq(i).text(msg[i].count);
            }
            setPoll();
        }
    }
    
})