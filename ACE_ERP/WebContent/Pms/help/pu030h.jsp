<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������ :ǰ���ۼ�
 * ���α׷�ID 	: pu030h
 * J  S  P	    	: pu030h.jsp
 * �� �� ��		: pu030hs
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2011-12-08
 * [ �������� ][������] ����
 * 
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
		<title>���ڰ��� -ǰ��</title>
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
     
//    alert("g_WinParam::"+g_WinParam);
//   alert("g_WinParam[0]::"+g_WinParam[0]+"::g_WinParam[1]::"+g_WinParam[1]+"::g_WinParam[2]::"+g_WinParam[2]+"::g_WinParam[3]::"+g_WinParam[3]);
    
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
	  
		//cfStyleGrid(getObjectFirst("gcbn_02"), "comn");
		cfStyleGrid(getObjectFirst("gr_apline"), "comn");
		cfStyleGrid(getObjectFirst("gr_apline_rqst"), "comn");
		cfStyleGrid(getObjectFirst("gr_RcpDpt"), "comn");
		cfStyleGrid(getObjectFirst("gr_RcpDpt2"), "comn");
	  
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
		                       + ",v_est_sid="+g_WinParam[1];
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT6=ds_default6)",  param);
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
			
			// ��ü����������
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                       + ",v_est_sid="+g_WinParam[1]
		                       + ",v_rqst_sid="+g_WinParam[4];
		                      // alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT7=ds_default7 )",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
		     
			 // û��(����)��������		    
		     var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                     + ",v_rqst_sid="+g_WinParam[4];
		 	//alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT9=ds_default9)",  param);
		     tr_post(tr1);
		     
	   	      // ����ǰ��
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								+ ",v_est_sid="+g_WinParam[1]
		                       + ",v_vend_cd="+g_WinParam[5] ;
		                       //alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT8=ds_default8 )",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
	
		     if(strAppline_gb=="1"){
			     //���缱 ��ȸ 
			     
			    sp0.style.display = "";
				sp1.style.display = "none";
				
				
				if(0[4]==""||0[4]=="undefined"||array2[4]=="undefined"||array2[4]==""){ //���缱�� �ȸ��� ��� 
					
					 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=5"
				                     + ",v_empno1="+array2[3]
				                     + ",v_empno2="+array3[3]
				                     + ",v_empno3="+array4[3]
				                     + ",v_empno4="+array5[3];
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT5=ds_default2)",  param);
				     tr_post(tr1);
					
				}else {                //���缱�� ���� ��� 
			     
				    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
				                     + ",v_sid="+array2[4];
				 	//alert(param);
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
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
		}
		
		
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
		   ds_approve.namevalue(app_row,"DOC_GU2") = g_WinParam[0]; // ( 010 ������� , 020 ��������, 030 ��������, 040 ��������, 100 ���񽺿�û .310 ����û��, 320 ����û������, 330 ����ǰ��,340 ���Ű˼�)
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
    
		    ln_TRSetting(tr3,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(I:DS_APPROVE=ds_approve,O:msgDS=msgDS)", "proType=A, dsType=1");
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
			alert("�ݼ� �۾����Դϴ�.");
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
		// ��ǰ�������ȸ
		function fnSelectDetail2(row) {
			 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					   + ",v_est_sid="+getObjectFirst("ds_default7").NameValue(row, "EST_SID")
		               + ",v_vend_cd="+getObjectFirst("ds_default7").NameValue(row, "VEND_CD");

		     ln_TRSetting(tr5,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H",
		     				  "JSP(O:DS_DEFAULT8=ds_default8 )",
		     				  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr5);
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
		<script language=JavaScript  for=ds_default6 event="OnLoadStarted()" >
			//fnShowLoading(410,180);
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds_default6 event="OnLoadCompleted(row,colid)">
			//fnHideLoading();
			//if (row>0){
			//	txt_reg_dat.value=ds_default6.namevalue(row,"REG_DAT").substring(0,16);	
			//}
		</script>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds_default6 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";

			//fnHideLoading();
		</script>
		<%//�������� Ŭ���� ����ǰ�� ��ȸ %>
		<script language=javascript for="gr_RcpDpt" event="OnClick(Row, Colid)">
		 	    fnSelectDetail2(Row);				
		</script>
		
<%/*=============================================================================
			 DataSet Component's Event Message Scripts
	=============================================================================*/
%>	
	<script language=JavaScript for=ds_default7 event="OnLoadCompleted(Row)">
		if ( ds_default7.CountRow > 0 )
			fnSelectDetail2(1);
	</script>
			
<!-----------------------------------------------------------------------------
	DataSet Components ���� 
	# ��ȸ�� �� ��� ����Ѵ�. 
------------------------------------------------------------------------------->
<%=HDConstant.COMMENT_START%>

<object  id=ds_default6 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
<object  id=ds_default7 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
<object  id=ds_default8 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object  id=ds_default9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>
<object  id=ds_default2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr       value="-APPROVE_TYPE">
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
<object  id="tr5" classid=<%=HDConstant.CT_TR_CLSID%>>
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
 	<td height=25>
	  <img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">�⺻����</font>
	  </td>
  </tr>
  <tr>
	<td height=25 width=950>
		<table width="950px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
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
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ǰ�ǹ�ȣ</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_con_no" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ǰ������</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_date_con" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">���޾�ü</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_vend_nm" type="text" class="textbox2"  size="25" style="height:19px" maxLength="10" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">���ޱ�(Vat����)</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left"  >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                    <object id=txt_prepay_amt classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=19 width=120 align=center  >
                        <param name=Text        value="">
                        <param name=Format      value="">
						<param name=Alignment	value=0>
						<param name=Border		value=false>
                        <param name=ReadOnly    value="true">
						<param name=Visible    value="true">                                                
						<param name=Numeric		value="true">
						<param name=IsComma   	value=true>
                    </object><%=HDConstant.COMMENT_END%>  										
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">���ޱ���</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_prepay_amt_rate" type="text" class="textbox2"  size="10" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">�����</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_site_nm" type="text" class="textbox2"  size="25" style="height:19px" readonly>
				</td>
				
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">���ں���������(")</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left"  >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                    <object id=txt_db_amt classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=19 width=120 align=center >
                        <param name=Text        value="">
                        <param name=Format      value="">
                        <param name=Alignment	value=0>
						<param name=Border		value=false>
                        <param name=ReadOnly    value="true">
						<param name=Visible    value="true">                        
						<param name=Numeric		value="true">
						<param name=IsComma   	value=true>
                    </object><%=HDConstant.COMMENT_END%>  										
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">���ں�����������</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left"  >&nbsp;
					<input id="txt_db_rate" type="text" class="textbox2"  size="10" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">�����Ⱓ</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_term_grn" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">������ຸ����(")</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left"  >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                    <object id=txt_ch_amt classid=CLSID:4AEAFD66-8D65-41AC-B1D1-57E7FF2A734F height=19 width=120 align=center  >
                        <param name=Text        value="">
                        <param name=Format      value="">
						<param name=Alignment	value=0>
						<param name=Border		value=false>
                        <param name=ReadOnly    value="true">
						<param name=Visible    value="true">                                                
						<param name=Numeric		value="true">
						<param name=IsComma   	value=true>
                    </object><%=HDConstant.COMMENT_END%>  										
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">������ຸ������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_ch_rate" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
					<td height="25px"  bgcolor="#eeeeee" align=center class="text">��ݺ�δ�</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_bur_trans" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			
			
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">�ε�����</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_terms_trans" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">��������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_terms_pay" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����â��</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_put_wh" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">û��Ư�����</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom colspan="3">&nbsp;
                    <input id="txt_rqst_memo" type="text" class="textbox2"  size="60" style="height:19px" readonly>
                </td>
               <td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��������</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_date_ddl" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">ǰ��Ư�����</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom colspan="5">&nbsp;
					<input id="txt_con_note" type="text" class="textbox2" size="100" style="height:19px" readonly	>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">�������ؼ�����</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom colspan="5">&nbsp;
					<input id="txt_osv_pvr" type="text" class="textbox2" size="100" style="height:19px" readonly	>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">÷������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom colspan="5">&nbsp;
                    <input type="text" name='txt_real_file' id="txt_real_file" style="width:500px;" class='textbox2'   readOnly="readonly">
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

