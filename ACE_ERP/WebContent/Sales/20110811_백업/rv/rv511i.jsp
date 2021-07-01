<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���/ȯ��
 * ���α׷�ID 	 : RV510I
 * J  S  P		 : rv511i
 * �� �� ��		 : RV511I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-08-09
 * �������		 : ���/ȯ�� (��ȸ, ����, ���)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-06-20][�ɵ���] �����κ� ���� ����. �۱����� ǥ�� �ٽ� üũ 
 * [2009-11-17][�ɵ���] ������ ��� ����ڶ� [ȯ��]�� �����ϵ���!
 * [2010-06-08][�ɵ���] ȯ�ҿ�û�� ��½� [ȯ������] ���¸�! (���ν��� ������)
 *						���μ������� ȯ�ҿ�û���� ������ؾ��� ���
 *						�����ش� ��û�������¸� �����(�̿���)�� �������� �� ���
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
   java.text.SimpleDateFormat m_today = new java.text.SimpleDateFormat("yyyyMMddHHmm");
   String firstday = m_today.format(date.getTime()).substring(0,8);
   String firsttime = m_today.format(date.getTime()).substring(8,12);
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
		if (selectImgDs.countrow < 1){
			var s_temp1 = "PICTURE_INFO:STRING";
			selectImgDs.SetDataHeader(s_temp1);
		}
	}
	/*
	 * ����ȸ
	 */
	function fnInit(){
		sBgnDate.text='<%=firstday%>';
		sEndDate.text='<%=firstday%>';

        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
		fnSetHeader();

        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";

        ln_TRSetting(tr2,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv510I",
            "JSP(O:IMAGE=imgDs,O:CLIENTINFO=ds_client_info)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);
        
		ds_saup.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy003H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_UseYn=Y";
		ds_saup.Reset(); //������
        //���������
        ds_saldam.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_saldam.Reset();
        //�븮��
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();
        //�۾�����1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status1.Reset();
        //�۾�����2
        ds_status2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_item1=Y";
        ds_status2.Reset();
        //������
        ds_charge.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV027&s_item1=Y";
        ds_charge.Reset();
        //�۱�����
        ds_bancod.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC002&s_item1=Y";
        ds_bancod.Reset();
        //�۾�����
        codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV030&s_item1=Y";
        codeDs1.Reset();
        //�۾�����(�˻�)
        codeDsSrch.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=2&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV030&s_item1=Y";
        codeDsSrch.Reset();

	}
	/*
	 * ������ȸ
	 */
    function fnSelect() {
		if (ds1.isUpdated ) {
			alert("�������� ���� �ֽ��ϴ�.");
			return;
		}
        window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
        v_job = "S";
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1,"
            + "sSaup_sid="	+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index) + ","
		    + "sGoods_sid="	+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index) + ","
            + "sSalDamSid=" + sSalDamSid.value + ","
            + "sClientSid=" + sClientSid.value + ","
            + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + ","
            + "sBgnDate=" + sBgnDate.text + ","
            + "sEndDate=" + sEndDate.text + ","
            + "sAcceptNo=" + sAcceptNo.text + ","
            + "sCustNm=" + sCustNm.value +","
            + "sDpBgnDate=" + sDpBgnDate.text + ","
            + "sDpEndDate=" + sDpEndDate.text + ","            
            + "sJobType=" + codeDsSrch.namevalue(codeDsSrch.rowposition,"detail") ;

		imgDs.ClearAll();
        ln_TRSetting(tr1,
            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv511I",
            "JSP(O:DS1=ds1,O:IMAGE=imgDs)",
            param);
        tr_post(tr1);
    }
	// ����

	function fnApply() {
		if ( ds1.isUpdated || imgDs.isUpdated ) {
			for ( i=1; i<= ds1.CountRow; i++ )  {		
				//alert(ds1.namevalue(i,"job_type") );
				if(ds1.namevalue(i,"accept_sid") == '' || ds1.namevalue(i,"accept_sid") == '0' ) {
					alert("��û�� ��ȣ�� �Է��� �ּ���.");
					return;
				}			
				if(ds1.namevalue(i,"rsv_sid") == '' || ds1.namevalue(i,"rsv_sid") == '0' ) {
					alert("������ �Է��� �ּ���.");
					return;
				}
				if(ds1.namevalue(i,"charge_cd") == '' || ds1.namevalue(i,"charge_cd") == '0' ) {
					alert("ȯ�� �����ڵ带 �������� �ʾҽ��ϴ�. ������ �����ڵ带 �������ּ���.");
					lc_charge.focus();
					return;
				};
				
				if(ds1.namevalue(i,"charge_cd")=='51') { <%//Ȯ�ο�û���δ� ����(����)�� �� ����%>
					alert("����='Ȯ�ο�û'���� �����Ͻ� �� �����ϴ�.");
					lc_charge.focus();
					return;
				};


				if(ds1.namevalue(i,"status_nm")=='���'&&ds1.namevalue(i,"job_type")!='3') { <%//Ȯ�ο�û���δ� ����(����)�� �� ����, ȯ�Ҹ� ����.%>
					alert('"'+ds1.namevalue(i,"cust_nm")+'"���� �������="���"�̹Ƿ� �۾�����=[ȯ��]�� �����մϴ�.\n\n�븮�� �� ���Ի繫�ҿ� Ȯ�� �� "��û���"���ּ���.');
					return;
				};
			};				
//				alert("gogo");
	        v_job = "I";
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";

	         ln_TRSetting(tr1,
	             "<%=dirPath%><%=HDConstant.PATH_RV%>Rv511I",
	             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
	             "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1");
	         tr_post(tr1);

			selectImgDs.clearData();
		    selectImgDs.addrow();
		    selectImgDs.namevalue(1,"picture_info") = imgDs.namevalue(ds1.rowposition,"picture_info");
			selectImgDs.ResetStatus();
		}else{
			alert("������ ������ ���� ������ �� �����ϴ�.");
		}
	}

	// ���
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
			lc_status2.index = lc_status2.IndexOfColumn("detail", ds1.namevalue(	ds1.rowposition,"status_cd"));
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";
		}
	}
	//��ǰ��ȸ
	function fnSelectGoodsLC() {
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
	
	/*
	 * �븮���˾�
	 */
	function fnPopup1() {
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp?gubun=1";
			strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	sClientSid.value = arrParam[0];
				sClientCd.value = arrParam[2];
				sClientNm.value = arrParam[1];
			} else {
		    	sClientSid.value = 0;
				sClientCd.value = '';
				sClientNm.value = '';
			}
	}
	/*
	 * ��������� �˾�
	 */
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
	/*
	 * �븮�� �ڵ�����(����)
	 */
	function fnSetting(dataSet) {
		var exit=false;
		if ( dataSet == 'ds_saldam' ) {	//���������
			for ( i=1; i<=ds_saldam.CountRow; i++ ) {
				if ( ds_saldam.namevalue(i,"sal_dam_cd") == sSalDamCd.value ) {
					sSalDamSid.value = ds_saldam.namevalue(i,"sal_dam_sid");
					sSalDamNm.value = ds_saldam.namevalue(i,"sal_dam_nm");
					exit=true;
					return;
				}
			}
			if ( exit != true ) {
					sSalDamSid.value = '';
					sSalDamNm.value = '';
			}
		}
		if ( dataSet == 'ds6' ) {	//�븮��
			for ( i=1; i<=ds6.CountRow; i++ ) {
				if ( ds6.namevalue(i,"client_cd") == sClientCd.value ) {
					sClientSid.value = ds6.namevalue(i,"client_sid");
					sClientNm.value = ds6.namevalue(i,"client_nm");
					exit=true;
					return;
				}
			}
			if ( exit != true ) {
				sClientSid.value = '';
				sClientNm.value = '';
			}
		}
	}
	/*
	 * �۾����� ����
	 */
	function fnStatusSet(status) {
		if(status=='JO') {//�����Ϸ� ��ư Ŭ��
			if (ds1.namevalue(ds1.rowposition,"status_cd")=='RR'||ds1.namevalue(ds1.rowposition,"status_cd")=='PC') {
				lc_status2.index = lc_status2.IndexOfColumn("detail", status);
			} else {
				alert("[��û|ȯ�Һ���]������ �͵鸸 [�����Ϸ�]�� ������ �� �ֽ��ϴ�.");
			}
		};
		
		if(status=='RC') {//��û��� ��ư Ŭ��
			if (ds1.namevalue(ds1.rowposition,"status_cd")=='RR'||ds1.namevalue(ds1.rowposition,"status_cd")=='PC') {
				lc_status2.index = lc_status2.IndexOfColumn("detail", status);
			} else {
				alert("[��û|ȯ�Һ���]������ �͵鸸 [��û���]�� ������ �� �ֽ��ϴ�.");
			}
		};

	}
	
	
	// Print : ȯ������/ȯ�ҿϷ� ���¸� ��°���...
	 function fnPrint(){
		if(ds_status2.namevalue(ds_status2.rowposition,"detail")=="PO" || ds_status2.namevalue(ds_status2.rowposition,"detail")=="TO"){
			//�����߰� : �����ͼ� ���            
			var ls_temp="PAY_AMT1:DECIMAL,REFUND_AMT1:DECIMAL,PAY_AMT2:DECIMAL,REFUND_AMT2:DECIMAL,PAY_AMT3:DECIMAL,REFUND_AMT3:DECIMAL,";
			ls_temp +="PAY_AMT4:DECIMAL,REFUND_AMT4:DECIMAL,PAY_AMT5:DECIMAL,REFUND_AMT5:DECIMAL,TOT_PAY_AMT:DECIMAL,TOT_REFUND_AMT:DECIMAL";
			ds2.SetDataHeader(ls_temp);
			var ls_temp ="TOUR_AMT:DECIMAL,PAY_AMT:DECIMAL,DEDUCT_AMT:DECIMAL,AMT:DECIMAL"	;
			ds3.SetDataHeader(ls_temp);
			//�����߰� ��.

		 	v_job = "S";
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2,"
	            + "sSaup_sid="	+ lc_saup.ValueOfIndex("saup_sid", lc_saup.Index) + ","
			    + "sGoods_sid="	+ lc_goods.ValueOfIndex("goods_sid", lc_goods.Index) + ","
	            + "sSalDamSid=" + sSalDamSid.value + ","
	            + "sClientSid=" + sClientSid.value + ","
	            + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + ","
	            + "sBgnDate=" + sBgnDate.text + ","
	            + "sEndDate=" + sEndDate.text + ","
	            + "sAcceptNo=" + sAcceptNo.text + ","
	            + "sCustNm=" + sCustNm.value +","
	            + "sDpBgnDate=" + sDpBgnDate.text + ","
	            + "sDpEndDate=" + sDpEndDate.text + ","            
	            + "sJobType=" + codeDsSrch.namevalue(codeDsSrch.rowposition,"detail") ;


	        ln_TRSetting(tr1,
	            "<%=dirPath%><%=HDConstant.PATH_RV%>Rv511I",
	            "JSP(O:DS2=ds2,O:DS3=ds3)",
	            param);
	            
			tr_post(tr1);
			pr2.PreView();

		}else{
			alert("ȯ������, ȯ�ҿϷ� ���°� �ƴϹǷ� ��û���� ����� �� �����ϴ�.");
			return;
		};

	 }
	 
    function fnExcelDs1() {
        if(ds1.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr1").SetExcelTitle(0, "");
        getObjectFirst("gr1").SetExcelTitle(1, "value:���-ȯ����Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr1").GridToExcel("���-ȯ����Ȳ", "���-ȯ����Ȳ.xls", 8);        
    }
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript for=gr1 event=OnClick(Row,Colid)>
			var index=lc_status2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"status_cd"));
			lc_status2.index=index;
