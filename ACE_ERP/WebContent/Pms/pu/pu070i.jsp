<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ����_ǰ��
 * ���α׷�ID 	 : PMS/PU070I
 * J  S  P		 	 : pu070i.jsp
 * �� �� ��		 : Pu070I
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2011-12-01
 * �������		 : ����_ǰ��
 * [ �������� ][������] ����
 * [2011-12-01][�ڰ汹] �ű�
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>

<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	
	  //���ϸ���Ʈ html �����
	    StringBuffer sb = new StringBuffer();
		String real_fileList ="";	//���� �ҷ��ͼ� 
		String sys_fileList ="";
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1;
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");
		cfStyleGrid(getObjectFirst("gr_tender"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail"), "comn");
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
       
//        v_fr_con_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_con_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

        v_fr_con_date.Text = "20130101";
        //v_to_con_date.Text = "20111114";


       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//�۾�����(��ȸ)
       ds_con_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU001&s_item1=Y";
       ds_con_status.Reset();	//�۾�����
       ds_rqst_use.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU002&s_item1=Y";
       ds_rqst_use.Reset();	//���ó
       ds_put_wh.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU003&s_item1=Y";
       ds_put_wh.Reset();	//����â��
       ds_terms_trans.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU004&s_item1=Y";
       ds_terms_trans.Reset();	//�ε�����
       ds_way_chk.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU005&s_item1=Y";
       ds_way_chk.Reset();	//�˻���
       ds_terms_pay.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU006&s_item1=Y";
       ds_terms_pay.Reset();	//��������
       ds_bur_trans.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU007&s_item1=Y";
       ds_bur_trans.Reset();	//��ݺ�δ�
       
      
      
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu070I",
            "JSP(O:DS_DEFAULT=ds_default,O:DS_TENDER=ds_tender,O:DS_DETAIL=ds_detail)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }
    
    <%//���� ��ȸ  %>
    function fnSelect() {
    
    	//alert("1");
		if (ds_default.IsUpdated || ds_tender.IsUpdated|| ds_detail.IsUpdated) {
			alert("�������� ���� �ֽ��ϴ�.");
		} else {
		    v_job="S";
		    
	        var fr_date = v_fr_con_date.Text.trim();
	        var to_date = v_to_con_date.Text.trim();
	
			
	        if(fr_date.length!=8) {
	            alert("ǰ������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("ǰ������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	    	}
	    	
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  //+ ",v_site_sid="+ v_site_sid.value
	                  + ",v_fr_con_date=" + fr_date
	                  + ",v_to_con_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index) ;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu070I",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
	        
	         //÷������ �ɰ���
	        var real_fileList="";
			var sys_fileList="";
				
			var real_fileList =txt_real_file.value;
			var sys_fileList =txt_sys_file.value;
		
			var real_file10= new Array();
			var sys_file10= new Array();
		
			real_file10 = real_fileList.split(":");	//�迭�� ����
			sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
			var real_file1=real_file10.slice(0,1);
			var sys_file1=sys_file10.slice(0,1);	
			var real_file2=real_file10.slice(1,2);
			var sys_file2=sys_file10.slice(1,2);	
			var real_file3=real_file10.slice(2,3);
			var sys_file3=sys_file10.slice(2,3);	
	        
	        
	        
		};
    }    

    <%//tender ��ȸ%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rqst_sid="+getObjectFirst("ds_default").NameValue(row, "RQST_SID")
                    + ",v_est_sid="+getObjectFirst("ds_default").NameValue(row, "EST_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu070I",
            "JSP(O:DS_TENDER=ds_tender)",
            v_param);
        tr_post(tr2);
        fnSelectDetail2(1);
    }

    <%//detail ��ȸ%>
    function fnSelectDetail2(row) {
        //v_tender_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_est_sid="+getObjectFirst("ds_tender").NameValue(row, "EST_SID")
                    + ",v_vend_cd="+getObjectFirst("ds_tender").NameValue(row, "VEND_CD");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu070I",
            "JSP(O:DS_DETAIL=ds_detail)",
            v_param);
        tr_post(tr2);
    }

	<%//���� %>
	function fnApply(){
		v_job = "A";
				
		if ( ds_detail.CountRow==0 ) { 
			alert("��� �ϳ��� ����ǰ���� ��ȸ �ϼž� �մϴ�."); 
			return;
	 	} 	

		if (ds_default.IsUpdated	||	ds_tender.IsUpdated	||	ds_detail.IsUpdated) {
			  //alert("1");
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu070I",
                "JSP(I:DS_DEFAULT=ds_default,I:DS_TENDER=ds_tender,I:DS_DETAIL=ds_detail)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
        		fnSelect();
    	}else
     		alert("������Ʈ�� ���� �����ϴ�.");
	}

	<%// �׸��� ���� ��� %>
	function fnCancel() {
        ds_default.undoall();
        ds_tender.undoall();
		window.status="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
	/******************************************************************************
		Description : ���缱  popup
	******************************************************************************/
	
	function fnApproval() {
				var arrParam	= new Array();
				var arrResult	= new Array();
				var strURL;
				var strPos;
				strURL = "<%=dirPath%>/Sales/help/sy040h.jsp?";
				strPos = "dialogWidth:580px;dialogHeight:530px;status:no;scroll:no;resizable:no";
	
				arrResult = showModalDialog(strURL,arrParam,strPos);
				//alert("arrResult===========");
				//alert(arrResult);
				sApproveLine = arrResult; // ru
				//alert("sApproveLine==========");
				//alert(sApproveLine);
		}
	
	
	/******************************************************************************
		Description : ���  popup
	******************************************************************************/
	function fnDraft() {
	
		if(ds_default.CountRow ==0){
			alert("ǰ�� �� ������ ��ȸ �� �ּ���");
			return;
		}
		
		if(sApproveLine==""||sApproveLine=="undefined"){
		   alert("���缱������ ���� �ʾҽ��ϴ�.");
		   return;
		}
		
		var result="";
	    var arrParam	= new Array();
	    var arrResult	= new Array();
		//alert(sApproveLine);	
		arrParam[0]="330";  // AP006 ( 010 ������� , 020 ��������, 030 ��������, 040 ��������, 100 ���񽺿�û .310 ����û��, 320 ����û������, 330 ����ǰ��)
		arrParam[1]=ds_default.namevalue(ds_default.rowposition,"EST_SID");  //����SID
		arrParam[2]=sApproveLine;      // ���缱���� 
		arrParam[4]=ds_default.namevalue(ds_default.rowposition,"RQST_SID");  //û��SID
		arrParam[5]=ds_tender.namevalue(ds_tender.rowposition,"VEND_CD");   //�ŷ�ó�ڵ�
		
		//alert(arrParam);
		strURL = "<%=dirPath%>/Pms/help/pu030h.jsp?";
		strPos = "dialogWidth:1000px;dialogHeight:900px;status:no;scroll:no;resizable:no";
		
		result = showModalDialog(strURL,arrParam,strPos);
		      
		if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
		} 
	} 

	<%//���ް��� ��- ��ȸ%>
    function fnSelSitePopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnCtSitePop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_site_nm.value = arrParam[1];	//NM
            v_site_sid.value = arrParam[2];	//SID
        } else {
			fnSelSiteCleanup();
        }               
    }
    
	<%//���� ��- �Է�%>
    function fnSelSitePopup1(dirPath) {
        if(ds_default.CountRow==0){
            alert("�ű� ��ư���� �� ���� �߰��Ͻñ� �ٶ��ϴ�.");
            return;
        }

        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtSitePop1(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_site_sid1.value = arrParam[0];//SITE_SID //
			v_rqst_date.text = arrParam[1];//DATE_CT //
			v_site_nm1.value = arrParam[2];//SITE_NM //
			//v_orderer_sid.value = arrParam[3];//ORDERER_SID //
			//v_orderer_nm.value = arrParam[4];//ORDERER_NM //
			// = arrParam[5]; //SITE_SEQ_CT_CD //
			// = arrParam[6]; //SITE_SEQ_CH_CD //
			//v_site_seq_ct.value = arrParam[7]; //SITE_SEQ_CT //
			//v_site_seq_ch.value = arrParam[8]; //SITE_SEQ_CH //
			//v_amt_ct_tot.text = arrParam[9]; //AMT_CT_TOT //
			//v_amt_ct.text = arrParam[10]; //AMT_CT //
			//v_amt_ct_vat.text = arrParam[11]; //AMT_CT_VAT //
			//v_ct_date_begin.text = arrParam[12]; //DATE_BEGIN //
			//v_ct_date_end.text = arrParam[13]; //DATE_END //

        } else {
			fnSelSiteCleanup1();
        }               
    }
	function fnSelSiteCleanup(){
        v_site_nm.value = "";
        v_site_sid.value  = "";
    }
    function fnSelSiteCleanup1(){
        v_site_nm1.value = "";
        v_site_sid1.value  = "";
    }

	function fnExcel() {
		if(ds_default.RowCount==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        } 
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:ǰ�Ǽ�; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("ǰ�Ǽ�","ǰ�Ǽ�.xls", 8);

	    if(ds_tender.RowCount==0){
            return;
        }
        
        getObjectFirst("gr_tender").SetExcelTitle(0, "");
        getObjectFirst("gr_tender").SetExcelTitle(1, "value:��������; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_tender").GridToExcel("��������","��������.xls", 8);
        
         if(ds_detail.RowCount==0){
            return;
        } 
        getObjectFirst("gr_detail").SetExcelTitle(0, "");
        getObjectFirst("gr_detail").SetExcelTitle(1, "value:����ǰ��; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_detail").GridToExcel("����ǰ��","����ǰ��.xls", 8);
	}	
	
	function fnPrepayAmt(){	//���ޱ� ����
		v_prepay_amt.value = Math.round(v_prepay_amt_rate.text  * v_tot_fn_est_amt.value)/100   +Math.round(v_prepay_amt_rate.text  * v_tot_fn_est_amt.value)/1000      ;
	}
	function fnChAmt(){	//������ຸ���� ����
		v_ch_amt.value = Math.round(v_ch_rate.text  * v_tot_fn_est_amt.value)/100   +Math.round(v_ch_rate.text  * v_tot_fn_est_amt.value)/1000      ;
	}
	function fnDbAmt(){	//���ں��������� ����
		v_db_amt.value = Math.round(v_db_rate.text  * v_tot_fn_est_amt.value)/100 +Math.round(v_db_rate.text  * v_tot_fn_est_amt.value)/1000        ;
	}
	
	//÷������(1) �ٿ�ε�_����
    function fnFile(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//�迭�� ����
		sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
				
		if(real_file1==''){
			alert("÷�������� �������� �ʽ��ϴ�")
			return;
		}else if(real_file1.length==1){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //�
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file1+'&sysfilename='+sys_file1; //����

		}

	}
	//÷������(2) �ٿ�ε�_����
    function fnFile2(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//�迭�� ����
		sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	

		//alert(real_file2);				
		//alert(sys_file2);						
		//alert(real_file2.length);
		
		if(real_file2.length==0){
		alert("2��° ������ �������� �ʽ��ϴ�")
		}
		if(real_file2.length>0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //�
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file2+'&sysfilename='+sys_file2; //����

		}
	}
	//÷������(3) �ٿ�ε�_����
    function fnFile3(){
		var real_fileList="";
		var sys_fileList="";
		var fileHtml="";		
				
		var real_fileList =txt_real_file.value;
		var sys_fileList =txt_sys_file.value;
		
		var real_file10= new Array();
		var sys_file10= new Array();
		
		real_file10 = real_fileList.split(":");	//�迭�� ����
		sys_file10 = sys_fileList.split(":");	//�迭�� ����
		
		var real_file1=real_file10.slice(0,1);
		var sys_file1=sys_file10.slice(0,1);	
		var real_file2=real_file10.slice(1,2);
		var sys_file2=sys_file10.slice(1,2);	
		var real_file3=real_file10.slice(2,3);
		var sys_file3=sys_file10.slice(2,3);	
		
		if(real_file3.length==0){
		alert("3��° ������ �������� �ʽ��ϴ�")
		}
		if(real_file3.length >0){
			location.href = '/Pms/common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //�
			//location.href = '../common/sys/download.jsp?dir=pu010&filename='+real_file3+'&sysfilename='+sys_file3; //����
		}

	}
