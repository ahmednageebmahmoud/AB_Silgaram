/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlNationalities', ['$scope', '$http','$filter', 'serviceNationalities', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.Nationalities = [];
    //</!--Config-->

    //Get Nationalities
    s.getNationalities = () => {
        startBlock();
        service.getNationalities().then((d) => {
            if (d.data != "" && d.data != null)
                s.Nationalities = d.data;
            else
                s.Nationalities = [];
            co("R-getNationalities", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
            stopBlock();
        });
    };


    //Create
    s.create = () => {
        
        //If Dublicate
        s.Nationality.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': s.Nationality.NameAr }, s.Nationalities);
        s.Nationality.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': s.Nationality.NameEn }, s.Nationalities);
        
        if (s.Nationality.NameArDuplicate || s.Nationality.NameEnDuplicate)
            return;

        //Added To List
        s.Nationality.State = State.Create;
        s.Nationality.Id = "xNew" + Math.floor(Math.random() * 1000000);
        s.Nationality.NationalityName = Service.isEn ? s.Nationality.NameEn : s.Nationality.NameAr;
        s.Nationalities.push(angular.copy(s.Nationality));

        s.filter();
        s.Nationality.NameAr = null;
        s.Nationality.NameEn = null;
    };

    //Update
    s.update = (nationality) => {
        //If Dublicate
        nationality.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': nationality.NameAr }, s.Nationalities, nationality.Id);
        nationality.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': nationality.NameEn }, s.Nationalities, nationality.Id);

        if (nationality.NameArDuplicate || nationality.NameEnDuplicate)
            return;

        if (nationality.State !=State.Create)
            nationality.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.NationalitiesRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.NationalitiesRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.Nationalities.forEach((nationality,index) => {
                if(nationality.Id==s.RowUpdateBackup.Id)
                {
                    s.Nationalities[index] = s.RowUpdateBackup;
                }
            });
            s.filter();
        }
        s.ShowUpdate = -1;
        s.IsUpdate = false;
    };

    //Delete Confirm
    s.deleteConfirm = (id) => {
        s.deleteId = id;
        showDeleteConfirm();
    };

    //Delete
    s.delete = () => {
        if (s.deleteId != null) {
            s.Nationalities.forEach((item, index) => {
                if (item.Id === s.deleteId) {
                    if (item.State == State.Create)
                        item.State = State.Delete
                    else
                        item.State = State.Delete
                    hideDeleteConfirm();
                    s.filter();
                }
            });
        }
    };

    //Cancel Delete
    s.cancelDelete = () => {
        hideDeleteConfirm();
        s.deleteId = null;
    };

    //Undo Delete
    s.undoDelete = nationality=> {
        if (nationality.Id.toString().includes('xNew'))
            nationality.State = State.Create;
        else
            nationality.State = null;

    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.Nationalities, 'State', State.Create, State.Delete, State.Update);
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
                        s.getNationalities();
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
        s.getNationalities();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Nationalities, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);