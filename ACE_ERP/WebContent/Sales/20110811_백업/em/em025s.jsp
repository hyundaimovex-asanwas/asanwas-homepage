<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : �޿�������Ȳ
+ ���α׷�ID : em025s.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2007.11.11
----------------------------------------------------------------------------------
+ �������� :
+ �� �� �� : 
+ �������� :
----------------------------------------------------------------------------------
+ ������ : Em025_S.java
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
	
	//���ÿ��� ����ϱ� ���� ���Ƿ� ����.
    /*
	var gs_date = gcurdate.substring(0,4)+gcurdate.substring(5,7)+gcurdate.substring(8,10);
	*/
	var gs_date ='<%=firstday%>';
	/*----------------------------------------------------------------------------
	 * �������ε�
	 ----------------------------------------------------------------------------*/
		function fnOnLoad(tree_idx){	// body onload �� ȣ��Ǵ� �Լ�!!!!!

			ln_before();//����ȸ
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ�� [�ݵ�� ���� ��]
      gcem_payym.Text = gs_date;
		}
/*----------------------------------------------------------------------------
	Description : �˾�â
----------------------------------------------------------------------------*/
function ln_Find(e){//������ȸ

  var arrParam	= new Array();
	var strURL   = "./Per_com_pop2.jsp";
	var strPos = "dialogWidth:375px;dialogHeight:485px;status:no;scroll:no;resizable:no";
	var arrResult = showModalDialog(strURL,window,strPos);

  if(e=='01'){
      if (arrResult != null) {
        arrParam = arrResult.split(";");
        txt_empno.value = arrParam[0];
        txt_empnmk.value = arrParam[1];
       }
       else{
        txt_empno.value = "";
        txt_empnmk.value = "";
      }
  }
}


/*----------------------------------------------------------------------------
	Description : �⺻��ȸ
----------------------------------------------------------------------------*/
function ln_Query(){

  if(gclx_print.bindcolval=='1'){

      gcds_data00.DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em025_S2"
                         + "?v_str1=" + fn_trim(gcem_payym.Text)					//�޿����
                         + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval)		//���ޱ���
                         + "&v_str3=" + fn_trim(gclx_teamcd.bindcolval)		//�Ҽ�
                         + "&v_str4=" + fn_trim(gclx_deptcd.value)	      //�μ�
                         + "&v_str5=" + fn_trim(txt_empno.value)	        //���
                         + "&v_str6=" + fn_trim(gclx_agencycd.bindcolval);//�븮��
      //prompt('',gcds_data00.DataID);
      gcds_data00.Reset();
  }else if(gclx_print.bindcolval=='2'){
    alert("����� - �������Դϴ�.");
  }else if(gclx_print.bindcolval=='3'){
		alert("����� - �������Դϴ�.");    
  }else if(gclx_print.bindcolval=='4'){
    alert("����� - �������Դϴ�.");    
  }
}
/*----------------------------------------------------------------------------
	Description : ����ȸ ����
----------------------------------------------------------------------------*/
function ln_before(){

	//����  CM004
	gcds_cm004.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm004?v_str1=CM004";
	gcds_cm004.Reset();
	//�븮��  CM005
	gcds_cm005.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM005";
	gcds_cm005.Reset();
 	//���ޱ���  CM018
	gcds_cm018.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM018";
	gcds_cm018.Reset();
	//�ٹ���ü  CM019
	gcds_cm019.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm019?v_str1=CM019";
	gcds_cm019.Reset();
	//�μ�  CM006
	gcds_cm006.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm006?v_str1=CM006";
	gcds_cm006.Reset();
	//�Ҽ���  CM003
	gcds_cm003.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm003?v_str1=CM003";
	gcds_cm003.Reset();
	//�ٹ���  CM007
	gcds_cm007.DataID="<%=dirPath%><%=HDConstant.PATH_EM%>Em010_Cm007?v_str1=CM007";
	gcds_cm007.Reset();
	
	}

/*----------------------------------------------------------------------------
	Description : ����
----------------------------------------------------------------------------*/
  function ln_Excel(){

    if(gclx_print.bindcolval=='1'){
        var szName = "�޿�������Ȳ";
        var szPath = "C:\\Test\\em025s1.xls";
          if (gcds_data00.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
          }
          else{
          gcgd_disp.GridToExcel(szName,szPath,2);
          }
    }
    else if(gclx_print.bindcolval=='2'){
    
        var szName = "�븮����������Ȳ";
        var szPath = "C:\\Test\\em025s2.xls";
          if (gcds_data01.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
          }
          else{
          gcgd_disp1.GridToExcel(szName,szPath,2);
          }
    }
    else if(gclx_print.bindcolval=='3'){

        var szName = "�ҼӺ�����ǥ";
        var szPath = "C:\\Test\\em025s3.xls";
          if (gcds_data02.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
          }
          else{
          gcgd_disp2.GridToExcel(szName,szPath,2);
          }
    }
    else if(gclx_print.bindcolval=='4'){

        var szName = "����������";
        var szPath = "C:\\Test\\em025s4.xls";
          if (gcds_data03.countrow<1){
          alert("�ٿ�ε� �Ͻ� �ڷᰡ �����ϴ�");
          }
          else{
          gcgd_disp3.GridToExcel(szName,szPath,2);
          }
    }
  }

/******************************************************************************
	Description : ���
******************************************************************************/
function ln_Print(){
   
  if(gclx_print.bindcolval=='1'){
		ln_SetDataHeader();
		gcds_rptmst.Addrow();
		gcds_rptmst.namevalue(gcds_rptmst.rowposition,"CTITLE") = gcem_payym.text.substring(0,4)+"��"+gcem_payym.text.substring(4,6)+"�� ������ ��ɻ�� �޿�������Ȳ";		
		gcds_rptmst.namevalue(gcds_rptmst.rowposition,"CPRTDT") = gs_date;

 		ln_Report('0'); //�Ѱ�
		ln_Report('1'); //������
		ln_Report('2'); //��ȸ��
		ln_Report('3'); //���¾�ü��
		ln_Report('9'); //������

		gcrp_print.Preview();

	}
}


/******************************************************************************
	Description : ���
	Parameter   : gbn 0 - �Ѱ�,  1-������,  2-��ȸ��,  3-���¾�ü��,  9-������
******************************************************************************/

function ln_Report(gbn){
  if(gclx_print.bindcolval=='1'){ //�޿�������Ȳ
	    eval("gcds_report"+gbn).DataID = "<%=dirPath%><%=HDConstant.PATH_EM%>Em025_S1"
                          + "?v_str1=" + fn_trim(gcem_payym.Text)					  //�޿����
                          + "&v_str2=" + fn_trim(gclx_paydiv.bindcolval)		//���ޱ���
                          + "&v_str3=" + fn_trim(gclx_teamcd.bindcolval)		//�Ҽ�
                          + "&v_str4=" + fn_trim(gclx_deptcd.value)	        //�μ�
                          + "&v_str5=" + fn_trim(txt_empno.value)	          //���
                          + "&v_str6=" + fn_trim(gclx_agencycd.bindcolval)  //�븮��
													+ "&v_str7=" + gbn ; //����
      //prompt('',eval("gcds_report"+gbn).DataID);
      eval("gcds_report"+gbn).Reset();
	}
}



