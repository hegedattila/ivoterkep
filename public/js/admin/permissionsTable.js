jQuery.fn.extend({
    drawPermissionTable: function(permissions,groups){
        var container = $('<div>')
                .addClass('permTableContainer');
        var pTable = $('<table>')
                .addClass('permissionTable')
                .prop('cellspacing', 0);
        var tHead = $('<thead>');
        var tBody = $('<tbody>')
                .addClass('permTableBody');
        var tHeadRow = $('<tr>');
        var $this = $(this);

        $(tHeadRow).append($('<th>'));

        $.each(groups, function(key, val){
            var th = $('<th>')
                    .addClass('ghead_' + val.id);
            $(th).html(val.name);
            $(tHeadRow).append(th);
        });

        $(tHead).html(tHeadRow);
        
        $.each(permissions, function(pkey,pval){
            var tRow = $('<tr>')
                    .addClass('perm_row p_' + pval.id);
            var tC0 = $('<td>')
                    .html(pval.name)
                    .addClass('phead_' + pval.id);
            $(tRow).append(tC0);
            $.each(groups, function(gkey,gval){
                var tCell = $('<td>')
                        .addClass('perm_cell g_' + gval.id)
                        .click(function(){
                            var data = {
                                group: gval.id,
                                perm: pval.id,
                                action: ($(this).hasClass('checked'))?0:1
                            };
                            $($this).setPermission(data);
                        })
                        .hover(
                        function(){
                            $('.phead_' + pval.id).addClass('mouseHelper');
                            $('.ghead_' + gval.id).addClass('mouseHelper');
                        },
                        function(){
                            $('.phead_' + pval.id).removeClass('mouseHelper');
                            $('.ghead_' + gval.id).removeClass('mouseHelper');
                        }
                        );
                $(tRow).append(tCell);
            });
            $(tBody).append(tRow);
        });

        $(pTable).append(tHead).append(tBody);
        $(container).html(pTable);
        $(this).html(container);
        return this;
    },

    getPermissionTable: function(){
        $this = $(this);
        $.ajax({
            url: '/____/admin/permission/getPermissionsToGroup',
            type: 'POST',
            success: function(response){
                $($this).find('.perm_cell').removeClass('checked');
                $.each(response,function(key,val){
                    $($this).find('.perm_row.p_'+val.permId)
                            .find('.perm_cell.g_'+val.groupId)
                            .addClass('checked');
                });
            }
        });
    },
    
    setPermission: function(data){
        $this = $(this);
        $.ajax({
            url: '/____/admin/permission/setPermissionToGroup',
            type: 'POST',
            data: data,
            success: function(){
                $($this).getPermissionTable();
            }
        });
    }
});

