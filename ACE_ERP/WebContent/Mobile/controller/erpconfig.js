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
            $("#txtCD_VALUE").addClass("ui-editable").removeAttr("readonly");
            $("#txtDS_BIGO").addClass("ui-editable").removeAttr("readonly");
            break;
        default:
            $("#divEdit").show();
            $("#divSave").hide();
            $("#txtCD_VALUE").removeClass("ui-editable").attr("readonly", true);
            $("#txtDS_BIGO").removeClass("ui-editable").attr("readonly", true);
        
         break;
    }
}

function fnSelect() {

    MOBILE.StartLoading();

    $("#listerpconfig li:not(:first)").remove();

    // 회사정보
    var params = [];
    AJAX.ParamAdd(params, "CD_SYSTEM", "");
   
    var data = {};
    data.SP = "DZZPR_CONFIGMGR_SELECT";
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
                var title = result.data[i].CD_CODE + "&nbsp;&nbsp;<span style='color:#aaa;'>[" + result.data[i].DS_SYSTEM + "]</span>";
                var desc = result.data[i].CD_VALUE;
                var onclick = "fnSetDetail(" + i + ");";
                html += LISTVIEW.AddRow("#pageerpconfigDetail", title, desc, onclick);
            }

            $("#listerpconfig").append(html);
        }
        else {
            $("#listerpconfig").append(LISTVIEW.EmptyData());
        }

        $("#listerpconfig li:first").removeClass("ui-screen-hidden");
        $("#listerpconfig").listview("refresh");

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
        $("#hdnCD_SYSTEM").val(gData[i].CD_SYSTEM);
        $("#hdnYN_SYSTEM").val(gData[i].YN_SYSTEM);

        $("#txtDS_SYSTEM").val(gData[i].DS_SYSTEM);
        $("#txtCD_CODE").val(gData[i].CD_CODE);
        $("#txtCD_VALUE").val(gData[i].CD_VALUE);
        $("#txtDS_BIGO").val(gData[i].DS_BIGO);
   
    }
}

function fnSave() {
    var params = [];
    AJAX.ParamAdd(params, "CD_SYSTEM", $("#hdnCD_SYSTEM").val());
    AJAX.ParamAdd(params, "CD_CODE", $("#txtCD_CODE").val());
    AJAX.ParamAdd(params, "CD_VALUE", $("#txtCD_VALUE").val());
    AJAX.ParamAdd(params, "YN_SYSTEM", $("#hdnYN_SYSTEM").val());
    AJAX.ParamAdd(params, "DS_BIGO", $("#txtDS_BIGO").val());
    AJAX.ParamAdd(params, "ID_UPDATE", "ERPADMIN");
      
    var data = {};
    data.INSERTSP = "";
    data.DELETESP = "";
    data.UPDATESP = "DZZPR_CONFIG_UPDATE";
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