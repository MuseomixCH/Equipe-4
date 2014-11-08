/*
    load floor image
*/
function loadFloor(floor=2){
    $('#mainContent img').attr('src','img/maps/floor'+floor+'.svg');
}

/*
    dot position in percent to image
 */
function drawDot(x,y,className='',name=''){
    $('#floorImg').append('<div class="dot '+className+'" style="left:'+x+'%;top:'+y+'%">');
}

/*
    beacon or photo
 */

function showButton(content='photo'){

}

/*
    clean main content
 */
function hideMainContent(){
    $('#mainContent').html('');
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

});