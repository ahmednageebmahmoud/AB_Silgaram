/// <reference path="../../Shared/Module.js" />
myApp.controller('ctrlSubCategories', ['$scope', '$http','$filter', 'serviceSubCategories', 'serviceView', function (s, h, filter,service, serviceView) {

    //<!--Config-->
    s.Token = Token;
    s.State = State;
    s.Categories = [];
    s.SubCategories = [];
    s.SubCaImageUpdateReview = null;
    s.SubCategoryImageUpdate = null;
    //</!--Config-->

    //Get Categories
    s.getCategories = () => {
        startBlock();
        service.getCategories().then((d) => {
            if (d.data != "" && d.data!=null)
                s.Categories = d.data;
            co("R-getCategories", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("Error Login", error.data);
            stopBlock();
        });
    };

    //Get SubCategories
    s.getSubCategories = () => {
        startBlock();
        service.getSubCategories(s.SubCategory.FkCategory_Id).then((d) => {
            if (d.data != "" && d.data != null)
                s.SubCategories = d.data;
            else
                s.SubCategories = [];

            co("R-getSubCategories", d);
            stopBlock();
        }).catch((error) => {
            if (!navigator.onLine)
                toastr.error(Token.ICantCallToServer, Token.Error);
            toastr.error(Token.OrSomeErrorInServer, Token.Error); co("SubCategories Login", error.data);
            stopBlock();
        });
    };

    //Create
    s.create = () => {
        
        //If Dublicate
        s.SubCategory.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': s.SubCategory.NameAr }, s.SubCategories);
        s.SubCategory.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': s.SubCategory.NameEn }, s.SubCategories);
        
        if (s.SubCategory.NameArDuplicate || s.SubCategory.NameEnDuplicate)
            return;

        //Added To List
        s.SubCategory.State = State.Create;
        s.SubCategory.Id = "xNew" + Math.floor(Math.random() * 1000000);
        s.SubCategory.SubCategoryName = Service.isEn ? s.SubCategory.NameEn : s.SubCategory.NameAr;
        s.SubCategory.Image = s.SubCaImageReview;
        var lengthPushed = s.SubCategories.push(angular.copy(s.SubCategory));
        //Add Image
        s.SubCategories[lengthPushed - 1].NewFile = s.SubCategoryImage;



        s.filter();
        s.SubCategory.NameAr = null;
        s.SubCategory.NameEn = null;
    };

    //Update
    s.update = (subCategory, fileImage, imageSrc) => {
        //If Dublicate
        subCategory.NameArDuplicate = serviceView.isDuplicated({ 'NameAr': subCategory.NameAr }, s.SubCategories, subCategory.Id);
        subCategory.NameEnDuplicate = serviceView.isDuplicated({ 'NameEn': subCategory.NameEn }, s.SubCategories, subCategory.Id);

        if (subCategory.NameArDuplicate || subCategory.NameEnDuplicate)
            return;


        if (!IsNullOrEmptyOrUndefined(imageSrc)) {
            subCategory.Image = imageSrc;
            subCategory.NewFile = fileImage;
        }

        if (subCategory.State !=State.Create)
            subCategory.State = State.Update;
        s.restartUpdate();
    };

    //Change For Update
    s.changeForUpdate = (index) => {
        if (s.ShowUpdate != -1) {
            s.SubCategoriesRepeat[s.ShowUpdate] = s.RowUpdateBackup;
        }
        s.ShowUpdate = index;
        s.RowUpdateBackup = angular.copy(s.SubCategoriesRepeat[index]);
    };

    //Restart Update
    s.restartUpdate = (resort) => {
        //Resort Backup 
        if (resort) {
            s.SubCategories.forEach((subCategory,index) => {
                if(subCategory.Id==s.RowUpdateBackup.Id)
                {
                    s.SubCategories[index] = s.RowUpdateBackup;
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
            s.SubCategories.forEach((item, index) => {
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
    s.undoDelete = subCategory=> {
        if (subCategory.Id.toString().includes('xNew'))
            subCategory.State = State.Create;
        else
            subCategory.State = null;

    };

    //Save Change
    s.saveChange = () => {
        //Check Data For Save
        var dataForSave = filter('filterIsEquals')(s.SubCategories, 'State', State.Create, State.Delete, State.Update);
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
                        s.getSubCategories();
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
        var dataForSave = filter('filterIsEquals')(s.SubCategories, 'State', State.Create, State.Delete, State.Update);
        dataForSave = filter('filterIsNotConstantWithDelete')(dataForSave, 'Id', "xNew");
        if (dataForSave.length >0)
            return "";
    });
}]);