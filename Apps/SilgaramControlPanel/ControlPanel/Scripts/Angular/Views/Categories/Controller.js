/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlCategories', ['$scope', '$http','$filter', 'serviceCategories', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.Categories = null;
    //</!--Config-->

    //Get Categories
    s.getCategories = () => {
        startBlock();
        service.getCategories().then((d) => {
            if (d.data != "" && d.data != null)
                s.Categories = d.data;
            else
                s.Categories = [];
            co("R-getCategories", d);
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
        s.Category.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': s.Category.NameAr }, s.Categories);
        s.Category.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': s.Category.NameEn }, s.Categories);
        
        if (s.Category.NameArDuplicate || s.Category.NameEnDuplicate)
            return;

        //Added To List
        s.Category.State = State.Create;
        s.Category.Id = "xNew" + Math.floor(Math.random() * 1000000);
        s.Category.CategoryName = Service.isEn ? s.Category.NameEn : s.Category.NameAr;
        s.Categories.push(angular.copy(s.Category));

        s.filter();
        s.Category.NameAr = null;
        s.Category.NameEn = null;
    };

    //Update
    s.update = (category) => {
        //If Dublicate
        category.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': category.NameAr }, s.Categories, category.Id);
        category.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': category.NameEn }, s.Categories, category.Id);

        if (category.NameArDuplicate || category.NameEnDuplicate)
            return;

        if (category.State !=State.Create)
            category.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.CategoriesRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.CategoriesRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.Categories.forEach((category,index) => {
                if(category.Id==s.RowUpdateBackup.Id)
                {
                    s.Categories[index] = s.RowUpdateBackup;
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
            s.Categories.forEach((item, index) => {
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
    s.undoDelete = category=> {
        if (category.Id.toString().includes('xNew'))
            category.State = State.Create;
        else
            category.State = null;

    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.Categories, 'State', State.Create, State.Delete, State.Update);
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
                        s.getCategories();
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
        s.getCategories();
    }; s.callFunctions();


    $(window).on('beforeunload', function () {
        var dataForSave = filter('filterIsEquals')(s.Categories, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);