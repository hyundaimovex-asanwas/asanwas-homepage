<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ���ڰ���ó�����
 * ���α׷�ID 	 : RM060I
 * J  S  P		 : rm060i
 * �� �� ��		 : RM060I
 * �� �� ��		 : ����ǥ
 * �� �� ��		 : 2006-06-22
 * �������		 : ���ڰ���ó����� (��ȸ,��� ,����, ���)
 * ��������		 :
 * �� �� ��		 : 
 * ������������        : 
 * TODO			 :
 * TODO			 :
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

    <jsp:include page="/Sales/common/include/head.jsp"/>
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
			ds4.deleterow(1);
			ds5.deleterow(1);
		}
	/*
	 * ����Ÿ�� ��� ����
	 */
	function fnSetHeader(){
		if (ds1.countrow < 1){
			var s_temp1 = "ROOM_SID:INT,"+
							"ROOM_NO:STRING,"+
							"UPJANG_NM:STRING,"+
							"BGN_DATE:STRING,"+
							"END_DATE:STRING,"+
							"REQ_EMPNO:STRING,"+
							"HIPERSON_CD:STRING,"+
							"WRONG_TYPE:STRING,"+
							"WRONG_TYPE_NM:STRING,"+
							"WRONG_DESC:STRING,"+
							"PROC_STATE:STRING,"+
							"PROC_STATE_NM:STRING,"+
							"PROC_DATE:STRING,"+
							"RECEIPT_EMPNO:STRING,"+
							"RECEIPT_EMPNO_NM:STRING,"+
							"RECEIPT_DATE:STRING,"+
							"PROC_EMPNO:STRING,"+
							"PROC_EMPNO_NM:STRING,"+
							"PROC_DESC:STRING,"+
							"U_EMPNO:STRING,"+
							"U_DATE:STRING,"+
							"U_IP:STRING";
			ds1.SetDataHeader(s_temp1);
		}	
	}
	/*
	 * ����ȸ
	 */
	function fnInit(){
        v_job = "H";
        div='init';
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm060I",
            "JSP(O:DS2=ds2,O:DS3=ds3,O:DS4=ds4,O:DS5=ds5,O:initds4=initds4,O:initds5=initds5)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
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
	        document.all.LowerFrame.style.visibility="visible";    
	        v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sUpjangSid=" + ds3.namevalue(ds3.rowposition,"upjang_sid") + ","
	            + "sProcState=" + initds4.namevalue(initds4.rowposition,"detail")+","
	            + "sWrongType=" + initds5.namevalue(initds5.rowposition,"detail")+","
	            + "sFrDate=" + txt_fr_req_dt.text +",sToDate=" + txt_to_req_dt.text;
	        
	            
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm060I",
	            "JSP(O:DEFAULT=ds1)",
	            param);
	        tr_post(tr1);
       		 }
        }
	/*
	 * ��������ȸ
	 */
