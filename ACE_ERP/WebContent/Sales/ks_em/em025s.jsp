<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*--------------------------------------------------------------------------------
+ �ý��۸� : ��¹߷ɰ�
+ ���α׷�ID : ks_em012s.jsp
+ ������� : 
+ �� �� �� : �� �� �� 
+ �ۼ����� : 2008.09.16
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

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
            <td bgcolor="#eeeeee" align="center"></td>
            <td bgcolor="#eeeeee" align="center"></td>
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
            <td bgcolor="#eeeeee" align="center"></td>
            <td bgcolor="#FFFFFF">

            </td>
            <td bgcolor="#eeeeee" align="center" width="100"></td>
            <td bgcolor="#FFFFFF">

            </td>
          </tr>
          <tr height="25">
            <td bgcolor="#FFFFFF">

            </td>
            <td bgcolor="#eeeeee" align="center" width="100"></td>
            <td bgcolor="#FFFFFF">

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
				</table>

			</td>
		</tr>
	</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>
</body>
</html>