/*
    load floor image
*/
function loadFloor(floor){
    floor = typeof floor !== 'undefined' ? floor : 2;
    $('#mainContent img').attr('src','img/maps/floor'+floor+'.svg');
}

/*
    dot position in percent to image
 */
function drawDot(x,y,className,name){
    className = typeof className !== 'undefined' ? className : '';
    name = typeof name !== 'undefined' ? name : '';
    $('#floorImg').append('<div class="dot '+className+'" style="left:'+x+'%;top:'+y+'%">');
}

/*
    beacon or photo
 */

function showButton(content){
    content = typeof content !== 'undefined' ? content : 'photo';
    var icon;
    if(content=='photo'){
        button = '<a href="#" id="takePic"><span class="glyphicon glyphicon-camera"></span></div>';
    }else{
        button = '<span class="glyphicon glyphicon-fullscreen"></span>';
    }
    $('#subContent').html('<div class="actionBtn">'+button+'</div>');
}

/*
    clean main content
 */
function hideMainContent(){
    $('#mainContent').html('');
}

function transparentBackground(){
    $('html').attr('style','background:transparent;');
    $('body').attr('style','background:transparent;');
}

$( document ).ready(function() {
    var fun = "bja43whspny60x2,knliyajr8y6x0yt,xrhnpx6pfdlquob";
    var app = "bja43whspny60x2,knliyajr8y6x0yt";
    var idList = '';

    $('#formmuseochoix').submit(function(e) {
        e.preventDefault();
        if( $('#facteurs .active input').val() == 'fun'){
            idList = fun;
        }else{
            idList = app;
        }
        document.location = 'museochoix://loadContexts?ids='+idList;
        return false;
    });

    $(document).on('click', '#takePic', function (e) {
        e.preventDefault();
        hideMainContent();
        transparentBackground();
    });
});