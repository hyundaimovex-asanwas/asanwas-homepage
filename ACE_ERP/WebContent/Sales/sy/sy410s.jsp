<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: �������������ȸ
 * ���α׷�ID 	: SY410S
 * J  S  P		: sy410s
 * �� �� ��		: Sy410S
 * �� �� ��		: ������
 * �� �� ��		: 2006-06-02
 * �������		: �������������ȸ(��ȸ)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	 
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>	
		<script language="javascript">
		
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit();
		}

		/*
		 * ����Ÿ�� ��� ����
		 */
		function fnSetHeaderDsInit(){
		
		}	
			
		/*
		 * �ʱ��۾�
		 */
		function fnInit(){
			
			ds2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY008";
			ds2.reset();
		}
			
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			fnSelectDs1();
		}
			
		/*
		 * �����ͼ� ù��° ��ȸ
		 */
		function fnSelectDs1() {
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_SY%>Sy410S?proType=S&dsType=1&s_DeptCd="+txt_dept_cd.value.toUpperCase()
																					+"&s_SalDamCd="+txt_sal_dam_cd.value.toUpperCase()
																					+"&s_SalDamNm="+txt_sal_dam_nm.value
																					+"&s_UseYn=";
			ds1.Reset();			
		}
			
		/*
		 * ���߰� , �ű� 
		 */
		function fnAddRowDs1() {

		}
			
		/*
		 * �����, ����
		 */
		function fnDeleteRow() {

		}
			
		/*
		 * ����
		 */
		function fnApply() {

		}
			
		/*
		 * ��� 
		 */
		function fnCancelDs1() {

		}			
			
		/*
		 * ����Ʈ
		 */
		function fnPrintDs1() {
		}
			
		/*
		 * ����
		 */
		function fnExcelDs1() {

		}
			
		/*
		 * �˾�
		 */
		function fnPopup() {
			
		}
			
		/*
		 * �Է� üũ
		 */
		function fnCheck() {
		
		}
		
		</script>		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 
%>
		<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ�
