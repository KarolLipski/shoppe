jQuery(document).ready(function($)
{
    $('.cart_quantity_input').on('change', function() {
        var new_quantity = this.value;
        var cart_item_id = $(this).attr("cart_item_id");
        console.log(new_quantity);
        console.log($(this).attr("cart_item_id"));

        $.ajax({
            url: '/cart_items/'+cart_item_id+'.json',
            type: 'PUT',
            data: "id="+cart_item_id+"&quantity="+new_quantity+"",
            success: function(data) {
                $("#cart-item-error-"+cart_item_id).text('');
                console.log(data);
                if(data.errors) {
                    toastr.error('Wystąpił bład','', {"closeButton": true});
                    console.log(data.errors[0]);
                    $("#cart-item-error-"+cart_item_id).text(data.errors[0]);
                }
                else {
                    console.log(data.sum);
                    $("#cart-sum").text(data.sum);
                    toastr.success('Ilość została zmieniona','', {"closeButton": true});
                }
            }
        });

    });

});
