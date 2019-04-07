/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlReportTypes', ['$scope', '$http','$filter', 'serviceReportTypes', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.ReportTypes = null;
    //</!--Config-->

    //Get ReportTypes
    s.getReportTypes = () => {
        startBlock();
        service.getReportTypes().then((d) => {
            if (d.data != "" && d.data != null)
                s.ReportTypes = d.data;
                else
                s.ReportTypes = [];
            co("R-getReportTypes", d);
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
        s.ReportType.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': s.ReportType.NameAr }, s.ReportTypes);
        s.ReportType.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': s.ReportType.NameEn }, s.ReportTypes);
        
        if (s.ReportType.NameArDuplicate || s.ReportType.NameEnDuplicate)
            return;

        //Added To List
        s.ReportType.State = State.Create;
        s.ReportType.Id = "xNew" + Math.floor(Math.random() * 1000000);
        s.ReportType.ReportTypeName = Service.isEn ? s.ReportType.NameEn : s.ReportType.NameAr;
        s.ReportTypes.push(angular.copy(s.ReportType));

        s.filter();


        s.ReportType.NameAr = null;
        s.ReportType.NameEn = null;
    };

    //Update
    s.update = (reportType) => {
        //If Dublicate
        reportType.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': reportType.NameAr }, s.ReportTypes, reportType.Id);
        reportType.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': reportType.NameEn }, s.ReportTypes, reportType.Id);

        if (reportType.NameArDuplicate || reportType.NameEnDuplicate)
            return;

        if (reportType.State !=State.Create)
            reportType.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.ReportTypesRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.ReportTypesRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.ReportTypes.forEach((reportType,index) => {
                if(reportType.Id==s.RowUpdateBackup.Id)
                {
                    s.ReportTypes[index] = s.RowUpdateBackup;
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
            s.ReportTypes.forEach((item, index) => {
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
    s.undoDelete = reportType=> {
        if (reportType.Id.toString().includes('xNew'))
            reportType.State = State.Create;
        else
            reportType.State = null;

    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.ReportTypes, 'State', State.Create, State.Delete, State.Update);
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
                        s.getReportTypes();
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
        s.getReportTypes();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.ReportTypes, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);