<!-- ���� / [����|����|����] -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">������ü</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='95px' border='1'>
			<param name="DataID"		    value="ds_default7">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="ViewSummary"       value="0">
			<param name="Format" 			value="
	    		 <C> name='����' 				ID={CurRow}	   			width=100 		align=CENTER	edit=none show=TRUE</C>
	             <C> name='EST_SID' 			ID='EST_SID'	   		width=80 		align=CENTER	edit=none show=FALSE</C>
	             <C> name='�ŷ�ó�ڵ�' 		ID='VEND_CD'   		width=80 		align=CENTER	edit=none show=false</C>
	             <C> name='���»��' 			ID='VEND_NM'    		width=200 	align=CENTER	edit=none</C>
	             <C> name='�����ݾ�'			ID='TOT_EST_AMT'  		width=150 		align=right 	 decao=0 edit=none </C>
	             <C> name='�����ݾ�'			ID='TOT_FN_EST_AMT'  		width=150 		align=right 	 decao=0	edit=none</C>
	             <C> name='������'				ID='UD_EST_AMT'  		width=100 		align=right 	 decao=0 edit=none</C>                                                  
	             <C> name='��������(%)'		ID='UD_RATE' 	 		width=100 		align=right  dec=1 edit=none</C>                                                  
   	             <C> name='��������ȣ'		ID='EST_NO'    		width=150 	show=false 	 align=CENTER	edit=none</C>
           ">
		</object>   
		<%=HDConstant.COMMENT_END%>		
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
	<td>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt2 classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='180px' border='1'>
			<param name="DataID"		    value="ds_default8">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="ViewSummary"       value="1">
			<param name="Format" 			value="
			 <C> name='EST_SID' 			ID='EST_SID'   			width=80 		align=CENTER		edit=none show=FALSE</C>
             <C> name='RQST_SID' 		ID='RQST_SID'   		width=80 		align=CENTER		edit=none show=FALSE</C>
             <C> name='����' 		ID='ITEM_SEQ'	   	width=30 	align=CENTER	edit=none show=TRUE	</C>
             <C> name='ITEM_SID' 		ID='ITEM_SID'   		width=80 		align=CENTER		edit=none show=FALSE</C>
             <C> name='ǰ��' 		ID='ITEM_NM'    		width=150 	align=left	 	edit=none</C>
             <C> name='�԰�' 				ID='ITEM_SIZE'   		width=150 		align=CENTER	 	edit=none</C>
             <C> name='����' 				ID='ITEM_UNIT'   		width=40 		align=CENTER		edit=none </C>

        <G> name='����'
             <C> name='����' 		ID='DG_CNT'   		width=47 		align=right		edit=none </C>
             <C> name='�ܰ�'    	ID='DG_AMT'    	    width=67 		align=right	 show=true decao=0	 </C>
             <C> name='�ݾ�'   		ID='DG_SUM_AMT'   width=77 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
        </G>
		<G> name='����'
             <C> name='����' 		ID='RQST_CNT'   	width=47 		align=right		edit=none </C>
             <C> name='�ܰ�' 		ID='YS_AMT'   		width=67 		align=right	 decao=0 	</C>
             <C> name='�ݾ�'    	ID='YS_SUM_AMT'		width=77 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
        </G>
		<G> name='����'
             <C> name='����' 		ID='EST_CNT'   		width=47 		align=right		edit=none </C>
             <C> name='�ܰ�' 		ID='FN_EST_AMT'   	width=67 		align=right	 decao=0 	</C>
             <C> name='�ݾ�'    	ID='FN_SUM_AMT'		width=77 		align=right	 show=true decao=0	 sumtext='@sum' sumtextalign='right'	</C>
        </G>


			 <G> name='���(%)'
				 <C> name='����'    		ID='VS_DG'	width=60 		align=RIGHT  show=true edit=none 	decao=1 dec=1	sumtext={sum(FN_SUM_AMT)/sum(DG_SUM_AMT)*100} sumtextalign='right'</C>
				 <C> name='����'    		ID='VS_YS'	width=60 		align=RIGHT  show=true edit=none 	 decao=1 dec=1	sumtext={sum(FN_SUM_AMT)/sum(YS_SUM_AMT)*100} sumtextalign='right'	</C>
			 </G>
              <C> name='�ҿ���' 		ID='DATE_USE'    	width=80 		align=CENTER  show=false edit=none 	 </C>
              <C> name='���' 			ID='RQST_NOTE'    	width=100 	align=LEFT	    show=true edit=none 	 </C>
              <C> name='�뵵' 			ID='RQST_USE'    	width=50 		align=CENTER  show=true edit=none 	 </C>
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
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline_rqst classid=<%=HDConstant.CT_GRID_CLSID%> width='950' height='100px' border='1'>
			<param name="DataID"		    value="ds_default9">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
			  <C> name='����SID'   ID='ap_m_sid'   	               width=80	align=left editlimit=5 show=FALSE edit=none    </C>
			  <C> name='����'     	ID=AP_TYPE_NM          	   width=80	align=center editlimit=50 show=true edit=none</C>
              <C> name='������'    	ID=EMPNMK		   	               width=80 	align=center editlimit=50 show=true edit=none</C>
              <C> name='���'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='����'		ID=PAYGRD  		               width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='�μ�'    	ID=DEPTNM	   	                   width=250 	align=center editlimit=16 show=true edit=none</C>
              <C> name='����'     	ID=AP_STATUS_D_NM         width=80 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='�ǰ�'	    ID=AP_DESC     		           width=110	align=center editlimit=14 show=true edit=none</C>
              <C> name='�����Ͻ�'	ID=U_DATE			               width=250 	align=center editlimit=50 show=true edit=none</C>
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
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='100px' border='1'>
			<param name="DataID"		    value="ds_default2">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
			  <C> name='����SID'   ID='ap_m_sid'   	               width=80	align=left editlimit=5 show=FALSE edit=none    </C>
			  <C> name='����'     	ID=AP_TYPE_NM          	   width=80	align=center editlimit=50 show=true edit=none</C>
              <C> name='������'    	ID=EMPNMK		   	               width=80 	align=center editlimit=50 show=true edit=none</C>
              <C> name='���'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='����'		ID=PAYGRD  		               width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='�μ�'    	ID=DEPTNM	   	                   width=250 	align=center editlimit=16 show=true edit=none</C>
              <C> name='����'     	ID=AP_STATUS_D_NM         width=80 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='�ǰ�'	    ID=AP_DESC     		           width=110	align=center editlimit=14 show=true edit=none</C>
              <C> name='�����Ͻ�'	ID=U_DATE			               width=250 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>
