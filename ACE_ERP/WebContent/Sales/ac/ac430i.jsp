<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ȯ��ó��
 * ���α׷�ID 	 : AC430I
 * J  S  P		 : ac430i
 * �� �� ��		 : AC430I
 * �� �� ��		 : ���ؼ�
 * �� �� ��		 : 2006-08-11
 * �������		 : ȯ��ó�� (��ȸ, ����, ���)
 * [��  ��   ��  ��][������] ����
 * [2007-09-12][�ɵ���] �� �޴�Ʈ�� ����
 * [2008-11-25][�ɵ���] ���������� �۾����� ���� ����~!
 * [2010-06-09][�ڰ汹] ��ȸ���ǿ� ȯ����(����),ȯ����(�Ա�) ��ȸ���� �߰�.
 * [2010-06-10][�ڰ汹] �۾����� ȯ�ҿϷ� �϶�, �۱ݿϷ� �̹��� �����ְ� �۱ݿϷ� Ŭ�� �� �۾����� ����(javascript).
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
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac430I",
            "JSP(O:IMAGE=imgDs,O:CLIENTINFO=ds_client_info)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr2);           
        //���������
        ds_saldam.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy005H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_saldam.Reset();        
        //�븮��
        ds_client.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Cu001H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>";
        ds_client.Reset();         
       
        //�۾�����1
        ds_status1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_Item1=Y";
        ds_status1.Reset(); 
        
        //�۾�����2
        ds_status2.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV024&s_Item1=Y";
        ds_status2.Reset();        
        
        //������
        ds_charge.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV027&s_Item1=Y";
        ds_charge.Reset();        
        
        //�۱�����
        ds_bancod.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=AC002&s_Item1=Y";
        ds_bancod.Reset(); 
        
		//��� �� ȯ�� - �Էºκ�
        codeDs1.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV030&s_Item1=Y";
        codeDs1.Reset(); 
        
		//��� �� ȯ�� - �˻����Ǻκ�
        codeDs.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?dsType=3&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&s_Head=RV030&s_Item1=Y";
        codeDs.Reset(); 


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
            + "sSalDamSid=" + sSalDamSid.value + ","         
            + "sClientSid=" + sClientSid.value + "," 
            + "sStatusCd=" + ds_status1.namevalue(ds_status1.rowposition,"detail") + "," 
            + "sBgnDate=" + sBgnDate.text + ","                         
            + "sEndDate=" + sEndDate.text + "," 
            + "sAcceptNo=" + sAcceptNo.text + ","   
            + "sCustNm=" + sCustNm.value + ","
            + "sJobType=" + codeDs.namevalue(codeDs.rowposition,"detail") + ","
            + "sRefundDate=" + sRefundDate.text + ","                         
            + "sRefundDateTr=" + sRefundDateTr.text ;
        imgDs.ClearAll();
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_AC%>Ac430I",
            "JSP(O:DS1=ds1,O:IMAGE=imgDs)",
            param);
        tr_post(tr1);
    }
	/*
	 * ����
	 */
	function fnApply() {
		if ( ds1.isUpdated || imgDs.isUpdated ) {
			if ( accept_sid.value.trim() == '' || accept_sid.value.trim() == '0' ) {
				alert("��û�� ��ȣ�� �Է��� �ּ���.");
				return;
			}			
			if ( rsv_sid.value.trim() == '' || rsv_sid.value.trim() == '0' ) {
				alert("������ �Է��� �ּ���.");
				return;
			}
			
		}
	         window.status="���� ���Դϴ�. ��ø� ��ٷ� �ֽʽÿ�...";
			 var v_param = "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>,dsType=1";
	         ln_TRSetting(tr1, 
	             "<%=dirPath%><%=HDConstant.PATH_AC%>Ac430I",
	             "JSP(I:DEFAULT=ds1,O:msgDS=msgDS)",
	             v_param);
	             
	         tr_post(tr1);
	         
			selectImgDs.clearData();
		    selectImgDs.addrow();
		    selectImgDs.namevalue(1,"picture_info") = imgDs.namevalue(ds1.rowposition,"picture_info");
			selectImgDs.ResetStatus();	         
		
	}
	/*
	 * ���
	 */
	function fnCancel() {
		if (ds1.IsUpdated ) {
			ds1.undoall();
			lc_status2.index = lc_status2.IndexOfColumn("detail", ds1.namevalue(	ds1.rowposition,"status_cd"));			
			window.status="<%=HDConstant.S_MSG_CANCEL_DONE%>";			
		}
	}
	/*
	 * �븮���˾�
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup1() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			strURL = "<%=dirPath%>/Sales/help/cu001h.jsp";
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
	 * ȯ�һ��˾�
	 */                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
	function fnPopup5() {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
			var arrParam	= new Array();
			var arrResult	= new Array();
			var strURL;	
			var strPos;
			
			
			strURL = "<%=dirPath%>/Sales/help/ac430h.jsp";
			strPos = "dialogWidth:505px;dialogHeight:309px;status:no;scroll:no;resizable:no";

			arrResult = showModalDialog(strURL,window,strPos);	

			if (arrResult != null) {
				arrParam = arrResult.split(";");
		    	//sClientSid.value = arrParam[0];
				//sClientCd.value = arrParam[2];
				//sClientNm.value = arrParam[1];					
			} else {
		    	//sClientSid.value = 0;
				//sClientCd.value = '';
				//sClientNm.value = '';
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
		if ( ds1.namevalue(ds1.rowposition,"status_cd") == 'JO' || ds1.namevalue(ds1.rowposition,"status_cd") == 'PO' || ds1.namevalue(ds1.rowposition,"status_cd") == 'PC' || ds1.namevalue(ds1.rowposition,"status_cd") == 'TO' )
			lc_status2.index = lc_status2.IndexOfColumn("detail", status);
	}
	
	function fnTotSum(){	//ȯ�� ��Ż�ݾ� �����ϱ�.
/*		var tempAmt = Number(ds1.NameValue(ds1.RowPosition, "BANK_AMT") )+ Number(ds1.NameValue(ds1.RowPosition, "ACCT_AMT")) + Number(ds1.NameValue(ds1.RowPosition, "CARD_AMT")) + Number(ds1.NameValue(ds1.RowPosition, "GIFT_AMT"))+ Number(ds1.NameValue(ds1.RowPosition, "ONLINE_AMT"))+ Number(ds1.NameValue(ds1.RowPosition, "ACCOUNT_AMT"));
		if (getObjectFirst("amt").text < tempAmt) {
			alert("ȯ�Ҿ��� ȯ�ҿ�û�ݾ׺��� Ŭ �� �����ϴ�.");
			return false;
		};*/
		getObjectFirst("tot").Text = Number(ds1.NameValue(ds1.RowPosition, "BANK_AMT") )+ Number(ds1.NameValue(ds1.RowPosition, "ACCT_AMT")) + Number(ds1.NameValue(ds1.RowPosition, "CARD_AMT")) + Number(ds1.NameValue(ds1.RowPosition, "GIFT_AMT"))+ Number(ds1.NameValue(ds1.RowPosition, "ONLINE_AMT"))+ Number(ds1.NameValue(ds1.RowPosition, "ACCOUNT_AMT"))+ Number(ds1.NameValue(ds1.RowPosition, "DEPO_AMT"));
	}
</script>	    
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
		<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
			if(Row==0){
		    	getObjectFirst("po").style.display = "none";
		    	getObjectFirst("pc").style.display = "none";
				getObjectFirst("to").style.display = "none";
				getObjectFirst("so").style.display = "none";

				getObjectFirst("o_tot").Text = 0;
				return;
			}
			
		    if (ds1.namevalue(Row, "status_cd") == "RR") {
		    	getObjectFirst("po").style.display = "inline";
		    	getObjectFirst("pc").style.display = "inline";
		    	getObjectFirst("to").style.display = "none";
		    	getObjectFirst("so").style.display = "none";
		    } else if (ds1.namevalue(Row, "status_cd") == "JO") {
		    	getObjectFirst("po").style.display = "inline";
		    	getObjectFirst("pc").style.display = "inline";
		    	getObjectFirst("to").style.display = "none";
		    	getObjectFirst("so").style.display = "none";
		    } else if (ds1.namevalue(Row, "status_cd") == "PO") {
		    	getObjectFirst("po").style.display = "none";
		    	getObjectFirst("pc").style.display = "none";
		    	getObjectFirst("to").style.display = "inline";
		    	getObjectFirst("so").style.display = "none";
		    } else if (ds1.namevalue(Row, "status_cd") == "PC") {
		    	getObjectFirst("po").style.display = "inline";
		    	getObjectFirst("pc").style.display = "inline";
		    	getObjectFirst("to").style.display = "none";
		    	getObjectFirst("so").style.display = "none";
	    	} else if (ds1.namevalue(Row, "status_cd") == "TO") {
		    	getObjectFirst("po").style.display = "none";
		    	getObjectFirst("pc").style.display = "none";
		    	getObjectFirst("to").style.display = "none";
		    	getObjectFirst("so").style.display = "inline";
		    } else {
		    	getObjectFirst("po").style.display = "none";
		    	getObjectFirst("pc").style.display = "none";
				getObjectFirst("to").style.display = "none";
				getObjectFirst("so").style.display = "none";		    	
		    }
		    
			getObjectFirst("tot").Text = Number(ds1.NameValue(Row, "BANK_AMT")) + Number(ds1.NameValue(Row, "ACCT_AMT")) + Number(ds1.NameValue(Row, "CARD_AMT")) + Number(ds1.NameValue(Row, "GIFT_AMT") )+ Number(ds1.NameValue(Row, "ONLINE_AMT") )+ Number(ds1.NameValue(Row, "ACCOUNT_AMT") )+ Number(ds1.NameValue(Row, "DEPO_AMT"));
			getObjectFirst("o_tot").Text = Number(ds1.NameValue(Row, "O_BANK_AMT")) + Number(ds1.NameValue(Row, "O_ACCT_AMT")) + Number(ds1.NameValue(Row, "O_CARD_AMT")) + Number(ds1.NameValue(Row, "O_GIFT_AMT") )+ Number(ds1.NameValue(Row, "O_ONLINE_AMT") )+ Number(ds1.NameValue(Row, "O_ACCOUNT_AMT") )+ Number(ds1.NameValue(Row, "O_DEPO_AMT")) ;
			
		</script>
		
		<script language=JavaScript for=gr1 event=OnClick(Row,Colid)>
/*			var index=lc_status2.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"status_cd"));
			lc_status2.index=index;
			index=lc_charge.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"charge_cd"));
			lc_charge.index=index;			
			index=lc_bancod.IndexOfColumn("detail", ds1.namevalue(ds1.Rowposition,"bancod"));
			lc_bancod.index=index;	
		    if(Row<1) return;
		    imgDs.RowPosition = Row;		*/
		    
		    alert("onclick");

		    if (ds1.namevalue(ds1.rowposition, "status_cd") == "RR") {
		    	getObjectFirst("po").style.display = "inline";
		    	getObjectFirst("pc").style.display = "inline";
		    	getObjectFirst("to").style.display = "none";
	    	    getObjectFirst("so").style.display = "none";		    	
		    } else if (ds1.namevalue(ds1.rowposition, "status_cd") == "JO") {
		    	getObjectFirst("po").style.display = "inline";
		    	getObjectFirst("pc").style.display = "inline";
		    	getObjectFirst("to").style.display = "none";
		    	getObjectFirst("so").style.display = "none";		    	
		    } else if (ds1.namevalue(ds1.rowposition, "status_cd") == "PO") {
		    	getObjectFirst("po").style.display = "none";
		    	getObjectFirst("pc").style.display = "none";
		    	getObjectFirst("to").style.display = "inline";
		    	getObjectFirst("so").style.display = "none";		    	
		    } else if (ds1.namevalue(ds1.rowposition, "status_cd") == "PC") {
		    	getObjectFirst("po").style.display = "inline";
		    	getObjectFirst("pc").style.display = "inline";
		    	getObjectFirst("to").style.display = "none";
		    	getObjectFirst("so").style.display = "none";		    	
		   	} else if (ds1.namevalue(ds1.rowposition, "status_cd") == "TO") {
		    	getObjectFirst("po").style.display = "none";
		    	getObjectFirst("pc").style.display = "none";
		    	getObjectFirst("to").style.display = "none";
		    	getObjectFirst("so").style.display = "inline";		    	
		   	} else {
		    	getObjectFirst("po").style.display = "none";
		    	getObjectFirst("pc").style.display = "none";
				getObjectFirst("to").style.display = "none";
				getObjectFirst("so").style.display = "none";		    	
		    }
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
		
		<script language=javascript for=acct_amt event=OnKillFocus()>
			fnTotSum();
		</script>
		<script language=javascript for=bank_amt event=OnKillFocus()>
			fnTotSum();
		</script>
		<script language=javascript for=card_amt event=OnKillFocus()>
			fnTotSum();
		</script>
		<script language=javascript for=gift_amt event=OnKillFocus()>
			fnTotSum();
		</script>
		<script language=javascript for=online_amt event=OnKillFocus()>
			fnTotSum();
		</script>
		<script language=javascript for=account_amt event=OnKillFocus()>
			fnTotSum();
		</script>				
		<script language=javascript for=depo_amt event=OnKillFocus()>
			fnTotSum();
		</script>	
		
	
		<script language=javascript for=bank_amt event=OnDblClick()>
			fnPopup5();
		</script>
		<script language=javascript for=card_amt event=OnDblClick()>
			fnPopup5();
		</script>
		<script language=javascript for=account_amt event=OnDblClick()>
			fnPopup5();
		</script>
		<script language=javascript for=depo_amt event=OnDblClick()>
			fnPopup5();
		</script>
		<script language=javascript for=online_amt event=OnDblClick()>
			fnPopup5();
		</script>
		<script language=javascript for=gift_amt event=OnDblClick()>
			fnPopup5();
		</script>
		
		<script language=JavaScript for=sBgnDate event=OnKillFocus()>
			if ( sBgnDate.Modified ) {
				sEndDate.text = sBgnDate.text;
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
            window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
        }  else if(v_job == "H" || v_job=="S") {
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";
       	}
       	
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
	<script language="javascript" for="tr1" event="onfail()">
        if(v_job=="I") {
            window.status = "<%=HDConstant.S_MSG_SAVE_ERR%>";
        }  else if(v_job == "H" || v_job=="S")
            window.status = "<%=HDConstant.AS_MSG_SEARCH_ERR%>";
        
        //�����޽���
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
            window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";

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
	
	<script language=JavaScript  for=ds_bancod event="OnLoadCompleted(row)">
     	window.status = "<%=HDConstant.S_MSG_SEARCH_DONE%>";		
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
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
       if(row==0){
           
            if(ds1.CountRow==0) return;

 		   if(colid=="refund_date"){           
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "refund_date") = ds1.NameValue(1, "refund_date");
                    
                }
            }     
                        
            if(colid=="status_cd"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "status_cd") = ds1.NameValue(1, "status_cd");
                 
                }
            } 
                  
            if(colid=="refund_date_tr"){
                for(var i=1; i<=ds1.CountRow; i++){
                    ds1.NameValue(i, "refund_date_tr") = ds1.NameValue(1, "refund_date_tr");
                }
            } 
            return;
        }
      
 </script>	
