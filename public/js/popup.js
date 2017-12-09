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
// sőt, gyakorlatilag egy az egyben át lehet adni neki egy ilyet:
//  makePopUp('data/url', true, continueWhenEveryFieldIsSaved);
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
        // valamiért nem engedte,hogy egy uform-on kívülre tegyem a .popupWindow-ot mert úgy nem találta meg
        var windowContent = $(content);

        $(back).html(windowContent);

        if ($(windowContent).hasClass('fullWidth')) {
            $(windowContent).append(closeButton);
        } else {
            $(back).append(closeButton);
        }

        $(back).find('.close').click(function () {
            close();
        });

        $(body).append(back);
        
        if(ajaxComplete){
            ajaxComplete(obj);
        }
    };
    
    var init = function(){
        
        body = $('body');
        back = $('<div class="popupBack">').click(function (e) {
            if (e.target === this)
                close();
        });
        obj.scope = back;
        closeButton = $('<div class="glyphter button popupClose close">');
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

// Galériát, lapozható képnézegető ablakot csinál.

function makeGalleryPopUp(title, imageList, initIndex, deleteFunc) {
    if (imageList.length === 0) {
        return;
    }
    var obj = {};
    
    var back = $('<div class="popupBack galleryBack">');

    var body = $('body');
    var closeButton = $('<div class="popupClose">')
            .addClass('glyphter button')
            .click(close);

    var slideContainer = $('<div class="slideContainer">')
            .swipe(function (dir) {
                if (dir === 'left') {
                    scrollLeft();
                } else if (dir === 'right') {
                    scrollRight();
                }
            });
    
    function close(){
        popupWindows.splice(-1,1);
        $(back).remove();
    }
    function scroll() {
        $(slideContainer).animate({
            scrollLeft: activeIndex * slideContainer.width()
        }, 100);
        refreshNumbers();
        refreshDLBtn();
        showHidePagers();
    }

    function scrollLeft() {
        if (activeIndex < imageList.length - 1) {
            activeIndex++;
            scroll();
        }
    }
    function scrollRight() {
        if (activeIndex > 0) {
            activeIndex--;
            scroll();
        }
    }
    
    function showHidePagers(){
        if (activeIndex > 0) {
            $(leftBtn).show();
        } else {
            $(leftBtn).hide();
        }
        if (activeIndex < imageList.length - 1) {
            $(rightBtn).show();
        } else {
            $(rightBtn).hide();
        }
    }

    function refreshNumbers() {
        galleryNumbers.html((activeIndex + 1) + '/' + imageList.length);
    }
    function refreshDLBtn() {
        downloadBtn.attr('href', imageList[activeIndex].url);
    }

    var leftBtn = $('<div class="leftScroller">').
            click(function () {
                scrollRight();
            });
    var rightBtn = $('<div class="rightScroller">').
            click(function () {
                scrollLeft();
            });

    var downloadBtn = $('<a download class="tool">')
            .html('Kép letöltése');

    var galleryTitle = $('<div class="galleryTitle onGallery">')
            .html(title);
    var galleryNumbers = $('<div class="numbers onGallery">');
    var deleteButton = $('<div class="tool icon-Trash">')
            .html('Fotó törlése');

    var toolsContainer = $('<div class="tools onGallery">')
            .html(downloadBtn)
            .append(deleteButton);

    var slides = [];
    var activeIndex = initIndex ? initIndex : 0;

    $.each(imageList, function (key, image) {
        var slide = $('<div class="slide">')
                .css('background-image', 'url(' + image.url + ')');
        slides.push(slide);
        $(slideContainer).append(slide);
    });

    if (typeof deleteFunc === 'function') {
        $(deleteButton).click(function () {
            deleteFunc(imageList[activeIndex].id);
            $(back).remove();
        });
    }

    $(back).html(slideContainer);
    $(back).append(closeButton);
    $(back).append(leftBtn);
    $(back).append(rightBtn);
    $(back).append(toolsContainer);
    $(back).append(galleryTitle);
    $(back).append(galleryNumbers);
    $(body).append(back);

    $(slideContainer).scrollLeft(activeIndex * slideContainer.width());
    refreshNumbers();
    showHidePagers();
    refreshDLBtn();
    
    obj.close = close;
    obj.scope = back;
    popupWindows.push(obj);

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