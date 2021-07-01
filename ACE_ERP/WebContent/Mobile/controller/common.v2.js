var MOBILE = {
    Menu: function() {
        /*
        var params = [];
        AJAX.ParamAdd(params, "ID_USER", MOBILE.GetCookie("ID_USER"));
        AJAX.ParamAdd(params, "CD_DEPT", "");

        var data = {};
        data.SP = "DZZPR_MENUINFO_SELECT_M";
        data.PARAMS = params;
        var result = AJAX.Select(data);

        var menu = "<li data-icon='home'><a href='/mobile/main.html' data-ajax='false'>홈</a></li>";
        if (result.success) {
        var old_level = 0;
        for (var i = 0; i < result.data.length; i++) {
        if (old_level > result.data[i].NO_LEVEL) {
        menu += "</ul></li>";
        }
        if (result.data[i].YN_MENU == 'Y') {
        menu += "<li data-role='collapsible' data-inset='false' data-iconpos='right'>";
        menu += "<h3>" + result.data[i].DS_FORM + "</h3>";
        menu += "<ul data-role='listview'>";
        }
        else {
        var sub = "";
        if (result.data[i].NO_LEVEL > 0) {
        sub = "&nbsp;-&nbsp;";
        }
        menu += "<li data-icon='" + result.data[i].DS_ICON + "'><a href='" + result.data[i].PATH + "' data-ajax='false'>" + sub + result.data[i].DS_FORM + "</a></li>";
        }
        old_level = result.data[i].NO_LEVEL;
        }
        }
        
        menu += "<li data-icon='delete' onclick='MOBILE.Logout();'><a href='#'>로그아웃</a></li>";
        */

        var menu = "<li data-icon='home'><a href='/Mobile/main.html' data-ajax='false'>홈</a></li>";
        
        /*menu += "<li data-icon='user'><a href='/Mobile/view/ng010.jsp' data-ajax='false'>PMS</a></li>";*/
        
        menu += "<li data-icon='user'><a href='/Mobile/view/actionplanmain.jsp' data-ajax='false'>Action Plan List</a></li>";
        menu += "<li data-icon='user'><a href='/Mobile/view/actionplanfolder.jsp' data-ajax='false'>Action Plan Folder</a></li>";
        /*menu += "<li data-icon='grid'><a href='/mobile/view/daily.html' data-ajax='false'>출역관리</a></li>";*/
        /*menu += "<li data-icon='delete' onclick='MOBILE.Logout();'><a href='#'>로그아웃</a></li>";*/
        /*menu += "<li data-icon='delete'><a href='http://naver.com'>로그아웃</a></li>";*/
        
        
        $("#listMenu").html(menu);
        $("#listMenu").trigger("create");
        $("#listMenu").listview("refresh");

    },

    Logout: function() {
    	
        if (confirm("로그아웃 하시겠습니까??\r\n")) {
        	
            $.cookie("AUTH", null, { path: '/' });
            //AJAX.Logout();
            //onclick="moveMove('/Common/sys/logout.jsp','');">
            
            //alert("로그아웃");
            
            //eturn "<li><a href='#' style='text-align:center;' class='ui-btn' onclick="moveMove('/Common/sys/logout.jsp','');"></a></li>"
        }
        
    },

    StartLoading: function() {
        $.mobile.loading('show', {
            text: "로딩중",
            textVisible: true,
            theme: "c",
            textonly: false,
            html: ""
        });
    },

    EndLoading: function() {
        $.mobile.loading('hide');
    },

    GetCookie: function(c_name) {
        if (document.cookie.length > 0) {
            c_start = document.cookie.indexOf(c_name + "=");
            if (c_start != -1) {
                c_start = c_start + c_name.length + 1;
                c_end = document.cookie.indexOf("&", c_start);
                if (c_end == -1) c_end = document.cookie.length;
                return decodeURI(document.cookie.substring(c_start, c_end));
            }
        }
        return "";
    }
}

