
jQuery.fn.extend({
    initWidgets: function(widgets){
        if($.inArray('chosen', widgets) > -1){
            $(this).find('.initChosen').chosen({ // chosen. Classname: initChosen
                disable_search: true,
                no_results_text: ":( ",
                placeholder_text_multiple: "",
                width: "100%"
            });
        }
        
        if($.inArray('tinymce', widgets) > -1){
            $(this).find('.initTinymce').tinymce({ // initTinymce

            });
        }
                
      //  $(this).find('.hideElements').hideElements(['true'],'#nick,#fullName');
        
        // ...
        
        return this;
    }
});
