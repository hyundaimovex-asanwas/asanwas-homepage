
<%
/****************************************************************************
 * �ý��۸� 		: ȣ�� ����
 * ���α׷�ID 	: SAMPLE (�ڵ�� �빮��)
 * J  S  P		: K010001.jsp
 * �� �� ��		: 
 * �� �� ��		: �ּ���
 * �� �� ��		: 2006-05-02
 * �������		:  ��ȸ, ���, ���� ����,
 * ��������		: 2006-05-02 : XXXXX ���� XXXXX ������û (�Ϸ�/�̿Ϸ�)
 * �� �� ��		: �ּ���
 * ������������ 	: 2006-05-04 
 * 
 * 
 *
 ***************************************************************************/
 %>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>

<%@ page import="sales.common.*"%>

<%
	// ContextPath
	String dirPath = request.getContextPath();
	
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<title>ȣ������ </title>
		<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<%
/*=============================================================================
				Style Sheet, Common Java Script Link
=============================================================================*/
%>		
		<link rel="stylesheet" href="<%=dirPath%>/Sales/common/include/common.css">

		<Script language="javascript" src="<%=dirPath%>/Sales/common/include/PubFun.js"></script>



<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>

<script language="javascript">
    	get_cookdata();
        var gs_userid = gusrid;
        var gs_fdcode = gfdcode;

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ������ �ε� 
// Parameter 	: 
%>
			function fnOnLoad(){
			fnInit();
			}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ����ȸ
// Parameter 	: 
%>
			function fnInit(){ 
			ln_SetDataHeader1();
			ln_SetDataHeader2();
	}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ȸ1
// Parameter 	: 
%>
    function fn_Query(){ 
         //if(gcds_data1.IsUpdated || gcds_data2.IsUpdated) {
					//alert("�������� ���� �ֽ��ϴ�.");
					//return;
				//}
         //else {
					gcds_data1.DataId = "<%=dirPath%><%=HDConstant.PATH_RM%>A0010_t0?proType=S&dsType=1&s_Head=" + txt_head.value + "&s_HeadName=" + txt_head_name.value;
					gcds_data1.Reset();
//}
			//}   
	 
	 //gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu020i?proType=&dsType=&s_Head=" + txt_head.value + "&s_HeadName=" + txt_head_name.value;
	 //gcds_data1.Reset(); 		

}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��ȸ2
// Parameter 	: 
%>
function fn_Query2(){   
	
gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_RM%>A0010_t0?proType=S&dsType=2&s_UpjangSid&s_SaupSid="+gcds_data1.namevalue(gcds_data1.rowposition,"SAUP_SID");
gcds_data2.Reset();


}

<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �߰� 
// Parameter 	: 
%>
function fn_Add2(){
    if (confirm("�Է��Ͻ� ������ �߰��Ͻðڽ��ϱ�?")){
	    gcds_data2.addrow();
	    gcds_data2.namevalue(gcds_data2.rowposition,"SAUP_SID")=gcds_data1.namevalue(gcds_data1.rowposition,"SAUP_SID");
       gcds_data2.namevalue(gcds_data2.rowposition,"SAUP_SID")=Number();
       gcgd_data2.setcolumn("DETAIL");
	   txt_focus.value=gcds_data2.rowposition;
	     window.status="Detail ���� ���ԵǾ����ϴ�.";
 }
}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 2
// Parameter 	: 
%>
        function fn_Save2(){
            var row1=gcds_data1.countrow;
	        var row2=gcds_data2.countrow;
                  if (confirm(" �������Ͻðڽ��ϱ�?")){
	                 if (gcds_data2.IsUpdated) {
                         if (fn_Chk()) {
			gctr_data2.KeyValue = "a0010_t0(I:USER=gcds_data2)";
			gctr_data2.Action ="<%=dirPath%><%=HDConstant.PATH_RM%>A0010_t0?proType=A&dsNum=1";
			gctr_data2.post();
		}
	}
}
}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
%>
function fn_Save(){

	var row1=gcds_data1.countrow;
	var row2=gcds_data2.countrow;
	if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){
		if (gcds_data2.IsUpdated) {

			if (fn_Chk()) {
			
				gctr_data2.KeyValue = "a0010_t0(I:USER=gcds_data2)";
				gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_RM%>A0010_t0?proType=A&dsNum=1";
				gctr_data2.post();
			}
		}
	}


}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  �Է°� üũ 
// Parameter 	: 
%>
function fn_Chk() {
	
var row1=gcds_data1.countrow;
var row2=gcds_data2.countrow;
	for(i=1;i<=row1;i++) {
		if(gcds_data1.namevalue(i,"SAUP_SID")=="") {
	alert(" �Է��� �ֽʽÿ�");
		return false;
	}
	}
for(i=1;i<=row2;i++) {
	if (gcds_data2.namevalue(i,"DETAIL")=="") {			
		alert(" �Է��� �ֽʽÿ�");
		return false;
	}
	}
return true;

}


