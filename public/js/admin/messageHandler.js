function message(msg,color){
    var colorCode;
    switch (color){
        case 'red':
            colorCode = '#e01515';
            break;
        case 'green':
            colorCode = '#0ea70b';
            break;
        case 'black':
            colorCode = '#222';
            break;
        case 'blue':
            colorCode = '#0b42a7';
            break;
        case 'yellow':
            colorCode = '#e0ab15';
            break;
        default:
            colorCode = '#eee';
    }
    var msgBox = $('<div>')
            .addClass('message')
            .hide()
            .click(function(){
                $(this).slideUp(100, function(){ $(this).remove(); } );
            })
            .html(msg)
            .css('border-color',colorCode);
    $('#messageBox').append(msgBox);
    $(msgBox).slideDown(100);
    setTimeout(function(){
        $(msgBox).slideUp(100, function(){ $(this).remove(); } );
    },8000);
}