//			index=lc_charge.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"charge_cd"));
//			lc_charge.index=index;
//			index=lc_bancod.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"bancod"));
//			lc_bancod.index=index;
			
			
		    if(Row<1) return;
		    imgDs.RowPosition = Row;
		</script>

		<script language=JavaScript for=gr1 event=OnDblClick(Row,Colid)>
			// ����Ŭ���̺�Ʈ : ��û����ȣ�� ���� �˻�â���� �����ؼ� ����ֽ��ϴ�.
//			alert(ds1.namevalue(ds1.Rowposition,"accept_no"));
			sAcceptNo.text = ds1.namevalue(ds1.Rowposition,"accept_no");
		</script>


		<script language=JavaScript for= lc_status2 event=OnSelChange()>
			ds1.namevalue(ds1.rowposition, "status_cd") = ds_status2.namevalue(ds_status2.rowposition, "detail");
		</script>

		<script language=JavaScript for= lc_charge event=OnSelChange()>
			ds1.namevalue(ds1.rowposition, "charge_cd") = ds_charge.namevalue(ds_charge.rowposition, "detail");
			if ( ds1.namevalue(ds1.rowposition, "charge_cd") == '1' )
				amt.text = pay_amt.text;
			else if ( ds1.namevalue(ds1.rowposition, "charge_cd") == '2' )
				amt.text = Math.round(pay_amt.text * 0.5);
		</script>

		<script language=JavaScript for= lc_bancod event=OnSelChange()>
			ds1.namevalue(ds1.rowposition, "bancod") = ds_bancod.namevalue(ds_bancod.rowposition, "detail");
		</script>

		<script language="javascript" for="gcip_file" event=OnClick()>
		    if (fn_trim(gcip_file.value)!="") {
		    	txt_file.value = gcip_file.value;
		    	photo.src = gcip_file.value;
		    }
		</script>

		<script language=JavaScript for=sBgnDate event=OnKillFocus()>
			if ( sBgnDate.Modified ) {
				sEndDate.text = sBgnDate.text;
			}
		</script>
		<script language=JavaScript for=sDpBgnDate event=OnKillFocus()>
			if ( sDpBgnDate.Modified ) {
				sDpEndDate.text = sDpBgnDate.text;
			}
		</script>


	<script language=JavaScript for=codeDs1 event="OnLoadCompleted(row)">
		codeDs1.DeleteRow(1);
		sJobType.Index = 0;
		sJobType1.Index = 0;	//�˻����Ǻκ�		
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
        var msg='';

        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";

            //�޽��� ó��
	        for ( j=1; j<=msgDS.CountRow; j++ )
	          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
	         if ( msgDS.CountRow > 0 )
	          	alert(msg);
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";

        var alertMsg = '';
       	var nErrCnt = tr1.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++)
			alertMsg = "ErrorCode : " + tr1.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr1.SrvErrMsg("ERROR", i) + "\n";
        if ( nErrCnt > 0 )
		    alert(alertMsg);

        //�޽��� ó��
		var msg='';
        for ( j=1; j<=msgDS.CountRow; j++ )
          	msg+=msgDS.namevalue(j,"pMsg")+"\n";
         if ( msgDS.CountRow > 0 )
          	alert(msg);
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onsuccess()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S") {
       	}
	</script>
