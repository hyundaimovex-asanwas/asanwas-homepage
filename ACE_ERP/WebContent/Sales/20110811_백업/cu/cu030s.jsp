<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ��ü��ȸ      
 * ���α׷�ID 	: CU030S        
 * J  S  P		: cu030s        
 * �� �� ��		: Cu030s        
 * �� �� ��		: ������        
 * �� �� ��		: 2006-06-05    
 * �������		: ��ü��ȸ(��ȸ)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 *****************************************************************************/
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
		 * �ʱ��۾�
		 */
		function fnInit(){
			ds2.DataId="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SY010";
			ds2.Reset();
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
			ds1.DataId = "<%=dirPath%><%=HDConstant.PATH_CU%>Cu030s?proType=S&dsType=1"
							+ "&s_GroupCd="+txt_group_cd.value.toUpperCase()
							+ "&s_GroupNm="+txt_group_nm.value
							+ "&s_SalDamSid="+txt_sal_dam_sid.value
							+ "&s_UseYn="+drp_use_yn.bindcolval;
			ds1.Reset();			
		}
		
		/*
		 * Ű����� �˾� ��ȸ
		 */		
		function fnSelectDs11() {
			if(txt_sal_dam_cd.value!=""&&txt_sal_dam_nm.value=="") {
				ds11.Dataid="<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?proType=S&dsType=1"
					+ "&s_SalDamCd="+txt_sal_dam_cd.value.toUpperCase();
				ds11.Reset();
			}	
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
			if(ds1.RowCount==0){
				alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
				return;
			}
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:��ü��ȸ ��ȸ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("��ü��ȸ", "��ü��ȸ.xls", 8);		 
		}
			
		/*
		 * �˾���ư���� ��ȸ
		 */
		function fnPopup() {
		
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;	
				var strPos;
				//arrParam[0] : ���������sid
				//arrParam[1] : ����������ڵ�
				//arrParam[2] : ����������̸�
				strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
				strPos = "dialogWidth:495px;dialogHeight:390px;status:no;scroll:no;resizable:no";
				arrResult = showModalDialog(strURL,arrParam,strPos);
				if (arrResult != undefined) {
					arrParam = arrResult.split(";");
					txt_sal_dam_sid.value = arrParam[0];
				   	txt_sal_dam_cd.value = arrParam[1];
					txt_sal_dam_nm.value = arrParam[2];
				} else {
					txt_sal_dam_sid.value = "";
				   	txt_sal_dam_cd.value = "";
					txt_sal_dam_nm.value = "";
				}
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
			fnShowLoading(410,180);			
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  ��ȸ�Ϸ�
	%>
		<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			fnHideLoading();	
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
			fnHideLoading();
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �˻����� ��ȸ�� 
	%>
		<script language=JavaScript  for=ds2 event="OnLoadStarted()" >
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
			fnShowLoading(410,180);			
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �˻����� ��ȸ�Ϸ�
	%>
		<script language=JavaScript  for=ds2 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			fnHideLoading();	
			ds2.insertrow(1);
			ds2.namevalue(1,"detail") = "";
			ds2.namevalue(1,"detail_nm") = "��ü";
			drp_use_yn.index = 0;
			if( row < 1){
				window.status="<%=HDConstant.S_MSG_NO_DATA%>"; 
			}
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  �˻����� ��ȸ�� ���� 
	%>		
 		<script language=JavaScript  for=ds2 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();	
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  Help��ȸ 
	%>
		<script language=JavaScript  for=ds11 event="OnLoadStarted()" >
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  Help��ȸ�Ϸ�
	%>
		<script language=JavaScript  for=ds11 event="OnLoadCompleted(row,colid)">
			window.status="<%=HDConstant.S_MSG_SEARCH_DONE%>";
			if(ds11.namevalue(ds11.rowposition,"sal_dam_nm") != undefined) {
				txt_sal_dam_nm.value=ds11.namevalue(ds11.rowposition,"sal_dam_nm");
				txt_sal_dam_sid.value=ds11.namevalue(ds11.rowposition,"sal_dam_sid");
			}
			else {
			}
		</script>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  ��ȸ�� ���� 
	%>		
 		<script language=JavaScript  for=ds11 event="OnLoadError()">
			window.status="<%=HDConstant.AS_MSG_SEARCH_ERR%>";
			fnHideLoading();				
		</script>
	<%
	/*******************************************************************************
				���콺 ������Ʈ  Dataset , TR ����
	*******************************************************************************/
	%>
		<%=HDConstant.COMMENT_START%>
			<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
			<param name="SyncLoad" 	value="false">
			</object><%-- ���� --%>
		<%=HDConstant.COMMENT_END%>
		<%=HDConstant.COMMENT_START%>
			<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
			<param name="SyncLoad" 	value="false">
			</object><%-- �˻����� --%>
		<%=HDConstant.COMMENT_END%>
		<%=HDConstant.COMMENT_START%>
			<object id=ds11 classid=<%=HDConstant.CT_DATASET_CLSID%>>
			<param name="SyncLoad" 	value="false">
			</object><%-- �˻�����2 --%>
		<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table  cellpadding="0" cellspacing="0" border="0">
				<tr height="30px">
					<td width='845px'>
						<table border="0" cellpadding="0" cellspacing="1"  width='845px'>
							<tr>
								<td width="845px" align="right">
									<table  cellpadding="0" cellspacing="0" border="0"><nobr>
										<img src="<%=dirPath%>/Sales/images/refer.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnSelectDs1()">
										<img src="<%=dirPath%>/Sales/images/excel.gif"   style="cursor:hand;position:relative;left:3px;top:3px" onclick="fnExcelDs1()"></nobr>
								  	</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="10px">
					<td></td>
				</tr>
				<tr> 
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width="845px">
							<tr height="30px"> 
								<td width="80px" height="30px" class="text">���������</td>
								<td align="left" bgcolor="#ffffff" width='270px'>&nbsp;
									<input id="txt_sal_dam_cd" type="text" class="textbox" readonly="readonly" size='10'  align='absmiddle' maxlength="7" onchange="txt_sal_dam_nm.value='',txt_sal_dam_sid.value=''" onblur="fnSelectDs11()">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0" align=absmiddle  ALT="��������ڸ� �˻��մϴ�"  align=center onclick="fnPopup();">
									<input id="txt_sal_dam_nm" type="text" class="boardt04" align=absmiddle  maxlength="22" readonly>
									<input id="txt_sal_dam_sid" type="hidden">
								</td>
								<td width="70px" height="30px" class="text">��ü�ڵ�</td>
								<td align="center" bgcolor="#ffffff">
									<input id="txt_group_cd" type="text" class="textbox"  style= "position:relative;left:0px;top:0px;width:65px; height:18px" maxlength="4">
								</td>
								<td width="70px" height="30px" class="text">��ü��</td>
								<td align="center" bgcolor="#ffffff">
									<input id="txt_group_nm" type="text" class="textbox" size=15 maxlength="42">
								</td>
								<td width="70px" height="30px" class="text">�������</td>
								<td align="center" bgcolor="#ffffff">
									<%=HDConstant.COMMENT_START%>
									<object id=drp_use_yn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=170 width=50 style="position:relative;left:1px;top:2px" align="absmiddle" class="txtbox" >
										<param name=ComboDataID			value=ds2>
										<param name=SearchColumn		value="detail_nm">
										<param name=Sort				value="false">
										<param name=ListExprFormat		value="detail_nm^0^50">
										<param name=BindColumn			value="detail">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>	
		</td>
	</tr>

	<tr>
		<td height="10px"></td>
	</tr>

	<tr> 
		<td valign=top> 
			<table border= "0" cellpadding=0 cellspacing=0  style='position:relative;left:0px;top:0px;width:270px;height:50px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:0px;border:0 solid #708090'>
				<tr> 
					<td>
					<%
					/*---------------------------------------------------------------------------->
						HTML Desc	: xxxxxxxx 
									: �˻� ���� - �з��ڵ�, �з���
						Object ID 	: �׸��� , gr1
						Data ID		: ds1
					-----------------------------------------------------------------------------*/
					%>
					<%=HDConstant.COMMENT_START%>											
					<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gr1  style="WIDTH:845px;HEIGHT:450px;border:1 solid #777777;">
						<param name="DataID"		VALUE="ds1">
						<param name="BorderStyle"   VALUE="0">
						<param name="Fillarea"		VALUE="true">
						<param name=ColSizing       value="false">
						<param name="IndWidth"      value="0">
						<param name="editable"      value="true">
						<param name=UsingOneClick  	value="1">
						<param name=Viewsummary  	value="1">
						<param name=sortview	value="right">
						<param name="Format"		VALUE="  
							<C> name='���������' ID='sal_dam_nm'  Width=100 align=left sumtext=��</C>
							<C> name='��ü�ڵ�'	  ID='group_cd'    Width=80 align=center sumtext=@cnt sort=true</C>
							<C> name='��ü��'     ID='group_nm'    Width=100 align=left sort=true</C>
							<C> name='��ǥ��'     ID='vd_direct'   Width=100 align=center</C>
							<C> name='��ȭ��ȣ'   ID='tel_no'      Width=100 align=center/C>
							<C> name='�޴���ȭ'   ID='mobile_no'   Width=100 align=center</C>
							<C> name='�ѽ���ȣ'   ID='fax_no'      Width=100 align=center</C>
							<C> name='�����ּ�'   ID='e_mail'      Width=120 align=left</C>
							<C> name='�����ȣ'   ID='zip_cd'      Width=70  align=center mask='XXX-XXX'</C>
							<C> name='�ּ�1'      ID='address1'    Width=200 align=left</C>
							<C> name='�ּ�2' 	  ID='address2'    Width=135 align=left</C>
							<C> name='���'       ID='desc'        Width=100 align=left</C>
							<C> name='�������'   ID='use_yn_nm'   Width=100 align=center</C>
						">
					</object> 
					<%=HDConstant.COMMENT_END%>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>

	<%
	/*******************************************************************************
				Bind ����
	*******************************************************************************/
	%>
	<%=HDConstant.COMMENT_START%>
    <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
       <param name="DataId" value="ds1">
       <param name=BindInfo    value="
       
        ">
    </object>
	<%=HDConstant.COMMENT_END%>      

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		