var CODEFIND = {

    Site: function() {
        $.mobile.document.on("pagebeforeshow", "#pageSite", function(e) {
            $("#listSite").on("filterablebeforefilter", function(e, data) {
                var $ul = $(this),
                            $input = $(data.input),
                            value = $input.val();
                if (value) {
                    CODEFIND.SiteSelect(value);
                }
                else {
                    CODEFIND.SiteSelect();
                }
            });

            CODEFIND.SiteSelect();
        });
    },

    SiteSelect: function(value) {
        var params = [];
        AJAX.ParamAdd(params, "TY_GUBUN", "1");
        AJAX.ParamAdd(params, "CN_ROW", 10, "Int");
        AJAX.ParamAdd(params, "VALUE", value);
        AJAX.ParamAdd(params, "MIN_VALUE", "");
        AJAX.ParamAdd(params, "GR_SEARCH", "1");
        AJAX.ParamAdd(params, "CD_DEPT", "100025");
        AJAX.ParamAdd(params, "CD_CORP", "D100"); //MOBILE.GetCookie("CD_CORP"));

        var data = {};
        data.SP = "DSXPR_DEPT_CODE";
        data.PARAMS = params;

        var result = AJAX.Select(data);
        if (result.success) {

            $("#listSite li").remove();
            var html = "";
            for (var i = 0; i < result.data.length; i++) {
                html += "<li><a data-rel='back' onclick='fnSetSite(\"" + result.data[i].CD_SITE + "\",\"" + result.data[i].DS_SITECHA + "\")'>" + result.data[i].DS_SITECHA + "</a></li>";
            }
            $("#listSite").append(html);

            $("#listSite").listview("refresh");
        }
    },

    Employee: function() {
        $.mobile.document.on("pagebeforeshow", "#pageEmployee", function(e) {
            $("#listEmployee").on("filterablebeforefilter", function(e, data) {
                var $ul = $(this),
                                $input = $(data.input),
                                value = $input.val();
                if (value) {
                    CODEFIND.EmployeeSelect(value);
                }
                else {
                    CODEFIND.EmployeeSelect();
                }
            });

            CODEFIND.EmployeeSelect();
        });
    },

    EmployeeSelect: function(value) {
        var params = [];
        AJAX.ParamAdd(params, "TY_GUBUN", "1");
        AJAX.ParamAdd(params, "CN_ROW", 10, "Int");
        AJAX.ParamAdd(params, "VALUE", value);
        AJAX.ParamAdd(params, "MIN_VALUE", "");
        AJAX.ParamAdd(params, "CD_SITE", $("#hdnCD_SITE").val());

        var data = {};
        data.SP = "DSXPR_EMPLOYEE_01";
        data.PARAMS = params;

        var result = AJAX.Select(data);
        if (result.success) {

            $("#listEmployee li").remove();
            var html = "";
            for (var i = 0; i < result.data.length; i++) {
                html += "<li><a data-rel='back' onclick='fnSetEmployee(\"" + result.data[i].NO_ID + "\",\"" + result.data[i].DS_NAME + "\")'>" + result.data[i].DS_NAME + "</a></li>";
            }
            $("#listEmployee").append(html);

            $("#listEmployee").listview("refresh");
        }
    }
}

var CONTROL = {
    IsExist: function(id) {
        var cls = "";
        if (id.indexOf("btn") > -1) {
            var cls = $("#" + id).attr("class");
        } else {
            cls = $("#" + id).parent().attr("class");
        }
        if (cls == undefined) cls = "";
        if (cls.indexOf('ui-btn') > -1 || cls.indexOf('ui-select') > -1 || cls.indexOf('ui-input-text') > -1) {
            return true;
        }
        else {
            return false;
        }
    }
}

var LISTVIEW = {

    AddTRow: function(link, title, onclick) {
        var row = "<li>" +
                    "<a href='" + link + "'" + (onclick == null ? "" : " onclick='" + onclick + "'") + ">" +
                    "<h2>" + title +
                    "</h2>" +
                    "</a>" +
                    "</li>";
        return row;
    },

    AddRow: function(link, title, desc, onclick) {
        var row = "<li>" +
                "<a href='" + link + "'" + (onclick == null ? "" : " onclick='" + onclick + "'") + ">" +
                "<h2>" + title +
                "</h2>" +
                "<p>" + desc + "</p>" +
                "</a>" +
                "</li>";
        return row;
    },

    AddImgRow: function(link, img, title, desc, onclick) {
        if (etc == null) etc = "";
        var row = "<li>" +
                "<a href='" + link + "'" + (onclick == null ? "" : " onclick='" + onclick + "'") + ">" +
                "<img src='" + img + "' />" +
                "<h2>" + title + "</h2>" +
                "<p>" + desc + "</p>" +
                "</a>" +
                "</li>";
        return row;
    },

    AddImgSplitRow: function(link, img, title, desc, split, onclick) {
        var row = "<li>" +
                "<a href='" + link + "'" + (onclick == null ? "" : " onclick='" + onclick + "'") + ">" +
                "<img src='" + img + "' />" +
                "<h2>" + title + "</h2>" +
                "<p>" + desc + "</p>" +
                "</a>" + split + 
                "</li>";
        return row;
    },

    MoreButton: function() {
        return "<li class='more'><a href='#' style='text-align:center;' class='ui-btn' onclick='fnSelectMore();'>---- 더 보기 ----</a></li>"
    },
    
    EmptyData: function() {
        var empty = "<li><a href='#' style='text-align:center;' class='ui-btn'>데이터가 없습니다.</a></li>";
        return empty;
    }
}

