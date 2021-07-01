<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���¾�ü���
 * ���α׷�ID 	: CU050I
 * J  S  P		: cu050i
 * �� �� ��		: Cu050I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-16
 * �������		: �븮���� �����ϴ� ���¾�ü(���������)�� ��ϸ޴�.
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-02-27][�ɵ���] ��������� : ���̺� ������ ���� �ٽ� ����
 * [2013-07-02][�ڰ汹] ��������ý��� ���¾�ü �ڵ�����޴��� �ű��ۼ�
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.*"%>
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
    <jsp:include page="/Pms/common/include/head.jsp"/>

<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
		<script language="javascript">
		
		var jobFlag = "";
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
			cfStyleGrid(getObjectFirst("gr1"), "comn1");
			
			fnInit(); 
			fnSetHeaderDs1();
		} 
			
		/*
		 * �����ͼ� ��� ���� (������)
		 */
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				+ "COOP_SID:INT,VEND_CD:STRING,COOP_CD:STRING,COOP_NM:STRING,COOP_YYMM:STRING,COOP_VGB:STRING,COOP_DIRECT:STRING,COOP_CERT:STRING,COOP_STYLE:STRING,CREAT_DT:STRING,E_DEFAULT:STRING,E_PATENT:STRING,RECOMMEND:STRING,VD_TELNO:STRING,VD_FAXNO:STRING,E_REMARK:STRING,I_EMPNO:STRING,I_DATE:STRING,U_EMPNO:STRING,U_DATE:STRING,USE_YN:STRING,COOP_ADDR:STRING";
				
				ds1.SetDataHeader(s_temp);
			}
		}		

		/*
		 * �ʱ��۾�
		 * Header ���� 
		 */
		function fnInit(){
    	   jobFlag = "INIT";
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_SY%>Sy201I",
				"JSP(O:DS1=ds1)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
		}
			
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			if (ds1.IsUpdated==false ) {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sCoop_cd="+ sCoop_cd.value
				          + ",sCoop_nm="+ sCoop_nm.value
				          ;
				
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_SY%>Sy201I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			} else {
				alert("�۾����� ���¿����� ��ȸ�Ҽ� �����ϴ�!");
			}
		}
					
		/*
		 * ���߰� , �ű� 
		 */
		function fnAddRowDs1() {
			jobFlag = "N";
			ds1.addRow();
			rowNum.value = ds1.rowposition;
			
			//ds1.namevalue(ds1.rowposition,"coop_cd") = ds1.namevalue(ds1.rowposition-1,"coop_cd")+1;	
			
		}
		
		function fnDeleteRowDs1() {
			jobFlag = "D";
			ds1.deleterow(ds1.rowposition);
		}

		/*
		 * ����
		 */		
		function fnApply() {
	
			var row=ds1.countRow;
			if (ds1.IsUpdated ) {
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_SY%>Sy201I",
	                "JSP(I:DS1=ds1)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            		tr_post(tr1);
            }	
		}
			
		/*
		 * ��� 
		 */
		function fnCancel() {
			ds1.undoall();
			
			if (ds1.countrow >= 1) {
				fnSelectDs1();
			}
			window. status="������ ������ ��ҵǾ����ϴ�.";
			return;		
		}

		/*
		 * ����
		 */
		function fnExcelDs1() {
			gr1.runexcelsheet("���¾�ü �ڵ����");
		}
			
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
	</script>	
	
	<script language=JavaScript  for=searchds1 event="OnLoadCompleted(row)">
		coop_cd.text = searchds1.namevalue(searchds1.rowposition,"COOP_CD");
		
	</script>
	
	
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
	<%=HDConstant.COMMENT_START%>
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���¾�ü ��ȸ -->
		<param name="SyncLoad" 	value="true">
	</object>
	<object id=searchds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���¾�ü�ڵ� -->
		<param name="SyncLoad" 	value="false">
	</object>
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
		<param name="KeyName"  	 value="toinb_dataid4">
		<param name="ServerIP"   value="">
		<param name="Action"     value="">
		<param name="KeyValue"   value="">
		<param name="Parameters" value="">
	</object>
	<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr>
			<td width='525px'>
				<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
					<tr>
						<td width='100px' height="30px" class='text'>���¾�ü��</td>
						<td width='200px' height="30px" bgcolor='#FFFFFF' align='center'>
							<input type='text' 		name='sCoop_nm' 		value='' maxlength='30' 	size='25' 	class='textbox' onkeydown="if(event.keyCode==13) fnSelect();">
						</td>

					</tr>
				</table>
			</td>
			<td align='right'>
				<table border='0' cellpadding='0' cellspacing='0' width='300px'>
					<tr>
						<td height='30px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/delete.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRowDs1()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
						</td>
					</tr>
				</table>
			</td>
		</tr> 
		<tr>
			<td height='10px'></td>
		</tr>
		<tr>
			<td colspan='3' valign="top">
				<table  border='0' cellpadding='0' cellspacing='0'>
					<tr>
						<td valign='top'>
							<table  border='0' cellpadding='0' cellspacing='0' width='300px' height='430px' >
								<tr>
									<td>
										<%=HDConstant.COMMENT_START%>
										<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='427px' border='1'>
											<param name="DataID"			value="ds1">
											<param name="ColSizing"			value="true">
											<param name="Fillarea"			value="false">
											<param name="Editable"  		value="false">
											<param name="BorderStyle"       value="0">
											<param name=SortView  			value="Left">
											<param name="Format" 			value="
												<FC>name='NO'            		ID='{CURROW}'   Width=35   edit=none align=center	show=false</FC>
								                <C> name='���¾�üSID'   	ID='coop_sid' 		Width=100  align=left editlimit=12 	show=false</C>
								                <C> name='���¾�ü�ڵ�'    	ID='coop_cd'  		Width=100  align=left editlimit=5 	show=false sort=true</C>
								                <C> name='���¾�ü��'    	ID='coop_nm'  	Width=299  align=left editlimit=30 	show=true sort=true</C>
								           ">											
										</object>	
										<%=HDConstant.COMMENT_END%>								
									</td>
								</tr>
							</table>
						</td>
						<td width='10px'></td>
						<td valign='top'>
							<table border='0' cellpadding='0' cellspacing='0' width='535px'>
								<tr>
									<td width='535px'>
										<table border='0' cellpadding='0' cellspacing='1' width='535px' height='30px' bgcolor="#666666">
											<tr>
												<td  width='100px' height='30px' class='text'>&nbsp;&nbsp;&nbsp;���¾�ü��</td>
												<td width='400px' height="30px" bgcolor='#FFFFFF' align='center'>
													&nbsp;&nbsp;<input type='text' 		id='coop_nm'	name='coop_nm' 		value='' maxlength='30' 	size='47' 	class='textbox'>
													<input type="hidden"  id='sCoop_cd' name="coop_cd"  value=""  maxlength='10' size="5" readonly="readonly" class="textbox">
												</td>
											</tr>
										</table>
									</td>
								</tr>
								<tr>
									<td height='10px'></td>
								</tr>

							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
        <%
        /*=============================================================================
                                Bind ����
        =============================================================================*/
        %>
        <%=HDConstant.COMMENT_START%>
        <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
            <param name="DataId" value="ds1">
            <param name=BindInfo    value="
                    <C>Col=coop_sid      	Ctrl=coop_sid         Param=value </C>
                    <C>Col=coop_cd       	Ctrl=coop_cd          Param=value </C>
                    <C>Col=coop_nm        Ctrl=coop_nm          Param=value </C>
            ">
        </object>
        <%=HDConstant.COMMENT_END%>
        <input type="hidden" name="tabFlag" value="1"> 
        <input type="hidden" name="rowNum" value="">
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		