<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	     : ���α׷� ����
 * ���α׷�ID 	 : CM040I
 * J  S  P		 : cm040i
 * �� �� ��		 : CM040I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2007-07-20
 * �������		 : ���α׷� ���� (��ȸ, ����, ����, �߰�)
 * [��  ��   ��  ��][������] ����
 * [2008-04-21][�ɵ���] ��� �÷� Ǯ��, ���߰�/���� ���� ��� �־�� ��.
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

<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My710DTO" %>
<%@ page import="sales.org.common.*"%>
<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>
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
	function fnOnLoad(tree_idx){
		fnInit();		//�ش� �������� ���� �ʱ�ȭ
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
	}
	/*
	 * ����Ÿ�� ��� ����
	 */
	function fnSetHeader(){
		if (ds1.countrow < 1){
			var s_temp1 = "PGMID:INT,SYSID:STRING,UPMENUID:STRING,PGMNM:STRING,RPGMID:STRING,FLAG:STRING,SEQ:INT,OLDPGMID:STRING";
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
        
        ds_lc_use.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=SY011&s_Item1=Y";
        ds_lc_use.Reset();         

        ds_page.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CN001&s_Item1=Y";
        ds_page.Reset();	//������ Ÿ��

		
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu032I",
            "JSP(O:DS2=ds_lc1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
        lc1.index=3;
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
       	     	+ "menu_idx=" + ds_lc3.namevalue(ds_lc3.rowposition,"menu_idx");
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu032I",
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
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu032I",
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
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu032I",
            "JSP(O:DS4=ds_lc3)",
            param);
        tr_post(tr3)
	}    
	/*
	 * ���߰�(�׸��庰)
	 */
	function fnAddRow1() {
		if ( ds_lc1.namevalue(ds_lc1.rowposition,"MENU_IDX" )==0 || ds_lc1.namevalue(ds_lc1.rowposition,"MENU_IDX" )==''  ) 
			alert("����1 �޴��� ���� �������ּ���.");
		else if ( ds_lc2.namevalue(ds_lc2.rowposition,"MENU_IDX" )==0 || ds_lc2.namevalue(ds_lc2.rowposition,"MENU_IDX" )==''  ) 
			alert("����2 �޴��� ���� �������ּ���.");
		else if ( ds_lc3.namevalue(ds_lc3.rowposition,"MENU_IDX" )==0 || ds_lc3.namevalue(ds_lc3.rowposition,"MENU_IDX" )=='' ) 
			alert("����3 �޴��� ���� �������ּ���.");
		else  {
			ds1.addrow();

			ds1.namevalue(ds1.rowposition,"PARENT_IDX")=ds_lc3.namevalue(ds_lc3.rowposition,"MENU_IDX");
			ds1.namevalue(ds1.rowposition,"PGMNM")= "";
			ds1.namevalue(ds1.rowposition,"RPGMID")= "";
			ds1.namevalue(ds1.rowposition,"FLAG")= "T";
			ds1.namevalue(ds1.rowposition,"SEQ")= ds1.CountRow;


			if( ds_lc1.namevalue(ds_lc1.rowposition,"MENU_IDX" )==113 || ds_lc1.namevalue(ds_lc1.rowposition,"MENU_IDX" )==114 || ds_lc1.namevalue(ds_lc1.rowposition,"MENU_IDX")==115 ){
				ds1.namevalue(ds1.rowposition,"PAGETYPE")= "1";	//html
			}else if( ds_lc1.namevalue(ds_lc1.rowposition,"MENU_IDX" )==116 || ds_lc1.namevalue(ds_lc1.rowposition,"MENU_IDX" )==117 || ds_lc1.namevalue(ds_lc1.rowposition,"MENU_IDX")==118 ){
				ds1.namevalue(ds1.rowposition,"PAGETYPE")= "2";	//jsp
			}

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
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu032I",
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
	
    <script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
        if(colid=="room_view_cd") {
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL;
            var strPos;
			
            arrParam[0] = "RM002";
            arrParam[1] = "��������"; //�����ڵ��� �����Ͱ�
            strURL = "<%=dirPath%>/Sales/help/sy001h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            arrResult = showModalDialog(strURL,arrParam,strPos);
            if (arrResult != undefined) {
                arrParam = arrResult.split(";");
                ds1.namevalue(ds1.RowPosition,"room_view_cd")=arrParam[1];	                
                ds1.namevalue(ds1.RowPosition,"room_view_nm")=arrParam[2];
            }
        }	        
    </script>
	    
	<script language=JavaScript for=lc1 event=OnSelChange()>
	//����1 �޺��� ����Ǿ��� �� ����2 ȣ��
		fnSelectDS3();
	</script>	
	
	<script language=JavaScript for=lc2 event=OnSelChange()>
	//����2 �޺��� ����Ǿ��� �� ����3 ȣ��
		fnSelectDS4();
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
	
	<script language=JavaScript  for=ds_lc1 event="OnLoadCompleted(row,colid)">
//		fnSelectDS3();
	</script>
		
	<script language=JavaScript  for=ds_lc2 event="OnLoadCompleted(row)">
//	    fnSelectDS4();
//	    div='';
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
<object id=ds_page classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
</head>
	
<jsp:include page="/Common/sys/body_s08.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
							<table border=0 cellpadding="0" cellspacing="0" width="100%" bordercolor=orange>
								<tr>
									<td>
									
										<table border="0" width="845px"  cellpadding="0" cellspacing="0">
											<%/*HTML Desc	: �˻� �κ� 
															: ����ڸ�, ������ڵ� --*/
											%>											
											<tr height="50px">
												<td align="left" >
													<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
														<tr> 
															<td align="right">
																<table border="0"  cellpadding="0" cellspacing="0" width="100%">
																	<tr>
																		<td align="right" height="30px">		
																			<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
																			<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRow1()" >
																			<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRow1()" >																																										
																			<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
																			<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
															 			</td>
																	</tr>																		
																</table>
															</td>
														</tr>															
													</table>	
												</td>											
											</tr>
											
											<tr height="30px">
												<td align="left" >
													<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
														<tr> 
															<td  width="845px">
										                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
										                            <tr bgcolor="#6f7f8d">
										            					<td align=left class="text" width=70>&nbsp;����1</td>
										                                <td align=left bgcolor="#ffffff">&nbsp;																										
						      												<%=HDConstant.COMMENT_START%>
												                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																				<param name=ComboDataID		value=ds_lc1>
																				<param name=BindColumn      value="MENU_IDX">
						                                                        <param name=BindColVal      value="MENU_IDX">
																				<param name=EditExprFormat	value="%,%;MENU_IDX, SCDNM">
																				<param name=ListExprFormat  value="SCDNM^0^120"></object>
																			<%=HDConstant.COMMENT_END%>
																		</td>
										            					<td align=left class="text" width=70>&nbsp;����2</td>
										                                <td align=left bgcolor="#ffffff">&nbsp;																										
						      												<%=HDConstant.COMMENT_START%>
												                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																				<param name=ComboDataID		value=ds_lc2>
																				<param name=BindColumn      value="MENU_IDX">
						                                                        <param name=BindColVal      value="MENU_IDX">
																				<param name=EditExprFormat	value="%,%;MENU_IDX, SCDNM">
																				<param name=ListExprFormat  value="SCDNM^0^120"></object>
																			<%=HDConstant.COMMENT_END%>
																		</td>				
										            					<td align=left class="text" width=70>&nbsp;����3</td>
										                                <td align=left bgcolor="#ffffff">&nbsp;																										
						      												<%=HDConstant.COMMENT_START%>
												                            <object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																				<param name=ComboDataID		value=ds_lc3>
																				<param name=BindColumn      value="MENU_IDX">
						                                                        <param name=BindColVal      value="MENU_IDX">
																				<param name=EditExprFormat	value="%,%;MENU_IDX, SCDNM">
																				<param name=ListExprFormat  value="SCDNM^0^120"></object>
																			<%=HDConstant.COMMENT_END%>
																		</td>																																		
										            					<td align=left class="text" width=70>&nbsp;�������</td>
										                                <td align=left bgcolor="#ffffff">&nbsp;
						      												<%=HDConstant.COMMENT_START%>
												                            <object id=lc_use classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																				<param name=ComboDataID		value=ds_lc_use>
																				<param name=BindColumn      value="detail">
						                                                        <param name=BindColVal      value="detail">
																				<param name=EditExprFormat	value="%,%;detail,detail_nm">
																				<param name=ListExprFormat  value="detail_nm^0^120"></object>
																			<%=HDConstant.COMMENT_END%>
																		</td>																			

										            				</tr>
										            			</table>
															</td>
														</tr>															
													</table>	
												</td>											
											</tr>
											<tr height="10">
												<td></td>
											</tr>		
											<tr>
												<td width="845px">
													
													<table  border="0" cellpadding="0" cellspacing="0">
														<tr valign="top"">
															<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
																<%=HDConstant.COMMENT_START%>
																<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:370" border="1" >
							                            			<param name="DataID"		VALUE="ds1">
							                            			<param name="BorderStyle"   VALUE="0">
							                            			<param name=ColSizing       value="true">
							                            			<param name="editable"      value="true">
							                            			<param name=UsingOneClick  	value="1">
							                                        <Param Name="AllShowEdit"   value="True">
							                                        <param name="SortView"      value="Right">
							                                        <param name="SuppressOption"    value="1">
																	<param name="Format" 			value="
																	 	<C> name='No.'        	ID='{STRING(CURROW)}'   Width=30    align=center</C>
																	 	<C> name='IDX'	    	ID='PGM_IDX'	width=60  	align=center editlimit=5 show=true edit=none </C>
																		<C> name='ParentIDX'	ID='PARENT_IDX'	width=80  	align=center editlimit=5 show=true edit=none suppress=3</C>
																		<C> name='���α׷���'   ID='PGMNM'     	width=140	align=left editlimit=30 show=true  edit=true Sort=True</C>
																		<C> name='���ϸ�'      	ID='RPGMID'     width=100	align=center editlimit=30 show=true Sort=True</C>
																		<C> name='���'      	ID='FLAG'     	align=center width=60 editstyle=checkbox editlimit=1 show=true Sort=True</C>
																		<C> name='����'      	ID='SEQ'   		width=60	align=center editlimit=5 show=true Sort=True</C>
																		<C> name='���ϸ�'      	ID='OLDPGMID'   width=100	align=center editlimit=30 show=false edit=none </C>
																		<C> name='������'     	ID='PAGETYPE'  	width=60	align=center show=true editstyle=lookup Data='ds_page:DETAIL:DETAIL_NM' </C>
																		<C> name='������'     ID='STRDATE'  	width=70	align=center show=true editlimit=8 </C>
																		<C> name='�������'		ID='ENDDATE'  	width=70	align=center show=true editlimit=8 </C>
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