var STR = {
    CheckLen: function(str) {
        /// <summary>
        /// 한글,영문 자릿수 체크
        /// </summary>
        /// <returns></returns>
        var tcount = 0;
        var tmpStr = new String(str);
        var temp = tmpStr.length;
        var onechar;
        for (k = 0; k < temp; k++) {
            onechar = tmpStr.charAt(k);
            if (escape(onechar).length > 4) {
                tcount += 2;
            }
            else {
                tcount += 1;
            }
        }
        return tcount;
    },

    ByteSubstring: function(str, st, ed) {
        var arr = [];
        var b = 0;
        for (var i = 0, m = str.length; i < m; i++) {

            if (str.charCodeAt(i) > 127) {
                arr.push(i);
                arr.push(i);
            } else {
                arr.push(i);
            }

        }
        if (arr[st] == arr[ed]) {
            return false;
        } else {
            return str.substring(arr[st], arr[ed])
        }
    },

    IsNullOrEmpty: function(str) {
        if (str == "undefined" || str == "" || str == null) {
            return true;
        }
        else {
            return false;
        }
    }
}

var NUMBER = {
    Format: function(num) {
        /// <summary>
        /// 콤마 , 찍어주기
        /// </summary>
        /// <returns></returns>
        if (num == "") return "";
        var num = String(num);
        var reg1 = /[^0-9.-]/gi;
        if (num != "") {
            if (reg1.test(num) == true) {
                num = num.replace(reg1, "");
            }
        }
        var reg = /(\-?\d+)(\d{3})($|\.\d+)/;

        if (reg.test(num)) {
            return num.replace(reg, function(str, p1, p2, p3) {
                return NUMBER.Format(p1) + "," + p2 + "" + p3;
            });
        } else {
            return num;
        }
    },
    ClearFormat: function(num) {
        /// <summary>
        /// 콤마 , 제거
        /// </summary>
        /// <returns></returns>
        if (num == "") return "";
        var num = String(num);
        var reg = /[^0-9.-]/gi;
        if (num != "") {
            if (reg.test(num) == true) {
                num = num.replace(reg, "");
            }
        }
        return num;
    }
}

var DATE = {
    Format: function(date, format) {
        /// <summary>
        /// 문자열 yyyyMMdd -> yyyy-MM-dd 변환
        /// </summary>
        /// <returns></returns>
        if (date.length != 8) return date;
        if (format == null) format = "-";
        return date.substr(0, 4) + format + date.substr(4, 2) + format + date.substr(6, 2);
    },
    ClearFormat: function(str, format) {
        /// <summary>
        /// date format string 제거 (yyyy-MM-dd -> yyyyMMdd)
        /// </summary>
        /// <returns></returns>
        if (str == null || str == "") return "";
        if (format == null) format = "-";
        return str.replace(eval("/" + format + "/g"), "");
    },
    ConvertToDate: function(strdate) {
        strdate = DATE.ClearFormat(strdate);
        var year = parseInt(strdate.substr(0, 4), 10);
        var month = parseInt(strdate.substr(4, 2), 10);
        if (isNaN(month)) month = 1;
        var day = parseInt(strdate.substr(6, 2), 10);
        if (isNaN(day)) day = 1;
        var date = new Date(year, month - 1, day);
        return date;
    }
}

// Date Format
Date.prototype.format = function(f) {
    if (!this.valueOf()) return " ";
    var weekName = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
    var d = this;
    return f.replace(/(yyyy|yy|MM|dd|E|hh|mm|ss|a\/p)/gi, function($1) {
        switch ($1) {
            case "yyyy": return d.getFullYear();
            case "yy": return (d.getFullYear() % 1000).zf(2);
            case "MM": return (d.getMonth() + 1).zf(2);
            case "dd": return d.getDate().zf(2);
            case "E": return weekName[d.getDay()];
            case "HH": return d.getHours().zf(2);
            case "hh": return ((h = d.getHours() % 12) ? h : 12).zf(2);
            case "mm": return d.getMinutes().zf(2);
            case "ss": return d.getSeconds().zf(2);
            case "a/p": return d.getHours() < 12 ? "오전" : "오후";
            default: return $1;
        }
    });
};
String.prototype.string = function(len) {
    var s = '', i = 0;
    while (i++ < len) {
        s += this;
    } return s;
};
String.prototype.zf = function(len) {
    return "0".string(len - this.length) + this;
};
Number.prototype.zf = function(len) {
    return this.toString().zf(len);
};