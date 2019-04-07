angular.module("ngDate", [])
    .service("$ngDate", ["$http", function (http) {
        var fun = {};

        fun.GetDate = function () {

            return http({
                method: "Get",
                url: "/Service/GetMonths"

            });
        };

        return fun;
    }])
    .directive("ngDate", function ($compile, $http, $ngDate) {
        return {
            restrict: 'E',

            template: '<div ></div>',

            replace: true,


            link: function ($scope, elem, attr, ctrl) {

                var day,
                    month,
                    select,
                  requiredDate = attr.dateRequired === "true" ? true : false,
                  lableWithRequired='',
                    dateFrom,
                    dateTo,
                    validation,
                    required = "",
                    validationLength,
                    scopeArryMonth = 'Month' + Math.floor(Math.random() * 100000000),
                    scopeArryDays = 'Days' + Math.floor(Math.random() * 100000000),
                    scopeArryYears = 'Yares' + Math.floor(Math.random() * 100000000);



                //Day
                if (attr.dateDaySelect === "true") {

                    //Genreate Days
                    $scope.$parent[scopeArryDays] = [];
                    for (var i = 1; i <= 31; i++) {
                        $scope.$parent[scopeArryDays].push({ "day": i });
                    }
                    day = '<select class="cursorPointer col-lg-4 col-md-4 custom-date" name="' + attr.dateFormDayName + '" ng-model="' + attr.dateModelDay + '" ng-options="x.day as x.day for x in ' + scopeArryDays + '"  ng-required="' + requiredDate + '" style="height: 26px;"></select>';
                } else if (attr.dateDaySelect === "false") {
                    day = '<input type="number"class="  col-lg-4 col-md-4 "  name="' + attr.dateFormDayName + '" ng-model="' + attr.dateModelDay + '" placeholder="DD"     ng-required="' + requiredDate + '" ng-maxlength="2"/>';
                }

                //Month 
                if (attr.dateMonthSelect === "true") {
                    month = '<input type="number"class="  col-lg-4 col-md-4 "  name="' + attr.dateFormMonthName + '" ng-model="' + attr.dateModelMonth + '" placeholder="MM" ng-required="' + requiredDate + '" ng-maxlength="2" />';
                } else if (attr.dateMonthSelect === "false") {
                    if ($scope.$parent[scopeArryMonth] == null || $scope.$parent[scopeArryMonth] == undefined) {
                        $ngDate.GetDate().then(function (d) {
                            $scope.$parent[scopeArryMonth] = d.data;
                      
                        }).catch(() => {

                            $scope.$parent[scopeArryMonth] = [
                                { 'MonthIndex': 1, 'MonthName': 1 },
                            { 'MonthIndex': 2, 'MonthName': 2 },
                            { 'MonthIndex': 3, 'MonthName': 3 },
                            { 'MonthIndex': 4, 'MonthName': 4 },
                            { 'MonthIndex': 5, 'MonthName': 5 },
                            { 'MonthIndex': 6, 'MonthName': 6 },
                            { 'MonthIndex': 7, 'MonthName': 7 },
                            { 'MonthIndex': 8, 'MonthName': 8 },
                            { 'MonthIndex': 9, 'MonthName': 9 },
                            { 'MonthIndex': 10, 'MonthName': 10 },
                            { 'MonthIndex': 11, 'MonthName': 11 },
                            { 'MonthIndex': 12, 'MonthName': 12 },

                            ];
                        });
                    }

                    month = '<select class="cursorPointer col-lg-4 col-md-4 custom-date" name="' + attr.dateFormMonthName + '" ng-model="' + attr.dateModelMonth + '" ng-options="x.MonthIndex as x.MonthName for x in ' + scopeArryMonth + '" ng-required="' + requiredDate + '" style="height: 26px;"></select>';
                }

                //Years
                if (attr.dateYearSelect === "true") {
                    var yearNow = Math.floor(attr.dateCurrentYear);

                    //Date From
                    if (attr.dateFrom === "now") {
                        dateFrom = yearNow;
                    } else {
                        //Check Plus Or Minus
                        if (attr.dateFrom.includes('+'))
                            //Plus
                            dateFrom = yearNow + Math.floor(attr.dateFrom.replace('+', ''));
                        else if (attr.dateFrom.includes('-'))
                            //Minus
                            dateFrom = yearNow - Math.floor(attr.dateFrom.replace('-', ''));
                        else
                            dateFrom = attr.dateFrom;
                    }


                    //Date To
                    if (attr.dateTo === "now") {

                        dateTo = yearNow;
                    }
                    else if (attr.dateTo != undefined) {

                        //Check Plus Or Minus
                        if (attr.dateTo.includes('+'))
                            //Plus
                            dateTo = yearNow + Math.floor(attr.dateTo.replace('+', ''));
                        else if (attr.dateTo.includes('-'))
                            //Minus
                            dateTo = yearNow - Math.floor(attr.dateTo.replace('-', ''));
                        else
                            dateTo = attr.dateTo;
                    }


                    //Genreate Yares
                    $scope.$parent[scopeArryYears] = [];
                    for (var i = dateFrom; i <= dateTo; i++) {
                        $scope.$parent[scopeArryYears].push({ "Year": i });
                    }

                    select = '<select class="cursorPointer col-lg-4 col-md-4 custom-date" name="' + attr.dateFormYearName + '" ng-model="' + attr.dateModelYear + '" ng-options="x.Year as x.Year for x in ' + scopeArryYears + '" ng-required="' + requiredDate + '" style="height: 26px;"></select>';

                } else if (attr.dateYearSelect === "false") {
                    select = '<select class="cursorPointer col-lg-4 col-md-4 custom-date" name="' + attr.dateFormYearName + '" ng-model="' + attr.dateModelYear + '" ng-options="' + attr.dateYearOptions + '" ng-required="' + requiredDate + '" style="height: 26px;"></select>';
                }



                //validation Required
                if (attr.dateRequired != undefined) {
                    if (attr.dateRequired === "true") {

                        required =
                              '<label class="red displayBlock" ng-show="' + attr.dateForm + '.' + attr.dateFormDayName + '.$error.required&&' + attr.dateRunRequiredModel + '">Day : ' + attr.erorrLabelRequiredDate + '</label>'
                            + '<label class="red displayBlock" ng-show="' + attr.dateForm + '.' + attr.dateFormMonthName + '.$error.required&&' + attr.dateRunRequiredModel + '">Month : ' + attr.erorrLabelRequiredDate + '</label>'
                            + '<label class="red displayBlock" ng-show="' + attr.dateForm + '.' + attr.dateFormYearName + '.$error.required&&' + attr.dateRunRequiredModel + '">Year : ' + attr.erorrLabelRequiredDate + '</label>';
                    }
                }

                //validation Length
                validationLength =
                              '<!--Length Valuation -->'
                              + '<label class="red displayBlock" ng-show="' + attr.dateForm + '.' + attr.dateFormDayName + '.$error.maxlength&&' + attr.dateRunRequiredModel + '">Day : ' + attr.erorrLabelMaxLength + '</label>'
                              + '<label class="red displayBlock" ng-show="' + attr.dateForm + '.' + attr.dateFormMonthName + '.$error.maxlength&&' + attr.dateRunRequiredModel + '">Month : ' + attr.erorrLabelMaxLength + '</label>';

                //validation 
                validation =
                  '  <!--Num Day In Any Month -->'
                  + ' <label class="red displayBlock" ng-show="(' + attr.dateModelYear + ' % 4 == 0 && ' + attr.dateModelMonth + ' == 2 && ' + attr.dateModelDay + ' > 29) || (' + attr.dateModelYear + ' % 4 > 0 && ' + attr.dateModelMonth + ' == 2 && ' + attr.dateModelDay + ' > 28) || ((' + attr.dateModelMonth + '==1||' + attr.dateModelMonth + '==3||' + attr.dateModelMonth + '==5||' + attr.dateModelMonth + '==7||' + attr.dateModelMonth + '==8||' + attr.dateModelMonth + '==10||' + attr.dateModelMonth + '==12) && ' + attr.dateModelDay + ' > 31) || (' + attr.dateModelMonth + '==4||' + attr.dateModelMonth + '==6||' + attr.dateModelMonth + '==9||' + attr.dateModelMonth + '==11)&&' + attr.dateModelDay + '>30||' + attr.dateModelDay + ' < 0  ">InvalidDate</label>'
                  + ' <!--Num Day In  Month  Feb -->'
                  + '   <label class="red displayBlock" ng-show="' + attr.dateModelMonth + ' >12||' + attr.dateModelMonth + '<0||' + attr.dateModelMonth + '===0 && ' + attr.dateRunRequiredModel + '">InvalidDate</label>';
                + '   <label class="red displayBlock" ng-show="' + attr.dateModelMonth + ' >12||' + attr.dateModelMonth + '<0||' + attr.dateModelMonth + '===0 && ' + attr.dateRunRequiredModel + '">InvalidDate</label>';

                debugger;

                if (attr.dateLabel != undefined) {
               
                    lableWithRequired = '<label for="labFirstNameAr">' + attr.dateLabel + '</label> ' + (attr.dateRequired === "true" ? ' <span class="red">*</span>' : "") + '</label>';
                }
               
                var htmlDate =
                        '<div class="">'
                        + lableWithRequired
                                              + '<div class="ngdateGroub">'
                        + day
                        + month
                        + select
                        + '</div>'
                        + required
                        + validationLength
                + validation
                '</div>';




                var element = $(elem).append(htmlDate);
                $compile(element)($scope);
            }
        };
    });