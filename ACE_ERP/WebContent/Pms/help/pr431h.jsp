<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ������ :�������
 * ���α׷�ID 	: pr431h
 * J  S  P	    : pr431h.jsp
 * �� �� ��		: pr431h
 * �� �� ��		: �̵���
 * �� �� ��		: 2016-03-21
 * [ �������� ][������] ����
 * [2016-03-21][�̵���]
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
		<title>���ڰ��� - �������</title>
		<jsp:include page="/Sales/common/include/head.jsp"/>
<%
	/***************************************************************************
	 *                            ����� ���� Java Script                       *
	 ***************************************************************************/
%>
	<script language="javascript">
	var  gusrid  		="<%=(String)session.getAttribute("vusrid")%>";
	var  gusrnm		="<%=(String)session.getAttribute("vusrnm")%>";
	
    var g_WinParam = window.dialogArguments;
     
    //alert("g_WinParam[0]::"+g_WinParam[0]+"::g_WinParam[1]::"+g_WinParam[1]);
    
    var array1= new Array();
	var array2= new Array();

		
		
	// ������ �ε�
	  function fnOnLoad(){

		cfStyleGrid(getObjectFirst("gr_RcpDpt"), "comn");
		
		fnSelect();
		    
	  }

		// ���� ��ȸ
		function fnSelect() {
			

			//�⺻���� ��ȸ 
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
																	             + ",v_cd_site="+g_WinParam[0]
	           																	 + ",v_no_silheng="+g_WinParam[1];       
   
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr431H", "JSP(O:DS_DEFAULT1=ds_default1)",  param);

		     tr_post(tr1);
		     

			// ����
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
																	            + ",v_cd_site="+g_WinParam[0]
            																	+ ",v_no_silheng="+g_WinParam[1];          
	        
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pr431H", "JSP(O:DS_DEFAULT2=ds_default2)",  param);
		     
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
		<script language=JavaScript  for=ds_default1 event="OnLoadStarted()" >

		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet 1 �� ��ȸ �޼��� ó�� (�÷���) 
//              :  ��ȸ�Ϸ� 
%>			
		<script language=JavaScript  for=ds_default1 event="OnLoadCompleted(row,colid)">

			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		
		</script>

<%// Description  :  �׸��� ����Ŭ�� �̺�Ʈ �߻�%>       
   
    <script language=JavaScript for=gr_RcpDpt event=OnDblClick(row,colid)>
     

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
	<PARAM NAME="SyncLoad" 						VALUE="false">
	
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

<%=HDConstant.COMMENT_END%>


<!-- �׸��� �����ϰ� üũ �̺�Ʈ -->
<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=tr1 event=OnFail()>
	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
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
	<colgroup>
		<col width="110"></col>
		<col width="250"></col>
		<col width="110"></col>
		<col width="250"></col>
		<col width="110"></col>		
		<col width="*"></col>
	</colgroup>  
	<td height=25 width=1050>
		<table width="1050px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
			<tr>
				<td  height="25px" width="110px"  bgcolor="#eeeeee" align="center" class="text">�����</td>
				<td  height="25px" width="250px"  bgcolor="#FFFFFF" align="left" valign=center>&nbsp;
					<input id="txt_DS_SITE" type="text" class="textbox2"  size="35" style="height:19px" readonly>
				</td>
				<td height="25px"  width="110px" bgcolor="#eeeeee" align=center class="text">�����ȣ</td>
				<td height="25px"  width="610px" bgcolor="#FFFFFF" align="left" valign=center colspan="3">&nbsp;
					(
					<input id="txt_NO_SILHENG" type="text" class="textbox2" size="3" style="height:19px" readonly>
					��)		
					<input id="txt_DS_SILHENG" type="text" class="textbox2" size="50" style="height:19px" readonly>		
				</td>
			</tr>
		</table>
	</td>
  </tr>
</table>


<!-- ���� -->
<table border="0" cellpadding="0" cellspacing="0" align=center>
  <tr>
	<td height=30 align ="left">
	  	<img src="<%=dirPath%>/Sales/images/p_icon.gif" align=center> <font style="position:relative;top:1px;width:100;height:15;">����/���� ����</font>
	</td>
  </tr>
  <tr>
	<td height=25 width=950 colspan =2>
		<%=HDConstant.COMMENT_START%>
		<object id=gr_RcpDpt classid=<%=HDConstant.CT_GRID_CLSID%> width='1050px' height='600px' border='1'>
			<param name="DataID"		    		value="ds_default2">
			<param name="ColSizing"	    		value="true">
			<param name="Fillarea"		    		value="false">
			<param name="Editable"		    	value="true">
			<param name="BorderStyle"			value="0">
			<param name=SortView  		    	value="Left">
			<param name="SuppressOption"    	value="1">
			<param name="ViewSummary"       value="1">
			<param name="GeneralEdit" 			value="false" />
			<param name="Format" 				value="
	    		<C> name='No' 							ID={CurRow}	   			width=30 		align=CENTER	edit=none show=false</C>
	    		<C> name='���� �ڵ�' 					ID=CD_DKCOST	   		width=100 		align=left		edit=none</C>
	    		<C> name='������' 						ID=DS_COST  				width=180 		align=left		edit=none</C>
	    		<C> name='�԰�' 							ID=SZ_SIZE	   				width=50 		align=left		edit=none</C>	    		
	    		<C> name='����' 							ID=DS_UNIT	   			width=30 		align=left		edit=none</C>	
	    			    		 	 
		        <G> name='����'
		             <C> name='����' 			ID='AM_TT_DOKUBPRE'   		width=110 		align=right			edit=none Value={Number(AM_TT_DOKUBPRE)} Dec=0 </C>	    
		             <C> name='����' 			ID='AM_TT_DOKUB'   			width=110 		align=right			edit=none Value={Number(AM_TT_DOKUB)} Dec=0</C>			                      
		             <C> name='����'    			ID='AM_TT_DOKUBCHA'    		width=110 		align=right	 		edit=none Value={Number(AM_TT_DOKUBCHA)} Dec=0 BgColor={IF(AM_TT_DOKUBCHA !='0','#FFFFFF','#FFCC66')}</C>             
		        </G>	
		        
		        <G> name='����'
		             <C> name='����' 			ID='AM_TT_SILHENGPRE'   		width=110 		align=right			edit=none Value={Number(AM_TT_SILHENGPRE)} Dec=0</C>
		             <C> name='����' 			ID='AM_TT_SILHENG'   			width=110 		align=right			edit=none Value={Number(AM_TT_SILHENG)} Dec=0</C>		                          
		             <C> name='����'   			ID='AM_TT_SILHENGCHA'   		width=110 		align=right	 		edit=none Value={Number(AM_TT_SILHENGCHA)} Dec=0 BgColor={IF(AM_TT_SILHENGCHA !='0','#FFFFFF','#FFCC66')}</C>	             
		        </G>		
    		               		        
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
	<object  id=gcbn_01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=ds_default1>
	<param name=BindInfo  value='  

	 <C>Col=DS_SITE 	 				Ctrl=txt_DS_SITE    					Param=value </C>
	 <C>Col=DS_SILHENG 				Ctrl=txt_DS_SILHENG  				Param=value </C>	 
	 <C>Col=NO_SILHENG 				Ctrl=txt_NO_SILHENG  				Param=value </C>
	 
	'>
</object>
<%=HDConstant.COMMENT_END%>      

</body>
<!- BODY END -->
</html>