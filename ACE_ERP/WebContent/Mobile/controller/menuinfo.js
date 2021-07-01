var gData = null;
var gIdx = null;

function fnInitPage() {
    $("#btnEdit").click(function() {
        fnSetForm("U");
    });

    $("#btnSave").click(function() {
        fnSetForm();
        fnSave();
    });

    $("#btnCancel").click(function() {
        fnSetDetail(gIdx);
        fnSetForm();
    });

    fnSelect();
}

function fnSetForm(mode) {
    switch (mode) {
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

    $("#listmenuinfo li:not(:first)").remove();

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
                var title = result.data[i].DS_FORM + "&nbsp;&nbsp;<span style='color:#aaa;'>[" + result.data[i].ID_FORM + "]</span>";
                var desc = result.data[i].PATH;
                var onclick = "fnSetDetail(" + i + ");";
                html += LISTVIEW.AddRow("#pagemenuinfoDetail", title, desc, onclick);
            }

            $("#listmenuinfo").append(html);
        }
        else {
            $("#listmenuinfo").append(LISTVIEW.EmptyData());
        }

        $("#listmenuinfo li:first").removeClass("ui-screen-hidden");
        $("#listmenuinfo").listview("refresh");

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
        $("#txtDS_FORM").val(gData[i].DS_FORM);
        $("#txtPATH").val(gData[i].PATH);
        $("#txtSN_NO").val(gData[i].SN_NO);
        $("#txtDS_ICON").val(gData[i].DS_ICON);


        $("#txtYN_USE").val(gData[i].YN_USE);
        $("#txtYN_MENU").val(gData[i].YN_MENU);
        $("#txtNO_LEVEL").val(gData[i].NO_LEVEL);   
    }
}

function fnSave() {
    var params = [];
    AJAX.ParamAdd(params, "CD_CORP", $("#hdnCD_CORP").val());
    AJAX.ParamAdd(params, "NO_CORP", $("#txtNO_CORP").val());
    AJAX.ParamAdd(params, "NO_SAUP", $("#txtNO_SAUP").val());
    AJAX.ParamAdd(params, "DS_SAUP", $("#txtDS_SAUP").val());
    AJAX.ParamAdd(params, "DS_SAUPADDR", $("#txtDS_SAUPADDR").val());
    AJAX.ParamAdd(params, "NO_ZIP", $("#txtNO_ZIP").val());
    AJAX.ParamAdd(params, "NO_SAUPTEL", $("#txtNO_SAUPTEL").val());
    AJAX.ParamAdd(params, "DS_NAME", $("#txtDS_NAME").val());
    AJAX.ParamAdd(params, "NO_ID", $("#hdnNO_ID").val());
    AJAX.ParamAdd(params, "DT_OPEN", $("#hdnDT_OPEN").val());
    AJAX.ParamAdd(params, "DT_CLOSE", $("#hdnDT_CLOSE").val());
    AJAX.ParamAdd(params, "RM_REASON", $("#hdnRM_REASON").val());
    AJAX.ParamAdd(params, "DS_UPTAE", $("#hdnDS_UPTAE").val());
    AJAX.ParamAdd(params, "DS_UPJONG", $("#hdnDS_UPJONG").val());
    AJAX.ParamAdd(params, "CD_BUMUN", "");
    AJAX.ParamAdd(params, "CD_GROUP", "");
    AJAX.ParamAdd(params, "DS_DESC", "");
    
    var data = {};
    data.INSERTSP = "";
    data.DELETESP = "";
    data.UPDATESP = "DZZPR_menuinfo_UPDATE";
    data.SAVEGUBUN = "U";
    data.PARAMS = params;

    var result = AJAX.Save(data);

    if (result.success) {
        alert("저장되었습니다.");
        fnSetForm();
        fnSelect();
    }
    else {
        alert(result.msg);
    }
}