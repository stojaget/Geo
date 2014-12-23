/*
- = The script is fully compatible with jquery.1.4.2-min.js = -
Author:         Hajan Selmani
Description:    Simple validation script used for validating text box dates on KeithWood's DatePicker.
                This script is written with special purpose for the Microsoft ASP.NET Weblog.
                It uses simple validation with showing effect acompained error messages.                                
Blogs:          http://weblogs.asp.net/hajan
                http://mkdot.net/blogs/hajan
                http://codeasp.net/blogs/hajan                
Websites:       http://www.asp.net, http://mkdot.net, http://codeasp.net
*/



function validate(obj, sDat, eDat) {
    //assigning the textbox values to startdate and enddate variables
    var startdate = document.getElementById(sDat).value;
    var enddate = document.getElementById(eDat).value;
    var btnName = obj.name; //assign obj.name to btnName, this is the ID of the asp.net serverside textbox controls

    var regEx = /^\d{1,2}(\-|\/|\.)\d{1,2}\1\d{4}$/;
    if (!regEx.test(startdate)) {
        //make startdate text box border-color to 'red'
        $('#' + sDat).css('border-color', 'red');
        $('#' + eDat).css('border-color', 'black');
        //check startdate if string empty
        if (enddate != '') {
            errorMessage(btnName, 'messages', 'Start date text box value is not valid date!', 2000, true);  //call errorMessage function
        }
        return false;
    }
    else if (!regEx.test(enddate)) {
        //make end date text box border-color to 'red'
        $('#' + sDat).css('border-color', 'black');
        $('#' + eDat).css('border-color', 'red');
        //check enddate if string empty
        if (enddate != '') {
            errorMessage(btnName, 'messages', 'End date text box value is not valid date!', 2000, true);  //call errorMessage function
        }
        return false;
    }
    else {
        //creating new date objects for start and end date
        var sDate = new Date(startdate);
        var eDate = new Date(enddate);

        //if startDate is greater than endDate
        //print error message and color the textboxes with border-color:red;
        if (sDate > eDate) {
            //make border color red to both text boxes
            $('#' + sDat).css('border-color', 'red');
            $('#' + eDat).css('border-color', 'red');

            //call errorMessage function and print the message
            errorMessage(btnName, 'messages', 'Start date must be smaller than End date', 3000, true);

            //validation is false
            return false;
        }
        else {
            $('#' + sDat).css('border-color', 'black');
            $('#' + eDat).css('border-color', 'black');
            return true;
        }
    }
}

///
///JS Function: errorMessage
///Params:
///-> btnId -           the ID of the button used when validate() function is called
///-> msgInfoId -       the ID of the <span>, <div> or any html object where error message will be displayed
///-> messageText -     the Error message that will be displayed
///-> timeoutPeriod -   time the error message will stay visible
///-> disableBtn -      true/false boolean to specify whether you like the button to get disabled once the error
///                     messgae is displayed or not.
function errorMessage(btnId, msgInfoId, messageText, timeoutPeriod, disableBtn) {
    if (disableBtn == true) {
        $('#' + btnId).attr('disabled', true); //disable button
        $('#' + btnId).attr('value', '...'); //change text to '...'
        $('#' + msgInfoId).html(messageText).fadeIn('slow').delay(timeoutPeriod).fadeOut('slow'); //show error message
        setTimeout(function() {
            $('#' + btnId).removeAttr('disabled', true);
            $('#' + btnId).attr('value', 'TEST');
        }, timeoutPeriod + 1000); //after timeoutPeriod + 1 more second, remove disabled attribute and change value to TEST
    }
    else {
        //just show the error message without disabling the button
        $('#' + msgInfoId).html(messageText).fadeIn('slow').delay(timeoutPeriod).fadeOut('slow');        
    }
}