<%
///////////////////////////////////////////////////////////////////////////////
// Description	:  �۾�����
%>
	<script language="javascript" for="tr2" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";

        var alertMsg = '';
       	var nErrCnt = tr2.SrvErrCount("ERROR");
       	for (i = 0; i < nErrCnt; i++)
			alertMsg = "ErrorCode : " + tr2.SrvErrCode("ERROR", i) + "ErrorMsg : " + tr2.SrvErrMsg("ERROR", i) + "\n";
        if ( nErrCnt > 0 )
		    alert(alertMsg);
	</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<script language=JavaScript	for=ds_saup event="OnLoadCompleted(row)">
		fnSelectGoodsLC();
	</script>

	<script language=JavaScript for=lc_saup event=OnSelChange()>
		fnSelectGoodsLC();//��ǰ ��˻�
	</script>
	<script language=JavaScript  for=ds1 event="OnLoadStarted()">
		window.status="<%=HDConstant.S_MSG_SEARCH_DATA%>";
	</script>

	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
		var index=lc_status2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"status_cd"));
		lc_status2.index=index;
//		index=lc_charge.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"charge_cd"));
//		lc_chargeindex=index;
//		index=lc_bancod.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"bancod"));
//		lc_bancodindex=index;
	</script>
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">

	</script>

	<script language=JavaScript  for=ds_bancod event="OnLoadCompleted(row)">
     	window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
	</script>

	<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
	    imgDs.RowPosition = Row;
	</script>
	
	<script language=JavaScript  for=imgDs event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
	    if(imgDs.NameValue(Row, "PICTURE_INFO")!="")
	        photo.src = imgDs.NameValue(Row, "PICTURE_INFO");
	    else
	        photo.src = "<%=dirPath%>/Sales/images/00000.gif";

		selectImgDs.clearData();
	    selectImgDs.addrow();
	    selectImgDs.namevalue(1,"picture_info") = imgDs.namevalue(Row,"picture_info");
		selectImgDs.ResetStatus();

	</script>



<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_saup classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���� -->
	<param name="SyncLoad" 	value="true">
</object>
<object id=ds_goods classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �˻� : ��ǰ -->
	<param name="SyncLoad" 	value="false">
</object>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>

<object id=ds_client classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_status2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_saldam classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_charge classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_bancod classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=reqNoDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=imgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=selectImgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=ds_client_info classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDsSrch classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=msgDS classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
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

