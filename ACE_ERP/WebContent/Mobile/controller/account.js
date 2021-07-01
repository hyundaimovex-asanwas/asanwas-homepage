var gData = null;
var gIdx = null;
var gDT_ACCOUNT = null;
var gSaveGubun = "I";

function fnInitPage(obj) {

    // pageAccount ///////////////////////////////////////////
    $("#stxtDT_ACCOUNT", obj).mobipick();
    
    $("#stxtDT_ACCOUNT").on("change", function() {
        fnSelect();
    });

    $("#btnNew").click(function() {
        gSaveGubun = "I";

        $(":mobile-pagecontainer").pagecontainer("change", "#pageAccountDetail");
        fnClear();
        fnSetForm("I");
    });

    // pageAccountDetail ////////////////////////////////////
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
        fnSave(gSaveGubun);
    });

    $("#btnCancel").click(function() {
        if (gSaveGubun == "I") {
            $(":mobile-pagecontainer").pagecontainer("change", "#pageAccount");
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

    $("#files").on("change", handleFileSelect);

    CODEFIND.Dept();
    CODEFIND.Vendor();

    fnSelect();
}

function fnNewData() {

    gSaveGubun = "I";
    fnClear();
    fnSetForm("I");
}

function fnSetDept(code, text) {
    $("#hdnCD_DEPT").val(code);
    $("#txtDS_DEPT, #spDS_DEPT").text(text);
}

function fnSetVendor(code, text) {
    $("#hdnCD_VENDOR").val(code);
    $("#txtDS_DEPT, #spDS_VENDOR").text(text);
}

function fnSetForm(mode) {
    switch (mode) {
        case "I":
            $(".divView").hide();
            $(".divEdit").show();
            $("#divFile").show();
            $("#txtTITLE").removeAttr("readonly");
            $("#txtAM_ACCOUNT").removeAttr("readonly");
            $("#txtDS_ACCOUNT").removeAttr("readonly");
            $("#txtDT_ACCOUNT").removeClass("ui-readonly");
            break;
        case "U":
            $(".divView").hide();
            $(".divEdit").show();
            $("#divFile").show();
            $("#txtTITLE").removeAttr("readonly");
            $("#txtAM_ACCOUNT").removeAttr("readonly");
            $("#txtDS_ACCOUNT").removeAttr("readonly");
            $("#txtDT_ACCOUNT").addClass("ui-readonly");
            break;
        default:
            $(".divView").show();
            $(".divEdit").hide();
            $("#divFile").hide();
            $("#txtTITLE").attr("readonly", true);
            $("#txtAM_ACCOUNT").attr("readonly", true);
            $("#txtDS_ACCOUNT").attr("readonly", true);
            $("#txtDT_ACCOUNT").addClass("ui-readonly");
            break;
    }
}

function fnClear() {
    $(".ui-field-contain input, .ui-field-contain textarea").val("");
    $("#files").val("");
    $("#imgPreview").html("");
    $("#spDS_DEPT").text("부서선택");
    $("#spDS_VENDOR").text("업체선택");
    $("#txtDT_ACCOUNT").val((new Date()).format("yyyy-MM-dd"));
}

function fnSelect() {
    
    MOBILE.StartLoading();

    $("#listAccount li:not(:first)").remove();
    
    var params = [];
    AJAX.ParamAdd(params, "ID_USER", MOBILE.GetCookie("ID_USER"));
    AJAX.ParamAdd(params, "CD_DEPT", "");
    AJAX.ParamAdd(params, "DT_ACCOUNT", DATE.ClearFormat($("#stxtDT_ACCOUNT").val()));

    var data = {};
    data.SP = "DZZPR_ACCOUNT_SELECT_M";
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
                var title = result.data[i].TITLE + "&nbsp;&nbsp;<span style='color:#aaa;'>[" + DATE.Format(result.data[i].DT_ACCOUNT) + "]</span>";
                var desc = NUMBER.Format(result.data[i].AM_ACCOUNT);
                var onclick = "fnSetDetail(" + i + ");";
                html += LISTVIEW.AddRow("#pageAccountDetail", title, desc, onclick);
            }

            $("#listAccount").append(html);
        }
        else {
            $("#listAccount").append(LISTVIEW.EmptyData());
        }

        $("#listAccount li:first").removeClass("ui-screen-hidden");
        $("#listAccount").listview("refresh");

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
        $("#hdnNO_SEQ").val(gData[i].NO_SEQ);

        $("#txtTITLE").val(gData[i].TITLE);
        $("#cboTY_ACCOUNT").val(gData[i].TY_ACCOUNT).selectmenu("refresh");
        $("#txtTY_ACCOUNT").val(gData[i].DS_TY_ACCOUNT);
        $("#txtAM_ACCOUNT").val(NUMBER.Format(gData[i].AM_ACCOUNT));
        $("#txtDT_ACCOUNT").val(DATE.Format(gData[i].DT_ACCOUNT));
        $("#txtDS_ACCOUNT").val(gData[i].DS_ACCOUNT);

        $("#hdnCD_DEPT").val(gData[i].CD_DEPT);
        $("#txtDS_DEPT").val(gData[i].DS_DEPT_ACNT);
        $("#spDS_DEPT").text(gData[i].DS_DEPT_ACNT);

        $("#hdnCD_VENDOR").val(gData[i].CD_VENDOR);
        $("#txtDS_VENDOR").val(gData[i].DS_VENDOR);
        $("#spDS_VENDOR").text(gData[i].DS_VENDOR);
        
        var img_path = gData[i].IMG_PATH;
        org_file = img_path.split(',');
        for (var x = 0; x < org_file.length; x++) {
            var img = document.createElement('img');
            img.src = org_file[x];
            img.style.width = "100%";
            
            $("#imgPreview").append(img);

        }
    }
}

