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
		cfStyleGrid(getObjectFirst("gr3"), "comn");
		cfStyleGrid(getObjectFirst("gr4"), "comn");
		cfStyleGrid(getObjectFirst("gr5"), "comn");
		cfStyleGrid(getObjectFirst("gr6"), "comn");
		cfStyleGrid(getObjectFirst("gr7"), "comn");
		
		
		sJobDate.text='<%=firstday%>';
                  
		var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1";
		 
		// �����, ������
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_SAUP_DS=codeDs1)", 
            param);
            
        tr_post(tr1);		
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
    	
 		var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
        	+ "sSaup_sid=" +codeDs1.namevalue(codeDs1.rowposition,"saup_sid") + ","        
        	+ "sJobDate=" + sJobDate.text;
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy520S",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3,O:DS4=ds4,O:DS5=ds5,O:DS6=ds6,O:DS7=ds7)",
            param);
        tr_post(tr1);

    }
 	
  	function fnExcel() {
	        getObjectFirst("gr7").SetExcelTitle(0, "");
	        getObjectFirst("gr7").GridToExcel("Sheet7","�ڷ�����.xls", 32);   

	        getObjectFirst("gr6").SetExcelTitle(0, "");
	        getObjectFirst("gr6").GridToExcel("Sheet6","�ڷ�����.xls", 32);   

	        getObjectFirst("gr5").SetExcelTitle(0, "");
	        getObjectFirst("gr5").GridToExcel("Sheet5","�ڷ�����.xls", 32);   

  
	        getObjectFirst("gr4").SetExcelTitle(0, "");
	        getObjectFirst("gr4").GridToExcel("Sheet4","�ڷ�����.xls", 32);   
	        
	        getObjectFirst("gr3").SetExcelTitle(0, "");
	        getObjectFirst("gr3").GridToExcel("Sheet3","�ڷ�����.xls", 32);   
	        
	        getObjectFirst("gr2").SetExcelTitle(0, "");
	        getObjectFirst("gr2").GridToExcel("Sheet2","�ڷ�����.xls", 32);   
	        
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").GridToExcel("Sheet1","�ڷ�����.xls", 32);   
	        /*  	
			if(selExl[0].checked){
		        getObjectFirst("gr1").SetExcelTitle(0, "");
		        getObjectFirst("gr1").GridToExcel("Sheet1","�ڷ�����.xls", 32);   
			}else if(selExl[1].checked){
		        getObjectFirst("gr2").SetExcelTitle(0, "");
		        getObjectFirst("gr2").GridToExcel("Sheet2","�ڷ�����.xls", 32);   
			}else if(selExl[2].checked){
		        getObjectFirst("gr3").SetExcelTitle(0, "");
		        getObjectFirst("gr3").GridToExcel("Sheet3","�ڷ�����.xls", 32);   
			}else if(selExl[3].checked){
	  	        getObjectFirst("gr4").SetExcelTitle(0, "");
		        getObjectFirst("gr4").GridToExcel("Sheet4","�ڷ�����.xls", 32);   
			}else if(selExl[4].checked){
		        getObjectFirst("gr5").SetExcelTitle(0, "");
		        getObjectFirst("gr5").GridToExcel("Sheet5","�ڷ�����.xls", 32);   
			}else if(selExl[5].checked){
		        getObjectFirst("gr6").SetExcelTitle(0, "");
		        getObjectFirst("gr6").GridToExcel("Sheet6","�ڷ�����.xls", 32);   
			}else if(selExl[6].checked){
		        getObjectFirst("gr7").SetExcelTitle(0, "");
		        getObjectFirst("gr7").GridToExcel("Sheet7","�ڷ�����.xls", 8);   
			}else{
				alert("�ڷḦ �������ּ���.");			
			};*/
	        
        }
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		resultMsg.innerHTML="�ڷ� �Ǽ� = <b>������: "+ds1.CountRow+", ��������:"+ds2.CountRow+", ����������: "+ds3.CountRow+", ������: "+ds4.CountRow+", �����: "+ds5.CountRow+", ����ڿ���: "+ds6.CountRow+", RF�߱�: "+ds7.CountRow+"</b>";
		
	</script>	
<%



/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>
<object id=ds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="true">
</object>