</script>
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
<%//ǰ������ Ŭ���� �������� ��ȸ %>
	<script language=javascript for="gr_default" event="OnClick(Row, Colid)">
		v_job="SD";
		if (ds_default.IsUpdated || ds_tender.IsUpdated) {
			alert("��������  �۾��� ���� ��쿡�� ��ȸ�� �Ҽ� �����ϴ�!");
			return false;
		} else {
		    var row2=ds_tender.countrow;
		    if(Row==0) return;
		    if(v_default_row==Row){
				return;
			}else{
			    fnSelectDetail(Row);				
		    }
		};
	</script>
<%//�������� Ŭ���� ����ǰ�� ��ȸ %>
	<script language=javascript for="gr_tender" event="OnClick(Row, Colid)">
			    fnSelectDetail2(Row);				
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
	}
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>
alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
</script>
<script language=javascript for=v_prepay_amt_rate event="OnKillFocus()">	<%//���ޱ��� �Է��� �������� ��%>
		fnPrepayAmt();
</script>
<script language=javascript for=v_ch_rate event="OnKillFocus()">	<%//������ຸ������ �Է��� �������� ��%>
		fnChAmt();
</script>
<script language=javascript for=v_db_rate event="OnKillFocus()">	<%//���ں����������� �Է��� �������� ��%>
		fnDbAmt();
