<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 		: �������
 * ���α׷�ID 	: AC720I
 * J  S  P		: ac720i
 * �� �� ��		: Ac720I
 * �� �� ��		: ����ǥ
 * �� �� ��		: 2006-08-14
 * �������		: ��ǰ�� �Ǹ�(��ȸ ��� ���� ����)
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
   	date.add(date.MONTH,-1);
    String lastday = m_today.format(date.getTime());
    String fSaleNo = request.getParameter("fSaleNo");		
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
		 var v_job = '';
		/*
		 * �������ε�
		 */
		function fnOnLoad(tree_idx){
			fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��

			cfStyleGrid(getObjectFirst("gr1"), "comn");
			cfStyleGrid(getObjectFirst("gr2"), "comn");
			sSDate.Text = '<%=lastday%>';	
			sEDate.Text = '<%=firstday%>';	
			fnInit();
			initds1.deleterow(1);
		} 
		 
		function fnInit() {
		v_job=="INIT";
		 ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac720I",
            "JSP(O:initds1=initds1)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1); 
        ds_giftType.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC003";
        ds_giftType.Reset();
		}
				/*
		 * �����ͼ� ��� ���� (������)
		 */	
		function fnSetHeaderDs1(){
			if (ds1.countrow<1){
				var s_temp =  "SALE_NO:STRING,"
							+ "SALE_DATE:STRING,"
							+ "VEND_CD:STRING,"
							+ "VEND_NM:STRING,"
							+ "FOC_GU:STRING,"
							+ "SALE_EMPNO:STRING,"
							+ "EMPNMK:STRING";
				ds1.SetDataHeader(s_temp);
			}
		}
			/*
		 * �����ͼ� ��� ���� (������)
		 */
		function fnSetHeaderDs2(){
			if (ds2.countrow<1){
				var s_temp =  "SALE_NO:STRING,"
							+ "GIFT_TYPE:STRING,"
							+ "GIFT_TYPE_NM:STRING,"
							+ "FR_GIFT_SEQ:STRING,"
							+ "TO_GIFT_SEQ:STRING,"
							+ "SALE_QTY:INT,"
							+ "SALE_PRICE:INT,"
							+ "SALE_AMT:INT";
									
				ds2.SetDataHeader(s_temp);
			}
		}
		/*
		 * ���� ��ȸ(������ ��ȸ, ��������ȸ)
		 */
		function fnSelect(){
		if (ds1.IsUpdated || ds2.IsUpdated) {
				alert("�������� ���� �ֽ��ϴ�.");
				return;
			} 
			fnSelectDs1();
			fnSelectDs2();
		}
		/*
		 * ������ ��ȸ
		 */
		function fnSelectDs1() {
			if(ds1.IsUpdated){
                alert("�������� �����Ͱ� �ֽ��ϴ�.");
			} 
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			          + ",sSDate=" + sSDate.Text
			          + ",sEDate=" + sEDate.Text;
			ln_TRSetting(tr1, 
			    "<%=dirPath%><%=HDConstant.PATH_AC%>Ac720I",
			    "JSP(O:DS1=ds1)",
			    param);
			   
			tr_post(tr1);
		}
		/*
		 * ������ ��ȸ
		 */
		function fnSelectDs2(){
			if(ds2.IsUpdated){
                alert("�������� �����Ͱ� �ֽ��ϴ�.");
                return;
            }
			var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
					  + ",sSaleNo=" + ds1.namevalue(ds1.rowposition,"sale_no");
			ln_TRSetting(tr1,
				"<%=dirPath%><%=HDConstant.PATH_AC%>Ac720I",
				"JSP(O:DS2=ds2)",
				param);
			tr_post(tr1);
			
		}
		/*
		 * ������ �ű� 
		 */
		function fnAddRowDs1(){
			fnSetHeaderDs1();
			 for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.RowStatus(i)==1){
                    if(ds2.CountRow==0){
                        alert("��ǰ��  �Ǹ�����(��)�� ���� ����Ͻñ� �ٶ��ϴ�.");
                        return;
                    }
                }
            }
            
            if(ds1.IsUpdated || ds2.IsUpdated){
                alert("���� �����Ͻñ� �ٶ��ϴ�.");
                return;
            }
            
            ds1.addrow();
            ds2.clearall();
            v_sale_date.Text = '<%=firstday%>';
            fnInit();
            vend_nm.value="";
            empn_mk.value="";
            initds1.deleterow(1);
		}
			/*
		 * ������ ���߰� 
		 */
		function fnAddRowDs2() {
			fnSetHeaderDs2();
			
			
				ds2.addrow();

				ds2.namevalue(ds2.RowPosition, "sale_no") = ds1.namevalue(ds1.rowposition, "sale_no");
				gr2.setcolumn("gift_type");
			
				msgTxt.innerHTML="Detail ���� ���ԵǾ����ϴ�.";
		}
		/*
		 * ������ ���� 
		 * ���� �׼ǽ� �ٷ� ����
		 */
		function fnDeleteRowDs1() {			
			if(ds2.IsUpdated) {
				alert("�������� ���� ������ ������ �� �����ϴ�.");
				return;
			}else{
				if (confirm("�Է��Ͻ� ������ �����Ͻðڽ��ϱ�?")) {
					
					ds1.deleterow(ds1.rowposition);
					ds2.deleteall();
					
					 var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
		                        + ",dsType=1";	
		                        
		            ln_TRSetting(tr1, 
		                "<%=dirPath%><%=HDConstant.PATH_AC%>Ac720I",
		                "JSP(I:DS1=ds1,O:msgDS=msgDS,O:ipgonoDs=ipgonoDs,I:DS2=ds2)",
		                v_param);
		            tr_post(tr1);
					
					msgTxt.innerHTML="Master ���� �����Ǿ����ϴ�.";
				}
			}
		}

		/*
		 * ������ ����� 
		 */
		function fnDeleteRowDs2(){
			ds2.deleterow(ds2.rowposition);
			msgTxt.innerHTML="Detail ���� �����Ǿ����ϴ�.";
		}

		/*
		 * ����
		 * ������ ����� �߰�, ������ ���߰�,���� �� ���� 
		 */
		function fnApply(){
			var v_gift_cnt = 0;
            var v_gift_amt = 0;
            
            if(ds1.IsUpdated==false && ds2.IsUpdated==false){
                alert("����� ������ �����ϴ�.");
                return;
            }
            
            for(var i=1; i<=ds1.CountRow; i++){
                if(ds1.NameValue(i, "SALE_DATE")==""){
                    alert("�Ǹ�����<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("v_sale_date").Focus();
                    return;
                }
                if(ds1.NameValue(i, "FOC_GU")==""){
                    alert("�Ǹű���<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("v_foc_gu").Focus();
                    return;
                }
                if(ds1.NameValue(i, "SALE_EMPNO")==""){
                    alert("�Ǹ���<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("v_sale_empno").focus();
                    return;
                }
                if(ds1.NameValue(i, "VEND_CD")==""){
                    alert("�ŷ�ó<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds1.RowPosition = i;
                    getObjectFirst("v_vend_cd").focus();
                    return;
                }
            }
            
            for(var i=1; i<=ds2.CountRow; i++){
                if(ds2.NameValue(i, "GIFT_TYPE")==0){
                    alert("����<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds2.RowPosition = i;
                    gr2.SetColumn("GIFT_TYPE");
                    return;
                }

                if(ds2.NameValue(i, "FR_GIFT_SEQ")==0){
                    alert("��ǰ�� ���۹�ȣ<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds2.RowPosition = i;
                    gr2.SetColumn("FR_GIFT_SEQ");
                    return;
                }
                if(ds2.NameValue(i, "TO_GIFT_SEQ")==0){
                    alert("��ǰ�� �����ȣ<%=HDConstant.A_MSG_MUST_INPUT%>");
                    ds2.RowPosition = i;
                    gr2.SetColumn("TO_GIFT_SEQ");
                    return;
                }
                if(ds2.NameValue(i, "SALE_QTY")==0){
                    alert("�߸��� ��ǰ�� �Ϸù�ȣ�Դϴ�.");
                    ds2.RowPosition = i;
                    gr2.SetColumn("FR_GIFT_SEQ");
                    return;
                }
                v_gift_cnt += ds2.NameValue(i, "SALE_QTY");
                v_gift_amt += ds2.NameValue(i, "SALE_AMT");
            }
			if (ds1.IsUpdated || ds2.IsUpdated ) {
						v_job=="I";
						msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
				         ln_TRSetting(tr1, 
				             "<%=dirPath%><%=HDConstant.PATH_AC%>Ac720I",
				             "JSP(I:DS1=ds1,O:msgDS=msgDS,O:ipgonoDs=ipgonoDs,I:DS2=ds2)",
				             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1"
				             +",v_gift_cnt="+ v_gift_cnt
				             +",v_gift_amt="+ v_gift_amt);
				         tr_post(tr1);
				}
		}

		/*
		 * ��� 
		 * ������, ������
		 */
		function fnCancel(){
		
			if(ds1.IsUpdated || ds2.IsUpdated) {
				ds1.undoall();
				ds2.undoall();
			}
			msgTxt.innerHTML="������ ������ ��ҵǾ����ϴ�.";
			return;
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
	        getObjectFirst("gr1").SetExcelTitle(1, "value:����Ϻ���Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
	        getObjectFirst("gr1").GridToExcel("����Ϻ���Ȳ","����Ϻ���Ȳ.xls", 8);
		}
  		
    	
	/*
	 * �ŷ�ó
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu004h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
				v_vend_cd.value = arrParam[0];
		    	vend_nm.value = arrParam[1];
				ds1.namevalue(ds1.RowPosition,"vend_cd")=arrParam[0];
                ds1.namevalue(ds1.RowPosition, "vend_nm") = arrParam[1];					
			}
	} 	
	/*
	 * �Ǹ���
	 */ 
	function fnPopup2() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/sy020h.jsp";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
				v_sale_empno.value = arrParam[0];
		    	empn_mk.value = arrParam[1];
				ds1.namevalue(ds1.RowPosition, "sale_empno")=arrParam[0];
				ds1.namevalue(ds1.RowPosition, "empnmk")=arrParam[1];
			}
	} 	
	function fnGiftSelect(Row, Colid, OldData){
            if(Colid=="GIFT_TYPE" || Colid=="FR_GIFT_SEQ" || Colid=="TO_GIFT_SEQ"){
                if(getObjectFirst("ds2").NameValue(Row, "GIFT_TYPE")!=""
                    && getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ")!=""
                    && getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ")!="")
                {
                    if(OldData != getObjectFirst("ds2").NameValue(Row, Colid)){
                        for(var i=getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ").length; i<6; i++)
                            getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ") = "0"+getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ");
            
                        for(var i=getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ").length; i<6; i++)
                            getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ") = "0"+getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ");
            
                        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                                    + ",v_gift_type="+getObjectFirst("ds2").NameValue(Row, "GIFT_TYPE")
                                    + ",v_fr_gift_seq="+getObjectFirst("ds2").NameValue(Row, "FR_GIFT_SEQ")
                                    + ",v_to_gift_seq="+getObjectFirst("ds2").NameValue(Row, "TO_GIFT_SEQ");
                        ln_TRSetting(tr1, 
                            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac720I",
                            "JSP(O:GIFTAMT=ds_giftAmt)",
                            v_param);
                        tr_post(tr1);
                    }
                }
            }
        }
		</script>
		
		
<%
/****************************************************************************
			���콺 �̺�Ʈ ��ũ��Ʈ
******************************************************************************/
%>
<!-- 
		������ �׸��� OnClick
	-->
	<script language="javascript" for="tr1" event="onsuccess()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>

	<script language="javascript" for="tr1" event="onfail()">
    document.all.LowerFrame.style.visibility="hidden";
    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_ERR%>";         
    var error_cnt = tr1.SrvErrCount("ERROR");
    var error_msg = "";
    for(var i=0; i<error_cnt; i++){
        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
    }
    if(error_msg!="") 
        alert(error_msg);
    else
        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	</script>
	<script language="javascript" for="tr2" event="onsuccess()">
	    document.all.LowerFrame.style.visibility="hidden";
	    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_DONE%>";
	</script>
	
	<script language="javascript" for="tr2" event="onfail()">
	    document.all.LowerFrame.style.visibility="hidden";
	    msgTxt.innerHTML="<%=HDConstant.S_MSG_SAVE_ERR%>";         
	    var error_cnt = tr2.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr2.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert(error_msg);
	    else
	        alert("Error Code : " + tr2.ErrorCode + "\n" + "Error Message : " + tr2.ErrorMsg + "\n");
	</script>
	<script language="javascript"  for=gr1 event=OnClick(Row,Colid)>
		if (ds1.IsUpdated || ds2.IsUpdated) {
			
		} else {
			fnSelectDs2();
		}
	</script>
	

	<script language=JavaScript for=ds1 event=OnRowPosChanged(row)>
		if (row < 1) {
			return;
		}
		
		if (ds1.namevalue(ds1.rowposition , "sub_chk") == "Y") {
			fnSubSelect();
		}
	</script>
	<script language="javascript" for="gr2" event="OnCloseUp(Row, Colid)">
	    if(Row==0) return;
	    fnGiftSelect(Row, Colid, ds2.OrgNameValue(Row, Colid));
	</script>
	<script language="javascript" for="gr2" event="OnExit(Row, Colid, OldData)">
    if(Row==0) return;
    fnGiftSelect(Row, Colid, OldData);
	</script>
	<script language="javascript" for="ds_giftAmt" event="OnLoadCompleted(row)">
    getObjectFirst("ds2").NameValue(getObjectFirst("ds2").RowPosition, "SALE_QTY") = getObjectFirst("ds_giftAmt").NameValue(row, "PAY_QTY");
    getObjectFirst("ds2").NameValue(getObjectFirst("ds2").RowPosition, "SALE_AMT") = getObjectFirst("ds_giftAmt").NameValue(row, "PAY_AMT")*1000;
	</script>
	<script language=javascript for=ds2_result event="OnLoadCompleted(Row)">
	    if(ds2_result.CountRow>0){
	        for(var i=1, j=1; i<=ds1.CountRow; i++){
	            if(ds1.RowStatus(i)==1){
	                ds1.NameValue(i, "SALE_NO") = ds2_result.NameValue(j, "SALE_NO");
	                
	                for(var k=1; k<=ds_detail.CountRow; k++){
	                    if(ds2.NameValue(k, "SALE_NO")=="")
	                        ds2.NameValue(k, "SALE_NO") = ds1.NameValue(i, "SALE_NO")
	                }
	                j++;
	            }
	        }
	    }
	    ds_master.ResetStatus();
	    
	    fnApplyDs2();
	</script>
	<script language=javascript for=msgDS event="OnLoadCompleted(Row)">
    var v_result_msg = "";
    if(msgDS.CountRow>0){
        for(var i=1; i<=ds_detail_result.CountRow; i++){
            if(msgDS.NameValue(i, "MSG_CD")!="0000")
                v_result_msg = msgDS.NameValue(i, "MSG")+"\n";
        }
    }
    if(v_result_msg!="")
        alert(v_result_msg);
	</script>

	<script language=javascript for=ipgonoDs event="OnLoadCompleted(Row)">
		if(Row==0) return;
		ds1.NameValue(ds1.RowPosition, "sale_no") = ipgonoDs.NameValue(1, "SALE_NO");
		ds1.ResetStatus();
	</script>
<%
/*******************************************************************************
			���콺 ������Ʈ  Dataset , TR ����
*******************************************************************************/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=initds1 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��  -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ���� -->
    <param name="SyncLoad"  value=false>
</object>
<object id=ipgonoDs classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��ǰ -->
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_giftType classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����ڵ� -->
    <param name="SyncLoad"  value="true">
</object>
<object id=ds_giftAmt classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="True">
</object>
<object id=ds2_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
	
<table  width="845px"  cellpadding="0" cellspacing="0" >

		<tr>
			<td align="left">
				<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
					<tr height="50px" > 
						<td align="left"  width="355px">
							<table border="0"  bgcolor="#666666"  cellspacing="1"  align="left" width="300">
						
								<tr  bgcolor="#6f7f8d" align="left">
									<td align=left class="text"  width="60">��&nbsp;��&nbsp;��</td>
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
										</object>&nbsp;~&nbsp;
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
								</tr>
							 
							</table>
						</td>
						
						<td align="right">
							<table border="0"  cellpadding="0" cellspacing="0" width="100%">
								<tr>
									<td align="right" height="30px">		
										<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:pointer" onclick="fnSelect()">
										<img src="<%=dirPath%>/Sales/images/new.gif"	style="cursor:pointer" onClick="fnAddRowDs1()" >
										<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
										<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer"  onclick="fnCancel()">
										<img src="<%=dirPath%>/Sales/images/delete.gif"  style="cursor:pointer" onClick="fnDeleteRowDs1();" >
						 			</td>
								</tr>
							</table>
						</td>
					</tr>
				</table>	
			</td>											
		</tr>
		<tr height="5">
			<td></td>
		</tr>			
		<tr>
			<td align="left">
				<table  width="845px"  cellpadding="0" cellspacing="0">
					<tr>
						<td colspan="5"  align="left">
							<table width="845px" border="0" cellpadding="0" cellspacing="0" >
								<tr>
									<td align="left" valign="top" width="300px" >
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: �з��ڵ� �˻�  
	�׸�			: �з��ڵ�, �з��ڵ��
	Object ID 	: �׸��� gr1
	Data ID		: ds1
-----------------------------------------------------------------------------*/
%>												
										<%=HDConstant.COMMENT_START%>
										<object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49  id=gr1  style="width=300px; height:383px" border="1">
											<param name="DataID"		VALUE="ds1">
	                            			<param name="BorderStyle"   VALUE="0">
	                            			<param name=ColSizing       value="true">
	                            			<param name="editable"      value="false">
	                            			<param name=UsingOneClick  	value="1">
	                            			 <param name="SuppressOption"    value="1">
	                                        <Param Name="AllShowEdit"   value="True">
	                                        <param name="SortView"      value="Right">
											<param name="Format"		value="  
												 <C> name='�Ǹ�����'		    ID='sale_date'   align=left editlimit=8 width=100 show=true mask=XXXX-XX-XX  suppress=1</C>
												 <C> name='�ǸŹ�ȣ'      	ID='sale_no'     align=right editlimit=20 width=100 show=true</C>
												 <C> name='�ŷ�ó�ڵ�'      	ID='vend_cd'     align=left editlimit=13 show=false</C>
												 <C> name='�ŷ�ó��'      	ID='vend_nm'     align=left editlimit=62 show=false</C>
												 <C> name='FOC ����'       	ID='foc_gu'      align=left editlimit=1  show=false</C>
												 <C> name='�Ǹ��ڻ��'   		ID='sale_empno'  align=left editlimit=7  show=false</C>
												 <C> name='�Ǹ��ڼ���'       	ID='empnmk'      align=left editlimit=20 show=false</C>											
											">
										</object>
										<%=HDConstant.COMMENT_END%>	
									</td>
									<td width="10px"></td>
									<td valign="top">
										<table width="530px" cellpadding="0" cellspacing="0" >
											<tr>
												<td align="center">
													<table width="530px" border="0" cellpadding="0" cellspacing="1" bgcolor="#666666">
														<tr>
															<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�� �� �� ��</td>
																<td align=left bgcolor="#ffffff" width="160">&nbsp;																							
																<%=HDConstant.COMMENT_START%>
																<object id=v_sale_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=65 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:65px; height:17px;">			
																	<param name=Alignment 	value=1>
																	<param name=Format 		value="0000-00-00">
																	<param name=Cursor	 	value="iBeam">
																	<param name=Border	 	value="false">		
																	<param name=InheritColor      value="true">																																																				
																	<param name=ReadOnly  	value="false">
																	<param name=SelectAll  	value="true">
																	<param name=SelectAllOnClick  	value="true">		
																	<param name=SelectAllOnClickAny   value="false">
																</object>
																<%=HDConstant.COMMENT_END%>	
															</td>
															<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�� �� �� ȣ</td>
															<td align=left bgcolor="#ffffff">&nbsp;
															<%=HDConstant.COMMENT_START%>
		                                                    <object id=v_sale_no classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=70 align=center class="textbox">            
		                                                        <param name=Alignment   value=1>
		                                                        <param name=Format      value="000000-000">
		                                                        <param name=Cursor      value="iBeam">
		                                                        <param name=Border      value="false">
		                                                        <param name=InheritColor      value="true">
		                                                        <param name=Enable      value="false">
		                                                        <param name=SelectAll   value="true">
		                                                        <param name=SelectAllOnClick    value="true">
		                                                        <param name=SelectAllOnClickAny   value=false>
		                                                    </object>
		                                                    <%=HDConstant.COMMENT_END%>
														</tr>
														<tr>
															<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">��&nbsp; &nbsp;��&nbsp;&nbsp;��</td>
															<td height="25px"  bgcolor="#FFFFFF" align="left" colspan="">&nbsp;
																<input id="v_sale_empno" type="text" readonly='readonly'  class='input01'    value="" size="8">
																<img src="<%=dirPath%>/Sales/images/help.gif" border="0" id="empno_btn"  ALT="�Ǹ��ڸ� �˻��մϴ�" style="cursor:pointer;position:relative;left:-0px;top:0px" align=absmiddle onclick="fnPopup2();">
																 <input type="text" name='empn_mk' id='empn_mk' value='' size='8' readonly='readonly'  class='input01'>
															</td>
															<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">FOC&nbsp;&nbsp;��&nbsp;&nbsp;��</td>
															  <td align=left bgcolor="#ffffff">&nbsp;																										
			      												<%=HDConstant.COMMENT_START%>
									                            <object id=v_foc_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=120 border="0" align=absmiddle>
																	<param name=ComboDataID		value=initds1>
																	<param name=BindColumn      value="detail">
			                                                        <param name=BindColVal      value="detail">
																	<param name=EditExprFormat	value="%,%;head,detail_nm">
																	<param name=ListExprFormat  value="detail_nm^0^120"></object>
																<%=HDConstant.COMMENT_END%>
															</td>
														</tr>
														<tr>
															<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">��&nbsp; &nbsp;��&nbsp;&nbsp;ó</td>
															<td height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
																<input id="v_vend_cd" type="text" readonly='readonly'  class='input01'    value="" size="11">
																<img src="<%=dirPath%>/Sales/images/help.gif" border="0" id="empno_btn"  ALT="�ŷ�ó�� �˻��մϴ�" style="cursor:pointer;position:relative;left:-0px;top:0px" align=absmiddle onclick="fnPopup();">
																 <input type="text" name='vend_nm' id='vend_nm' value='' size='20' readonly='readonly'  class='input01'>
															</td>
														</tr>	
													</table>
												</td>
											</tr>
											<tr>
												<td height="7">
												<tr>
													<td align="right" height="30px">
													<img src="<%=dirPath%>/Sales/images/plus.gif"	 style="cursor:pointer"  onClick="fnAddRowDs2();" >
													<img src="<%=dirPath%>/Sales/images/minus.gif"		style="cursor:pointer" onClick="fnDeleteRowDs2();"></td>
												</tr>
												</td>
											</tr>
										
											<tr>
												<td height="5"></td>
											</tr>
<%
/*---------------------------------------------------------------------------->
	HTML Desc	: ���ڵ� 
	�׸�			: �ڵ�, �ڵ��, �Ӽ� 1 - 15 
	Object ID 	: �׸��� gr2
	Data ID		: ds2
-----------------------------------------------------------------------------*/
%>																						
											<tr>
												<td align="left" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
													<%=HDConstant.COMMENT_START%>
														<object classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" id="gr2"  style="WIDTH:530px;HEIGHT:263px" border="1">
															 <param name="DataID"            value="ds2">
					                                            <param name="ColSizing"         value="true">
					                                            <param name="Editable"          value="true">
					                                            <param name="SuppressOption"    value="1">
					                                            <param name="BorderStyle"       value="0">
					                                            <param name=UsingOneClick       value="1">
					                                            <Param Name="AllShowEdit"       value="True">
					                                            <param name="ViewSummary"       value="1">
					                                            <param name="Format"            value="
					                                            <C> name=''				ID={currow}				width=30</C>
															    <C> name='�ǸŹ�ȣ'      	ID='SALE_NO'     		align=left editlimit=20 show=false sumbgcolor=#E0CFE4</C>
																<C> name='����'       	ID='GIFT_TYPE'  	    Width=120 	SumText='�ݾ�' align=left editlimit=1 show=true align=left EditStyle=Lookup Data='ds_giftType:detail:detail_nm'</C>
																<C> name='��ǰ�� ������' 	ID='GIFT_TYPE_NM'       align=left editlimit=50 show=false </C>
																<C> name='���ۻ�ǰ�ǹ�ȣ' 	ID='FR_GIFT_SEQ'        align=right editlimit=6 width=100 show=true</C>
																<C> name='�����ǰ�ǹ�ȣ' 	ID='TO_GIFT_SEQ'        align=right editlimit=6 width=100 show=true</C>
																<C> name='�ż�'     		ID='SALE_QTY'    		SumText=@sum width=60  align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0</C>
																<C> name='�ǸŴܰ�'   	ID='SALE_PRICE'  		align=left editlimit=8 show=false/C>
																<C> name='�ݾ�'     	ID='SALE_AMT'    		SumText=@sum width=115 align=right Edit=None bgcolor='<%=HDConstant.GRID_ITEM%>' dec=0</C>
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
			</td>												
		</tr>
	</table>												 


<input type="hidden" name="row" value="">	
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>	
<%=HDConstant.COMMENT_START%>
<object  id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>> 
	<param name=DataID    value=ds1>
	<param name=BindInfo  value='  
		 <C>Col=sale_no          Ctrl=v_sale_no            Param=Text </C>
		 <C>Col=sale_date        Ctrl=v_sale_date          Param=Text </C>
		 <C>Col=vend_cd          Ctrl=v_vend_cd            Param=value </C>
		 <C>Col=vend_nm          Ctrl=vend_nm            Param=value </C>
		 <C>Col=foc_gu           Ctrl=v_foc_gu             Param=BindColVal</C>
		 <C>Col=sale_empno       Ctrl=v_sale_empno         Param=value </C>
		 <C>Col=empnmk           Ctrl=empn_mk             Param=value </C>
	'>
</object>
<%=HDConstant.COMMENT_END%>  

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		