<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>
function fn_Delete(){

	if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")){
	gcds_data2.deleteall();
		gcds_data2.deleterow(gcds_data2.rowposition);
	fn_Save2();
		window.status="Detail ���� �����Ǿ����ϴ�.";
	}

}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ��� 
// Parameter 	: 
%>
function fn_Print(){

gcrp_print1.preview();

}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  ���� 
// Parameter 	: 
%>

function fn_Excel(){

gcgd_data2.runexcel("ȣ�� ����");

}


<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
// Parameter	:
%>	
			function ln_SetDataHeader1(){
			if (gcds_data1.countrow<1){
				var s_temp = "SAUP_SID:STRING,SAUP_NM:STRING,SAUP_ENG_NM:STRING,U_DATE:STRING";
			gcds_data1.SetDataHeader(s_temp);
			}
		}
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  DataSet Head ���� 
%>	

			function ln_SetDataHeader2(){
			if (gcds_data2.countrow<1){
				var s_temp = "SAUP_SID:STRING,UPJANG_SID:STRING,UPJANG_NM:STRING,"
						   + "UPJANG-SID:STRING,UPJANG_CD:STRING,UPJANG_NM:STRING,UPJANG_ENG_NM:STRING,DIRECT_SID:STRING"
					       + "SAUP_SID:STRING,U_EMPNO:STRING,U_DATE:STRING,U_IP:STRING";   
				gcds_data2.SetDataHeader(s_temp);
			}
		}	






 </script>

<%
/*----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------*/
%>
<object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name= SortExpr 	value="+HEAD">
</object>
<object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
	<param name=SortExpr	value="+HEAD">
</object>
<%
/*-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------*/
%>
<object  id="gctr_data1" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object>
<object  id="gctr_data2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object>
<script language="javascript"  for=gcgd_data1  event=OnClick(row,colid)>
  fn_Query2();
  </script>
 <script language=JavaScript for=gcgd_data1 event=OnEnter(row,colid)>
  if(colid=="SAUP_SID") {
	if(txt_status_head1.value!="") {
		alert("Ű���� ������ �� �����ϴ�.");
		gcds_data1.namevalue(row,colid)=txt_status_head1.value;
		return;
		}
	}
</script>


<%
/* ---------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
---------------------------------------------------------------------------- */
%>

<script language=JavaScript  for=gcds_data1 event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";	
</script>

<script language=JavaScript  for=gcds_data1 event="OnLoadError()">
	alert("������ �߻��߽��ϴ� : " + gcds_data1.ErrorMsg );
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
  document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data1 event="OnLoadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	if( row < 1){
		alert("�˻��� ����Ÿ�� �����ϴ�."); 
	}
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";	
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadError()">
     alert("������ �߻��߽��ϴ� : " + gcds_data2.ErrorMsg );
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
  document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data2 event="OnLoadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
	
</script>


<%
/*-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------*/
%>

</HEAD>

<body bgcolor="#FFFFFF" topmargin="0" marginheight="0" leftmargin="0" marginwidth="0" onload="fnOnLoad()" style="overflow:hidden">
<table width="877" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;" >
  <tr> 
    <td background="/Sales/common/img/com_t_bg.gif"><img src="../img/tsy160.gif"></td>
    <td align="right" style="padding-top:10px;" background="/Sales/common/img/com_t_bg.gif">&nbsp;&nbsp;</td>
  </tr>
  </table>
