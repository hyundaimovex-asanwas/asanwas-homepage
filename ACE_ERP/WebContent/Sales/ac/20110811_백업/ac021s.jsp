<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸�		: ����Ϻ� ��Ȳ
 * ���α׷�ID 	: AC020S
 * J  S  P		: ac020s
 * �� �� ��		: Ac020S
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-07-27
 * �������		:
 * ��������		: AC001	 	�Աݰ����ڵ�
 * ��������		: AC001	010	����
 * ��������		: AC001	020	�������
 * ��������		: AC001	030	������ü
 * ��������		: AC001	040	�ſ�ī��
 * ��������		: AC001	050	���ͳ�(ī)
 * ��������		: AC001	060	��ǰ��
 * ��������		: AC001	070	�ܻ�
 * ��������		: AC001	080	�������Ա�
 * ��������		: AC001	090	��Ÿ��ü
 * ��������		: AC001	100	������
 * ��������		: AC001	110	������ȯ��
 * ��������		: AC001	910	�����ݾ�1
 * ��������		: AC001	920	�����ݾ�2
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2007-10-30][�ɵ���] ������, �¶���ī�� �÷� �߰� 
 * [2008-11-04][�ڰ汹] ��汸�� ��ȸ���� => ������� ��ȸ�������� ����
 * [2008-11-05][�ڰ汹] ��汸�� ��ȸ���� => ��������� �����߰�
 * [2010-04-21][�ɵ���] ���ް���, �ΰ��� �÷� �߰�~
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
		// �������ε�
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr_main"), "comn");
			sSDate.Text = '<%=firstday%>';	
			sEDate.Text = '<%=firstday%>';	
			fnInit();

		} 
		 
		function fnInit() {
			div = 'init';
        
			ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
			ds_saup.Reset(); //�����ڵ�
			//������
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010I",
	            "JSP(O:CUSTALL=ds_custGu)",
	            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
	        tr_post(tr1);
	        
	        //���������
        	ds_saldam.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
	        ds_saldam.Reset();
	        
	        //�������
       		ds_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=RV001&s_item1=Y";
            ds_status.Reset();	
        
	        // ������ ���������� default
	        getObjectFirst("lc_custGu").index = 1; 
	        
		}
		
		
		
		// ���� ��ȸ
		function fnSelect() {
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					  + ",sSalDamSid=" + sSalDamSid.value
			          + ",sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			          + ",sGoods_sid=" + lc_goods.ValueOfIndex("goods_sid", lc_goods.Index)
		              + ",sClient_sid=" + sClientSid.value
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text
			          + ",v_status=" + v_status.ValueOfIndex("detail", v_status.Index)
   			          + ",sCustGu=" + lc_custGu.ValueOfIndex("detail", lc_custGu.Index);
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac020S",
			    "JSP(O:DS1=ds_g_main)",
			    param);
			    
			   // prompt('',param);
			   
			tr_post(tr1);
		}
			
		// ����
		function fnExcelds_g_main() {
			if(ds_g_main.RowCount==0){
	            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
	            return;
	        } 
	        getObjectFirst("gr_main").SetExcelTitle(0, "");
	        getObjectFirst("gr_main").SetExcelTitle(1, "value:����Ϻ���Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr_main").GridToExcel("����Ϻ���Ȳ","����Ϻ���Ȳ.xls", 8);
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
	    
	    
	    //��������� �˾�
		function fnPopup4() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy005h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sSalDamSid.value = arrParam[0];
				sSalDamCd.value = arrParam[1];
				sSalDamNm.value = arrParam[2];
			} else {
		    	sSalDamSid.value = 0;
				sSalDamCd.value = '';
				sSalDamNm.value = '';
			}
		}
	
	    
		//�˻����� �븮��  �˾� 
	    function fnResultPop(gubun) {
	        
	        var arrParam    = new Array();
	        var arrResult   = new Array();
	       
	        var param = "&sSaup_sid="+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
			                 + "&sGoods_sid=" + ds_g_main.namevalue(ds_g_main.rowposition, "goods_sid")
		                     + "&sClient_sid=" + ds_g_main.namevalue(ds_g_main.rowposition, "client_sid")
			                 + "&sSDate=" + ds_g_main.namevalue(ds_g_main.rowposition, "depart_date")
			                 + "&sUpjang_sid=" + ds_g_main.namevalue(ds_g_main.rowposition, "upjang_sid")
			                 + ",sCustGu=" + lc_custGu.ValueOfIndex("detail", lc_custGu.Index)
							 + ",v_status=" + v_status.ValueOfIndex("detail", v_status.Index);
          
			if (gubun == "020") {			//�������
				var strURL = '<%=dirPath%>/Sales/help/ac020_1h.jsp?dsType=1' + param;
			} else if (gubun == "030") {	//������ü
				var strURL = '<%=dirPath%>/Sales/help/ac020_2h.jsp?dsType=2' + param;
			} else if (gubun == "040") {	//�ſ�ī��edi
				var strURL = '<%=dirPath%>/Sales/help/ac020_3h.jsp?dsType=3' + param;
			} else if (gubun == "050") {	//�¶���ī��
				var strURL = '<%=dirPath%>/Sales/help/ac020_9h.jsp?dsType=3' + param;
			} else if (gubun == "060") {	//��ǰ��
				var strURL = '<%=dirPath%>/Sales/help/ac020_4h.jsp?dsType=4' + param;
			} else if (gubun == "080") {	//�������Ա�. dsType ������ �״� �ǹ� ����̴µ�;; ��..
				var strURL = '<%=dirPath%>/Sales/help/ac020_5h.jsp?dsType=5' + param;
			} else if (gubun == "090") {	//��Ÿ��ü
				var strURL = '<%=dirPath%>/Sales/help/ac020_6h.jsp?dsType=6' + param;
			} else if (gubun == "100") {	//������
				var strURL = '<%=dirPath%>/Sales/help/ac020_8h.jsp?dsType=6' + param;
			} else if (gubun == "3") {		//ȯ��
				var strURL = '<%=dirPath%>/Sales/help/ac020_7h.jsp?dsType=6' + param;
			} else if (gubun == "4") {		//ȯ��
				var strURL = '<%=dirPath%>/Sales/help/ac020_7h.jsp?dsType=6' + param;
			};

//			prompt("",strURL);
		    var strPos = "dialogWidth:820px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		    arrResult = showModalDialog(strURL,arrParam,strPos); 
		   
		//   window.open(strURL, 'test', strPos);
	    
	    } 

		//��ǰ��ȸ
		function fnSelectLcGoods() {
			window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";	
			var param = "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1"
				    + ",sSaupSid=" + lc_saup.ValueOfIndex("saup_sid", lc_saup.Index)
					+ ",sDepartDate=";
			ln_TRSetting(tr2, 
			    "<%=dirPath%><%=HDConstant.PATH_HELP%>CommonH",
			    "JSP(O:S_GOODS_DS=ds_goods)",
			    param);
			tr_post(tr2);
		};
		
	   //�ڵ����� ���������
	   function fnSetting(dataSet) {
	      var exit=false;
	      if ( dataSet == 'ds_saldam' ) {  //�븮��
	         for ( i=1; i<=ds_saldam.CountRow; i++ ) {
	            if ( ds_saldam.namevalue(i,"sal_dam_cd") == sSalDamCd.value ) {
	               sSalDamNm.value = ds_saldam.namevalue(i,"sal_dam_nm");
	               sSalDamSid.value = ds_saldam.namevalue(i,"sal_dam_sid");
	               exit=true;
	               return;
	            }
	         }
	         if ( exit != true ) {
	               sSalDamNm.value = ds_saldam.namevalue(i,"sal_dam_nm");
	               sSalDamSid.value = ds_saldam.namevalue(i,"sal_dam_sid");
	         }
	      }
	   }		
		</script>
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
		<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
			fnSelectLcGoods();
		</script>
		
		<script language=JavaScript for=lc_saup event=OnSelChange()>
			fnSelectLcGoods();//��ǰ ��˻�
		</script>
		<script language="javascript" for="tr1" event="onsuccess()">
			window.status="�۾��� ���������� �Ϸ�Ǿ����ϴ�.";
		</script>	
	
		<script language=JavaScript for=sSDate event=OnKillFocus()>
		   if( sSDate.Modified == true )
				sEDate.text = sSDate.text;
		</script>	
	
		<script language=JavaScript for=gr_main event=OnLButtonDblClk(row,colid,xpos,ypos)>
			if (colid == "a_amt") {
			
				if (ds_g_main.namevalue(ds_g_main.rowposition, "a_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('020');
			} else if (colid == "b_amt") {
				if (ds_g_main.namevalue(ds_g_main.rowposition, "b_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('030');
			} else if (colid == "c_amt") {	//�ſ�ī��
				if (ds_g_main.namevalue(ds_g_main.rowposition, "c_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('040');
			} else if (colid == "h_amt") {	//�¶���ī��
				if (ds_g_main.namevalue(ds_g_main.rowposition, "h_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('050');
			} else if (colid == "d_amt") {
				if (ds_g_main.namevalue(ds_g_main.rowposition, "d_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('060');
			} else if (colid == "e_amt") {	//�������Ա�
				if (ds_g_main.namevalue(ds_g_main.rowposition, "e_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('080');
			} else if (colid == "f_amt") {	//��Ÿ��ü
				if (ds_g_main.namevalue(ds_g_main.rowposition, "f_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('090');		
			} else if (colid == "g_amt") {	//�����ݴ�ü
				if (ds_g_main.namevalue(ds_g_main.rowposition, "g_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('100');
			}else if (colid == "refund_amt") {	//ȯ��
				if (ds_g_main.namevalue(ds_g_main.rowposition, "refund_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('3');				
			}else if (colid == "fund_amt") {	//ȯ��
				if (ds_g_main.namevalue(ds_g_main.rowposition, "fund_amt") == 0) {
					alert("��ȸ�� ������ �����ϴ�!");
					return;
				}
				fnResultPop('4');				
			}
		</script>


<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_g_main classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_custGu classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������ -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_saldam classid=<%=HDConstant.CT_DATASET_CLSID%>><!--  ���������  -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ������� -->
    <param name="SyncLoad"  value="True">
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
			<td width='845px'>
				<table  border='0' cellpadding='0' cellspacing='0' width='845'>
					<tr>
						<td>
							<table border='0' celpadding='0' cellspacing='1' width='605' bgcolor='#666666'>
								<tr>
									<td align=center width=65 class="text">���������</td>
                                	<td align=left bgcolor="#ffffff">&nbsp;
										<input id="sSalDamSid" type="hidden" value="0">
										<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
										<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="��������ڸ� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
										<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>
									</td>
								     <td align=center class="text" width="60">�������</td>
                                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
                                        <object id=v_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=200 width=70 border="0" align=absmiddle>
                                            <param name=ComboDataID     value=ds_status>
                                            <param name=ListExprFormat  value="detail_nm^0^70">
                                        </object>
                                        <%=HDConstant.COMMENT_END%>
                                    </td>
			                        <td align="center" width="60px" height="30px" class="text">������</td>
										<td align="center" bgcolor="#ffffff">
											<%=HDConstant.COMMENT_START%>
											<object id=lc_custGu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
												<param name=ComboDataID		value=ds_custGu>
												<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
												<param name=ListExprFormat  value="detail_nm^0^100">
											</object>
											<%=HDConstant.COMMENT_END%>	
									</td>
								</tr>
							</table>
						</td>
						<td>
							<table  border='0' cellpadding='0' cellspacing='0'>
								<tr>
								
									<td align='CENTER'>
										<img src="<%=dirPath%>/Sales/images/refer.gif"  	style="cursor:hand"	align=absmiddle onclick="fnSelect()"> 		<!-- ��ȸ -->
										<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	align=absmiddle onClick="fnExcelds_g_main()">		<!-- ���� -->
									</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr height="5px">
			<td></td>
		</tr>
		<tr height="30px">
			<td width='845px'>
				<table border='0' cellpadding='0' cellspacing='1' width='845' bgcolor="#666666">
					<tr height='30px'>
						<td align=left class="text" width="60px">����</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																										
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_saup>
								<param name=BindColumn      value="saup_sid">
	                            <param name=BindColVal      value="saup_sid">
								<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
								<param name=ListExprFormat  value="saup_nm^0^120">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>	
						<td align="center" width="60px" height="30px" class="text" >�븮��</td>
						<td align="left"  bgcolor="#ffffff" colspan="3">&nbsp;
                            <input type="text" name='sClientNm' id='sClientNm' value='' size='10' readonly='readonly'  class='textbox'>
                            <input type="hidden" name='sClientSid' id='sClientSid' value=''>
                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:hand"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
						</td>
						<td align=left class="text"  width="60">�������</td>
	                    <td align=left bgcolor="#ffffff">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
							<object id=sSDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">		
								<param name=SelectAllOnClickAny   value="false">
 
																											
							</object>~
						
	                       	<object id=sEDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
								<param name=Text 		value="">
								<param name=Alignment 	value=1>
								<param name=Format 		value="0000-00-00">
								<param name=Cursor	 	value="iBeam">
								<param name=Border	 	value="false">		
								<param name=InheritColor      value="true">																																																				
								<param name=ReadOnly  	value="false">
								<param name=SelectAll  	value="true">
								<param name=SelectAllOnClick  	value="true">	
								<param name=SelectAllOnClickAny   value="false">
 
																												
							</object>&nbsp;
							<%=HDConstant.COMMENT_END%>																				
						</td>																							
						<td align=left class="text" width="80">��ǰ����</td>
	                    <td align=left bgcolor="#ffffff" valign="middle">&nbsp;																							
							<%=HDConstant.COMMENT_START%>
	                        <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=160 width=140 border="0" align=absmiddle>
								<param name=ComboDataID		value=ds_goods>
								<param name=BindColumn      value="goods_sid">
	                            <param name=BindColVal      value="goods_sid">
								<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
								<param name=ListExprFormat  value="goods_nm^0^140"></object>
							<%=HDConstant.COMMENT_END%>&nbsp;	
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
							<%=HDConstant.COMMENT_START%>
							<object id=gr_main classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='370px' border='1'>
								<param name="DataID"		value="ds_g_main">
								<param name="ColSizing"		value="true">
								<param name="Fillarea"		value="false">
								<param name="Editable"		value="false">
								<param name="BorderStyle"	value="0">
								<param name=SortView  		value="Left">
								 <param name="SuppressOption"    value="1">
								 <param name=ViewSummary     value=1>
								<param name="Format" 			value="
									
									<C> name='�������'   	ID='depart_date' width=70 	align=center editlimit=61 show=true suppress=1 mask='XXXX-XX-XX' SumText='�հ�'</C>
									<C> name='��ǰ'   		ID='goods_nm'  	width=100 	align=left editlimit=61 show=true suppress=2 </C>
									<C> name='�븮��'   	ID='client_nm'  width=100 	align=left editlimit=61 show=true suopress=3</C>
									<C> name='�������'    	ID='STATUS_CD'  width=60 	align=left Edit=None</C>
									<C> name='������'   	ID='upjang_nm'  width=100 	align=left editlimit=61 show=true </C>
									<C> name='�ο���'   	ID='p_cnt'  	width=40 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right</C>
									<C> name='�����'   	ID='tour_amt'  	width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
					                <C> name='���ް���'     ID='supp_amt' 	width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
					                <C> name='�ΰ���'      	ID='tax_amt' 	width=100 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>

									<C> name='�����'   	ID='sale_amt'  	width=100	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='�Աݾ�'   	ID='pay_amt'  	width=100 	align=right editlimit=61 show=true  SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='�ܻ�����'   ID='credit_amt' width=100	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='���Ծ�'       ID='over_amt'   width=100	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								<G>	name='�Աݾ� ��'
									<C> name='�������'   	ID='a_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='�ſ�ī��'   	ID='c_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='�¶���ī��' 	ID='h_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='��ǰ��'		ID='d_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
		                            <C> name='�������Ա�'	ID='e_amt'      width=80    align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
		                            <C> name='��Ÿ��ü'		ID='f_amt'      width=80    align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='������'		ID='g_amt'  	width=80 	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
								</G>
									<C> name='������ȯ�Ծ�' ID='fund_deposit_amt'  width=80	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='ȯ�Ҿ�'       ID='refund_amt' width=80	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='ȯ�Ծ�'       ID='fund_amt'  	width=80	align=right editlimit=61 show=true SumText=@sum SumTextAlign=right decao=0</C>

									<C> name='������ü'   	ID='b_amt'  	width=80 	align=right editlimit=61 show=false SumText=@sum SumTextAlign=right decao=0</C>
									<C> name='��ǰ'			ID='goods_cd'  	width=100 	align=left editlimit=61 show=false</C>
									<C> name='������'		ID='upjang_cd'  	width=100 	align=left editlimit=61 show=false</C>
               					">
							</object>
							<%=HDConstant.COMMENT_END%>		
						</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>�� ��ǰ>�븮��>������ ���� ����ǹǷ� ��汸�� ���� GRID�� ǥ�õ��� �ʽ��ϴ�.<BR>
			���������� �� ������Ȳ�� ���÷��� [Ȩ>��������>�������>���� ����>���� ������Ȳ]�� �������ּ���.

			</td>
		</tr>
	</table>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

