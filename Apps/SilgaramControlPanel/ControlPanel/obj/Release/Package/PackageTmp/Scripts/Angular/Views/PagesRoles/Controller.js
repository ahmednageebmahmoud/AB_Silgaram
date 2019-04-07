/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlPagesRoles', ['$scope', '$http','$filter', 'servicePagesRoles', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.boolTrue = Token.boolTrue;
    s.boolFalse = Token.boolFalse;
    s.PagesRoleType  = PagesRoleTypes;

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

    //Get PagesRoles
    s.getPagesRoles = () => {
        startBlock();
        service.getPagesRoles(s.PageId).then((d) => {
            s.PagesRoles = d.data;
            co("R-getPagesRoles", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get Roles
    s.getRoles = () => {
        startBlock();
        service.getRoles().then((d) => {
            s.Roles = d.data;
            co("R-getRoles", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get Pages Role Types
    s.getPagesRoleTypes = () => {
        startBlock();
        service.getPagesRoleTypes().then((d) => {
            s.PagesRoleTypes = d.data;
            co("R-getPagesRoleTypes", d);
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
            s.PagesRolesRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.PagesRolesRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.PagesRoles.forEach((pageAllow,index) => {
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
        var dataForSave = filter('filterIsEquals')(s.PagesRoles, 'State', State.Delete, State.Update);
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
                        s.getPagesRoles();
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
        s.getRoles();
        s.getPagesRoleTypes();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.PagesRoles, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);