/******************************************************************************
	Description : ����Ÿ �� ��� ����
******************************************************************************/
function ln_SetDataHeader(){
	if (gcds_rptmst.countrow<1){
		var s_temp = "CTITLE:STRING(100),CPRTDT:STRING(8)";
							
		gcds_rptmst.SetDataHeader(s_temp);
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
	<!-- �Ҽ��� 
	<script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
		gcds_cm003.insertrow(1);
		gcds_cm003.namevalue(1,"COM_CODE") = "";
		gcds_cm003.namevalue(1,"COM_SNAME") = "��ü";
		gclx_team_cd.index = 0;
	</script>-->

<%
/*=============================================================================
			Gauce Components Event Scripts ��
=============================================================================*/
%>


<%/*=============================================================================
			Transaction Component's Event Message Scripts ����
=============================================================================*/%>




<%
/*=============================================================================
			Transaction Component's Event Message Scripts ��
=============================================================================*/
%>

<script language=JavaScript for= gclx_print event=OnSelChange()>
	
var key = gclx_print.bindcolval;

	if(key==1){
	document.all["div_1"].style.display="block";
	document.all["div_2"].style.display="none";
	document.all["div_3"].style.display="none";
	document.all["div_4"].style.display="none";
	}else if(key==2){
	document.all["div_1"].style.display="none";
	document.all["div_2"].style.display="block";
	document.all["div_3"].style.display="none";
	document.all["div_4"].style.display="none";
	}else if(key==3){
	document.all["div_1"].style.display="none";
	document.all["div_2"].style.display="none";
	document.all["div_3"].style.display="block";
	document.all["div_4"].style.display="none";
	}else{
	document.all["div_1"].style.display="none";
	document.all["div_2"].style.display="none";
	document.all["div_3"].style.display="none";
	document.all["div_4"].style.display="block";
	}


</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts ����
=============================================================================*/
%>
<!-- �븮�� -->
  <script language="javascript" for="gcds_cm005" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm005","gclx_agencycd");
  </script>
<!-- ���ޱ��� -->
  <script language="javascript" for="gcds_cm018" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm018","gclx_paydiv");
  </script>
<!-- �Ҽ� -->
  <script language="javascript" for="gcds_cm003" event="onloadCompleted(row,colid)">
      ln_Insert_Row(2,"gcds_cm003","gclx_teamcd");
  </script>



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

  <script language="javascript" for="gcds_data01" event="OnLoadStarted()">
  window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
  document.all.LowerFrame.style.visibility="visible";
  </script>
  <script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
    window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    document.all.LowerFrame.style.visibility="hidden";
    ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
    if (row <1) {
    alert("�˻��� �����Ͱ� �����ϴ�.");
    }
  </script>

  <script language="javascript" for="gcds_data02" event="OnLoadStarted()">
  window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
  document.all.LowerFrame.style.visibility="visible";
  </script>
  <script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
    window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    document.all.LowerFrame.style.visibility="hidden";
    ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
    if (row <1) {
    alert("�˻��� �����Ͱ� �����ϴ�.");
    }
  </script>

  <script language="javascript" for="gcds_data03" event="OnLoadStarted()">
  window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
  document.all.LowerFrame.style.visibility="visible";
  </script>
  <script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
    window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
    document.all.LowerFrame.style.visibility="hidden";
    ft_cnt1.innerText = "��ȸ�Ǽ� : " + row + " ��";
    if (row <1) {
    alert("�˻��� �����Ͱ� �����ϴ�.");
    }
  </script>

	<script language=JavaScript for=gcrp_print event=OnError()>

alert("Error Code = " + gcrp_print.ErrorCode + "\n" + "Error Message = " + gcrp_print.ErrorMsg);

</script>


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
	<!-- <param name=SortExpr	value="+VEND_NM"> -->
</OBJECT>
<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
<OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
 <OBJECT id=gcds_rptmst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_report0 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_report1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_report2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
 <OBJECT id=gcds_report3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>
<OBJECT id=gcds_report9 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- �����ڵ� -->
<OBJECT id=gcds_cm018 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>
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
<OBJECT id=gcds_cm007 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
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
								<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand" onclick="ln_Query()">
								<img src="<%=dirPath%>/Sales/images/print.gif"		style="cursor:hand" onClick="ln_Print('01')">
								<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand" onClick="ln_Excel('01')">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top"><!-- ���̺� ���� -->
				<table cellpadding=0 cellspacing=1 style="width:829px;" bgcolor="#708090">
          <tr height="25">
            <td bgcolor="#eeeeee" align="center">��±���</td>
            <td bgcolor="#eeeeee" align="center">�޿����</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
              <OBJECT id=gcem_payym classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"
              style="position:relative; left:8px;top:2px; width:50px; height:20px; font-family:����; font-size:9pt;" >
              <param name=Alignment			value=0>
              <param name=Border	      value=true>
              <param name=Format	      value="YYYY/MM">
              <param name=PromptChar	  value="_">
              </OBJECT><%=HDConstant.COMMENT_END%>
              <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:15px;cursor:hand" onclick="__GetCallMonth('gcem_payym', 'Text');">
            </td>
            <td bgcolor="#eeeeee" align="center">���ޱ���</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
                <OBJECT id=gclx_paydiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                <param name=ComboDataID			value="gcds_cm018">
                <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                <param name=SearchColumn		value=COM_SNAME>
                <param name=Sort						value=false>
                <param name=Index						value=0>
                <param name=ListExprFormat	value="COM_SNAME^0^100">
                <param name=BindColumn			value=COM_CODE>
                </OBJECT><%=HDConstant.COMMENT_END%>
            </td>
            <td bgcolor="#eeeeee" align="center" width="100">�Ҽ�</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
                <OBJECT id=gclx_teamcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
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
          </tr>
          <tr height="25">
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%><object id=gclx_print classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69
              style="position:relative;left:8px;top:1px;font-size:12px;width:115px;" >
              <param name=CBData					value="1^�޿�������Ȳ,2^�븮����������Ȳ,3^�ҼӺ�����ǥ,4^����������">
              <param name=CBDataColumns		value="Code, Parm">
              <param name=SearchColumn		value="Parm">
              <param name=index						value="0">
              <param name=Sort						value="false">
              <param name=ListExprFormat	value="Parm^0^120">
              <param name=BindColumn			value="Code">
              </object></comment>
              <script>__ws__(__NSID__);</script>
            </td>
            <td bgcolor="#eeeeee" align="center" width="100">�븮��</td>
            <td bgcolor="#FFFFFF">
              <%=HDConstant.COMMENT_START%>
                <OBJECT id=gclx_agencycd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
                style="position:relative;left:8px;top:1px;font-size:12px;width:100px;">
                <param name=ComboDataID			value="gcds_cm005">
                <param name=CBDataColumns		value="COM_CODE, COM_SNAME">
                <param name=SearchColumn		value=COM_SNAME>
                <param name=Sort						value=false>
                <param name=Index						value=0>
                <param name=ListExprFormat	value="COM_SNAME^0^100">
                <param name=BindColumn			value=COM_CODE>
                </OBJECT><%=HDConstant.COMMENT_END%>
            </td>
            <td bgcolor="#eeeeee" align="center" width="100">����</td>
            <td bgcolor="#FFFFFF" colspan="3">
                <input type="text" id="txt_empno" style="position:relative;left:8px;top:-2px;width:60px;" >
                <img src="<%=dirPath%>/Sales/images/help.gif" style="position:relative;left:11px;top:2px;cursor:hand" onclick="ln_Find('01')">
                <input type="text" id="txt_empnmk" style="position:relative;left:15px;top:-2px;width:100px;" >
                <input type="hidden" id="gclx_deptcd" style="position:relative;left:15px;top:-2px;width:100px;" >
            </td>

          </tr>
				</table>
			</td>
		</tr>
		<tr>
			<td valign="top" bgcolor="#FFFFFF"><br>
<!-- div_1 --------------------------------------------------------------------------------------------------->
      <div id="div_1" style="display:block">
				<table cellpadding=0 cellspacing=1 style="width:829px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp style="width:829;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data00">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=30>
							<param name="sortview"    value=left>
		          <!-- <param name="LineColor"		value=Green> -->
							<param name=ViewSummary    value=1>
							<PARAM NAME="Format"			VALUE="  
              <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30, align=center SumBgColor=#C3D0DB  </F> 
							<FC>ID=VEND_NM			Name=�ٹ���ü	 		    ,width=70px,	align=left,	  HeadBgColor=#B9D4DC,  SumBgColor=#C3D0DB  SumText='' suppress=1</FC>
              <FC>ID=GROUPNM			Name=����						  ,width=70px,	align=left,	  HeadBgColor=#B9D4DC,  SumBgColor=#C3D0DB  SumText='�� ��'</FC>
              <C>ID=BASIC_TOT    ,Name=�⺻             ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
              <C>ID=O_TIME_TOT	 ,Name=OT��             ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
              <C>ID=RET_PAY			,	Name=������           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
              <C>ID=REWARD_PAY	,	Name=�̽ǽ�\\�����   ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
              <C>ID=BON_PAY			,	Name=�󿩱�           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=LST_PAY			,	Name=�����ұ�         ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=PAY_SUM			,	Name=���ް�           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum  Bgcolor=#CCFFCC</C>
							<C>ID=TEL_PAY			,	Name=��ȭ��           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=ADV_PAY			,	Name=����             ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=TELUBO_PAY	, Name=��ȭ��\\����     ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=TELSAVE_PAY	,	Name=��ȭ��\\�������� ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=ETC_PAY			,	Name=��Ÿ             ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum</C>
							<C>ID=DEDUCT_SUM	,	Name=������           ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum  Bgcolor=#CCFFCC </C>
							<C>ID=REAL_PAY_SUM,	Name=�����޾�         ,width=70px,	align=right,	HeadBgColor=#B9D4DC   SumBgColor=#C3D0DB  SumText=@sum  Bgcolor=Yellow</C>
							">																																											 
							</OBJECT><%=HDConstant.COMMENT_END%>																		 
              <fieldset style="width:829;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
                &nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
              </fieldset>
						</td>
					</tr>
				</table></div>

<!-- div_2 --------------------------------------------------------------------------------------------------->
      <div id="div_2" style="display:none">
				<table cellpadding=0 cellspacing=1 style="width:829px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp1 style="width:829;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data01">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
              <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right </F> 
              <C>ID=TEAM_CD			,		Name=�Ҽ�          ,width=80px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm003:COM_CODE:COM_SNAME'</C>
              <C>ID=EMPNO				,		Name=���          ,	width=60px,	align=center,	HeadBgColor=#B9D4DC</C>
              <C>ID=EMPNMK      ,		Name=����          ,width=80px,	align=left,	HeadBgColor=#B9D4DC</C>
              <C>ID=AGENCY_CD      ,Name=�븮��          ,width=80px,	align=center,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm005:COM_CODE:COM_SNAME'</C>
              <C>ID=JOB_CD			,		Name=����          ,width=80px,	align=left,	HeadBgColor=#B9D4DC,EditStyle=Lookup,Data='gcds_cm004:COM_CODE:COM_SNAME'</C>
              <C>ID=B_PAY1			,		Name=�⺻��1       ,width=80px,	align=right,	HeadBgColor=#B9D4DC</C>
              <C>ID=B_PAY2			,		Name=�⺻��2       ,width=80px,	align=right,	HeadBgColor=#B9D4DC</C>
              <C>ID=O_TIME			,		Name=OT�ð�        ,width=80px,	align=right,	HeadBgColor=#B9D4DC</C>
              <C>ID=O_TIME_TOT	,		Name=OT��          ,width=80px,	align=right,	HeadBgColor=#B9D4DC</C>
              <C>ID=TEL_PAY			,		Name=��ȭ��        ,width=80px,	align=right,	HeadBgColor=#B9D4DC</C>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
              <fieldset style="width:829;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
                &nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
              </fieldset>
						</td>
					</tr>
				</table></div>
<!-- div_3 --------------------------------------------------------------------------------------------------->
      <div id="div_3" style="display:none">
				<table cellpadding=0 cellspacing=1 style="width:829px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp2 style="width:829;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data02">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
              <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right </F> 
						  <C>ID=CERETC,		Name=����,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
							<G> name=����,HeadBgColor=#B9D4DC
						  <C>ID=CERETC,		Name=�ο�,	width=50px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=�����޾�,	width=100px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=��մܰ�,	width=100px,	align=left,			HeadBgColor=#B9D4DC	</C>
							</G>
							<G> name=���,HeadBgColor=#B9D4DC
						  <C>ID=CERETC,		Name=�ο�,	width=50px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=�����޾�,	width=100px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=��մܰ�,	width=100px,	align=left,			HeadBgColor=#B9D4DC	</C>
							</G>

							<G> name=������,HeadBgColor=#B9D4DC
						  <C>ID=CERETC,		Name=����,	width=110px,	align=left,			HeadBgColor=#B9D4DC	</C>
							</G>

							<G> name=��մܰ�,HeadBgColor=#B9D4DC
						  <C>ID=CERETC,		Name=����,	width=130px,	align=left,			HeadBgColor=#B9D4DC	</C>
							</G>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
              <fieldset style="width:829;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
                &nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
              </fieldset>
						</td>
					</tr>
				</table></div>
<!-- div_4 --------------------------------------------------------------------------------------------------->
      <div id="div_4" style="display:none">
				<table cellpadding=0 cellspacing=1 style="width:829px;height:390px;" bgcolor="">
					<tr>
						<td bgcolor="#FFFFFF" align="left" class="tab_z0101">
							<%=HDConstant.COMMENT_START%>
							<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp3 style="width:829;height:370px;border:0 solid #708090;border-left-width:1px;border-top-width:1px;">
							<PARAM NAME="DataID"			VALUE="gcds_data03">
							<PARAM NAME="BorderStyle" VALUE="0">
							<PARAM NAME="Indwidth"		VALUE="0">
							<PARAM NAME="Fillarea"		VALUE="true">
							<PARAM NAME="Colsizing"		VALUE="true">
							<PARAM NAME="TitleHeight"	VALUE=20>
							<param name="sortview"    value=left>
							<PARAM NAME="Format"			VALUE="  
              <F> Name=NO			ID={CurRow} HeadAlign=Center   HeadBgColor=#B9D4DC   Width=30,  align=right </F> 
						  <C>ID=CERETC,		Name=����,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
							<G> name=�ο�,HeadBgColor=#B9D4DC
						  <C>ID=CERETC,		Name=��,	width=20px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=FICC,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=JLCC,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=JOEC,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=QUTC,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
							</G>
							<G> name=�ݾ�,HeadBgColor=#B9D4DC
						  <C>ID=CERETC,		Name=��,	width=20px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=FICC,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=JLCC,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=JOEC,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=QUTC,	width=40px,	align=left,			HeadBgColor=#B9D4DC	</C>
							</G>
						  <C>ID=CERETC,		Name=��մܰ�,	width=80px,	align=left,			HeadBgColor=#B9D4DC	</C>
							<G> name=����,HeadBgColor=#B9D4DC
						  <C>ID=CERETC,		Name=�ݾ�,	width=60px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=��մܰ�,	width=90px,	align=left,			HeadBgColor=#B9D4DC	</C>
							</G>
							<G> name=�����������,HeadBgColor=#B9D4DC
						  <C>ID=CERETC,		Name=�ݾ�,	width=60px,	align=left,			HeadBgColor=#B9D4DC	</C>
						  <C>ID=CERETC,		Name=����,	width=90px,	align=left,			HeadBgColor=#B9D4DC	</C>
							</G>
							">
							</OBJECT><%=HDConstant.COMMENT_END%>
              <fieldset style="width:829;height:20px;border:0 solid #708090;border-top-width:1px;text-align:left;">
                &nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
              </fieldset>
						</td>
					</tr>
				</table></div>
			</td>
		</tr>
	</table>
<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N  -- �޿�������Ȳ[����] --
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%><OBJECT id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="MasterDataID"			VALUE="gcds_rptmst">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"					VALUE="1">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<A>id=Area0 ,left=0,top=0 ,right=2871 ,bottom=132
	<R>id='�Ѱ�.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132, DetailDataID='gcds_report0' 
		<B>id=Header ,left=0,top=0 ,right=2871 ,bottom=166 ,face='Arial' ,size=10 ,penwidth=1
			<X>left=627 ,top=66 ,right=2294 ,bottom=167 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=2</X>
			<C>id='CTITLE', left=635, top=74, right=2278, bottom=159, face='HY������M', size=20, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
		</B>
		<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=410 ,face='Arial' ,size=10 ,penwidth=1
			<T>id='���� : �޷�' ,left=2566 ,top=56 ,right=2770 ,bottom=98 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='CPRTDT', left=2564, top=0, right=2768, bottom=48, align='right' ,mask='XXXX.XX.XX', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<T>id='Print Date:' ,left=2291 ,top=3 ,right=2553 ,bottom=50 ,align='right' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='1  �Ѱ�' ,left=32 ,top=42 ,right=235 ,bottom=95 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=103 ,right=2781 ,bottom=103 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='���޳���' ,left=360 ,top=114 ,right=1490 ,bottom=153 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����' ,left=841 ,top=191 ,right=992 ,bottom=230 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�̽ǽ�' ,left=841 ,top=159 ,right=992 ,bottom=198 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�󿩱�' ,left=997 ,top=175 ,right=1138 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='������' ,left=683 ,top=175 ,right=833 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='O/T��' ,left=524 ,top=175 ,right=675 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�⺻' ,left=360 ,top=175 ,right=516 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1849 ,top=191 ,right=2000 ,bottom=230 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1849 ,top=159 ,right=2000 ,bottom=198 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=2011 ,top=191 ,right=2162 ,bottom=230 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=2011 ,top=159 ,right=2162 ,bottom=198 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=2334 ,top=175 ,right=2532 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=2172 ,top=175 ,right=2323 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1688 ,top=175 ,right=1839 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1529 ,top=175 ,right=1680 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1312 ,top=175 ,right=1511 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����ұ�' ,left=1146 ,top=175 ,right=1296 ,bottom=214 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=519 ,top=156 ,right=519 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=352 ,top=156 ,right=2466 ,bottom=156 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='��������' ,left=1535 ,top=114 ,right=2484 ,bottom=153 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����޾�' ,left=2553 ,top=116 ,right=2773 ,bottom=225 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ο�' ,left=270 ,top=116 ,right=347 ,bottom=225 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=106 ,right=32 ,bottom=402 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=34 ,top=235 ,right=2781 ,bottom=235 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��  ��' ,left=45 ,top=116 ,right=246 ,bottom=225 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2331 ,top=156 ,right=2540 ,bottom=156 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1304 ,top=156 ,right=1521 ,bottom=156 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id='P_PAY_YM', left=45, top=246, right=243, bottom=291, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_CNT', left=273, top=246, right=349, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REAL_PAY_SUM', left=2553, top=246, right=2773, bottom=291, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_DEDUCT_SUM', left=2334, top=246, right=2532, bottom=291, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ETC_PAY', left=2172, top=246, right=2323, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELSAVE_PAY', left=2011, top=246, right=2162, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELUBO_PAY', left=1849, top=246, right=2000, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ADV_PAY', left=1688, top=246, right=1839, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TEL_PAY', left=1529, top=246, right=1680, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_PAY_SUM', left=1312, top=246, right=1511, bottom=291, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_LST_PAY', left=1146, top=246, right=1296, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_BON_PAY', left=997, top=246, right=1138, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REWARD_PAY', left=841, top=246, right=992, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_RET_PAY', left=683, top=246, right=833, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_O_TIME_TOT', left=524, top=246, right=675, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_BASIC_TOT', left=360, top=246, right=516, bottom=291, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=34 ,top=294 ,right=2781 ,bottom=294 </L>
			<C>id='C_PAY_YM', left=45, top=299, right=243, bottom=344, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_CNT', left=270, top=299, right=347, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_BASIC_TOT', left=360, top=299, right=516, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_O_TIME_TOT', left=524, top=299, right=675, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_RET_PAY', left=683, top=299, right=833, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_REWARD_PAY', left=841, top=299, right=992, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_BON_PAY', left=997, top=299, right=1138, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_LST_PAY', left=1146, top=299, right=1296, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_PAY_SUM', left=1312, top=299, right=1511, bottom=344, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TEL_PAY', left=1529, top=299, right=1680, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ADV_PAY', left=1688, top=299, right=1839, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELUBO_PAY', left=1849, top=299, right=2000, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELSAVE_PAY', left=2011, top=299, right=2162, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ETC_PAY', left=2172, top=299, right=2323, bottom=344, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_DEDUCT_SUM', left=2334, top=299, right=2532, bottom=344, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_REAL_PAY_SUM', left=2553, top=299, right=2773, bottom=344, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=48 ,top=347 ,right=2778 ,bottom=347 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='�����������' ,left=53 ,top=349 ,right=246 ,bottom=394 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='{C_CNT-P_CNT}', left=270, top=349, right=347, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='{C_BASIC_TOT-P_BASIC_TOT}', left=360, top=349, right=516, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_O_TIME_TOT-P_O_TIME_TOT}', left=524, top=349, right=675, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_RET_PAY-P_RET_PAY}', left=683, top=349, right=833, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_REWARD_PAY-P_REWARD_PAY}', left=841, top=349, right=992, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_BON_PAY-P_BON_PAY}', left=997, top=349, right=1138, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_LST_PAY-P_LST_PAY}', left=1146, top=349, right=1296, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_PAY_SUM-P_PAY_SUM}', left=1312, top=349, right=1511, bottom=394, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TEL_PAY-P_TEL_PAY}', left=1529, top=349, right=1680, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ADV_PAY-P_ADV_PAY}', left=1688, top=349, right=1839, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELUBO_PAY-P_TELUBO_PAY}', left=1849, top=349, right=2000, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELSAVE_PAY-P_TELSAVE_PAY}', left=2011, top=349, right=2162, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ETC_PAY-P_ETC_PAY}', left=2172, top=349, right=2323, bottom=394, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_DEDUCT_SUM-P_DEDUCT_SUM}', left=2334, top=349, right=2532, bottom=394, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_REAL_PAY_SUM-P_REAL_PAY_SUM}', left=2553, top=349, right=2773, bottom=394, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<L> left=34 ,top=402 ,right=2781 ,bottom=402 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=48 ,top=347 ,right=48 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=352 ,top=106 ,right=352 ,bottom=402 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=257 ,top=106 ,right=257 ,bottom=402 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1519 ,top=106 ,right=1519 ,bottom=402 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2543 ,top=106 ,right=2543 ,bottom=402 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2781 ,top=106 ,right=2781 ,bottom=402 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=677 ,top=156 ,right=677 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=836 ,top=156 ,right=836 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=995 ,top=156 ,right=995 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1140 ,top=156 ,right=1140 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1304 ,top=156 ,right=1304 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1683 ,top=156 ,right=1683 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1842 ,top=156 ,right=1842 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2006 ,top=156 ,right=2006 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2167 ,top=156 ,right=2167 ,bottom=405 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2331 ,top=156 ,right=2331 ,bottom=405 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
		</B>
	</R>
