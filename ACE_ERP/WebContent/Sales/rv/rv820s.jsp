<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ���� ������Ȳ (���Һ�)
 * ���α׷�ID 	: RV820S
 * J  S  P		: rv820s
 * �� �� ��		: Rv820S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-08
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-11-13][�ɵ���] ������ ��Ȳ ����
 *						�ݰ���� ���� �� ������ �޶� ����� �����ϴ� �׸��� ���� �����ȴ�
 *						���� �������� ��..�׸��� ������ �ٸ���.. ��..
 * [2009-09-21][�ɵ���] plz �߰�
 
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
		 var div='';
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			cfStyleGrid(getObjectFirst("gr3"), "comn");

			document.all.gridlayer1.style.display="none";
			document.all.gridlayer2.style.display="none";
			document.all.gridlayer3.style.display="none";

			fnInit();
		} 
		 
		function fnInit() {
		
			sJob_date.text='<%=firstday%>';	
    	    ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
	        ds_saup.Reset(); //�����ڵ�		        
		}
		
		
		
		/*
		 * ���� ��ȸ
		 */
		function fnSelect() {
			var saupSid = lc1.ValueOfIndex("saup_sid", lc1.Index);
			
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSaup_sid="+ lc1.ValueOfIndex("saup_sid", lc1.Index)
			          + ",sJob_date=" + sJob_date.Text
			          + ",sClientSid=" + sClientSid.value;

			if(saupSid==1){	//�ݰ����� ���
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv820S",
				    "JSP(O:DS1=ds1)",
				    param);
			}else if(saupSid==2){	//������ ���
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv820S",
				    "JSP(O:DS2=ds2)",
				    param);
			}else if(saupSid==5){	//PLZ�� ���
				ln_TRSetting(tr1, 
				    "<%=dirPath%><%=HDConstant.PATH_RV%>Rv820S",
				    "JSP(O:DS3=ds3)",
				    param);
			}			
			
			tr_post(tr1);
		}
			
		/*
		 * ����
		 */
		function fnExcelDs1() {
			if(ds1.RowCount==0&&ds2.RowCount==0&&ds3.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
			
			var saupSid = lc1.ValueOfIndex("saup_sid", lc1.Index);

			if(saupSid==1){	//�ݰ����� ���
		        getObjectFirst("gr1").SetExcelTitle(0, "");
		        getObjectFirst("gr1").SetExcelTitle(1, "value:�ݰ��� ���� ������Ȳ(���Һ�) ���; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr1").GridToExcel("�ݰ������ ������Ȳ(���Һ�)","�ݰ��� ���� ������Ȳ(���Һ�).xls", 8);
			}else if(saupSid==2){	//������ ���
		        getObjectFirst("gr2").SetExcelTitle(0, "");
		        getObjectFirst("gr2").SetExcelTitle(1, "value:���� ���� ������Ȳ(���Һ�) ���; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr2").GridToExcel("�������� ������Ȳ(���Һ�)","���� ���� ������Ȳ(���Һ�).xls", 8);
			}else if(saupSid==5){	//PLZ
		        getObjectFirst("gr3").SetExcelTitle(0, "");
		        getObjectFirst("gr3").SetExcelTitle(1, "value:PLZ ���� ������Ȳ(���Һ�) ���; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
		        getObjectFirst("gr3").GridToExcel("PLZ���� ������Ȳ(���Һ�)","PLZ ���� ������Ȳ(���Һ�).xls", 8);
			}


				        
		}
    	
		/**
	     * �˻����� �븮��  �˾� 
	     */
	    function fnSelectClientPopup(dirPath) {
	        
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	        var strURL; 
	        var strPos;
	        
	        arrResult = fnClientPop(dirPath,'');
	    
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            sClientNm.value = arrParam[1];
	            sClientSid.value = arrParam[0];
	        } else {
	          sClientNm.value = "";
	          sClientSid.value = "";
	        }               
	    }  
	    
		function fnSetGrid() {
			var saupSid = lc1.ValueOfIndex("saup_sid", lc1.Index);
			if(saupSid==1){
				document.all.gridlayer1.style.display="";
				document.all.gridlayer2.style.display="none";
				document.all.gridlayer3.style.display="none";				
			}else if(saupSid==2){
				document.all.gridlayer1.style.display="none";
				document.all.gridlayer2.style.display="";
				document.all.gridlayer3.style.display="none";				
			}else if(saupSid==5){
				document.all.gridlayer1.style.display="none";
				document.all.gridlayer2.style.display="none";
				document.all.gridlayer3.style.display="";
			}

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

	<script language=JavaScript for=lc1 event=OnSelChange()>
	//���� �޺� ���� �Ҷ�.. �׸��� ���ϱ�
			fnSetGrid();
	</script>	

<%



/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>

<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �ݰ���׸���  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �����׸���  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- PLZ �׸���  -->
	<param name="SyncLoad" 	value="true">
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

	<table border='0' cellpadding='0' cellspacing='0' width='845'>	
		
		<tr height="30px">
			<td width='545px'>
				<table border='0' cellpadding='0' cellspacing='1' width='645' bgcolor="#666666">
					<tr height='30px'>
						<td align="center" width="70px" height="30px" class="text" >�븮��</td>
						<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
                            <input type="text" name='sClientNm' id='sClientNm' value='' size='20' readonly='readonly'  class='textbox'>
                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
						</td>

						<td align=left class="text" width="70px">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align=left class="text"  width="70">�۾����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sJob_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">																					
							</object>&nbsp;
							<%=HDConstant.COMMENT_END%>
					 	</td>
					</tr>
				</table>
			</td>
			<td width='200'>
				<table   border='0' cellpadding='0' cellspacing='0' width='200'>
					<tr>
						<td align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelDs1()">		<!-- ���� -->
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height='10px'>
			<td></td>
		</tr>
		<tr>
			<td colspan='2'>
				<table  border='0' cellpadding='0' cellspacing='1' >
					<tr>
						<td>
							<div id=gridlayer1 style="display:;">
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
						              	<FC> name='������'    	ID='RSV_CLOSE_DATE' width=60 align=left 	editlimit=5 show=true		suppress=1</FC>
						              	<FC> name='�����'    	ID='DEPART_DATE'   	width=60 align=left 	editlimit=50 show=true		suppress=2</FC>
   						             	<FC> name='��ǰ'    		ID='SHORT_NM'   	width=60 align=left 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=3</FC>
   						              	<FC> name='��¼���'    	ID='PRT_SEQ'   		width=100 align=left 	editlimit=50 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=4</FC>
   						            
   						              	<FC> name='�հ�'    		ID='U_TT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} </FC>
   						              	<C> name='�رݰ�'    	ID='U_HH'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='��ġ'    		ID='U_FH'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�Ҽ�'    		ID='U_PT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='ķ��ī'    	ID='U_CC'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�ݰ���'    	ID='U_GH'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����'    		ID='U_GB'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�ܱݰ�'    	ID='U_MH'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����'    		ID='U_NV'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='��õ'    		ID='U_OV'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�Ƴ�Ƽ'  		ID='U_AG'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='������'    	ID='U_FD'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='��Ʈ'    		ID='U_YT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����'    		ID='U_1D'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�����'    	ID='U_ZA'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='TOT_CHK'		ID='tot_chk'		width=100 	align=left 	editlimit=1 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   	
						        
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
							</div>
							
							<div id=gridlayer2 style="display:;">
							<%=HDConstant.COMMENT_START%>
							<object id=gr2 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds2">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              	<FC> name='������'    	ID='RSV_CLOSE_DATE' width=60 align=left 	editlimit=5 show=true		suppress=1</FC>
						              	<FC> name='�����'    	ID='DEPART_DATE'   	width=60 align=left 	editlimit=50 show=true		suppress=2</FC>
   						             	<FC> name='��ǰ'    		ID='SHORT_NM'   	width=60 align=left 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=3</FC>
   						              	<FC> name='��¼���'    	ID='PRT_SEQ'   		width=100 align=left 	editlimit=50 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=4</FC>
   						            
   						              	<FC> name='�հ�'    		ID='U_TT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} </FC>
   						              	<C> name='�ڿ�'    		ID='U_BY'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����'    		ID='U_YT'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�ո�'    		ID='U_WR'   		width=60 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>

										<C> name='TOT_CHK'		ID='tot_chk'		width=100 	align=left 	editlimit=1 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   	
						        
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
							</div>

							<div id=gridlayer3 style="display:;">
							<%=HDConstant.COMMENT_START%>
							<object id=gr3 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds3">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								<param name="Format" 			value="
						              	<FC> name='������'    	ID='RSV_CLOSE_DATE' width=60 align=left 	editlimit=5 show=true		suppress=1</FC>
						              	<FC> name='�����'    	ID='DEPART_DATE'   	width=60 align=left 	editlimit=50 show=true		suppress=2</FC>
   						             	<FC> name='��ǰ'    	ID='SHORT_NM'   	width=60 align=left 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=3</FC>
   						              	<FC> name='��¼���'    ID='PRT_SEQ'   		width=100 align=left 	editlimit=50 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} suppress=4</FC>
   						            
   						              	<FC> name='�հ�'    	ID='U_TT'   	width=85 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')} </FC>
   						              	<C> name='����(��õ)'   ID='U_1001'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����(ȭõ)'   ID='U_DHC'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����(����)'   ID='U_DGP'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����(ȭ��)'   ID='U_DHS'  	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����(Ⱦ��)'   ID='U_DHW'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����(�籸)'   ID='U_DYG'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����(�Ȼ�)'   ID='U_DAS'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='����(����)'   ID='U_DGR'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='����(����)'   ID='U_DPJ'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='����(��õ)'   ID='U_DPC'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										<C> name='����(�Ѱ�)'   ID='U_DHR'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
										
   						              	<C> name='�籸(ȣ��)' 	ID='U_YGH'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�籸(���)' 	ID='U_YGP'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='����(�ܵ�)' 	ID='U_SCC'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�¾�(����)' 	ID='U_TAH'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='ȭõ(��Ʈ)' 	ID='U_HCD'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	
   						              	<C> name='�ϵ�(�ѿ�)' 	ID='U_HDS'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>

   						              	<C> name='ī�Ḯ��' 	ID='U_FCM'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='ũ�����Ѹ�' 	ID='U_FCF'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�ΰ��Ѹ�' 	ID='U_FBG'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='��Űķ��' 	ID='U_SSW'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='Ƽ������' 	ID='U_TKO'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	
   						              	<C> name='���ֱ׷���' 		ID='U_JGR'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='���ִ����Ϸ���' 	ID='U_JNI'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='���ִ�����' 		ID='U_JNJ'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	<C> name='�潺Ÿ' 			ID='U_FST'   	width=70 align=right 	editlimit=50 show=true		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>
   						              	
										<C> name='TOT_CHK'		ID='tot_chk'	width=100 	align=left 	editlimit=1 show=false		bgColor={IF(tot_chk='N','<%=HDConstant.GRAD_OK_COLOR%>','<%=HDConstant.GRID_SUM_COLOR%>')}</C>   	
						        
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
							</div>

						</td>
						
					</tr>
				</table>
			</td>
		</tr>
		
		<tr>
			<td>
�� ����������Ȳ�� ��ġ�� �Ʒ��� ���� �������� ��ȸ�˴ϴ�.<br>
��1. �⺻ ����<br>
����1.1. ������=<b>������</b>("10") �̸鼭 �������=<b>�Ϲ�("10") �Ǵ� ��������("20")</b> �� ��<br>
����1.2. �������=<b>������û</b>("30")  �Ǵ� <b>�̻갡��</b>("40") �� �� (<b>�����п� �������</b> ��� ��ȸ)<br>
<br>
��2. ����<br>
����2.1. �Ϲݿ��� ������ �� (���Է� ����)<br>
����2.2.1. ��ȿ ���(OK,PK,DK)�� <b>�ƴ�</b> ��Ͽ��� ������ �� (���Է� ����)<br>
����2.2.2. ��ȿ ���(OK,PK,DK)�� Ȯ�� �ο����� �ش� ����� ���Է� ������ �� �߿� ū ��<br>
������ �� 3������ �� ���ؼ� �����ݴϴ�.<br>
			</td>
		</tr>
	</table>


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

