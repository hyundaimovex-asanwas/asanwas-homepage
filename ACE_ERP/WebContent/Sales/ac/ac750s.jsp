<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ��ǰ�� ��ȸ
 * ���α׷�ID 	 : AC750S
 * J  S  P		 : ac750s
 * �� �� ��		 : Ac750S
 * �� �� ��		 : ����ǥ
 * �� �� ��		 : 2006-08-17
 * �������		 : ��ǰ�� ��ȸ (��ȸ)
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

   java.util.Calendar date = java.util.Calendar.getInstance();
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
   String firstday = m_today.format(date.getTime());		   
   date.set(java.util.Calendar.HOUR_OF_DAY, 120);      
   String lastday = m_today.format(date.getTime());
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
        var div='';
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			fnInit();
		}
	/*
	 * ����ȸ
	 */
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=lastday%>';
		
		div='init';
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        cfStyleGrid(getObjectFirst("gr2"), "comn");       
		
        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";		 		
        		
      
                				
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac750S",
            "JSP(O:DS3=ds3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);		
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated || ds2.IsUpdated ) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {    
			if ( sBgnDate.text.trim() == '' ||  sEndDate.text.trim() == '' ) {
				alert("��¥�� �Է��� �ּ���.");
				return;
			}		
	        v_job = "S";
	         msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sEndDate=" + sEndDate.text + ","
	            + "sGiftSeq=" + sGiftSeq.ValueOfIndex("detail",sGiftSeq.Index)+ ","
	            + "sFrGiftNo=" + sFrGiftNo.text + ","
	            + "sToGiftNo=" + sToGiftNo.text + ","
	            + "sDateSel=" + sDateSel.value;            	                                                
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac750S",
	            "JSP(O:DS1=ds1,O:DS2=ds2)",
	            param);
	        tr_post(tr1);
        }
    }
	 
	/*
	 * ����
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("��ǰ�� ��ȸ");
		gr2.runexcelsheet("��ǰ�� ��ȸ��");		
	}		
	
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>


		<script language=JavaScript for= lc1 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs4()
		</script>
		
		<script language=JavaScript for= lc2 event=OnSelChange()>
			if ( div!='init')
				fnSelectDs5()
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
            msgTxt.innerHTML = "<%=HDConstant.A_MSG_SAVE_DONE%>";
			fnSelect();                                    
        }  else if(v_job == "H" || v_job=="S")
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds2 event="OnLoadCompleted(row)">
	    fnOnProgressEnd();
		for ( i=1;i<=ds2.CountRow;i++ ) {
			if ( ds1.namevalue(ds1.rowposition,"upjang_sid") == ds2.namevalue(i,"upjang_sid") && ds1.namevalue(ds1.rowposition,"use_date") == ds2.namevalue(i,"use_date") ) {
				ds2.namevalue(i,"select_div") = 'Y';
			} else {
				ds2.namevalue(i,"select_div") = 'N';				
			}
		}    
		ds2.ResetStatus();					
	</script>
	<script language=JavaScript  for=ds3 event="OnLoadCompleted(row)">
		fnSelectDs4(); 
	</script>
	<script language=JavaScript  for=ds4 event="OnLoadCompleted(row)">
		fnSelectDs5(); 
		div='';			
	</script>	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
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
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
	
									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:pointerhand" align=absmiddle onclick="fnSelect()">																			
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:pointerhand" align=absmiddle onclick="fnExcelDs1()">  																																							
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
			            					<td align=left width=80 class="text">&nbsp;
			            					<select name="sDateSel">
												 <option value="">��ǰ��</option>
												 <option value="1">�Ǹ���</option>
												 <option value="2">ȸ����</option>
											</select>
												</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
										     <%=HDConstant.COMMENT_START%>
											<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
												<param name=Text 		value="">
												<param name=Alignment 	value=1>
												<param name=Format 		value="0000-00-00">
												<param name=Cursor	 	value="iBeam">
												<param name=Border	 	value="false">		
												<param name=InheritColor      value="true">																																																				
												<param name=ReadOnly  	value="false">
												<param name=SelectAll  	value="true">
												<param name=SelectAllOnClick  	value="true">		
												<param name=SelectAllOnClickAny   value="false">
											</object>&nbsp;~&nbsp;
					                       	<object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
												<param name=Text 		value="">
												<param name=Alignment 	value=1>
												<param name=Format 		value="0000-00-00">
												<param name=Cursor	 	value="iBeam">
												<param name=Border	 	value="false">		
												<param name=InheritColor      value="true">																																																				
												<param name=ReadOnly  	value="false">
												<param name=SelectAll  	value="true">
												<param name=SelectAllOnClick  	value="true">	
												<param name=SelectAllOnClickAny   value="false">
											</object>&nbsp;
											<%=HDConstant.COMMENT_END%>								
											</td>																				
			            					<td align=left width=70 class="text">&nbsp;��ǰ�Ǳ���</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=sGiftSeq classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds3>
													<param name=BindColumn      value="head">
                                                    <param name=BindColVal      value="head">
													<param name=EditExprFormat	value="%,%;head,detail">
													<param name=ListExprFormat  value="detail_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>											                            
			            					<td align=left width=70 class="text">&nbsp;��ǰ�ǹ�ȣ</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=sFrGiftNo classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
												<param name=Text 		value="">
												<param name=Alignment 	value=1>
												<param name=Format 		value="0000000">
												<param name=Cursor	 	value="iBeam">
												<param name=Border	 	value="false">		
												<param name=InheritColor      value="true">																																																				
												<param name=ReadOnly  	value="false">
												<param name=SelectAll  	value="true">
												<param name=SelectAllOnClick  	value="true">	
												<param name=SelectAllOnClickAny   value="false">
												</object>&nbsp;~&nbsp;
					                            <object id=sToGiftNo classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
												<param name=Text 		value="">
												<param name=Alignment 	value=1>
												<param name=Format 		value="0000000">
												<param name=Cursor	 	value="iBeam">
												<param name=Border	 	value="false">		
												<param name=InheritColor      value="true">																																																				
												<param name=ReadOnly  	value="false">
												<param name=SelectAll  	value="true">
												<param name=SelectAllOnClick  	value="true">	
												<param name=SelectAllOnClickAny   value="false">
												</object>&nbsp;
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
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:175" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="false">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption  value=1>	
										<param name="Format" 			value="
							                <C> name='����'     		ID='FOC_GU_NM'    	width=80 	align=left 	show=true suppress=1</C>																		
							                <C> name='��ǰ����'     	ID='GIFT_TYPE_NM'   width=100 	align=left 	show=true  suppress=2</C>
							                <C> name='�ǸŸż�'     	ID='SALE_CNT'   	width=80 	align=right show=true</C>
							                <C> name='�Ǹűݾ�'      	ID='SALE_AMT'     	width=80 	align=right show=true dec=0 </C>
							                <C> name='ȸ���ż�'    	ID='BACK_CNT'   	width=80 	align=right show=true  </C>
							                <C> name='ȸ���ݾ�'      	ID='BACK_AMT'      	width=80 	align=right show=true dec=0</C>
							                <C> name='��¼���'     	ID='PRT_SEQ'       	width=50 	align=right show=false</C>
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
<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr height="10">
		<td></td>
	</tr>		
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"">
					<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						<%=HDConstant.COMMENT_START%>
						<object id=gr2 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:175" border="1" >
                			<param name="DataID"		VALUE="ds2">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="false">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
							<param name=MultiRowSelect    value=true>	
							<param name=SuppressOption value=1>																																					
																											                                        								                                        
							<param name="Format" 			value="
				                <C> name='�Ǹ���'     	ID='SALE_DATE'   	Width=80  	align=center  suppress=1	mask=XXXX-XX-XX </C> 																                																																				
				                <C> name='��ǰ�Ǳ���'     ID='GIFT_TYPE_NM'   Width=100  	align=left  	suppress=2</C> 																                																		
				                <C> name='��ǰ�ǹ�ȣ'     ID='GIFT_SEQ'   	Width=80  	align=right  	</C> 																                																																	                
				                <C> name='�Ǹ��ڼ���'     ID='SALE_EMPNMK'    width=70 	align=center  	</C>															                															                
				                <C> name='�׸鰡'     	ID='AMT'  			Width=80  	align=right  	 dec=0</C>
				                <C> name='�Ǹűݾ�'     	ID='SALE_AMT'  		Width=80  	align=right  	 dec=0</C> 
				                <C> name='FOC����'     	ID='FOC_GU_NM'    	Width=60  	align=left   	</C> 
				                <C> name='ȸ����'     	ID='BACK_DATE'    	Width=80  	align=center   	mask=XXXX-XX-XX</C> 																                
				                <C> name='ȸ���� ����'    	ID='BACK_EMPNMK'   	Width=70  	align=center	</C> 
				                <C> name='ȸ���ݾ�'     	ID='BACK_AMT'   	Width=80  	align=right 	 dec=0</C> 															                
				                <C> name='����'			ID='GIFT_STATE' 	Width=30 	align=center	</C>
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

