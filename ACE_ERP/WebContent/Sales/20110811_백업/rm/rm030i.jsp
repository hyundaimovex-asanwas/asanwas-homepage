<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	     : ����Ÿ�� ���
 * ���α׷�ID 	 : RM030I
 * J  S  P		 : rm030i
 * �� �� ��		 : RM030I
 * �� �� ��		 : ������
 * �� �� ��		 : 2006-06-11
 * �������		 : ���� Ÿ�� ��� (��ȸ ��� ���� ����)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
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
        var v_job = "H";
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε�
// Parameter 	:
%>
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit();
	}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	: ����ȸ
// Parameter 	:
%>
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";

        ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds2.Reset(); //�����ڵ�

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm030I",
            "JSP(O:DEFAULT=ds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ȸ
// Parameter 	:
%>
    function fnSelect()
    {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";

        v_job = "S";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1" 
                    + ",v_upjang_sid="  + drp_upjang.ValueOfIndex("upjang_sid", drp_upjang.Index) 
                    + ",v_saup_sid="  + drp_saup.ValueOfIndex("saup_sid", drp_saup.Index) 
                    + ",v_room_type_cd=" + txt_RoomTypeCd.value
                    + ",v_room_type_nm=" + txt_RoomTypeNm.value;
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm030I", 
            "JSP(O:DEFAULT=ds1)",
            v_param);
        tr_post(tr1);
    }
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���߰� (�׸��庰)
// Parameter 	:
%>
	function fnAddRow() {
		ds1.addrow();
        gr1.SetColumn("UPJANG_CD");
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����� (�׸��庰)
// Parameter 	:
%>
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����
// Parameter 	:
%>
	function fnApply() {
        v_job = "I";
		if (ds1.IsUpdated) {
            if(confirm("�����Ͻðڽ��ϱ�?")){
                for(var i=1; i<=ds1.CountRow; i++){
                    if(ds1.NameValue(i, "UPJANG_SID")==0){
                        alert("����Ÿ�� �ڵ�<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("ROOM_TYPE_CD");
                        return;
                    }
                    if(ds1.NameValue(i, "ROOM_TYPE_CD")==""){
                        alert("����Ÿ�� �ڵ�<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("ROOM_TYPE_CD");
                        return;
                    }
                    if(ds1.NameValue(i, "ROOM_TYPE_NM")==""){
                        alert("����Ÿ�Ը�<%=HDConstant.A_MSG_MUST_INPUT%>");
                        ds1.RowPosition = i;
                        gr1.setColumn("ROOM_TYPE_NM");
                        return;
                    }
                }
                window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
                document.all.LowerFrame.style.visibility="visible";

                ln_TRSetting(tr1, 
                            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm030I", 
                            "JSP(I:DEFAULT=ds1)", 
                            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
                tr_post(tr1);
            }
		}
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description :  ���
%>
	function fnCancel() {
		ds1.undoall();
		window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
	}
    </script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
    <script language="javascript"  for=gr1 event=OnClick(row,colid)>
        if(row==0){
            if(ds1.CountRow==0) return;
            
            gr1.ReDraw = "False";

			if(colid=="USE_YN" ){
                for(var i=1; i<=ds1.CountRow; i++)
                    ds1.NameValue(i, "USE_YN") = ds1.NameValue(1, "USE_YN");
            }
            gr1.ReDraw = "True";
            return;
        }
    </script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for=drp_saup event=OnSelChange()>
        ds3.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_SaupSid="+ds2.namevalue(ds2.RowPosition, "saup_sid")+"&s_UpjangType=10&s_use_yn=Y";
        ds3.Reset(); //�������ڵ�
	</script>   	  
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        document.all.LowerFrame.style.visibility="hidden";
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
    <script language="javascript" for="tr1" event="OnFail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
    
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
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    
    if(v_job == "H") return;
    if( row < 1){
        alert("�˻��� ����Ÿ�� �����ϴ�."); 
    }
</script>

<script language=JavaScript  for=ds_temp event="OnLoadCompleted(row)">
    fnOnProgressEnd();
    if(row==0){
        ds1.NameValue(ds1.RowPosition, "UPJANG_SID")="";
        ds1.NameValue(ds1.RowPosition, "UPJANG_NM")="";
        ds1.NameValue(ds1.RowPosition, "ROOM_TYPE_CD") = "";
        ds1.NameValue(ds1.RowPosition, "ROOM_GRADE_CD")="";
        ds1.NameValue(ds1.RowPosition, "ROOM_GRADE_NM")="";
        ds1.NameValue(ds1.RowPosition, "BED_TYPE_CD")="";
        ds1.NameValue(ds1.RowPosition, "BED_TYPE_NM")="";
        
        alert("�˻��� ����Ÿ�� �����ϴ�.");
        return;
    }
    ds1.NameValue(ds1.RowPosition, "UPJANG_SID") = ds_temp.NameValue(row, "UPJANG_SID");
    ds1.NameValue(ds1.RowPosition, "UPJANG_NM") = ds_temp.NameValue(row, "UPJANG_NM");
    ds1.NameValue(ds1.RowPosition, "ROOM_GRADE_CD")= ds_temp.NameValue(row, "ROOM_GRADE_CD");
    ds1.NameValue(ds1.RowPosition, "ROOM_GRADE_NM")= ds_temp.NameValue(row, "ROOM_GRADE_NM");
    ds1.NameValue(ds1.RowPosition, "BED_TYPE_CD")  = ds_temp.NameValue(row, "BED_TYPE_CD");
    ds1.NameValue(ds1.RowPosition, "BED_TYPE_NM")  = ds_temp.NameValue(row, "BED_TYPE_NM");
</script>

<script language=JavaScript  for=ds1 event="OnLoadStarted()">
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
</script>

<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	ds3.insertRow(1);
	ds3.namevalue(1,"upjang_nm") = "��ü";
    drp_upjang.index = 0;
</script>

<script language=javascript for=gr1 event="OnExit(Row, Colid, olddata)">
    if(Row==0) return;
    if(Colid=="ROOM_TYPE_CD"){
        if(ds1.NameValue(Row, Colid)==olddata) return;
        if(ds1.NameValue(Row, Colid).length!=5) {
            ds1.NameValue(Row, Colid) = olddata;
            return;
        }
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible";
    
        v_job = "S";
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1" 
                    + ",v_room_type_cd=" + ds1.NameValue(Row, Colid)
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm030I", 
            "JSP(O:TEMP=ds_temp)",
            v_param);
        tr_post(tr1);
    }
</script>

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_temp classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

</head>                                                                                 
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>                              
                                                                                        
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table width="100%" height="525" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                    <td align="right">
                        <img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelect()">
                        <img src="<%=dirPath%>/Sales/images/plus.gif"    style="cursor:hand;position:relative;left:3px;top:3px"  onClick="fnAddRow()" >
                        <img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnDeleteRow()" >
                        <img src="<%=dirPath%>/Sales/images/save.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnApply()">
                        <img src="<%=dirPath%>/Sales/images/cancel.gif" style="cursor:hand;position:relative;left:3px;top:3px" onClick="fnCancel()">
                    </td>
                </tr>
                <tr><td height=10></td></tr>
                <tr>
                    <td>
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
                                <td align=left class="text">����</td>
            					<td align=left bgcolor="#ffffff">&nbsp;
            						<%=HDConstant.COMMENT_START%>
            						<object id=drp_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=100 style="position:relative;left:1px;top:2px" class="txtbox" >
            							<param name=ComboDataID			value=ds2>
            							<param name=SearchColumn		value="saup_nm">
            							<param name=Sort				value="false">
            							<param name=ListExprFormat		value="saup_nm^0^140">
            							<param name=BindColumn			value="saup_sid">
            						</object>
                                    <%=HDConstant.COMMENT_END%>
            					</td>
                                <td align=left class="text">�����</td>
            					<td align=left bgcolor="#ffffff">&nbsp;
            						<%=HDConstant.COMMENT_START%>
            						<object id=drp_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=200 style="position:relative;left:1px;top:2px" class="txtbox" >
            							<param name=ComboDataID			value=ds3>
            							<param name=SearchColumn		value="upjan_nm">
            							<param name=Sort				value="false">
            							<param name=ListExprFormat		value="upjang_nm^0^140">
            							<param name=BindColumn			value="upjang_sid">
            						</object>
                                    <%=HDConstant.COMMENT_END%>
            					</td>
            					<td align=left class="text">&nbsp;�����ڵ�</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input id="txt_RoomTypeCd" type="text" class="txtbox" size=5 maxlength="10"></td>
            					<td align=left class="text">&nbsp;����Ÿ�Ը�</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input id="txt_RoomTypeNm" type="text" class="txtbox" size=10 maxlength="40"></td>
            				</tr>
            			</table>
            		</td>
            	</tr>
            	<tr>
            		<td height=3  border="0"></td>
            	</tr>
            	<tr>
                	<td valign=top colspan=2>
                	   <table border= "0" cellpadding=0 cellspacing=0 border=0>
                			<tr>
                				<td>
                            		<%=HDConstant.COMMENT_START%>
                            		<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=845px; height:470px" border="1">
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="true">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
                            			<param name="Format"		VALUE="
                                            <FC> name='R#'            ID='{CURROW}'        Width=25    align=center</FC>
                                            <FC> name='�����ڵ�'      ID='ROOM_TYPE_CD'    Width=70   align=center    Edit=Upper editlimit=5 Sort=True</FC>
                                            <C>  name='�����'        ID='UPJANG_NM'    Width=100   align=Left    Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C>  name='���ǵ��'      ID='ROOM_GRADE_NM'    Width=100   align=Left    Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C>  name='����Ÿ��'      ID='BED_TYPE_NM'    Width=70   align=center    Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>'</C>
                                            <C>  name='����Ÿ�Ը�'    ID='ROOM_TYPE_NM'    Width=120  align=left      Edit=Any editlimit='20' Sort=True</C>
                                            <C>  name='����'         ID='PYUNG'           Width=50  align=left Edit=Numeric editlimit='3'</C>
                                            <C>  name='ǥ���ο�'      ID='STD_PERSONS'     Width=60   align=right     Edit=Numeric editlimit='2'</C>
                                            <C>  name='�ִ��ο�'      ID='MAX_PERSONS'     Width=60  align=right      Edit=Numeric editlimit='2'</C>
                                            <C>  name='��뿩�Ρ�'     ID='USE_YN'          Width=60   align=Center    EditStyle=CheckBox CheckBoxText='' Pointer='hand' HeadCheck=false HeadCheckShow=False</C>
                                            <C>  name='����'         ID='DISPLAY_SEQ'     Width=60   align=Center    Edit=Numeric editlimit='2' Sort=True</C>
                            			">
                            		</object>
                            		<%=HDConstant.COMMENT_END%>
                				</td>
                		    </tr>
                		</table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

