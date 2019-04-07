/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlNotifications', ['$scope', '$http','$filter', 'serviceNotifications', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.NotifyId = getQueryStringValue("NotId");

    //</!--Config-->

    //Check User Allow For This Notify
    s.checkUserAllowForThisNotify = () => {
        if (!IsNullOrEmptyOrUndefined(s.NotifyId))
        startBlock();
        service.checkUserAllowForThisNotify(s.NotifyId).then((d) => {
            switch (d.data.RequestType) {
                case RequestType.Success: {
                    //Get Notify
                    s.getNotify();
                } break;
                case RequestType.Error:{
                    //Show Alert
                    toastr.error(d.data.Message, Token.Error);
                }
            }
            
            co("R-checkUserAllowForThisNotify", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error checkUserAllowForThisNotify", error.data);
            stopBlock();
        });
    };

    //Get Notify
    s.getNotify = () => {
        startBlock();
        service.getNotify(s.NotifyId).then((d) => {
            s.Notify = d.data;
            co("R-getNotify", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Get Notify", error.data);
            stopBlock();
        });
    };


    //Call Functions
    s.callFunctions = () => {
        s.checkUserAllowForThisNotify();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Notifications, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);