/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlPointPackages', ['$scope', '$http','$filter', 'servicePointPackages', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.PointPackages = [];
    //</!--Config-->

    //Get PointPackages
    s.getPointPackages = () => {
        startBlock();
        service.getPointPackages().then((d) => {
            if (d.data != "" && d.data != null)
                s.PointPackages = d.data;
            co("R-getPointPackages", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error);
            co("Error Login", error.data);
            stopBlock();
        });
    };


    //Create
    s.create = () => {
        

            //If Dublicate
            s.PointPackage.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': s.PointPackage.NameAr }, s.PointPackages);
            s.PointPackage.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': s.PointPackage.NameEn }, s.PointPackages);

            if (s.PointPackage.NameArDuplicate || s.PointPackage.NameEnDuplicate)
                return;

        //Added To List
        s.PointPackage.State = State.Create;
        s.PointPackage.Id = "xNew" + Math.floor(Math.random() * 1000000);
        s.PointPackage.PointPackageName = Service.isEn ? s.PointPackage.NameEn : s.PointPackage.NameAr;
        s.PointPackages.push(angular.copy(s.PointPackage));
        s.filter();
        s.PointPackage.NameAr = null;
        s.PointPackage.NameEn = null;
        s.PointPackage.Points = null;
        s.PointPackage.Price = null;
    };

    //Update
    s.update = (job) => {
        //If Dublicate
        job.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': job.NameAr }, s.PointPackages, job.Id);
        job.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': job.NameEn }, s.PointPackages, job.Id);

        if (job.NameArDuplicate || job.NameEnDuplicate)
            return;

        if (job.State !=State.Create)
            job.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.PointPackagesRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.PointPackagesRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.PointPackages.forEach((job,index) => {
                if(job.Id==s.RowUpdateBackup.Id)
                {
                    s.PointPackages[index] = s.RowUpdateBackup;
                }
            });
            s.filter()
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
            s.PointPackages.forEach((item, index) => {
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
    s.undoDelete = job=> {
        if (job.Id.toString().includes('xNew'))
            job.State = State.Create;
        else
            job.State = null;

    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.PointPackages, 'State', State.Create, State.Delete, State.Update);
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
                        s.getPointPackages();
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
        s.getPointPackages();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.PointPackages, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);