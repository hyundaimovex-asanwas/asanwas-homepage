<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �λ���Ȳ
+ ���α׷�ID : em013s.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2007.11.02
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : Em013_S.java
----------------------------------------------------------------------------------*/
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
	java.util.Calendar date = java.util.Calendar.getInstance();
    java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
    String firstday = m_today.format(date.getTime());	
%>
<!-- HTML ����-->
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script ����
=============================================================================*/
%>
	<script language="javascript">

	get_cookdata();
/*
	var gs_date = gcurdate;
	var year_date = gcurdate.substring(2,4);
	var yymmdd = gcurdate;
*/

	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			ln_before();//����ȸ
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
			//gcem_contr_fr.Text = yymmdd;
		}
/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){

	gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em013_S"
											 + "?v_str1=" + fn_trim(gclx_vend_cd.bindcolval)			//�ٹ���ü
											 + "&v_str2=" + fn_trim(gclx_job_cd.bindcolval)			  //����
											 + "&v_str3=" + fn_trim(gcem_contr_fr.Text)					  //����� from
											 + "&v_str4=" + fn_trim(gcem_contr_to.Text)					  //����� to
											 + "&v_str5=" + fn_trim(gclx_dept_cd.bindcolval)			//�μ�
											 + "&v_str6=" + fn_trim(gclx_agency_cd.bindcolval)		//�η´븮��
											 + "&v_str7=" + fn_trim(gcem_stdt_fr.Text)	          //�Ի��� from 
											 + "&v_str8=" + fn_trim(gcem_stdt_to.Text)						//�Ի��� to
											 + "&v_str9=" + fn_trim(gclx_team_cd.bindcolval)			//�Ҽ���
											 + "&v_str10=" + fn_trim(gclx_country_cd.bindcolval)	//����
											 + "&v_str11=" + fn_trim(gcem_passdt_fr.Text)				  //���Ǹ����� from
											 + "&v_str12=" + fn_trim(gcem_passdt_to.Text)				  //���Ǹ����� to
											 + "&v_str13=" + fn_trim(gclx_work_cd.bindcolval)		  //�ٹ���
											 + "&v_str14=" + fn_trim(gclx_nation_cd.bindcolval)	  //����
											 + "&v_str15=" + fn_trim(gclx_sex.bindcolval)				  //����
											 + "&v_str16=" + fn_trim(gclx_usts.bindcolval)				//��������
											 + "&v_str17=" + fn_trim(gclx_con_year.bindcolval)		//�ټӳ���
											 + "&v_str18=" + fn_trim(gclx_att_cd.bindcolval)			//�з�
											 + "&v_str19=" + fn_trim(gclx_rem_bnk.bindcolval) 		//�۱�����
											 + "&v_str20=" + fn_trim(gclx_retgb_cd.bindcolval) 		//�ͱ�����
											 + "&v_str21=" + fn_trim(blchk.value);		            //BLACKLIST

//	prompt('',gcds_data00.DataID);
	gcds_data00.Reset();
}


/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

		//�ٹ���ü  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM019";
	gcds_cm019.Reset();

	//����  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM004";
	gcds_cm004.Reset();

	//�μ�  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM006";
	gcds_cm006.Reset();

	//�η´븮��  CM005
	gcds_cm005.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM005";
	gcds_cm005.Reset();

	//�Ҽ���  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM003";
	gcds_cm003.Reset();

	//����  SY005
	gcds_cm020.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm020?v_str1=SY005";
	gcds_cm020.Reset();

	//�ٹ���  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM007";
	gcds_cm007.Reset();

	//����  CM020
	gcds_cu003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM020";
	gcds_cu003.Reset();

	//�ټӳ���
	gcds_cm017.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM017";
	gcds_cm017.Reset();

	//�з�  
	gcds_cm028.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM028";
	gcds_cm028.Reset();

	//�۱����� 
	gcds_cm027.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM027";
	gcds_cm027.Reset();

	//�ͱ����� 
	gcds_cm032.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em_com_s1?v_str1=CM032";
	gcds_cm032.Reset();

	}

