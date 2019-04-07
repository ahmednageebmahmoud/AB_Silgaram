
function getQueryStringValue(key) {
    return decodeURIComponent(window.location.search.replace(new RegExp("^(?:.*[&\\?]" + encodeURIComponent(key).replace(/[\.\+\*]/g, "\\$&") + "(?:\\=([^&]*))?)?.*$", "i"), "$1"));
};

//Console.log()
function co(title, data) {
    console.log(title);
    console.log(data);
};
function showDeleteConfirm() {
    $("#DeleteConfirm").modal({
        show: true,
        backdrop: 'static',
        keyboard: false
    });
};
function hideDeleteConfirm() {
    $("#DeleteConfirm").modal('hide');
};

function showModel (key) {
    $("#"+key).modal({
        show: true,
        backdrop: 'static',
        keyboard: false
    });
};
function hideModel(key) {
    $("#"+key).modal('hide');
};

function showDropDown(key) {
    $("#" + key).addClass("open");
}
function hideDropDown(key) {
    $("#" + key).removeClass("open");
}



//ننشى الصوت هنا كى يحمى مع الصفحة
var audioAlert;
(function () {
    audioAlert = new Audio('/Files/Sound/AlertSound2.mp3');
   
}
)()

//Date
/*Chack Date Valid*/

function checkvaliddate(dd, mm, yyyy) {
    //Check Day & Month
    if ((dd > 31 && (mm == 1 || mm == 3 || mm == 5 || mm == 7 || mm == 8 || mm == 10 || mm == 12)) ||
        (dd > 30 && (mm == 4 || mm == 6 || mm == 9 || mm == 11)) ||
        (dd < 0 || mm < 0 || mm == 0 || mm > 12)
        )
        return false;

    //Check Yare  (Leap year) or (Commercial year)
    if (yyyy % 4 == 0) {
        // (Leap year)
        if (dd > 29 && mm == 2)
            return false;
    } else {
        //(Commercial year)
        if (dd > 28 && mm == 2)
            return false;
    }

    return true;
}



//Ui Loading start
function startBlock() {
    var el = $("body"); // $("#getData").closest(".portlet").children(".portlet-body");
    blockUI({
        target: el,
        animate: true,
        overlayColor: 'none'
    });
};
//Ui Loading Stop
function stopBlock() {
    var el = $("body"); // $("#getData").closest(".portlet").children(".portlet-body");
    unblockUI(el);
}

// wrApper function to  block element(indicate loading)
function blockUI(options) {
    
    options = $.extend(true, {}, options);
    var html = '';
    if (options.animate) {
        html = '<div class="loading-message ' + (options.boxed ? 'loading-message-boxed' : '') + '">' + '<div class="block-spinner-bar"><div class="bounce1"></div><div class="bounce2"></div><div class="bounce3"></div></div>' + '</div>';
    } else if (options.iconOnly) {
        html = '<div class="loading-message ' + (options.boxed ? 'loading-message-boxed' : '') + '"><img src="' + this.getGlobalImgPath() + 'loading-spinner-grey.gif" align=""></div>';
    } else if (options.textOnly) {
        html = '<div class="loading-message ' + (options.boxed ? 'loading-message-boxed' : '') + '"><span>&nbsp;&nbsp;' + (options.message ? options.message : 'LOADING...') + '</span></div>';
    } else {
        html = '<div class="loading-message ' + (options.boxed ? 'loading-message-boxed' : '') + '"><img src="' + this.getGlobalImgPath() + 'loading-spinner-grey.gif" align=""><span>&nbsp;&nbsp;' + (options.message ? options.message : 'LOADING...') + '</span></div>';
    }

    if (options.target) { // element blocking
        var el = $(options.target);
        if (el.height() <= ($(window).height())) {
            options.cenrerY = true;
        }
        
        el.block({
            message: html,
            baseZ: options.zIndex ? options.zIndex : 1000,
            centerY: options.cenrerY !== undefined ? options.cenrerY : false,
            css: {
                top: '10%',
                border: '0',
                padding: '0',
                backgroundColor: 'none'
            },
            overlayCSS: {
                backgroundColor: options.overlayColor ? options.overlayColor : '#555',
                opacity: options.boxed ? 0.05 : 0.1,
                cursor: 'wait'
            }
        });
    } else { // page blocking
        $.blockUI({
            message: html,
            baseZ: options.zIndex ? options.zIndex : 1000,
            css: {
                border: '0',
                padding: '0',
                backgroundColor: 'none'
            },
            overlayCSS: {
                backgroundColor: options.overlayColor ? options.overlayColor : '#555',
                opacity: options.boxed ? 0.05 : 0.1,
                cursor: 'wait'
            }
        });
    }
};

// wrApper function to  un-block element(finish loading)
function unblockUI(target) {
    if (target) {
        $(target).unblock({
            onUnblock: function() {
                $(target).css('position', '');
                $(target).css('zoom', '');
            }
        });
    } else {
        $.unblockUI();
    }
};






//Check Value Null || Empty || Undefined
function IsNullOrEmptyOrUndefined(value) {
    if (value == "" || value == null || value == undefined)
        return true;
    else
        return false;
}

//Set Null To Value By Name Using jQuery 
function SetValueNullByNameJQ(elmName) {
    $(`[name=${elmName}]`).val(null);
}

function convartDateTimeToJavaScriptDateTime(dateTime) {
    return new Date(parseInt(dateTime.substr(6)));
}

function convertDateTimeToCSharpDateTime(dateTime) {
    var date = new Date(dateTime);
    var day = dateTime.getDate();       // yields date
    var month = dateTime.getMonth() + 1;    // yields month (add one as '.getMonth()' is zero indexed)
    var year = dateTime.getFullYear();  // yields year
    var hour = dateTime.getHours();     // yields hours 
    var minute = dateTime.getMinutes(); // yields minutes
    var second = dateTime.getSeconds(); // yields seconds

    // After this construct a string with the above results as below
    var time = month + "/" + day + "/" + year + " " + hour + ':' + minute + ':' + second;

    return time;
}