</A>
<A>id=Area1 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='������.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , DetailDataID='gcds_report1' 
		<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=378 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=2331 ,top=122 ,right=2331 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2167 ,top=122 ,right=2167 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2006 ,top=122 ,right=2006 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1842 ,top=122 ,right=1842 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1683 ,top=122 ,right=1683 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1304 ,top=122 ,right=1304 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1140 ,top=122 ,right=1140 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=995 ,top=122 ,right=995 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=836 ,top=122 ,right=836 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=677 ,top=122 ,right=677 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2781 ,top=71 ,right=2781 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2543 ,top=71 ,right=2543 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1519 ,top=71 ,right=1519 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=257 ,top=71 ,right=257 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=352 ,top=71 ,right=352 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=48 ,top=312 ,right=48 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=34 ,top=368 ,right=2781 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='{C_REAL_PAY_SUM-P_REAL_PAY_SUM}', left=2553, top=315, right=2773, bottom=360, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_DEDUCT_SUM-P_DEDUCT_SUM}', left=2334, top=315, right=2532, bottom=360, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ETC_PAY-P_ETC_PAY}', left=2172, top=315, right=2323, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELSAVE_PAY-P_TELSAVE_PAY}', left=2011, top=315, right=2162, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELUBO_PAY-P_TELUBO_PAY}', left=1849, top=315, right=2000, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ADV_PAY-P_ADV_PAY}', left=1688, top=315, right=1839, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TEL_PAY-P_TEL_PAY}', left=1529, top=315, right=1680, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_PAY_SUM-P_PAY_SUM}', left=1312, top=315, right=1511, bottom=360, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_LST_PAY-P_LST_PAY}', left=1146, top=315, right=1296, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_BON_PAY-P_BON_PAY}', left=997, top=315, right=1138, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_REWARD_PAY-P_REWARD_PAY}', left=841, top=315, right=992, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_RET_PAY-P_RET_PAY}', left=683, top=315, right=833, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_O_TIME_TOT-P_O_TIME_TOT}', left=524, top=315, right=675, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_BASIC_TOT-P_BASIC_TOT}', left=360, top=315, right=516, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_CNT-P_CNT}', left=270, top=315, right=347, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='�����������' ,left=53 ,top=315 ,right=246 ,bottom=360 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=48 ,top=312 ,right=2778 ,bottom=312 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='C_REAL_PAY_SUM', left=2553, top=265, right=2773, bottom=310, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_DEDUCT_SUM', left=2334, top=265, right=2532, bottom=310, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ETC_PAY', left=2172, top=265, right=2323, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELSAVE_PAY', left=2011, top=265, right=2162, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELUBO_PAY', left=1849, top=265, right=2000, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ADV_PAY', left=1688, top=265, right=1839, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TEL_PAY', left=1529, top=265, right=1680, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_PAY_SUM', left=1312, top=265, right=1511, bottom=310, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_LST_PAY', left=1146, top=265, right=1296, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_BON_PAY', left=997, top=265, right=1138, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_REWARD_PAY', left=841, top=265, right=992, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_RET_PAY', left=683, top=265, right=833, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_O_TIME_TOT', left=524, top=265, right=675, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_BASIC_TOT', left=360, top=265, right=516, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_CNT', left=270, top=265, right=347, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_PAY_YM', left=45, top=265, right=243, bottom=310, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=34 ,top=259 ,right=2781 ,bottom=259 </L>
			<C>id='P_BASIC_TOT', left=360, top=212, right=516, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_O_TIME_TOT', left=524, top=212, right=675, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_RET_PAY', left=683, top=212, right=833, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REWARD_PAY', left=841, top=212, right=992, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_BON_PAY', left=997, top=212, right=1138, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_LST_PAY', left=1146, top=212, right=1296, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_PAY_SUM', left=1312, top=212, right=1511, bottom=257, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TEL_PAY', left=1529, top=212, right=1680, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ADV_PAY', left=1688, top=212, right=1839, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELUBO_PAY', left=1849, top=212, right=2000, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELSAVE_PAY', left=2011, top=212, right=2162, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ETC_PAY', left=2172, top=212, right=2323, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_DEDUCT_SUM', left=2334, top=212, right=2532, bottom=257, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REAL_PAY_SUM', left=2553, top=212, right=2773, bottom=257, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_CNT', left=273, top=212, right=349, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_PAY_YM', left=45, top=212, right=243, bottom=257, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1304 ,top=122 ,right=1521 ,bottom=122 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2331 ,top=122 ,right=2540 ,bottom=122 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='2  ������' ,left=32 ,top=5 ,right=235 ,bottom=58 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��  ��' ,left=45 ,top=82 ,right=246 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=201 ,right=2781 ,bottom=201 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=32 ,top=71 ,right=32 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='�ο�' ,left=270 ,top=82 ,right=347 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����޾�' ,left=2553 ,top=82 ,right=2773 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=1535 ,top=79 ,right=2484 ,bottom=119 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=352 ,top=122 ,right=2466 ,bottom=122 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=519 ,top=122 ,right=519 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='�����ұ�' ,left=1146 ,top=140 ,right=1296 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1312 ,top=140 ,right=1511 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1529 ,top=140 ,right=1680 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1688 ,top=140 ,right=1839 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=2172 ,top=140 ,right=2323 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=2334 ,top=140 ,right=2532 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=2011 ,top=124 ,right=2162 ,bottom=164 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=2011 ,top=156 ,right=2162 ,bottom=196 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1849 ,top=124 ,right=2000 ,bottom=164 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1849 ,top=156 ,right=2000 ,bottom=196 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�⺻' ,left=360 ,top=140 ,right=516 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='O/T��' ,left=524 ,top=140 ,right=675 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='������' ,left=683 ,top=140 ,right=833 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�󿩱�' ,left=997 ,top=140 ,right=1138 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�̽ǽ�' ,left=841 ,top=124 ,right=992 ,bottom=164 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����' ,left=841 ,top=156 ,right=992 ,bottom=196 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���޳���' ,left=360 ,top=79 ,right=1490 ,bottom=119 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=69 ,right=2781 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		</B>
	</R>