/*   function fnSelectDS3() {
        v_job = "H";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds2.namevalue(ds2.rowposition,"saup_sid");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm060I",
            "JSP(O:DS3=ds3)",
            param);
        tr_post(tr2);;
    }
*/    
	/*
	 * ���߰�(�׸��庰)
	 */
	function fnAddRow1() {
/*		if ( ds3.namevalue(ds3.rowposition,"upjang_sid" )==0 || ds3.namevalue(ds3.rowposition,"upjang_sid" )==''  ) 
			alert("������ ������ ���� �������ּ���.");
		else if ( ds4.namevalue(ds4.rowposition,"room_type_sid" )==0 || ds4.namevalue(ds4.rowposition,"room_type_sid" )=='' ) 
			alert("����Ÿ���� ���� �������ּ���.");			
		else  {
			ds1.addrow();
			ds1.namevalue(ds1.rowposition,"upjang_sid")=ds3.namevalue(ds3.rowposition,"upjang_sid" );
			ds1.namevalue(ds1.rowposition,"room_type_sid")=ds4.namevalue(ds4.rowposition,"room_type_sid" );			
		}
*/		
		ds1.addrow();
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
	         window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	         document.all.LowerFrame.style.visibility="visible";
	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
	            + "sUpjangSid=" + ds3.namevalue(ds3.rowposition,"upjang_sid") + ","
	            + "sProcState=" + ds4.namevalue(ds4.rowposition,"detail");
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_RM%>Rm060I",
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

  <script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
        if(colid=="room_no") {
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL;
            var strPos;
            //arrParam[0] : head
            //arrParam[1] : detail
            //arrParam[2] : detail_nm
            //arrParam[3] : item1
            arrParam[0] = "";
            arrParam[1] = ""; //�����ڵ��� �����Ͱ�
            strURL = "<%=dirPath%>/Sales/help/rm003h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            arrResult = showModalDialog(strURL,arrParam,strPos);
            if (arrResult != undefined) {
                arrParam = arrResult.split(";");
               	ds1.namevalue(ds1.RowPosition,"room_sid")=arrParam[6];
                ds1.namevalue(ds1.RowPosition,"room_no")=arrParam[3];
                ds1.namevalue(ds1.RowPosition,"upjang_nm")=arrParam[1];
            }else {
            	ds1.namevalue(ds1.RowPosition,"room_sid") = "";
                ds1.namevalue(ds1.RowPosition,"room_no")="";
                ds1.namevalue(ds1.RowPosition,"upjang_nm")="";
            }
        }
        //�Ƿ��ڸ�
          if(colid=="HIPERSON_NM") {
            var arrParam    = new Array();
            var arrResult   = new Array();
            var strURL;
            var strPos;
            //arrParam[0] : head
            //arrParam[1] : detail
            //arrParam[2] : detail_nm
            //arrParam[3] : item1
            arrParam[0] = "";
            arrParam[1] = ""; //�����ڵ��� �����Ͱ�
            strURL = "<%=dirPath%>/Sales/help/sy020h.jsp";
            strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
            arrResult = showModalDialog(strURL,arrParam,strPos);
            if (arrResult != undefined) {
                arrParam = arrResult.split(";");
                ds1.namevalue(ds1.RowPosition,"req_empno")=arrParam[0];
                ds1.namevalue(ds1.RowPosition, "HIPERSON_NM") = arrParam[1];
                
            }
        }

    </script>
		<script language="javascript"  for=gr1 event=OnClick(row,colid)>
		   if (row < 1 && ( colid=='bgn_date' || colid=='end_date' || colid=='room_view_cd' ) ) {
			   	for(i=1;i<=ds1.CountRow;i++)
		     		ds1.namevalue(i,colid) = ds1.namevalue(1,colid);
		   }		
		   if (row < 1 && colid=='use_yn' ) {
		     	if ( ds1.namevalue(1,colid) == 'T' ) {
				   	for(i=1;i<=ds1.CountRow;i++)
			     		ds1.namevalue(i,colid) = 'F';
			    } else {
				   	for(i=1;i<=ds1.CountRow;i++)
			     		ds1.namevalue(i,colid) = 'T';			    
			    }
		   }			   
		</script>
		
		<script language=JavaScript for=gr1 event=OnDblClick(row,colid)>
			if (ds2.IsUpdated ) { ds1.undoall(); alert("������ �����Ͽ� �������� ���� �ֽ��ϴ�."); gr2.Focus(); }				
		</script>

		<script language="javascript"  for=gr2 event=OnClick(row,colid)>
			if (ds1.IsUpdated ) { ds2.undoall(); alert("������ �����Ϳ� �������� ���� �ֽ��ϴ�."); gr1.Focus(); }		
		</script>

		<script language=JavaScript for=gr2 event=OnDblClick(row,colid)>
			if (ds1.IsUpdated ) { ds2.undoall(); alert("������ �����Ϳ� �������� ���� �ֽ��ϴ�."); gr1.Focus(); }		
		</script>
<!--    
 		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDS3();
		</script>	
	

-->				   
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
            window.status = "�۾��� �Ϸ� �Ǿ����ϴ�.";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        document.all.LowerFrame.style.visibility="hidden";
        window.status = "�۾��� �����Ͽ����ϴ�.";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        document.all.LowerFrame.style.visibility="visible";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
	    
	    if(v_job == "H") return;
	    if( row < 1){
	        alert(row + " �˻��� ����Ÿ�� �����ϴ�."); 
	    }
	</script>
	
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		div='';
	</script>	

 <%	//<script language=JavaScript  for=ds4 event="OnLoadCompleted(row,colid)">
	//	fnSelectDS3();
	//</script>
	%>
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
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=initds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=initds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<%=HDConstant.COMMENT_END%>
</head>
	
<jsp:include page="/Sales/common/include/body_s.jsp"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
									
								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr>
										<td>
											<table border="0" width="845px"  cellpadding="0" cellspacing="0">
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: �˻� �κ� 
				: ����ڸ�, ������ڵ�
-----------------------------------------------------------------------------*/
%>											
												<tr height="50px">
													<td align="left" >
														<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
															<tr> 
																<td  width="500px">
											                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
											                            <tr bgcolor="#6f7f8d">
											            					<td align=left class="text">&nbsp;����</td>
											                                <td align=left bgcolor="#ffffff" colspan=3>&nbsp;																										
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds2>
																					<param name=BindColumn      value="saup_sid">
							                                                        <param name=BindColVal      value="saup_sid">
																					<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
																					<param name=ListExprFormat  value="saup_nm^0^120"></object>
																				<%=HDConstant.COMMENT_END%>
																			</td>
																		<tr bgcolor="#6f7f8d">
											            					<td align=left class="text">&nbsp;������</td>
											                                <td align=left bgcolor="#ffffff">&nbsp;																										
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																					<param name=ComboDataID		value=ds3>
																					<param name=BindColumn      value="upjang_sid">
							                                                        <param name=BindColVal      value="upjang_sid">
																					<param name=EditExprFormat	value="%,%;upjang_sid,upjang_nm">
																					<param name=ListExprFormat  value="upjang_nm^0^120"></object>
																				<%=HDConstant.COMMENT_END%>
																			</td>																			
											            					<td align=left class="text">&nbsp;ó������</td>
											                                <td align=left bgcolor="#ffffff">&nbsp;																										
							      												<%=HDConstant.COMMENT_START%>
													                            <object id=sProcState classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																					<param name=ComboDataID		value=initds4>
																					<param name=BindColumn      value="head">
							                                                        <param name=BindColVal      value="head">
																					<param name=EditExprFormat	value="%,%;head,detail_nm">
																					<param name=ListExprFormat  value="detail_nm^0^120"></object>
																				<%=HDConstant.COMMENT_END%>
																			</td>
											            				</tr>
											            				<tr bgcolor="#6f7f8d">
											            					<td align=left class="text">&nbsp;��������</td>
											            					<td align=left bgcolor="#ffffff">&nbsp;
											            					<%=HDConstant.COMMENT_START%>
					                                                            <object id=txt_fr_req_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
					                                                            <param name=Format      value="YYYY-MM-DD">
					                                                            <PARAM NAME=InputFormat value="YYYYMMDD">
					                                                            <param name=Alignment   value=1>
					                                                            <param name=ClipMode    value=true>
					                                                            <param name=Border      value=false>
					                                                             <param name=SelectAll   value=true>
										                                        <param name=SelectAllOnClick      value=true>
										                                        <param name=SelectAllOnClickAny   value=false>
					                                                            </object>
					                                                        <%=HDConstant.COMMENT_END%>&nbsp;~&nbsp;
					                                                        <%=HDConstant.COMMENT_START%>
					                                                            <object id=txt_to_req_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='70px' align='absmiddle' class='textbox'>            
					                                                            <param name=Format      value="YYYY-MM-DD">
					                                                            <PARAM NAME=InputFormat value="YYYYMMDD">
					                                                            <param name=Alignment   value=1>
					                                                            <param name=ClipMode    value=true>
					                                                            <param name=Border      value=false>
					                                                             <param name=SelectAll   value=true>
										                                        <param name=SelectAllOnClick      value=true>
										                                        <param name=SelectAllOnClickAny   value=false>
					                                                            </object>
					                                                        <%=HDConstant.COMMENT_END%>
											            					</td>
											            					<td align=left class="text">&nbsp;��������</td>
											            					<td align=left bgcolor="#ffffff">&nbsp;
											            					<%=HDConstant.COMMENT_START%>
													                            <object id=sWrongType classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																					<param name=ComboDataID		value=initds5>
																					<param name=BindColumn      value="head">
							                                                        <param name=BindColVal      value="head">
																					<param name=EditExprFormat	value="%,%;head,detail_nm">
																					<param name=ListExprFormat  value="detail_nm^0^120"></object>
																				<%=HDConstant.COMMENT_END%>
											            					</td>
											            																            					
											            				</tr>											            				
											            			</table>
																</td>
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
												<tr height="10">
													<td></td>
												</tr>		
												<tr>
													<td width="845px">
														<table  border="0" cellpadding="0" cellspacing="0">
															<tr valign="top"">
																<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: �˻� ���� - ����,������,����Ÿ��:  
	Object ID 	: �׸��� , gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>							
																	<%=HDConstant.COMMENT_START%>
																	<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:350" border="1" >
								                            			<param name="DataID"		VALUE="ds1">
								                            			<param name="BorderStyle"   VALUE="0">
								                            			<param name=ColSizing       value="true">
								                            			<param name="editable"      value="true">
								                                        <Param Name="AllShowEdit"   value="True">
								                                        <param name="SortView"      value="Right">
																		<param name="Format" 			value="
																			<C>name='����sid'		ID='room_sid'            editlimit=10 show=false</C>               
																			<FC>name='���ǹ�ȣ'		ID='room_no'             editStyle=popup align=right</FC>                
																			<FC>name='�������'		ID='upjang_nm'           editlimit=30 width=120</FC>               
																			<G>NAME='����Ⱓ'    	                                                                    
																			<C>name='������'			ID='bgn_date'            editlimit=8 width=100 align=center mask=XXXX-XX-XX </C>
																			<C>name='������'			ID='end_date'            editlimit=8 width=100 align=center mask=XXXX-XX-XX</C>
																			</G>                                                                                                 
																			<C>name='�Ƿ��ڻ��'		ID='req_empno'           editlimit=7 show=false</C>                
																			<C>name='�Ƿ��ڸ�'		ID='HIPERSON_NM'         editlimit=7 editStyle=popup show=false</C>                
																			<C>name='��������'		ID='wrong_type'          editlimit=2 editstyle=lookup data='ds5:detail:detail_nm'</C>                
																			<C>name='���峻��'		ID='wrong_desc'          editlimit=62 width=200 show=false</C>               
																			<C>name='ó������'		ID='proc_state'          editlimit=2  editstyle=lookup data='ds4:detail:detail_nm'</C>                
																			<C>name='ó������'		ID='proc_date'           editlimit=8  windth=100 align=center mask=XXXX-XX-XX</C>
																			<C>name='ó����'			ID='PROC_EMPNO_NM'       	 </C>
																			<C>name='ó������'		ID='proc_desc'           editlimit=62 width=200</C>
																			<C>name='������'			ID='receipt_empno'       editlimit=7  edit=none </C>                
																			<C>name='�����ڸ�'		ID='RECEIPT_EMPNO_NM'    editlimit=7  show=false</C>                
																			<C>name='��������'		ID='receipt_date'        editlimit=8 width=100 align=center mask=XXXX-XX-XX </C>
																			<C>name='ó�������'		ID='proc_empno'          editlimit=7 show=false</C>                
																			               
																			<C>name='���������ڻ��'	ID='u_empno'             editlimit=10 show=false</C>               
																			<C>name='������������'		ID='u_date'              editlimit=26 show=false</C>               
																			<C>name='��������ip'		ID='u_ip'                editlimit=30 show=false</C>               
																		">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>		
															</tr>
														</table>
													</td>
												</tr>
												<tr height="10">
												<td></td>
												</tr>
												<tr>
												<td>
												<table width="500px" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
													<tr bgcolor="#6f7f8d">
														<td align=left class="text">�Ƿ��ڸ�
														</td>
														<td align=left bgcolor="#ffffff">&nbsp;&nbsp;<input type=text id='HIPERSON_NM' name='HIPERSON_NM' class=textbox readOnly></td>
													</tr>
													<tr bgcolor="#6f7f8d">
														<td align=left class="text">���峻��
														</td>
														<td align=left bgcolor="#ffffff">&nbsp;&nbsp;<input type=text id='wrong_desc' name='wrong_desc' class=textbox  size=62 maxlength=60></td>
													</tr>
												</table>
												</td>
												</tr>											
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
  <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="ds1">
             <param name=BindInfo    value="
             	<C>Col=HIPERSON_NM         Ctrl=HIPERSON_NM           Param=value</C>
             	<C>Col=wrong_desc         Ctrl=wrong_desc           Param=value</C>
             ">	
</object>
<%=HDConstant.COMMENT_END%> 		
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>

<jsp:include page="/Sales/common/include/body_e.jsp"/>