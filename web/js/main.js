$( document ).ready(function() {
    var fun = "bja43whspny60x2, knliyajr8y6x0yt, xrhnpx6pfdlquob";
    var app = "bja43whspny60x2, knliyajr8y6x0yt";
    var idList = '';

    $('#formmuseochoix').submit(function() {

        if( $('#facteurs .active input').val() == 'fun'){
            idList = fun;
        }else{
            idList = app;
        }

        var newitem = document.createElement("input");
            newitem.name = "ids";
            newitem.type = "hidden";
            newitem.value = idList;
        $(this).append(newitem);
    });
});