</A>
<A>id=Area2 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='��ȸ��.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , DetailDataID='gcds_report2' 
		<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=375 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=2331 ,top=116 ,right=2331 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2167 ,top=116 ,right=2167 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2006 ,top=116 ,right=2006 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1842 ,top=116 ,right=1842 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1683 ,top=116 ,right=1683 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1304 ,top=116 ,right=1304 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1140 ,top=116 ,right=1140 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=995 ,top=116 ,right=995 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=836 ,top=116 ,right=836 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=677 ,top=116 ,right=677 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2781 ,top=66 ,right=2781 ,bottom=362 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2543 ,top=66 ,right=2543 ,bottom=362 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1519 ,top=66 ,right=1519 ,bottom=362 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=257 ,top=66 ,right=257 ,bottom=362 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=352 ,top=66 ,right=352 ,bottom=362 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=48 ,top=307 ,right=48 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=34 ,top=362 ,right=2781 ,bottom=362 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='{C_REAL_PAY_SUM-P_REAL_PAY_SUM}', left=2553, top=310, right=2773, bottom=355, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_DEDUCT_SUM-P_DEDUCT_SUM}', left=2334, top=310, right=2532, bottom=355, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ETC_PAY-P_ETC_PAY}', left=2172, top=310, right=2323, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELSAVE_PAY-P_TELSAVE_PAY}', left=2011, top=310, right=2162, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELUBO_PAY-P_TELUBO_PAY}', left=1849, top=310, right=2000, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ADV_PAY-P_ADV_PAY}', left=1688, top=310, right=1839, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TEL_PAY-P_TEL_PAY}', left=1529, top=310, right=1680, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_PAY_SUM-P_PAY_SUM}', left=1312, top=310, right=1511, bottom=355, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_LST_PAY-P_LST_PAY}', left=1146, top=310, right=1296, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_BON_PAY-P_BON_PAY}', left=997, top=310, right=1138, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_REWARD_PAY-P_REWARD_PAY}', left=841, top=310, right=992, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_RET_PAY-P_RET_PAY}', left=683, top=310, right=833, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_O_TIME_TOT-P_O_TIME_TOT}', left=524, top=310, right=675, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_BASIC_TOT-P_BASIC_TOT}', left=360, top=310, right=516, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_CNT-P_CNT}', left=270, top=310, right=347, bottom=355, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='�����������' ,left=53 ,top=310 ,right=246 ,bottom=355 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=48 ,top=307 ,right=2778 ,bottom=307 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='C_REAL_PAY_SUM', left=2553, top=259, right=2773, bottom=304, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_DEDUCT_SUM', left=2334, top=259, right=2532, bottom=304, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ETC_PAY', left=2172, top=259, right=2323, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELSAVE_PAY', left=2011, top=259, right=2162, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELUBO_PAY', left=1849, top=259, right=2000, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ADV_PAY', left=1688, top=259, right=1839, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TEL_PAY', left=1529, top=259, right=1680, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_PAY_SUM', left=1312, top=259, right=1511, bottom=304, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_LST_PAY', left=1146, top=259, right=1296, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_BON_PAY', left=997, top=259, right=1138, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_REWARD_PAY', left=841, top=259, right=992, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_RET_PAY', left=683, top=259, right=833, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_O_TIME_TOT', left=524, top=259, right=675, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_BASIC_TOT', left=360, top=259, right=516, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_CNT', left=270, top=259, right=347, bottom=304, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_PAY_YM', left=45, top=259, right=243, bottom=304, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=34 ,top=254 ,right=2781 ,bottom=254 </L>
			<C>id='P_BASIC_TOT', left=360, top=206, right=516, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_O_TIME_TOT', left=524, top=206, right=675, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_RET_PAY', left=683, top=206, right=833, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REWARD_PAY', left=841, top=206, right=992, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_BON_PAY', left=997, top=206, right=1138, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_LST_PAY', left=1146, top=206, right=1296, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_PAY_SUM', left=1312, top=206, right=1511, bottom=251, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TEL_PAY', left=1529, top=206, right=1680, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ADV_PAY', left=1688, top=206, right=1839, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELUBO_PAY', left=1849, top=206, right=2000, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELSAVE_PAY', left=2011, top=206, right=2162, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ETC_PAY', left=2172, top=206, right=2323, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_DEDUCT_SUM', left=2334, top=206, right=2532, bottom=251, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REAL_PAY_SUM', left=2553, top=206, right=2773, bottom=251, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_CNT', left=273, top=206, right=349, bottom=251, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_PAY_YM', left=45, top=206, right=243, bottom=251, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1304 ,top=116 ,right=1521 ,bottom=116 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2331 ,top=116 ,right=2540 ,bottom=116 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='3  ��ȸ��' ,left=32 ,top=0 ,right=235 ,bottom=53 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��  ��' ,left=45 ,top=77 ,right=246 ,bottom=185 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=196 ,right=2781 ,bottom=196 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=32 ,top=66 ,right=32 ,bottom=362 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='�ο�' ,left=270 ,top=77 ,right=347 ,bottom=185 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����޾�' ,left=2553 ,top=77 ,right=2773 ,bottom=185 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=1535 ,top=74 ,right=2484 ,bottom=114 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=352 ,top=116 ,right=2466 ,bottom=116 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=519 ,top=116 ,right=519 ,bottom=362 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='�����ұ�' ,left=1146 ,top=135 ,right=1296 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1312 ,top=135 ,right=1511 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1529 ,top=135 ,right=1680 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1688 ,top=135 ,right=1839 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=2172 ,top=135 ,right=2323 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=2334 ,top=135 ,right=2532 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=2011 ,top=119 ,right=2162 ,bottom=159 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=2011 ,top=151 ,right=2162 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1849 ,top=119 ,right=2000 ,bottom=159 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1849 ,top=151 ,right=2000 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�⺻' ,left=360 ,top=135 ,right=516 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='O/T��' ,left=524 ,top=135 ,right=675 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='������' ,left=683 ,top=135 ,right=833 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�󿩱�' ,left=997 ,top=135 ,right=1138 ,bottom=175 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�̽ǽ�' ,left=841 ,top=119 ,right=992 ,bottom=159 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����' ,left=841 ,top=151 ,right=992 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���޳���' ,left=360 ,top=74 ,right=1490 ,bottom=114 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=64 ,right=2781 ,bottom=64 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		</B>
	</R>
