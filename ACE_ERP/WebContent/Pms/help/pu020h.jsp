<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������ :����û������
 * ���α׷�ID 	: pu020h
 * J  S  P	    	: pu020h.jsp
 * �� �� ��		: pu020hs
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-12-08
 * [ �������� ][������] ����
 * [2012-11-16][�ɵ���] ITEM_SEQ �� ����
 *****************************************************************************/
%>
<%@ page import="pms.common.*" %>
<%
	// ContextPath
	String dirPath = request.getContextPath();
	int v_ap_m_sid =0;
	//int v_ap_m_sid = HDUtil.nullCheckNum(request.getParameter("ap_m_sid"));
	
	
		  //���ϸ���Ʈ html �����
	    StringBuffer sb = new StringBuffer();
		String real_fileList ="";	//���� �ҷ��ͼ� 
		String sys_fileList ="";
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>���ڰ��� - ����û������</title>
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
     
    //alert("g_WinParam::"+g_WinParam);
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
		array3 = array1[1].split("/");  //����
		array4 = array1[2].split("/");  //Ȯ��
		array5 = array1[3].split("/");  //����
		strAppline_gb="1"; //���
	}else{
		strAppline_gb="2"; // �̰����Կ��� ó�� �� ��� 
	}
		
		
	// ������ �ε�
	  function fnOnLoad(){
	  
	  	cfStyleGrid(getObjectFirst("gr_RcpDpt"), "comn");
		cfStyleGrid(getObjectFirst("gr_apline_rqst"), "comn");
		cfStyleGrid(getObjectFirst("gr_apline"), "comn");
	  
		fnSelect();
	  }

		// ���� ��ȸ
		function fnSelect() {
			
			//�⺻���� ��ȸ 
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                       + ",v_rqst_sid="+g_WinParam[1];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu020H", "JSP(O:DS_DEFAULT=ds_default)",  param);
		    // prompt('',ds_default.dataid);   
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
		     
		    // ǰ��
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                       + ",v_rqst_sid="+g_WinParam[1];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu020H", "JSP(O:DS_DEFAULT9=ds_default9 )",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
			
			 // û��(����)��������		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                     + ",v_rqst_sid="+g_WinParam[1];
		 	//alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu020H", "JSP(O:DS_DEFAULT8=ds_default8)",  param);
		     tr_post(tr1);
					     
			 
	         //���缱 ��ȸ  
		     if(strAppline_gb=="1"){
			
			    sp0.style.display = "";
				sp1.style.display = "none";
				
				if(0[4]==""||0[4]=="undefined"||array2[4]=="undefined"||array2[4]==""){ //���缱�� �ȸ��� ��� 
					
						 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=5"
					                     + ",v_empno1="+array2[3]
					                     + ",v_empno2="+array3[3]
					                     + ",v_empno3="+array4[3]
					                     + ",v_empno4="+array5[3];
					     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu020H", "JSP(O:DS_DEFAULT5=ds_default2)",  param);
					     tr_post(tr1);
						
					}else {                //���缱�� ���� ��� 
				     
					    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
					                     + ",v_sid="+array2[4];
					 	//alert(param);
					     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu020H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
					     tr_post(tr1);
					}
			 }else if(strAppline_gb=="2"){
			    
			        sp0.style.display = "none";
					sp1.style.display = "";
			        // alert("g_WinParam[3]::"+g_WinParam[3]+"::");
			    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",dsType=1"
				          + ",s_ap_m_sid="+g_WinParam[3]
				          + ",s_ap_gu=1"; 
			         ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_SALES_HELP%>My400H", "JSP(O:AP_LINE_DS=ds_default2)",  param);
			         tr_post(tr1);
			    }
			}//������ȸ��
		
		
		// ���
		function fnApply_1() {
		   var app_row="";
		
		   //������ ����� ���� 
		   
		   fnSetHeader();
		   ds_approve.addrow();
		   
		   app_row = ds_approve.rowposition;
		   //alert(g_WinParam[1]);
		   ds_approve.namevalue(app_row,"DOC_SID") = g_WinParam[1]; //��Ϲ�ȣ//������ȣ//���ſ�����ȣ
		   ds_approve.namevalue(app_row,"DOC_GU") = "30";  //����
		   ds_approve.namevalue(app_row,"DOC_GU2") = g_WinParam[0]; //  ( 010 ������� , 020 ��������, 030 ��������, 040 ��������, 100 ���񽺿�û .310 ����û��, 320 ����û������, 330 ����ǰ��,340 ���Ű˼�)
		   ds_approve.namevalue(app_row,"AP_GU_1") = array2[0];
		   ds_approve.namevalue(app_row,"AP_SEQ_1") = array2[1];
		   ds_approve.namevalue(app_row,"AP_TYPE_1") = array2[2];
		   ds_approve.namevalue(app_row,"AP_EMPNO_1") = array2[3];
		   ds_approve.namevalue(app_row,"AP_GU_2") = array3[0];
		   ds_approve.namevalue(app_row,"AP_SEQ_2") = array3[1];
		   ds_approve.namevalue(app_row,"AP_TYPE_2") = array3[2];
		   ds_approve.namevalue(app_row,"AP_EMPNO_2") = array3[3];
		   ds_approve.namevalue(app_row,"AP_GU_3") = array4[0];
		   ds_approve.namevalue(app_row,"AP_SEQ_3") = array4[1];
		   ds_approve.namevalue(app_row,"AP_TYPE_3") = array4[2];
		   ds_approve.namevalue(app_row,"AP_EMPNO_3") = array4[3];
		   ds_approve.namevalue(app_row,"AP_GU_4") = array5[0];
		   ds_approve.namevalue(app_row,"AP_SEQ_4") = array5[1];
		   ds_approve.namevalue(app_row,"AP_TYPE_4") = array5[2];
		   ds_approve.namevalue(app_row,"AP_EMPNO_4") = array5[3];
		   ds_approve.namevalue(app_row,"AP_STATUS_M") = "2"; //��������
		   //prompt('',ds_approve.text);
    
		    ln_TRSetting(tr3,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu020H", "JSP(I:DS_APPROVE=ds_approve,O:msgDS=msgDS)", "proType=A, dsType=1");
	        tr_post(tr3);
		}
		

		// ��� ������ ����� ���� 
		function fnSetHeader() {
			var Theader = "DOC_SID:DECIMAL(10.0),DOC_GU:STRING(10),DOC_GU2:STRING(10),"
			    				+ "AP_GU_1:STRING(10),AP_SEQ_1:DECIMAL(10.0),AP_TYPE_1:STRING(10),AP_EMPNO_1:STRING(10),"
								+ "AP_GU_2:STRING(10),AP_SEQ_2:DECIMAL(10.0),AP_TYPE_2:STRING(10),AP_EMPNO_2:STRING(10),"
								+ "AP_GU_3:STRING(10),AP_SEQ_3:DECIMAL(10.0),AP_TYPE_3:STRING(10),AP_EMPNO_3:STRING(10),"
								+ "AP_GU_4:STRING(10),AP_SEQ_4:DECIMAL(10.0),AP_TYPE_4:STRING(10),AP_EMPNO_4:STRING(10),"
								+ "AP_STATUS_M:STRING(1)"; 
			ds_approve.SetDataHeader(Theader);
		}
		
		
		
		// �ݼ�  
		function fnApply_2(){
			var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
 											+ ",s_ap_m_sid="+g_WinParam[3]
 											+ ",sEmpNo="+gusrid
										    + ",sApDesc=" + ds_default2.namevalue(ds_default2.rowposition,"AP_DESC")  											
								            + ",sEmpNmk="+gusrnm;
		    ln_TRSetting(tr4,"<%=dirPath%><%=HDConstant.PATH_SALES_HELP%>My400H_01","JSP(I:AP_LINE_DS=ds_default2, O:msgDS=msgDS)", param);
	        tr_post(tr4); 
		}
		
			// ����  
		function fnApply_3(){
			var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
 											+ ",s_ap_m_sid="+g_WinParam[3]
 											+ ",sEmpNo="+gusrid
								            + ",sEmpNmk="+gusrnm;
		    ln_TRSetting(tr2,"<%=dirPath%><%=HDConstant.PATH_SALES_HELP%>My400H","JSP(I:AP_LINE_DS=ds_default2, O:msgDS=msgDS)", param);
	        tr_post(tr2); 
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
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //�
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
		<script language=JavaScript  for=ds_default event="OnLoadStarted()" >
			//fnShowLoading(410,180);
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds_default event="OnLoadCompleted(row,colid)">
			//fnHideLoading();
			//if (row>0){
			//	txt_reg_dat.value=ds_default.namevalue(row,"REG_DAT").substring(0,16);	
			//}
		</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds_default event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";

			//fnHideLoading();
		</script>
		
<!-----------------------------------------------------------------------------
	DataSet Components ���� 
	# ��ȸ�� �� ��� ����Ѵ�. 
------------------------------------------------------------------------------->
<%=HDConstant.COMMENT_START%>

<object  id=ds_default classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="-APPROVE_TYPE">
</object>

<object  id=ds_default8 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="-APPROVE_TYPE">
</object>

<object  id=ds_default9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id="ds_approve" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT>
	<param name="SyncLoad" value="false">
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

<object  id="tr4" classid=<%=HDConstant.CT_TR_CLSID%>>
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


<script language=JavaScript for=tr1 event=OnSuccess()>
   /**
    alert("pS_YN::::::"+msgDS.namevalue(1,"pS_YN"));
    alert("pMsg::::::"+msgDS.namevalue(1,"pMsg"));
	
	if(msgDS.namevalue(1,"pS_YN")=="Y"){
		alert("::::::"+msgDS.namevalue(1,"pMsg"));
	}
	**/
</script>
<script language=JavaScript for=tr4 event=OnSuccess()>
	alert("���������� �ݷ�ó�� �Ǿ����ϴ�.");
	window.returnValue = "Y"+ ";" 
	window.close();
</script>

<script language=JavaScript for=tr3 event=OnSuccess()>
	alert("���������� ���ó�� �Ǿ����ϴ�.");
	window.returnValue = "Y"+ ";" 
	window.close();
</script>

<script language=JavaScript for=tr3 event=OnFail()>
	alert("Error Code : " + tr3.ErrorCode + "\n" + "Error Message : " + tr3.ErrorMsg + "\n");
</script>


<script language=JavaScript for=tr2 event=OnSuccess()>
	alert("���������� ����ó�� �Ǿ����ϴ�.");
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


<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=15> </td>
  </tr>
  <tr>
	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">�⺻����</font>
	  </td>
  </tr>
  <tr>
	<td height=25 width=950>

		<table width="950" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">û����ȣ</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_no" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">û������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_date" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">��������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_ac_date" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				
			</tr>
			<tr>
				<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">��ü����</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_seq_nm" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">�����</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_site_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�۾�����</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rqst_status_nm" type="text" class="textbox2"  size="18" style="height:19px" maxLength="10" readonly>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">û��Ư�̻���</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom colspan="5">&nbsp;
                    <input type="text" name='txt_rqst_memo' id="txt_rqst_memo" style="width:650px;" class='textbox2'   readOnly="readonly">
                </td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">����Ư�̻���</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom colspan="5">&nbsp;
                    <input type="text" name='txt_rqstac_memo' id="txt_rqstac_memo" style="width:650px;" class='textbox2'   readOnly="readonly">
                </td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">÷������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom colspan="5">&nbsp;
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
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">ǰ��</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=850 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='950' height='360px' border='1'>
			<param name="DataID"		    value="ds_default9">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="ViewSummary"       value="1">
			<param name="AutoResizing"       value="true">
			<param name="Format" 			value="
             <C> name='RQST_SID' 	ID='RQST_SID'   		width=40 		align=CENTER	edit=none show=false</C>
             <C> name='ITEM_SID' 	ID='ITEM_SID'   		width=40 		align=CENTER	edit=none show=false</C>
             <C> name='����' 		ID='ITEM_SEQ'	   	width=30 	align=CENTER	edit=none show=TRUE	</C>
             <C> name='ǰ��' 		ID='ITEM_NM'    		width=150 	align=CENTER	 editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
             <C> name='�԰�' 		ID='ITEM_SIZE'   		width=80 		align=CENTER	 </C>
             <C> name='����' 		ID='ITEM_UNIT'   		width=80 		align=CENTER	  </C>
            <G> name='����'
             <C> name='����' 		ID='DG_CNT'   		width=45 		align=right decao=2	</C>
             <C> name='�ܰ�'    	ID='DG_AMT'    	    width=85 		align=right	 show=true decao=0	sumtext='��'  sumtextalign='right' </C>
             <C> name='�ݾ�(�ڵ�)'  ID='DG_SUM_AMT'   width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
            </G>
            <G> name='����'
             <C> name='����' 		ID='RQST_CNT'   	width=45 		align=right	 decao=2	</C>
             <C> name='�ܰ�' 		ID='YS_AMT'   			width=85 		align=right	 decao=0 sumtext='��'  sumtextalign='left'</C>
             <C> name='�ݾ�(�ڵ�)'  ID='YS_SUM_AMT'    width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
            </G>
             <C> name='�ҿ���' 		ID='DATE_USE'    	width=80 		align=CENTER	 EditStyle=popup sumtext='��'  sumtextalign='left'</C>
             <C> name='���' 		ID='RQST_NOTE'    	width=150 		align=LEFT	 	 </C>
             <C> name='�뵵' 		ID='RQST_USE'    	width=50 		align=CENTER  show=true edit=none 	 </C>


              
              
           ">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>
<!-- û������ / [����|����|����] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:80;height:15;">������缱</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=850 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline_rqst classid=<%=HDConstant.CT_GRID_CLSID%> width='950' height='100px' border='1'>
			<param name="DataID"		    value="ds_default8">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
			  <C> name='����SID'   ID='ap_m_sid'   	               width=80	align=left editlimit=5 show=FALSE edit=none    </C>
			  <C> name='����'     	ID=AP_TYPE_NM          	   width=55	align=center editlimit=50 show=true edit=none</C>
              <C> name='������'    	ID=EMPNMK		   	               width=69 	align=center editlimit=50 show=true edit=none</C>
              <C> name='���'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='����'		ID=PAYGRD  		               width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='�μ�'    	ID=DEPTNM	   	                   width=200 	align=center editlimit=16 show=true edit=none</C>
              <C> name='����'     	ID=AP_STATUS_D_NM         width=70 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='�ǰ�'	    ID=AP_DESC     		           width=200	align=center editlimit=14 show=true edit=none</C>
              <C> name='�����Ͻ�'	ID=U_DATE			               width=200 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>
<!-- ���� / [����|����|����] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:80;height:15;">������缱</font>
	</td>
	<td height=30  align ="right">
	  	
		<span id=sp0 style="display:none;">
	    	<img src="<%=dirPath%>/Sales/images/btn_ReportOn.gif"	        align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_1();">
	    </span>
	    <span id=sp1 style="display:none;">
	    	<img src="<%=dirPath%>/Sales/images//btn_ConsentOn.gif"	    align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_3();">
	    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"	align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_2();">
	     </span>
	</td>
  </tr>
  <tr>
	<td height=25 width=850 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='950' height='100px' border='1'>
			<param name="DataID"		    value="ds_default2">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
			  <C> name='����SID'   ID='ap_m_sid'   	               width=80	align=left editlimit=5 show=FALSE edit=none    </C>
			  <C> name='����'     	ID=AP_TYPE_NM          	   width=55	align=center editlimit=50 show=true edit=none</C>
              <C> name='������'    	ID=EMPNMK		   	               width=69 	align=center editlimit=50 show=true edit=none</C>
              <C> name='���'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='����'		ID=PAYGRD  		               width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='�μ�'    	ID=DEPTNM	   	                   width=200 	align=center editlimit=16 show=true edit=none</C>
              <C> name='����'     	ID=AP_STATUS_D_NM         width=70 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='�ǰ�'	    ID=AP_DESC     		           width=200	align=center editlimit=200 show=true edit=true</C>
              <C> name='�����Ͻ�'	ID=U_DATE			               width=200 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width=850 align=center>
  <tr>
	<td>
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
	<param name=DataID    value=ds_default>
	<param name=BindInfo  value='  
	 <C>Col=RQST_SID	 	 	Ctrl=txt_rqst_sid    	Param=value </C>
	 <C>Col=RQST_NO 	  		Ctrl=txt_rqst_no     	Param=value </C>
	 <C>Col=RQST_MEMO		Ctrl=txt_rqst_memo  	Param=value </C>	 
	 <C>Col=RQSTAC_MEMO	Ctrl=txt_rqstac_memo  	Param=value </C>	 
	 <C>Col=RQST_STATUS 	Ctrl=txt_rqst_status  	Param=value </C>
	 <C>Col=RQST_DATE 	  	Ctrl=txt_rqst_date     Param=value </C>
	 <C>Col=AC_DATE 	  		Ctrl=txt_ac_date	   Param=value </C>	 
	 <C>Col=RQST_USE       	Ctrl=txt_rqst_use      Param=value </C>
	 <C>Col=SITE_SID          	Ctrl=txt_site_sid        Param=value </C>
	 <C>Col=PU_SITE_CD 	    Ctrl=txt_pu_site_cd   Param=value </C>
	 <C>Col=PU_EMPNO 		Ctrl=txt_pu_empno  	Param=value </C>
	 <C>Col=SITE_NM 			Ctrl=txt_site_nm  		Param=value </C>
	 <C>Col=RQST_SEQ_NM 	Ctrl=txt_rqst_seq_nm  		Param=value </C>
	 <C>Col=RQST_STATUS_NM 	Ctrl=txt_rqst_status_nm  	Param=value </C>
	  <C>Col=REAL_FILE 			Ctrl=txt_real_file	  	Param=value </C>
	 <C>Col=SYS_FILE 			Ctrl=txt_sys_file  		Param=value </C>	 
	'>
</object>
<%=HDConstant.COMMENT_END%>      
</body>
<!- BODY END -->
</html>