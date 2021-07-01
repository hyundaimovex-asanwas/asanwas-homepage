var gData = null;
var gIdx = null;
var gDT_ACCOUNT = null;
var gSaveGubun = "I";

var gFilePath = "/DS/";

function fnInitPage(obj) {

    // pageNomu ///////////////////////////////////////////
    if ($.cookie("CD_SITE") != null) {
        $("#hdnCD_SITE").val($.cookie("CD_SITE"));
        $("#spDS_SITE").text($.cookie("DS_SITE"));
    }
    
    $("#btnSite").click(function() {
        $(":mobile-pagecontainer").pagecontainer("change", "/mobile/codefind/site.html");
    });

    $("#btnEmployee").click(function() {
        if ($("#hdnCD_SITE").val() == "") {
            alert("현장을 선택하세요.");
            return;
        }
        $(":mobile-pagecontainer").pagecontainer("change", "/mobile/codefind/employee.html", { transition: "pop" });
    });
    
    $("#btnSearch").click(function() {
        if ($("#hdnCD_SITE").val() == "") {
            alert("현장을 선택하세요.");
            return;
        }
        fnSelect();
    });

    $("#btnNew").click(function() {
        gSaveGubun = "I";

        $(":mobile-pagecontainer").pagecontainer("change", "#pageNomuDetail");
        fnClear();
        fnSetForm("I");
    });

    // pageNomuDetail ////////////////////////////////////
    gDT_ACCOUNT = $("#btnDT_ACCOUNT", obj).mobipick();
    gDT_ACCOUNT.on("change", function() {
        $("#txtDT_ACCOUNT").val($(this).val());
    });
    
    $("#btnEdit").click(function() {
        $(document).scrollTop(0);
        gSaveGubun = "U";
        fnSetForm("U");
    });

    $("#btnDelete").click(function() {
        if (confirm("삭제하시겠습니까?")) {
            fnSave("D");
        }
    });

    $("#btnSave").click(function() {
        $(document).scrollTop(0);
        fnUpload();
    });

    $("#btnCancel").click(function() {
        if (gSaveGubun == "I") {
            $(":mobile-pagecontainer").pagecontainer("change", "#pageNomu");
        }
        else {
            fnSetDetail(gIdx);
            fnSetForm();
        }
    });
    
    $("#txtDT_ACCOUNT").click(function() {
        if (!$(this).hasClass('ui-readonly')) {
            gDT_ACCOUNT.mobipick("open");
        }
    });

    $("#cboTY_ACCOUNT").on("change", function() {
        $("#txtTY_ACCOUNT").val($("#cboTY_ACCOUNT option:selected").text());
    });
    
    $("#txtAM_ACCOUNT").on("change", function() {
        var num = NUMBER.Format($(this).val());
        $(this).val(num);
    }).on("focus", function() {
        var num = NUMBER.ClearFormat($(this).val());
        $(this).val(num);
    });


    // 비동기 파일전송 설정
    AJAX.FileUploadSet("form1", fnSave);
    
    $("#file1").on("change", handleFileSelect);
    $("#file2").on("change", handleFileSelect2);

    CODEFIND.Site();
    CODEFIND.Employee();

    //fnSelect();
}

function fnNewData() {

    gSaveGubun = "I";
    fnClear();
    fnSetForm("I");
}

function fnSetSite(code, text) {
    $("#hdnCD_SITE").val(code);
    $("#spDS_SITE").text(text);

    $.cookie("CD_SITE", code, { expires: 30, path: '/' });
    $.cookie("DS_SITE", text, { expires: 30, path: '/' });
}

function fnSetEmployee(code, text) {
    $("#hdnNO_ID").val(code);
    $("#spDS_NAME").text(text);
}