%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			document.all.LowerFrame.style.visibility="hidden";
			if( row < 1){
				window.status="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds1 event="OnLoadError()">
			alert("<%=HDConstant.AS_MSG_SEARCH_ERR%>");
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� 
%>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			document.all.LowerFrame.style.visibility="visible";	
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�Ϸ�
%>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			document.all.LowerFrame.style.visibility="hidden";
			ds2.InsertRow(1);
			ds2.namevalue(1,"detail")="";
			ds2.namevalue(1,"detail_nm")="��ü";
			drp_gunmu.index=0;
			if( row < 1){
				window.status="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
		</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  ��ȸ�� ���� 
%>		
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			document.all.LowerFrame.style.visibility="hidden";
		</script>

<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>

	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<param name="SyncLoad" 	value="false">
	</object>
	<%=HDConstant.COMMENT_END%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<param name="SyncLoad" 	value="false">
	</object>
	<%=HDConstant.COMMENT_END%>



</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
  <tr>
	<td>
		<table  cellpadding="0" cellspacing="0" border="0">
		  <tr> 
			<td width="51px">
				<table width="660px" cellpadding="0" cellspacing="0" border="0"  style='width:660px;height:30px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
				  <tr> 
					<td style="width:70px;height:30px;border:1 solid #708090;" bgcolor="#eeeeee" align=center class="txtbox">�μ��ڵ�</td>
					<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
						<input id="txt_dept_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:70px; height:20px;" maxlength="50">
					</td>
					<td style="width:70px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">�ٹ�����</td>
					<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
						<%=HDConstant.COMMENT_START%>
						<object id=drp_gunmu classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=150 width=80 style="position:relative;left:1px;top:2px" class="txtbox" >
							<param name=ComboDataID			value=ds2>
							<param name=SearchColumn		value="detail_nm">
							<param name=Sort				value="false">
							<param name=ListExprFormat		value="detail_nm^0^150">
							<param name=BindColumn			value="detail">
						</object>
						<%=HDConstant.COMMENT_END%>
					</td>
					<td style="width:70px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">������ڵ�</td>
					<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
						<input id="txt_sal_dam_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:70px; height:20px;" maxlength="50">
					</td>
					<td style="width:70px;height:30px;border:1 solid #708090;border-left-width:0px" bgcolor="#eeeeee" align=center class="txtbox">����ڸ�</td>
					<td style="border:1 solid #708090;border-left-width:0px">&nbsp;
						<input id="txt_sal_dam_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:70px; height:20px;" maxlength="50">
					</td>
				  </tr>
				</table>
			</td>
			<td width="180" align="right"><table  cellpadding="0" cellspacing="0" border="0"><nobr>
				<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnSelectDs1()">
				<img src="<%=dirPath%>/Sales/images/print.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnPrintDs1()">
				<img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnExcelDs1()"></nobr>
			</td>
		  </tr>
		</table>	
	</td>
  </tr>
</table>		

<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:1px;width:310px;height:300px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
  <tr>
  	<td height=3  border="0"></td>
  </tr>
  <tr> 
	<td valign=top> 
		<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:270px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
		  <tr> 
			<td>
				<%=HDConstant.COMMENT_START%>											
				<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1  style="WIDTH:845px;HEIGHT:450px;border:1 solid #777777;">
					<param name="DataID"		VALUE="ds1">
					<param name="BorderStyle"   VALUE="0">
					<param name="Fillarea"		VALUE="true">
					<param name=ColSizing       value="false">
					<param name="IndWidth"      value="0">
					<param name="editable"      value="true">
					<param name=UsingOneClick  	value="1">
					<param name="Format"		VALUE="  
						<C> name='�μ���' 	  ID='deptnm' 	  HeadAlign=Center Width=150 align=left</C>						
						<C> name='������ڵ�' ID='sal_dam_cd' HeadAlign=Center Width=80 align=center</C>
						<C> name='����ڸ�'   ID='sal_dam_nm' HeadAlign=Center Width=100 align=left</C>
						<C> name='�������α���' ID='name_gu'  HeadAlign=Center Width=100 align=center</C>
						<C> name='ȸ����ȭ'  ID='office_tel'  HeadAlign=Center Width=100 align=center/C>
						<C> name='������ȭ'  ID='house_tel'   HeadAlign=Center Width=100 align=center</C>
						<C> name='�޴���ȭ'  ID='mobile_tel'  HeadAlign=Center Width=100 align=center</C>
						<C> name='�ѽ���ȣ'  ID='fax_no'      HeadAlign=Center Width=100 align=center</C>
						<C> name='������'  ID='business_gu_nm' HeadAlign=Center  Width=100 align=left</C>
						<C> name='�ٹ�����'  ID='area_cd_nm'     HeadAlign=Center  Width=60 align=center</C>
						<C> name='�⺻�����ּ�' ID='b_email'  HeadAlign=Center Width=120 align=left</C>
						<C> name='�������'  ID='bithday'     HeadAlign=Center Width=80 align=center mask='XXXX/XX/XX'</C>
						<C> name='����'      ID='bithday_gu_nm'  HeadAlign=Center Width=100 align=center</C>
						<C> name='�����ȣ'  ID='zip_cd'      HeadAlign=Center Width=70 align=center mask='XXX-XXX'</C>
						<C> name='�ּ�1'     ID='address1'    HeadAlign=Center Width=200 align=left</C>
						<C> name='�ּ�2' 	 ID='address2'    HeadAlign=Center Width=155 align=left</C>
						<C> name='���'      ID='sal_dam_desc'        HeadAlign=Center Width=100 align=left</C>
					">
				</object> 
				<%=HDConstant.COMMENT_END%>
			</td>
		  </tr>
		</table>
	</td>
  </tr>
</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


