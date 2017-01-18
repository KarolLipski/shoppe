jQuery(document).ready(function($)
{
    $('.actualize_item_category').on('change', function() {
        var category_id = this.value;
        console.log(category_id);
        var item_id = $(this).attr("item_id");
        console.log(item_id);
        params = { 'item': {'category_id': category_id}};
        $.ajax({
            url: '/admin/items/'+item_id+'.json',
            type: 'PUT',
            data: params,
            success: function(data) {
                $("#item-error-"+item_id).text('');
                if(data.errors) {
                    toastr.error('Wystąpił bład','', {"closeButton": true});
                    //$("#item-error-"+item_id).text(data.errors[0]);
                    $("#item-error-"+item_id).text('Błędna Kategoria');

                }
                else {
                    toastr.success('Kategoria zmieniona','', {"closeButton": true});
                    $("#row-actualize-itemid-"+item_id).remove();
                    //$('.actualize_item_category').next().focus();
                }
            }
        });

    });

});