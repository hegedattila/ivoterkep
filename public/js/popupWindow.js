function popupWindow(obj){ // content[html], ajaxUrl[url], ajaxParams[object], form[null|selector], buttons[object(text,func)],
                            // cancelBtn[true,false], okBtn[true,false], exitBtn[true,false],
                            // cancelFn[func], okFn[func], exitFn[func]
    var set = {
        title: '',
        content: '',
        ajaxUrl: null, // felulirja a contentet!!!
        ajaxParams: {},
        form: null,
        buttons: {},
        cancelBtn: true,
        okBtn: true,
        exitBtn: true,
        cancelFn: null,
        okFn: null,
        exitFn: null,
        formData: null
    };
    var buttonContainer, bg, window, title, content;
    
    $.extend(set,obj);
    
    if(set.ajaxUrl){ 
        $.ajax({
            url: '/____/' + set.ajaxUrl,
            type: "POST",
            data: set.ajaxParams,
            success: function(r){
                set.content = r;
                buildWindow();
            }
        });
    } else {
        buildWindow();
    }
       
    function buildWindow(){
        title = $('<div>')
                .addClass('popupTitle')
                .html(set.title);

        content = $('<div>')
                .addClass('popupContent')
                .html(set.content);

        buttonContainer = $('<div>')
                .addClass('buttonCont');

        if(set.okBtn){                  // ok button
            addButton('OK','popupOkBtn',true,set.okFn);
        }

        if(set.cancelBtn){
            addButton('Cancel',null,true,set.cancelFn);
        }

        if(set.exitBtn){
            var Btn = $('<div>')
                .addClass('button fa fa-times right')
                .click(closeWindow);

            if(set.exitFn){
                $(Btn).click(function(){
                    if(set.form){
                        // getFormData
                    }
                    set.exitFn('responseData');
                });
            }
            $(title).append(Btn);
        }
        
        if(set.formData){
            setFormContent(set.formData);
        }

        window = $('<div>')
                .addClass('popupWindow vertCenter')
                .html(title)
                .append(content)
                .append(buttonContainer);

        bg = $('<div>')
                .addClass('popupContainer')
                .html(window)
                .append('<div class="vertFixer">');

        $('body').append(bg);
    }
    
    function addButton(text,cssclass,exit,moreFn){
        var Btn = $('<div>')
            .html(text)
            .addClass('popupBtn button ' + cssclass);
        if(exit){
            Btn.click(closeWindow);
        }
        if(moreFn){
            $(Btn).click(function(){
                var values = {};
                if(set.form){
                    values = getFormContent();
                }
                moreFn(values);
            });
        }
        $(buttonContainer).append(Btn);
    }
    
    function closeWindow(){
        $(bg).remove();
    };
    
    function getFormContent(){
        var values = {};
        $(content).find('input,textarea,select').each(function(){
            values[$(this).attr("name")] = $(this).val();
        });
        return values;
    }
    
    function setFormContent(data){
        $.each(data,function(key,fieldData){
            $(content).find("[name=" + key + "]").val(fieldData);
        });
    }
}

function confirmWindow(text,ok,can){
    return popupWindow({
        content: text,
        exitBtn: false,
        okFn: function(){
            (ok)?ok():null;
        },
        cancelFn: function(){
            (can)?can():null;
        }
    });
}