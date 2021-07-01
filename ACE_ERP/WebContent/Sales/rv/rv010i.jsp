<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�     : ��ǰ��ݰ��� 
 * ���α׷�ID   : RV020I
 * J  S  P      : rv020i
 * �� �� ��        : Rv020I
 * �� �� ��        : ������
 * �� �� ��        : 2006-05-16
 * �������     : ��ǰ ��� ���� (��ȸ ��� ���� ����)
 * ��������     : ���(function) ����
 * �� �� ��        : �迵��
 * ������������ : 2006-05-22 
 * 				ȭ������λ� ��� ����
 * 				�̺�Ʈ ����
 * 				ȭ�鱸�� ����
 * 				�˻����Ƕ� �ڵ� ���ֱ� ��� 
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-11-05][�ɵ���] �˻����� �߰� / ���� : �������, ������� 
 						����/���� ����ϴ� �͸� �ҷ�����.. ��.. 
 * [2008-07-23][�ɵ���] �˻����� ���� �޺��� ����ϴ� �͸� �ҷ�����.
 * [2017-02-17][�ɵ���] ���� ����ȭ
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
    java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    //date.set(java.util.Calendar.HOUR_OF_DAY, 240);
    String firstday = m_today.format(date.getTime());
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
        
<%
/*=============================================================================
                Developer Java Script
=============================================================================*/
%>      
<script language="javascript">
    var var_saup    = "";   //����
    var var_upjang  = "";   //����
    var var_season  = "";   //����
    var var_room    = "";   //��
    var var_age     = "";   //����
    var var_goods  = "";    //��ǰ
    
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit(); 
	}

    function fnInit(){
        cfStyleGrid(getObjectFirst("gr1"), "comn1");
        
        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds_saup.Reset(); //�����ڵ�

        ds_age.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV014&s_item1=Y";
        ds_age.Reset(); //����
        
        ds_season.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RM006&s_item1=Y";
        ds_season.Reset(); //����
        
        ds_goods.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?proType=S&dsType=2";
        ds_goods.Reset();
        
        ds_goods0.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm002H?proType=S&dsType=2";
        ds_goods0.Reset();
        
        v_date.text="<%=firstday%>";
    }

    function fnSelect() {
        var_saup    = v_saup.ValueOfIndex("SAUP_SID", v_saup.Index);        //����
        var_upjang  = v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);  //����
        var_season  = v_season.ValueOfIndex("DETAIL", v_season.Index);      //����
        var_room    = v_room.ValueOfIndex("ROOM_TYPE_SID", v_room.Index);   //��
        var_age     = v_age.ValueOfIndex("DETAIL", v_age.Index);            //����
        var_goods   = v_goods.ValueOfIndex("GOODS_SID", v_goods.Index);   //��ǰ
        
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                    + ",dsType=1"
                    + ",v_saup_sid="	+var_saup
                    + ",v_upjang_sid="	+var_upjang
                    + ",v_season="		+var_season
                    + ",v_room="		+var_room
                    + ",v_age="			+var_age
                    + ",v_date="		+v_date.text
                    + ",v_goods="		+var_goods;
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
        
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv010I", 
            "JSP(O:DS1=ds1)",
            v_param);
        tr_post(tr1);
    }

    function fnAddRow() {
        ds1.AddRow();
        
        if(ds1.CountRow==0){
            alert("��ȸ�� ���� �Ͻñ� �ٶ��ϴ�.");
            return;
        }
        ds1.NameValue(ds1.RowPosition,"SAUP_SID") = var_saup;
        ds1.NameValue(ds1.RowPosition,"UPJANG_SID") = var_upjang;
        ds1.NameValue(ds1.RowPosition,"MENU_ITEM5") = "1";
        
        gr1.SetColumn("MENU_CD");
    }
    
    function fnDeleteRow() {
        ds1.DeleteRow(ds1.RowPosition);
    }

    function fnApply() {
        if (ds1.IsUpdated) {
            if (fnChk()) {
                window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
                document.all.LowerFrame.style.visibility="visible";

                ln_TRSetting(tr_save, 
                            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv010I", 
                            "JSP(I:DS1=ds1)",
                            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
                tr_post(tr_save);
            }
        }
    }
    
    function fnCancel() {           
        ds1.undoall();
        window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";      
    }

    function fnChk() {
        for(i=1;i<=ds1.CountRow;i++) {
            if(ds1.namevalue(i,"MENU_CD")==""){
                alert("�޴��ڵ�<%=HDConstant.A_MSG_MUST_INPUT%>");
                ds1.RowPosition = i;
                gr1.setColumn("MENU_CD");
                return false;
            } else if(ds1.namevalue(i,"MENU_NM")=="") {
                alert("�޴���<%=HDConstant.A_MSG_MUST_INPUT%>");
                ds1.RowPosition = i;
                gr1.setColumn("MENU_NM");
                return false;
            }
            if(ds1.namevalue(i,"MENU_ITEM1")=="" || ds1.namevalue(i,"MENU_ITEM1_NM")=="") {
                alert("���𱸺�<%=HDConstant.A_MSG_MUST_INPUT%>");
                ds1.RowPosition = i;
                gr1.setColumn("MENU_ITEM1");
                return false;
            }
            if(ds1.namevalue(i,"MENU_ITEM2")=="" || ds1.namevalue(i,"MENU_ITEM2_NM")=="") {
                alert("����Ÿ��<%=HDConstant.A_MSG_MUST_INPUT%>");
                ds1.RowPosition = i;
                gr1.setColumn("MENU_ITEM2");
                return false;
            }
            if(ds1.namevalue(i,"MENU_ITEM3")=="" || ds1.namevalue(i,"MENU_ITEM3_NM")=="") {
                alert("���ɱ���<%=HDConstant.A_MSG_MUST_INPUT%>");
                ds1.RowPosition = i;
                gr1.setColumn("MENU_ITEM3");
                return false;
            }
            if(ds1.namevalue(i,"MENU_ITEM4")=="") {
                alert("��ǰ<%=HDConstant.A_MSG_MUST_INPUT%>");
                ds1.RowPosition = i;
                gr1.setColumn("MENU_ITEM4");
                return false;
            }
            if(ds1.namevalue(i,"BGN_DATE")=="") {
                alert("���� ��������<%=HDConstant.A_MSG_MUST_INPUT%>");
                ds1.RowPosition = i;
                gr1.setColumn("BGN_DATE");
                return false;
            }
            if(ds1.namevalue(i,"END_DATE")=="") {
                alert("���� ��������<%=HDConstant.A_MSG_MUST_INPUT%>");
                ds1.RowPosition = i;
                gr1.setColumn("END_DATE");
                return false;
            }
        }
        return true;
    }
        
</script>

<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
    if(colid=="MENU_ITEM1") {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        //arrParam[0] : head
        //arrParam[1] : detail
        //arrParam[2] : detail_nm
        //arrParam[3] : item1               
        arrParam[0] = "RM006";
        arrParam[1] = "���𱸺�"; //�����ڵ��� �����Ͱ�
        strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrResult = showModalDialog(strURL,arrParam,strPos);
        if (arrResult != undefined) {
            arrParam = arrResult.split(";");
            ds1.namevalue(ds1.rowposition,"MENU_ITEM1")=arrParam[1];
            ds1.namevalue(ds1.rowposition,"MENU_ITEM1_NM")=arrParam[2];
        }
    } else if(colid=="MENU_ITEM2") {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        arrParam[2] = v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);
        strURL = "<%=dirPath%>/Sales/help/rm001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrResult = showModalDialog(strURL,arrParam,strPos);
        if (arrResult != undefined) {
            arrParam = arrResult.split(";");
            ds1.namevalue(ds1.rowposition,"MENU_ITEM2")=arrParam[1];
            //ds1.namevalue(ds1.rowposition,"room_type_cd")=arrParam[1];
            ds1.namevalue(ds1.rowposition,"MENU_ITEM2_NM")=arrParam[2];
        }
    } else if(colid=="MENU_ITEM3") {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        //arrParam[0] : head
        //arrParam[1] : detail
        //arrParam[2] : detail_nm
        //arrParam[3] : item1           
        arrParam[0] = "RV014";
        arrParam[1] = "���ɱ���"; //�����ڵ��� �����Ͱ�
        strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrResult = showModalDialog(strURL,arrParam,strPos);
        if (arrResult != undefined) {
            arrParam = arrResult.split(";");
            ds1.namevalue(ds1.rowposition,"MENU_ITEM3")=arrParam[1];
            ds1.namevalue(ds1.rowposition,"MENU_ITEM3_NM")=arrParam[2];
        }
    }       
