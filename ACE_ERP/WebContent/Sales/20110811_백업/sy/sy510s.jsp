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
		cfStyleGrid(getObjectFirst("gr8"), "comn");
		
		
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
        	+ "sJobDate=" + sJobDate.text + ","
        	+ "sAll=" + sAll.value;
                      
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SY%>Sy510S",
            "JSP(O:DS1=ds1,O:DS2=ds2,O:DS3=ds3,O:DS4=ds4,O:DS5=ds5,O:DS6=ds6,O:DS7=ds7,O:DS8=ds8)",
            param);
        tr_post(tr1);

    }
 	
  	function fnExcel() {
  	
		  	getObjectFirst("gr8").SetExcelTitle(0, "");
	        getObjectFirst("gr8").GridToExcel("Sheet8","�ڷ�����.xls", 32);   

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
            
	        
            
        }
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
	<script language="javascript" for="tr1" event="onsuccess()">
		window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		resultMsg.innerHTML="�ڷ� �Ǽ� = <b>����������: "+ds1.CountRow+", ������:"+ds2.CountRow+", ����Ÿ������: "+ds3.CountRow+", ��������: "+ds4.CountRow+", ��ǰ����: "+ds5.CountRow+", �����ڵ�: "+ds6.CountRow+", ����ó����: "+ds7.CountRow+", �ɼǿ������: "+ds8.CountRow+"</b>";		
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
<object id=ds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
    					<td align=left width=70 class="text">��������</td>
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
							</object> �� ���� 
							<%=HDConstant.COMMENT_END%>&nbsp;
						</td>		
						<td align=left width=100 class="text">��ü</td>
                        <td align=left bgcolor="#ffffff">&nbsp;																										
							<select name=sAll>
								<option value="Y">��ü</option>
								<option value="N">��������</option>
							</select>
						</td>	
					</tr>
				</table>
			</td>
		</tr>
		
				
		<tr>
			<td height=420>
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
											<T>divid="mxTab_page1"	title="����������"</T>
											<T>divid="mxTab_page2"	title="������"</T>
											<T>divid="mxTab_page3"	title="����Ÿ������"</T>
											<T>divid="mxTab_page4"	title="��������"</T>
											<T>divid="mxTab_page5"	title="��ǰ����"</T>
											<T>divid="mxTab_page6"	title="�����ڵ�"</T>
											<T>divid="mxTab_page7"	title="����ó����"</T>
											<T>divid="mxTab_page8"	title="�ɼǿ������"</T>
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
							               	<C> name='����SID'			ID='UPJANG_SID'			width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='�����ڵ�'			ID='UPJANG_CD'			width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='�����'			ID='UPJANG_NM'			width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='���念����'			ID='UPJANG_ENG_NM'		width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='��������'			ID='UPJANG_SHORT_NM'	width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='����Ÿ��'			ID='UPJANG_TYPE'		width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='��������'			ID='DIRECT_YN'			width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='��뿩��'			ID='USE_YN'				width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='ȭ��ǥ�ü���'		ID='DISPLAY_SEQ'		width=100 align=left editlimit=50 show=true </C>  
							               	<C> name='�������'			ID='REMARKS'			width=100 align=left editlimit=50 show=true </C>  
							               		<C> name='���SID'			ID='SAUP_SID'			width=100 align=left editlimit=50 show=true </C>  
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
						           			<C> name='��SID'				ID='DONG_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='���ڵ�'			ID='DONG_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='���̸�'			ID='DONG_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='������'			ID='DONG_ENG_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�����'			ID='DONG_SHORT_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����SID'			ID='UPJANG_SID'			width=100 align=left editlimit=50 show=true </C> 
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
						           			<C> name='����Ÿ��SID'				ID='ROOM_TYPE_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='����SID'			ID='UPJANG_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='���ǵ���ڵ�'			ID='ROOM_GRADE_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='���Ÿ��'			ID='BED_TYPE_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����Ÿ��'			ID='ROOM_TYPE_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����Ÿ�Ը�'			ID='ROOM_TYPE_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����'				ID='PYUNG'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�ּ��ο�'			ID='STD_PERSONS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�ִ��ο�'			ID='MAX_PERSONS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='ȭ��ǥ�ü���'			ID='DISPLAY_SEQ'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��뿩��'			ID='USE_YN'			width=100 align=left editlimit=50 show=true </C> 
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
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='����SID'			ID='ROOM_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='���ǹ�ȣ'			ID='ROOM_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��������'			ID='BGN_DATE'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��������'			ID='END_DATE'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��������:R'			ID='ROOM_VIEW_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='������'			ID='FLOORS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��뿩��:S'			ID='USE_YN'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�����SID'			ID='UPJANG_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��SID'				ID='DONG_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����Ÿ��SID'		ID='ROOM_TYPE_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�������'			ID='REMARKS'			width=100 align=left editlimit=50 show=true </C> 
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
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='��ǰSID'			ID='GOODS_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='��ǰ�ڵ�'			ID='GOODS_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��ǰ��'			ID='GOODS_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='������ǰ��'			ID='ENG_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�⺻���'			ID='COURSE'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�ڼ�'				ID='NIGHTS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�ϼ�'				ID='DAYS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��뿩��'			ID='USE_YN'			width=100 align=left editlimit=50 show=true </C> 
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
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='��з�'			ID='HEAD'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='�Һз�'			ID='DETAIL'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Һз���'			ID='DETAIL_NM'		width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�1'				ID='ITEM1'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�2'				ID='ITEM2'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�3'				ID='ITEM3'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�4'				ID='ITEM4'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�5'				ID='ITEM5'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�6'				ID='ITEM6'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�7'				ID='ITEM7'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�8'				ID='ITEM8'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�9'				ID='ITEM9'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�10'			ID='ITEM10'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�11'			ID='ITEM11'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�12'			ID='ITEM12'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�13'			ID='ITEM13'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�14'			ID='ITEM14'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�Ӽ�15'			ID='ITEM15'			width=100 align=left editlimit=50 show=true </C> 
						           			
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
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           			<C> name='����óSID'		ID='CLIENT_SID'			width=100 align=left editlimit=50 show=true </C>
						           			<C> name='ȸ��ŷ�ó'		ID='VEND_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����ó�ڵ�'		ID='CLIENT_CD'		width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����ó��'			ID='CLIENT_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����ó����'		ID='CLIENT_GU'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�븮������'		ID='AGEN_GU'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='���ǿ���'			ID='DIR_YN'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�����ڵ�'			ID='AREA_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����������ڵ�'	ID='SAL_DAM_SID'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����ó�����'		ID='CLIENT_DAM_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��ȭ��ȣ'			ID='TEL_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�޴���ȭ'			ID='MOBILE_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='FAX��ȣ'			ID='FAX_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�̸���'			ID='E_MAIL'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�����ȣ'			ID='ZIP_CD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�ּ�1'			ID='ADDRESS1'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�ּ�2'			ID='ADDRESS2'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��������'			ID='COMMI_RATE'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='������'			ID='CUNT_STATUS'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='�����ڵ�'			ID='BANCOD'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='������¹�ȣ'		ID='BANK_ACC_NO'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='������'			ID='BANK_ACCT_NM'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='��뿩��'			ID='USE_YN'			width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����Ÿ��'			ID='VEND_TYPE'	width=100 align=left editlimit=50 show=true </C> 
						           			<C> name='����ڹ�ȣ'		ID='VEND_ID'	width=100 align=left editlimit=50 show=true </C> 
										">
									</object>
									<%=HDConstant.COMMENT_END%>	
									</div>
									<div class=page id="mxTab_page8" style="position:absolute; left:170; top:210; width:845; height:300">
									<%=HDConstant.COMMENT_START%>
									<object id=gr8 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=845px; height:360" border="1" >
	                        			<param name="DataID"		VALUE="ds8">
	                        			<param name="BorderStyle"   VALUE="0">
	                        			<param name=ColSizing       value="true">
	                        			<param name="editable"      value="false">
	                        			<param name=UsingOneClick  	value="1">
	                                    <Param Name="AllShowEdit"   value="True">
	                                    <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
						           					<C> name='�޴�SID'			ID='MENU_SID'	width=100 align=left editlimit=12 show=true</C>
													<C> name='�޴��ڵ�'			ID='MENU_CD'	 width=100 align=left editlimit=13 show=true</C>
													<C> name='�޴������ڵ�'		ID='MENU_GUBUN_CD'	width=100  align=left editlimit=2 show=true</C>
													<C> name='�޴�����1'			ID='MENU_ITEM1'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='�޴�����2'			ID='MENU_ITEM2'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='�޴�����3'			ID='MENU_ITEM3'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='�޴�����4'			ID='MENU_ITEM4'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='�޴�����5'			ID='MENU_ITEM5'	 width=100 align=left editlimit=5 show=true</C>
													<C> name='�����������'		ID='BGN_DATE'	 width=100 align=left editlimit=8 show=true</C>
													<C> name='������������'		ID='END_DATE'	 width=100 align=left editlimit=8 show=true</C>
													
													<C> name='�����ο�'			ID='BGN_PERSONS'	width=100  align=left editlimit=4 show=true</C>
													<C> name='�����ο�'			ID='END_PERSONS'	width=100  align=left editlimit=4 show=true</C>
													<C> name='�޴���'			ID='MENU_NM'	 width=100 align=left editlimit=50 show=true</C>
													<C> name='�޴�������'			ID='MENU_ENG_NM'	width=100  align=left editlimit=30 show=true</C>
													<C> name='�޴������'			ID='MENU_SHORT_NM'	width=100  align=left editlimit=12 show=true</C>
													<C> name='��������'			ID='TAX_YN'	 width=100 align=left editlimit=1 show=true</C>
													<C> name='���ݰ����'		ID='TAX_CALCU_CD'	width=100  align=left editlimit=1 show=true</C>
													<C> name='�ܰ�'				ID='UNIT_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='���ް�'			ID='NET_AMT'	width=100  align=left editlimit=12 show=true dec=0</C>
													<C> name='�ΰ���'			ID='VAT_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													
													<C> name='Ư�Ҽ�'			ID='EXCISE_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='������'			ID='EDU_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='��Ư��'			ID='VILLAGE_AMT' width=100 	 align=left editlimit=12 show=true dec=0</C>
													<C> name='ü�����'			ID='SPORTS_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='�������'			ID='TOUR_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='��ȸ��'			ID='ASSOC_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='�����'			ID='TIP_AMT'	 width=100 align=left editlimit=12 show=true dec=0</C>
													<C> name='��ȭ�ڵ�(RV022)'	ID='CURRENCY_CD'	width=100  align=left editlimit=3 show=true</C>
													<C> name='�ɼǻ�ǰ����'		ID='OPTION_YN'	 	width=100 align=left editlimit=1 show=true</C>
													<C> name='�ɼ�ǥ��(RV023)'	ID='OPTION_VIEW_CD' width=100 	 align=left editlimit=1 show=true</C>
													
													<C> name='ȭ��ǥ�ü���'		ID='DISPLAY_SEQ'	width=100  align=left editlimit=4 show=true</C>
													<C> name='��뿩��'			ID='USE_YN'	 width=100 align=left editlimit=1 show=true</C>
													<C> name='���SID'			ID='SAUP_SID'	width=100  align=left editlimit=12 show=true</C>
													<C> name='����SID'			ID='UPJANG_SID' width=100 	 align=left editlimit=12 show=true</C>
													<C> name='�������'			ID='REMARKS'	width=100  align=left editlimit=100 show=true</C>

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