/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
  function ln_Excel(){

    var szName1 = "�λ� ��Ȳ";
    var szPath = "C:\\Test\\em013s.xls";
       if (gcds_data00.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
       }
       else{
          gcgd_disp.GridToExcel(szName1,szPath,2);
       }
   }

 /*----------------------------------------------------------------------------
	Description : ���
----------------------------------------------------------------------------*/
	 function ln_Print(){
			alert("���� ��");
	 }

 /*----------------------------------------------------------------------------
	Description : black list üũ�ڽ�
----------------------------------------------------------------------------*/
function ln_ChkBox_Chk(){
	if(blchk.checked==true){
		blchk.value="Y";
	}else{
		blchk.value="";
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
			Gauce Components Event Scripts ����
=============================================================================*/
%>
	<!-- �ٹ���ü -->
	<script language="javascript" for="gcds_cm019" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm019","gclx_vend_cd");
	</script>
	<!-- ���� -->
	<script language="javascript" for="gcds_cm004" event="onloadCompleted(row,colid)">
	  ln_Insert_Row(2,"gcds_cm004","gclx_job_cd");
	</script>
	<!-- �μ� -->
	<script language="javascript" for="gcds_cm006" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm006","gclx_dept_cd");
	</script>
	<!-- �η´븮�� -->
	<script language="javascript" for="gcds_cm005" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm005","gclx_agency_cd");
	</script>
	<!-- �Ҽ��� -->
	<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm003","gclx_team_cd");
	</script>
	<!-- ���� -->
	<script language="javascript" for="gcds_cm020" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm020","gclx_country_cd");
	</script>
	<!-- �ٹ��� -->
	<script language="javascript" for="gcds_cm007" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm007","gclx_work_cd");
	</script>
	<!-- ���� -->
	<script language="javascript" for="gcds_cu003" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cu003","gclx_nation_cd");
	</script>

	<script language="javascript" for="gcds_cm017" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm017","gclx_con_year");
	</script>

	<script language="javascript" for="gcds_cm028" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm028","gclx_rem_bnk");
	</script>

	<script language="javascript" for="gcds_cm027" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm027","gclx_att_cd");
	</script>

		<script language="javascript" for="gcds_cm032" event="onloadCompleted(row,colid)">
		ln_Insert_Row(2,"gcds_cm032","gclx_retgb_cd");
	</script>

<%
/*=============================================================================
			Gauce Components Event Scripts ��
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
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �۾�����-TR1
	%>
		<script language="javascript" for="tr1" event="onfail()">

		</script>



<!-- �λ�⺻ -->
			<script language="javascript" for="gcds_data00" event="OnLoadStarted()">
			window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
			document.all.LowerFrame.style.visibility="visible";
			</script>
			<script language="javascript" for="gcds_data00" event="onloadCompleted(row,colid)">
			window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
			document.all.LowerFrame.style.visibility="hidden";
			ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
			if (row <1) {
			alert("�˻��� �����Ͱ� �����ϴ�.");
			}
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
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
	</script>


<%
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
	<%=HDConstant.COMMENT_END%>

<%=HDConstant.COMMENT_START%>
	<OBJECT id=gcds_data00 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<!-- �����ڵ� -->
<OBJECT id=gcds_cm019 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm006 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm004 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm005 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm020 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cu003 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm017 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm028 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm027 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_cm032 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<%=HDConstant.COMMENT_END%>
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><object id="gctr_data00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"		VALUE="toinb_dataid4">
</object><%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			DataSet Components(DS) ���� ��
=============================================================================*/
%>


</head>
<body>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
<table cellpadding="0" cellspacing="0" width=829 height=495 bordercolor=black ><!-- body table -->
		<tr>
			<td align="left" colspan="3">
				<table width="820" border="0"  cellspacing="0" cellpadding="0"><!-- ��ư ���� ����-->
					<tr>
						<td align="right" height="30px">		
							<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" onclick="ln_Query()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"	style="cursor:hand"  onclick="ln_Excel()">
							<!-- <img src="<%=dirPath%>/Sales/images/print.gif"	style="cursor:hand"  onclick="ln_Print()"> -->
						</td>
					</tr>																		
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
          <tr height="25">
            <td bgcolor="#eeeeee" align="center" >��������</td>
            <td  bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%><OBJECT id=gclx_usts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
              style="position:relative;left:7px;top:1px;font-size:12px;width:100px;">
              <param name=CBData					value="^[��ü],1^����^,2^����,3^����">
              <param name=CBDataColumns		value="COM_CODE,COM_SNAME">
              <param name=Index						value=0>
              <param name=SearchColumn		value="COM_SNAME">
              <param name=ListExprFormat	value="COM_SNAME^0^70">								
              <param name=BindColumn			value="COM_CODE">
              <param name=Enable					value="true">
              </OBJECT><%=HDConstant.COMMENT_END%>
            </td>
						<td bgcolor="#eeeeee" align="center">�ټӳ���</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_con_year classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm017">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">�з�</td>
						<td bgcolor="#FFFFFF"  ><%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_att_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm027">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">�����</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_contr_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:1px; width:67px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;cursor:hand" onclick="__GetCallCalendar7('gcem_contr_fr', 'Text');">
								<span style="position:relative;left:0px;top:-4px;">&nbsp;~</span>
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_contr_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:1px; width:67px; height:20px; font-family:����; font-size:9pt;z-index:2; ">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:2px;cursor:hand" onclick="__GetCallCalendar7('gcem_contr_to', 'Text');"> 
						</td>
						
          </tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">�ٹ���ü</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_vend_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm019">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">����</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_job_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm004">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">����</td>
						<td bgcolor="#FFFFFF"><%=HDConstant.COMMENT_START%>
								<object id=gclx_sex classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;" >
								<param name=CBData					value="^[��ü],M^��,F^��">
								<param name=CBDataColumns		value="Code, Parm">
								<param name=SearchColumn		value="Parm">
								<param name=index						value="0">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^100">
								<param name=BindColumn			value="Code">
								</object><%=HDConstant.COMMENT_END%>
						</td>
            <td bgcolor="#eeeeee" align="center">�Ի���</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_stdt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:1px; width:67px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;cursor:hand" onclick="__GetCallCalendar7('gcem_stdt_fr', 'Text');">
								<span style="position:relative;left:0px;top:-4px;">&nbsp;~</span>
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_stdt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:1px; width:67px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:2px;cursor:hand" onclick="__GetCallCalendar7('gcem_stdt_to', 'Text');">
						</td>
					</tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">�μ�</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_dept_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm006">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">�η´븮��</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_agency_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm005">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">�۱�����</td>
						<td bgcolor="#FFFFFF" ><%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_rem_bnk classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm028">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>

						<td bgcolor="#eeeeee" align="center">���Ǹ�����</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_passdt_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:8px;top:1px; width:67px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:10px;cursor:hand" onclick="__GetCallCalendar7('gcem_passdt_fr', 'Text');">
								<span style="position:relative;left:0px;top:-4px;">&nbsp;~</span>
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gcem_passdt_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
								style="position:relative; left:0px;top:1px; width:67px; height:20px; font-family:����; font-size:9pt;z-index:2; " >
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								</OBJECT><%=HDConstant.COMMENT_END%>
							<img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:2px;cursor:hand" onclick="__GetCallCalendar7('gcem_passdt_to', 'Text');">
						</td>
						
					</tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">�Ҽ���</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_team_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm003">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">����</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_country_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm020">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">�ͱ�����</td>
						<td bgcolor="#FFFFFF" colspan=3>
						  <%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_retgb_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm032">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
					</tr>
					<tr height="25">
						<td bgcolor="#eeeeee" align="center">�ٹ���</td>
						<td bgcolor="#FFFFFF">
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_work_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cm007">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=Index						value=0>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>
						<td bgcolor="#eeeeee" align="center">����</td>
						<td bgcolor="#FFFFFF" >
							<%=HDConstant.COMMENT_START%>
								<OBJECT id=gclx_nation_cd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
								<param name=ComboDataID			value="gcds_cu003">
								<param name=CBDataColumns		value="COM_CODE, COM_SNAME">
								<param name=SearchColumn		value=COM_SNAME>
								<param name=Sort						value=false>
								<param name=ListExprFormat	value="COM_SNAME^0^100">
								<param name=BindColumn			value=COM_CODE>
								</OBJECT><%=HDConstant.COMMENT_END%>
						</td>

			     <td bgcolor="#eeeeee" align="center">Black List</td>
					 <td bgcolor="#FFFFFF" colspan=3>								
					      <input type="checkbox" id=blchk   value=""    style="position:relative;left:4px;top:0px;cursor:hand;width:22px" onClick="ln_ChkBox_Chk()">
					 </td> 

						<!-- <td bgcolor="#eeeeee" align="center">��±���</td>
						<td bgcolor="#FFFFFF" colspan=3><%=HDConstant.COMMENT_START%>
								<object id=gclx_hm_gbn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
								style="position:relative;left:8px;top:1px;font-size:12px;width:100px;" >
								<param name=CBData					value=" ^ ,1^�����Ȳ,2^�ο���Ȳ">
								<param name=CBDataColumns		value="Code, Parm">
								<param name=SearchColumn		value="Parm">
								<param name=index						value="0">
								<param name=Sort						value="false">
								<param name=ListExprFormat	value="Parm^0^100">
								<param name=BindColumn			value="Code">
								</object><%=HDConstant.COMMENT_END%>
						</td> -->
				
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
				<table cellpadding=0 cellspacing=0 style="width:827px;height:327px;">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z1111"  >
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:827;height:307px;border:0">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"     value=left>
							<PARAM NAME="Format"			VALUE="  
                <F> Name=NO				  ID={CurRow}         HeadAlign=Center   HeadBgColor=#B9D4DC Width=30,  align=right </F> 
								<FC>Name=�ٹ���ü,  ID=VEND_CD			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=70,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm019:COM_CODE:COM_SNAME', </FC>
								<FC>Name=�μ�,      ID=DEPT_CD					HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm006:COM_CODE:COM_SNAME', </FC>
								<FC>Name=�Ҽ���,    ID=TEAM_CD				  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=90,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm003:COM_CODE:COM_SNAME', </FC>
								<FC>Name=�ٹ���,    ID=WORK_CD				  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=70,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm007:COM_CODE:COM_SNAME', </FC>
								<FC>Name=���,      ID=EMPNO					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=left,  sort = true </FC>
								<FC>Name=����,      ID=EMPNMK					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=left,  sort = true </FC>						
								<C>Name=����,       ID=JOB_CD					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true EditStyle=Lookup,Data='gcds_cm004:COM_CODE:COM_SNAME', </C>
								<C>Name=�븮��,     ID=AGENCY_CD        HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm005:COM_CODE:COM_SNAME', </C>
								<C>Name=����,       ID=COUNTRY_CD			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm020:COM_CODE:COM_SNAME', </C>
								<C>Name=����,       ID=NATION_CD			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cu003:COM_CODE:COM_SNAME', </C>
								<C>Name=�����,     ID=CSTART_DT		    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center,sort = true Mask='XXXX/XX/XX'</C>
								<C>Name=�Ի���,     ID=ASTART_DT			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center,sort = true Mask='XXXX/XX/XX'</C>
								<C>Name=���ǹ�ȣ,   ID=PASS_NO          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true </C>
								<C>Name=���Ǹ�����, ID=PASS_EXPIRE_DATE HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=center,sort = true Mask='XXXX/XX/XX'</C>
								<C>Name=����,       ID=SEX							HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,sort = true, value={if(SEX='M','��',IF(SEX='F','��',''))}</C>
								<C>Name=����,       ID=CON_YEAR 			  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm017:COM_CODE:COM_SNAME', </C>
								<C>Name=�з�,       ID=ATT_CD  			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm027:COM_CODE:COM_SNAME', </C>
								<G>Name=�߱�������ó  HeadBgColor=#B9D4DC,
                <C>Name=����,       ID=CHI_NM           HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true </C>
								<C>Name=����,       ID=CHI_RNM          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true </C>
								<C>Name=��ȭ��ȣ,   ID=CHI_TEL          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=150,align=left,  sort = true </C>
								<C>Name=�ּ�,       ID=CHI_ADD          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=150,align=left,  sort = true </C>
								</G>
								<G>Name=�۱�����    HeadBgColor=#B9D4DC,
								<C>Name=����,       ID=REM_BNK 			    HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=60,align=center,sort = true EditStyle=Lookup,Data='gcds_cm028:COM_CODE:COM_SNAME', </C>
								<C>Name=������,     ID=SAV_NM           HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true </C>
								<C>Name=��ȭ��ȣ,   ID=SAV_TEL          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=80,align=left,  sort = true  </C>
								<C>Name=�۱ݰ���,   ID=REM_ACC          HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=150,align=left,  sort = true </C>
								</G>
								<C>Name=����,       ID=USESTS					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,sort = true EditStyle=Combo,Data='1:����,2:����,3:����', </C>
								<C>Name=�ͱ�����,   ID=RETGB					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,EditStyle=Lookup,Data='gcds_cm032:COM_CODE:COM_SNAME',</C>
								<C>Name=������Ʈ, ID=BLCHK					  HeadBgColor=#B9D4DC, bgcolor=#ffffff, width=50,align=center,</C>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
									<fieldset style="width:827;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
										&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
									</fieldset>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
</body>
</html>