</A>
<A>id=Area3 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='���¾�ü.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , DetailDataID='gcds_report3' 
		<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=370 ,face='Arial' ,size=10 ,penwidth=1
			<L> left=2331 ,top=122 ,right=2331 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2167 ,top=122 ,right=2167 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2006 ,top=122 ,right=2006 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1842 ,top=122 ,right=1842 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1683 ,top=122 ,right=1683 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1304 ,top=122 ,right=1304 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1140 ,top=122 ,right=1140 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=995 ,top=122 ,right=995 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=836 ,top=122 ,right=836 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=677 ,top=122 ,right=677 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2781 ,top=71 ,right=2781 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2543 ,top=71 ,right=2543 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1519 ,top=71 ,right=1519 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=257 ,top=71 ,right=257 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=352 ,top=71 ,right=352 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=48 ,top=312 ,right=48 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=34 ,top=368 ,right=2781 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<C>id='{C_REAL_PAY_SUM-P_REAL_PAY_SUM}', left=2553, top=315, right=2773, bottom=360, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_DEDUCT_SUM-P_DEDUCT_SUM}', left=2334, top=315, right=2532, bottom=360, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ETC_PAY-P_ETC_PAY}', left=2172, top=315, right=2323, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELSAVE_PAY-P_TELSAVE_PAY}', left=2011, top=315, right=2162, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELUBO_PAY-P_TELUBO_PAY}', left=1849, top=315, right=2000, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ADV_PAY-P_ADV_PAY}', left=1688, top=315, right=1839, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TEL_PAY-P_TEL_PAY}', left=1529, top=315, right=1680, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_PAY_SUM-P_PAY_SUM}', left=1312, top=315, right=1511, bottom=360, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_LST_PAY-P_LST_PAY}', left=1146, top=315, right=1296, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_BON_PAY-P_BON_PAY}', left=997, top=315, right=1138, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_REWARD_PAY-P_REWARD_PAY}', left=841, top=315, right=992, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_RET_PAY-P_RET_PAY}', left=683, top=315, right=833, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_O_TIME_TOT-P_O_TIME_TOT}', left=524, top=315, right=675, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_BASIC_TOT-P_BASIC_TOT}', left=360, top=315, right=516, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_CNT-P_CNT}', left=270, top=315, right=347, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<T>id='�����������' ,left=53 ,top=315 ,right=246 ,bottom=360 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=48 ,top=312 ,right=2778 ,bottom=312 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<C>id='C_REAL_PAY_SUM', left=2553, top=265, right=2773, bottom=310, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_DEDUCT_SUM', left=2334, top=265, right=2532, bottom=310, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ETC_PAY', left=2172, top=265, right=2323, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELSAVE_PAY', left=2011, top=265, right=2162, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELUBO_PAY', left=1849, top=265, right=2000, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ADV_PAY', left=1688, top=265, right=1839, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TEL_PAY', left=1529, top=265, right=1680, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_PAY_SUM', left=1312, top=265, right=1511, bottom=310, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_LST_PAY', left=1146, top=265, right=1296, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_BON_PAY', left=997, top=265, right=1138, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_REWARD_PAY', left=841, top=265, right=992, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_RET_PAY', left=683, top=265, right=833, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_O_TIME_TOT', left=524, top=265, right=675, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_BASIC_TOT', left=360, top=265, right=516, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_CNT', left=270, top=265, right=347, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_PAY_YM', left=45, top=265, right=243, bottom=310, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=34 ,top=259 ,right=2781 ,bottom=259 </L>
			<C>id='P_BASIC_TOT', left=360, top=212, right=516, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_O_TIME_TOT', left=524, top=212, right=675, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_RET_PAY', left=683, top=212, right=833, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REWARD_PAY', left=841, top=212, right=992, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_BON_PAY', left=997, top=212, right=1138, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_LST_PAY', left=1146, top=212, right=1296, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_PAY_SUM', left=1312, top=212, right=1511, bottom=257, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TEL_PAY', left=1529, top=212, right=1680, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ADV_PAY', left=1688, top=212, right=1839, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELUBO_PAY', left=1849, top=212, right=2000, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELSAVE_PAY', left=2011, top=212, right=2162, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ETC_PAY', left=2172, top=212, right=2323, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_DEDUCT_SUM', left=2334, top=212, right=2532, bottom=257, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REAL_PAY_SUM', left=2553, top=212, right=2773, bottom=257, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_CNT', left=273, top=212, right=349, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_PAY_YM', left=45, top=212, right=243, bottom=257, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=1304 ,top=122 ,right=1521 ,bottom=122 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=2331 ,top=122 ,right=2540 ,bottom=122 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<T>id='4  ���¾�ü' ,left=32 ,top=5 ,right=235 ,bottom=58 ,align='left' ,face='����' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��  ��' ,left=45 ,top=82 ,right=246 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=34 ,top=201 ,right=2781 ,bottom=201 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=32 ,top=71 ,right=32 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='�ο�' ,left=270 ,top=82 ,right=347 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����޾�' ,left=2553 ,top=82 ,right=2773 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=1535 ,top=79 ,right=2484 ,bottom=119 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=352 ,top=122 ,right=2466 ,bottom=122 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=519 ,top=122 ,right=519 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='�����ұ�' ,left=1146 ,top=140 ,right=1296 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1312 ,top=140 ,right=1511 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1529 ,top=140 ,right=1680 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1688 ,top=140 ,right=1839 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=2172 ,top=140 ,right=2323 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=2334 ,top=140 ,right=2532 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=2011 ,top=124 ,right=2162 ,bottom=164 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=2011 ,top=156 ,right=2162 ,bottom=196 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1849 ,top=124 ,right=2000 ,bottom=164 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1849 ,top=156 ,right=2000 ,bottom=196 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�⺻' ,left=360 ,top=140 ,right=516 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='O/T��' ,left=524 ,top=140 ,right=675 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='������' ,left=683 ,top=140 ,right=833 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�󿩱�' ,left=997 ,top=140 ,right=1138 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�̽ǽ�' ,left=841 ,top=124 ,right=992 ,bottom=164 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����' ,left=841 ,top=156 ,right=992 ,bottom=196 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='���޳���' ,left=360 ,top=79 ,right=1490 ,bottom=119 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=32 ,top=69 ,right=2781 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
		</B>
	</R>
