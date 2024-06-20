// implementation of disabled form fields
var nowTemp = new Date();
var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);
var checkin = $('#check_in_date').fdatepicker({
    format: 'dd-mm-yyyy',
    onRender: function (date) {
        return date.valueOf() < now.valueOf() ? 'disabled' : '';
    }
}).on('changeDate', function (ev) {
    if (ev.date.valueOf() > checkout.date.valueOf()) {
        var newDate = new Date(ev.date)
        newDate.setDate(newDate.getDate() + 1);
        checkout.update(newDate);
    }
    checkin.hide();
    $('#check_out_date')[0].focus();
}).data('datepicker');
var checkout = $('#check_out_date').fdatepicker({
    format: 'dd-mm-yyyy',
    onRender: function (date) {
        return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
    }
}).on('changeDate', function (ev) {
    checkout.hide();
    var totalDays = Math.floor((checkout.date - checkin.date)/86400000);
    var price = document.getElementById('price').innerHTML;
    var total_price = (totalDays+1)*(price);
    $('#staying_day').html(totalDays+1);
    $('#total_price').html(total_price);
}).data('datepicker');



var joining_date = $('.joining_date').fdatepicker({
    format: 'dd-mm-yyyy',
    onRender: function (date) {
        return date.valueOf() < now.valueOf() ? 'disabled' : '';
    }
}).data('datepicker');