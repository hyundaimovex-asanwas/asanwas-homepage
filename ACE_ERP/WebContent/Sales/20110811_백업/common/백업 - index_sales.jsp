<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: �ε���_��������
 * ���α׷�ID 	: index_sales
 * J  S  P		: index_sales.jsp
 * �� �� ��		: 
 * �� �� ��		: �ɵ���
 * �� �� ��		: 2007-08-13
 * �������		: Ʈ���޴� ������ �� �������� ����ȭ��
 * ��������		: 
 * �� �� ��		: �ɵ���
 * ������������ 	: 
 * TODO			: 
 * TODO			: 
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import
%>
<%@ page import="sales.common.*"%>
<%
	// ContextPath
	String dirPath = request.getContextPath(); //HDASan
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<meta http-equiv="expires" content="0">
    <jsp:include page="common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
   		var div='';
	/*
	 * �������ε�
	 */
		function fnOnLoad(){
			fnInit();
			fnInit_tree(); //Ʈ���ʱ�
		}
	/*
	 * ����Ÿ�� ��� ����
	 */
	function fnSetHeader(){
		if (ds1.countrow < 1){
			var s_temp1 = "MENU_IDX:INT,PARENT_IDX:INT, SCDNM:STRING,SEQ:INT,LEVEL:INT";
			ds1.SetDataHeader(s_temp1);
		}	
	}
	/*
	 * ����ȸ
	 */
	function fnInit(){
        v_job = "H";
//        div='init';
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();
        window.status = "<%=HDConstant.S_MSG_SEARCH_DATA%>";        		
        
//        ds_lc_use.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY011&s_Item1=Y";
//        ds_lc_use.Reset();         
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
   	     	+ "menu_level=" + getObjectFirst("menu_level").value;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
            "JSP(O:DS_MENU=ds_menu)",
            param);
        tr_post(tr1); 		
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {    
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
       	     	+ "menu_level=" + getObjectFirst("menu_level").value;

	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
	            "JSP(O:DEFAULT=ds1)",
	            param);
	        tr_post(tr1);
        }
    }
	/*
	 * ����2��ȸ
	 */
    function fnSelectDS3() {
        v_job = "H";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "menu_idx=" + ds_lc1.namevalue(ds_lc1.rowposition,"menu_idx");

        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
            "JSP(O:DS3=ds_lc2)",
            param);
        tr_post(tr2);
    }   
	/*
	 * ����3��ȸ
	 */		
	function fnSelectDS4() {
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "menu_idx=" + ds_lc2.namevalue(ds_lc2.rowposition,"menu_idx");
        ln_TRSetting(tr3, 
            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
            "JSP(O:DS4=ds_lc3)",
            param);
        tr_post(tr3)
	}    
	/*
	 * ���߰�(�׸��庰)
	 */
	function fnAddRow1() {
		if ( ds3.namevalue(ds3.rowposition,"upjang_sid" )==0 || ds3.namevalue(ds3.rowposition,"upjang_sid" )==''  ) 
			alert("������ ������ ���� �������ּ���.");
		else if ( ds_dong.namevalue(ds_dong.rowposition,"dong_sid" )==0 || ds_dong.namevalue(ds_dong.rowposition,"dong_sid" )==''  ) 
			alert("�� ������ ���� �������ּ���.");			
		else if ( ds4.namevalue(ds4.rowposition,"room_type_sid" )==0 || ds4.namevalue(ds4.rowposition,"room_type_sid" )=='' ) 
			alert("����Ÿ���� ���� �������ּ���.");			
		else  {
			ds1.addrow();
			ds1.namevalue(ds1.rowposition,"upjang_sid")=ds3.namevalue(ds3.rowposition,"upjang_sid" );
			ds1.namevalue(ds1.rowposition,"upjang_nm")=ds3.namevalue(ds3.rowposition,"upjang_nm" );			
			ds1.namevalue(ds1.rowposition,"dong_sid")=ds_dong.namevalue(ds_dong.rowposition,"dong_sid" );												
			ds1.namevalue(ds1.rowposition,"room_type_sid")=ds4.namevalue(ds4.rowposition,"room_type_sid" );			
			ds1.namevalue(ds1.rowposition,"room_type_cd")=ds4.namevalue(ds4.rowposition,"room_type_cd" );						
		}
		
	}
	/*
	 * �����(�׸��庰)
	 */
	function fnDeleteRow1() {
		ds1.deleterow(ds1.rowposition);
	}
	/*
	 * ����
	 */
	function fnApply() {
		if (ds1.IsUpdated ) {
	        v_job = "I";	
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
       	     	+ "menu_idx=" + ds_lc3.namevalue(ds_lc3.rowposition,"menu_idx");
       	     	
    	    ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
	            "JSP(I:DS1=ds1)",
	            param);
	         tr_post(tr1);
	         
         }
	}
	/*
	 * ���
	 */
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
	}
	
    </script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
	   if (row < 1 && ( colid=='bgn_date' || colid=='end_date' || colid=='room_view_cd' ) ) {
		   	for(i=1;i<=ds1.CountRow;i++)
	     		ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
	   }		
	   if (row < 1 && colid=='use_yn' ) {
		   	for(i=1;i<=ds1.CountRow;i++)
		    	ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
	   }			   
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
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
                   
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
	</script>
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
                   
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
	</script>
	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
                   
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);              
	</script>		

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
	</script>
	
	
	<script language=JavaScript for=ds1 event=OnColumnChanged(row,colid)>
        var flag = false;
        if(colid='room_view_cd'){
            for(var i=1; i<=ds5.CountRow; i++){
                if(ds5.NameValue(i, "detail")==ds1.NameValue(row, colid)){
                    ds1.NameValue(row, "room_view_nm") = ds5.NameValue(i, "detail_nm");
                    flag = true;
                    return;
                }
            }
            if(!flag)
                ds1.NameValue(row, "room_view_nm") = "";
        }		
	</script>		

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_lc1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_lc2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_lc3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_lc_use classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_menu classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>

