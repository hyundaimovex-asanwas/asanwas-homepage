<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������ :�����Ƿڼ�
 * ���α׷�ID 	: pr510h
 * J  S  P	    : pr510h.jsp
 * �� �� ��		: pr510h
 * �� �� ��		: �̵���
 * �� �� ��		: 2015-09-12
 * [ �������� ][������] ����
 * [2015-09-12][�̵���]
 *****************************************************************************/
%>
<%@ page import="pms.common.*" %>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	int v_ap_m_sid =0;
	//int v_ap_m_sid = HDUtil.nullCheckNum(request.getParameter("ap_m_sid"));
	
	//��Ű�ҷ����� ����
		String v_login_name ="";
		String v_login_id = "";
		Cookie cookies[] = request.getCookies();
	     if(cookies != null) {
	          for(int i=0; i<cookies.length; i++){
	               if(cookies[i].getName().equals("vusrid") ) {
	                    v_login_id = cookies[i].getValue() ;	//=> cookie���� �� �����Ҷ� ���                             
	               }
	               if(cookies[i].getName().equals("vusrnm") ) {
	                    v_login_name = cookies[i].getValue() ;	//=> cookie���� �� �����Ҷ� ���                             
	               }
	          }
	     } 
		//��Ű�ҷ����� ��
		
		
		  //���ϸ���Ʈ html �����
	    StringBuffer sb = new StringBuffer();
		String real_fileList ="";	//���� �ҷ��ͼ� 
		String sys_fileList ="";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>���ڰ��� - �����Ƿڼ�����</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
	<script language="javascript">
	var  gusrid  	="<%=(String)session.getAttribute("vusrid")%>";
	var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";
	
    var g_WinParam = window.dialogArguments;
     
    //alert("g_WinParam[0]::"+g_WinParam[0]+"::g_WinParam[1]::"+g_WinParam[1]+"::g_WinParam[2]::"+g_WinParam[2]+"::g_WinParam[3]::"+g_WinParam[3]);
    
    var array1= new Array();
	var array2= new Array();
	var array3= new Array();
	var array4= new Array();
	var array5= new Array();
	
	var strAppline_gb=""; //���缱���� ��ȸ ���� 
	
	if(g_WinParam[2]!=""){
		
		array1=g_WinParam[2].split(";");
		
		array2 = array1[0].split("/");  //���
		
//		alert(array2[0]);
//		alert(array2[1]);
//		alert(array2[2]);
//		alert(array2[3]);
//		alert(array2[4]);
		
		
		array3 = array1[1].split("/");  //����
		array4 = array1[2].split("/");  //Ȯ��
		array5 = array1[3].split("/");  //����
		strAppline_gb="1"; //���
	}else{
		strAppline_gb="2"; // �̰����Կ��� ó�� �� ��� 
	}
		
		
	// ������ �ε�
	  function fnOnLoad(){

		cfStyleGrid(getObjectFirst("gr_apline"), "comn");
		cfStyleGrid(getObjectFirst("gr_apline_rqst"), "comn");
		cfStyleGrid(getObjectFirst("gr_RcpDpt"), "comn");
		
		fnSelect();
		
		/*
	    if (g_WinParam[0]=="010") {
	    	sp0.style.display = "";
			sp1.style.display = "none";
	    }else{
	    	sp0.style.display = "none";
			sp1.style.display = "";
	    }
	    */
		    
	  }

		// ���� ��ȸ
		function fnSelect() {
			
			//�⺻���� ��ȸ 
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
																	                       	 + ",v_ap_m_sid="+g_WinParam[3]
																				             + ",v_cd_site="+g_WinParam[4]
																				             + ",v_no_cont="+g_WinParam[5]
																							 + ",vEmpNo="+gusrid;
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H", "JSP(O:DS_DEFAULT1=ds_default1)",  param);
		     
		     //prompt(this, param);
		     
		     tr_post(tr1);
		     
		    //÷������ �ɰ���
		    var real_fileList="";
			var sys_fileList="";
				
			var real_fileList =txt_real_file.value;
			var sys_fileList =txt_sys_file.value;
		
			var real_file10= new Array();
			var sys_file10= new Array();
		
			real_file10 = real_fileList.split(":");	//�迭�� ����
			sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
			var real_file1=real_file10.slice(0,1);
			var sys_file1=sys_file10.slice(0,1);	
			var real_file2=real_file10.slice(1,2);
			var sys_file2=sys_file10.slice(1,2);	
			var real_file3=real_file10.slice(2,3);
			var sys_file3=sys_file10.slice(2,3);	
			
			
			
			// ��ü��õ����
	        //var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		    //                   + ",v_ap_m_sid="+g_WinParam[3];        
		    // ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
		    // tr_post(tr1);
		     
		     
			 // (����)��������		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 				+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H", "JSP(O:DS_DEFAULT3=ds_default3)",  param);
		     tr_post(tr1);
		     
			 // (����)��������		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
                 				+ ",v_ap_m_sid="+g_WinParam[3];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H", "JSP(O:DS_DEFAULT4=ds_default4)",  param);
		     tr_post(tr1);
		     

		}
		
		
		// ����  
		function fnApply_1(){
			
			if (confirm("�����Ͻðڽ��ϱ�?")) {

				var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
														 											+ ",v_ap_m_sid="+g_WinParam[3]
																						            + ",v_cd_site="+g_WinParam[4]
																						            + ",v_no_cont="+g_WinParam[5]
														 											+ ",vEmpNo="+gusrid
																						            + ",vEmpNmk="+gusrnm;

			    ln_TRSetting(tr2,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H","JSP(O:msgDS=msgDS)", param);
			    
		        tr_post(tr2); 

			}

		}		

		// �ݼ�  
		function fnApply_2(){
			
			  //alert(arrParam);
			  strURL = "<%=dirPath%>/Pms/help/pr010h_desc.jsp?";
			  strPos = "dialogWidth:800px;dialogHeight:150px;status:yes;scroll:yes;resizable:yes";
		      result = showModalDialog(strURL,arrParam,strPos);			

		      if(result != null){
			  	arrResult = result.split(";");
	          }  

			var ap_desc = arrResult[1];
		      
			if (confirm("�ݼ��Ͻðڽ��ϱ�?")) {

				var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2"
																							+ ",v_ap_m_sid="+g_WinParam[3]
																							+ ",vEmpNo="+gusrid
																			            	+ ",vEmpNmk="+gusrnm
														    								+ ",vApDesc=" + ap_desc; 				
	
				ln_TRSetting(tr3,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr510H","JSP(O:msgDS=msgDS)", param);
				tr_post(tr3); 		
			
			}
			
		}

  //÷������(1) �ٿ�ε�_����
    function fnFile(){
	  
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//�迭�� ����
		sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
				
		if(real_file1==''){
		alert("÷�������� �������� �ʽ��ϴ�")
		return;
		}else if(real_file1.length==1){
			
			var url = "http://203.242.32.115/"+sys_file1; //�
			location.href=url;
			
			//location.href = 'http://203.242.32.115/'+sys_file1; //�
			//location.href = './download_zace.jsp?dir=pr010&sysfilename='+sys_file1; //�			
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //����
		}
	}

  	//÷������(2) �ٿ�ε�_����
    function fnFile2(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//�迭�� ����
		sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	

		//alert(real_file2);				
		//alert(sys_file2);						
		//alert(real_file2.length);
		
		if(real_file2.length==0){
		alert("2��° ������ �������� �ʽ��ϴ�")
		}
		if(real_file2.length>0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //�
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //����
		}
	}
  	
	//÷������(3) �ٿ�ε�_����
    function fnFile3(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//�迭�� ����
		sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
		
		if(real_file3.length==0){
		alert("3��° ������ �������� �ʽ��ϴ�")
		}
		if(real_file3.length >0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //�
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //����
		}

	}
	

	</script>
		
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�� 
%>	
		<script language=JavaScript  for=ds_default1 event="OnLoadStarted()" >



		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds_default1 event="OnLoadCompleted(row,colid)">

		</script>


<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds_default1 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
		</script>

<%/*=============================================================================
			 DataSet Component's Event Message Scripts
	=============================================================================*/
%>	

			
<!-----------------------------------------------------------------------------
	DataSet Components ���� 
	# ��ȸ�� �� ��� ����Ѵ�. 
------------------------------------------------------------------------------->
<%=HDConstant.COMMENT_START%>

<object  id=ds_default1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id="msgDS" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr3" classid=<%=HDConstant.CT_TR_CLSID%>>
	<param name="KeyName"  	 value="toinb_dataid4">
	<param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>


<%=HDConstant.COMMENT_END%>


<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=tr1 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>


<script language=JavaScript for=tr2 event=OnSuccess()>
	alert("���������� ����ó�� �Ǿ����ϴ�.");
	window.returnValue = "Y"+ ";" 
	window.close();
</script>

<script language=JavaScript for=tr3 event=OnSuccess()>
	alert("���������� �ݼ�ó�� �Ǿ����ϴ�.");
	window.returnValue = "Y"+ ";" 
	window.close();
</script>

</head>	
	
<!--  BODY START -->
<body border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="fnOnLoad()">

	<!--  loading file ���¹� �÷���  -->
	<iframe id="loadingBar" 
			name="loadingBar" 
			style="display:none; position:absolute;z-index:9;" 
			Frameborder="0" src="<%=dirPath%>/Sales/common/include/loadingSales.jsp">
	</iframe>	

<!-- ���� / [����|�ݼ�] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=25  width=950 align ="right">
	    	<img src="<%=dirPath%>/Sales/images//btn_ConsentOn.gif"	    align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_1();">
	    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"		align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_2();">
	</td>
  </tr>
</table>


<table border="0" cellpadding="0" cellspacing="0" align=center>
 	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">�⺻����</font>
	  </td>
  </tr>
  <tr>
	<colgroup>
		<col width="120"></col>
		<col width="250"></col>
		<col width="120"></col>
		<col width="*"></col>
	</colgroup>  
	<td height=25 width=950>
		<table width="950px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="120px"  bgcolor="#eeeeee" align="center" class="text">�ϵ�����ȣ</td>
				<td  height="25px" width="250px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_NO_GAHADOCONT" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">��������</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_rqst_date" type="text" class="textbox2" size="30" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px" width="120px"  bgcolor="#eeeeee" align="center" class="text">�����</td>
				<td  height="25px" bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<input id="txt_DS_SITE" type="text" class="textbox2"  size="30" style="height:19px" readonly>
			
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">��������</td>
				<td height="25px"  width="250px" bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_TY_TAX" type="text" class="textbox2"  size="3" style="height:19px" readonly>&nbsp;&nbsp;(
					<input id="txt_RT_TAX" type="text" class="textbox2"  size="6" style="height:19px" readonly>%&nbsp;)	
				</td>				
			</tr>
			<tr>
				<td  height="25px"  width="120px" bgcolor="#eeeeee" align="center" class="text">���ְ����</td>
				<td  height="25px" width="250px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DS_HADOCONT" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>
				<td  height="25px"  width="120px" bgcolor="#eeeeee" align="center" class="text">����Ⱓ</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<object  id=txt_DT_FROM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="true">										
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
										<param name=Format				value="####-##-##">										
					</object>	
					&nbsp; ~ &nbsp;
					<object  id=txt_DT_TO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:60px;height:18px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="true">										
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
										<param name=Format				value="####-##-##">										
					</object>	
				</td>
			</tr>
			<tr>
				<td  height="25px"  width="120px" bgcolor="#eeeeee" align="center" class="text">���ޱݾ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<object  id=txt_AM_TT_DOKUB classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="height:18px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="true">										
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
					</object>				
				</td>
				<td  height="25px"  width="120px" bgcolor="#eeeeee" align="center" class="text">����ݾ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center >&nbsp;
					<object  id=txt_AM_TT_SILHENG classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:18px;position:relative;left:5px;top:5px">		
										<param name=Text					value="">
										<param name=Editable				value="true">												
										<param name=Border        		value="false">
										<param name=GeneralEdit   		value="false">
										<param name=BackColor     		value="#CCCCCC">
										<param name=Alignment			value=0>
					</object>	
					
					&nbsp; (
					<input id="txt_DAEBI" type="text" class="textbox2"  size="3" style="width:38px;height:19px;'" readonly>		
					% &nbsp; )
				</td>
			</tr>
			<tr>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">Ư�����</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center colspan="3">&nbsp;
					<input id="txt_RM_REMARK" type="text" class="textbox2"  size="50" style="width:800px;height:25px;top:5px" readonly >	
				</td>
			</tr>
			<tr>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">÷������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center colspan="4">&nbsp;
                    <input type="text" name='txt_real_file' id="txt_real_file" style="width:700px;" class='textbox2'   readOnly="readonly">
                    <input type="text" name='real_file1' id="real_file1" style="width:20px;" class='textbox2' value="(1)"  onclick="fnFile()" readOnly="readonly">
                    <input type="text" name='real_file2' id="real_file2" style="width:20px;" class='textbox2'   value="(2)" onclick="fnFile2()" readOnly="readonly">
                    <input type="text" name='real_file3' id="real_file31" style="width:20px;" class='textbox2'   value="(3)" onclick="fnFile3()" readOnly="readonly">
					<input id="txt_sys_file" type="hidden" class="textbox2" size="0" style="height:0px" readonly>
				</td>
			</tr>								
		</table>
	</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align=center>
 	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">��������</font>
	  </td>
  </tr>
  <tr>
	<td height=25 width=950>
		<table width="950px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="120px" bgcolor="#eeeeee" align="center" class="text">����������</td>
				<td  height="25px"bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_EXPLAIN" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">�������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_AT_SITEEXPLAIN" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px" width="120px" bgcolor="#eeeeee" align="center" class="text">����������</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_BIDMAGAM" type="text" class="textbox2"  size="30" style="height:19px" readonly>
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">����û��</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DT_REQCONTRACT" type="text" class="textbox2"  size="30" style="height:19px" readonly>				
				</td>
			</tr>			
		</table>
	</td>
  </tr>
</table>

<table border="0" cellpadding="0" cellspacing="0" align=center>
 	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">��������</font>
	  </td>
  </tr>
  <tr>
	<td height=25 width=950>
		<table width="950px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="120px" bgcolor="#eeeeee" align="center" class="text">���ޱ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_rqst_no4" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  width="120px" bgcolor="#eeeeee" align=center class="text">�������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_rqst_date" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
			</tr>
		</table>
	</td>
  </tr>
</table>

<!-- ��ü��õ -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">��ü��õ</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='60px' border='1'>
			<param name="DataID"		    		value="ds_default2">
			<param name="ColSizing"	    		value="true">
			<param name="Fillarea"		    		value="false">
			<param name="Editable"		    	value="true">
			<param name="BorderStyle"			value="0">
			<param name=SortView  		    	value="Left">
			<param name="SuppressOption"    	value="1">
			<param name="ViewSummary"       value="0">
			<param name="Format" 				value="
	    		 <C> name='No' 							ID={CurRow}	   			width=20 		align=CENTER	edit=none</C>
	             <C> name='��ü��' 						ID='EST_SID'	   			width=200 		align=CENTER	edit=none</C>
	             <C> name='��ǥ��' 						ID='VEND_CD'   			width=100 		align=CENTER	edit=none</C>
	             <C> name='����ڵ�Ϲ�ȣ' 			ID='VEND_NM'    			width=100 		align=CENTER	edit=none</C>
	             <C> name='��)������'					ID='TOT_EST_AMT'  		width=200 		align=CENTER	edit=none</C>
	             <C> name='��õ����'					ID='TOT_FN_EST'  		width=320 		align=CENTER	edit=none</C>
           ">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>

<!-- ������缱 �����Ƿڰ��� / [����|����|����] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:80;height:15;">������缱</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline_rqst classid=<%=HDConstant.CT_GRID_CLSID%> width='950' height='100px' border='1'>
			<param name="DataID"		    		value="ds_default3">
			<param name="ColSizing"	    		value="true">
			<param name="Fillarea"		   			value="false">
			<param name="Editable"		    	value="true">
			<param name="BorderStyle"			value="0">
			<param name=SortView  		    	value="Left">
			<param name="SuppressOption"    	value="1">
			<param name="Format" 				value="
			  <C> name='����SID'   ID=AP_M_SID   	               		width=80	align=left 	editlimit=5 show=FALSE edit=none    </C>
			  <C> name='����'     	ID=AP_TYPE_NM   	   			width=80	align=center editlimit=50 show=true edit=none</C>
              <C> name='������'    	ID=EMPNM		   	           		width=80 	align=center editlimit=50 show=true edit=none</C>
              <C> name='���'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='����'		ID=AP_JOBNM  		            width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='�μ�'    	ID=AP_DPTNM	   	                width=250 	align=center editlimit=16 show=true edit=none</C>
              <C> name='����'     	ID=AP_STATUS_D_NM         	width=80 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='�ǰ�'	    ID=AP_DESC     		           width=110	align=center editlimit=14 show=true edit=none</C>
              <C> name='�����Ͻ�'	ID=A_DATE			               width=250 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>

<!-- ������缱 �����Ƿڰ��� / [����|����|����] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:80;height:15;">������缱</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='100px' border='1'>
			<param name="DataID"		    		value="ds_default4">
			<param name="ColSizing"	    		value="true">
			<param name="Fillarea"		    		value="false">
			<param name="Editable"		    	value="true">
			<param name="BorderStyle"			value="0">
			<param name=SortView  		    	value="Left">
			<param name="SuppressOption"    	value="1">
			<param name="Format" 				value="
			  <C> name='����SID'   ID=AP_M_SID   	               		width=80	align=left 	editlimit=5 show=FALSE edit=none    </C>
			  <C> name='����'     	ID=AP_TYPE_NM   	   			width=80	align=center editlimit=50 show=true edit=none</C>
              <C> name='������'    	ID=EMPNM		   	           		width=80 	align=center editlimit=50 show=true edit=none</C>
              <C> name='���'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='����'		ID=AP_JOBNM  		            width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='�μ�'    	ID=AP_DPTNM	   	                width=250 	align=center editlimit=16 show=true edit=none</C>
              <C> name='����'     	ID=AP_STATUS_D_NM         	width=80 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='�ǰ�'	    ID=AP_DESC     		           width=110	align=center editlimit=14 show=true edit=none</C>
              <C> name='�����Ͻ�'	ID=A_DATE			               width=250 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>

<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object  id=gcbn_02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default1>
	<param name=BindInfo  value='  
	 <C>Col=AP_M_SID	 	 			Ctrl=txt_rqst_sid    					Param=value </C>

	 <C>Col=NO_GAHADOCONT 		Ctrl=txt_NO_GAHADOCONT  		Param=value </C>
	 <C>Col=DS_SITE 	 				Ctrl=txt_DS_SITE    					Param=value </C>
	 <C>Col=TY_TAX 	 					Ctrl=txt_TY_TAX    					Param=value </C>	
	 <C>Col=RT_TAX 	 					Ctrl=txt_RT_TAX    					Param=value </C>	  
 	 <C>Col=DS_HADOCONT				Ctrl=txt_DS_HADOCONT  			Param=value </C>
	 <C>Col=DT_FROM 	  				Ctrl=txt_DT_FROM   					Param=text </C>
	 <C>Col=DT_TO 	  					Ctrl=txt_DT_TO   					Param=text </C>
	 <C>Col=DT_REQCONTRACT       Ctrl=txt_DT_REQCONTRACT     	Param=value </C>
	 <C>Col=AM_TT_DOKUB 	    	Ctrl=txt_AM_TT_DOKUB   			Param=text </C>
	 <C>Col=AM_TT_SILHENG 			Ctrl=txt_AM_TT_SILHENG  			Param=text </C>
	 <C>Col=DAEBI 						Ctrl=txt_DAEBI  						Param=value </C>	 
	 <C>Col=RM_REMARK					Ctrl=txt_RM_REMARK					Param=value </C>	 
	 <C>Col=DT_EXPLAIN 				Ctrl=txt_DT_EXPLAIN  				Param=value </C>
	 <C>Col=AT_SITEEXPLAIN			Ctrl=txt_AT_SITEEXPLAIN 			Param=value </C>	 
	 <C>Col=DT_BIDMAGAM          	Ctrl=txt_DT_BIDMAGAM        		Param=value </C>
	 <C>Col=REAL_FILE 					Ctrl=txt_real_file	  					Param=value </C>
	 <C>Col=SYS_FILE 					Ctrl=txt_sys_file  						Param=value </C>	 
	'>
</object>
<%=HDConstant.COMMENT_END%>      
</body>
<!- BODY END -->
</html>