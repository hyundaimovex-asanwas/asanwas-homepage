<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������ :�˼�
 * ���α׷�ID 	: pu040h
 * J  S  P	    	: pu040h.jsp
 * �� �� ��		: pu040hs
 * �� �� ��		: �ڰ汹
 * �� �� ��		: 2012-02-01
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
	 	cfStyleGrid(getObjectFirst("gr_apline"), "comn");
		cfStyleGrid(getObjectFirst("gr_RcpDpt"), "comn");
		cfStyleGrid(getObjectFirst("gr_RcpDpt2"), "comn");
	  
		fnSelect();
		}
	// ���� ��ȸ
		function fnSelect() {
			
			//�⺻���� ��ȸ 
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                       + ",v_con_sid="+g_WinParam[1]
		                       + ",v_cgcd_sid="+g_WinParam[4]
		                       + ",v_date_cgcd="+g_WinParam[5]; 
		                       //alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(O:DS_DEFAULT6=ds_default6)",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
		     
		      // ��ü����������
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                       + ",v_est_sid="+g_WinParam[7]
		                       + ",v_rqst_sid="+g_WinParam[6];
		                      // alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(O:DS_DEFAULT7=ds_default7 )",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
	     
	   	      // ����ǰ��
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								+ ",v_con_sid="+g_WinParam[1]
		                       + ",v_date_cgcd="+g_WinParam[5] ;
		                       //alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(O:DS_DEFAULT8=ds_default8 )",  param);
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
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(O:DS_DEFAULT5=ds_default2)",  param);
				     tr_post(tr1);
					
				}else {                //���缱�� ���� ��� 
			     
				    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
				                     + ",v_sid="+array2[4];
				 	//alert(param);
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
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
		   ds_approve.namevalue(app_row,"DOC_SID") = g_WinParam[1]; //��Ϲ�ȣ//������ȣ//���ſ�����ȣ   ==>CON_SID
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
		   ds_approve.namevalue(app_row,"NUM_PARAM2") = g_WinParam[4]; //CGCD_SID;�˼�������SID
		   ds_approve.namevalue(app_row,"CH_PARAM1") = g_WinParam[5]; //DATE_CGCD;�˼�����������
		   ds_approve.namevalue(app_row,"NUM_PARAM3") = g_WinParam[6];//RQST_SID 		   		   		   
		   ds_approve.namevalue(app_row,"NUM_PARAM4") = g_WinParam[7];//EST_SID 		   		   		   		   
	
		   //prompt('',ds_approve.text);
    
		    ln_TRSetting(tr3,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(I:DS_APPROVE=ds_approve,O:msgDS=msgDS)", "proType=A, dsType=1");
	        tr_post(tr3);
		}
		

		// ��� ������ ����� ���� 
		function fnSetHeader() {
			var Theader = "DOC_SID:DECIMAL(10.0),DOC_GU:STRING(10),DOC_GU2:STRING(10),"
			    				+ "AP_GU_1:STRING(10),AP_SEQ_1:DECIMAL(10.0),AP_TYPE_1:STRING(10),AP_EMPNO_1:STRING(10),"
								+ "AP_GU_2:STRING(10),AP_SEQ_2:DECIMAL(10.0),AP_TYPE_2:STRING(10),AP_EMPNO_2:STRING(10),"
								+ "AP_GU_3:STRING(10),AP_SEQ_3:DECIMAL(10.0),AP_TYPE_3:STRING(10),AP_EMPNO_3:STRING(10),"
								+ "AP_GU_4:STRING(10),AP_SEQ_4:DECIMAL(10.0),AP_TYPE_4:STRING(10),AP_EMPNO_4:STRING(10),"
								+ "AP_STATUS_M:STRING(1),NUM_PARAM2:DECIMAL(10.0),CH_PARAM1:STRING(20),NUM_PARAM3:DECIMAL(10.0),NUM_PARAM4:DECIMAL(10.0)"; 
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
		
 
		// ��ǰ�������ȸ
		function fnSelectDetail2(row) {
		//alert(row);
			 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								+ ",v_est_sid="+getObjectFirst("ds_default7").NameValue(row, "EST_SID")
		                       + ",v_vend_cd="+getObjectFirst("ds_default7").NameValue(row, "VEND_CD");
		                       
		          //  + ",v_est_sid="+getObjectFirst("ds_tender").NameValue(row, "EST_SID")
                  //  + ",v_vend_cd="+getObjectFirst("ds_tender").NameValue(row, "VEND_CD");
                    
		   //                    alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu040H", "JSP(O:DS_DEFAULT8=ds_default8 )",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
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
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='40px' border='1'>
			<param name="DataID"		    value="ds_default7">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="Format" 			value="
	    		 <C> name='��������' 			ID='CHOICE_YN'	   	width=80 		align=CENTER	edit=none show=FALSE</C>
	             <C> name='EST_SID' 			ID='EST_SID'	   		width=80 		align=CENTER	edit=none show=FALSE</C>
	             <C> name='�ŷ�ó�ڵ�' 		ID='VEND_CD'   		width=80 		align=CENTER	edit=none show=FALSE</C>
	             <C> name='���»��' 			ID='VEND_NM'    		width=200 	align=CENTER	edit=none</C>
	             <C> name='�����ݾ�'			ID='TOT_EST_AMT'  width=150 		align=right 	 decao=0 edit=none </C>
	             <C> name='�����ݾ�'			ID='TOT_FN_EST_AMT'  	width=150 		align=right 	 decao=0	edit=none</C>
	             <C> name='������'				ID='UD_EST_AMT'  	width=150 		align=right 	 decao=0 edit=none</C>                                                  
   	             <C> name='��������ȣ'		ID='EST_NO'    		width=150 	show=false 	 align=CENTER	edit=none</C>
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
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">ǰ��</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt2 classid=<%=HDConstant.CT_GRID_CLSID%> width='950px' height='550px' border='1'>
			<param name="DataID"		    value="ds_default8">
			<param name="ColSizing"	    value="true">
			<param name="Fillarea"		    value="false">
			<param name="Editable"		    value="true">
			<param name="BorderStyle"	value="0">
			<param name=SortView  		    value="Left">
			<param name="SuppressOption"    value="1">
			<param name="ViewSummary"       value="1">
			<param name="Format" 			value="
				 <C> name='����'     	   	    ID=CurRow   	    width=50	    align=center  show=false edit=none Value={CurRow}</C>
                 <C> name='EST_SID' 			ID='EST_SID'   		width=80 		align=CENTER		edit=none  show=false </C>
                 <C> name='CON_SID' 		ID='CON_SID'   		width=80 		align=CENTER		edit=none  show=false</C>
                 <C> name='RQST_SID' 		ID='RQST_SID'   	width=80 		align=CENTER		edit=none  show=false </C>
                 <C> name='ITEM_SID' 		ID='ITEM_SID'   	width=80 		align=CENTER		edit=none  show=false </C>
                 <C> name='�˼�������SID' 			ID='CGC_SID'	   	width=200 		align=CENTER	edit=none show=false	suppress=1</C>
                 <C> name='�˼�������SID' 			ID='CGCD_SID'	   	width=200 		align=CENTER	edit=none show=false	suppress=2</C>
                 <C> name='�˼�����'	 		ID='DATE_CGCD'   	width=80 		align=CENTER	editlimit=8	edit=true show=true		suppress=3</C>
                 <C> name='ǰ��' 				ID='ITEM_NM'    	width=150 	align=CENTER	 	edit=none sumtext='��'  sumtextalign='right' suppress=4</C>
                 <C> name='�԰�' 				ID='ITEM_SIZE'   	width=150 		align=CENTER	 	edit=none sumtext='@count' sumtextalign='right' suppress=5</C>
                 <C> name='����' 				ID='ITEM_UNIT'   	width=60 		align=CENTER		edit=none sumtext='ǰ��' sumtextalign='left' suppress=6</C>
                 <C> name='����' 				ID='EST_CNT'   	width=60 		align=CENTER		edit=none </C>
				<G> name='����'
                 <C> name='�ܰ�' 				ID='FN_EST_AMT'   	width=85 		align=right	 decao=0 	edit=none</C>
                 <C> name='�ݾ�'    				ID='FN_SUM_AMT'  	width=85 		align=right	 show=true decao=0	 sumtext='@sum' sumtextalign='right'	edit=none</C>
                </G>
						<G> name='��ȸ����'
	  						 <C> name='����' 		ID='CGCD_PRE_CNT'	width=85 		align=right	 show=true	decao=0 		edit=none</C>
    	                     <C> name='�ݾ�'    		ID='CGCD_PRE_AMT'  width=85 		align=right	 show=true	decao=0	 sumtext='@sum' sumtextalign='right'	edit=none</C>
						</G>
						<G> name='�ݿ�����'
 							 <C> name='����' 		ID='CGCD_NOW_CNT'	width=85 		align=right	 show=true	decao=0 	 	edit=true	</C>
            	             <C> name='�ݾ�'    		ID='CGCD_NOW_AMT'  	width=85 		align=right	 show=true	decao=0	 sumtext='@sum' sumtextalign='right'	edit=none	</C>
						</G>
						<G> name='��������'
							 <C> name='����' 		ID='CGCD_SUM_CNT'	width=85 		align=right	 show=true	decao=0 		edit=none</C>
                    	     <C> name='�ݾ�'    		ID='CGCD_SUM_AMT'  width=85 		align=right	 show=true	decao=0	 sumtext='@sum' sumtextalign='right'	edit=none</C>
						</G>
						<G> name='�ܿ���'
							 <C> name='����' 		ID='CGCD_RES_CNT'	width=85 		align=right	 show=true	decao=0 	 	edit=none</C>
                         	<C> name='�ݾ�'    		ID='CGCD_RES_AMT'  width=85 		align=right	 show=true	decao=0	 sumtext='@sum' sumtextalign='right'	edit=none</C>
						</G>
                         <C> name='�˼�Ư�����V' 	ID='CGCD_NOTE'   		width=200 		align=CENTER	edit=true show=true</C>                                                  
						<G> name='����'
                         <C> name='�ܰ�'    			ID='DG_AMT'    	    width=85 		align=right	 show=false  decao=0	sumtext='��' sumtextalign='left'	edit=none </C>
                         <C> name='�ݾ�'   			ID='DG_SUM_AMT'   width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=false  edit=none	decao=0	 </C>
                         </G>
                         <G> name='����'
                         <C> name='�ܰ�' 			ID='YS_AMT'   			width=85 		align=right	 decao=0 sumtext='��' sumtextalign='left'	show=false edit=none</C>
                         <C> name='�ݾ�'    			ID='YS_SUM_AMT'    width=85 		align=right	 sumtext='@sum' sumtextalign='right'	show=false  edit=none	decao=0	 </C>
                         </G>
                         <C> name='�ŷ�ó�ڵ�' 	ID='VEND_CD'   		width=200 		align=CENTER	edit=none show=false</C>                                                  
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
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">���缱</font>
	</td>
	<td height=30  align ="right">
	  	
		<span id=sp0 style="display:none;">
	    	<img src="<%=dirPath%>/Sales/images/btn_ReportOn.gif"	        align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_1();">
	    </span>
	    <span id=sp1 style="display:none;">
	    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"	align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_2();">
	    	<img src="<%=dirPath%>/Sales/images//btn_ConsentOn.gif"	    align=right	style="cursor:pointer;position:relative;left:0px;top:0px" onClick="fnApply_3();">
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
			  <C> name='����'     	ID=AP_TYPE_NM          	   width=55	align=center editlimit=50 show=true edit=none</C>
              <C> name='������'    	ID=EMPNMK		   	               width=69 	align=center editlimit=50 show=true edit=none</C>
              <C> name='���'    	ID=EMPNO		   	               width=80 	align=center editlimit=50 show=false edit=none</C>
              <C> name='����'		ID=PAYGRD  		               width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='�μ�'    	ID=DEPTNM	   	                   width=90 	align=center editlimit=16 show=true edit=none</C>
              <C> name='����'     	ID=AP_STATUS_D_NM         width=70 	align=center editlimit=30 show=true edit=none  </C>
              <C> name='�ǰ�'	    ID=AP_DESC     		           width=100	align=center editlimit=14 show=true edit=none</C>
              <C> name='�����Ͻ�'	ID=U_DATE			               width=209 	align=center editlimit=50 show=true edit=none</C>
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
	 <C>Col=CON_NO 	  		Ctrl=txt_con_no     	Param=value </C>
	 <C>Col=VEND_NM		 	Ctrl=txt_vend_nm  	Param=value </C>
	 <C>Col=RQST_DATE 	  	Ctrl=txt_rqst_date     Param=value </C>
	 <C>Col=DATE_CGC 	  	Ctrl=txt_date_cgc     Param=value </C>	
	 <C>Col=AC_DATE 	  		Ctrl=txt_ac_date       Param=value </C>	 	  
	 <C>Col=RQST_USE       	Ctrl=txt_rqst_use      Param=value </C>
	 <C>Col=SITE_SID          	Ctrl=txt_site_sid        Param=value </C>
	 <C>Col=PU_SITE_CD 	    Ctrl=txt_pu_site_cd   Param=value </C>
	 <C>Col=PU_EMPNO 		Ctrl=txt_pu_empno  	Param=value </C>
	 <C>Col=SITE_NM 			Ctrl=txt_site_nm  		Param=value </C>
	 <C>Col=EST_SID 			Ctrl=txt_est_sid 		Param=value </C>	 
	 <C>Col=PREPAY_AMT_RATE  	Ctrl=txt_prepay_amt_rate     Param=value </C>
	 <C>Col=PREPAY_AMT     Ctrl=txt_prepay_amt  Param=value </C>
	 <C>Col=CH_RATE          	Ctrl=txt_ch_rate        Param=value </C>
	 <C>Col=CH_AMT 	    	Ctrl=txt_ch_amt   		Param=value </C>
	 <C>Col=DB_RATE 			Ctrl=txt_db_rate  		Param=value </C>
	 <C>Col=DB_AMT 			Ctrl=txt_db_amt  		Param=value </C>
	 <C>Col=TERM_GRN 		Ctrl=txt_term_grn 		Param=value </C>	 
     <C>Col=REAL_FILE 			Ctrl=txt_real_file	  	Param=value </C>
	 <C>Col=SYS_FILE 			Ctrl=txt_sys_file  		Param=value </C>
	 <C>Col=TERMS_TRANS	Ctrl=txt_terms_trans  Param=value </C>
	 <C>Col=TERMS_PAY 	  	Ctrl=txt_terms_pay   	Param=value </C>
	 <C>Col=BUR_TRANS 	  	Ctrl=txt_bur_trans    	Param=value </C>
	 <C>Col=CON_NOTE 	  	Ctrl=txt_con_note     Param=value </C>
	 <C>Col=CGC_NOTE 	  	Ctrl=txt_cgc_note     Param=value </C>
	 <C>Col=OSV_PVR 	  		Ctrl=txt_osv_pvr     	Param=value </C>
	'>
</object>
<%=HDConstant.COMMENT_END%>      
</body>
<!- BODY END -->
</html>