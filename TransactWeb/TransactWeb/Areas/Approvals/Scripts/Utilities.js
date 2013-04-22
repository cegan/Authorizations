

function ToggleSelectAll(tableId) {

    if ($('#' + tableId).is(':checked')) {

        $(":checkbox").each(function () {

            this.checked = true;

        });
    }
    else {

        $(":checkbox").each(function () {

            this.checked = false;

        });
    }
}