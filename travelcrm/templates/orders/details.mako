<%namespace file="../common/resource.mako" import="resource_list_details"/>
<div class="dp100 item-details">
    % if item.descr:
        <div class="dp100">
            ${h.tags.literal(item.descr)}
        </div>
    % endif
    <div class="dp100">
        <div class="dp15 b">
            ${_(u'advertise')}
        </div>
        <div class="dp85">
            ${item.advsource.name}
        </div>
    </div>
    <div class="dp100">
        <div class="dp15 b">
            ${_(u'services')}
        </div>
        <div class="dp85">
            <div class="dp100">
                <div class="b dp40">${_(u'service')}</div>
                <div class="b dp15">${_(u'price')}</div>
                <div class="b dp15">${_(u'calculation')}</div>
                <div class="b dp15">${_(u'currency')}</div>
                <div class="b dp15">${_(u'status')}</div>
            </div>
            % for order_item in item.orders_items:
            <div class="dp100">
                <div class="dp40">
                    ${order_item.service.display_text}, ${order_item.supplier.name}
                </div>
                <div class="dp15">
                    ${order_item.final_price}
                </div>
                <div class="dp15">
                    % if order_item.calculation:
                        ${order_item.calculation.price}
                    % else:
                        &nbsp;
                    % endif
                </div>
                <div class="dp15">
                    ${order_item.currency.iso_code}
                </div>
                <div class="dp15">
                    <span class="mr1 status-label ${order_item.status.key}">
                        ${order_item.status.title}
                    </span>
                </div>
            </div>
            % endfor
        </div>
    </div>
    <div class="dp100">
        ${resource_list_details(item.resource)}
    </div>
</div>