</script>

<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
    if(Row==0) {
        if(ds1.CountRow<=1) return;
        gr1.Redraw = "False";
        if(Colid=="MENU_ITEM1" || Colid=="MENU_ITEM2" || Colid=="MENU_ITEM3"){
            for(var i=2; i<=ds1.CountRow; i++){
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
                ds1.NameValue(i, Colid+"_NM") = ds1.NameValue(1, Colid+"_NM");
            }
        } else if(Colid=="MENU_NM" || Colid=="MENU_ITEM4" || Colid=="BGN_PERSONS" || Colid=="USE_YN"
            || Colid=="END_PERSONS" || Colid=="BGN_DATE" || Colid=="END_DATE" || Colid=="UNIT_AMT" || Colid=="MENU_CD"){
            for(var i=2; i<=ds1.CountRow; i++){
                ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
            }
        }
        gr1.Redraw = "True";
        return;
    }
</script>

<script language=JavaScript for=gr1 event=OnExit(Row,Colid,olddata)>
    if(Row==0) return;
    if(Colid=="MENU_ITEM1") {
        ds1.NameValue(Row, "MENU_ITEM1_NM") = "";
        for(var i=2; i<=ds_season.CountRow; i++){
            if(ds_season.NameValue(i, "DETAIL")==ds1.NameValue(Row, Colid)){
                ds1.NameValue(Row, "MENU_ITEM1_NM") = ds_season.NameValue(i, "DETAIL_NM");
                return;
            }
        }
    } else if(Colid=="MENU_ITEM2") {
        ds1.NameValue(Row, "MENU_ITEM2_NM") = "";
        for(var i=2; i<=ds_room.CountRow; i++){
            if(ds_room.NameValue(i, "ROOM_TYPE_CD")==ds1.NameValue(Row, Colid)){
                ds1.NameValue(Row, "MENU_ITEM2_NM") = ds_room.NameValue(i, "ROOM_TYPE_NM");
                return;
            }
        }
    } else if(Colid=="MENU_ITEM3") {
        ds1.NameValue(Row, "MENU_ITEM3_NM") = "";
        for(var i=2; i<=ds_age.CountRow; i++){
            if(ds_age.NameValue(i, "DETAIL")==ds1.NameValue(Row, Colid)){
                ds1.NameValue(Row, "MENU_ITEM3_NM") = ds_age.NameValue(i, "DETAIL_NM");
                return;
            }
        }
    }
