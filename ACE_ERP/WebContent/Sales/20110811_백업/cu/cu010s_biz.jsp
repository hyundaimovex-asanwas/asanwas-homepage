<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������
 * ���α׷�ID 	: CU010S
 * J  S  P		: cu010i
 * �� �� ��		: Cu010i
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-06-05
 * �������		: ����ȸ
 * [��  ��   ��  ��][������] ����
 * [2007-09-17][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<% 
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>



<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>

    <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i.js"></script>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
	<script language="javascript">
		
	/* �������ε� */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnInit();
//		lc3.Index = 1;
	}


	/* ����Ÿ�� ��� ���� */
	function fnSetHeaderDsInit(){
		
		if (searchds1.countrow<1){
			var s_temp4 = "head:STRING,detail:STRING,detail_nm:STRING";
			searchds1.SetDataHeader(s_temp4);
		}		
		if (searchds2.countrow<1){
			var s_temp5 = "head:STRING,detail:STRING,detail_nm:STRING";
			searchds2.SetDataHeader(s_temp5);
		}
		if (searchds3.countrow<1){
			var s_temp6 = "head:STRING,detail:STRING,detail_nm:STRING";
			searchds3.SetDataHeader(s_temp6);
		}		
		
		if (searchds4.countrow<1){
			var s_temp6 = "head:STRING,detail:STRING,detail_nm:STRING";
			searchds4.SetDataHeader(s_temp6);
		}
	}	
			
	/* �ʱ��۾� */
	function fnInit(){
	    initds.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010S?proType=INIT&dsType=1";
			initds.Reset();
		}

			
		/* ���� ��ȸ */
		function fnSelect() {
			fnSelectDs1();
		}
			
		/* �����ͼ� ù��° ��ȸ */
		function fnSelectDs1() {
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010S?proType=S&dsType=1&sClientSid="+client_sid.value
																				+"&sCustNm=" + sCustNm.value
																				+"&sManageNo=" + sManageNo.value
																				+"&sCustGu=" + lc3.ValueOfIndex("detail",lc3.Index)
																				+"&sCountryGu=" + lc1.ValueOfIndex("detail",lc1.Index)
																				+"&sRegiYn=" + lc2.ValueOfIndex("detail",lc2.Index)
																				+"&sGroupCd=" + sAccpt_no.value
																				+"&sSaupCd=" + lc4.ValueOfIndex("detail",lc4.Index)
																			
		ds1.Reset();
		ds1.ResetStatus();
	}
		
	/* ���߰� , �ű�  */
	function fnAddRowDs1() {
		ds1.addrow();
	}
		
	/* �����, ���� */
	function fnDeleteRow() {
		ds1.deleterow(ds1.rowposition);
	}
		
	/* ���� */
	function fnApply() {
		var row1=ds1.countrow;
			
		if (ds1.IsUpdated) {
			tr1.KeyValue = "Cu010I(I:INPUT_DATA=ds1)";
			tr1.Action = "<%=dirPath%><%=HDConstant.PATH_SY%>Cu010I?proType=A&dsNum=1";
																
			tr1.post();
			fnSelect(); // �Է��� ��ȸ 
		}		
	}
		
	/* ���  */
	function fnCancelDs1() {
		ds1.Reset();
		ds1.undoall();
		window. status="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
		
		
	/* ����Ʈ */
	function fnPrintDs1() {
	}
			
	/* ���� */
	function fnExcelDs1() {
		
		if(ds1.RowCount==0){
			alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
			return;
		}
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:����ȸ ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("����ȸ", "����ȸ.xls", 8);		 
	}
		
	/* �˾� */
	function fnPopup() {
		
	}
		
	/* �Է� üũ */
	function fnCheck() {
	};

		
	
	/* �븮�� �˻� �˾� */
	function fnClientPopup() {
		
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		
		strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
	   		client_nm.value = arrParam[1];
	   		client_sid.value = arrParam[0];
	   		
		} else {
		  client_nm.value = "";
		  client_sid.value = "";
		}				
	}
	
	/* ��������� �˾� */
	function fnSalDamPopup() {
		
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		
		strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			sal_dam_cd.value = arrParam[0];
	   		sal_dam_nm.value = arrParam[2];
		} else {
		  sal_dam_cd.value = "";
		  sal_dam_nm.value = "";
		}				
	}
	</script>
			

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>


	<%
	/****************************************************************************
	 Description	:  ����ȸ�� �����ڵ� ������ �޺��ڽ��� �����͸� ä��� 
	*****************************************************************************/
	%>		
	<script language=JavaScript  for=initds event="OnLoadCompleted(row,colid)">
		fnSetHeaderDsInit();
		 
		var row=initds.countrow;
		
		for(i=1;i<=row;i++) {
			
			if (initds.namevalue(i,"head") == 'CU009'){// ��������
				searchds1.insertRow(1);
				searchds1.namevalue(1,"head") = initds.namevalue(i,"head");	
				searchds1.namevalue(1,"detail") = initds.namevalue(i,"detail");
				searchds1.namevalue(1,"detail_nm") = initds.namevalue(i,"detail_nm");	
			} else if  (initds.namevalue(i,"head") == 'CU002') { // ��������
				searchds2.insertRow(1);
				searchds2.namevalue(1,"head") = initds.namevalue(i,"head");	
				searchds2.namevalue(1,"detail") = initds.namevalue(i,"detail");
				searchds2.namevalue(1,"detail_nm") = initds.namevalue(i,"detail_nm");	
			} else if  (initds.namevalue(i,"head") == 'CU001') { // ������
				searchds3.insertRow(1);
				searchds3.namevalue(1,"head") = initds.namevalue(i,"head");	
				searchds3.namevalue(1,"detail") = initds.namevalue(i,"detail");
				searchds3.namevalue(1,"detail_nm") = initds.namevalue(i,"detail_nm");
					
			} else if  (initds.namevalue(i,"head") == 'CU004') { // �������
				searchds4.insertRow(1);
				searchds4.namevalue(1,"head") = initds.namevalue(i,"head");	
				searchds4.namevalue(1,"detail") = initds.namevalue(i,"detail");
				searchds4.namevalue(1,"detail_nm") = initds.namevalue(i,"detail_nm");
			}
		}		
		
		searchds3.insertRow(1);
		searchds3.namevalue(1,"head") = 'CU001';	
		searchds3.namevalue(1,"detail") = '';
		searchds3.namevalue(1,"detail_nm") = '��ü';
			
		searchds2.insertRow(1);
		searchds2.namevalue(1,"head") = 'CU001';	
		searchds2.namevalue(1,"detail") = '';
		searchds2.namevalue(1,"detail_nm") = '��ü';
			
		searchds1.insertRow(1);
		searchds1.namevalue(1,"head") = 'CU009'
		searchds1.namevalue(1,"detail") = '';
		searchds1.namevalue(1,"detail_nm") = '��ü';
		
		
		searchds4.insertRow(1);
		searchds4.namevalue(1,"head") = 'CU004'
		searchds4.namevalue(1,"detail") = '';
		searchds4.namevalue(1,"detail_nm") = '��ü';
		
		lc1.index = 5;
		lc2.index = 0;
		lc3.index = 1;
		lc4.index = 0;
		
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
			
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
		<script language="javascript" for="tr1" event="onfail()">
		</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 