<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr>
		<td align=right height="30px">
			<table border="0"  cellpadding="0" cellspacing="0" width="100%">
				<tr>
					<td width=500>
						<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
					  		<tr bgcolor="#6f7f8d"  >
		                  		<td align=center class="text" width="66">����</td>
                  				<td align=left bgcolor="#ffffff" width=189>&nbsp;<%=HDConstant.COMMENT_START%>
			            	        <object id=lc_saup classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_saup>
										<param name=BindColumn      value="saup_sid">
		    	                        <param name=BindColVal      value="saup_sid">
										<param name=EditExprFormat	value="%,%;saup_sid,saup_nm">
										<param name=ListExprFormat  value="saup_nm^0^60">
									</object>
									<%=HDConstant.COMMENT_END%>
							    </td>
							    <td align=center class="text" width="65">��ǰ</td>
								<td align=left width="118" bgcolor="#ffffff" valign="middle">&nbsp;<%=HDConstant.COMMENT_START%>
			        	            <object id=lc_goods classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=105 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_goods>
										<param name=BindColumn      value="goods_sid">
			                            <param name=BindColVal      value="goods_sid">
										<param name=EditExprFormat	value="%,%;goods_sid,goods_nm">
										<param name=ListExprFormat  value="goods_nm^0^100"></object>
									<%=HDConstant.COMMENT_END%>
							  	</td>	
						    </tr>
						</table>
					</td>
					<td align="right" width=345>
						<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:hand" align=absmiddle 	onclick="fnSelect()">
						<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" align=absmiddle 	onClick="fnApply()">
						<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand" align=absmiddle  	onclick="fnCancel()">
						<img src="<%=dirPath%>/Sales/images/refund.gif"		style="cursor:hand" align=absmiddle 	onClick="fnPrint()"></td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr>
					<td  width="845px">
                        <table width="100%" border="0" cellspacing="1" cellpadding="0" bgcolor="#666666">
                            <tr bgcolor="#6f7f8d">
            					<td align=center width=65 class="text">���������</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
									<input id="sSalDamSid" type="hidden" value="0">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="��������ڸ� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
									<input id="sSalDamNm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" maxlength="50" onBlur="" readOnly>
								</td>
								<td align=center width=65 class="text">��û����ȣ</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sAcceptNo classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=100 align=center class="textbox">
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="00000-000000000">
										<param name=Cursor	 	value="iBeam">
										<param name=Border	 	value="0">
										<param name=InheritColor      value="true">
										<param name=ReadOnly  	value="false">
										<param name=SelectAll   value="true">
										<param name=SelectAllOnClick   value="true">
										<param name=SelectAllOnClickAny  	value="false">
									</object>
									<%=HDConstant.COMMENT_END%>
								</td>
            					<td align=center width=60 class="text">�������</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sDpBgnDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>&nbsp;-&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sDpEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>
								</td>
								<td align=center width=60 class="text">����</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="sCustNm" value="" size=10 class="textbox">
								</td>
            				</tr>
                            <tr bgcolor="#6f7f8d">
            					<td align=center class="text">�븮��</td>
                                <td align=left bgcolor="#ffffff">&nbsp;<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
									<input id="sClientSid" type="hidden" value="0">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�븮���� �˻��մϴ�" style="cursor:hand;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
									<input id="sClientNm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:80px; height:20px;" maxlength="50" onBlur="" readOnly>
								</td>
			            		<td align=center class="text"><B>�۾�����</B></td>
			                    <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_status1>
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80"></object>
									<%=HDConstant.COMMENT_END%>
								</td>
            					<td align=center class="text"><B>��û����</B></td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
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
									<%=HDConstant.COMMENT_END%>&nbsp;-&nbsp;<%=HDConstant.COMMENT_START%>
								     <object id=sEndDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
									<%=HDConstant.COMMENT_END%>
								</td>
								<td align=center class="text"><B>�۾�����</B></td>
                                <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
		                            <object id=sJobType1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDsSrch>
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80">
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
	<tr>
		<td height="10"></td>
	</tr>
	<tr>
		<td width="845px">
			<table  border="0" cellpadding="0" cellspacing="0">
				<tr valign="top"">
					<td align="left" width="290px" border="0" cellpadding="0" cellspacing="0" bordercolor="#000000">
						    <%=HDConstant.COMMENT_START%>
						    <object id=gr1 classid=<%=HDConstant.CT_GRID_CLSID%> style="width=290px; height:350" border="1" >
             				<param name="DataID"		VALUE="ds1">
                			<param name="BorderStyle"   VALUE="0">
                			<param name=ColSizing       value="true">
                			<param name="editable"      value="true">
                			<param name=UsingOneClick  	value="1">
                            <Param Name="AllShowEdit"   value="True">
                            <param name="SortView"      value="Right">
                            <param name="ViewSummary" value="1">
							<param name="Format" 			value="
				                <C> name='�۾�����'    	ID='status_cd' width=60  align=center editlimit=2 editstyle=lookup edit=none Data='ds_status2:detail:detail_nm' show=true sumtext=��</C>
				                <C> name='��û��'  		ID='accept_date'     width=70    align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX sumtext=@count</C>
				                <C> name='��û����ȣ'  	ID='accept_no'  width=100 align=center editlimit=15 edit=none show=true sort=true sumtext=��</C>
				                <C> name='�̸�'      	ID='cust_nm'   width=60  align=left editlimit=30 edit=none show=true sort=true</C>
				                <C> name='������ȣ'     ID='req_no'  width=100  width=100  align=center editlimit=20 edit=none show=true</C>
				                <C> name='�۾�����'    	ID='job_type'  width=60  align=left EditStyle=Lookup Data='codeDs1:DETAIL:DETAIL_NM' show=true</C>
				                <C> name='�븮��SID'   	ID='client_sid' width=60  align=left editlimit=12 show=false</C>
				                <C> name='��ǰ'   		ID='lc_goods' width=60  align=left editlimit=12 show=false</C>
				                <C> name='��û�ð�'  	ID='accept_time'         align=left show=false </C>
				                <C> name='�����'       ID='client_dam_nm'       align=left editlimit=20 show=false</C>
				                <C> name='����ó'    ID='mobile_no'   align=left editlimit=15 show=false</C>
				                <C> name='�����'  ID='depart_date'         align=left editlimit=8 show=false</C>
				                <C> name='��߽ð�'  ID='depart_time'         align=left editlimit=8 show=false</C>
				                <C> name='��ûSID'   ID='accept_sid'  align=left editlimit=12 show=false</C>
				                <C> name='����SID'      ID='rsv_sid'     align=left editlimit=12 show=false</C>
				                <C> name='��SID'     ID='cust_sid'    align=left editlimit=12 show=false</C>
				                <C> name='�ֹ�/���ǹ�ȣ'    ID='manage_no'   align=left editlimit=20 show=false</C>
				                <C> name='�����'   ID='company_nm'  align=left editlimit=30 show=false</C>
				                <C> name='����'    ID='positions'   align=left editlimit=30 show=false</C>
				                <C> name='����ó'    ID='cust_mobile_no'   align=left editlimit=15 show=false</C>
				                <C> name='�ǸŰ�'      ID='tour_amt'     align=left editlimit=33 show=false</C>
				                <C> name='�Աݾ�'      ID='pay_amt'     align=left editlimit=33 show=false</C>
				                <C> name='ȯ�Ҿ�'      ID='amt'         align=left editlimit=12 show=False</C>
   				                <C> name='ȯ�ҿ�û�ݾ�' ID='rq_amt'     align=left editlimit=12 show=False</C>
				                <C> name='�����ڵ�'    ID='charge_cd'   align=left editlimit=1 show=false</C>
				                <C> name='ǥ�ذ�����'     ID='charge_rate'   align=left show=false</C>
				                <C> name='�۱�����'       ID='bancod'      align=left editlimit=2 show=False</C>
				                <C> name='�۱������'     ID='bannm'       align=left editlimit=50 show=false</C>
				                <C> name='�۱ݰ���'  ID='bank_acc_no'         align=left editlimit=20 show=false</C>
				                <C> name='������' ID='bank_acct_nm'        align=left editlimit=32 show=false</C>
				                <C> name='����'       ID='reason'      align=left editlimit=200 show=false</C>
				                <C> name='���' ID='desc'        align=left editlimit=200 show=false</C>
							">
						</object>
						<%=HDConstant.COMMENT_END%>
						�� ȯ�ҿ�û���� ��� ���Ǵ�� ��µ˴ϴ�.<br>
						����û����ȣ�� ���̻� �ʼ��� �ƴմϴ�.<BR><br>
						�� ���´� <b>[ȯ������]</b>�� ��µ˴ϴ�.<br>
						������������ ȯ�ҿ�û���� ó���ϸ� [ȯ�ҿϷ�]<br>
						 ���°� �˴ϴ�.<br>
						���� ���� ȯ�ҿ�û���� ������Ϸ��� ��������<br>
						 ��û�Ͽ� ���¸� [�����Ϸ�]�� �����Ͽ��� �մϴ�.
					</td>
					<td width="25px">
					</td>
					<td align="left" valign="top" width="530px">
						<table border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td>
									<table border="0" cellpadding="0" cellspacing="0">
										<tr>
											<td>
												<table width="530px" border="0" cellpadding="0" cellspacing="1"  bgcolor="#666666">
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�۾�����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_status2 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_status2>
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^80">
																<param name=BindColumn      value="detail">
		                                                        <param name=BindColVal      value="detail">
																<param name=Enable  value=false>
															</object>
															<%=HDConstant.COMMENT_END%>
															<img src="<%=dirPath%>/Sales/images/take_com.gif"   	style="cursor:hand;position:relative;left:3px;top:1px" onclick="fnStatusSet('JO')">
															<img src="<%=dirPath%>/Sales/images/request_can.gif"		style="cursor:hand;position:relative;left:3px;top:1px" onClick="fnStatusSet('RC')">

														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�۾�����</td>
						                                <td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=sJobType classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=codeDs1>
																<param name=BindColumn      value="detail">
		                                                        <param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^80">
																<param name=Enable  value=false>
																</object>
															<%=HDConstant.COMMENT_END%>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û��</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=accept_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=accept_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="00:00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">������ȣ</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="req_no" type="text" class="textbox_d"   value="" size="20" readonly>
														</td>
													</tr>
													<tr>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">�����</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="client_dam_nm" type="text" class="textbox_d"  style="text-align:left;" value="�����" size="20" readonly>
														</td>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">����ó</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="mobile_no" type="text" class="textbox_d"  style="text-align:left;" value="010-3399-0101" size="20" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=depart_date classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="0000-00-00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=depart_time classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=40 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=1>
																<param name=Format 		value="00:00">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">��ǰ</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id=goods_nm name=goods_nm type="text"  class="textbox_d" size="20" value=""  style="text-align:center" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û����ȣ</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input id="accept_sid" type="hidden" value="0">&nbsp;
															<input id="accept_no" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black; text-align:center;" readonly>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��湮Ƚ��</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" >&nbsp;
															<input id="north_cnt" name=north_cnt type="text"  class="textbox_d" size="20" value=""  style="text-align:center" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id=confirm_yn name=confirm_yn type="text"  class="textbox_d" size="20" value=""  style="text-align:center" readonly>
														</td>																									
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�������</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id=status_nm name=status_nm type="text"  class="textbox_d" size="20" value=""  style="text-align:center" readonly>
															<input id=status_cd name=status_cd type="hidden"  value="">
														</td>																									
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input type="hidden" id="rsv_sid" value="0">
															<input type="hidden" id="cust_sid" value="0">&nbsp;
															<input id="cust_nm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;" readonly>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�ֹ�/���ǹ�ȣ</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="manage_no" type="text" class="textbox_d"  size="20" value="" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="company_nm" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:131px; height:20px;color:black; text-align:left;" readonly>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="positions" type="text" class="textbox_d"  style= "position:relative;left:-0px;top:2px;width:131px; height:20px; text-align:left" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�ǸŰ�</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=tour_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����ó</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="cust_mobile_no" type="text" class="textbox_d"  size="20" value="" style="text-align: left" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�Աݾ�</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=pay_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
														<td width="90px" bgcolor="#ffffff" colspan="2" rowspan="7">
															<table border="0" cellpadding="0" cellspacing="0" width="200px" height="120px" bgcolor="#666666" style="border:0px solid #6f7f8d">
																<tr bgcolor="#ffffff">
																	<td width="150px" bgcolor="#ffffff">
																		<img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="120px">
																	</td>
																	<td width="150px" align="left" bgcolor="#ffffff" align="absmiddle">
                                                                        <input type=hidden name=txt_file>
																		<%=HDConstant.COMMENT_START%>
																		<%=HDConstant.COMMENT_END%>
																		<br><br>
																		<img src="<%=dirPath%>/Sales/images/print.gif"   	style="cursor:hand;position:relative;left:3px;top:3px" onclick="pr1.preview();" >
																	</td>
																</tr>
															</table>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">���� | ������</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_charge classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=190 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_charge>
																<param name=BindColumn      value="detail">
																<param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
																<param name=ListExprFormat  value="detail_nm^0^80;item4^0^50">

															</object>
															<%=HDConstant.COMMENT_END%>
															<input id="charge_rate" type="text" class="textbox_d"  size="7" value="" style="text-align: right" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ȯ�ҿ�û�ݾ�</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=rq_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ȯ�Ҿ�</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=129 align=center class="textbox">
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">
																<param name=InheritColor      value="true">
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	value="#dddddd">
																<param name=SelectAll   value="true">
																<param name=SelectAllOnClick   value="true">
																<param name=SelectAllOnClickAny  	value="false">
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�۱�����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_bancod classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=110 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_bancod>
																<param name=BindColumn      value="detail">
																<param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^110">
																<param name=Enable2  value=false>
															</object>
															<%=HDConstant.COMMENT_END%>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�۱ݰ���</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="bank_acc_no" type="text" class="textbox_d" style="text-align:left;" size="20" value="" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">������</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="bank_acct_nm" type="text" class="textbox_d" style="text-align:left;" size="20" value="" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ȯ�һ���</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="reason" type="text" class="textbox_d" style="text-align:left;" size="50" value="" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">���</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="desc" type="text" class="textbox"  size="50" value="" style="text-align: left">
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ó�����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="desc2" type="text" class="textbox_d"  size="50" value="" style="text-align: left" readonly>
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
		</td>
	</tr>