</script>

<script language=JavaScript for=v_saup event=OnSelChange()>
    var v_param = "dsType=1"
                + "&proType=S"
                + "&s_SaupSid="+v_saup.ValueOfIndex("SAUP_SID", v_saup.Index)
                + "&s_UpjangType=10";
    ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
    ds_upjang.Reset(); //����
</script>

<script language=JavaScript for=v_upjang event=OnSelChange()>
    var v_param = "proType=S"
                + "&dsType=2"
                + "&s_UpjangSid="+v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);
    ds_room.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Rm001H?"+v_param;
    ds_room.Reset(); //����
</script>

<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>

<script language="javascript" for="tr_save" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_DONE%>";
    fnSelect();
</script>

<script language="javascript" for="tr_save" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    window.status="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr_save.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr_save.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
</script>

<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
    document.all.LowerFrame.style.visibility="hidden";
    if(row==0){
        alert("<%=HDConstant.S_MSG_NO_DATA%>");
    }
</script>


<%=HDConstant.COMMENT_START%>
<object  id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_season classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_room classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_age classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_goods0 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%> 

</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


    <table cellpadding="0" cellspacing="0" border="0" width="845">
        <tr> 
            <td align="right">
                <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                <img src="<%=dirPath%>/Sales/images/plus.gif"    style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
                <img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >
                <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
                <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
            </td>
        </tr>
        <tr>
            <td>
                <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                    <tr bgcolor="#6f7f8d" height=25>
                        <td class=text>����</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=100 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_saup>
                                <param name=SearchColumn        value="saup_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="saup_nm^0^100">
                                <param name=BindColumn          value="saup_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%> 
                        </td>
                        <td class=text>�����</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_upjang>
                                <param name=SearchColumn        value="upjang_nm">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="upjang_nm^0^130">
                                <param name=BindColumn          value="upjang_sid">
                            </object>
                            <%=HDConstant.COMMENT_END%> 
                        </td>
                        <td class=text>����</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_season classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_season>
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="DETAIL_NM^0^130">
                                <param name=BindColumn          value="DETAIL">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                    <tr bgcolor="#6f7f8d" height=25>
                        <td class=text>����</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_room classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_room>
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="ROOM_TYPE_CD^0^130">
                                <param name=BindColumn          value="ROOM_TYPE_SID">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class=text>����</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_age classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_age>
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="DETAIL_NM^0^130">
                                <param name=BindColumn          value="DETAIL">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class=text>��ǰ��</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=v_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                <param name=ComboDataID         value=ds_goods0>
                                <param name=SearchColumn        value="GOODS_NM">
                                <param name=Sort                value="false">
                                <param name=ListExprFormat      value="GOODS_NM^0^130">
                                <param name=BindColumn          value="GOODS_SID">
                            </object>
                            <%=HDConstant.COMMENT_END%>
                        </td>
                        <td class=text>�̿�����</td>
                        <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                <object id=v_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>  height='16px' width=67 align=center class='textbox'>
                                    <param name=Format      value="YYYY-MM-dd">
                                    <param name=Alignment   value=1>
                                    <param name=ClipMode    value=true>
                                    <param name=Border      value=false>
                                    <param name=SelectAll   value=true>
                                    <param name=SelectAllOnClick      value=true>
                                    <param name=SelectAllOnClickAny   value=false>
                                </object>
                                <%=HDConstant.COMMENT_END%>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>        
    <table border= "0" cellpadding=0 cellspacing=0>
        <tr>
            <td height=3  border="0"></td>
        </tr>
        <tr> 
            <td valign=top> 
                <table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:270px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
                    <tr> 
                        <td>
                            <%=HDConstant.COMMENT_START%>                                           
                            <object  classid=<%=HDConstant.CT_GRID_CLSID%> id=gr1  style="WIDTH:845px;HEIGHT:450px;border:1 solid #777777;">
                                <param name="DataID"        VALUE="ds1">
                                <param name="BorderStyle"   VALUE="0">
                                <param name=ColSizing       value="true">
                                <param name="editable"      value="true">
                                <param name=UsingOneClick   value="1">
                                <Param Name="AllShowEdit"   value="True">
                                <param name=SortView  		value="right">
                                <param name="Format"        VALUE="  
                                    <FC> name=''            ID='{CURROW}'       Width=25  align=center </FC>                     
                                    <FC> name='�޴�\\�ڵ��'	ID='MENU_CD'        Width=50  align=center edit=upper</FC>
                                    <FC> name='�޴����'       ID='MENU_NM'        Width=100 align=left sort=true</FC>
                                    <C> name='�����'       	ID='MENU_ITEM1'     Width=80  align=center editstyle=Lookup Data='ds_season:DETAIL:DETAIL_NM' sort=true</C>
                                    <C> name='���ǡ�'       	ID='MENU_ITEM2'   	Width=90  align=center editstyle=Lookup Data='ds_room:ROOM_TYPE_SID:ROOM_TYPE_NM'</C>
                                    <C> name='���ɡ�'       	ID='MENU_ITEM3'     Width=50  align=center editstyle=Lookup Data='ds_age:DETAIL:DETAIL_NM'</C>
                                    <C> name='��ǰ��'       	ID='MENU_ITEM4'     Width=100  align=center editstyle=Lookup Data='ds_goods:goods_sid:goods_nm'</C>
                                    <C> name='����\\�ο���'    ID='BGN_PERSONS' Width=40  align=right Edit=Numeric</C>
                                    <C> name='����\\�ο���'    ID='END_PERSONS' Width=40  align=right Edit=Numeric</C>
                                    <C> name='����\\�������ڡ�' ID='BGN_DATE'   Width=70  align=center Edit=Numeric mask='XXXX/XX/XX'</C>
                                    <C> name='����\\�������ڡ�' ID='END_DATE'   Width=70  align=center Edit=Numeric mask='XXXX/XX/XX'</C>
                                    <C> name='�ܰ���'       	ID='UNIT_AMT'       Width=60  align=right Edit=Numeric dec=0</C>
                                    <C> name='���\\���Ρ�'		ID='USE_YN'        Width=50  align=center EditStyle=CheckBox</C>
                                    <C> name='��������'     	ID='TAX_YN'        Width=60  align=center EditStyle=CheckBox </C>
                                    <C> name='�޴������'    	ID='MENU_SHORT_NM'  Width=120 align=left Edit=AlphaNum</C>
                                    <C> name='�޴�������'    	ID='MENU_ENG_NM'    Width=155 align=left Edit=AlphaNum</C>
                                ">
                            </object> 
                            <%=HDConstant.COMMENT_END%> 
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


