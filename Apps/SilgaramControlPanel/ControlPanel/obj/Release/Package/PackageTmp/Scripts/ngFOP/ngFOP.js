angular.module("ngFOP", [])
    .service("fOPService", ["$filter", function ($filter) {
        var fun = {},
         config = {
             data: null,
             dataRepeat: null,
             ngModels: []
         };

        //Fill object data in Cofig && set Nme Object repeat
        fun.fillData = function (data, dataRepeat) {
            config.data = data;
            config.dataRepeat = dataRepeat;
        };


        //set ng models
        fun.setNgModels = function (modelName) {
            config.ngModels.push(modelName);
        };

        //filter
        fun.filter = function (objectPropertFilter, data) {
            if (data == null || data == undefined)
                return $filter('filter')(config.data, objectPropertFilter);

            return $filter('filter')(data, objectPropertFilter);

        };

        //return config
        fun.getConfig = function () {
            return config;
        };

        return fun;
    }])
    .service("serviceOrderBy", ["orderByFilter", "fOPService", function (orderBy, fOPService) {
        /*
        (reverse=true)   0-9 ||  Z-A 
        (reverse=false)  9-0 ||  A-Z 
        */

        var fun = {},
            Range = [],
        //Config Service
        Config = {
            Items: null,
            propertyName: '',
            reverse: false
        };
        var propertyNameVrtial, reverseVrtial;


        //set Defult In Config
        fun.setDefultInConfig = function (reverse, propertyName) {
            Config.propertyName = propertyName;
            Config.reverse = reverse;
        };

        //OrderBy 
        fun.OrderBy = function (data, reverse, propertyName) {
            if (data == undefined)
                Config.Items = fOPService.getConfig().data;

            else
                Config.Items = data;

            if (reverse == undefined && propertyName == undefined)
                //order by defult
                Config.Items = orderBy(Config.Items, Config.propertyName, Config.reverse);
            else
                Config.Items = orderBy(Config.Items, propertyName, reverse);

            return Config.Items;
        };

        //restart OrderBy
        fun.restartOrderBy = function () {
            propertyNameVrtial = null;
            reverseVrtial = null;
            Config.Items = orderBy(Config.Items, Config.propertyName, Config.reverse);
            return Config.Items;
        };

        return fun;
    }])
    .service("servicePaging", [function () {
        var fun = {},
           Pages = [],
           PageSizeVrtial = 0,
           PagesVrtial = [],
           pageSizeVrtial,//تم انشاء هذا المتغير للتلاعب بة وعد المساس بـ اعدادت الكونفيج
             startIndexVrtial = 0;

        //Config Service
        fun.Config = {
            Items: [],
            pageItemsCount: 15,//عدد العناصر الذى سوف تعرض فى الصفحة الواحدة
            pageItemsCountselect: [],//ليختار المستخدم عدد العناصر المراد عرضها فى الصفحة
            pageItemsCountDefult: 15,
            totalPages: 0,//عدد كل الصفح
            pageSize: 5,//عدد الصفح المرد عرضها
            currentPage: 1,//الصفحة الحالية
            currentpages: [],//الصفح الحالية
            startIndex: 0,
            pageSizeSelect: [],//ليختاؤ عدد الصفح الذى يريد التنقل بينها
        };

        //GetPages
        fun.GetPages = function () {
            if (fun.Config.Items == null || fun.Config.Items.length == 0)
                return {
                    itemLength: 0,
                    pages: null,
                    currentPage: 1,
                    totalPages: 0,
                    pageItemsCountselect: null,
                    pageItemsCount: null,
                    pageSize: null,
                    pageSizeSelect: null,
                    items: null,
                };

             
            //rest Defult
            if (fun.Config.pageItemsCount < fun.Config.pageItemsCountDefult)
                fun.Config.pageItemsCount = fun.Config.pageItemsCountDefult;

            //نزود واحد بحيث يكون هناك صفحة زيادة
            fun.Config.totalPages = Math.ceil(fun.Config.Items.length / fun.Config.pageItemsCount);
            //بحيث الوقوف على آخر صفحة
            if (fun.Config.currentPage > fun.Config.totalPages)
                fun.Config.currentPage = fun.Config.totalPages;

            fun.GetPager(fun.Config.pageSize, fun.Config.totalPages);

            //وضع عدد العناصر الذى يختار منها المستخدم لتعرض فى الصفحة
            fun.Config.pageItemsCountselect = [];
            if (fun.Config.Items.length > 5) {
                 
                for (var w = 5; w <= fun.Config.Items.length; w + 0) {
                    fun.Config.pageItemsCountselect.push(w);
                    w *= 2;
                }
            } else {
                //بحث ان تكون السيلكت الخاصة بعدد العناصر فى الصفحة لا تكون فارغة 
                fun.Config.pageItemsCountselect.push(fun.Config.Items.length);
                fun.Config.pageItemsCount = fun.Config.Items.length;
            }



            //وضع عدد الصفح الذى يريد ان يرها للتنقل بين الصفح من خلالها
            fun.Config.pageSizeSelect = [];
            if (fun.Config.totalPages > 5) {
                for (var w = 5; w <= fun.Config.totalPages ; w + 0) {

                    fun.Config.pageSizeSelect.push(w);
                    w *= 2;
                }
            } else {
                //بحيث السيلكت الخاصة بـ عدد الصفح لا تكون فارغة 
                fun.Config.pageSizeSelect.push(fun.Config.totalPages);
                fun.Config.pageSize = fun.Config.totalPages;
            }

            return {

                itemLength: fun.Config.Items.length,
                pages: fun.Config.currentpages,
                currentPage: fun.Config.currentPage,
                totalPages: fun.Config.totalPages,//لان عملية التكرار تبداء من واحد ولذالك يجب اعادة ضبط الرتب بنا على ما يعرض للمستخدم
                pageItemsCountselect: fun.Config.pageItemsCountselect,
                pageItemsCount: fun.Config.pageItemsCount,
                pageSize: fun.Config.pageSize,
                pageSizeSelect: fun.Config.pageSizeSelect,
                items: fun.SetItems(),
            };
        };

        //GotoPage
        fun.GotoPage = function (numPage) {

            if (fun.Config.Items == undefined)
                return;

            if (numPage == undefined) {
                //return null;
                return {
                    itemLength: null,
                    pages: null,
                    //   currentPage: fun.Config.currentPage,
                    totalPages: null,
                    pageItemsCountselect: null,
                    pageItemsCount: null,
                    pageSize: null,
                    pageSizeSelect: null,
                    items: [],// fun.SetItems(),
                };
            }

            

            if (numPage == 0 || numPage > fun.Config.totalPages)
                fun.Config.currentpages = [];

            fun.Config.currentpages = [];

            //البحث داخل الصفح اذا صفحة منهم 
            for (var i = 0; i < Pages.length; i++) {
                if (fun.Config.currentpages.length == 0) {
                    var x = Pages[i].length - 1;
                    if (fun.Config.currentPage > numPage) {
                        /*
                        الصفحة الحالية اكبر من المطلوبة اذا هوا يرجع للخلف 
                        */
                        for (var y = 0; y < Pages[i].length; y++) {
                            if (Pages[i][y].numPage == numPage)
                                fun.Config.currentpages = Pages[i];
                        }
                        //if (Pages[i][x].numPage == numPage)
                        //    fun.Config.currentpages = Pages[i];
                    } else if (fun.Config.currentPage < numPage) {
                        /*
                        الصفحة الحالية اصغر من الصفحة المطلوبة اذا هوا يذهب الى الامام
                        */
                        for (var y = 0; y < Pages[i].length; y++) {
                            if (Pages[i][y].numPage == numPage)
                                fun.Config.currentpages = Pages[i];
                        }
                    }
                }
            }


            if (!Pages.length == 0 && fun.Config.currentpages.length == 0) {
                //واذا كانت الصفحة الاولى او الاخيرة
                if (Pages[0][0].numPage == numPage) {
                    //Frist Page
                    fun.Config.currentpages = Pages[0];
                } else if (Pages[Pages.length - 1][Pages[Pages.length - 1].length - 1].numPage == numPage) {
                    //Last Page
                    fun.Config.currentpages = Pages[Pages.length - 1];
                } else {
                    if (fun.Config.currentpages.length === 0) {
                        //معنى ذالك انها صفحة فى الوسط 
                        for (var i = 0; i < Pages.length; i++) {
                            for (var z = 0; z < Pages[i].length; z++) {
                                if (Pages[i][z].numPage == numPage)
                                    fun.Config.currentpages = Pages[i];

                            }

                        }
                    }


                }
            }
            fun.Config.currentPage = numPage;

            /*
            من اجل اختيار 
            pageSize
            بحيث يكون السيلكت على قد عدد الصفح المعروضة
            */
            // if (PageSizeVrtial==0) 
            //   PageSizeVrtial = fun.Config.pageSizeSelect[0];

            return {
                itemLength: fun.Config.Items.length,
                pages: fun.Config.currentpages,
                currentPage: fun.Config.currentPage,
                totalPages: fun.Config.totalPages,
                pageItemsCountselect: fun.Config.pageItemsCountselect,
                pageItemsCount: fun.Config.pageItemsCount,
                pageSize: PageSizeVrtial,
                pageSizeSelect: fun.Config.pageSizeSelect,
                items: fun.SetItems(),
                isLastPage: numPage == fun.Config.totalPages
            };
        };

        //SetItems
        fun.SetItems = function () {
            /*
           page Num 2 If pageItemsCount==5
           startIndex= 2 - 1 * 5 = 5;
           endIndex= 2 * 5 = 10;
           هكذا
           */
            if (fun.Config.Items == null) return;

            var startIndex = (fun.Config.currentPage - 1) * fun.Config.pageItemsCount,
                endIndex = fun.Config.currentPage * fun.Config.pageItemsCount,
                items = fun.Config.Items.slice(startIndex, endIndex);

            return items;
        };

        //GetPager
        fun.GetPager = function (pageSize, totalPages) {

            if (fun.Config.pageSize < 5) {
                fun.Config.pageSize = 5;
            }
            if (pageSize < fun.Config.pageSize) {
                pageSize = fun.Config.pageSize;
            }


            PagesVrtial = []
            //انشاء اوبجكت افتراضى
            for (var i = 0; i < fun.Config.totalPages ; i++) {
                PagesVrtial.push({ "numPage": (i + 1) });
            }

            //تقسيم الصفح الى وحدات وكل وحدة بها عدد صفح تم تحديدة من قبل المستخدم ويمكن تغيرة 
            Pages = [];

            startIndexVrtial = fun.Config.startIndex;
            pageSizeVrtial = pageSize;// fun.Config.pageSize;
            while (startIndexVrtial <= PagesVrtial.length) {
                /*
                نقوم الان بتقسيم الى مجموعات او وحدات الصفح الذى سوف يتنقل منها المستخدم
                */
                Pages.push(PagesVrtial.slice(startIndexVrtial, pageSizeVrtial));
                startIndexVrtial = pageSizeVrtial - 1;
                pageSizeVrtial = pageSizeVrtial + pageSize;// fun.Config.pageSize;
            };

            //وضع المجموعة الذى سوف تعرض اول حاجة
            if (fun.Config.pageSize < fun.Config.currentPage) {
                //هذا التحقق مهم لانة يجلب لنا المجموعة الذى بة الصفحة الحالية 

                for (var i = 0; i < Pages.length; i++) {
                    for (var x = 0; x < Pages[i].length; x++) {
                        if (fun.Config.currentPage === Pages[i][x].numPage) {
                            fun.Config.currentpages = Pages[i];
                        }
                    }
                }

            } else {
                fun.Config.currentpages = Pages[0];
            }
        };

        //changePageSize
        fun.changePageSize = function (pageSize) {

            fun.GetPager(pageSize, fun.Config.totalPages);
            PageSizeVrtial = pageSize;
            return {

                itemLength: fun.Config.Items.length,
                pages: fun.Config.currentpages,
                currentPage: fun.Config.currentPage,
                totalPages: fun.Config.totalPages,//لان عملية التكرار تبداء من واحد ولذالك يجب اعادة ضبط الرتب بنا على ما يعرض للمستخدم
                pageItemsCountselect: fun.Config.pageItemsCountselect,
                pageItemsCount: fun.Config.pageItemsCount,
                pageSize: pageSize,//بحيث يكون واقف السيلكت عليها
                pageSizeSelect: fun.Config.pageSizeSelect,

            };
        };


        return fun;
    }])
    .directive("ngFopData", function (fOPService, serviceOrderBy, servicePaging, $compile) {
        return {
            restrict: 'A',
            link: function ($scope, elem, attr, ctrl) {
                //Set Object Data For Filter && Set object DataRepeat
                fOPService.fillData($scope[attr.ngFopData], attr.ngFopDataRepeat);

                //set new data is change
                $scope.$watch(attr.ngFopData, function () {


                    //Set Object Data For Filter && Set object DataRepeat
                    fOPService.fillData($scope[attr.ngFopData], attr.ngFopDataRepeat);

                    //create object filter
                    var config = fOPService.getConfig(), objectPropertyFilter = {};
                    config.ngModels.forEach(function (prop) {
                        if ($scope[prop] != undefined)
                            objectPropertyFilter[prop] = $scope[prop];
                    });



                    var _config = fOPService.getConfig();
                     
                    //filter order by defult and paging
                    servicePaging.Config.Items = serviceOrderBy.OrderBy(fOPService.filter(objectPropertyFilter), $scope.reverse, $scope.propertyName);
                    $scope.Pager = servicePaging.GetPages();
                    $scope[_config.dataRepeat] = $scope.Pager.items;
                });
            }
        };
    })
    .directive("ngFop", function (fOPService, serviceOrderBy, servicePaging, $compile) {
        return {
            restrict: 'E',
            template: '<div></div>',
            replace: true,
            link: function ($scope, elem, attr, ctrl) {
                var elments = {
                    icon: '',
                    lable: '',
                    lableRequired: '',
                    attr: '',
                    filter: '',
                    placeholder: " ",
                    orderBy: '',
                    ngClickOrderBy: '',
                    divOpen: '<div>',
                    divClose: '</div>'
                }, charEmpty;
                 
                //set icon
                if (attr.ngFopClassIcon != undefined)
                    elments.icon = '<i class="' + attr.ngFopClassIcon + '"></i>';

                //set orderBy
                if (attr.ngFopOrderBy != undefined && attr.ngFopOrderBy == 'true') {
                    elments.ngClickOrderBy = 'ng-click="orderBy(\'' + attr.ngFopModel + '\')"';
                    elments.orderBy = '<div class="iconeSortDive cursor-pointer"  ' + elments.ngClickOrderBy + '>'
                       + '<span class="sortorder " ng-show="propertyName === \'' + attr.ngFopModel + '\'" ng-class="{reverse: reverse}"></span>'
                       + '<span class="glyphicon glyphicon-sort  opacity-2" ng-show="propertyName != \'' + attr.ngFopModel + '\'" ></span>'
                        + '</div>';
                }

                //set lable
                if (attr.ngFopLabel != undefined)
                    if (attr.ngFopOrderBy != undefined && attr.ngFopOrderBy == 'true')
                        elments.lable = '<label class="control-label cursor-pointer" ' + elments.ngClickOrderBy + '>  ' + elments.icon + ' ' + attr.ngFopLabel + '</label>';
                    else
                        elments.lable = '<label class="control-label">  ' + elments.icon + ' ' + attr.ngFopLabel + '</label>';

                //set lable error
                if (attr.ngFopRequierd != undefined && attr.ngFopRequierd == "true")
                    elments.lableRequired = ' <label class="lableErorr">*</label>';

                //set attr
                if (attr.ngFopAttr != undefined)
                    elments.attr = attr.ngFopAttr;

                //set placeholder
                if (attr.ngFopPlaceholder != undefined)
                    elments.placeholder = attr.ngFopPlaceholder;

                //set input filter
                if (attr.ngFopFilter != undefined && attr.ngFopFilter == 'true')
                    switch (attr.ngFopTypeFilter) {
                        case 'bool':
                            {
                                elments.filter = '<div class="icon-addon addon-sm">' +
                                        '<select class="form-control cursor-pointer" ' + elments.attr + ' ng-model="' + attr.ngFopModel + '" ng-change="filter()">' +
                                        '<option value="true" label="{{boolTrue}}"></option>' +
                                        '<option value="false" label="{{boolFalse}}"></option>' +
                                        '</select>' +
                                        '<label ng-hide="' + attr.ngFopModel + ' != null" for="txt2" class="glyphicon glyphicon-search" rel="tooltip"></label>'
                                     + '<label ng-show="' + attr.ngFopModel + ' != null" class="glyphicon glyphicon-remove-circle" ng-click="' + attr.ngFopModel + '=null;filter()" ></label>'
                                '</div>';
                            } break;
                        case 'select':
                            {
                                elments.filter = '<div class="icon-addon addon-sm">' +
                                        '<select class="form-control cursor-pointer" ' + elments.attr + ' ng-model="' + attr.ngFopModel + '" ng-options="' + attr.ngFopOptions + '" ng-change="filter()"></select>' +
                                        '<label ng-hide="' + attr.ngFopModel + ' != null" for="txt2" class="glyphicon glyphicon-search" rel="tooltip"></label>'
                                     + '<label ng-show="' + attr.ngFopModel + ' != null" class="glyphicon glyphicon-remove-circle" ng-click="' + attr.ngFopModel + '=null;filter()" ></label>'
                                '</div>';
                            } break;
                        case 'number':
                            {
                                elments.filter = '<div class="icon-addon addon-sm">' +
                                                '<input type="number" class="form-control" ' + elments.attr + ' placeholder=' + elments.placeholder + ' min="' + attr.ngFopMin + '" max="' + attr.ngFopMax + '" ng-model="' + attr.ngFopModel + '" ng-change="filter()" >' +
                                                '<label ng-show="' + attr.ngFopModel + '.length==0||' + attr.ngFopModel + '==null||' + attr.ngFopModel + '==' + charEmpty + '" for="txt2" class="glyphicon glyphicon-search" rel="tooltip"></label>'
                                     + '<label ng-show="' + attr.ngFopModel + '.length>0&&' + attr.ngFopModel + '!=null" class="glyphicon glyphicon-remove-circle" ng-click="' + attr.ngFopModel + '=' + charEmpty + ';filter()" ></label>'
                                '</div>';
                            } break;
                        default: {
                            elments.filter = '<div class="icon-addon addon-sm">' +
                                     '<input type="' + attr.ngFopTypeFilter + '" class="form-control" ' + elments.attr + ' placeholder=' + elments.placeholder + '   ng-model="' + attr.ngFopModel + '" ng-change="filter()" >' +
                                     '<label ng-show="' + attr.ngFopModel + '.length==0||' + attr.ngFopModel + '==null||' + attr.ngFopModel + '==' + charEmpty + '" for="txt2" class="glyphicon glyphicon-search" rel="tooltip"></label>'
                                     + '<label ng-show="' + attr.ngFopModel + '.length>0&&' + attr.ngFopModel + '!=null" class="glyphicon glyphicon-remove-circle" ng-click="' + attr.ngFopModel + '=' + charEmpty + ';filter()" ></label>'
                            '</div>';
                        }
                    }

                elments.divOpen += elments.lable + elments.lableRequired + elments.orderBy + elments.filter + elments.divClose;
                //insert Lable With using sort Or No using Sort
                var element = $(elem).append(elments.divOpen)
                $compile(element)($scope);

                //add this model to list model for filter
                fOPService.setNgModels(attr.ngFopModel);

                //Filter
                $scope.filter = function () {
                     
                    var config = fOPService.getConfig(), objectPropertyFilter = {};

                    config.ngModels.forEach(function (prop) {
                        if ($scope[prop] != undefined)
                            objectPropertyFilter[prop] = $scope[prop];
                    });

                    //sed data filter to fop for process orderby and paging
                    $scope.fop(fOPService.filter(objectPropertyFilter));
                };

                //Functions 
                $scope.orderBy = function (propertyName) {
                     
                    $scope.reverse = $scope.propertyName === propertyName ? !$scope.reverse : true;
                    $scope.propertyName = propertyName;
                    //نقوم بعمل فيلتر ثم ترتيب 
                    var config = fOPService.getConfig(), objectPropertyFilter = {};

                    config.ngModels.forEach(function (prop) {
                        if ($scope[prop] != undefined)
                            objectPropertyFilter[prop] = $scope[prop];
                    });

                    //Paging
                    servicePaging.Config.Items = serviceOrderBy.OrderBy(fOPService.filter(objectPropertyFilter), $scope.reverse, $scope.propertyName);
                    $scope.Pager = servicePaging.GetPages();
                    $scope[fOPService.getConfig().dataRepeat] = $scope.Pager.items;
                };

                //Fop
                $scope.fop = function (dataFiltered) {
                     
                    //order by defult and paging
                    servicePaging.Config.Items = serviceOrderBy.OrderBy(dataFiltered, undefined, undefined);
                    $scope.Pager = servicePaging.GetPages();
                    $scope[fOPService.getConfig().dataRepeat] = $scope.Pager.items;
                };
            }
        };
    })
    .directive("ngFopOrderByDefult", function (fOPService, serviceOrderBy, $compile) {
        return {
            restrict: 'A',
            replace: false,
            link: function ($scope, elem, attr, ctrl) {

                if (attr.ngFopOrderBy == undefined || attr.ngFopOrderBy == 'false' && attr.ngFopOrderByDefult == 'true')
                    return;

                var _config = fOPService.getConfig();


                $scope.reverse = $scope.propertyName === attr.ngFopModel ? !$scope.reverse : true;
                $scope.propertyName = attr.ngFopModel;
                serviceOrderBy.setDefultInConfig(attr.ngFopOrderByDefultCase, attr.ngFopModel);
                $scope[_config.dataRepeat] = serviceOrderBy.OrderBy($scope.reverse, $scope.propertyName);

            }
        };
    })
    .directive("ngPaging", function (fOPService, servicePaging) {
        return {

            replace: true,
            restrict: "E",
            templateUrl: "/Scripts/ngFOP/PageingPage.html",
            link: function ($scope, elm, attr, ctrl) {

                if (attr.ngPagingCountItem != undefined) {
                    servicePaging.Config.pageItemsCount = attr.ngPagingCountItem;
                    servicePaging.Config['pageItemsCountDefult'] = attr.ngPagingCountItem;
                }

                var _config = fOPService.getConfig();

                //paging
                //الذهاب الى صفحة ما
                $scope.GotoPage = function (numPage) {
                    $scope.Pager = servicePaging.GotoPage(numPage);
                    $scope[_config.dataRepeat] = $scope.Pager.items;
                };

                //تغير عدد العماصر الذى سوف تعرض فى الصفحة
                $scope.changePageItemsCount = function (pageItemsCount) {
                    if (pageItemsCount == null) return;
                    servicePaging.Config.pageItemsCount = pageItemsCount;
                    $scope.Pager = servicePaging.GetPages();
                    $scope[_config.dataRepeat] = $scope.Pager.items;
                };

                //تغير عدد الصفح الذى سوف تعرض فى الوحدة
                $scope.changePageSize = function (pageSize) {
                    if (pageSize == null) return;
                    $scope.Pager = servicePaging.changePageSize(pageSize);
                };
            }
        };
    }).directive("ngPagingDisplayMore", function (fOPService, servicePaging) {
        return {

            replace: true,
            restrict: "E",
            templateUrl: "/Scripts/ngFOP/ngPagingDisplayMore.html",
            link: function ($scope, elm, attr, ctrl) {

                if (attr.ngPagingCountItem != undefined) {
                    servicePaging.Config.pageItemsCount = attr.ngPagingCountItem;
                    servicePaging.Config['pageItemsCountDefult'] = attr.ngPagingCountItem;
                }

                var _config = fOPService.getConfig();

                //paging
                //الذهاب الى صفحة ما
                $scope.GotoPage = function (numPage) {
                    $scope.Pager = servicePaging.GotoPage(numPage);
                    $scope[_config.dataRepeat] = $scope.Pager.items;
                };

                //تغير عدد العماصر الذى سوف تعرض فى الصفحة
                $scope.changePageItemsCount = function (pageItemsCount) {
                    if (pageItemsCount == null) return;
                    servicePaging.Config.pageItemsCount = pageItemsCount;
                    $scope.Pager = servicePaging.GetPages();
                    $scope[_config.dataRepeat] = $scope.Pager.items;
                };

                //تغير عدد الصفح الذى سوف تعرض فى الوحدة
                $scope.changePageSize = function (pageSize) {
                    if (pageSize == null) return;
                    $scope.Pager = servicePaging.changePageSize(pageSize);
                };
            }
        };
    });