<!--  ����� -->
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
    					<td align=left width=70 class="text">�������</td>
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
						
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan='2' HEIGHT="420">
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<table  border="0" cellpadding="0" cellspacing="0">
								<tr valign="top"">
									<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">

									<%=HDConstant.COMMENT_START%>
									<object id=mxTab classid=CLSID:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute; left:170; top:190; width:845; height:20">
										<param name="BackColor"			value="#00ffff">
										<param name="DisableBackColor"	value="#ffffee">
										<param name="Format"			value='
											<T>divid="mxTab_page1"	title="������:TCU010"</T>
											<T>divid="mxTab_page2"	title="��������:TRV010"</T>
											<T>divid="mxTab_page3"	title="����������:TRV020"</T>
											<T>divid="mxTab_page4"	title="������:TRV030"</T>
											<T>divid="mxTab_page5"	title="�����:TCM010"</T>
											<T>divid="mxTab_page6"	title="����ڿ���:TCM040"</T>
											<T>divid="mxTab_page7"	title="RF�߱�:RF_TAG_H"</T>
											'>	
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
										<param name="Format" 			value="
							               		<C> name='��SID'	ID='CUST_SID'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='��û����ȣ'	ID='GROUP_CD'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�ֹ�/���ǹ�ȣ'	ID='MANAGE_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�׷��ȣ'		ID='GROUP_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='�ֹι�ȣ'		ID='REGI_NO'	 width=100 align=left editlimit=13 show=true</C>
												<C> name='��������'		ID='REGI_YN'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='������'		ID='CUST_GU'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='��������'		ID='COUNTRY_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='�������'		ID='SAUP_GU'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='������'		ID='CUST_TYPE'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='�ѱۼ���'		ID='CUST_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='������'	ID='LAST_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='��������'	ID='FIRST_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='�����ڵ�'	ID='COUNTRY_CD'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='�����ڵ�'	ID='NATION_CD'	 width=100 align=left editlimit=3 show=true</C>
												<C> name='�������'	ID='BIRTHDAY'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='����'		ID='SEX'	 width=100 align=left editlimit=1 show=true</C>
												<C> name='������ȭ'	ID='TEL_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�ڵ���'	ID='MOBILE_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�̸���'	ID='E_MAIL'	 width=100 align=left editlimit=40 show=true</C>
												<C> name='FAX��ȣ'	ID='FAX_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='�����ȣSID'	ID='ZIP_SID'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='�����ȣ'	ID='ZIP_CD'	 width=100 align=left editlimit=6 show=true</C>
												<C> name='�ּ�1'	ID='ADDRESS1'	 width=100 align=left editlimit=80 show=true</C>
												<C> name='�ּ�2'	ID='ADDRESS2'	 width=100 align=left editlimit=60 show=true</C>
												<C> name='�ܱ������ȣ'	ID='ENG_ZIP_CD'	 width=100 align=left editlimit=10 show=true</C>
												<C> name='�����ּ�1'	ID='ENG_ADDR1'	 width=100 align=left editlimit=60 show=true</C>
												<C> name='�����ּ�2'	ID='ENG_ADDR2'	 width=100 align=left editlimit=60 show=true</C>
												<C> name='��������'	ID='PASS_TYPE'	 width=100 align=left editlimit=2 show=true</C>
												<C> name='���ǹ�ȣ'	ID='PASS_NO'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='���Ǹ�����'	ID='PASS_EXPIRE_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='���ǹ�����'	ID='PASS_ISSUE_DATE'	 width=100 align=left editlimit=8 show=true</C>
												<C> name='���ǹ�����'	ID='PASS_AREA'	 width=100 align=left editlimit=22 show=true</C>
												<C> name='�����'	ID='COMPANY_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='����'	ID='POSITIONS'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='���������'	ID='ENG_COMPANY_NM'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='��������'	ID='ENG_POSITION'	 width=100 align=left editlimit=30 show=true</C>
												<C> name='���ѹ湮Ƚ��'	ID='NORTH_CNT'	 width=100 align=left editlimit=7 show=true</C>
												<C> name='����óSID'	ID='CLIENT_SID'	 width=100 align=left editlimit=12 show=true</C>
												<C> name='����'	ID='HEIGHT'	 width=100 align=left editlimit=5 show=true</C>
												<C> name='�Ǹ�Ȯ��'	ID='REGI_YN_T'	 width=100 align=left editlimit=20 show=true</C>
												<C> name='����'	ID='JOB_CD'	 width=100 align=left editlimit=2 show=true</C>
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
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           				<C> name='��ûSID'	ID='ACCEPT_SID'	 align=left editlimit=12 show=true</C>
												<C> name='��û����ȣ'	ID='ACCEPT_NO'	 align=left editlimit=14 show=true</C>
												<C> name='��û����'	ID='ACCEPT_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='�������'	ID='DEPART_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='�����SID'	ID='SAUP_SID'	 align=left editlimit=12 show=true</C>
												<C> name='��ǰSID'	ID='GOODS_SID'	 align=left editlimit=12 show=true</C>
												<C> name='����óSID'	ID='CLIENT_SID'	 align=left editlimit=12 show=true</C>
												<C> name='���SID'	ID='EVENT_SID'	 align=left editlimit=12 show=true</C>
												<C> name='�۾�����'	ID='JOB_GUBUN'	 align=left editlimit=1 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page3" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds3">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           				<C> name='����SID'	ID='RSV_SID'	 align=left editlimit=12 show=true</C>
												<C> name='�ֿ���SID'	ID='M_RSV_SID'	 align=left editlimit=12 show=true</C>
												<C> name='KEY-MAN'	ID='KEY_MAN'	 align=left editlimit=13 show=true</C>
												<C> name='��ûSID'	ID='ACCEPT_SID'	 align=left editlimit=12 show=true</C>
												<C> name='����SID'	ID='UPJANG_SID'	 align=left editlimit=12 show=true</C>
												<C> name='��û����Ÿ��SID'	ID='A_ROOM_TYPE_SID'	 align=left editlimit=12 show=true</C>
												<C> name='��û����SID'	ID='A_ROOM_SID'	 align=left editlimit=12 show=true</C>
												<C> name='����Ÿ��SID'	ID='ROOM_TYPE_SID'	 align=left editlimit=12 show=true</C>
												<C> name='����SID'	ID='ROOM_SID'	 align=left editlimit=12 show=true</C>
												<C> name='����ROOM NO'	ID='OLD_ROOM_NO'	 align=left editlimit=5 show=true</C>
												<C> name='���SID'	ID='BLOCK_SID'	 align=left editlimit=12 show=true</C>
												<C> name='����Ÿ��'	ID='RSV_TYPE'	 align=left editlimit=1 show=true</C>
												<C> name='�����ڷ����'	ID='STATUS_CD'	 align=left editlimit=2 show=true</C>
												<C> name='�������'	ID='DEPART_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='��߽ð�'	ID='DEPART_TIME'	 align=left editlimit=4 show=true</C>
												<C> name='�ڼ�'	ID='NIGHTS'	 align=left editlimit=5 show=true</C>
												<C> name='�԰�����'	ID='ARRIVE_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='�԰�ð�'	ID='ARRIVE_TIME'	 align=left editlimit=4 show=true</C>
												<C> name='��SID'	ID='CUST_SID'	 align=left editlimit=12 show=true</C>
												<C> name='������'	ID='CUST_TYPE'	 align=left editlimit=3 show=true</C>
												<C> name='������'	ID='CUST_GU'	 align=left editlimit=1 show=true</C>
												<C> name='�������'	ID='SAUP_GU'	 align=left editlimit=2 show=true</C>
												<C> name='�����ڵ�'	ID='AGE_CD'	 align=left editlimit=2 show=true</C>
												<C> name='�����ڵ�'	ID='JOIN_CD'	 align=left editlimit=2 show=true</C>
												<C> name='�ڵ���'	ID='MOBILE_NO'	 align=left editlimit=15 show=true</C>
												<C> name='�����'	ID='COMPANY_NM'	 align=left editlimit=30 show=true</C>
												<C> name='����'	ID='POSITIONS'	 align=left editlimit=30 show=true</C>
												<C> name='�ּ�SID'	ID='ZIP_SID'	 align=left editlimit=12 show=true</C>
												<C> name='�ּ��ڵ�'	ID='ZIP_CD'	 align=left editlimit=6 show=true</C>
												<C> name='�ּ�1'	ID='ADDRESS1'	 align=left editlimit=60 show=true</C>
												<C> name='��'	ID='CLASS'	 align=left editlimit=3 show=true</C>
												<C> name='��'	ID='TEAMS'	 align=left editlimit=3 show=true</C>
												<C> name='������NO'	ID='PAGE_NO'	 align=left editlimit=5 show=true</C>
												<C> name='��ϸ���'	ID='NORTH_PURPOSE'	 align=left editlimit=62 show=true</C>
												<C> name='��������'	ID='DRIVE_YN'	 align=left editlimit=1 show=true</C>
												<C> name='��һ����ڵ�'	ID='CANCEL_CD'	 align=left editlimit=2 show=true</C>
												<C> name='��������ȣ'	ID='TOUR_NO'	 align=left editlimit=20 show=true</C>
												<C> name='������üũ'	ID='MOJ_CHECK_YN'	 align=left editlimit=1 show=true</C>
												<C> name='�����̼�����'	ID='EDUC_FINISH_YN'	 align=left editlimit=1 show=true</C>
												<C> name='�����������'	ID='ORG_SUBMIT_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='���Ϻ��Ϸù�ȣ'	ID='UNITY_NO'	 align=left editlimit=12 show=true</C>
												<C> name='����㰡����[����]'	ID='SOUTH_PERMIT_YN'	 align=left editlimit=1 show=true</C>
												<C> name='�����������'	ID='NORTH_SUBMIT_DATE'	 align=left editlimit=8 show=true</C>
												<C> name='�������ð�'	ID='NORTH_SUBMIT_TIME'	 align=left editlimit=4 show=true</C>
												<C> name='�����Ա��㰡'	ID='NORTH_PERMIT_YN'	 align=left editlimit=1 show=true</C>
												<C> name='�����û���'	ID='RSV_WAY_CD'	 align=left editlimit=1 show=true</C>
												<C> name='�������'	ID='REMARKS'	 align=left editlimit=200 show=true</C>
												
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page4" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr4 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds4">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
						           			<C> name='����SID'		ID='RSV_SID'	 width=100 align=left editlimit=12 show=true</C>
											<C> name='�������'		ID='USE_DATE'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='����'		ID='KEY_SEQ'	 width=100 align=left editlimit=5 show=true</C>
											<C> name='�޴�SID'		ID='MENU_SID'	 width=100 align=left editlimit=12 show=true</C>
											<C> name='ǥ�ؿ��'		ID='STD_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='�̿���'		ID='USE_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
											<C> name='�Ǹż���'		ID='SALE_QTY'	 width=100 align=left editlimit=5 show=true</C>
											<C> name='�ɼǻ�ǰ����'	ID='OPTION_YN'	 width=100 align=left editlimit=1 show=true</C>
											<C> name='����ð��翩��'	ID='RSV_PAY_YN'	 width=100 align=left editlimit=1 show=true</C>
											<C> name='�������'		ID='REMARKS'	 width=100 align=left editlimit=100 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>

									<div class=page id="mxTab_page5" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr5 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds5">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
											<C> name='��SID' ID='CUST_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='����������⿩��' ID='VISIT_K_LIST'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�ǹ���ȣ' ID='WORK_NO'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�Ҽӻ�' ID='CLIENT_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='���δ�ȸ��' ID='REAL_CLIENT'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='��ϱ����̼�����' ID='N_EDUC_YN'	 width=100 align=left editlimit=8 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>

									<div class=page id="mxTab_page6" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr6 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds6">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
											<C> name=' ����SID' ID='RSV_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' �����SID' ID='CUST_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' �������Ÿ��' ID='A_ROOM_TYPE_SID'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' ������� �������' ID='REMARKS'	 width=100 align=left editlimit=8 show=true</C>
											<C> name=' ���������' ID='N_CARD_GU'	 width=100 align=left editlimit=8 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>

									<div class=page id="mxTab_page7" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr7 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds7">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption 	value=1>
										<param name="Format" 			value="
											<C> name='�±׽ø���'      ID='TAG_SER'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱޼���'        ID='TAG_SEQ'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱ޱ���'        ID='TAG_ISSUE_KIND' 	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱޺��'        ID='COMMENT'       	 width=100 align=left editlimit=8 show=true</C>
											<C> name='ȸ��Ű'          ID='MEMBER_NO'      	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�����'          ID='MEM_GROUP'      	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�̸�'            ID='NAME'           	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�ֹε�Ϲ�ȣ'    ID='PS_NO'          	 width=100 align=left editlimit=8 show=true</C>
											<C> name='��ϱ���'        ID='MEMBER_KIND'    	 width=100 align=left editlimit=8 show=true</C>
											<C> name='ī�屸��'        ID='RF_KIND'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='��� ������'     ID='USE_FROM'       	 width=100 align=left editlimit=8 show=true</C>
											<C> name='��� ������'     ID='USE_TO'         	 width=100 align=left editlimit=8 show=true</C>
											<C> name='Ű����'          ID='KEY_VER'        	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱������ڵ�'    ID='ISSUE_AUTH_CODE'	 width=100 align=left editlimit=8 show=true</C>
											<C> name='�߱���'          ID='USER_ID'        	 width=100 align=left editlimit=8 show=true</C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									
							</td>		
						</tr>
					</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td id=resultMsg></td>
		</tr>
		<tr>
			<td>�� ��ȸ �� GRID ����� �� Tab�� �ѹ��� Ŭ���� �� [�׼�] ��ư�� ������ �������� �߸� ���� �ٿ�ε�˴ϴ�.</td>
		</tr>

	</table>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

