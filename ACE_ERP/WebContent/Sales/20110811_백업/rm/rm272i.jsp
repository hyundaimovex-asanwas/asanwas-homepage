<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ��ĳ���� ��ȸ
 * ���α׷�ID 	 : RM272I
 * J  S  P		 : rm272i
 * �� �� ��		 : RM272I
 * �� �� ��		 : ���ϳ�
 * �� �� ��		 : 2010-08-26
 * �������		 : ��ĳ���� ��ȸ (��ȸ, ����)
 * �������		 : 
 * 				      �޼����� �߼��ϴ� �������� �ܺ�SMS ��� ó���� ���� windos������ ASP�� �Ǿ� ����.
 * [��  ��   ��  ��][������] ����
 * 
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

        var v_upjang_sid  = "";
        var v_use_date    = "";

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
		gr1.TitleHeight = "35";        
		
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";		 		

  /*      //�˻�
        ds6.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RM017&s_Item1=Y";
        ds6.Reset();
    */            
           
        ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
        ds_saup.Reset(); //�����ڵ�        
        
		
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated) { 
			alert("�������� ���� �ֽ��ϴ�."); 
		} else {    
			if ( sBgnDate.text.trim() == '' ||  sEndDate.text.trim() == '' ) {
				alert("�̿����ڸ� �Է��� �ּ���.");
				return;
			}
			
			
	        v_job = "S";
            var_upjang      = v_upjang.ValueOfIndex("UPJANG_SID", v_upjang.Index);  //����
            var_saup        = v_saup.ValueOfIndex("SAUP_SID", v_saup.Index); 
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sEndDate=" + sEndDate.text + ","
	            + "sSaupSid=" + var_saup+ ","
	            + "sUpjangSid=" + var_upjang + ","         	                                                
	            + "sRemarks=" + txt_remarks.value;       
	            
	            
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_RM%>Rm272I",
	            "JSP(O:DS1=ds1)",
	            param);
	        tr_post(tr1);
	                    
        }
    }
	/*
	 * ����
	 */
	function fnExcelDs1() {
		gr1.runexcelsheet("���ɽ��� ��ȸ");	
	}		
	/*
	 * ����
	 */
	function fnApply() {
	
	}
	/*
	 * ���
	 */
	function fnCancel() {
	
	}
	
	</script>
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>

    <script language=JavaScript for=v_saup event=OnSelChange()>
        var v_param = "dsType=1"
                    + "&proType=S"
                    + "&s_SaupSid="+v_saup.bindcolval
                    + "&s_UpjangType=99";
        ds_upjang.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy004H?"+v_param;
        ds_upjang.Reset(); //����
    </script>
       


		
	    <script language=JavaScript for=sBgnDate event=OnKillFocus()>
	        if( sBgnDate.Modified == true )
				sEndDate.text = sBgnDate.text;
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
		var msg='';
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
            for ( i=1; i<=msgDS.CountRow; i++ )
            	msg+=msgDS.namevalue(i,"pMsg")+"\n";
            if ( msgDS.CountRow > 0 ) 
	          	alert(msg);     
	        fnSelect();   
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
		div='';  
		
        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);  
		    
        var msg='';
        //�޽��� ó��
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 ) 
          	alert(msg); 		    		
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        div='';             
         
        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";        
        if ( nErrCnt > 0 )
		    alert(alertMsg);           
	</script>	
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr3" event="onfail()">
        window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        div='';             
         
        var alertMsg = '';
       	var nErrCnt = tr3.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++) 
			alertMsg = "ErrorCode : " + tr3.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr3.SrvErrMsg("ERROR", i) + "\n";        
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

    <script language=JavaScript  for=ds_saup event="OnLoadStarted()" >
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible"; 
    </script> 
  
    <script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
        document.all.LowerFrame.style.visibility="hidden";
    </script>   
    
    <script language=JavaScript  for=ds_upjang event="OnLoadStarted()" >
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible"; 
    </script>
    <script language=JavaScript  for=ds_upjang event="OnLoadProsess(row)" >
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        document.all.LowerFrame.style.visibility="visible"; 
    </script>
    <script language=JavaScript  for=ds_upjang event="OnLoadCompleted(row)">
        window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
        document.all.LowerFrame.style.visibility="hidden";
    </script>



