jQuery.fn.extend({
    hideElements: function(arr){
        var $this = this;
        $(arr).each(function (key,val){
            $($this).find(val.element).change(function(){
                var thisValue = ($(this).attr('type') === "checkbox")?!this.checked:$(this).val();
                
                if($.inArray(thisValue, val.values)){
                    $(val.hideElements).hide(50);
                } else {
                    $(val.hideElements).show(50);
                }

            });
        });
        return this;
    }
});