</script>
<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			ds_tender.clearall();
			}else{
				fnSelectDetail(row);
			}
		}
	</script>
	<script language=javascript for="ds_tender" event="OnLoadCompleted(row)">
        window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
       			ds_detail.clearall();
			}else{
				fnSelectDetail2(row);
			}
		}
	</script>
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_tender classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>
<object id=ds_detail classid=<%=HDConstant.CT_DATASET_CLSID%>> 
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_srch_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��ȸ: �۾����� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_con_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �۾����� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_use classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ó -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_put_wh classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ����â�� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_date_ddl classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_terms_trans classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �ε����� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_way_chk classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �˻��� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_terms_pay classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_bur_trans classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ������δ� -->
    <param name="SyncLoad"  value="True">
</object>
<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"   value="">
    <param name="Action"     value="">
    <param name="KeyValue"   value="">
    <param name="Parameters" value="">
</object>
<%=HDConstant.COMMENT_END%>
</head>
<jsp:include page="/Common/sys/body_s08.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='845px'>
                     <tr>
                    	<td align=left >
							<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="cursor:pointer" onclick="fnApproval()">
							<img src="<%=dirPath%>/Sales/images/ap_up.gif"		style="cursor:pointer" onclick="fnDraft()">
						</td>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
							<!--<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:pointer"  onclick="fnCancel()">-->
							<!--<img src="<%=dirPath%>/Sales/images/delete.gif" 	style="cursor:pointer" onClick="fnDeleteRowDsDefault()" >-->
							<!--<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	onClick="fnExcel()">	-->	<!-- ���� -->
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td width='845px'>
                <table border='0' cellpadding="0" cellspacing="1"  width='845px'>
                    <tr height='25px'>
                    	<td>
                    		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
                    			<tr>
			                        <td align=left class="text"  width="70">ǰ������</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_con_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>&nbsp;~&nbsp;
			                            <object id=v_to_con_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                            <%=HDConstant.COMMENT_END%>                                                                             
			                        </td>
                    				<td align=left class="text">�۾�����</td>
			                        <td align=left bgcolor="#ffffff" WIDTH="220">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_srch_rqst_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_srch_rqst_status>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
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
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="300px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='285px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="0">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name=SortView  value="Right">
                                <param name="Format"            value="
                                     <C> name='�۾�����'	ID='CON_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	suppress=1</C>
                                     <C> name='�۾�����'	ID='CON_STATUS_NM'    	width=80 	align=CENTER	Edit=None 		show=TRUE	</C>
                                     <C> name='ǰ������' 	ID='DATE_CON'    		width=80 	align=CENTER	Edit=None 		sort=true</C>
                                     <C> name='ǰ�ǹ�ȣ'	ID='CON_NO' 				width=120 align=CENTER	Edit=None		sort=true</C>
                                     <C> name='ǰ��SID'    ID='CON_SID'       		width=60 	align=CENTER	Edit=None	 	 show=false decao=0	Edit=None </C>                                     
                                     <C> name='����SID'    ID='EST_SID'       			width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None </C>
                                     <C> name='û������' 	ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='û����ȣ' 	ID='RQST_NO'	    		width=150 	align=CENTER	Edit=None 	sort=true</C>
                                     <C> name='û��SID'    ID='RQST_SID'       		width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='�����ڵ�'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='��������'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='�����'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None		show=false</C>
                                     <C> name='����SID'    ID='SITE_SID'       		width=60 	align=CENTER	Edit=None 		 show=false  </C>
                                     <C> name='���ó'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None		show=false</C>
                                     <C> name='��������'		ID='DATE_DDL'    		width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='����â��'		ID='PUT_WH' 			width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='�ε�����'    	ID='TERMS_TRANS' width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='�˻���'		ID='WAY_CHK' 			width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='��������'		ID='TERMS_PAY'    	width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='��ݺ�δ�'	ID='BUR_TRANS' 		width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='������ �ؼ�����'    ID='OSV_PVR'  width=60 	align=CENTER	Edit=None 		show=false</C>
                                     <C> name='Ư�����'		ID='CON_NOTE' 		width=60 	align=CENTER	Edit=None		show=false</C>
                                     <C> name='���ޱ���'    				ID='PREPAY_AMT_RATE'  width=60 	align=CENTER	Edit=None	 	limitdec=0 show=false decao=0	 </C>                                     
									 <C> name='���ޱ�'    					ID='PREPAY_AMT'   			width=60 	align=CENTER	Edit=None	 	 show=false Dec=0	 </C>                                                                          
                                     <C> name='���ຸ������'    		ID='CH_RATE'       		 	width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>
                                     <C> name='���ຸ����'    			ID='CH_AMT'       			    width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>
                                     <C> name='���ں�����������'      ID='DB_RATE'       		 	width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>                                     
                                     <C> name='���ں���������'         ID='DB_AMT'       		   	 	width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>                                     
                                     <C> name='�����Ⱓ' 					ID='TERM_GRN'    		 	width=80 	align=CENTER	Edit=None 		 show=false decao=0	 </C>                                     
                                     <C> name='�����ݾ�'         			ID='TOT_FN_EST_AMT'       		width=60 	align=CENTER	Edit=None 		 show=false decao=0	 </C>                                     
                                     
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">�۾�����</td>
									<td bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_con_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_con_status>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=ReadOnly    value="true">											
											<param name="Editable"          value="false">											
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^80">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td width="120px" class="text">���ó</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_rqst_use classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_rqst_use>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="true">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									<input type="hidden"  name='v_rqst_sid' id='v_rqst_sid'>
									<input type="hidden"  name='v_est_sid' id='v_est_sid'>
									</td>
								</tr>	
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>ǰ������</b></font></td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_con classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                                <param name=Enable  value=true>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
									<td width="120px" class="text">ǰ�ǹ�ȣ</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_con_no' id="v_con_no" style="width:130px;" class='input01'  readOnly="readonly"> </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">û������</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=SelectAll   value="true">
			                                <param name=Enable  value=false>
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
									<td width="120px" class="text">û����ȣ</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_rqst_no' id="v_rqst_no" style="width:130px;" class='input01'   readOnly="readonly"> 
										<input type="hidden"  name='v_pu_site_cd' id='v_pu_site_cd'>
										<input type="hidden"  name='v_pu_empno' id='v_pu_empno'>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">�����</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid1' id='v_site_sid1'>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>��������</b></font></td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_ddl classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
									<td width="120px" class="text">����â��</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_put_wh classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_put_wh>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>�ε�����</b></font></td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_terms_trans classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_terms_trans>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=true>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td width="120px" class="text"><font color="green"><b>�˻���</b></font></td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_way_chk classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_way_chk>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=true>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>��������</b></font></td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_terms_pay classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_terms_pay>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=true>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td width="120px" class="text"><font color="green"><b>��ݺ�δ�</b></font></td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_bur_trans classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_bur_trans>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name="Editable"          value="false">
											<param name=ReadOnly    value="false">
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=true>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>������Ư�����</b></font></td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_osv_pvr' id="v_osv_pvr" style="width:100px;" class='testbox'  >
                                    </td>
									<td width="120px" class="text"><font color="green"><b>ǰ��Ư�����</b></font></td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_con_note' id="v_con_note" style="width:100px;" class='testbox'  >
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>���ޱ���</b></font></td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_prepay_amt_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="false">                                                                                                                                                                                                             
			                                <param name=Numeric			value=true>
			                                <param name=IsComma			value=true>
			                                <param name=Enable  value=true>
			                            </object><%=HDConstant.COMMENT_END%>  &nbsp;%
									</td>
									<td width="120px" class="text">���ޱ�</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_prepay_amt' id="v_prepay_amt" style="width:130px;" limitdec=0 class='input01'  readOnly="readonly"> </td>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>������ຸ������</b></font></td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_ch_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="false">                                                                                                                                                                                                             
			                                <param name=Numeric			value=true>
			                                <param name=IsComma			value=true>
			                                <param name=Enable  value=true>
			                                
			                            </object><%=HDConstant.COMMENT_END%>  &nbsp;%
									</td>
									<td width="120px" class="text">������ຸ����</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_ch_amt' id="v_ch_amt" style="width:130px;" class='input01'  readOnly="readonly"> </td>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text" ><font color="green"><b>���ں�����������</b></font></td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_db_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="false">                                                                                                                                                                                                             
											<param name=Numeric			value=true>	
											<param name=IsComma			value=true>		                               
			                                <param name=Enable  value=true>
			                            </object><%=HDConstant.COMMENT_END%>  &nbsp;%
									</td>
									<td width="120px" class="text">���ں���������</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_db_amt' id="v_db_amt" style="width:130px;" class='input01'  readOnly="readonly"> </td>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text"><font color="green"><b>�����Ⱓ</b></font></td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_term_grn' id="v_term_grn" style="width:80px;" class='testbox'  >&nbsp;����
									<input type="hidden"  name='v_tot_fn_est_amt' id='v_tot_fn_est_amt'>
                                    </td>
                                   	<td width="120px" class="text">��������</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_pu_empnm' id="v_pu_empnm" style="width:130px;" class='input01'  readOnly="readonly"> </td>
								</tr>
								<tr>
									<td width="120px" class="text">÷������</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;
                                        <input type="hidden"  name='txt_sys_file' id='txt_sys_file'>
                                        <input type="text" name='txt_real_file' id="txt_real_file" style="width:310px;" class='input01'   readOnly="readonly">
                                        <input type="text" name='real_file1' id="real_file1" style="width:20px;" class='input01' value="(1)"  onclick="fnFile()" readOnly="readonly">
					                    <input type="text" name='real_file2' id="real_file2" style="width:20px;" class='input01'   value="(2)" onclick="fnFile2()" readOnly="readonly">
					                    <input type="text" name='real_file3' id="real_file31" style="width:20px;" class='input01'   value="(3)" onclick="fnFile3()" readOnly="readonly">
									</td>
								</tr>
							</table>
                        </td>
                    </tr>
                </table>
			</td>
        </tr>
        <tr>
        	<td align=right>
        	<b>[��������]</b>
        	</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_tender" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='80px' border='1'>
                    <param name="DataID"            value="ds_tender">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='����' 			ID={CurRow}	   			width=100 		align=CENTER	edit=none show=TRUE</C>
	                     <C> name='EST_SID' 		ID='EST_SID'	   		width=80 		align=CENTER	edit=none  show=false </C>
                         <C> name='�ŷ�ó�ڵ�' 		ID='VEND_CD'   		width=80 		align=CENTER	edit=none show=false</C>
                         <C> name='���»��' 		ID='VEND_NM'    		width=200 	align=CENTER	edit=none</C>
                         <C> name='�����ݾ�'		ID='TOT_EST_AMT'  width=90 		align=right 	 decao=0 edit=none </C>
                         <C> name='�����ݾ�'		ID='TOT_FN_EST_AMT'  	width=90 		align=right 	 decao=0	edit=none</C>
                         <C> name='������'			ID='UD_EST_AMT'  	width=90 		align=right 	 decao=0 edit=none</C>                                                  
                         <C> name='��������ȣ'		ID='EST_NO'    		width=150 	show=false 	 align=CENTER	edit=none</C>
                         <C> name='��������(%)'		ID='UD_RATE'  	width=100 		align=right 	 decao=0 edit=none</C>                                                  
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>
            </td>
        </tr>
     	<tr>
            <td align=right>
				<b>[����ǰ��]</b>
			</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_detail" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='180px' border='1'>
                    <param name="DataID"            value="ds_detail">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                     <param name="ViewSummary"       value="1">
                    <param name="Format"            value="
                         <C> name='EST_SID' 			ID='EST_SID'   			width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='RQST_SID' 		ID='RQST_SID'   		width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='ITEM_SID' 		ID='ITEM_SID'   		width=80 		align=CENTER		edit=none  show=false </C>
                         <C> name='ǰ��' 				ID='ITEM_NM'    		width=150 	align=CENTER	 	edit=none sumtext='��'  sumtextalign='right'</C>
                         <C> name='�԰�' 				ID='ITEM_SIZE'   		width=150 		align=CENTER	 	edit=none sumtext='@count' sumtextalign='right'</C>
                         <C> name='����' 				ID='ITEM_UNIT'   		width=50 		align=CENTER		edit=none sumtext='ǰ��' sumtextalign='left'</C>
                    <G> name='����'
                         <C> name='����' 		ID='DG_CNT'   		width=50 		align=right		edit=none </C>
                         <C> name='�ܰ�'    	ID='DG_AMT'    	    width=70 		align=right	 show=true decao=0	 </C>
                         <C> name='�ݾ�'   		ID='DG_SUM_AMT'   width=80 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
                    </G>
					<G> name='����'
                         <C> name='����' 		ID='RQST_CNT'   		width=50 		align=right		edit=none </C>
                         <C> name='�ܰ�' 		ID='YS_AMT'   			width=70 		align=right	 decao=0 	</C>
                         <C> name='�ݾ�'    	ID='YS_SUM_AMT'    width=80 		align=right	 sumtext='@sum' sumtextalign='right'	show=true edit=none	decao=0	 </C>
                    </G>
					<G> name='����'
                         <C> name='����' 		ID='EST_CNT'   		width=50 		align=right		edit=none </C>
                         <C> name='�ܰ�' 		ID='FN_EST_AMT'   			width=70 		align=right	 decao=0 	</C>
                         <C> name='�ݾ�'    	ID='FN_SUM_AMT'    width=80 		align=right	 show=true decao=0	 sumtext='@sum' sumtextalign='right'	</C>
                    </G>
                         <C> name='�������' 				ID='EST_ITEM_NOTE'    	width=150 	align=LEFT	 	 edit=none</C>                         
                         <C> name='�����ݾ�'    		ID='SUM_AMT'    	    width=80 		align=right	 show=false decao=0	sumtext='@sum' sumtextalign='right'	 </C>
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>

              
            </td>
        </tr>
    </table>