function fnSetForm(mode) {
    switch (mode) {
        case "I":
            $(".divView").hide();
            $(".divEdit").show();
            $(".divFile").show();
            $("#txtTITLE").removeAttr("readonly");
            $("#txtAM_ACCOUNT").removeAttr("readonly");
            $("#txtDS_ACCOUNT").removeAttr("readonly");
            $("#txtDT_ACCOUNT").removeClass("ui-readonly");
            break;
        case "U":
            $(".divView").hide();
            $(".divEdit").show();
            $(".divFile").show();
            $("#txtTITLE").removeAttr("readonly");
            $("#txtAM_ACCOUNT").removeAttr("readonly");
            $("#txtDS_ACCOUNT").removeAttr("readonly");
            $("#txtDT_ACCOUNT").addClass("ui-readonly");
            break;
        default:
            $(".divView").hide();
            $(".divEdit").show();
            $(".divFile").show();
            $("#txtTITLE").removeAttr("readonly");
            $("#txtAM_ACCOUNT").removeAttr("readonly");
            $("#txtDS_ACCOUNT").removeAttr("readonly");
            $("#txtDT_ACCOUNT").addClass("ui-readonly");
            break;
    }
}

function fnClear() {
    arr_file = [];
    arr_info = [];
    arr_type = [];
    new_file = [];
    
    $(".ui-field-contain input, .ui-field-contain textarea").val("");
    $("#file1, #file2").val("");
    $("#imgPreview, #imgPreview2").html("");
}

function fnSelect() {
    
    MOBILE.StartLoading();

    $("#listNomu li:not(:first)").remove();

    var params = [];
    AJAX.ParamAdd(params, "TY_GUBUN", "1");
    AJAX.ParamAdd(params, "CN_ROW", 100, "Int");
    AJAX.ParamAdd(params, "VALUE", $("#ctxtDS_NAME").val());
    AJAX.ParamAdd(params, "MIN_VALUE", "");
    AJAX.ParamAdd(params, "CD_SITE", $("#hdnCD_SITE").val());

    var data = {};
    data.SP = "DSAPR_EMPLOYEE_M";
    data.PARAMS = params;

    // 비동기 호출
    var result = AJAX.Select(data, true, fnSuccess, fnError);

}

function fnSuccess(result) {
    if (result.success) {
        var html = "";
        gData = result.data;
        if (result.data.length > 0) {
            for (var i = 0; i < result.data.length; i++) {
                var title = result.data[i].DS_NAME + "&nbsp;&nbsp;<span style='color:#aaa;'>[" + result.data[i].TY_CHAIYONG + "]</span>";
                var desc = result.data[i].NO_ID;
                var onclick = "fnSetDetail(" + i + ");";
                html += LISTVIEW.AddRow("#pageNomuDetail", title, desc, onclick);
            }

            $("#listNomu").append(html);
        }
        else {
            $("#listNomu").append(LISTVIEW.EmptyData());
        }

        $("#listNomu li:first").removeClass("ui-screen-hidden");
        $("#listNomu").listview("refresh");

        MOBILE.EndLoading();
    }
    else {
        MOBILE.EndLoading();
        alert(result.msg);
    }
}

function fnError(result) {
    MOBILE.EndLoading();
    if (!STR.IsNullOrEmpty(result.msg))
        alert(result.msg);
}

function fnSetDetail(i) {
    gIdx = i;
    fnSetForm();

    fnClear();
    if (gData.length > 0) {
        $("#txtDS_NAME").val(gData[i].DS_NAME);
        $("#txtNO_ID").val(gData[i].NO_ID);
        $("#txtTY_CHAIYONG").val(gData[i].TY_CHAIYONG);
        $("#txtDT_IPSA").val(gData[i].DT_IPSA);

        if (gData[i].IMG_1 != "") {
            var img = document.createElement('img');
            img.src = gData[i].IMG_1;
            img.style.width = "100%";
            $("#imgPreview").append(img);
        }
        if (gData[i].IMG_2 != "") {
            var img2 = document.createElement('img');
            img2.src = gData[i].IMG_2;
            img2.style.width = "100%";
            $("#imgPreview2").append(img2);
        }
        
        /*
        var img_path = gData[i].IMG_PATH;
        org_file = img_path.split(',');
        for (var x = 0; x < org_file.length; x++) {
            var img = document.createElement('img');
            img.src = org_file[x];
            img.style.width = "100%";
            
            $("#imgPreview").append(img);

        }
        */
    }
}

