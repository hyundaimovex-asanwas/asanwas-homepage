<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������� :
 * ���α׷�ID 	: li0200h
 * J  S  P	    	: li0200h.jsp
 * �� �� ��		: li0200hs
 * �� �� ��		: ������
 * �� �� ��		: 2010-11-01
 * [ �������� ][������] ����
 * 
 *
 *						
 *****************************************************************************/
%>
<%@ page import="security.common.*" %>
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
		<title></title>
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
		array3 = array1[1].split("/");  //����
		array4 = array1[2].split("/");  //Ȯ��
		array5 = array1[3].split("/");  //����
		strAppline_gb="1"; //���
	}else{
	    strAppline_gb="2"; // �̰����Կ��� ó�� �� ��� 
	}	
	
	if(g_WinParam[0]=="030"){
		document.title ="���ڰ��� - ���ſ��� ";
	}
		
	// ������ �ε�
	  function fnOnLoad(){
	  
			fnSelect();
	  }

		// ���� ��ȸ
		function fnSelect() {
			
			if(g_WinParam[0]=="030"){
				
				     
			     
			     //���缱 ��ȸ 
			    if(strAppline_gb=="1"){ //��� 
			    
			        sp0.style.display = "";
				    sp1.style.display = "none"; 
				    
					  //����
			         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                      + ",v_rcp_rdg_sid="+g_WinParam[1]
				                      + ",v_rcp_dpt="+g_WinParam[3];
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(O:DS_DEFAULT4=ds_default)",  param);
				    // prompt('',ds_default.dataid);   
				     tr_post(tr1);
				    
				    //���缱 ��ȸ 
				     if(array2[4]==""){ //���缱�� �ȸ��� ��� 
							 var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
						                     + ",v_empno1="+array2[3]
						                     + ",v_empno2="+array3[3]
						                     + ",v_empno3="+array4[3]
						                     + ",v_empno4="+array5[3];
						     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(O:DS_DEFAULT5=ds_default2)",  param);
						     tr_post(tr1);
					}else {                //���缱�� ���� ��� 
		
					    var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					                       + ",v_sid="+array2[4];
					     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
					    // prompt('',ds_default.dataid);   
					     tr_post(tr1);
					 }
				     
			     }else if (strAppline_gb=="2"){//����
			 		sp0.style.display = "none";
					sp1.style.display = "";
					
					 //����
			         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				                      + ",v_rcp_rdg_sid="+g_WinParam[1]
				                      + ",v_rcp_dpt=XXXX";
				     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(O:DS_DEFAULT4=ds_default)",  param);
				    // prompt('',ds_default.dataid);   
				     tr_post(tr1);
					
					
			        // alert("g_WinParam[3]::"+g_WinParam[3]+"::");
			    	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",dsType=1"
				          + ",s_ap_m_sid="+g_WinParam[3]
				          + ",s_ap_gu=1"; 
			         ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_SALES_HELP%>My400H", "JSP(O:AP_LINE_DS=ds_default2)",  param);
			         tr_post(tr1);
				 }	  
			 }	   
		}
		
		/******************************************************************************
		// ���
		*******************************************************************************/
		function fnApply_1() {
		   var app_row="";
		
		   //������ ����� ���� 
		   
		   fnSetHeader();
		   ds_approve.addrow();
		   
		   app_row = ds_approve.rowposition;
		   
		   ds_approve.namevalue(app_row,"DOC_SID") = g_WinParam[1]; //��Ϲ�ȣ//������ȣ//���ſ�����ȣ
		   ds_approve.namevalue(app_row,"DOC_GU") = "00";  //����
		   ds_approve.namevalue(app_row,"DOC_GU2") = g_WinParam[0]; //�������� 010 ������� , 020 ��������, 030 ��������, 040 ��������, 100 ���񽺿�û 
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
    
		    ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Li0100H", "JSP(I:DS_APPROVE=ds_approve,O:msgDS=msgDS)", "proType=A, dsType=1");
	        tr_post(tr1);
		
		}
		
		/******************************************************************************
		// ��� ������ ����� ���� 
		*******************************************************************************/
		function fnSetHeader() {
			var Theader = "DOC_SID:DECIMAL(10.0),DOC_GU:STRING(10),DOC_GU2:STRING(10),"
			    				+ "AP_GU_1:STRING(10),AP_SEQ_1:DECIMAL(10.0),AP_TYPE_1:STRING(10),AP_EMPNO_1:STRING(10),"
								+ "AP_GU_2:STRING(10),AP_SEQ_2:DECIMAL(10.0),AP_TYPE_2:STRING(10),AP_EMPNO_2:STRING(10),"
								+ "AP_GU_3:STRING(10),AP_SEQ_3:DECIMAL(10.0),AP_TYPE_3:STRING(10),AP_EMPNO_3:STRING(10),"
								+ "AP_GU_4:STRING(10),AP_SEQ_4:DECIMAL(10.0),AP_TYPE_4:STRING(10),AP_EMPNO_4:STRING(10),"
								+ "AP_STATUS_M:STRING(1)"; 
						
			ds_approve.SetDataHeader(Theader);
		}
		
			
		function fnClose() {
			window.close();
		}
		
		
			// �ݼ�  
		function fnApply_2(){
			alert("�ݼ� �۾����Դϴ�.");
		}
		
			// ����  
		function fnApply_3(){
			var param="proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
 											+ ",s_ap_m_sid="+g_WinParam[3]  //����SID
 											+ ",sEmpNo="+gusrid
								            + ",sEmpNmk="+gusrnm;
		    ln_TRSetting(tr2,"<%=dirPath%><%=HDConstant.PATH_SALES_HELP%>My400H","JSP(I:AP_LINE_DS=ds_default2, O:msgDS=msgDS)", param);
	        tr_post(tr2); 
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
			if (row>0){
				txt_reg_dat.value=ds_default.namevalue(row,"REG_DAT").substring(0,16);	
			}
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
	<td height=25 width=700>

		<table width="700px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">���Ź�ȣ</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_rcp_rdg_sid" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�۾�����</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_sgn_sts_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û�Ͻ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_reg_dat" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">�������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_doc_grd_nm" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">��������</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_doc_frm_nm" type="text" class="textbox2"  style="height:19px" size="18" readonly>
				</td>
				<td height="25px"  bgcolor="#eeeeee" align=center class="text">�����μ�</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_own_dpt_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">����μ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_prd_dpt_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">������</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_prd_psn_nm" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">��������</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_prd_dat" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
			</tr>

			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">��������</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_crt_div_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">��������</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom >&nbsp;
					<input id="txt_prs_yr_lmt_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">��Ϲ�ȣ</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_doc_mag_sid" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">�߽ű���</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_snd_div_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">�����μ�</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom >&nbsp;
					<input id="txt_dtb_dpt_nm" type="text" class="textbox2"  size="18" style="height:19px" readonly>
				</td>
				<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">������ȣ</td>
				<td height="25px"  bgcolor="#FFFFFF" align="left" valign=bottom>&nbsp;
					<input id="txt_dtb_mag_sid" type="text" class="textbox2" size="18" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">����</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;
					<input id="txt_doc_tle" type="text" class="textbox2" size="90" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">����</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;
					<input id="txt_doc_cts" type="text" class="textbox2" size="90" style="height:19px" readonly>
				</td>
			</tr>
			<tr>
				<td  height="25px"  bgcolor="#eeeeee" align="center" class="text">Ű����</td>
				<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="5" valign=bottom>&nbsp;
					<input id="txt_doc_kwd" type="text" class="textbox2" size="90" style="height:19px" readonly>
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
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:50;height:15;">���缱</font>
	</td>
	<td height=30  align ="right">
	    <span id=sp0 style="display:none;">
	    	<img src="<%=dirPath%>/Sales/images/btn_ReportOn.gif"	        align=right	style="cursor:hand;position:relative;left:0px;top:0px" onClick="fnApply_1();">
	    </span>
	    <span id=sp1 style="display:none;">
	    	<img src="<%=dirPath%>/Sales/images/btn_SendbackOn.gif"	align=right	style="cursor:hand;position:relative;left:0px;top:0px" onClick="fnApply_2();">
	    	<img src="<%=dirPath%>/Sales/images//btn_ConsentOn.gif"	    align=right	style="cursor:hand;position:relative;left:0px;top:0px" onClick="fnApply_3();">
	     </span>
	</td>
  </tr>
  <tr>
	<td height=25 width=700 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_apline classid=<%=HDConstant.CT_GRID_CLSID%> width='700px' height='100px' border='1'>
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
              <C> name='����'		ID=PAYGRD   		               width=90 	align=center editlimit=20 show=true edit=none</C>
              <C> name='�μ�'    	ID=DEPTNM	   	                   width=90 	align=center editlimit=16 show=true edit=none</C>
              <C> name='����'     	ID=AP_STATUS_D_NM         width=70 	align=center editlimit=30 show=true edit=none </C>
              <C> name='�ǰ�'	    ID=AP_DESC     		           width=100	align=center editlimit=14 show=true edit=none</C>
              <C> name='�����Ͻ�'	ID=U_DATE			               width=209 	align=center editlimit=50 show=true edit=none</C>
			">
		</object>   
		<%=HDConstant.COMMENT_END%>		
	</td>
  </tr>
</table>


<table border="0" cellpadding="0" cellspacing="0" width=700 align=center>
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
	 <C>Col=DTB_MAG_SID	  Ctrl=txt_dtb_mag_sid     Param=value </C>
	 <C>Col=DOC_MAG_SID	  Ctrl=txt_doc_mag_sid    Param=value </C>
	 <C>Col=DOC_GRD_NM 	  Ctrl=txt_doc_grd_nm     Param=value </C>
	 <C>Col=DOC_FRM_NM 	  Ctrl=txt_doc_frm_nm     Param=value </C>
	 <C>Col=OWN_DPT_NM 	  Ctrl=txt_own_dpt_nm     Param=value </C>
	 <C>Col=PRD_DPT_NM 	  Ctrl=txt_prd_dpt_nm      Param=value </C>
	 <C>Col=PRD_PSN_NM      Ctrl=txt_prd_psn_nm     Param=value </C>
	 <C>Col=PRD_DT   	          Ctrl=txt_prd_dat             Param=value </C>
	 <C>Col=CRT_DIV_NM 	      Ctrl=txt_crt_div_nm        Param=value </C>
	 <C>Col=PRS_YR_LMT_NM Ctrl=txt_prs_yr_lmt_nm  Param=value </C>
	 <C>Col=DOC_TLE 	          Ctrl=txt_doc_tle             Param=value </C>
	 <C>Col=DOC_CTS 	          Ctrl=txt_doc_cts            Param=value </C>
	 <C>Col=DOC_KWD 	          Ctrl=txt_doc_kwd           Param=value </C>
	 <C>Col=SGN_STS_NM      Ctrl=txt_sgn_sts_nm      Param=value </C>
	 <C>Col=SND_DIV_NM        Ctrl=txt_snd_div_nm        Param=value </C>
	 <C>Col=OWN_DPT_NM      Ctrl= txt_dtb_dpt_nm        Param=value </C>
	 <C>Col=RCP_RDG_SID      Ctrl=txt_rcp_rdg_sid      Param=value </C>
	 <C>Col=REG_DAT             Ctrl=txt_reg_dat             Param=value </C>
	'>
</object>
<%=HDConstant.COMMENT_END%>      

</body>
<!- BODY END -->
</html>