%>
<script language="javascript" for="initds" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 
%>
<script language="javascript" for="ds1" event="OnLoadStarted()">
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>				
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
		 if (ds1.countrow == 1000) {
		alert("�����ʹ� 1000�� �̻� ��ȸ �� �� �����ϴ�!");
		}
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			
			if( row < 1){
				alert("�˻��� ����Ÿ�� �����ϴ�."); 
				
			} else {
				lc1.index = lc1.IndexOfColumn("detail", ds1.namevalue(ds1.rowpostion, "country_gu"));
				lc2.index = lc2.IndexOfColumn("detail", ds1.namevalue(ds1.rowpostion, "regi_yn"));
				lc3.index = lc3.IndexOfColumn("detail", ds1.namevalue(ds1.rowpostion, "cust_gu"));
			}
			
							
		</script>	
		
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	<param name="SyncLoad" 	value="false">
</object>

<object id=gcds_data00 classid=<%=HDConstant.CT_DATASET_CLSID%>> 
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=initds classid=<%=HDConstant.CT_DATASET_CLSID%>>      
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=searchds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=searchds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                        
<object id=searchds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="true">                    
</object>    
<object id=searchds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>   
	<PARAM NAME="SyncLoad" VALUE="false">                    
</object>                                                      

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  value="toinb_dataid4">
</object>
<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


								<table border="0" cellpadding="0" cellspacing="0" width="100%">
									<tr height="60px">
										<td >
											<table width=845 >
												<tr>
													<td colspan=2>
														<table align=right>
															<tr>
																<td align="right"> 
																	<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">                                                                                    
																	<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcelDs1()">  
																</td>                                                                                                                
															</tr>
														</table>
													</td>
												</tr>
												<tr>
													<td>
														<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="245x">
															<tr>                
																<td align="center" width="85px" height="30px" class="text" >��û����ȣ</td>                                                          
																<td align="left"  bgcolor="#ffffff" colspan="3">
																	&nbsp;<input type="text" name="sAccpt_no" value="" size="14" maxlength="14">
																	<img src="<%=dirPath%>/Sales/images/help.gif" border="0" 		ALT="��û����ȣ��  �˻��մϴ�"  style="cursor:hand"  onclick="javascript:fnAcceptNoPopup('<%=dirPath%>');" align='absmiddle'>                                                                            
																</td>                               
																                                                                                                               
															</tr>
															<tr>	                                                                                                                      
																<td align="center" width="85px" height="30px" class="text">�븮���ڵ�</td>                                                              
																<td align="left"  bgcolor="#ffffff" colspan="3">                                                                           
																	&nbsp;<input type="text" id=client_nm name="sClientSid" value="" size="14" maxlength="10"  readOnly="true">
																<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle onClick = fnClientPopup();>     
																 <input type='hidden' id='client_sid' name='client_sid' value=''>                                              
																</td>                                                                                                                      
															</tr>												                                   
														</table>
													</td>
													<td align=right>                                                                                                                                    
														<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="600x">                                                          
															<tr>                                                                                                                                
																<td align="center" width="85px" height="30px" class="text" >������</td>                                                  
																<td align="center"  bgcolor="#ffffff" colspan="3">                                                                            
																	<%=HDConstant.COMMENT_START%>
																	<object id=lc3 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
																		<param name=ComboDataID		value=searchds3>
																		<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
																		<param name=ListExprFormat  value="detail_nm^0^100">
																	</object>
																	<%=HDConstant.COMMENT_END%>	
																</td>                                                                                                                       
																<td align="center" width="80px" height="30px" class="text" >��������</td>                                                  
																<td align="center"  bgcolor="#ffffff" colspan="3">                                                                            
																	<%=HDConstant.COMMENT_START%>
																	<object id=lc2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
																		<param name=ComboDataID		value=searchds2>
																		<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
																		<param name=ListExprFormat  value="detail_nm^0^100">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>                                                                                                                       
																<td align="center" width="85px" height="30px" class="text" >����</td>                                                    
																<td align="left"  bgcolor="#ffffff" colspan="3">                                                                            
																	&nbsp;&nbsp;<input type="text" name="sCustNm" value="" size="12" maxlength="10" >  
																</td>                                                                                                                       
															</tr>                                                                                                                               
															<tr>                                                                                                                  
																<td align="center" width="85px" height="30px" class="text">��������</td>                                                                 
																<td align="center"  bgcolor="#ffffff" colspan="3">                                                                            
																	<%=HDConstant.COMMENT_START%>
																	<object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
																		<param name=ComboDataID		value=searchds1>
																		<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
																		<param name=ListExprFormat  value="detail_nm^0^100">
																	</object>
																	<%=HDConstant.COMMENT_END%>
																</td>                
																<td align="center" width="80px" height="30px" class="text" >�������</td>                                                  
																<td align="center"  bgcolor="#ffffff" colspan="3">                                                                            
																	<%=HDConstant.COMMENT_START%>
																	<object id=lc4 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=100 width=100 border="0" align=absmiddle>
																		<param name=ComboDataID		value=searchds4>
																		<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
																		<param name=ListExprFormat  value="detail_nm^0^100">
																	</object>
																	<%=HDConstant.COMMENT_END%>	
																</td>        
																
																                                                                                                       
															                                                                                        
																<td align="center" width="85px" height="30px" class="text" >�ֹ�/���ǹ�ȣ</td>                                             
																<td align="left"  bgcolor="#ffffff" colspan="3">                                                                            
																	&nbsp;&nbsp;<input type="text" name="sManageNo" value="" size="12" maxlength="13">  
																</td>                                                                                                                       
															</tr>
														</table>                                                                                                                                    
													</td>
												</tr>
												<tr>
												<td height="5"></td>
												</tr>
												<tr>
													<td colspan=2>
														<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=845px; height:383px" border="1">
													        <param name="DataID"            value="ds1">
													        <param name="BorderStyle"       value="0">
													        <param name="Fillarea"          value="true">
													        <param name="ColSizing"         value="true">
													        <param name="IndWidth"          value="0">
													        <param name="editable"          value="false">
													        <param name="LineColor"         value="#dddddd">
													        <param name="SortView"         		value="Right">
													        <param name="Format"            value="
													
													                <C> name='���������'   	ID='sal_dam_nm' 		 Width=80  align=left editlimit=22</C>
													                <C> name='�븮��'    		ID='client_nm'  		 Width=150  align=left editlimit=20</C>
													                <C> name='����'      	ID='cust_nm'    		 Width=100  align=left editlimit=20</C>
													                <C> name='�ֹ�/���ǹ�ȣ'	ID='manage_no'  		 Width=100  align=left editlimit=13</C>
													                <C> name='��������' 		ID='regi_yn_name'   	 Width=60  align=left editlimit=50</C>
													                <C> name='������' 		ID='cust_gu_name'        Width=60  align=left editlimit=50</C>
													                <C> name='��������'		ID='country_gu_name'     Width=60  align=left editlimit=50</C>
													                <C> name='�������' 		ID='saup_gu_name'        Width=60  align=left editlimit=50</C>
													                <C> name='������'		ID='cust_type_name'      Width=60  align=left editlimit=50</C>
													                <C> name='����'   		ID='country_cd' 		 Width=50  align=left editlimit=3</C>
													                <C> name='����'       	ID='nation_cd'		      Width=100  align=left editlimit=50</C>
													                <C> name='������ȭ'		ID='tel_no'     		 Width=100  align=left editlimit=20</C>
													                <C> name='��󿬶�ó'    	ID='mobile_no'  		 Width=100  align=left editlimit=15</C>
													                <C> name='�����'   		ID='company_nm' 		 Width=150  align=left editlimit=30</C>
													                <C> name='����'    		ID='positions'  		 Width=150  align=left editlimit=30</C>
													                <C> name='�ּ�'     		ID='address1'   		 Width=200  align=left editlimit=60</C>
													                <C> name='����Ƚ��'    	ID='north_cnt'  		 Width=60  align=left editlimit=7</C>
													                <C> name='�׷��ڵ�'    	ID='group_cd'  			 Width=100  align=left editlimit=7</C>
													                <C> name='����'    		ID='height'  			 Width=50  align=left editlimit=7 show=false</C>
													                <C> name='�Է��Ͻ�'    	ID='u_date'  			 Width=170  align=center  sort=true</C>
													        ">
													</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
													</td>
												</tr>
											</table>	                                                                                                                       
										</td>                                                                                                                                              
									</tr>
								</table>						


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

