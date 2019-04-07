/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlProvinces', ['$scope', '$http','$filter', 'serviceProvinces', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.Countries = [];
    s.Provinces = [];
    //</!--Config-->

    //Get Countries
    s.getCountries = () => {
        startBlock();
        service.getCountries().then((d) => {
            if (d.data != "" && d.data!=null)
            s.Countries = d.data;
            co("R-getCountries", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get Provinces
    s.getProvinces = () => {
        startBlock();
        service.getProvinces(s.Province.FkCountry_Id).then((d) => {
            if (d.data != "" && d.data != null)
            s.Provinces = d.data;
                 else
                s.Provinces = [];
            co("R-getProvinces", d);
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
        s.Province.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': s.Province.NameAr }, s.Provinces);
        s.Province.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': s.Province.NameEn }, s.Provinces);
        
        if (s.Province.NameArDuplicate || s.Province.NameEnDuplicate)
            return;

        //Added To List
        s.Province.State = State.Create;
        s.Province.Id = "xNew" + Math.floor(Math.random() * 1000000);
        s.Province.ProvinceName = Service.isEn ? s.Province.NameEn : s.Province.NameAr;
        s.Provinces.push(angular.copy(s.Province));

        s.filter();
        s.Province.NameAr = null;
        s.Province.NameEn = null;
        s.IsSubmit = false;
    };

    //Update
    s.update = (province) => {
        //If Dublicate
        province.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': province.NameAr }, s.Provinces, province.Id);
        province.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': province.NameEn }, s.Provinces, province.Id);

        if (province.NameArDuplicate || province.NameEnDuplicate)
            return;

        if (province.State !=State.Create)
            province.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.ProvincesRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.ProvincesRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.Provinces.forEach((province,index) => {
                if(province.Id==s.RowUpdateBackup.Id)
                {
                    s.Provinces[index] = s.RowUpdateBackup;
                    s.filter();
                }
            });
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
            s.Provinces.forEach((item, index) => {
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
    s.undoDelete = province=> {
        if (province.Id.toString().includes('xNew'))
            province.State = State.Create;
        else
            province.State = null;

    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.Provinces, 'State', State.Create, State.Delete, State.Update);
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
                        s.getProvinces();
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
        s.getCountries();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Provinces, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);