function fnSave(result) {
    new_file = [];
    var spl = result.msg.split('/');
    for (var s = 0; s < spl.length; s++) {
        if (spl[s] == "") continue;
        new_file.push(spl[s]);
    }
    
    var arr = [];
    for (var i = 0; i < arr_file.length; i++) {
        var params = [];

        AJAX.ParamAdd(params, "CD_SITE", $("#hdnCD_SITE").val());
        AJAX.ParamAdd(params, "NO_ID", DATE.ClearFormat($("#txtNO_ID").val()));
        AJAX.ParamAdd(params, "NM_FILE", new_file[i]);
        AJAX.ParamAdd(params, "DS_PATH", "/DS/" + DATE.ClearFormat($("#txtNO_ID").val()) + "/");
        AJAX.ParamAdd(params, "RM_BIGO", arr_type[i]);
        AJAX.ParamAdd(params, "ID_INSERT", MOBILE.GetCookie("ID_USER"));

        var data = {};
        data.INSERTSP = "DSAPR_EMPLOYEE_FILES_INSERT";
        data.DELETESP = "";
        data.UPDATESP = "";
        data.SAVEGUBUN = "I";
        data.PARAMS = params;

        arr.push(data);
    }
    var result = AJAX.MultiSave(arr);

    if (result.success) {

        alert("저장되었습니다.");
        
        fnSelect();

        fnSetForm();
    }
    else {
        alert(result.msg);
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// File Upload 모듈
/////////////////////////////////////////////////////////////////////////////////////////////////
var arr_file = [];
var arr_info = [];
var arr_type = [];
var new_file = [];
//var org_file = [];
//var chg_file = false;
//var chg_file2 = false;

function handleFileSelect(evt) {

    var files = evt.target.files; 

    for (var i = 0, f; f = files[i]; i++) {
//        if (!f.type.match('image.*')) {
//            continue;
//        }

        var file = {
            name: f.name,
            size: f.size,
            type: f.type
        }

        arr_info.push(file);
        arr_type.push("신분증");
        
        var reader = new FileReader();

        reader.onload = (function(theFile) {
            return function(e) {
                var img = document.createElement('img');

                img.src = e.target.result;
                img.style.width = "100%";

                //if (!chg_file) {
                    $("#imgPreview img").remove();
                    //chg_file = true;
                //}
                $("#imgPreview").append(img);

                var spl = e.target.result.split(",");
                arr_file.push(e.target.result);
            };
        })(f);

        reader.readAsDataURL(f);
    }
}

function handleFileSelect2(evt) {

    var files = evt.target.files;

    for (var i = 0, f; f = files[i]; i++) {
        if (!f.type.match('image.*')) {
            continue;
        }

        var file = {
            name: f.name,
            size: f.size,
            type: f.type
        }

        arr_info.push(file);
        arr_type.push("통장");

        var reader = new FileReader();

        reader.onload = (function(theFile) {
            return function(e) {
                var img = document.createElement('img');

                img.src = e.target.result;
                img.style.width = "100%";

                //if (!chg_file2) {
                $("#imgPreview2 img").remove();
                //chg_file2 = true;
                //}
                $("#imgPreview2").append(img);

                var spl = e.target.result.split(",");
                arr_file.push(e.target.result);
            };
        })(f);

        reader.readAsDataURL(f);
    }
}

function fnUpload() {    
    var frm = $("#form1");
    frm.attr("action", "/mobile/model/Ajax_File_Upload.aspx?path=" + gFilePath + DATE.ClearFormat($("#txtNO_ID").val()));
    frm.submit();
    
//    var xhr, provider;

//    xhr = $.ajaxSettings.xhr();
////    if (xhr.upload) {
////        xhr.upload.addEventListener('progress', function(e) {
////            if (e.lengthComputable) {
////                var percentage = Math.round((e.loaded * 100) / e.total);
////            }
////        }, false);
////    }
//    provider = function() {
//        return xhr;
//    };

//    new_file = [];
//    for (var i = 0; i < arr_file.length; i++) {
//        AJAX.FileUpload(provider, gFilePath + DATE.ClearFormat($("#txtNO_ID").val()), arr_info[i], arr_file[i], fnUploadSuccess, fnUploadError);
//    }

//    if (new_file.length == arr_info.length) {
//        return true;
//    }
//    else {
//        return false;
//    }
}

function fnUploadSuccess(result) {
    if (result.success) {
        new_file.push(result.msg);
    }
    else {
        alert(result.msg);
    }
}

function fnUploadError(result) {
    alert(reuslt.msg);
}
