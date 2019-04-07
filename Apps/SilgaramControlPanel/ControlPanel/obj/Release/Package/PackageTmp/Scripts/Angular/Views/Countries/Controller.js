/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlCountries', ['$scope', '$http','$filter', 'serviceCountries', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.Countries = null;
    //</!--Config-->

    //Get Countries
    s.getCountries = () => {
        startBlock();
        service.getCountries().then((d) => {
            if(d.data!=""&&d.data!=null)
            s.Countries = d.data;
                else
                s.Countries = [];
            co("R-getCountries", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get Flags
    s.getFlags = () => {
        startBlock();
        service.getFlags().then((d) => {
            if (d.data != "" && d.data != null)
                s.Flags = d.data;
            else
                s.Flags = [];
            co("R-getFlags", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error getFlags", error.data);
            stopBlock();
        });
    };




    //Create
    s.create = () => {
        
        //If Dublicate
        s.Country.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': s.Country.NameAr }, s.Countries);
        s.Country.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': s.Country.NameEn }, s.Countries);
        s.Country.CountryKeyDuplicate = serviceView.isDuplicated({ 'CountryKey': s.Country.CountryKey }, s.Countries);

        s.Country.FlagUrlDuplicate = serviceView.isDuplicated({ 'FlagUrl': s.Country.FlagUrl }, s.Countries);
        
        if (s.Country.NameArDuplicate || s.Country.NameEnDuplicate, s.Country.FlagUrlDuplicate || s.Country.CountryKeyDuplicate)
            return;

        //Added To List
        s.Country.State = State.Create;
        s.Country.Id = "xNew" + Math.floor(Math.random() * 1000000);
        s.Country.CountryName = Service.isEn ? s.Country.NameEn : s.Country.NameAr;
        s.Countries.push(angular.copy(s.Country));

        s.filter();
        s.Country.NameAr = null;
        s.Country.NameEn = null;
    };

    //Update
    s.update = (country) => {
        //If Dublicate
        country.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': country.NameAr }, s.Countries, country.Id);
        country.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': country.NameEn }, s.Countries, country.Id);
        country.CountryKeyDuplicate = serviceView.isDuplicated({ 'CountryKey': country.CountryKey }, s.Countries, country.Id);
        country.FlagUrlDuplicate = serviceView.isDuplicated({ 'FlagUrl': country.FlagUrl }, s.Countries, country.Id);


        if (country.NameArDuplicate || country.NameEnDuplicate || country.CountryKeyDuplicate || country.FlagUrlDuplicate)
            return;

        if (country.State !=State.Create)
            country.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.CountriesRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.CountriesRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.Countries.forEach((country,index) => {
                if(country.Id==s.RowUpdateBackup.Id)
                {
                    s.Countries[index] = s.RowUpdateBackup;
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
            s.Countries.forEach((item, index) => {
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
    s.undoDelete = country=> {
        if (country.Id.toString().includes('xNew'))
            country.State = State.Create;
        else
            country.State = null;

    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.Countries, 'State', State.Create, State.Delete, State.Update);
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
                        s.getCountries();
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
        s.getFlags();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Countries, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);