</A>
<A>id=Area4 ,left=0,top=0 ,right=2871 ,bottom=133
	<R>id='������.sbt' ,left=0 ,top=0 ,right=2831 ,bottom=132 , DetailDataID='gcds_report9' 
		<B>id=default ,left=0,top=0 ,right=2871 ,bottom=368 ,face='Arial' ,size=10 ,penwidth=1
			<C>id='{currow+4}', left=42, top=16, right=93, bottom=61, align='left' ,mask='XX.', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='C_GROUPNM', left=90, top=16, right=603, bottom=61, align='left', face='����', size=10, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=42 ,top=69 ,right=2791 ,bottom=69 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='���޳���' ,left=370 ,top=79 ,right=1500 ,bottom=119 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����' ,left=852 ,top=156 ,right=1003 ,bottom=196 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�̽ǽ�' ,left=852 ,top=124 ,right=1003 ,bottom=164 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�󿩱�' ,left=1008 ,top=140 ,right=1148 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='������' ,left=693 ,top=140 ,right=844 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='O/T��' ,left=534 ,top=140 ,right=685 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�⺻' ,left=370 ,top=140 ,right=527 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1860 ,top=156 ,right=2011 ,bottom=196 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1860 ,top=124 ,right=2011 ,bottom=164 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��������' ,left=2021 ,top=156 ,right=2172 ,bottom=196 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=2021 ,top=124 ,right=2172 ,bottom=164 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=2344 ,top=140 ,right=2543 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��Ÿ' ,left=2183 ,top=140 ,right=2334 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='����' ,left=1699 ,top=140 ,right=1849 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��ȭ��' ,left=1540 ,top=140 ,right=1691 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='��' ,left=1323 ,top=140 ,right=1521 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����ұ�' ,left=1156 ,top=140 ,right=1307 ,bottom=180 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=529 ,top=122 ,right=529 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=362 ,top=122 ,right=2477 ,bottom=122 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='��������' ,left=1545 ,top=79 ,right=2495 ,bottom=119 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�����޾�' ,left=2564 ,top=82 ,right=2783 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<T>id='�ο�' ,left=280 ,top=82 ,right=357 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=42 ,top=71 ,right=42 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=45 ,top=201 ,right=2791 ,bottom=201 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<T>id='��  ��' ,left=56 ,top=82 ,right=257 ,bottom=191 ,face='����' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<L> left=2342 ,top=122 ,right=2551 ,bottom=122 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1315 ,top=122 ,right=1532 ,bottom=122 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id='P_PAY_YM', left=56, top=212, right=254, bottom=257, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_CNT', left=283, top=212, right=360, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REAL_PAY_SUM', left=2564, top=212, right=2783, bottom=257, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_DEDUCT_SUM', left=2344, top=212, right=2543, bottom=257, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ETC_PAY', left=2183, top=212, right=2334, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELSAVE_PAY', left=2021, top=212, right=2172, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TELUBO_PAY', left=1860, top=212, right=2011, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_ADV_PAY', left=1699, top=212, right=1849, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_TEL_PAY', left=1540, top=212, right=1691, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_PAY_SUM', left=1323, top=212, right=1521, bottom=257, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_LST_PAY', left=1156, top=212, right=1307, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_BON_PAY', left=1008, top=212, right=1148, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_REWARD_PAY', left=852, top=212, right=1003, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_RET_PAY', left=693, top=212, right=844, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_O_TIME_TOT', left=534, top=212, right=685, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='P_BASIC_TOT', left=370, top=212, right=527, bottom=257, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=45 ,top=259 ,right=2791 ,bottom=259 </L>
			<C>id='C_LST_PAY', left=1156, top=265, right=1307, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_PAY_SUM', left=1323, top=265, right=1521, bottom=310, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TEL_PAY', left=1540, top=265, right=1691, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ADV_PAY', left=1699, top=265, right=1849, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELUBO_PAY', left=1860, top=265, right=2011, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_TELSAVE_PAY', left=2021, top=265, right=2172, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_ETC_PAY', left=2183, top=265, right=2334, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_DEDUCT_SUM', left=2344, top=265, right=2543, bottom=310, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_REAL_PAY_SUM', left=2564, top=265, right=2783, bottom=310, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<L> left=58 ,top=312 ,right=2789 ,bottom=312 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<T>id='�����������' ,left=64 ,top=315 ,right=257 ,bottom=360 ,align='right' ,face='����' ,size=9 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
			<C>id='{C_CNT-P_CNT}', left=280, top=315, right=357, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
			<C>id='{C_BASIC_TOT-P_BASIC_TOT}', left=370, top=315, right=527, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_O_TIME_TOT-P_O_TIME_TOT}', left=534, top=315, right=685, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_RET_PAY-P_RET_PAY}', left=693, top=315, right=844, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_REWARD_PAY-P_REWARD_PAY}', left=852, top=315, right=1003, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_BON_PAY-P_BON_PAY}', left=1008, top=315, right=1148, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_LST_PAY-P_LST_PAY}', left=1156, top=315, right=1307, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_PAY_SUM-P_PAY_SUM}', left=1323, top=315, right=1521, bottom=360, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TEL_PAY-P_TEL_PAY}', left=1540, top=315, right=1691, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ADV_PAY-P_ADV_PAY}', left=1699, top=315, right=1849, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELUBO_PAY-P_TELUBO_PAY}', left=1860, top=315, right=2011, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_TELSAVE_PAY-P_TELSAVE_PAY}', left=2021, top=315, right=2172, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_ETC_PAY-P_ETC_PAY}', left=2183, top=315, right=2334, bottom=360, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_DEDUCT_SUM-P_DEDUCT_SUM}', left=2344, top=315, right=2543, bottom=360, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<C>id='{C_REAL_PAY_SUM-P_REAL_PAY_SUM}', left=2564, top=315, right=2783, bottom=360, align='right', face='����', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=2</C>
			<L> left=45 ,top=368 ,right=2791 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=58 ,top=312 ,right=58 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=362 ,top=71 ,right=362 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=267 ,top=71 ,right=267 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=1529 ,top=71 ,right=1529 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2553 ,top=71 ,right=2553 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=2791 ,top=71 ,right=2791 ,bottom=368 ,penstyle=solid ,penwidth=5 ,pencolor=#000000 </L>
			<L> left=688 ,top=122 ,right=688 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=847 ,top=122 ,right=847 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1005 ,top=122 ,right=1005 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1151 ,top=122 ,right=1151 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1315 ,top=122 ,right=1315 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<L> left=1693 ,top=122 ,right=1693 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=1852 ,top=122 ,right=1852 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2016 ,top=122 ,right=2016 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2178 ,top=122 ,right=2178 ,bottom=368 ,penstyle=dot ,penwidth=1 ,pencolor=#000000 </L>
			<L> left=2342 ,top=122 ,right=2342 ,bottom=368 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
			<C>id='C_BON_PAY', left=1008, top=265, right=1148, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_REWARD_PAY', left=852, top=265, right=1003, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_RET_PAY', left=693, top=265, right=844, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_O_TIME_TOT', left=534, top=265, right=685, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_BASIC_TOT', left=370, top=265, right=527, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_PAY_YM', left=56, top=265, right=254, bottom=310, align='right' ,mask='XXXX.XX��', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
			<C>id='C_CNT', left=280, top=265, right=357, bottom=310, align='right', face='����', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
		</B>
	</R>
</A>
<B>id=Footer ,left=0 ,top=1910 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=8 ,top=5 ,right=2826 ,bottom=5 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='#p/#t' ,left=8 ,top=19 ,right=2815 ,bottom=87</T>
	<I>id='../common/img/icon.jpg' ,left=2400 ,top=13 ,right=2781 ,bottom=90</I>
</B>
">
</OBJECT><%=HDConstant.COMMENT_END%>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>