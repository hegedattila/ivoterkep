jQuery.fn.extend({
    adminList: function(listParam,url,origParams){
        var showCheckBoxes = ('massbuttons' in listParam);
        var container = $('<div>')
                .addClass('admTableContainer');
        var tcontainer = $('<div>')
                .addClass('TableContainer');
        var pagin = $('<div>')
                .addClass('pagination');
        var admTable = $('<table>')
                .addClass('adminTable')
                .prop('cellspacing', 0);
        var tHead = $('<thead>');
        var tBody = $('<tbody>')
                .addClass('admTableBody');
        var tHeadRow = $('<tr>');
        var th0 = $('<th>');

        if(showCheckBoxes === true){
            var chkbx0 = $('<input>')
                    .attr('type','checkbox')
                    .addClass('allCheck');
            $(th0).append(chkbx0);

            $(chkbx0).click(function(){
                $(tBody).find('.rowCheck').prop('checked', $(this).is(':checked'));
            });
            $(tHeadRow).append(th0);
        }

        $(tHeadRow).append($('<th>'));

        $.each(listParam.head, function(key, val){
            var th = $('<th>');
            $(th).html(val.label);
            if(val.sortable === true){
                var up = $('<div>')
                    .click(function(){
                        $.extend(origParams,{refreshTable:true, page:0,sort:'ASC', sortby:key});
                        loadAdmin(url,origParams);
                    })
                    .addClass('button fa fa-sort-asc');
                var down = $('<div>')
                    .click(function(){
                        $.extend(origParams,{refreshTable:true, page:0,sort:'DESC', sortby:key});
                        loadAdmin(url,origParams);
                    })
                    .addClass('button fa fa-sort-desc');
                $(th).append(up).append(down);
            }
            if(val.searchable === true){
                var searchBox = $('<div>')
                        .addClass('searchBox');
                var searchField = $('<input>')
                        .addClass('listSearchField')
                        .keyup(function(e){
                            if(e.keyCode === 13)
                            {
                                var sObj = (origParams.search || {});
                                sObj[key] = $(this).val();
                                $.extend(origParams,{refreshTable:true, page:0, search: sObj});
                                loadAdmin(url,origParams);
                            }
                        });
                var searchbtn = $('<div>')
                    .click(function(){
                        var sObj = (origParams.search || {});
                        sObj[key] = $(searchField).val();
                        $.extend(origParams,{refreshTable:true, page:0, search: sObj});
                        loadAdmin(url,origParams);
                    })
                    .addClass('button fa fa-search');
                $(searchBox).html(searchField).append(searchbtn);
                $(th).append(searchBox);
            }
            $(tHeadRow).append(th);
        });

        $(tHead).html(tHeadRow);
        
        $(admTable).append(tHead).append(tBody).buildTable(listParam.data,(showCheckBoxes === true));
        $(tcontainer).html(admTable).append(pagin);
        if('pageInform' in listParam){
            $(tcontainer).showPagination(listParam.pageInform,url,origParams);
        }
        if(showCheckBoxes === true){
            $(container).massBtns(listParam.massbuttons);
        }
        $(container).append(tcontainer);
        $(this).html(container);
        return this;
    },
    
    buildTable: function(data,checkBoxes){
        var target = $(this).find('tbody.admTableBody');
        $(target).empty();
        $.each(data, function(row_key, row){
            var tr = $('<tr>').addClass('adminTableRow');
            if(checkBoxes === true){
                var col0 = $('<td>').addClass('adminTableCell checkboxCell');
                var chkbx = $('<input>');
                $(chkbx).attr('type','checkbox')
                        .addClass('rowCheck')
                        .prop('value',row.id);
                $(col0).append(chkbx);

        //        $(tr).click(function(){
        //            $(chkbx).prop('checked',!$(chkbx).is(':checked'));
        //        })
                $(tr).append(col0);
            }

            var col1 = $('<td>').addClass('adminTableCell operationsCell');

            if(row.opCol !== null){
                $.each(row.opCol,function(key, val){
                    var button = $('<div>')
                            .addClass('squareBtn boxSmall button ' + val.icoClass)
                            .click(function(e){
                                if(val.confirm){
                                    confirmWindow(val.confirm,function(){
                                        loadAdmin(val.url,val.params);
                                    });
                                } else {
                                    loadAdmin(val.url,val.params);
                                }
                            });
                    if('tooltip' in val){
                        var tooltip = $('<div>')
                                .addClass('tooltipText')
                                .html(val.tooltip);
                        $(button).append(tooltip)
                                .addClass('tooltip');
                    }
                    $(col1).append(button);
                });
            }
            $(tr).append(col1);

            $.each(row.data, function(cell_key, cell){
                var td = $('<td>').addClass('adminTableCell');
                $(td).html(cell);
                $(tr).append(td);
            });
            $(target).append(tr);
        });
        return this;
    },

    getAllChecked: function(){
        var checkList = [];
        $(this).find('.rowCheck:checked').each(function(){
            checkList.push(this.value);
        });
        return checkList;
    },

    massBtns: function(massbtns){
        var $this = $(this);
        var container = $('<div>').addClass('massButtonsContainer');
        $.each(massbtns,function (key, val){
            if(!val.params){
                val.params = {};
            }
            var button = $('<div>')
                    .addClass('massBtn boxSmall button')
                    .html(val.text)
                    .click(function(){
                        val.params.list = $($this).getAllChecked();
                        if(val.params.list.length > 0){
                            if(val.confirm){
                                confirmWindow(val.confirm,function(){
                                    loadAdmin(val.url,val.params);
                                });
                            } else {
                                loadAdmin(val.url,val.params);
                            }
                        }
                    });
            $(container).append(button);
        });
        $(this).html(container);
        return this;
    },
    
    showPagination: function(p_info,url,origParams){
        var target = $(this).find('.pagination');
        var pagesCont = $('<div>')
                .addClass('pagesCont');
        var selectorCont = $('<div>')
                .addClass('selCont');
        var infoCont = $('<div>')
                .addClass('infoCont');
        
        var page = parseInt(p_info.page);
        var tpages = parseInt(p_info.totalPages);
        
        var left = page - 3;
        if(left < 0){
            left = 0;
        }
        var right = page + 3;
        if(right >= tpages){
            right = tpages -1;
        }
        
        if(left > 0){
            $(pagesCont).append(makePageNr(0,'<<'));
        }
        if(page > 0){
            $(pagesCont).append(makePageNr(page - 1,'<'));
        }
        
        
        for (var i = left; i < page; i++){ //bal
            $(pagesCont).append(makePageNr(i,i + 1));
        }
        
        var active = $('<div>').addClass('pageNr active').html(page + 1);
        $(pagesCont).append(active);
        
        for (var i = page + 1; i <= right; i++){ //jobb
            $(pagesCont).append(makePageNr(i,i + 1));
        }
        
        
        if(page < tpages - 1){
            $(pagesCont).append(makePageNr(page + 1,'>'));
        }
        if(right < tpages - 1){
            $(pagesCont).append(makePageNr(tpages - 1,'>>'));
        }
        
        var pageLOpts = [25,50,100,200,500];
        var pageLengthSelector = $('<select>')
                .addClass();
        $.each(pageLOpts,function(key, val){
            var opt = $('<option>')
                    .html(val)
                    .attr('value', val);
            if(p_info.pageLength === val){ 
                $(opt).attr('selected', true);
            }
            $(pageLengthSelector).append(opt);
        });
        $(pageLengthSelector).change(function(){ 
            $.extend(origParams,{refreshTable:true, pageLength:$(this).val(), page: 0});
            loadAdmin(url,origParams);
        });
        $(selectorCont).append(pageLengthSelector);
        
        $(infoCont).append("Total: " + p_info.totalRows)
                    .append(" Pages: " + tpages);
        
        $(target).html(pagesCont)
                .append(selectorCont)
                .append(infoCont);
        
        function makePageNr(i,txt){
            return $('<div>')
                .addClass('pageNr')
                .html(txt)
                .click(function(){
                    $.extend(origParams,{refreshTable:true, page: i});
                    loadAdmin(url,origParams);
                });
        }
        return this;
    }
});