/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlSubMenus', ['$scope', '$http','$filter', 'serviceSubMenus', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.SubMenus = null;
    //</!--Config-->

    //Get SubMenus
    s.getSubMenus = () => {
        startBlock();
        service.getSubMenus().then((d) => {
            if(d.data!=""&&d.data!=null)
            s.SubMenus = d.data;
            co("R-getSubMenus", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Get SubMenus", error.data);
            stopBlock();
        });
    };

    //Get Menus
    s.getMenus = () => {
        startBlock();
        service.getMenus().then((d) => {
            if (d.data != "" && d.data != null)
                s.Menus = d.data;
            co("R-getMenus", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Get Menus", error.data);
            stopBlock();
        });
    };

    
    //Update
    s.update = (SubMenu) => {
       
        if (SubMenu.State !=State.Create)
            SubMenu.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.SubMenusRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.SubMenusRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.SubMenus.forEach((SubMenu,index) => {
                if(SubMenu.Id==s.RowUpdateBackup.Id)
                {
                    s.SubMenus[index] = s.RowUpdateBackup;
                    s.filter();
                }
            });

        }
        s.ShowUpdate = -1;
        s.IsUpdate = false;
    };
 
    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.SubMenus, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
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
                        s.getSubMenus();
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
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
            stopBlock();
        });

    };


    //Restart
    s.rest = () => {
       
    };

    //Call Functions
    s.callFunctions = () => {
        s.getSubMenus();
        s.getMenus();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.SubMenus, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);