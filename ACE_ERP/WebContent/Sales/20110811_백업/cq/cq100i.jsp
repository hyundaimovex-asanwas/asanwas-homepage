<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ��������� ����
 * ���α׷�ID 	: CQ100I
 * J  S  P		: cq100i
 * �� �� ��		: Cq100I
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-11
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-07-24][�ɵ���] ��ǰ ������ �߰� (����/��ȸ/������ ��ǰ����)
 *						���ÿ� �����ͼ�, �����޺� ���� ������� �� �����ؾ� �� �� ����.
 *						���ǿ��� ���� ���̴� �͵� �� �����ؾ� �� �� �մϴ�.
 *						���� ��� ds_saup, ds_goods, ... , lc_saup, lc_goods �̷��ñ��.. ����Ģ��.!!!
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
   	date.set(java.util.Calendar.HOUR_OF_DAY, 240);         
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
        var v_job = "H";
        var div='';

		/*
		 * �������ε� 
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			
			fnInit(); 
		} 
		
		//������ �ʱ�ȭ
		function fnInit() {
			div="init";
			sJob_date.text='<%=firstday%>';	
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //�����ڵ� 
	        
		}
		
		//������ư
		function fnApply() {	
			fnCreate();	//����
			fnSelect();	//��ȸ
		}
		
		//������ư
		function fnDelete() {
			fnDeleteDs1();	//����
			fnSelect();		//��ȸ
		}
		
		//���� ��ȸ
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
			          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          + ",sGoods_sid="+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
			          + ",sJob_date=" + sJob_date.Text
			          + ",sJob_seq=" + sJob_seq.value;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq100I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		
		 /*
		 * ����
		 */
		function fnCreate() {
			if(lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)=="0" ){
				alert("��ǰ='��ü'�� ���� �Ұ��մϴ�. ��ǰ�� �������ּ���"); 
			}else{
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
				          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				          + ",sGoods_sid="+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)				          
				          + ",sJob_date=" + sJob_date.Text
			        	  + ",sJob_seq=" + sJob_seq.value;
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq100I",
				    "JSP(O:DS1=ds1)",
				    param);
				   
				tr_post(tr1);
			};
		}
		
		/*
		 * ���� 
		 */
		function fnDeleteDs1() {
			if(lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)=="0" ){
				alert("��ǰ='��ü'�� ���� �Ұ��մϴ�. ��ǰ�� �������ּ���"); 
			}else{
				var param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=2"
				          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				          + ",sGoods_sid="+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)			          
				          + ",sJob_date=" + sJob_date.Text
				          + ",sJob_seq=" + sJob_seq.value;
				      
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq100I",
				    "JSP(O:DS1=ds1)",
				    param);
				tr_post(tr1);
			};
		}
		
		
		//��ǰ��ȸ
		function fnSelectGoodsLC() {
	        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
	            + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
				+ ",sDepartDate=" + sJob_date.Text;
	        ln_TRSetting(tr2, 
	            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
	            "JSP(O:S_GOODS_DS=ds_goods)",
	            param);
	        tr_post(tr2);
		};
		</script>

<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
	</script>	


	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectGoodsLC();
	</script>

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectGoodsLC();//��ǰ ��˻�
	</script>	

	<script language=JavaScript for=sJob_date event=OnKillFocus()> <!-- ���ð� ���� -->
		fnSelectGoodsLC();			
	</script>

<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--   -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
	<param name="SyncLoad" 	value="true">
</object>

<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �˻� : ��ǰ -->
	<param name="SyncLoad" 	value="false">
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

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		
		<tr>
			<td>
				<table border='0' cellpadding="0" cellspacing="0" width="545"> 
					<tr height="30px">
						<td width=545>
							<table border='0' cellpadding="0" cellspacing="1" width="645" bgcolor="#666666">
								<tr>
									<td align=center class="text" width="60">����</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<%=HDConstant.COMMENT_START%>
				                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_saup>
											<param name=BindColumn      value="saup_sid">
				                            <param name=BindColVal      value="saup_sid">
											<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
											<param name=ListExprFormat  value="saup_nm^0^60">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>	
									<td align=center class="text"  width="70">�������</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																							
										<%=HDConstant.COMMENT_START%>
										<object id=sJob_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=80 align=center class="textbox" style= "width:65px; height:17px;">			
											<param name=Text 				value="">
											<param name=Alignment 			value=1>
											<param name=Format 				value="0000-00-00">
											<param name=Cursor	 			value="iBeam">
											<param name=Border	 			value="false">		
											<param name=InheritColor      	value="true">																																																				
											<param name=ReadOnly  			value="false">
											<param name=SelectAll  			value="true">
											<param name=SelectAllOnClick  	value="false">																					
										</object>&nbsp;
										<%=HDConstant.COMMENT_END%>
								 	</td>
									<td align=center class="text" width="60">��ǰ</td>
									<td align=left bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
				                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=140 width=100 border="0" align=absmiddle>
											<param name=ComboDataID		value=ds_goods>
											<param name=BindColumn      value="goods_sid">
				                            <param name=BindColVal      value="goods_sid">
											<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
											<param name=ListExprFormat  value="goods_nm^0^100"></object>
										<%=HDConstant.COMMENT_END%>&nbsp;	
									</td>
								 	
								 	<td align=center class="text" width="70">�۾�����</td>
				                    <td align=left bgcolor="#ffffff">&nbsp;																										
										<select name="sJob_seq">
											<option value="1">����</option>
											<option value="3">�д�����</option>
											<option value="2">������</option>
										</select>
									</td>	
								</tr>
							</table>
						</td>
					 	<td width='300' align=right>
							<table width='200'>
								<tr>
									<td align=right>
										<img src="<%=dirPath%>/Sales/images/n_create.gif"	style="cursor:hand"	align=absmiddle onClick="fnApply();">		<!-- ���� -->
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
										<img src="<%=dirPath%>/Sales/images/delete.gif"	style="cursor:hand"	align=absmiddle onClick="fnDelete()">		<!--  -->
									</td>
								</tr>
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
			<td colspan=2>
				<table border='0' cellpadding="0" cellspacing="0" width="845"> 
					<tr>
						<td width='845'>
							<%=HDConstant.COMMENT_START%>
							<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds1">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								<param name="SuppressOption"    value="1">
								<param name="Format" 			value="
								  <C> name='��û����ȣ'    	ID='accept_no'   width=150 	align=left editlimit=16 show=true</C>
								  <C> name='�������'  		ID='depart_date' width=200	align=left editlimit=10 show=true</C>
								  <C> name='��ǰ��'     		ID='goods_nm'    width=200 	align=left editlimit=40 show=true</C>
								  <C> name='�����'       	ID='jo_cnt'      width=80 	align=right editlimit=11 show=true</C>
								  <C> name='�д������'     ID='stu_jo_cnt'      width=80 	align=right editlimit=11 show=true</C>								  
								  <C> name='�����ڼ�'    	ID='drive_cnt'   width=80 	align=right editlimit=11 show=true</C>
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

