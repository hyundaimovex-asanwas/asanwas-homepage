<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : �����(���ϼ�)üũ����Ʈ
 * ���α׷�ID 	 : CQ580S
 * J  S  P		 : cq580s
 * �� �� ��		 : CQ580S
 * �� �� ��		 : ����ǥ
 * �� �� ��		 : 2006-08-24 
 * �������		 : �����(���ϼ�)üũ����Ʈ (��ȸ)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-07-28][�ɵ���] �ּ��� �߰�.
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
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
	<script language="javascript">
        var v_job = "H";
        var div='';
	/*
	 * �������ε�
	 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			fnInit();
		}
	/*
	 * ����Ÿ�� ��� ����
	 */
	function fnSetHeader(){
	}
	/*
	 * ����ȸ
	 */
	function fnInit(){
        v_job = "H";
		div='init';	        
        cfStyleGrid(getObjectFirst("gr1"), "comn");
                      
		fnSetHeader();

		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
		sBgnDate.text='<%=firstday%>';

      	ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //�����ڵ�

        ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_Item1=Y";
        ds_status.Reset();	//�������

              
	}
	
	/*
	 * ������ȸ
	 */
    function fnSelect() {
    	if ( sBgnDate.text.trim() == '' ) {
			alert("������ڸ� �Է����ּ���.");
			return;
		}    
        v_job = "S";
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid") + ","        
            + "sBgnDate=" + sBgnDate.text + ","
            + "sDepartTime=" + ds_depart_time.namevalue(ds_depart_time.rowposition,"depart_time") + ","            
            + "sGoodsSid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index);

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CQ%>Cq580S",
            "JSP(O:DS1=ds1)",
            param);
        tr_post(tr1);

    }
	
	/*
	 * ����
	 */
	function fnExcel() {
		if(ds1.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr1").SetExcelTitle(0, "");
	        getObjectFirst("gr1").SetExcelTitle(1, "value:����� üũ����Ʈ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("����� üũ����Ʈ","����� üũ����Ʈ.xls", 8);
	}
	/*
	 * ���ð�
	 */		
	function fnSelectDsDepartTime() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1,"
            + "sSaupSid=" + ds_saup.namevalue(ds_saup.rowposition,"saup_sid") + ","
			+ "sDepartDate=" + sBgnDate.text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_DEPART_TIME_DS=ds_depart_time)",
            param);
        tr_post(tr2);
	}		

	//��ǰ��ȸ
	function fnSelectGoodsLC() {
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
            + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			+ ",sDepartDate=" + sBgnDate.Text;
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
            "JSP(O:S_GOODS_DS=ds_goods)",
            param);
        tr_post(tr2);
	};
    </script>	
    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language=JavaScript for= lc_saup event=OnSelChange()>
		if ( div != 'init' ) {	//����
			div = 'init';			
			fnSelectDsDepartTime();
		}
	</script>
	
	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		if ( div != 'init' ) {	//�������
			if ( sBgnDate.Modified ) {
				div = 'init';
				fnSelectDsDepartTime();			
			}
		}				
	</script>

<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>

<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
			fnSelect();                                    
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
    	window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.A_MSG_SAVE_DONE%>";
			fnSelect();                                    
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
    	window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
	</script>	
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript  for=ds_saup event="OnLoadCompleted(row)">
		fnSelectDsDepartTime();	//���ð� ��˻�
		fnSelectGoodsLC();		//��ǰ ��˻�
	</script>

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectDsDepartTime();	//���ð� ��˻�
		fnSelectGoodsLC();		//��ǰ ��˻�
	</script>

	<script language=JavaScript for=sBgnDate event=OnKillFocus()>
		fnSelectDsDepartTime();	//���ð� ��˻�
		fnSelectGoodsLC();		//��ǰ ��˻�
	</script>
		
	<script language=JavaScript  for=ds_depart_time event="OnLoadCompleted(row)">
		div='';
	</script>	

