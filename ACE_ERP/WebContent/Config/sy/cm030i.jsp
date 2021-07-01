<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���α׷� ����
 * ���α׷�ID 	 : CM030I
 * J  S  P		 : cm030I
 * �� �� ��		 : CM030I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2007-07-20
 * �������		 : ERP�ý��� �޴� ����  ������ ��ȸ, ����, ����, �߰�
 * [��  ��   ��  ��][������] ����
 * [2007-09-07][�ɵ���] ���ø������� ���� ����  �ּ� ó�� �� �ҽ� ����
 * [2011-09-02][�ɵ���] �޴��� ���� ��η� ǥ���ϱ��...
 * [2014-01-13][�ɵ���] �籸��-����
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

<%	// ContextPath �� ��Ÿ ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>


<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
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
	 * ����ȸ
	 */
	function fnInit(){
		
        v_job = "H";
        
        cfStyleGrid(getObjectFirst("gr1"), "comn");	//�׸��忡 ��Ÿ�� �����ϴ� �κ�. 1��="comn";2��="comn1"
        
        msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DATA%>"; //������ ����â ����.

        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
   	     									+ "menu_level=" + getObjectFirst("menu_level").value;

        
        ln_TRSetting(tr1, 
		            "<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
		            "JSP(O:DS_MENU=ds_menu)",
		            param);
        
        tr_post(tr1); 		
        
        fnSelect();
	}


	
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		
		if (ds1.isUpdated ) { 
			
			alert("�������� ���� �ֽ��ϴ�."); 
			
		} else {    
			
	        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	        
	        v_job = "S";
	        
	        
	        var param2 = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
														+ "menu_level=" + getObjectFirst("menu_level").value;

			ln_TRSetting(tr2, 
							"<%=dirPath%><%=HDConstant.PATH_ERP_COMMON%>Cm030I",
							"JSP(O:DS_MENU=ds_menu)",
							param2);
			
			tr_post(tr2); 	
	        
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
	 * ���߰�(�׸��庰)
	 */
	function fnAddRow1() {
		
		ds1.addrow();
		
		ds1.namevalue(ds1.rowposition,"LV") = getObjectFirst("menu_level").value;
		
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
	        
	        msgTxt.innerHTML="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�.";
	        
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1,"
       	     									+ "menu_level=" + getObjectFirst("menu_level").value;       	     	
       	     	
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
			
			msgTxt.innerHTML="<%=HDConstant.S_MSG_CANCEL_DONE%>";		
			
		}
		
	}
	
    </script>
<%
/*=============================================================================
				Developer Java Script ��
=============================================================================*/
%>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/

	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
	%>
		<script language="javascript" for="tr1" event="onsuccess()">
	        if(v_job=="I") {
	            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
	        }  else if(v_job == "H" || v_job=="S")
	            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
		</script>
		
		
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
	%>
		<script language="javascript" for="tr1" event="onfail()">
	        if(v_job=="I") {
	            msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	        }  else if(v_job == "H" || v_job=="S")
	            msgTxt.innerHTML = "<%=HDConstant.AS_MSG_SEARCH_ERR%>"; 
	                   
	        var alertMsg = '';
	       	var nErrCnt = tr1.SrvErrCount("ERROR");
	       	for (i = 0; i < nErrCnt; i++) 
				alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "\nErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";        
	        if ( nErrCnt > 0 )
			    alert(alertMsg);              
		</script>
	
	
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts ��
=============================================================================*/
%>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts ����
=============================================================================*/
%>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
	        msgTxt.innerHTML="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts ��
=============================================================================*/



/*=============================================================================
			DataSet Component's Event Message Scripts ��
=============================================================================*/
%>



<%
/*=============================================================================
			DataSet Components(DS) ���� ����
=============================================================================*/
%>

<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<%=HDConstant.COMMENT_END%>



<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>


</head>
<jsp:include page="/Common/sys/body_s03.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table border=0 cellpadding="0" cellspacing="0" width="100%" bordercolor=orange>
  <tr>
	<td>
		<table border=0 width=1000 cellpadding=0 cellspacing=0>
		  <tr height="50px">
			<td align="left" ><!-- ��ư ����-->
				<table width="1000px" border="0"  cellspacing="0" cellpadding="0" >
					<tr> 
						<td align="right">
							<table border="0"  cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="right" height="30px">		
										<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="fnSelect();">
										<img src="<%=dirPath%>/Sales/images/plus.gif"		style="cursor:hand" onClick="fnAddRow1();" >
										<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand"  onclick="fnCancel();">						 			
									</td>
								</tr>
							</table>
						</td>
					</tr>															
				</table>	
			</td>											
		  </tr>
		
		  <tr height="30px">
			<td align="left" ><!-- �˻����� ����-->
				<table width="1000px" border="0"  cellspacing="0" cellpadding="0" >
					<tr> 
						<td  width="1000px">
	                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
	                            <tr bgcolor="#6f7f8d">
	            					<td align=left class="text" width=70>&nbsp;�޴�����</td>
	                                <td align=left bgcolor="#ffffff">&nbsp;																										
										<SELECT NAME=menu_level style="width:120px;align:center;" onChange="fnSelect();">
											<OPTION value=1>����1 ����</OPTION>
											<OPTION value=2>����2 ����</OPTION>
											<OPTION value=3>����3 ����</OPTION>
										</SELECT>
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
			<td width="1000px"><!-- �׸��� ����-->
				
				<table  border="0" cellpadding="0" cellspacing="0">
					<tr valign="top"">
						<td align="left" width="1000px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width:1000; height:500" border="1" >
                    			<param name="DataID"			VALUE="ds1">
                    			<param name="BorderStyle"   	VALUE="0">
                    			<param name=ColSizing       	value="true">
                    			<param name="editable"      	value="true">
                    			<param name=UsingOneClick  		value="1">
                                <Param Name="AllShowEdit"   	value="True">
                                <param name="SortView"      	value="Right">
                                <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								 	<C> name='No.'        	ID='{STRING(CURROW)}'   Width=30    align=center</C>
								 	<C> name='IDX'	    	ID='MENU_IDX'			width=60  	align=center 	editlimit=5 show=true edit=none </C>
									<C> name='�޴�����'     ID='LV'     			width=60	align=center 	editlimit=5 show=TRUE edit=none </C>
									<C> name='�����޴���'	ID='PARENT_IDX'			width=150  	align=LEFT  	editstyle=lookup data='ds_menu:menu_idx:scdnm'</C>
									<C> name='�޴���'   	ID='SCDNM'     			width=200	align=left 		editlimit=14 Sort=True</C>
									<C> name='����'      	ID='SEQ'   				width=60	align=center 	editlimit=5 </C>
									<C> name='���'      	ID='FLAG'     			width=60 	align=center 	editstyle=checkbox editlimit=1 Sort=True</C>									
									<C> name='���'     	ID='DIRPATH'   			width=80	align=center 	editlimit=15 </C>
									<C> name='Full Path'	ID='FULLPATH'			width=250  	align=LEFT 	 	edit=none  Sort=True</C>
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