</table>
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
     <object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
             <param name="DataId" value="imgDs">
             <param name=BindInfo    value="
                <C>Col=PICTURE_INFO     Ctrl=gcip_file          Param=value</C>
                <C>Col=PICTURE_URL      Ctrl=gcip_file          Param=value</C>
              ">
      </object>
<%=HDConstant.COMMENT_END%>
<comment id="__NSID__"><object id=bn1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49>
	<param name="DataId" value="ds1">
	<param name=BindInfo	value="
        <C>Col=req_no           Ctrl=req_no             Param=value </C>
        <C>Col=goods_sid        Ctrl=goods_sid          Param=value </C>
        <C>Col=client_sid       Ctrl=client_sid         Param=value </C>
        <C>Col=accept_date      Ctrl=accept_date                Param=text </C>
        <C>Col=accept_time      Ctrl=accept_time                Param=text </C>
        <C>Col=client_dam_nm    Ctrl=client_dam_nm              Param=value </C>
        <C>Col=mobile_no        Ctrl=mobile_no          Param=value </C>
        <C>Col=depart_date      Ctrl=depart_date                Param=text </C>
        <C>Col=depart_time      Ctrl=depart_time                Param=text </C>

        <C>Col=goods_nm			Ctrl=goods_nm			Param=value </C>
        <C>Col=confirm_yn		Ctrl=confirm_yn			Param=value </C>
        <C>Col=status_nm		Ctrl=status_nm			Param=value </C>
        
        <C>Col=accept_sid       Ctrl=accept_sid         Param=value </C>
        <C>Col=accept_no        Ctrl=accept_no          Param=value </C>
        <C>Col=rsv_sid          Ctrl=rsv_sid            Param=value </C>
        <C>Col=cust_sid         Ctrl=cust_sid           Param=value </C>
        <C>Col=cust_nm          Ctrl=cust_nm            Param=value </C>
        <C>Col=manage_no        Ctrl=manage_no          Param=value </C>
        <C>Col=company_nm       Ctrl=company_nm         Param=value </C>
        <C>Col=positions        Ctrl=positions          Param=value </C>
        <C>Col=cust_mobile_no   Ctrl=cust_mobile_no     Param=value </C>
        <C>Col=tour_amt         Ctrl=tour_amt           Param=text </C>
        <C>Col=pay_amt          Ctrl=pay_amt            Param=text </C>
        <C>Col=amt              Ctrl=amt                Param=text </C>
        <C>Col=rq_amt           Ctrl=rq_amt             Param=text </C>        

        <C>Col=charge_cd        Ctrl=lc_charge   	 	Param=BindColVal</C>

        <C>Col=charge_rate      Ctrl=charge_rate        Param=value </C>
        <C>Col=bancod           Ctrl=lc_bancod          Param=BindColVal </C>
        <C>Col=bannm            Ctrl=bannm              Param=value </C>
        <C>Col=bank_acc_no      Ctrl=bank_acc_no        Param=value </C>
        <C>Col=bank_acct_nm     Ctrl=bank_acct_nm       Param=value </C>
        <C>Col=reason           Ctrl=reason             Param=value </C>
        <C>Col=desc             Ctrl=desc               Param=value </C>
        <C>Col=desc2            Ctrl=desc2              Param=value </C>
        <C>Col=north_cnt        Ctrl=north_cnt          Param=value </C>
		<C>Col=job_type         Ctrl=sJobType           Param=BindColVal </C>
		<C>Col=status_cd        Ctrl=lc_status2         Param=BindColVal </C>
	">
