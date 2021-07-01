var gData = null;
var gIdx = null;
var gSaveGubun = "I";

function fnInitPage() {
    $("#btnEdit").click(function() {
    $(document).scrollTop(0);
    gSaveGubun = "U";
    fnSetForm("U");
    });

    $("#btnSave").click(function() {
        fnSetForm();
        fnSave(gSaveGubun);
    });

    $("#btnCancel").click(function() {
        fnSetDetail(gIdx);
        fnSetForm();
    });

    $("#btnDelete").click(function() {
        if (confirm("삭제하시겠습니까?")) {
            fnSave("D");
        }
    });

//    $("#cboYN_USE").on("change", function() {
//    $("#txtYN_USE").val($("#cboYN_USE option:selected").text());
//    });

//    $("#cboYN_MENU").on("change", function() {
//    $("#txtYN_MENU").val($("#cboYN_MENU option:selected").text());
//    });

//    $("#cboNO_LEVEL").on("change", function() {
//    $("#txtNO_LEVEL").val($("#cboNO_LEVEL option:selected").text());
//    });

    fnSelect();
}

function fnNewData() {

    gSaveGubun = "I";

    //$(":mobile-pagecontainer").pagecontainer("change", "#pageforminfoDetail");
    //fnClear();
    fnSetForm("I");
}

function fnSetForm(mode) {
    switch (mode) {
        case "I":
            $(".divView").hide();
            $(".divEdit").show();
            $("#txtID_FORM").addClass("ui-editable").removeAttr("readonly");
            $("#txtDS_FORM").addClass("ui-editable").removeAttr("readonly");
            $("#txtPATH").addClass("ui-editable").removeAttr("readonly");
            $("#txtSN_NO").addClass("ui-editable").removeAttr("readonly");
            $("#txtDS_ICON").addClass("ui-editable").removeAttr("readonly");
            break;
        case "U":
            $(".divView").hide();
            $(".divEdit").show();
            //$("#txtID_FORM").addClass("ui-editable").removeAttr("readonly");
            $("#txtDS_FORM").addClass("ui-editable").removeAttr("readonly");
            $("#txtPATH").addClass("ui-editable").removeAttr("readonly");
            $("#txtSN_NO").addClass("ui-editable").removeAttr("readonly");
            $("#txtDS_ICON").addClass("ui-editable").removeAttr("readonly");
            break;
        default:
            $(".divView").show();
            $(".divEdit").hide();
        
            $("#txtDS_FORM").removeClass("ui-editable").attr("readonly", true);
            $("#txtPATH").removeClass("ui-editable").attr("readonly", true);
            $("#txtSN_NO").removeClass("ui-editable").attr("readonly", true);
            $("#txtDS_ICON").removeClass("ui-editable").attr("readonly", true);
            break;
    }
}

function fnSelect() {

    MOBILE.StartLoading();

    $("#listforminfo li:not(:first)").remove();

    // 회사정보
    var params = [];
   // AJAX.ParamAdd(params, "NO_SAUP", "");
    AJAX.ParamAdd(params, "DS_FORM", "");

    var data = {};
    data.SP = "DZZPR_M_MENU_SELECT";
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
                var title = result.data[i].DS_FORM + "&nbsp;&nbsp;<span style='color:#aaa;'>[" + result.data[i].NO_LEVEL + "]</span>";
                var desc = result.data[i].PATH;
                var onclick = "fnSetDetail(" + i + ");";
                html += LISTVIEW.AddRow("#pageforminfoDetail", title, desc, onclick);
            }

            $("#listforminfo").append(html);
        }
        else {
            $("#listforminfo").append(LISTVIEW.EmptyData());
        }

        $("#listforminfo li:first").removeClass("ui-screen-hidden");
        $("#listforminfo").listview("refresh");

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

    if (gData.length > 0) {
        $("#txtID_FORM").val(gData[i].ID_FORM);
        var value = gData[i].DS_FORM;
        value = value.replace("--->", "");

        $("#txtDS_FORM").val(value);
        $("#txtPATH").val(gData[i].PATH);
        $("#txtSN_NO").val(gData[i].SN_NO);
        $("#txtDS_ICON").val(gData[i].DS_ICON);


        $("#txtYN_USE").val(gData[i].YN_USE);
       
       // $("#cboYN_USE").val(gData[i].YN_USE);
        $("#txtYN_MENU").val(gData[i].YN_MENU);
        $("#cboYN_MENU").val(gData[i].YN_MENU).selectmenu("refresh");
        $("#txtNO_LEVEL").val(gData[i].NO_LEVEL);
        $("#cboNO_LEVEL").val(gData[i].NO_LEVEL).selectmenu("refresh");   
    }
}

function fnSave(sGubun) {
    var params = [];
  
    if (sGubun == "I" || sGubun == "U" || sGubun == "D") {
        AJAX.ParamAdd(params, "ID_FORM", $("#txtID_FORM").val());
    }
    if (sGubun == "I" || sGubun == "U") {
        AJAX.ParamAdd(params, "DS_FORM", $("#txtDS_FORM").val());
        AJAX.ParamAdd(params, "PATH", $("#txtPATH").val());
        AJAX.ParamAdd(params, "YN_USE", $("#cboYN_USE").find(":selected").val());
        AJAX.ParamAdd(params, "YN_MENU", $('#cboYN_MENU').find(":selected").val());
        AJAX.ParamAdd(params, "SN_NO", $("#txtSN_NO").val());
        AJAX.ParamAdd(params, "NO_LEVEL", $("#cboNO_LEVEL").find(":selected").val());
        AJAX.ParamAdd(params, "DS_ICON", $("#txtDS_ICON").val());
    }

    var data = {};
    data.INSERTSP = "DZZPR_M_MENU_INSERT";
    data.DELETESP = "DZZPR_M_MENU_DELETE";
    data.UPDATESP = "DZZPR_M_MENU_UPDATE";
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
            $(":mobile-pagecontainer").pagecontainer("change", "#pageFORMINFO");
        }
        else {
            fnSetForm();
        }
    }
    else {
        alert(result.msg);
    }
}