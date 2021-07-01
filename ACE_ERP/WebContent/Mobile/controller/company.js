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
            $("#divEdit").hide();
            $("#divSave").show();
            $("#txtDS_SAUP").addClass("ui-editable").removeAttr("readonly");
            $("#txtDS_SAUPADDR").addClass("ui-editable").removeAttr("readonly");
            $("#txtNO_ZIP").addClass("ui-editable").removeAttr("readonly");
            $("#txtNO_SAUPTEL").addClass("ui-editable").removeAttr("readonly");
            $("#txtDS_NAME").addClass("ui-editable").removeAttr("readonly");
            break;
        default:
            $("#divEdit").show();
            $("#divSave").hide();
            $("#txtDS_SAUP").removeClass("ui-editable").attr("readonly", true);
            $("#txtDS_SAUPADDR").removeClass("ui-editable").attr("readonly", true);
            $("#txtNO_ZIP").removeClass("ui-editable").attr("readonly", true);
            $("#txtNO_SAUPTEL").removeClass("ui-editable").attr("readonly", true);
            $("#txtDS_NAME").removeClass("ui-editable").attr("readonly", true);
            break;
    }
}

function fnSelect() {

    MOBILE.StartLoading();

    $("#listCompany li:not(:first)").remove();

    // 회사정보
    var params = [];
    AJAX.ParamAdd(params, "NO_SAUP", "");
    AJAX.ParamAdd(params, "TY_GUBUN", "1");

    var data = {};
    data.SP = "DZZPR_COMPANY_SELECT";
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
                var title = result.data[i].DS_SAUP + "&nbsp;&nbsp;<span style='color:#aaa;'>[" + result.data[i].DS_CORP + "]</span>";
                var desc = result.data[i].NO_CORP;
                var onclick = "fnSetDetail(" + i + ");";
                html += LISTVIEW.AddRow("#pageCompanyDetail", title, desc, onclick);
            }

            $("#listCompany").append(html);
        }
        else {
            $("#listCompany").append(LISTVIEW.EmptyData());
        }

        $("#listCompany li:first").removeClass("ui-screen-hidden");
        $("#listCompany").listview("refresh");

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
        $("#hdnCD_CORP").val(gData[i].CD_CORP);
        $("#hdnNO_ID").val(gData[i].NO_ID);
        $("#hdnDT_OPEN").val(gData[i].DT_OPEN);
        $("#hdnDT_CLOSE").val(gData[i].DT_CLOSE);
        $("#hdnRM_REASON").val(gData[i].RM_REASON);
        $("#hdnDS_UPTAE").val(gData[i].DS_UPTAE);
        $("#hdnDS_UPJONG").val(gData[i].DS_UPJONG);
    
        $("#txtDS_CORP").val(gData[i].DS_CORP);
        $("#txtNO_CORP").val(gData[i].NO_CORP);
        $("#txtNO_SAUP").val(gData[i].NO_SAUP);
        $("#txtDS_SAUP").val(gData[i].DS_SAUP);
        $("#txtDS_SAUPADDR").val(gData[i].DS_SAUPADDR);
        $("#txtNO_ZIP").val(gData[i].NO_ZIP);
        $("#txtNO_SAUPTEL").val(gData[i].NO_SAUPTEL);
        $("#txtDS_NAME").val(gData[i].DS_NAME);
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
    data.UPDATESP = "DZZPR_COMPANY_UPDATE";
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