</object></comment><SCRIPT>__WS__(__NSID__);</SCRIPT>


<input type="hidden" name="row" value="">
<!-----------------------------------------------------------------------------
					��¹� ���Ǻκ�
------------------------------------------------------------------------------>
<%=HDConstant.COMMENT_START%>
	<object  id="pr1" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F">
		<param NAME="DetailDataID"			VALUE="selectImgDs">
		<PARAM NAME="PaperSize"				VALUE="A4">
		<PARAM NAME="LandScape"				VALUE="false">
		<PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
		<PARAM NAME="PreviewZoom"			VALUE="100">
		<PARAM NAME="FixPaperSize"			VALUE="true">
		<PARAM NAME="PrintMargine"			VALUE="false">
		<PARAM NAME="NullRecordFlag"		VALUE="false">
		<param name="SuppressColumns"		value="1:pageskip,skip">
		<PARAM NAME="Format"                VALUE="
		   <B>id=default ,left=0,top=0 ,right=2000 ,bottom=478 ,face='Arial' ,size=10 ,penwidth=1
		   	<I>id='picture_info' ,left=80 ,top=120 ,right=1900 ,bottom=2700</I>
		   </B>
      ">
	</object>

<%=HDConstant.COMMENT_END%>
<%
/*=============================================================================
			����Ʈ ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
   <OBJECT ID=pr2 CLASSID=<%=HDConstant.CT_REPORT_CLSID%>>
      <PARAM NAME="MasterDataID"          VALUE="ds2">
      <PARAM NAME="DetailDataID"          VALUE="ds3">
      <PARAM NAME="BandColumn"            VALUE="BCol">
      <PARAM NAME="PaperSize"			  VALUE="A4">
      <PARAM NAME="LandScape"				   VALUE="True">
      <PARAM NAME="PrintSetupDlgFlag"     VALUE="True">
      <PARAM NAME="PreviewZoom"			   VALUE="100">
      <PARAM NAME="FixPaperSize"			   VALUE="True">
      <PARAM NAME="PrintMargine"			   VALUE="False">
      <PARAM NAME="NullRecordFlag"		   VALUE="False">
      <PARAM NAME="ImagSyncFlag"          VALUE="True">
      <param name="SuppressColumns"		  value="8:ACCEPT_NO;7:DEPART_DATE;6:GOODS_NM;5:ROOM_TYPE_NM;4:CUST_NM;3:MANAGE_NO;2:TOUR_AMT;1:REQ_NO">
      <PARAM NAME="Format"                VALUE="

<B>id=Header ,left=0,top=0 ,right=2870 ,bottom=793 ,face='����ü' ,size=10 ,penwidth=1
	<T>id='/' ,left=2575 ,top=206 ,right=2793 ,bottom=245 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�۾�����' ,left=1061 ,top=324 ,right=1274 ,bottom=390 ,face='����ü' ,size=7 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<C>id='STATUS_NM', left=1269, top=324, right=1935, bottom=390, face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='JOB_NM', left=2143, top=324, right=2793, bottom=390, face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<T>id='�۾�����' ,left=1930 ,top=324 ,right=2143 ,bottom=390 ,face='����ü' ,size=7 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��û�Ⱓ' ,left=1061 ,top=258 ,right=1274 ,bottom=324 ,face='����ü' ,size=7 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<X>left=203 ,top=40 ,right=1303 ,bottom=206 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=184 ,top=29 ,right=1285 ,bottom=192 ,border=true</X>
	<C>id='ACCEPT_DATES', left=1269, top=258, right=1935, bottom=324, face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<T>id='�Ա�����' ,left=184 ,top=258 ,right=398 ,bottom=324 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='���������' ,left=1930 ,top=258 ,right=2143 ,bottom=324 ,face='����ü' ,size=7 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='ȯ �� �� û ��' ,left=358 ,top=32 ,right=1143 ,bottom=163 ,face='����ü' ,size=22 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='�Աݾ�' ,left=395 ,top=258 ,right=711 ,bottom=324 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�������' ,left=184 ,top=324 ,right=398 ,bottom=390 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<C>id='{PAY_AMT1*1}', left=395, top=324, right=711, bottom=390, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='SAL_DAM_NM', left=2143, top=258, right=2793, bottom=324, face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<T>id='ȯ�Ҿ�' ,left=708 ,top=258 ,right=1064 ,bottom=324 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<C>id='{REFUND_AMT1*1}', left=708, top=324, right=1064, bottom=390, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<T>id='�ſ�ī��' ,left=184 ,top=385 ,right=398 ,bottom=456 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<C>id='{PAY_AMT2*1}', left=395, top=385, right=711, bottom=456, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{REFUND_AMT2*1}', left=708, top=385, right=1064, bottom=456, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<T>id='�¶���ī��' ,left=184 ,top=451 ,right=398 ,bottom=517 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<C>id='{PAY_AMT3*1}', left=395, top=451, right=711, bottom=517, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{REFUND_AMT3*1}', left=708, top=451, right=1064, bottom=517, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<T>id='��ǰ��' ,left=184 ,top=514 ,right=398 ,bottom=580 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�������Ա�' ,left=184 ,top=577 ,right=398 ,bottom=643 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<C>id='{PAY_AMT4*1}', left=395, top=514, right=711, bottom=580, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{PAY_AMT5*1}', left=395, top=577, right=711, bottom=643, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{REFUND_AMT4*1}', left=708, top=514, right=1064, bottom=580, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{REFUND_AMT5*1}', left=708, top=577, right=1064, bottom=643, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<T>id='������' ,left=184 ,top=641 ,right=398 ,bottom=707 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<C>id='{PAY_AMT6*1}', left=395, top=641, right=711, bottom=707, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<C>id='{REFUND_AMT6*1}', left=708, top=641, right=1064, bottom=707, align='right', face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=1, pencolor=#000000</C>
	<T>id='�հ�' ,left=184 ,top=709 ,right=398 ,bottom=775 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=4 ,pencolor=#000000</T>
	<C>id='{TOT_PAY_AMT*1}', left=395, top=709, right=711, bottom=775, align='right', face='����ü', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=4, pencolor=#000000</C>
	<C>id='{TOT_REFUND_AMT*1}', left=708, top=709, right=1064, bottom=775, align='right', face='����ü', size=9, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, border=true, penstyle=solid, penwidth=4, pencolor=#000000</C>
	<T>id='��  ��' ,left=2575 ,top=61 ,right=2793 ,bottom=100 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='/' ,left=2359 ,top=206 ,right=2578 ,bottom=245 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='Ȯ  ��' ,left=2359 ,top=61 ,right=2578 ,bottom=100 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��  ��' ,left=2143 ,top=61 ,right=2362 ,bottom=100 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='/' ,left=2143 ,top=206 ,right=2362 ,bottom=245 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='/' ,left=1927 ,top=206 ,right=2146 ,bottom=245 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��  ��' ,left=1927 ,top=61 ,right=2146 ,bottom=100 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id=' ' ,left=2575 ,top=98 ,right=2793 ,bottom=208 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id=' ' ,left=2359 ,top=98 ,right=2578 ,bottom=208 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id=' ' ,left=2143 ,top=98 ,right=2362 ,bottom=208 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id=' ' ,left=1927 ,top=98 ,right=2146 ,bottom=208 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='    ��   ��   ��' ,left=1927 ,top=24 ,right=2793 ,bottom=63 ,face='����ü' ,size=8 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
</B>
<B>id=DHeader ,left=0,top=0 ,right=2870 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='�Ա���' ,left=1227 ,top=0 ,right=1351 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�Ǹž�' ,left=885 ,top=0 ,right=995 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='����' ,left=474 ,top=0 ,right=571 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�Աݾ�' ,left=1103 ,top=0 ,right=1230 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�̸�' ,left=566 ,top=0 ,right=698 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=4 ,pencolor=#000000</T>
	<T>id='��������' ,left=993 ,top=0 ,right=1106 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��ǰ' ,left=332 ,top=0 ,right=477 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��û����ȣ' ,left=47 ,top=0 ,right=219 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�����' ,left=216 ,top=0 ,right=334 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�ֹ�/����' ,left=692 ,top=0 ,right=885 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=4 ,pencolor=#000000</T>
	<T>id='��  ��' ,left=2475 ,top=0 ,right=2675 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='�� ��' ,left=2372 ,top=0 ,right=2477 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='������' ,left=2264 ,top=0 ,right=2375 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='���¹�ȣ' ,left=2067 ,top=0 ,right=2267 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='ȯ�Ҿ�' ,left=1932 ,top=0 ,right=2069 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=4 ,pencolor=#000000</T>
	<T>id='�Ա���' ,left=1485 ,top=0 ,right=1585 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='ȯ�Ծ�' ,left=1825 ,top=0 ,right=1935 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=4 ,pencolor=#000000</T>
	<T>id='�Ա�����' ,left=1348 ,top=0 ,right=1488 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='ȯ�һ���' ,left=1682 ,top=0 ,right=1825 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=4 ,pencolor=#000000</T>
	<T>id='��û��ȣ' ,left=2672 ,top=0 ,right=2843 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1 ,pencolor=#000000</T>
	<T>id='��û��' ,left=1582 ,top=0 ,right=1682 ,bottom=66 ,face='����ü' ,size=7 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=4 ,pencolor=#000000</T>
</B>
<B>id=default ,left=0,top=0 ,right=2870 ,bottom=66 ,face='����ü' ,size=10 ,penwidth=1
	<C>id='{AMT*1}', left=1932, top=0, right=2069, bottom=66, align='right', face='����ü', size=8, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_DATE', left=1485, top=0, right=1585, bottom=66, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#A0A0A4</C>
	<C>id='ACCEPT_DATE', left=1582, top=0, right=1682, bottom=66, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHARGE_TXT', left=1682, top=0, right=1825, bottom=66, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{DEDUCT_AMT*1}', left=1825, top=0, right=1930, bottom=66, align='right', face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BANK_ACC_NO', left=2067, top=0, right=2267, bottom=66, supplevel=1, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BANK_ACCT_NM', left=2264, top=0, right=2375, bottom=66, align='left', supplevel=1, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='BANNM', left=2372, top=0, right=2477, bottom=66, supplevel=1, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REASON', left=2475, top=0, right=2672, bottom=66, align='left', supplevel=1, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REQ_NO', left=2672, top=0, right=2843, bottom=66, supplevel=1, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='PAY_CD_NM', left=1348, top=0, right=1488, bottom=66, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#A0A0A4, Dec=0</C>
	<C>id='ROOM_TYPE_NM', left=474, top=0, right=571, bottom=66, supplevel=5, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='GOODS_NM', left=332, top=0, right=477, bottom=66, supplevel=6, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ACCEPT_NO', left=47, top=0, right=219, bottom=66, supplevel=8, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{PAY_AMT*1}', left=1101, top=0, right=1227, bottom=66, align='right', face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ORDER_NM', left=1227, top=0, right=1351, bottom=66, align='left', face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='MANAGE_NO', left=692, top=0, right=887, bottom=66, supplevel=3, face='����ü', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CUST_NM', left=566, top=0, right=695, bottom=66, supplevel=4, face='����ü', size=8, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{TOUR_AMT*1}', left=885, top=0, right=990, bottom=66, align='right', supplevel=2, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CUST_TYPE_NM', left=993, top=0, right=1103, bottom=66, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=671 ,top=0 ,right=885 ,bottom=0 ,supplevel=3 </L>
	<L> left=566 ,top=0 ,right=719 ,bottom=0 ,supplevel=4 </L>
	<L> left=2375 ,top=0 ,right=2375 ,bottom=66 </L>
	<L> left=2267 ,top=0 ,right=2267 ,bottom=66 </L>
	<L> left=2477 ,top=0 ,right=2477 ,bottom=66 </L>
	<L> left=1230 ,top=0 ,right=1230 ,bottom=66 </L>
	<L> left=993 ,top=0 ,right=993 ,bottom=66 </L>
	<L> left=885 ,top=0 ,right=885 ,bottom=66 </L>
	<L> left=566 ,top=0 ,right=566 ,bottom=66 </L>
	<L> left=1106 ,top=0 ,right=1106 ,bottom=66 </L>
	<L> left=477 ,top=0 ,right=566 ,bottom=0 ,supplevel=5 </L>
	<C>id='DEPART_DATE', left=216, top=0, right=334, bottom=66, supplevel=7, face='����ü', size=7, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=692 ,top=0 ,right=692 ,bottom=66 </L>
	<L> left=477 ,top=0 ,right=477 ,bottom=66 </L>
	<L> left=332 ,top=0 ,right=332 ,bottom=66 </L>
	<L> left=216 ,top=0 ,right=216 ,bottom=66 </L>
	<L> left=1348 ,top=0 ,right=1348 ,bottom=66 </L>
	<L> left=1488 ,top=0 ,right=1488 ,bottom=66 </L>
	<L> left=1582 ,top=0 ,right=1582 ,bottom=66 </L>
	<L> left=1682 ,top=0 ,right=1682 ,bottom=66 </L>
	<L> left=1825 ,top=0 ,right=1825 ,bottom=66 </L>
	<L> left=2069 ,top=0 ,right=2069 ,bottom=66 </L>
	<L> left=1935 ,top=0 ,right=1935 ,bottom=66 </L>
	<L> left=2672 ,top=0 ,right=2672 ,bottom=66 </L>
	<L> left=332 ,top=0 ,right=477 ,bottom=0 ,supplevel=6 </L>
	<L> left=47 ,top=0 ,right=216 ,bottom=0 ,supplevel=8 </L>
	<L> left=216 ,top=0 ,right=342 ,bottom=0 ,supplevel=7 </L>
	<L> left=2670 ,top=0 ,right=2843 ,bottom=0 ,supplevel=1 </L>
	<L> left=993 ,top=0 ,right=2672 ,bottom=0 </L>
	<L> left=885 ,top=0 ,right=993 ,bottom=0 ,supplevel=2 </L>
</B>
<B>id=DFooter ,left=0,top=0 ,right=2870 ,bottom=82 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=45 ,top=0 ,right=2841 ,bottom=0 </L>
</B>
<B>id=Footer ,left=0 ,top=1876 ,right=2870 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../images/hyundai.jpg' ,left=2285 ,top=3 ,right=2688 ,bottom=119</I>
</B>




	">
</OBJECT>
<%=HDConstant.COMMENT_END%>

<script language=JavaScript for=pr2 event=OnError()>
    alert(pr2.ErrorMsg);
</script>

<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