<table  cellpadding="1" cellspacing="0" border="0"  style='width:877px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<tr> 
				    <td>
                       <input id="txt_head" type="hidden" size="1">
					<input id="txt_head_name" type="hidden" size="1">
						<input id="txt_focus" type="hidden" size="1">
					</td>
					<td align="right" width=100%>					
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_excel.gif"  style="cursor:hand;position:relative;left:-5px;top:3px" onclick="fn_Excel()">
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_print.gif"  style="cursor:hand;position:relative;left:-5px;top:3px" onclick="fn_Print()">
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_delete.gif" style="cursor:hand;position:relative;left:-5px;top:3px" onClick="fn_Delete()" >
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_insert.gif"	 style="cursor:hand;position:relative;left:-5px;top:3px"  onClick="fn_Add2()">
							<img src="<%=dirPath%>/Sales/common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;left:-5px;top:3px" onClick="fn_Save()">
						    <img src="<%=dirPath%>/Sales/common/img/btn/com_b_query.gif"   style="cursor:hand;position:relative;left:-5px;top:3px" onclick="fn_Query()">
				     </td>
				</tr>
	</table>	
    <table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:200px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
						<tr> 
										<td>
											  <object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data1  style="WIDTH:140px;HEIGHT:400px;border:1 solid #777777;">
												<PARAM NAME="DataID"			 VALUE="gcds_data1">
												<PARAM NAME="Editable"        VALUE=" true">
												<PARAM NAME="BorderStyle"   VALUE="0">
												<param name="Fillarea"		     VALUE="true">
												<param name=ColSizing          value="true">
												<param name="IndWidth"       value="0">
												<PARAM NAME="Format"		      VALUE="  
													<C> Name='' ID={CURROW} HeadAlign=Center HeadBgColor=#B9D4DC Width=20 align=center </C>						
													<C> Name='�����ڵ�'  ID=SAUP_CD   HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=left </C>	
													<C> Name='������'  ID=SAUP_NM  HeadAlign=Center HeadBgColor=#B9D4DC Width=60 align=left </C>	
												">
											</object> 
										</td>
		
										<td>
											<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data2  style="WIDTH:650px;HEIGHT:400px;border:1 solid #777777;">
												<PARAM NAME="DataID"			 VALUE="gcds_data2">
												<PARAM NAME="Editable"        VALUE="True">
												<PARAM NAME="BorderStyle"    VALUE="0">
												<param name="Fillarea"		     VALUE="true">
												<param name=ColSizing          value="true">
												<param name="IndWidth"        value="0">
												<PARAM NAME="Format"		     VALUE="  
									     <C> Name=' '					ID={CURROW}			HeadAlign=Center HeadBgColor=#B9D4DC Width=30 align=center </C>	
									    <C> Name='�������ڵ�'  ID=UPJANG_CD			HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left </C>
										<C> Name='�������'		ID= UPJANG_NM			HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left </C>
										<C> Name='������'			ID=UPJANG_ENG_NM  HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left </C>
										<C> Name='��������'		ID=DIRECT_YN			HeadAlign=Center         EditStyle=CheckBox    
										HeadBgColor=#B9D4DC Width=100 align=Center </C>
										<C> Name='���������ڻ��'	  ID=U_EMPNO	HeadAlign=Center HeadBgColor=#B9D4DC Width=80 align=left </C>										
										<C> Name='��������'		ID=U_IP 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left </C>
										<C> Name='�����SID'		ID=SAUP_ID 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left </C>
										">
									</object>
									</td>
								</tr>
	</table>
			
<%
/*-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------*/
%>

<object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='  
	<C>Col=HEAD                    Ctrl=gcem_head              Param=text</C>
	<C>Col=HEAD_NAME               Ctrl=gcem_head_name         Param=text</C>
	'>
</object>
<%
/*-----------------------------------------------------------------------------
					��¹� ���Ǻκ�
-----------------------------------------------------------------------------*/
%>
<object  id="gcrp_print1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
	<param NAME="MasterDataID"			VALUE="gcds_data2">
	<param NAME="DetailDataID"			VALUE="gcds_data2">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
	<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">	
	<PARAM NAME="Format"                VALUE="
<B>id=Header ,left=0,top=0 ,right=2869 ,bottom=238 ,face='Arial' ,size=12 ,penwidth=2
	<L> left=25 ,top=237 ,right=2778 ,bottom=237 </L>
	<T>id='ȣ������' ,left=0 ,top=25 ,right=2791 ,bottom=122 ,face='HY������M' ,size=18 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='#p/#t' ,left=2641 ,top=178 ,right=2756 ,bottom=234 ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Page:' ,left=2328 ,top=178 ,right=2591 ,bottom=234 ,align='right' ,face='����' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
</B>
">
</object> 

<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="/Sales/common/img/flash/loading.swf" width="320px" height="42px">
</iframe> 

</body>
</html>


