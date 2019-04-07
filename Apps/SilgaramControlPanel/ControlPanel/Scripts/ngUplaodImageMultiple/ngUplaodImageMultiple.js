angular.module("ngUplaodImageMultiple", []).directive('ngUplaodImageMultiple', function ($compile,$filter) {
    return {
        restrict: 'E',

        template: '<div></div>',


        replace: true,

        link: function ($scope, elem, attr, ctrl) {


            var countImages = attr.upCount;

            var elementUplaod = $(elem);
                        elementUplaod.append(' <input type="file" class="btn" multiple  name="' + attr.upName + '" accept="' + attr.upAccept + '" onchange="(angular.element(this).scope()).GetImagesReview(this)"/>');
            $compile(elementUplaod)($scope);

          

            $scope.GetImagesReview = function (elmentImage) {

                if (countImages == undefined || countImages == null) {
                                        for (var file of elmentImage.files) {

                        var reader = new FileReader();
                    //Read File
                        reader.onload = (fi=> {
                            return event=> {
                                var pathImage = event.target.result;
                                var imageObject = { "FileUrl": pathImage, "State": State.Create, "ImageName": fi.name, "File": fi };
                                $scope.$apply(function () {
                                    $scope[attr.upModelImages].push(imageObject);
                                });
                            }
                        })(file);
                        reader.readAsDataURL(file);
                    }
                }
                else {

                    //Filter Images from Iamges Deleted For Grt Pure length images Neded
                    var ImagesPureLenth = $filter('filterIsEquals')($scope[attr.upModelImages], 'State', State.Create,State.Update,null).length;

                    var counterImagesNadedd = countImages - ImagesPureLenth;

                    if (counterImagesNadedd == 0)
                        toastr.error("No More images");

                    for (var i = 0 ; i <= counterImagesNadedd-1 ; i++) {

                        var reader = new FileReader();
                        //Read File
                        reader.onload = (fi=> {
                            return event=> {
                                var pathImage = event.target.result;
                                var imageObject = { "FileUrl": pathImage, "State": State.Create, "ImageName": fi.name, "File": fi };
                                $scope.$apply(function () {
                                    $scope[attr.upModelImages].push(imageObject);
                                });
                            }
                        })(elmentImage.files[i]);
                        reader.readAsDataURL(elmentImage.files[i]);
                    }
                }
                


                elmentImage.value = null;
            };


        }
    };
});