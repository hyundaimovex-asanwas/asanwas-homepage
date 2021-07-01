<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ��ü ���� / ��������
 * ���α׷�ID 	: RV110I
 * J  S  P		: rv110i
 * �� �� ��		: Rv110I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-06-20
 * �������		:
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

	java.util.Calendar date = java.util.Calendar.getInstance();
	java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMdd");
	String firstday = m_today.format(date.getTime());

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
		
		var jobFlag = "";
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			fnInit(); 
			fnSetHeaderDs1();
			
			codeDs1.deleteRow(1);
			codeDs2.deleteRow(1);
		} 
			
  				
												
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp = ""
				s_temp += 
				 "DC_SID:INT,"
				+ "DC_GUBUN_CD:STRING,"
				+ "DC_ITEM1:STRING,"
				+ "GOODS_CD:STRING,"
				+ "GOODS_NM:STRING,"
				+ "BGN_DATE:STRING,"
				+ "END_DATE:STRING,"
				+ "BGN_PERSONS:INT,"
				+ "END_PERSONS:INT,"
				+ "APP_DC_CD:STRING,"
				+ "APP_DC_RATE:STRING,"
				+ "FOC_PERSONS:INT,"
				+ "USE_YN:STRING";
				
				ds1.SetDataHeader(s_temp);
			}
		}	
			
		 
		/*
		 * �ʱ��۾�
		 * Header ���� 
		 * RV003 �����ڵ�, RV004 ���������� SY011 �������
		 */
		function fnInit(){
    	   jobFlag = "INIT";
        	ln_TRSetting(tr1, 
            	"<%=dirPath%><%=HDConstant.PATH_RV%>Rv110I",
            	"JSP(O:RV004=codeDs1, O:SY011=codeDs2)",
            	"proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        	tr_post(tr1);
		}
			
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			if (ds1.IsUpdated) {
				if (confirm("�۾��� ����ϰ� ��ȸ�Ͻðڽ��ϱ�?")) {
					var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					          + ",sDate="+ sDate.Text
					          + ",sGoods_sid=" + sGoods_sid.value
									
					ln_TRSetting(tr1, 
					    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv110I",
					    "JSP(O:DS1=ds1)",
					    param);
					tr_post(tr1);
				} 
			} else {
				var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				          + ",sDate="+ sDate.Text
				          + ",sGoods_sid=" + sGoods_sid.value
								
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv110I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			}
		}
			
		
			
		/*
		 * ����
		 */
		function fnApply() {
			var row=ds1.countRow;
			
			if (ds1.IsUpdated) {
				  ln_TRSetting(tr1, 
	                "<%=dirPath%><%=HDConstant.PATH_RV%>Rv110I",
	                "JSP(I:DS1=ds1)",
	                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            		tr_post(tr1);
			}			
		}
		
		/*
		 * �����
		 */
		 
		function fnDeleteRowDs1() {
			 ds1.DeleteRow(ds1.rowposition);
			
		}
		 
		/*
		* ���߰� 
		*/
		function fnAddRowDs1() {
			ds1.addRow();
		}
		 
		/*
		 * ��� 
		 */
		function fnCancel() {
			ds1.undoall();
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
		 * GOOD
		 */
		 
		 function fnGoodPopup(flag) {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			strURL = "<%=dirPath%>/Sales/help/rm002h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			
			
			arrResult = showModalDialog(strURL,arrParam,strPos);	
			
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				
				
			 	if (flag == "S") {
			 		sGoods_sid.value = arrParam[0];
			 		sGoodsNm.value = arrParam[1];
			 	} else if (flag == "I") {
			 		ds1.namevalue(ds1.rowposition,"dc_item1") = arrParam[0];
			 		ds1.namevalue(ds1.rowposition,"goods_cd") = arrParam[1];
			 		ds1.namevalue(ds1.rowposition,"goods_nm") = arrParam[2];
			 	}
			} else {
				if (flag == "S") {
			 		sGoods_sid.value = "";
			 		sGoodsNm.value = "";
			 	} else if (flag == "I") {
			 		
			 			ds1.namevalue(ds1.rowposition,"dc_item1") = "";
			 		ds1.namevalue(ds1.rowposition,"goods_cd") = "";
			 		ds1.namevalue(ds1.rowposition,"goods_nm") = "";
			 	}
			}
		 }			
		</script>
		

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
<script language=JavaScript  for=ds1 event="OnLoadStarted()" >
	window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
	document.all.LowerFrame.style.visibility="visible";	
</script>
 
<script language=JavaScript  for=ds1 event="OnLoadCompleted(row,colid)">
	window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
	document.all.LowerFrame.style.visibility="hidden";
</script>
	
<script language="javascript" for="tr1" event="onsuccess()">
	window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
</script>	
	
<script language="javascript"  for=gr1  event=OnColumnPosChanged(Row,Colid)>
	if (ds1.RowStatus(ds1.RowPosition) == 0) {
		gr1.ColumnProp("dc_item1","Edit")="None";
		gr1.ColumnProp("bgn_date","Edit")="None";
	} else {
	    gr1.ColumnProp("dc_item1","Edit")="";
		gr1.ColumnProp("bgn_date","Edit")="";
	}
</script>
	
	
<script language=JavaScript for=gr1 event=OnPopup(row,colid,data)>
	if(colid=="goods_nm") {
		fnGoodPopup('I');
	}
</script>		
	
<script language=javascript for="gr1" event="OnClick(Row, Colid)">
//������ Ŭ���ϸ� ��ü �ݿ�;

	if(Row==0){
	    if(ds1.CountRow==0) return;
	    if(Colid=="use_yn"){
	        for(var i=1; i<=ds1.CountRow; i++){
	            ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
	        }
	    }
	    if(Colid=="app_dc_cd"){
	        for(var i=1; i<=ds1.CountRow; i++){
	            ds1.NameValue(i, Colid) = ds1.NameValue(1, Colid);
	        }
	    }
	    return;
	}
</script>



<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �븮�� ��ȸ -->
	<param name="SyncLoad" 	value="false">
</object>


<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����ڵ� -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���������� -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=codeDs3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������� -->
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		


<table border='0' cellpadding='0' cellspacing='0' width='100%'>	
	<tr>
		<td width='425px'>
			<table border='0' cellpadding="0" cellspacing="1" bgcolor="#666666">
				<tr>
					<td width='100px' height="25px" class='text'>��������</td>
                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                        <object id=sDate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
                            <param name=Text        value="<%=firstday%>">
                            <param name=Alignment   value=1>
                            <param name=Format      value="YYYY-MM-DD">
                            <param name=InputFormat value="YYYYMMDD">
                            <param name=Cursor      value="iBeam">
                            <param name=Border      value="false">
                            <param name=InheritColor      value="true">
                            <param name=ReadOnly    value="false">
                            <param name=SelectAll   value="true">
                            <param name=SelectAllOnClick    value="true">
                            <param name=SelectAllOnClickAny   value=false>
                        </object>
                        <%=HDConstant.COMMENT_END%>
					</td>
					<td width='100px' height="25px" class='text'>��ǰ�ڵ�</td>
					<td width='200px' height="25px" bgcolor='#FFFFFF'>&nbsp;
						<input type="hidden" name="sGoods_sid" value="">
						<input type="text" name="sGoodsNm" value="" class="textbox">&nbsp;
						<img src="<%=dirPath%>/Sales/images/help.gif"  style="cursor:hand" align=absmiddle onclick="fnGoodPopup('S')">
					</td>
				</tr>
			</table>
		</td>
		<td align='right' width="400">
			<table border='0' cellpadding='0' cellspacing='0' width='400px'>
				<tr>
					<td height='25px' align='right'>
						<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:hand" align=absmiddle onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand"	align=absmiddle onClick="fnAddRowDs1()" >
						<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:hand" align=absmiddle onClick="fnDeleteRowDs1()" >
						<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:hand" align=absmiddle onClick="fnApply();">
						<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"	align=absmiddle onclick="fnCancel()">
					</td>
				</tr>
			</table>
		</td>
	</tr> 
	<tr height='15px'>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td colspan='3' valign="top">
			<table  border='0' cellpadding='0' cellspacing='0'>
				<tr>
					<td valign='top'>
						<table  border='0' cellpadding='0' cellspacing='0' width='845px'>
							<tr>
								<td>
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='410px' border='1'>
										<param name="DataID"			value="ds1">
										<param name="ColSizing"			value="true">
										<param name="Fillarea"			value="false">
										<param name="Editable"  		value="true">
										<param name="BorderStyle"       value="0">
										<param name=SortView  			value="Left">
			                            <param name=ViewSummary 		value=1>
										<param name="Format" 			value="
							                <C> name=''					ID='{currow}'	width=30 sumtext=��</C>
							                <C> name='�����ڵ�SId'       ID='dc_sid'      	width=100 align=left editlimit=12 show=false</C>
											<C> name='���α����ڵ�'  		ID='dc_gubun_cd'    width=100 align=left editlimit=1 show=false</C>
											<C> name='���α���1'     		ID='dc_item1'    	width=100 align=left editlimit=5 show=false</C>
											<C> name='��ǰ�ڵ�'     		ID='goods_cd'    	width=100 align=left editlimit=7 show=false</C>
											<C> name='��ǰ��'     		ID='goods_nm'    	width=130 align=left editlimit=40 show=true editstyle=popup sumtext=@cnt</C>
											<C> name='������'     		ID='bgn_date'    	width=80 align=center editlimit=8 show=true mask='XXXX-XX-XX'</C>
											<C> name='������'     		ID='end_date'    	width=80 align=center editlimit=8 show=true mask='XXXX-XX-XX'</C>
											<C> name='�����ο�'  			ID='bgn_persons'    width=70 align=right editlimit=4 show=true</C>
											<C> name='�����ο�'  			ID='end_persons'    width=70 align=right editlimit=4 show=true</C>
											<C> name='Ȱ����������' 	 	ID='app_dc_cd'   	width=90 align=left editlimit=1 show=true editstyle=lookup data='codeDs1:detail:detail_nm'</C>
											<C> name='���������/�ݾ�'  	ID='app_dc_rate'    width=100 align=right editlimit=10 show=true</C>
											<C> name='���� FOC�ο�'  		ID='foc_persons'    width=100 align=right editlimit=5 show=true</C>
											<C> name='��뿩�Ρ�'       	ID='use_yn'      	width=70 align=left editlimit=1 show=true editstyle=lookup data='codeDs2:detail:detail_nm'</C>

							        	">											
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
</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

