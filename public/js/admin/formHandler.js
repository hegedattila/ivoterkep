 /* DEPRECEATED!!!! */
//
////(function($){
//    $.fn.serializeObject = function(){
//
//        var self = this,
//            json = {},
//            push_counters = {},
//            patterns = {
//                "validate": /^[a-zA-Z][\w]*(?:\[(?:\d*|[\w]+)\])*$/,
//                "key":      /[\w]+|(?=\[\])/g,
//                "push":     /^$/,
////                "fixed":    /^\d+$/,
//                "named":    /^[a-zA-Z0-9_]+$/
//            };
//
//
//        this.build = function(base, key, value){
//            base[key] = value;
//            return base;
//        };
//
//        this.push_counter = function(key){
//            if(push_counters[key] === undefined){
//                push_counters[key] = 0;
//            }
//            return push_counters[key]++;
//        };
//
//        $.each($(this).serializeArray(), function(){
//            // skip invalid keys
//            if(!patterns.validate.test(this.name)){
//                return;
//            }
//
//            var k,
//                keys = this.name.match(patterns.key),
//                numKeys = keys.length - 1,
//                merge = this.value,
//                reverse_key = this.name;
//                
//            while((k = keys.pop()) !== undefined){
//
//                // adjust reverse_key
//                reverse_key = reverse_key.replace(new RegExp("\\[" + k + "\\]$"), '');
//                
//                // push
//                if(k.match(patterns.push)){ 
//                    merge = self.build([], self.push_counter(reverse_key), merge);
//                }
//
//                // named
//                else if(k.match(patterns.named)){
//                    merge = self.build({}, k, merge);
//                }
//            }
//
//            if(reverse_key in json && numKeys === 0){
//                if(Object.prototype.toString.call( json[reverse_key] ) === '[object Array]'){
//                    json[reverse_key].push(this.value);
//                } else {
//                    json[reverse_key] = [json[reverse_key], this.value];
//                }
//            } else {
//                json = $.extend(true, json, merge);
//            }
//        });
//        
//        return json;
//    };
//    
//    $.fn.adminAjaxForm = function(){
//     //   var $this = this;
//        $(this).submit(function(e){
//            e.preventDefault();
//            var f = new FormData(this);
//            loadAdmin($(this).attr('action'),{form: $(this).serializeObject()});
//        });
//        return this;
//    };
//    
//    
//    
//    
//    
//    
//    
//    
//})(jQuery);