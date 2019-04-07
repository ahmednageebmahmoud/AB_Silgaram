/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlPagesAllow', ['$scope', '$http','$filter', 'servicePagesAllow', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;

    //</!--Config-->

    //Get Pages
    s.getPages= () => {
        startBlock();
        service.getPages().then((d) => {
            s.Pages= d.data;
            co("R-getPages", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get PagesAllow
    s.getPagesAllow = () => {
        startBlock();
        service.getPagesAllow().then((d) => {
            s.PagesAllow = d.data;
            co("R-getPagesAllow", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };

    
    //Update
    s.update = (pageAllow) => {

        if (pageAllow.State !=State.Create)
            pageAllow.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.PagesAllowRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.PagesAllowRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.PagesAllow.forEach((pageAllow,index) => {
                if(pageAllow.Id==s.RowUpdateBackup.Id)
                {
                    pageAllow.IsAllowLog = s.RowUpdateBackup.IsAllowLog;
                    pageAllow.IsAllowNotify = s.RowUpdateBackup.IsAllowNotify;
                    s.filter();
                }
            });
        }
        s.ShowUpdate = -1;
    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.PagesAllow, 'State', State.Delete, State.Update);
        if (dataForSave.length == 0) {

            toastr.error(Token.NoDataForSave,Token.Error);
            return;
        }

        startBlock();
        service.saveChange(dataForSave).then(d=> {
            co("R-SaveChange", d);
            switch (d.data.RequestType) {
                case RequestType.Success:
                    {
                        toastr.success(d.data.Message, Token.Success);
                        s.getPagesAllow();
                    }
                    break;
                case RequestType.Error:
                    {
                        toastr.error(d.data.Message, Token.Error);
                    }
                    break;
                case 3:
                    break;
            }
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });

    };

    //Restart
    s.rest = () => {
       
    };

    //Call Functions
    s.callFunctions = () => {
        s.getPages();
        s.getPagesAllow();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.PagesAllow, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);