<table border="0" cellpadding="0" cellspacing="0" width=950 align=center>
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
	<param name=DataID    value=ds_default6>
	<param name=BindInfo  value='  
	 <C>Col=RQST_SID	 	 	Ctrl=txt_rqst_sid    	Param=value </C>
	 <C>Col=RQST_NO 	  		Ctrl=txt_rqst_no     	Param=value </C>
	 <C>Col=RQST_STATUS 	Ctrl=txt_rqst_status  	Param=value </C>
	 <C>Col=CON_SID	 	 	Ctrl=txt_con_sid    	Param=value </C>
 	 <C>Col=RQST_MEMO		Ctrl=txt_rqst_memo  	Param=value </C>
	 <C>Col=CON_NO 	  		Ctrl=txt_con_no     	Param=value </C>
	 <C>Col=VEND_NM		 	Ctrl=txt_vend_nm  	Param=value </C>
	 <C>Col=RQST_DATE 	  	Ctrl=txt_rqst_date     Param=value </C>
 	 <C>Col=DATE_CON 	  	Ctrl=txt_date_con     Param=value </C>
 	  <C>Col=DATE_DDL	 	  	Ctrl=txt_date_ddl     Param=value </C>	 
	 <C>Col=AC_DATE 	  		Ctrl=txt_ac_date       Param=value </C>	 
	 <C>Col=PUT_WH 	  		Ctrl=txt_put_wh       Param=value </C>	 
	 <C>Col=RQST_USE       	Ctrl=txt_rqst_use      Param=value </C>
	 <C>Col=SITE_SID          	Ctrl=txt_site_sid        Param=value </C>
	 <C>Col=PU_SITE_CD 	    Ctrl=txt_pu_site_cd   Param=value </C>
	 <C>Col=PU_EMPNO 		Ctrl=txt_pu_empno  	Param=value </C>
	 <C>Col=SITE_NM 			Ctrl=txt_site_nm  		Param=value </C>
	 <C>Col=EST_SID 			Ctrl=txt_est_sid 		Param=value </C>	 
	 <C>Col=PREPAY_AMT_RATE  	Ctrl=txt_prepay_amt_rate     Param=value </C>
	 <C>Col=PREPAY_AMT     Ctrl=txt_prepay_amt  		Param=text </C>
	 <C>Col=CH_RATE          	Ctrl=txt_ch_rate        Param=value </C>
	 <C>Col=CH_AMT 	    	Ctrl=txt_ch_amt   		Param=text </C>
	 <C>Col=DB_RATE 			Ctrl=txt_db_rate  		Param=value </C>
	 <C>Col=DB_AMT 			Ctrl=txt_db_amt  		Param=text </C>
	 <C>Col=TERM_GRN 		Ctrl=txt_term_grn 		Param=value </C>	 
     <C>Col=REAL_FILE 			Ctrl=txt_real_file	  	Param=value </C>
	 <C>Col=SYS_FILE 			Ctrl=txt_sys_file  		Param=value </C>
	 <C>Col=TERMS_TRANS	Ctrl=txt_terms_trans  Param=value </C>
	 <C>Col=TERMS_PAY 	  	Ctrl=txt_terms_pay   	Param=value </C>
	 <C>Col=BUR_TRANS 	  	Ctrl=txt_bur_trans    	Param=value </C>
	 <C>Col=CON_NOTE 	  	Ctrl=txt_con_note     Param=value </C>
	 <C>Col=OSV_PVR 	  		Ctrl=txt_osv_pvr     	Param=value </C>
	'>
</object>
<%=HDConstant.COMMENT_END%>      
</body>
<!- BODY END -->
</html>