<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	<%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_default">
	             <param name=BindInfo    value="
					<C>Col=CON_STATUS     	 Ctrl=lc_con_status    	Param=BindColVal </C>
					<C>Col=CON_STATUS_NM     	 Ctrl=v_con_status_nm    	Param=value </C>
					<C>Col=RQST_DATE       	 Ctrl=v_rqst_date        	Param=Text </C>
					<C>Col=DATE_DDL       	 Ctrl=v_date_ddl         	Param=Text </C>					
					<C>Col=DATE_CON       	 Ctrl=v_date_con        	Param=Text </C>
					<C>Col=DATE_FR       	 	 Ctrl=v_date_fr  	     	Param=Text </C>
					<C>Col=DATE_TO       	 	 Ctrl=v_date_to        	 	Param=Text </C>
					<C>Col=RQST_NO       	 	 Ctrl=v_rqst_no        	 	Param=value </C>
					<C>Col=CON_NO       	 	 Ctrl=v_con_no        	 	Param=value </C>					
					<C>Col=RQST_SID	       	 Ctrl=v_rqst_sid 	     	Param=Value </C>
					<C>Col=CON_SID		       	 Ctrl=v_con_sid 	     	Param=Value </C>					
					<C>Col=EST_SID		       	 Ctrl=v_est_sid 	     	Param=Value </C>										
					<C>Col=RQST_USE     		 Ctrl=lc_rqst_use	     	Param=BindColVal </C>
					<C>Col=SITE_CD       	 	 Ctrl=v_pu_site_cd     	Param=value </C>
					<C>Col=PUT_WH     		 	 Ctrl=lc_put_wh	     	Param=BindColVal </C>
					<C>Col=TERMS_TRANS     Ctrl=lc_terms_trans  	Param=BindColVal </C>
					<C>Col=WAY_CHK     		 Ctrl=lc_way_chk	     	Param=BindColVal </C>
					<C>Col=TERMS_PAY     	 Ctrl=lc_terms_pay    	Param=BindColVal </C>
					<C>Col=BUR_TRANS     	 Ctrl=lc_bur_trans     	Param=BindColVal </C>
					<C>Col=OSV_PVR       	 	 Ctrl=v_osv_pvr		     	Param=value </C>
					<C>Col=CON_NOTE	       	 Ctrl=v_con_note	    	Param=Value </C>					
					<C>Col=SITE_NM       	 	 Ctrl=v_site_nm1        	Param=value </C>
					<C>Col=SITE_SID	       	 	 Ctrl=v_site_sid1 	     	Param=Value </C>
					<C>Col=PU_EMPNO    	 	 Ctrl=v_pu_empno   		Param=value </C>
					<C>Col=PU_EMPNM    	 	 Ctrl=v_pu_empnm   		Param=value </C>
					<C>Col=PREPAY_AMT_RATE    Ctrl=v_prepay_amt_rate   	Param=text </C>
					<C>Col=PREPAY_AMT    			Ctrl=v_prepay_amt   		Param=value </C>
					<C>Col=CH_RATE    	 	 			Ctrl=v_ch_rate   		Param=text </C>
					<C>Col=CH_AMT    	 	 			Ctrl=v_ch_amt   		Param=value </C>
					<C>Col=DB_RATE    	 	 			Ctrl=v_db_rate   		Param=text </C>
					<C>Col=DB_AMT    	 	 			Ctrl=v_db_amt   		Param=value </C>
					<C>Col=TERM_GRN    	 	 		Ctrl=v_term_grn   		Param=value </C>																				
					<C>Col=TOT_FN_EST_AMT  	 	 		Ctrl=v_tot_fn_est_amt		Param=value </C>			
					<C>Col=real_file	    	 	 Ctrl=txt_real_file		 	 	Param=value </C>
					<C>Col=sys_file	    	 	 Ctrl=txt_sys_file		 		Param=value </C>																						
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		