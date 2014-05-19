<%namespace file="../common/search.mak" import="searchbar"/>
<%
    _id = h.common.gen_id()
    _tb_id = "tb-%s" % _id
    _s_id = "s-%s" % _id    
%>
<div class="easyui-panel unselectable"
    data-options="
    	fit:true,
    	border:false,
    	iconCls:'fa fa-table'
    "
    title="${_(u'Tours')}">
    <script type="text/javascript">
        function formatter_${_id}(index, row){
            var html = '<table width="100%" class="grid-details">';
            html += '<tr>'
                + '<td width="25%" class="b">${_(u'date')}</td>'
                + '<td>' + row.deal_date + '</td>'
                + '</tr>';
            html += '<tr>'
                + '<td width="25%" class="b">${_(u'customer')}</td>'
                + '<td>' + row.customer + '</td>'
                + '</tr>';
            if(row.customer_phone){
                html += '<tr>'
                    + '<td width="25%" class="b">${_(u'customer phone')}</td>'
                    + '<td>' + row.customer_phone + '</td>'
                    + '</tr>';
            }
            if(row.customer_email){
                html += '<tr>'
                    + '<td width="25%" class="b">${_(u'customer email')}</td>'
                    + '<td>' + row.customer_email + '</td>'
                    + '</tr>';
            }
            if(row.customer_skype){
                html += '<tr>'
                    + '<td width="25%" class="b">${_(u'customer skype')}</td>'
                    + '<td>' + row.skype + '</td>'
                    + '</tr>';
            }
            if(row.customer_citizen_passport){
                html += '<tr>'
                    + '<td width="25%" class="b">${_(u'citizen passport')}</td>'
                    + '<td>' + row.customer_citizen_passport + '</td>'
                    + '</tr>';
            }
            if(row.customer_foreign_passport){
                html += '<tr>'
                    + '<td width="25%" class="b">${_(u'foreign passport')}</td>'
                    + '<td>' + row.customer_foreign_passport + '</td>'
                    + '</tr>';
            }
            html += '<tr>'
                + '<td width="25%" class="b">${_(u'base price')}</td>'
                + '<td>' + row.base_price + ' ' + row.base_currency
                + ' ( ${_(u'exchange rate')}: ' + row.rate + ' ' + row.base_currency 
                + (row.date?(' ' + row.date):'') + ' )' + '</td>'
                + '</tr>';
            html += '</table>';
            return html;
        }
    </script>
    <table class="easyui-datagrid"
    	id="${_id}"
        data-options="
            url:'${request.resource_url(_context, 'list')}',border:false,
            pagination:true,fit:true,pageSize:50,singleSelect:true,
            rownumbers:true,sortName:'id',sortOrder:'desc',
            pageList:[50,100,500],idField:'_id',checkOnSelect:false,
            selectOnCheck:false,toolbar:'#${_tb_id}',
            view: detailview,
            detailFormatter: function(index, row){
                return formatter_${_id}(index, row);
            },          
            onBeforeLoad: function(param){
                $.each($('#${_s_id}, #${_tb_id} .searchbar').find('input'), function(i, el){
                    param[$(el).attr('name')] = $(el).val();
                });
            }
        " width="100%">
        <thead>
            % if _context.has_permision('delete'):
            <th data-options="field:'_id',checkbox:true">${_(u"id")}</th>
            % endif
            <th data-options="field:'id',sortable:true,width:60">${_(u"id")}</th>
            <th data-options="field:'touroperator_name',sortable:true,width:140">${_(u"touroperator")}</th>
            <th data-options="field:'country',sortable:true,width:100">${_(u"country")}</th>
            <th data-options="field:'hotel_cat',sortable:true,width:60">${_(u"hotel cat")}</th>
            <th data-options="field:'price',sortable:true,width:100,formatter:function(value, row, index){return row.currency + ' ' + value;}">${_(u"price")}</th>
            <th data-options="field:'start_date',sortable:true,width:80">${_(u"start")}</th>
            <th data-options="field:'end_date',sortable:true,width:80">${_(u"end")}</th>
            <th data-options="field:'modifydt',sortable:true,width:120,styler:function(){return datagrid_resource_cell_styler();}"><strong>${_(u"updated")}</strong></th>
            <th data-options="field:'modifier',width:100,styler:function(){return datagrid_resource_cell_styler();}"><strong>${_(u"modifier")}</strong></th>
        </thead>
    </table>

    <div class="datagrid-toolbar" id="${_tb_id}">
        <div class="actions button-container dl45">
            % if _context.has_permision('add'):
            <a href="#" class="button primary _action" 
                data-options="container:'#${_id}',action:'dialog_open',url:'${request.resource_url(_context, 'add')}'">
                <span class="fa fa-plus"></span>${_(u'Add New')}
            </a>
            % endif
            <div class="button-group">
                % if _context.has_permision('edit'):
                <a href="#" class="button _action"
                    data-options="container:'#${_id}',action:'dialog_open',property:'with_row',url:'${request.resource_url(_context, 'edit')}'">
                    <span class="fa fa-pencil"></span>${_(u'Edit')}
                </a>
                <a href="#" class="button _action"
                    data-options="container:'#${_id}',action:'dialog_open',property:'with_row',url:'${request.resource_url(_context, 'copy')}'">
                    <span class="fa fa-copy"></span>${_(u'Copy')}
                </a>
                % endif
                % if _context.has_permision('delete'):
                <a href="#" class="button danger _action" 
                    data-options="container:'#${_id}',action:'dialog_open',property:'with_rows',url:'${request.resource_url(_context, 'delete')}'">
                    <span class="fa fa-times"></span>${_(u'Delete')}
                </a>
                % endif
            </div>
            <div class="button-group">
                % if _context.has_permision('invoice'):
                <a href="#" class="button _action"
                    data-options="container:'#${_id}',action:'dialog_open',property:'with_row',url:'${request.resource_url(_context, 'edit')}'">
                    <span class="fa fa-file-o"></span>${_(u'Invoice')}
                </a>
                % endif
                % if _context.has_permision('contract'):
                <a href="#" class="button _action" 
                    data-options="container:'#${_id}',action:'dialog_open',property:'with_rows',url:'${request.resource_url(_context, 'delete')}'">
                    <span class="fa fa-file-text-o"></span>${_(u'Contract')}
                </a>
                % endif
            </div>
        </div>
        <div class="ml45 tr">
            <div class="search">
                ${searchbar(_id, _s_id)}
                <div class="advanced-search tl hidden" id = "${_s_id}">
                    <div>
                        ${h.tags.title(_(u"customer or member"))}
                    </div>
                    <div>
                        ${h.fields.persons_combobox_field(request, None, 'person_id', show_toolbar=False)}
                    </div>
		            <div class="mt05">
		                ${h.tags.title(_(u"hotel"))}
		            </div>
		            <div>
		                ${h.fields.hotels_combobox_field(request, None, 'hotel_id', show_toolbar=False)}
		            </div>
		            <div class="mt05">
		                ${h.tags.title(_(u"hotel category"))}
		            </div>
		            <div>
		                ${h.fields.hotelcats_combobox_field(request, None, 'hotelcat_id', show_toolbar=False)}
		            </div>
		            <div class="mt05">
		                ${h.tags.title(_(u"country"))}
		            </div>
		            <div>
		                ${h.fields.countries_combobox_field(request, None, 'country_id', show_toolbar=False)}
		            </div>
		            <div class="mt05">
		                ${h.tags.title(_(u"price range"))}
		            </div>
		            <div>
		                ${h.tags.text('price_from', None, class_="text w10 easyui-numberbox", data_options="min:0,precision:0")}
		                <span class="p1">-</span>
		                ${h.tags.text('price_to', None, class_="text w10 easyui-numberbox", data_options="min:0,precision:0")}
		            </div>
		            <div class="mt05">
		                ${h.tags.title(_(u"tour dates"))}
		            </div>
		            <div>
		                ${h.fields.date_field(None, "tour_from")}
		                <span class="p1">-</span>
		                ${h.fields.date_field(None, "tour_to")}
		            </div>
		            <div class="mt05">
		                ${h.tags.title(_(u"updated"))}
		            </div>
		            <div>
		                ${h.fields.date_field(None, "updated_from")}
		                <span class="p1">-</span>
		                ${h.fields.date_field(None, "updated_to")}
		            </div>
		            <div class="mt05">
		                ${h.tags.title(_(u"modifier"))}
		            </div>
		            <div>
		                ${h.fields.employees_combobox_field(request, None, 'modifier_id', show_toolbar=False)}
		            </div>
                    <div class="mt1">
                        <div class="button-group minor-group">
                            <a href="#" class="button _advanced_search_submit">${_(u"Find")}</a>
                            <a href="#" class="button" onclick="$(this).closest('.advanced-search').hide();">${_(u"Close")}</a>
                            <a href="#" class="button danger _advanced_search_clear">${_(u"Clear")}</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>