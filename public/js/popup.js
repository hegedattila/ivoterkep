// popup ablakot csinál. 

var popupWindows = [];

// data: lehet tartalom, vagy url
// isAjaxUrl: jelzi, ha a data paraméter URL.. alapért: true
// closeCallback: saját metódus, amely az ablak megnyitása ill. bezárása előtt fut le.
//  Paraméterként megkapja az ablakot bezáró metódust.
//  használata tehát:
//  makePopUp('data/url', true, function(callback){
//      // ... minden amit el kell végezni a bezárás előtt ...
//      if(mindenRendben){
//          callback();
//      }
//  });
// 

function makePopUp(data, isAjaxUrl, openCallback, closeCallback, ajaxComplete) {
    if (!data) {
        return;
    }
    if (isAjaxUrl == null || isAjaxUrl == 'undefined') {
        isAjaxUrl = true;
    }
    var obj = {};
    var back, closeButton, body;
    
    var show = function(){
        if (isAjaxUrl) {
            $.post(data, {}, createWindow, 'html');
        } else {
            createWindow(data);
        }
    };
    
    var createWindow = function (content) {
        var windowContent = $(content);
        console.log($(windowContent).find('#transparent-overlay'));
        back = $(windowContent);
        closeButton = $(windowContent).find('#popup-btn-close-container');
        obj.scope = back;
        
        $(back).click(function (e) {
            if (e.target === this)
                close();
        });

        $(closeButton).click(function () {
            close();
        });

        body.append(windowContent);
        

        /*$(back).html(windowContent);

        if ($(windowContent).hasClass('fullWidth')) {
            $(windowContent).append(closeButton);
        } else {
            $(back).append(closeButton);
        }


        $(body).append(back);
        */
        if(ajaxComplete){
            ajaxComplete(obj);
        }
    };
    
    var init = function(){
        
        body = $('body');
        /*back = $('<div class="popupBack">').click(function (e) {
            if (e.target === this)
                close();
        });
        obj.scope = back;
        closeButton = $('<div class="button popupClose close">').html('X');*/
        show();
    };

    var close = function() {
        if (closeCallback) {
            closeCallback(function () {
                $(back).remove();
                popupWindows.splice(-1,1);
            },obj);
            return;
        }
        $(back).remove();
        popupWindows.splice(-1,1);
    };
    
    obj.refreshContent = show;
    obj.close = close;
    popupWindows.push(obj);
    
    if(openCallback){
        openCallback(init,obj);
    } else {
        init();
    }
    
    return obj;
}

function showDialog(content, confirmMethod, exitMethod, confirmText, cancelText) {

    var obj = {};
    
    var back = $('<div class="popupBack dialogBack">');

    var body = $('body');
    
    var title = $('<div class="dialogTitle">').append('Rendszerüzenet');
    
    var xBtn = $('<div class="glyphter button dialogX">').click(close);
    var cnBtn = $('<button class="dialogCancelBtn secondary">').click(close);
    var okBtn = $('<button class="dialogOkBtn primary">').click(realClose);
    
    var buttonContainer = $('<div class="buttonContainer">')
            .append(cnBtn)
            .append(okBtn);
    
    var dialogContent = $('<div class="dialogContent">')
            .html("<p>" + content + "</p>");
    
    var window = $('<div class="dialogWindow">')
            .html(title)
            .append(xBtn)
            .append(dialogContent)
            .append(buttonContainer)
            .draggable({handle: title});
    $(back).html(window)
            .append($('<div class="verticalFix">'));
    
    if(cancelText){
        $(cnBtn).html(cancelText);
    } else {
        $(cnBtn).hide();
    }
    
    $(okBtn).html(confirmText?confirmText:'Ok');
    
    if (confirmMethod) {
        $(okBtn).click(confirmMethod);
    }
    
    function realClose(){
        $(back).remove();
        popupWindows.splice(-1,1);
    }
    
    function close() {
        if (exitMethod) {
            exitMethod(realClose);
            return;
        }
        realClose();
    };
    
    $(body).append(back);
    obj.close = close;
    obj.scope = back;
    popupWindows.push(obj);
    
    return obj;
}

$(document).keyup(function(e){
    if (e.keyCode === 27) {
        if(popupWindows.length){
            popupWindows[popupWindows.length-1].close();
        }
    }
});