<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>

<object  id=ds_upjang classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object  id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>

<!--  �˻� -->
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

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
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="10px">		
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect()">
												<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand" onClick="fnExcelDs1()">
								 			</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>										
				<tr height="25px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left class="text" width="70"><b>�̿�����</b></td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																						
										     <comment id="__NSID__"><object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
												<param name=Text 		value="">
												<param name=Alignment 	value=1>
												<param name=Format 		value="0000-00-00">
												<param name=Cursor	 	value="iBeam">
												<param name=Border	 	value="0">		
												<param name=InheritColor      value="true">																																																				
												<param name=ReadOnly  	value="false">
												<param name=SelectAll   value="true">																				
												<param name=SelectAllOnClick   value="true">	
												<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																										
											</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>&nbsp;~
										     <comment id="__NSID__"><object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
												<param name=Text 		value="">
												<param name=Alignment 	value=1>
												<param name=Format 		value="0000-00-00">
												<param name=Cursor	 	value="iBeam">
												<param name=Border	 	value="0">		
												<param name=InheritColor      value="true">																																																				
												<param name=ReadOnly  	value="false">
												<param name=SelectAll   value="true">																				
												<param name=SelectAllOnClick   value="true">	
												<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																										
											</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>
											</td>
			            					<td align=left class="text" width="70">����</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>	              										
					                            <object id=v_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_saup>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>	
																						              											
			            					<td align=left class="text" width="70">������</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=v_upjang classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>													
				                                <param name=ComboDataID         value=ds_upjang>
				                                <param name=SearchColumn        value="upjang_nm">
				                                <param name=Sort                value="false">
				                                <param name=ListExprFormat      value="upjang_nm^0^150">
				                                <param name=BindColumn          value="upjang_sid">		
				                                  </object>											
												<%=HDConstant.COMMENT_END%>
											</td>								
			            					<td align=left class="text" width="70">����</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
                        <td bgcolor="#ffffff">&nbsp;<input type=text name=txt_remarks class="txtbox" size=15 maxLength=15></td>
																																																																				
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
										HTML Desc	: �˻� ���� - 
										Object ID 	: �׸��� , gr1
										Data ID		: ds1
									-----------------------------------------------------------------------------*/
									%>							
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:450" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>		
										<param name=ColSelect    value="True">																	                                        
										<param name=SelectionColor    value="<SC>Type='FocusEditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='EditCol', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='FocusEditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='EditRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='FocusCurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='CurCol', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='FocusCurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='CurRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='FocusSelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
											<SC>Type='SelRow', BgColor='#D1DEF0', TextColor='Black'</SC>
										">								                                        															                                        
										<param name="Format" 			value="
							                <C> name='������SID'     ID='upjang_sid'    align=left show=false </C>																		
							                <C> name='�̿�����'     ID='use_date'    width=70 align=left show=true mask=XXXX-XX-XX suppress=1</C>							            
							                <C> name='����'      ID='yoil_nm'       width=30 align=center edit=none show=true  suppress=3 </C>
							                <C> name='������'    ID='upjang_nm'     width=100 align=left edit=none show=true  suppress=4 </C>
                               				<C> name='�޴���'          ID='menu_nm'        Width=150   align=left</C>		
                               				<C> name='�޴���'          ID='menu_sid'        Width=150   align=left show=false</C>																			
											<C> name='ȸ��'          ID='use_seq'        Width=50   align=right</C>		
							                <C> name='����'     ID='menu_cnt'      width=40 align=right edit=none how=true</C>
							                <C> name='����'   ID='available_cnt'    fontstyle=bold Width=40  align=right edit=none </C>
											<C> name='����\\ ����'       ID='use_yn'     Width=60  align=right show=false </C> 								                
							                <C> name='����'  ID='rsv_cnt'           width=40 align=right edit=none show=true</C>
                                   			<C> name='����'     ID='remarks'        Width=150   align=left</C>
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

