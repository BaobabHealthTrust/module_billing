/*
 * Custom javascript code goes in here.
 *
 **/

function checkTimeForStoppingBreastFeeding(){
    if(__$("touchscreenInput" + tstCurrentPage).value == "Breastfeeding stopped over 6 weeks ago"){
        showCategory("Confirm HIV status!")
    } else if(__$("touchscreenInput" + tstCurrentPage).value == "Breastfeeding stopped in last 6 weeks"){
        showCategory("Book HIV test!")
    }
    setTimeout("checkTimeForStoppingBreastFeeding()", 100)
}

function checkConfirmationStatus(status){
    if(__$("touchscreenInput" + tstCurrentPage).value == status){
        showCategory("START ART!")
    } else {
        hideCategory();
    }
    setTimeout("checkConfirmationStatus()", 100)
}

function checkBCGDate(session_date){
    var today = new Date(session_date);
    var year = (__$("1.1.2.1").value.trim() != "Unknown" ? __$("1.1.2.1").value.trim() : today.getFullYear());
    var month = padZeros((__$("1.1.2.2").value.trim() != "Unknown" ? __$("1.1.2.2").value.trim() : today.getMonth()) + 1, 2);
    var day = padZeros((__$("1.1.2.3").value.trim() != "Unknown" ? __$("1.1.2.3").value.trim() : today.getDate()), 2);
    
    var bcgDate = new Date(year + "-" + month + "-" + day);

    var diff = today - bcgDate;

    return Math.round(diff / (7 * 24 * 60 * 60 * 1000))
}

function findDates(){
    getDayOfMonthPicker(__$("1.1.2.1").value, __$("1.1.2.2").value);
}

function populateMonth(id){

    __$(id).innerHTML = "";

    var months = [
        [1,"January"],
        [2,"February"],
        [3,"March"],
        [4,"April"],
        [5,"May"],
        [6,"June"],
        [7,"July"],
        [8,"August"],
        [9,"September"],
        [10,"October"],
        [11,"November"],
        [12,"December"],
        ["Unknown","Unknown"]
    ]

    for(var i = 0; i < months.length; i++){
        var opt = document.createElement("option");
        opt.value = months[i][0];
        opt.innerHTML = months[i][1];

        __$(id).appendChild(opt);
    }

}
