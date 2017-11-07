var tplBuilder = function(){
    
    var obj = {
        json : {},
        modules : {},
        
        textarea : null,
        map : null,
        modlist : null,
        select : null,
        
        
        initTplBuilder: function(_modList,_map,_textarea,_select){
            this.textarea = $(_textarea);
            this.map = $(_map);
            this.select = $(_select);
            this.modlist = $(_modList);
            
            getTemplateJson();
            getModuleList();
            initLayoutSelect();
            loadLayout($(this.select).val(),true);
            
            $(this.textarea).change(function(){
                if(getTemplateJson()){
                    fillMap();
                }
            });
            
        }
    };
    
    function refresh(){
        $(obj.textarea).val(JSON.stringify(obj.json));
        fillMap();
    }
    
    function getModuleList(){
        $.ajax({
            url: '/____/admin/module',
            type: "POST",
            success: function(r){
                obj.modules = r;
                showModuleList();
            }
        });
    }

    function showModuleList(){
        $(obj.modlist).empty();
        $.each(obj.modules,function(mkey,mod){
            $.each(mod,function(pkey,part){
                var modBox = $('<div>')
                    .addClass('moduleDrag')
                    .html(('displayName' in part)?part.displayName:pkey)
                    .attr('draggable',true)
                    .on('dragstart',function(ev){
                        ev.originalEvent.dataTransfer.setData("action", 'add');
                        ev.originalEvent.dataTransfer.setData("modName", mkey);
                        ev.originalEvent.dataTransfer.setData("actionRoute", part.actionRoute);
                        ev.originalEvent.dataTransfer.setData("partName", pkey);
                        if(part.formRoute){
                            ev.originalEvent.dataTransfer.setData("formRoute", part.formRoute);
                        }
                    });
                $(obj.modlist).append(modBox);
            });
        });
    }
    
    function fillMap(){// CSAK a megjelenites !!!

        $(obj.map).find('div.place').each(function(){
            var $this = this;
            $($this).empty();
            var placename = $($this).data('placename');
            if(obj.json && placename in obj.json){
                $.each(obj.json[placename],function(k,module){
                    if('module' in module){
                        var modname = module.module;
                        var moduleInfo = {};
                        if( (modname in obj.modules) &&
                            (module.modulePart in obj.modules[modname]) ){
                                moduleInfo = obj.modules[modname][module.modulePart];
                        } else {
                            moduleInfo.displayName = modname;
                        }
                        var displayName = ('displayName' in moduleInfo)?moduleInfo.displayName:module.modulePart;
                        var delBtn = $('<div>')
                                .addClass('delmodBtn squareBtn boxSmall button fa fa-trash')
                                .click(function(){
                                    obj.json[placename].splice(k,1);
                                    refresh();
                                });
                        var recipient = $('<div>')
                                .addClass('recipient')
                                .recipient(placename,k);
                        var modBtn = $('<div>')
                                .addClass('moduleBox button')
                                .html(displayName)
                                .click(function(){
                                    if('formRoute' in moduleInfo){
                                      //  console.log(module.params);
                                        popupWindow({
                                            title: displayName,
                                            ajaxUrl: modname + '/' + moduleInfo.formRoute,
                                            form: '#tplForm',
                                            formData: module.params,
                                            okFn: function(r){
                                                obj.json[placename][k].params = r;
                                                refresh();
                                            }
                                        });
                                    }
                                })
                                .attr('draggable',true)
                                .on('dragstart',function(ev){ // athelyezes
                                    ev.originalEvent.dataTransfer.setData("action", 'move');
                                    ev.originalEvent.dataTransfer.setData("placeName", placename);
                                    ev.originalEvent.dataTransfer.setData("index", k);
                                })
                                .append(delBtn);
                        $($this).append(recipient).append(modBtn);
                    }
                });
            } else {
                $($this).html(' ( Örökölt beállítások )');
            }

            var lastrecipient = $('<div>')
                    .addClass('recipient')
                    .recipient(placename,null);
            $($this).append(lastrecipient);

        });
    }
    
    function loadLayout(tplid,fill){
        $(obj.map).load(
            "/____/admin/template/form/getView",
            { tplid: tplid },
            function(){
                if(fill){
                    fillMap();
                }
            }
        );
    }
    
    function initLayoutSelect (){
        $(obj.select).change(function(){
            loadLayout($(this).val(),true);
        });
        return this;
    }

    function getTemplateJson(){
        try{
            obj.json = JSON.parse($(obj.textarea).val());
            return true;
        } catch(e) {
            return false;
        }
    }
            
    jQuery.fn.extend({

        recipient: function(placename,before){ //hat majd mas nevet kitalalunk neki
            $(this).on('drop',function(ev){
                ev.preventDefault();
                
                function insertToJson(data){
                    if(!(placename in obj.json)){
                        obj.json[placename] = [data];
                    } else if(before === null) {
                        obj.json[placename].push(data);
                    } else {
                        obj.json[placename].splice(before, 0, data);
                    }
                }
                
                if(ev.originalEvent.dataTransfer.getData("action") === 'move'){
                    
                    var origPlace = ev.originalEvent.dataTransfer.getData("placeName");
                    var origIndex = ev.originalEvent.dataTransfer.getData("index");
                    var newObj = obj.json[origPlace][origIndex];
                    obj.json[origPlace].splice(origIndex,1);
                    insertToJson(newObj);
                    refresh();
                    
                } else if(ev.originalEvent.dataTransfer.getData('action') === 'add'){
                    var modname = ev.originalEvent.dataTransfer.getData('modName');
                    var formRoute = ev.originalEvent.dataTransfer.getData('formRoute');
                    var actionRoute = ev.originalEvent.dataTransfer.getData('actionRoute');
                    var partKey = ev.originalEvent.dataTransfer.getData('partName');
                    
                    if((typeof formRoute !== 'undefined') && formRoute !== ''){
                        popupWindow({
                            title: modname,
                            ajaxUrl: modname + '/' + formRoute,
                            form: '#tplForm',
                            okFn: function(r){
                                insertToJson({
                                    module:modname,
                                    action:actionRoute,
                                    modulePart:partKey,
                                    params:r
                                });
                                refresh();
                            }
                        });
                    } else {
                        insertToJson({
                            module:modname,
                            action:actionRoute,
                            modulePart:partKey
                        });
                        refresh();
                    }
                }
            })
                .on('dragover',function(e){
                    e.preventDefault();
                });
            return this;
        }
    });
    return obj;
};