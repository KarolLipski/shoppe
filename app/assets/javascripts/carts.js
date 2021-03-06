jQuery(document).ready(function($)
{
    $('.cart_quantity_input').on('change', function() {
        var new_quantity = this.value;
        var cart_item_id = $(this).attr("cart_item_id");

        $.ajax({
            url: '/cart_items/'+cart_item_id+'.json',
            type: 'PUT',
            data: "id="+cart_item_id+"&quantity="+new_quantity+"",
            success: function(data) {
                $("#cart-item-error-"+cart_item_id).text('');
                if(data.errors) {
                    toastr.error('Wystąpił bład','', {"closeButton": true});
                    $("#cart-item-error-"+cart_item_id).text(data.errors[0]);
                }
                else {

                    $("#login-info-cart-sum").text(data.sum);
                    $("#total_price_"+cart_item_id).text(data.total_value+" zł.")
                    $("#shopping-cart-totals-table span.price").text(data.sum+' zł');
                    toastr.success('Ilość została zmieniona. <br />Wartośc koszyka: '
                        +data.sum+' zł.','', {"closeButton": true});
                }
            }
        });

    });

});