<script language=JavaScript for=codeDs1 event="OnLoadCompleted(row)">
	codeDs1.DeleteRow(1);
	sJobType.Index = 0;
</script>			
<script language=JavaScript for=codeDs event="OnLoadCompleted(row)">
	codeDs.DeleteRow(1);
	sJobType1.Index = 0;	//�˻����Ǻκ�
</script>			
		
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<object id=codeDs1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object>
<object id=codeDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
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
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border="0" width="845px"  cellpadding="0" cellspacing="0">
	<tr height="50px">
		<td align="left" >
			<table width="845px" border="0"  cellspacing="0" cellpadding="0" >
				<tr> 
					<td align="right">
						<table border="0"  cellpadding="0" cellspacing="0" width="100%">
							<tr>
								<td align="right" height="30px">		
									<img src="<%=dirPath%>/Sales/images/refer.gif"   	style="cursor:pointer;position:relative;left:3px;top:3px" onclick="fnSelect()">
									<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer;position:relative;left:3px;top:3px" onClick="fnApply()">
									<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer;position:relative;left:3px;top:3px"  onclick="fnCancel()">
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
            					<td align=center width=70 class="text">���������</td>
                                <td align=left bgcolor="#ffffff" >&nbsp;
									<input id="sSalDamSid" type="hidden" value="0">                                
									<input id="sSalDamCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:50px; height:20px;" maxlength="7" onBlur="fnSetting('ds_saldam')">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="��������ڸ� �˻��մϴ�" style="cursor:pointer;position:relative;left:-0px;top:0px" align=center onclick="fnPopup4();">
									<input id="sSalDamNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>																						
								</td>	
								<td align=center width=70 class="text">��û����ȣ</td>
                                <td align=left bgcolor="#ffffff">&nbsp;
								     <%=HDConstant.COMMENT_START%>
								     <object id=sAcceptNo classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
										<param name=Text 		value="">
										<param name=Alignment 	value=1>
										<param name=Format 		value="00000000000000">
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
								<td align=center width=70 class="text">����</td>
                                <td align=left bgcolor="#ffffff">&nbsp;
                                	<input type="text" name="sCustNm" value="" size=10 class="textbox"></td>
								<td align=center width=70 class="text">�۾�����</td>
								<td bgcolor=#ffffff>&nbsp;
									<%=HDConstant.COMMENT_START%>
		                            <object id=sJobType1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=codeDs>
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80">
										</object>
									<%=HDConstant.COMMENT_END%>
                                	
								</td>	
            				</tr>											                        
                            <tr bgcolor="#6f7f8d">
            					<td align=center width=70 class="text">�븮��</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<input id="sClientSid" type="hidden" value="0">                                
									<input id="sClientCd" type="text" class="textbox"  style= "position:relative;left:-0px;top:2px;width:40px; height:20px;" maxlength="5" onBlur="fnSetting('ds_client')">
									<img src="<%=dirPath%>/Sales/images/help.gif" border="0"  ALT="�븮���� �˻��մϴ�" style="cursor:pointer;position:relative;left:-0px;top:0px" align=center onclick="fnPopup1();">
									<input id="sClientNm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:120px; height:20px;" maxlength="50" onBlur="" readOnly>																						
								</td>		
            					<td align=center width=70 class="text">�۾�����</td>
                                <td align=left bgcolor="#ffffff">&nbsp;																										
									<%=HDConstant.COMMENT_START%>
		                            <object id=lc_status1 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
										<param name=ComboDataID		value=ds_status1>
										<param name=BindColumn      value="detail">
                                        <param name=BindColVal      value="detail">
										<param name=EditExprFormat	value="%,%;detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^80"></object>
									<%=HDConstant.COMMENT_END%>
								</td>																				
            					<td align=center width=70 class="text">��û����</td>
                                <td align=left bgcolor="#ffffff" width=300 colspan=3>&nbsp;
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
									<%=HDConstant.COMMENT_END%>&nbsp;-
								     <%=HDConstant.COMMENT_START%>
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
            				</tr>
            				<tr bgcolor="#6f7f8d">
            					<td align=center width=80 class="text">ȯ����(����)</td>
                                <td align=left bgcolor="#ffffff" width=300 >&nbsp;
									<%=HDConstant.COMMENT_START%>
								     <object id=sRefundDate classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
            					<td align=center width=80 class="text">ȯ����(�Ա�)</td>
                                <td align=left bgcolor="#ffffff" width=300 colspan=5>&nbsp;
									<%=HDConstant.COMMENT_START%>
								     <object id=sRefundDateTr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
                            <param name="ViewSummary"      value="1">
							<param name="Format" 			value="
				                <C> name='�۾����¡�'    ID='status_cd' width=60  align=center editlimit=2 editstyle=lookup edit=none Data='ds_status2:detail:detail_nm' show=true Sumtext=@cnt</C>
				                <C> name='��û��'  ID='accept_date'     width=70    align=center editlimit=8 edit=none show=true mask=XXXX-XX-XX</C>
				                <C> name='��û��ȣ'    ID='accept_no'  width=100 align=center editlimit=15 edit=none show=False</C>
				                <C> name='�̸�'      ID='cust_nm'   width=60  align=left editlimit=30 edit=none show=true</C>															                
				                <C> name='������ȣ'       ID='req_no'  width=100  width=100  align=center editlimit=20 edit=none show=true</C>		
				                
				                													                
				                <C> name='ȯ����(����)��'  ID='refund_date'    width=85   align=center editlimit=8 show=True  mask=XXXX-XX-XX</C>
				                <C> name='ȯ����(�Ա�)��'  ID='refund_date_tr'  width=85   align=center editlimit=8 show=True  mask=XXXX-XX-XX</C>


				               
				                
				                
				                <C> name='�븮��SID'   ID='client_sid' width=60  align=left editlimit=12 show=False</C>
				                <C> name='��û�ð�'  ID='accept_time'         align=left show=False </C>															                
				                <C> name='�����'        ID='client_dam_nm'       align=left editlimit=20 show=False</C>
				                <C> name='����ó'    ID='mobile_no'   align=left editlimit=15 show=False</C>
				                <C> name='�����'  ID='depart_date'         align=left editlimit=8 show=False</C>
				                <C> name='��߽ð�'  ID='depart_time'         align=left editlimit=8 show=False</C>															                
				                <C> name='��ûSID'   ID='accept_sid'  align=left editlimit=12 show=False</C>
				                <C> name='����SID'      ID='rsv_sid'     align=left editlimit=12 show=False</C>
				                <C> name='��SID'     ID='cust_sid'    align=left editlimit=12 show=False</C>
				                <C> name='�ֹ�/���ǹ�ȣ'    ID='manage_no'   align=left editlimit=20 show=False</C>
				                <C> name='�����'   ID='company_nm'  align=left editlimit=30 Show=False</C>
				                <C> name='����'    ID='positions'   align=left editlimit=30 Show=False</C>
				                <C> name='����ó'    ID='cust_mobile_no'   align=left editlimit=15 Show=False</C>
				                <C> name='�ǸŰ�'      ID='tour_amt'     align=left editlimit=33 Show=False</C>
				                <C> name='�Աݾ�'      ID='pay_amt'     align=left editlimit=33 Show=False</C>
				                <C> name='ȯ�Ҿ�'  ID='amt'         align=left editlimit=12 Show=False</C>
				                <C> name='ȯ�ҿ�û��'  ID='rq_amt'         align=left editlimit=12 Show=False</C>
				                <C> name='�����ڵ�'    ID='charge_cd'   align=left editlimit=1 Show=False</C>
				                <C> name='ǥ�ذ�����'    ID='charge_rate'   align=left Show=False</C>														                
				                <C> name='�۱�����'       ID='bancod'      align=left editlimit=2 Show=False</C>
				                <C> name='�۱������'        ID='bannm'       align=left editlimit=50 Show=False</C>
				                <C> name='�۱ݰ���'  ID='bank_acc_no'         align=left editlimit=20 Show=False</C>
				                <C> name='������' ID='bank_acct_nm'        align=left editlimit=32 Show=False</C>
				                <C> name='����'       ID='reason'      align=left editlimit=200 Show=False</C>
				                <C> name='ó�����' ID='desc'        align=left editlimit=200 Show=False</C>															                
							">
						</object>
						<%=HDConstant.COMMENT_END%>
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
																<param name=BindColumn      value="detail">
		                                                        <param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm">
																<param name=ListExprFormat  value="detail_nm^0^80">
																<param name=Enable  value=True>
															</object>
															<%=HDConstant.COMMENT_END%>
															
															<img src="<%=dirPath%>/Sales/images/refund_com.gif"   id=to 	    style="cursor:pointer;position:relative;left:3px;top:3px;display:none" onclick="fnStatusSet('TO')">
															<img src="<%=dirPath%>/Sales/images/refund_po.gif"    id=po 	    style="cursor:pointer;position:relative;left:3px;top:3px;display:none" onclick="fnStatusSet('PO')">
															<img src="<%=dirPath%>/Sales/images/refund_hold.gif"  id=pc		style="cursor:pointer;position:relative;left:3px;top:3px;display:none" onClick="fnStatusSet('PC')">																																														
															<img src="<%=dirPath%>/Sales/images/trans_com.gif"  id=so		style="cursor:pointer;position:relative;left:3px;top:3px;display:none" onClick="fnStatusSet('SO')">																																														
														</td>																									
													</tr>
													<tr>
														<td align=center width=100 class="text">�۾�����</td>
						                                <td align=left bgcolor="#ffffff" colspan="3">&nbsp;
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
															<input id="req_no" type="text" class="boardt04"   value="" size="20" readonly>
														</td>																																																			
													</tr>
													<tr>
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">�����</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="client_dam_nm" type="text" class="boardt04" style="text-align:left;"  value="�����" size="20" readonly>
														</td>																								
														<td height="25px" width="100px" bgcolor="#eeeeee" align=center class="text">����ó</td>
														<td height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="mobile_no" type="text" class="boardt04"  style="text-align:left;" value="010-3399-0101" size="20" readonly>
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
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��û����ȣ</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input id="accept_sid" type="hidden" value="0">&nbsp;                                
															<input id="accept_no" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px;color:black; text-align:center;" readonly>
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">
															<input type="hidden" id="rsv_sid" value="0">																									
															<input type="hidden" id="cust_sid" value="0">&nbsp;
															<input id="cust_nm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:100px; height:20px; text-align:left;" readonly>
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�ֹ�/���ǹ�ȣ</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="manage_no" type="text" class="boardt04"  size="20" value="" readonly>
														</td>																									
													</tr>																												
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="company_nm" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:132px; height:20px;color:black; text-align:left;" readonly>																						
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="positions" type="text" class="boardt04"  style= "position:relative;left:-0px;top:2px;width:132px; height:20px; text-align:left" readonly>																						
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
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">����ó</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="cust_mobile_no" type="text" class="boardt04"  size="20" value="" style="text-align: left" readonly>
														</td>
													</tr>	
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">���� | ������</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
		      												<%=HDConstant.COMMENT_START%>
								                            <object id=lc_charge classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
																<param name=ComboDataID		value=ds_charge>
																<param name=BindColumn      value="detail">
                                                    			<param name=BindColVal      value="detail">
																<param name=EditExprFormat	value="%,%;detail,detail_nm,item2">
																<param name=ListExprFormat  value="detail_nm^0^80">
																<param name=Enable2  value=false>
															</object>																										
															<%=HDConstant.COMMENT_END%>			
															<input id="charge_rate" type="text" class="boardt04"  size="7" value="" style="text-align: right" readonly>																																																																																										
														</td>	
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
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�������</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=o_bank_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">
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
														     <object id=bank_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="Hand">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	>																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>			
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">������ü</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=o_acct_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
															<%=HDConstant.COMMENT_START%>
														     <object id=acct_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="Hand">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	>																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>
																																																								
													</tr>	
													
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�ſ�ī��</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=o_card_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
															<%=HDConstant.COMMENT_START%>
														     <object id=card_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="Hand">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	>																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>	
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">���ͳ�(ī)</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=o_online_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
															<%=HDConstant.COMMENT_START%>
														     <object id=online_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="Hand">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	>																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>																																												
													</tr>	
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��ǰ��</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=o_gift_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
															<%=HDConstant.COMMENT_START%>
														     <object id=gift_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="Hand">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	>																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�����Ա�</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=o_account_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
															<%=HDConstant.COMMENT_START%>
														     <object id=account_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="Hand">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	>																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>
													</tr>	
													
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��(�Ա�/ȯ��)</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<%=HDConstant.COMMENT_START%>
														     <object id='o_tot' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Enable 		value="false">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	>																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
														     <object id='tot' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Enable 		value="false">
																<param name=Cursor	 	value="iBeam">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	>																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>			
														</td>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">������</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id=o_depo_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
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
															<%=HDConstant.COMMENT_START%>
														     <object id=depo_amt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
																<param name=Format 		value="">
																<param name=Cursor	 	value="Hand">
																<param name=Border	 	value="0">		
																<param name=InheritColor      value="true">	
																<param name=Numeric value="true">
																<param name=IsComma   value=true>
																<param name=ReadOnly  	value="true">
																<param name=ReadOnlyBackColor  	>																																																																																	
																<param name=SelectAll   value="true">																				
																<param name=SelectAllOnClick   value="true">		
																<param name=SelectAllOnClickAny  	value="false">																																																																																																																																																																																																																																																																																																																																																																																																						
															</object>
															<%=HDConstant.COMMENT_END%>																									
														</td>
													</tr>
											
													
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">�ǸŰ�</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id='tour_amt' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox">			
																<param name=Text 		value="">
																<param name=Alignment 	value=2>
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
														
														
														<td width="90px" bgcolor="#ffffff" colspan="2" rowspan="5">
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
																		<img src="<%=dirPath%>/Sales/images/print.gif"   	style="cursor:pointer;position:relative;left:3px;top:3px" onclick="pr1.preview();" >																													
																	</td>																												
																</tr>
															</table>
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
															<input id="bank_acc_no" type="text" class="boardt04" style="text-align:left;" size="20" value="" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">������</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
															<input id="bank_acct_nm" type="text" class="boardt04" style="text-align:left;" size="20" value="" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">��湮Ƚ��</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" >&nbsp;
															<input id="north_cnt" name=north_cnt type="text"  class="boardt04" size="20" value=""  style="text-align: right" readonly>
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ȯ�һ���</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="reason" type="text" class="boardt04" style="text-align:left;" size="50" value="" readonly>
														</td>
													</tr>																									
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">���</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="desc" type="text" class="boardt04"  size="50" value="" style="text-align: left" readonly>
														</td>
													</tr>																																																																																																																							
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ó�����</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left" colspan="3">&nbsp;
															<input id="desc2" type="text" class="textbox"  size="50" value="" style="text-align: left">
														</td>
													</tr>
													<tr>
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ȯ����(����)</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id='refund_date' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox" maxlength='8'>			
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
														<td  height="25px" width="100px" bgcolor="#eeeeee" align="center" class="text">ȯ����(�Ա�)</td>
														<td  height="25px"  bgcolor="#FFFFFF" align="left">&nbsp;
														     <%=HDConstant.COMMENT_START%>
														     <object id='refund_date_tr' classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F height=17 width=70 align=center class="textbox" maxlength='8'>
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
        <C>Col=client_sid       Ctrl=client_sid         Param=value </C>
        <C>Col=accept_date      Ctrl=accept_date        Param=text </C>
        <C>Col=accept_time      Ctrl=accept_time        Param=text </C>        
        <C>Col=client_dam_nm    Ctrl=client_dam_nm      Param=value </C>
        <C>Col=mobile_no        Ctrl=mobile_no          Param=value </C>
        <C>Col=depart_date      Ctrl=depart_date        Param=text </C>
        <C>Col=depart_time      Ctrl=depart_time        Param=text </C>        
        <C>Col=accept_sid       Ctrl=accept_sid         Param=value </C>
        <C>Col=accept_no        Ctrl=accept_no          Param=value </C>
        <C>Col=rsv_sid          Ctrl=rsv_sid            Param=value </C>
        <C>Col=cust_sid         Ctrl=cust_sid           Param=value </C>
        <C>Col=cust_nm          Ctrl=cust_nm            Param=value </C>
        <C>Col=manage_no        Ctrl=manage_no          Param=value </C>
        <C>Col=company_nm       Ctrl=company_nm         Param=value </C>
        <C>Col=positions        Ctrl=positions          Param=value </C>
        <C>Col=cust_mobile_no   Ctrl=cust_mobile_no     Param=value </C>
        <C>Col=pay_amt          Ctrl=pay_amt            Param=text </C>
        <C>Col=amt              Ctrl=amt                Param=text </C>
        <C>Col=rq_amt           Ctrl=rq_amt             Param=text </C>
        <C>Col=charge_cd        Ctrl=lc_charge   	 	Param=BindColVal</C>
        
        <C>Col=charge_rate      Ctrl=charge_rate        Param=value </C>        
        <C>Col=bancod           Ctrl=lc_bancod          Param=BindColVal</C>
        <C>Col=bannm            Ctrl=bannm              Param=value </C>
        <C>Col=bank_acc_no      Ctrl=bank_acc_no        Param=value </C>
        <C>Col=bank_acct_nm     Ctrl=bank_acct_nm       Param=value </C>
        <C>Col=reason           Ctrl=reason             Param=value </C>
        <C>Col=desc             Ctrl=desc               Param=value </C>    
        <C>Col=desc2            Ctrl=desc2              Param=value </C>            
        <C>Col=north_cnt        Ctrl=north_cnt          Param=value </C>  
		<C>Col=job_type         Ctrl=sJobType           Param=BindColVal </C>    
		<C>Col=status_cd        Ctrl=lc_status2         Param=BindColVal </C>    

          <C>Col=bank_amt             Ctrl=bank_amt               Param=Text </C>  
          <C>Col=acct_amt             Ctrl=acct_amt               Param=Text </C>  
          <C>Col=card_amt             Ctrl=card_amt               Param=Text </C>  
          <C>Col=gift_amt             Ctrl=gift_amt               Param=Text </C>  
          <C>Col=online_amt             Ctrl=online_amt               Param=Text </C>
          <C>Col=account_amt             Ctrl=account_amt               Param=Text </C>  
          <C>Col=depo_amt             Ctrl=depo_amt               Param=Text </C>          
          <C>Col=o_bank_amt             Ctrl=o_bank_amt               Param=Text </C>  
          <C>Col=o_acct_amt             Ctrl=o_acct_amt               Param=Text </C>  
          <C>Col=o_card_amt             Ctrl=o_card_amt               Param=Text </C>  
          <C>Col=o_gift_amt             Ctrl=o_gift_amt               Param=Text </C>
          <C>Col=o_online_amt             Ctrl=o_online_amt               Param=Text </C>
          <C>Col=o_account_amt             Ctrl=o_account_amt               Param=Text </C>   
          <C>Col=o_depo_amt             Ctrl=o_depo_amt               Param=Text </C>          

          <C>Col=tour_amt             Ctrl=tour_amt               Param=Text </C>          
          <C>Col=refund_date          Ctrl=refund_date               Param=Text </C>
          <C>Col=refund_date_tr       Ctrl=refund_date_tr           Param=Text </C>
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
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	

<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