<%
/*	============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="false">
</object>
<!--  ���� -->
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value=false>
</object>

<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>>	<%// ��ǰ���� %>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_depart_time classid=<%=HDConstant.CT_DATASET_CLSID%>>	<%//���ð�%>
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <%//�������%>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ--%>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyName"    value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
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

									
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>
			<table border="0" width="845px"  cellpadding="0" cellspacing="0">
				<tr height="50px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td align="right">
									<table border="0"  cellpadding="0" cellspacing="0" width="100%">
										<tr>
											<td align="right" height="30px">	
												<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" align=absmiddle onclick="fnSelect()">
											<!-- 	<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:hand" align=absmiddle onclick="fnPrint()"> -->
												<img src="<%=dirPath%>/Sales/images/excel.gif"  style="cursor:hand" align=absmiddle onclick="fnExcel()">  																				
								 			</td>
										</tr>																		
									</table>
								</td>
							</tr>															
						</table>	
					</td>											
				</tr>
				<tr height="30px">
					<td align="left" >
						<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
							<tr> 
								<td  width="845px">
			                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
			                            <tr bgcolor="#6f7f8d">
			            					<td align=left width=70 class="text">&nbsp;�����</td>
			                                <td align=left bgcolor="#ffffff">&nbsp;																										
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_saup>
													<param name=BindColumn      value="saup_sid">
                                                    <param name=BindColVal      value="saup_sid">
													<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
													<param name=ListExprFormat  value="saup_nm^0^120"></object>
												<%=HDConstant.COMMENT_END%>
											</td>	
			            					<td align=left width=70 class="text">&nbsp;�������</td>
			                                <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
										     	<%=HDConstant.COMMENT_START%>
										     	<object id=sBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
  												<%=HDConstant.COMMENT_START%>
					                            <object id=lc_depart_time classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=50 border="0" align=absmiddle>
													<param name=ComboDataID		value=ds_depart_time>
													<param name=BindColumn      value="depart_time">
                                                    <param name=BindColVal      value="depart_time">
													<param name=EditExprFormat	value="%,%;depart_time,depart_time_nm">
													<param name=ListExprFormat  value="depart_time_nm^0^50">
												</object>
												<%=HDConstant.COMMENT_END%>																				
											</td>																				
			            					<td class=text>��ǰ��</td>
                                            <td bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                                <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=130 style="position:relative;left:1px;top:2px" class="txtbox" >
                                                    <param name=ComboDataID         value=ds_goods>
                                                    <param name=SearchColumn        value="GOODS_NM">
                                                    <param name=Sort                value="false">
                                                    <param name=ListExprFormat      value="GOODS_NM^0^130">
                                                    <param name=BindColumn          value="GOODS_SID">
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
				<tr height="10">
					<td></td>
				</tr>		
				<tr>
					<td width="845px">
						<table  border="0" cellpadding="0" cellspacing="0">
							<tr valign="top"">
								<td align="left" width="845px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
								<%=HDConstant.COMMENT_START%>
									<object id=gr1 classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" style="width=845px; height:360" border="1" >
                            			<param name="DataID"		VALUE="ds1">
                            			<param name="BorderStyle"   VALUE="0">
                            			<param name=ColSizing       value="true">
                            			<param name="editable"      value="false">
                            			<param name=UsingOneClick  	value="1">
                                        <Param Name="AllShowEdit"   value="True">
                                        <param name="SortView"      value="Right">
										<param name=SuppressOption value=1>
										<param name="Format" 			value="
							                <c> name='�Ϸù�ȣ'		ID='{CURROW}'      	Width=60    align=right show=false</c>
							                <C> name='��'   		ID='class' 			width=60  align=left editlimit=50 show=true</C>
							                <C> name='��'        	ID='teams'   		width=40  align=right editlimit=11 show=true</C>
							                <C> name='��������ȣ'    	ID='tour_no'   		width=80  align=right editlimit=11 show=true</C>
											<C> name='�������'     ID='STATUS_CD'  	width=60 align=center Edit=None BgColor={IF(STATUS_CD='RC','#fefec0','' )} editstyle=lookup data='ds_status:detail:detail_nm'  SumText='�ѰǼ�'</C>
											<C> name='��û����ȣ'		ID='accept_no' 		width=80  align=left editlimit=50 show=true</C>
											<C> name='�ѱۼ���'   	ID='cust_nm' 		width=60  align=left editlimit=50 show=true</C>
											<C> name='�������'   	ID='birthday' 		width=60  align=left editlimit=50 show=true</C>
											<C> name='����'   	ID='sex' 				width=30  align=left editlimit=50 show=true</C>
											<C> name='����Ÿ��'   	ID='room_type_cd' 	width=60  align=left editlimit=50 show=true</C>
											<C> name='���ǹ�ȣ'   	ID='room_no' 		width=60  align=left editlimit=50 show=true</C>
											<C> name='��¼���'   	ID='prt_seq' 		width=60  align=left editlimit=50 show=false</C>
											<C> name='���'			ID='desc' 			width=50 show=true </C>
											<C> name='�ּ�'			ID='address' 			width=170 show=true </C>
										">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>		
							</tr>
						</table>
					</td>
				</tr>
				<tr id="total">
					<td width="845px" height="20" class="textbox" style="border:0">

					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<%
/*=============================================================================
			����Ʈ ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=pr1 classid=<%=HDConstant.CT_REPORT_CLSID%>> 
		<PARAM NAME="MasterDataID"          VALUE="ds9">
		<PARAM NAME="DetailDataID"			VALUE="ds9">
		<PARAM NAME="PaperSize"				VALUE="A4">	
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
 		<param NAME="SuppressColumns" 	    VALUE="1:pageskip,page_skip">
		<PARAM NAME="Format"                value="
<B>id=Header ,left=0,top=0 ,right=1999 ,bottom=122 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='����� üũ����Ʈ' ,left=677 ,top=34 ,right=1322 ,bottom=98</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=1999 ,bottom=254 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='��ǰ��' ,left=60 ,top=24 ,right=258 ,bottom=90</T>
	<T>id='�����' ,left=558 ,top=29 ,right=757 ,bottom=95</T>
	<T>id='��������' ,left=1191 ,top=29 ,right=1389 ,bottom=95</T>
	<X>left=47 ,top=100 ,right=1979 ,bottom=209 ,border=true</X>
</B>
<B>id=Default ,left=0,top=0 ,right=1999 ,bottom=129 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=1488 ,top=24 ,right=1488 ,bottom=127 </L>
</B>

		">
</object> 
<%=HDConstant.COMMENT_END%>
<script language=JavaScript for=pr1 event=OnError()>
    alert(pr1.ErrorMsg);
</script>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


