<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ü����Ȳ
 * ���α׷�ID 	: AC020S
 * J  S  P		: ac020s
 * �� �� ��		: Ac020S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-08-07
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2009-08-17][�ɵ���] �׸��� �� ���� ���� ����
 * [2009-08-21][�ɵ���] 2009-08-18 ���Ժ��� ���� ����. �׸��� ����.
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
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

		

			fnInit();
		}

	/*
	 * ����ȸ
	 */
	function fnInit(){
		
		cfStyleGrid(getObjectFirst("gr1"), "comn");
		cfStyleGrid(getObjectFirst("gr2"), "comn");
		
		sJobDate.text='<%=firstday%>';
                  
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1";
		codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		codeDs1.Reset(); //�����ڵ� 
		// �����, ������
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:DS5=codeDs2)", 
            param);
            
        tr_post(tr1);		
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
    	if ( sJobDate.text.trim() == '' ) {
			alert("�԰����� �Է����ּ���.");
			return;
		}    

        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaup_sid=" +codeDs1.namevalue(codeDs1.rowposition,"saup_sid") + ","        
            + "sJobDate=" + sJobDate.text + ","
            + "sCustGu=" + codeDs2.namevalue(codeDs2.rowposition,"detail") + ","
            + "sManageNo=" +  sManageNo.value + ","
            + "sName=" + sName.value;
            
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq610S",
            "JSP(O:DS1=ds1,O:DS2=ds2)",
            param);
        tr_post(tr1);

    }
 	
  	function fnExcel() {
            if(ds1.CountRow==0 && ds2.CountRow==0 && ds3.CountRow ==0){
                alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
                return;
            }
            getObjectFirst("gr1").SetExcelTitle(0, "");
            getObjectFirst("gr1").SetExcelTitle(1, "value:�Ѱ�; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr1").GridToExcel("�Ѱ�", "ü����Ȳ.xls", 32);        

            getObjectFirst("gr2").SetExcelTitle(0, "");
            getObjectFirst("gr2").SetExcelTitle(1, "value:ü���ο���Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
            getObjectFirst("gr2").GridToExcel("ü���ο���Ȳ", "ü����Ȳ.xls", 32);   
            
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
<%



/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<!--  ����� -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>
<!-- ������ -->
<object id=codeDs2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<%=HDConstant.COMMENT_END%>

</head>
<jsp:include page="/Common/sys/body_s.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		<tr height="30px">
			<td bgcolor="#ffffff" width='845px'>
				<table border='0' cellpadding='0' cellspacing='0' width='845' bgcolor="#ffffff">
					<tr>
					<td align='right'>
						<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
						<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcel()">		<!-- ���� -->
					</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="10px">
			<td></td>
		</tr>
		<tr height="30px">
			<td bgcolor="#ffffff">
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height="30px">
						<td align=left width=70 class="text">&nbsp;����</td>
                        <td align=left bgcolor="#ffffff">&nbsp;																										
								<%=HDConstant.COMMENT_START%>
                            <object id=sSaupSid classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs1>
								<param name=BindColumn      value="saup_sid">
                                <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120"></object>
							<%=HDConstant.COMMENT_END%>
						</td>	
    					<td align=left width=70 class="text">�۾�����</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
					     	<%=HDConstant.COMMENT_START%>
					     	<object id=sJobDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="0">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll   value="true">																				
								<param name=SelectAllOnClick   value="true">
								<param name=SelectAllOnClickAny  	value="false">																				
							</object>
							<%=HDConstant.COMMENT_END%>&nbsp;
						</td>		
						<td  align=left width=70 class="text">������</td>
						<td align=left bgcolor="#ffffff" valign="middle">&nbsp;				
							<%=HDConstant.COMMENT_START%>
                            <object id=sCustGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=60 border="0" align=absmiddle>
								<param name=ComboDataID		value=codeDs2>
								<param name=BindColumn      value="detail">
                                <param name=BindColVal      value="detail">
								<param name=EditExprFormat	value="%;detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^60">
							</object>
							<%=HDConstant.COMMENT_END%>									
						</td>
						<td align=left width=100 class="text">�ֹε�Ϲ�ȣ</td>
                        <td align=left bgcolor="#ffffff">&nbsp;																										
							<input type="text" name="sManageNo" value="" size='13' maxlength="13" class="textbox">
						</td>	
    					<td align=left width=40 class="text">����</td>
                        <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
					     	<input type="text" name="sName" value="" size='10' maxlength="10" class="textbox">
						</td>
					</tr>
				</table>
			</td>
		</tr>
		
				
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" height=410 border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
									<%=HDConstant.COMMENT_START%>
									<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:190; width:845; height:20">
										<param name="BackColor"			value="#00ffff">
										<param name="DisableBackColor"	value="#ffffee">
										<param name="Format"			value='
											<T>divid="mxTab_page1"	title="�䡡��"</T>
											<T>divid="mxTab_page2"	title="�󡡼�"</T>'>																		
									</object>
									<%=HDConstant.COMMENT_END%>	
									<div class=page id="mxTab_page1" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
									
	                        			<param name="DataID"		VALUE="ds1">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name=ViewSummary 	value=1>
										<param name="Format" 			value="
											<C> name='����'			ID='CUST_GU'		width=80 align=left editlimit=50 show=true suppress=1 </C>        
											<C> name='�������'		ID='GUBN'			width=100 align=left editlimit=50 show=true suppress=2 </C>        
											<C> name='�Ѱ�'			ID='CNT_TOTAL'			width=70 align=right editlimit=50 show=true sumtext=@sum</C>
										<G> name='����ü��'
											<C> name='������'		ID='CNT_GO_KR'			width=70 align=right editlimit=50 show=true sumtext=@sum</C>        
											<C> name='�ܱ���'		ID='CNT_GO_FR'			width=70 align=right editlimit=50 show=true sumtext=@sum</C>
										</G>
										<G> name='ü����ü��'
											<C> name='������'		ID='CNT_STAY_KR'			width=70 align=right editlimit=50 show=true sumtext=@sum</C>
											<C> name='�ܱ���'		ID='CNT_STAY_FR'			width=70 align=right editlimit=50 show=true sumtext=@sum</C>
										</G>
										<G> name='ü�����԰�'
											<C> name='������'		ID='CNT_COME_KR'			width=70 align=right editlimit=50 show=true sumtext=@sum</C>
											<C> name='�ܱ���'		ID='CNT_COME_FR'			width=70 align=right editlimit=50 show=true sumtext=@sum</C>
										</G>
										<G> name='�����԰�'
											<C> name='������'		ID='CNT_TODAY_KR'			width=70 align=right editlimit=50 show=true sumtext=@sum</C>
											<C> name='�ܱ���'		ID='CNT_TODAY_FR'			width=70 align=right editlimit=50 show=true sumtext=@sum</C>
										</G>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page2" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds2">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name=ViewSummary 	value=1>
										<param name="Format" 		value="
							            <C> name='����'			ID='DIRECTION'     	width=60 align=center editlimit=50 show=true suppress=1 </C>
							            <C> name='������'		ID='CUST_GU'       	width=60 align=center editlimit=50 show=true suppress=2 </C>
										<C> name='�������'		ID='SAUP_GU' 		width=60 align=center editlimit=50 show=true suppress=3 </C>
										<C> name='��������' 	ID='COUNTRY_GU'    	width=60 align=center editlimit=50 show=true suppress=4 sumtext='�� �ο�'</C>
										<C> name='����' 		ID='CUST_NM' 		width=80 align=left editlimit=50 show=true sumtext=@cnt</C>
										<C> name='��' 			ID='CLASS' 			width=60 align=left editlimit=50 show=true </C>
										<C> name='��' 			ID='TEAMS' 			width=40 align=left editlimit=50 show=true</C>
										<C> name='�ֹε�Ϲ�ȣ'	ID='MANAGE_NO' 		width=100 align=left editlimit=50 show=true </C>        
										<C> name='����'			ID='SEX' 			width=40 align=center editlimit=50 show=true </C>        
										<C> name='����' 		ID='COUNTRY_NM'		width=60 align=center editlimit=50 show=true </C>        
										<C> name='����' 		ID='NATION_MM' 		width=60 align=center editlimit=50 show=true </C>        
										<C> name='����' 		ID='COMPANY_NM'		width=90 align=left editlimit=50 show=true </C>        
										<C> name='����' 		ID='POSITIONS' 		width=90 align=left editlimit=50 show=true </C>        
										<C> name='��ϸ���'		ID='north_purpose'	width=110 align=left editlimit=62 show=true</C>
										<C> name='�������'		ID='DEPART_DATE' 	width=80 align=center editlimit=50 show=true mask='XXXX-XX-XX'</C>
										<C> name='���ð�'		ID='DEPART_TIME' 	width=60 align=center editlimit=50 show=true  mask='XX:XX'</C>        
										<C> name='�԰�����'		ID='ARRIVE_DATE' 	width=80 align=center editlimit=50 show=true  mask='XXXX-XX-XX'</C>
										<C> name='�԰�ð�'		ID='ARRIVE_TIME' 	width=60 align=center editlimit=50 show=true  mask='XX:XX'</C>        
										<C> name='��ǰ' 		ID='GOODS_NM'     	width=100 align=left editlimit=50 show=true </C>        
										<C> name='���ǵ��' 	ID='ROOM_TYPE_CD'	width=70 align=left editlimit=50 show=true </C>        
										<C> name='���ȣ'		ID='ROOM_NO' 		width=100 align=left editlimit=50 show=false </C>        										                
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									
									</td>		
								</tr>
								<tr>
									<td>-. �۾������� ü���ο� = [����ü��] + [ü����ü��]<BR>
										-. �۾������� ����ο� = [����ü��] + [�����԰�]<BR>
										-. �۾������� �԰��ο� = [ü�����԰�] + [�����԰�]<BR><BR>

										�� ��Ȯ�� ü����Ȳ ��ġ�� ���ؼ�<BR>
										��1. <a href="cq720i.jsp?idx=340" target="_blank">���԰���>�԰��� ����>���԰��� Ȯ��</a>�� ��Ȯ�� �Ϸ��Ͽ��� �մϴ�.<BR>
										��2. �԰� N/S�ڴ� �԰����ڸ� ���� �԰濹�����ڷ� �ٽ� �����Ͽ��� �մϴ�. (<a href="cq620i.jsp?idx=338" target="_blank">���԰���>�԰��� ����>���԰��� Ȯ��</a>)
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

