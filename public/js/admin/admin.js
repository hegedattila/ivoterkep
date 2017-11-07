function loadAdmin(url,params){
    if(!params){
        params = {};
    }
    $.ajax({
        url: '/____/' + url,
        type: 'POST',
        data: params,
        beforeSend: function() {
          //  $("#loader").show();
         },
        success: function(response, status, xhr){
          //  $("#loader").hide();
            adminLoader(response,xhr);
            listLoader(response, url, params);
        }
    });
}

function adminLoader(response, xhr){
    var ct = xhr.getResponseHeader("content-type") || "";
    if (ct.indexOf('html') > -1) { // html
        $('#moduleMenu').empty();
        $('#moduleContent').html(response);
    }
    if (ct.indexOf('json') > -1) { // json
//                if(typeof response !== 'object'){
//                    message(':(', 'red');
//                    return false;
//                }
        if('VIEW' in response){
            $('#moduleContent').html(response.VIEW);
        }
        if('SUBMENU' in response){
            buildModuleSubMenu(response.SUBMENU); //buildmenu
        } else {
            $('#moduleMenu').empty();
        }
        if('MESSAGE' in response && response.MESSAGE !== null){
            if('msg' in response.MESSAGE){
                message(response.MESSAGE.msg, response.MESSAGE.color);
            } else if (Array.isArray(response.MESSAGE)){
                $.each(response.MESSAGE,function(k,v){
                    message(v.msg, v.color);
                });
            }
        }
        if('INVALIDINPUTS' in response && response.INVALIDINPUTS !== null){
            highlightInvalidInputs(response.INVALIDINPUTS);
        }
        if('REDIRECT' in response && response.REDIRECT !== null){
            loadAdmin(response.REDIRECT.url, response.REDIRECT.params);
        }
    }
}

function listLoader(response, url, params){
//                if(typeof response !== 'object'){
//                    message(':(', 'red');
//                    return false;
//                }
    if('LIST' in response){
        if(params.refreshTable){
            $('#moduleContent').buildTable(response.LIST.data,('massbuttons' in response.LIST));
            if('pageInform' in response.LIST){
                $('#moduleContent').showPagination(response.LIST.pageInform,url,params);
            }
        } else {
            $('#moduleContent').adminList(response.LIST,url,params);
        }
    }
}
  
function highlightInvalidInputs(inputs){
    $.each(inputs, function(k,v){
        $('#' + v.htmlid).css('box-shadow','0 0 5px 2px red')
                .change(function(){
                    $(this).css('box-shadow','none');
                });
        $('#' + v.htmlid + '_invalid').css('display','inline-block')
                .find('.tooltipText').html(v.msg);
    });
}

function buildModuleSubMenu(Menu){
    var container = $('<div>').addClass('subMenuContainer');
    $.each(Menu,function (key, menu){
        var button = $('<div>')
                .addClass('boxSmall subMenuBtn button')
                .click(function(){
                    loadAdmin(menu.action,menu.params);
                });
        if(menu.hasOwnProperty('icon')){
            var icon = $('<div>').addClass('menuIcon fa fa-' + menu.icon);
            $(button).html(icon);
        }
        if(menu.hasOwnProperty('label')){
            var label = $('<div>').addClass('menuLabel').html(menu.label);
            $(button).append(label);
        }
        $(container).append(button);
    });
    $('#moduleMenu').html(container);
}

function generateAdminMenu(Menu){
    var element = $('<div>'); 
    $.each(Menu, function(name,menu){
        if(menu){
            var subElement = $('<div>').addClass('admMenuSub');
            var button = $('<div>').addClass('admMenuBtn');
            if(menu.hasOwnProperty('icon')){
                var icon = $('<div>').addClass('menuIcon fa fa-' + menu.icon);
                $(button).html(icon);
            }
            if(menu.hasOwnProperty('label')){
                var label = $('<div>').addClass('menuLabel').html(menu.label);
                $(button).append(label);
            }
            $(subElement).html(button);
            if(menu.hasOwnProperty('subMenu')){ // submenu
                button.addClass('hasSubMenu');
                var dropdown = $('<div>').addClass('admMenuDrop');
                $(button).click(function(e){
                    dropdown.slideToggle(100,function(){
                        if($(this).is( ":visible" )){
                            button.addClass('opened');
                        } else {
                            button.removeClass('opened');
                        }
                    });
                });
                $(dropdown).html(generateAdminMenu(menu.subMenu));
                $(subElement).append(dropdown);
            } else
                if(menu.hasOwnProperty('action')){ // action
                    $(button).click(function(e){
                        loadAdmin(menu.action);
                    });
                }
            $(element).append(subElement);
        }
    });
    return element;
}

function adminMenu(){
    $.ajax({
        url: '/____/menu/admin',
        type: "POST",
        dataType: 'JSON',
        success: function(r){
            $('#adminMenu').html(generateAdminMenu(r));
            $('#adminMenu').find('.admMenuDrop').hide();
        }
    });
}