<link rel="stylesheet" href="<%=dirPath%>/Common/css/KIS.css">
<script language=javascript src=<%=dirPath%>/Common/js/fnc_index_sales.js></script>
</head>

<body style=margin:0px ONLOAD="init();">
<!-- progress bar window -->
<iframe id=newsWin frameborder=0 marginwidth=0 marginheight=0 scrolling=no style="BACKGROUND:black; POSITION: absolute;DISPLAY:none;width:200;height:120;left: expression((document.body.clientWidth - 200)/2);top: expression((document.body.clientHeight - 120)/2);background: black;Z-INDEX: 9"></iframe>

<TABLE width=100% height=100% border=0 cellspacing="0" cellpadding="0">
	<TR WIDTH="100%">
	  <TD WIDTH="100%" HEIGHT=130 VALIGN=top><!-- ž�޴� -->
		<TABLE CELLPADDING="0" CELLSPACING="0" border=0 width=100%>
		  <TR STYLE="height:42px;">
			<TD><img src=<%=dirPath%>/images/Common/logo.gif border=0></TD>
		  </TR>
		  <TR STYLE="height:35px;">
			<TD Background=<%=dirPath%>/images/Common/topMenu_back.gif>
				<FONT COLOR=#FFFFFF style="font-weight:bold;padding-left:12px">��ä��(2070141)�ԡ�[�������� > �渮�� > ������]</font>
			</TD>
		  </TR>
		  <TR STYLE="height:3px;">
			<TD bgcolor=#FFD104></TD>
		  </TR>
		  <TR STYLE="height:49px;">
			<TD>
				<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
				  <TR>
					<TD width=158 ALIGN=center><img src=<%=dirPath%>/images/Common/ti_SETTLE.gif border=0></TD>
					<TD ALIGN=LEFT VALIGN=BOTTOM><FONT COLOR=#333333 style="font-size:16px;padding-left:12px">�ǸŰ� ����</font></TD>
					<TD ALIGN=right VALIGN=BOTTOM><FONT COLOR=#333333 style="padding-right:12px">Ȩ>��������>���ǰ���>������ �Ա�</font></TD>
				  </TR>
				</TABLE>
			</TD>
		  </TR>
		  <TR STYLE="height:1px;">
			<TD bgcolor=#FFD104></TD>
		  </TR>
		</TABLE>
	  </TD>
	</TR>
	<TR WIDTH="100%">
	  <TD WIDTH="100%" VALIGN=top>
		<TABLE border=0 cellspacing=0 cellpadding=0 height=100%>
		  <TR>
			<TD VALIGN=top BGCOLOR=#E8FFE8 STYLE="border-right:1 solid #DFDFDF;">
				<!-- ����Ʈ �޴� �г� -->
				<DIV style='width:100%;height:30px;padding:4px' align=right>
					<img ID=leftMenuArrow src='<%=dirPath%>/images/Common/arrow_menuClose.gif' border=0 style='cursor:hand' onclick='togLeftMenu();'>
					<!-- open���ο� ���� �̹��� �ҽ�����...��Ű�� ������ ��.. -->
				</DIV>
				<DIV ID=leftMenuLayer style='width:157px;height:300px;padding-left:12px;padding-right:8px;display:;'>
				  <jsp:include page="/erp/Common/jsp/cm010i_1.jsp"  flush="true"/>
				</DIV>
				<!-- ����Ʈ �޴� �г� -->
			</TD>
			<TD WIDTH=100% STYLE="padding:12px;" VALIGN=top>
				
				<!-- �������� -->
				<TABLE border=0 cellspacing=0 cellpadding=0 WIDTH=100%>
				  <TR>
					<TD STYLE='border-bottom:1 solid #009999;border-top:6 solid #009999;padding:7px'  BGCOLOR=#E8FFE8 height=60>
						����
					</TD>
				  </TR>
				</TABLE>
				<!-- �������� -->

			</TD>
		  </TR>
		</TABLE>
	  <TD>
	</TR>
<!--
 	<TR HEIGHT=30>
	  <TD WIDTH="100%" STYLE="border-top:1 solid #FFD104">
		<TABLE border=0 cellspacing=0 cellpadding=0 width=100% height=100%>
		  <TR>
			<TD width=158 ALIGN=center>Message</TD>
			<TD ALIGN=LEFT STYLE="padding-top:2px;padding-left:12px;color:#0000CC" ID=msgText>KIS-WA�� ���� ���� ȯ���մϴ�.</TD>
		  </TR>
		</TABLE>	  
	  </TD>
	</TR>
-->

</TABLE>
</body>
</html>


