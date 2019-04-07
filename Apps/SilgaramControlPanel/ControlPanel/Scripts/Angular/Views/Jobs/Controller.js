/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlJobs', ['$scope', '$http','$filter', 'serviceJobs', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.Jobs = null;
    //</!--Config-->

    //Get Jobs
    s.getJobs = () => {
        startBlock();
        service.getJobs().then((d) => {
            if (d.data != "" && d.data != null)
                s.Jobs = d.data;
                else
                s.Jobs = [];
            co("R-getJobs", d);
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
        s.Job.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': s.Job.NameAr }, s.Jobs);
        s.Job.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': s.Job.NameEn }, s.Jobs);
        
        if (s.Job.NameArDuplicate || s.Job.NameEnDuplicate)
            return;

        //Added To List
        s.Job.State = State.Create;
        s.Job.Id = "xNew" + Math.floor(Math.random() * 1000000);
        s.Job.JobName = Service.isEn ? s.Job.NameEn : s.Job.NameAr;
        s.Jobs.push(angular.copy(s.Job));

        s.filter();


        s.Job.NameAr = null;
        s.Job.NameEn = null;
    };

    //Update
    s.update = (job) => {
        //If Dublicate
        job.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': job.NameAr }, s.Jobs, job.Id);
        job.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': job.NameEn }, s.Jobs, job.Id);

        if (job.NameArDuplicate || job.NameEnDuplicate)
            return;

        if (job.State !=State.Create)
            job.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.JobsRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.JobsRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.Jobs.forEach((job,index) => {
                if(job.Id==s.RowUpdateBackup.Id)
                {
                    s.Jobs[index] = s.RowUpdateBackup;
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
            s.Jobs.forEach((item, index) => {
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
        var dataForSave = filter('filterIsEquals')(s.Jobs, 'State', State.Create, State.Delete, State.Update);
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
                        s.getJobs();
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
        s.getJobs();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Jobs, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);