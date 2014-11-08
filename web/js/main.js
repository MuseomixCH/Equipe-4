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