function fnSave(sGubun) {
    if (fnUpload()) {
        var params = [];
        
        if(sGubun == "U" || sGubun == "D") {
            AJAX.ParamAdd(params, "NO_SEQ", $("#hdnNO_SEQ").val(), "Int");
        }
        if (sGubun == "I" || sGubun == "U") {
            AJAX.ParamAdd(params, "TITLE", $("#txtTITLE").val());
            AJAX.ParamAdd(params, "CD_DEPT", $("#hdnCD_DEPT").val());
            AJAX.ParamAdd(params, "ID_USER", MOBILE.GetCookie("ID_USER"));
            AJAX.ParamAdd(params, "DT_ACCOUNT", (new Date()).format("yyyyMMdd"));
            AJAX.ParamAdd(params, "TY_ACCOUNT", $("#cboTY_ACCOUNT").val());
            AJAX.ParamAdd(params, "AM_ACCOUNT", NUMBER.ClearFormat($("#txtAM_ACCOUNT").val()), "BigInt");
            AJAX.ParamAdd(params, "CD_VENDOR", $("#hdnCD_VENDOR").val());
            AJAX.ParamAdd(params, "DS_ACCOUNT", $("#txtDS_ACCOUNT").val());
            if (new_file.length > 0)
                AJAX.ParamAdd(params, "IMG_PATH", new_file.join(','));
            else
                AJAX.ParamAdd(params, "IMG_PATH", org_file.join(','));
        }
        
        var data = {};
        data.INSERTSP = "DZZPR_ACCOUNT_INSERT_M";
        data.DELETESP = "DZZPR_ACCOUNT_DELETE_M";
        data.UPDATESP = "DZZPR_ACCOUNT_UPDATE_M";
        data.SAVEGUBUN = sGubun;
        data.PARAMS = params;

        var result = AJAX.Save(data);

        if (result.success) {

            if (sGubun == "D") {
                alert("삭제되었습니다.");
            } else {
                alert("저장되었습니다.");
            }
            
            fnSelect();

            if (sGubun == "I" || sGubun == "D") {
                $(":mobile-pagecontainer").pagecontainer("change", "#pageAccount");
            }
            else {
                fnSetForm();
            }
        }
        else {
            alert(result.msg);
        }
    }
    else {
        alert("파일업로드에 실패했습니다.");
    }
}

/////////////////////////////////////////////////////////////////////////////////////////////////
// File Upload 모듈
/////////////////////////////////////////////////////////////////////////////////////////////////
var arr_file = [];
var arr_info = [];
var new_file = [];
var org_file = [];
var chg_file = false;

function handleFileSelect(evt) {

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
        
        var reader = new FileReader();

        reader.onload = (function(theFile) {
            return function(e) {
                var img = document.createElement('img');
                img.src = e.target.result;
                img.style.width = "100%";

                if (!chg_file) {
                    $("#imgPreview img").remove();
                    chg_file = true;
                }
                $("#imgPreview").append(img);

                arr_file.push(e.target.result);
            };
        })(f);

        reader.readAsDataURL(f);
    }
}

function fnUpload() {
    var xhr, provider;

    xhr = $.ajaxSettings.xhr();
    if (xhr.upload) {
        xhr.upload.addEventListener('progress', function(e) {
            if (e.lengthComputable) {
                var percentage = Math.round((e.loaded * 100) / e.total);
            }
        }, false);
    }
    provider = function() {
        return xhr;
    };

    new_file = [];
    for (var i = 0; i < arr_file.length; i++) {
        AJAX.FileUpload(provider, "/Mobile/Account", arr_info[i], arr_file[i], fnUploadSuccess, fnUploadError);
    }

    if (new_file.length == arr_info.length) {
        return true;
    }
    else {
        return false;
    }
}

function fnUploadSuccess(result) {
    if (result.success) {
        new_file.push("/Mobile/Account/" + result.msg);
    }
    else {
        alert(result.msg);
    }
}

function fnUploadError(result) {
    alert(reuslt.msg);
}
