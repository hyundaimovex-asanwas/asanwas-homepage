<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ����_ǰ����ȸ
 * ���α׷�ID 	 : PMS/PU070s
 * J  S  P		 	 : pu070s.jsp
 * �� �� ��		 : Pu070S
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2011-12-01
 * �������		 : ����_ǰ��
 * [ �������� ][������] ����
 * [2011-12-01][�ڰ汹] �ű�
 * [2015-04-15][�ɵ���] ���»� �׸��忡�� �������� ǥ��(�÷���, decao �Ӽ�)
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
       
       // v_fr_con_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
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
	                  + ",v_fr_con_date=" + fr_date
	                  + ",v_to_con_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index)
	                  + ",v_rqst_no="+ sRqstNo.value
	                  + ",v_site_sid="+ v_site_sid.value;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu070S",
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
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu070S",
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
        
        //alert(v_param);
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu070S",
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
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu070S",
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
		strPos = "dialogWidth:740px;dialogHeight:720px;status:no;scroll:no;resizable:no";
		
		result = showModalDialog(strURL,arrParam,strPos);
		      
		if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
		} 
	} 

	<%//����� ��- ��ȸ%>
    function fnSelSitePopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnPuSitePop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_site_nm.value = arrParam[1];	//NM
            v_site_sid.value = arrParam[4];	//SID
        } else {
			fnSelSiteCleanup();
        }               
    }
    
	function fnSelSiteCleanup(){
	    v_site_nm.value = "";
	    v_site_sid.value  = "";
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
		v_prepay_amt.value = Math.round(v_prepay_amt_rate.text  * v_tot_fn_est_amt.value)/100         ;
	}
	function fnChAmt(){	//������ຸ���� ����
		v_ch_amt.value = Math.round(v_ch_rate.text  * v_tot_fn_est_amt.value)/100         ;
	}
	function fnDbAmt(){	//���ں��������� ����
		v_db_amt.value = Math.round(v_db_rate.text  * v_tot_fn_est_amt.value)/100         ;
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

	/*
	 * ����Ʈ
	 */
	function fnPrint() {
	
        	//�⺻���� ��ȸ 
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                       + ",v_est_sid=" + v_est_sid.value;
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT6=ds_default6)",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
		     
		     // ��ü����������
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                        + ",v_est_sid=" + v_est_sid.value
		                       + ",v_rqst_sid=" + v_rqst_sid.value;
		                      // alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT7=ds_default7 )",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
	     
	   	     // ����ǰ��
	         var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
								 + ",v_est_sid=" + v_est_sid.value
		                       + ",v_vend_cd="+getObjectFirst("ds_tender").NameValue(1, "VEND_CD");
		                       //alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT8=ds_default8 )",  param);
		    // prompt('',ds_default.dataid);   
		     tr_post(tr1);
		     
		     
		 	// ����(ǰ��)��������		    
	     	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                     + ",v_rqst_sid=" + v_est_sid.value;
		 	//alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT9_1=ds_default9_1)",  param);
		     tr_post(tr1);   
	       	
	       	// û��(����)��������		    
	     	var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		                     + ",v_rqst_sid=" + v_rqst_sid.value;
		 	//alert(param);
		     ln_TRSetting(tr1,"<%=dirPath%><%=HDConstant.PATH_HELP%>Pu030H", "JSP(O:DS_DEFAULT9=ds_default9)",  param);
		     tr_post(tr1);
		     
     		pr1.PreView();
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
<object id=ds_default6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ--%>
<object id=ds_default7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ_����1--%>
<object id=ds_default8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ_����2--%>
<object id=ds_default9_1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ_����3--%>
<object id=ds_default9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
    <param name="SyncLoad"  value="False">
</object><%--����Ʈ_����4--%>

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
                    	<td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:pointer"	onClick="fnExcel()">		<!-- ���� -->
							<img src="<%=dirPath%>/Sales/images/print.gif"  style="cursor:pointer"  onclick="fnPrint()">		<!-- �μ� -->							
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
			             		<tr>
									<td align=left width="70px" class="text">û����ȣ</td>
									<td align=left bgcolor="#ffffff">&nbsp;<input type="text" name="sRqstNo" value="" size="20" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"></td>			                        
								    <td align="center" class="text" width="70">�����</td>
                                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="�� �����">
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
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
               				    <param name=SortView  value="Right">
                                <param name="Format"            value="
                                     <C> name='�۾�����'	ID='CON_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	suppress=1</C>
                                     <C> name='�۾�����'	ID='CON_STATUS_NM'    	width=80 	align=CENTER	Edit=None 		show=TRUE	</C>
                                     <C> name='û������' 	ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 		sort=true</C>
                                     <C> name='ǰ������' 	ID='DATE_CON'    		width=80 	align=CENTER	Edit=None 		sort=true</C>
                                     <C> name='û����ȣ' 	ID='RQST_NO'	    		width=200 	align=CENTER	Edit=None 	sort=true</C>
                                     <C> name='ǰ�ǹ�ȣ'	ID='CON_NO' 				width=100 align=CENTER	Edit=None		sort=true</C>
                                     <C> name='ǰ��SID'    ID='CON_SID'       		width=60 	align=CENTER	Edit=None	 	 show=false decao=0	Edit=None </C>                                     
                                     <C> name='����SID'    ID='EST_SID'       			width=60 	align=CENTER	Edit=None 		 show=false decao=0	Edit=None </C>
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
									<td width="120px" class="text">ǰ������</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_con classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="true">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                                <param name=Enable  value=false>
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
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_rqst_no' id="v_rqst_no" style="width:130px;" class='input01'   readOnly="readonly"> </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">�����</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid1' id='v_site_sid1'>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">����ݷ�����</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_ap_desc_re' id="v_ap_desc_re" style="width:400px;" class='input01' readOnly="readonly"  >
                                    </td>
								</tr>		
								<tr height="21px">
									<td width="120px" class="text">��������</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_ddl classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Format      value="0000-00-00">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=Enable  value=false>
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
											<param name=ListExprFormat  value="detail_nm^0^100">
											<param name=Enable  value=false>
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">�ε�����</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_terms_trans classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_terms_trans>
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
									<td width="120px" class="text">�˻���</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_way_chk classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_way_chk>
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
									<td width="120px" class="text">��������</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_terms_pay classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_terms_pay>
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
									<td width="120px" class="text">��ݺ�δ�</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_bur_trans classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_bur_trans>
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
									<td width="120px" class="text">������Ư�����</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_osv_pvr' id="v_osv_pvr" style="width:100px;" class='input01'  readOnly="readonly">
                                    </td>
									<td width="120px" class="text">ǰ��Ư�����</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_con_note' id="v_con_note" style="width:100px;" class='input01'  readOnly="readonly">
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">���ޱ���</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_prepay_amt_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="false">                                                                                                                                                                                                             
			                                <param name=Numeric			value=true>
			                                <param name=IsComma			value=true>
											<param name=Enable  value=false>
			                            </object><%=HDConstant.COMMENT_END%>  &nbsp;%
									</td>
									<td width="120px" class="text">���ޱ�</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_prepay_amt' id="v_prepay_amt" style="width:130px;" limitdec=0 class='input01'  readOnly="readonly"> </td>
                                    </td>
                        		</tr>
								<tr height="21px">
									<td width="120px" class="text">������ຸ������</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_ch_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="false">                                                                                                                                                                                                             
			                                <param name=Numeric			value=true>
			                                <param name=IsComma			value=true>
											<param name=Enable  value=false>
			                                
			                            </object><%=HDConstant.COMMENT_END%>  &nbsp;%
									</td>
									<td width="120px" class="text">������ຸ����</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_ch_amt' id="v_ch_amt" style="width:130px;" class='input01'  readOnly="readonly"> </td>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">���ں�����������</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_db_rate classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="input01" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="false">                                                                                                                                                                                                             
											<param name=Numeric			value=true>	
											<param name=IsComma			value=true>		                               
											<param name=Enable  value=false>
			                            </object><%=HDConstant.COMMENT_END%>  &nbsp;%
									</td>
									<td width="120px" class="text">���ں���������</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_db_amt' id="v_db_amt" style="width:130px;" class='input01'  readOnly="readonly"> </td>
                                    </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">�����Ⱓ</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="textbox_d" name='v_term_grn' id="v_term_grn" style="width:80px;" class='input01'  readOnly="readonly" >&nbsp;����
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
                          <C> name='����' 				ID={CurRow}	   			width=100 		align=CENTER	edit=none show=TRUE</C>
	                     <C> name='EST_SID' 			ID='EST_SID'	   		width=80 		align=CENTER	edit=none  show=false </C>
                         <C> name='�ŷ�ó�ڵ�' 		ID='VEND_CD'   		width=80 		align=CENTER	edit=none show=false</C>
                         <C> name='���»��' 			ID='VEND_NM'    		width=200 	align=CENTER	edit=none</C>
                         <C> name='�����ݾ�'			ID='TOT_EST_AMT'  width=90 		align=right 	 decao=0 edit=none </C>
                         <C> name='�����ݾ�'			ID='TOT_FN_EST_AMT'  	width=90 		align=right 	 decao=0	edit=none</C>
                         <C> name='������'				ID='UD_EST_AMT'  	width=90 		align=right 	 decao=0 edit=none</C>                                                  
                         <C> name='��������ȣ'		ID='EST_NO'    		width=150 	show=false 	 align=CENTER	edit=none</C>
                         <C> name='��������(%)'		ID='UD_RATE'  	width=100 		align=right 	 decao=1 dec=1 edit=none</C>                                                  
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
                         <C> name='����' 				ID='ITEM_UNIT'   		width=60 		align=CENTER		edit=none sumtext='ǰ��' sumtextalign='left'</C>


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
                         <C> name='����' 		ID='EST_CNT'   		width=50 		align=right	  edit=none </C>
                         <C> name='�ܰ�' 		ID='FN_EST_AMT'   	width=70 		align=right	  decao=0 	</C>
                         <C> name='�ݾ�'    	ID='FN_SUM_AMT'     width=80 		align=right	  show=true decao=0	 sumtext='@sum' sumtextalign='right'	</C>
                    </G>

                         <C> name='�������' 				ID='EST_ITEM_NOTE'    	width=150 	align=LEFT	 	 edit=none</C>                         
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
					<C>Col=PREPAY_AMT_RATE    Ctrl=v_prepay_amt_rate   	Param=text </C>
					<C>Col=PREPAY_AMT    			Ctrl=v_prepay_amt   		Param=value </C>
					<C>Col=CH_RATE    	 	 			Ctrl=v_ch_rate   		Param=text </C>
					<C>Col=CH_AMT    	 	 			Ctrl=v_ch_amt   		Param=value </C>
					<C>Col=DB_RATE    	 	 			Ctrl=v_db_rate   		Param=text </C>
					<C>Col=DB_AMT    	 	 			Ctrl=v_db_amt   		Param=value </C>
					<C>Col=TERM_GRN    	 	 		Ctrl=v_term_grn   		Param=value </C>																				
					<C>Col=TOT_FN_EST_AMT  	 	 		Ctrl=v_tot_fn_est_amt		Param=value </C>		
					<C>Col=AP_DESC_RE 	 	 Ctrl=v_ap_desc_re   	 Param=value </C>											
					<C>Col=real_file	    	 	 Ctrl=txt_real_file		 	 	Param=value </C>
					<C>Col=sys_file	    	 	 Ctrl=txt_sys_file		 		Param=value </C>																						
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
		
<%
/*=============================================================================
			����Ʈ ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
	<object id=pr1 classid=<%=HDConstant.CT_REPORT_CLSID%>> 
	<param NAME="MasterDataID"				VALUE=ds_default6>
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="LandScape"				VALUE="0">
    <PARAM NAME="PrintSetupDlgFlag" 	VALUE="true">
	<PARAM NAME="PreviewZoom"			VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=FHeader ,left=0,top=0 ,right=2101 ,bottom=881 ,face='Tahoma' ,size=10 ,penwidth=1
	<T>id='* �⺻����' ,left=50 ,top=101 ,right=450 ,bottom=167 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
	<X>left=50 ,top=180 ,right=1950 ,bottom=881 ,border=true</X>
	<L> left=1601 ,top=180 ,right=1601 ,bottom=680 </L>
	<L> left=1352 ,top=180 ,right=1352 ,bottom=680 </L>
	<L> left=50 ,top=741 ,right=1950 ,bottom=741 </L>
	<L> left=50 ,top=450 ,right=1950 ,bottom=450 </L>
	<L> left=50 ,top=246 ,right=1950 ,bottom=246 </L>
	<L> left=50 ,top=312 ,right=1950 ,bottom=312 </L>
	<L> left=50 ,top=376 ,right=1950 ,bottom=376 </L>
	<L> left=50 ,top=601 ,right=1950 ,bottom=603 </L>
	<T>id='û����ȣ' ,left=56 ,top=185 ,right=286 ,bottom=241 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��������' ,left=1357 ,top=185 ,right=1588 ,bottom=241 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��ݺ�δ�' ,left=1357 ,top=251 ,right=1588 ,bottom=307 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='�����Ⱓ' ,left=1357 ,top=386 ,right=1588 ,bottom=442 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���޾�ü' ,left=1357 ,top=315 ,right=1588 ,bottom=370 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='�����' ,left=1357 ,top=460 ,right=1588 ,bottom=516 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='û������' ,left=706 ,top=185 ,right=937 ,bottom=241 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='ǰ������' ,left=704 ,top=254 ,right=934 ,bottom=310 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���ޱ���' ,left=704 ,top=315 ,right=934 ,bottom=370 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��ຸ������' ,left=706 ,top=458 ,right=937 ,bottom=513 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='�ε�����' ,left=56 ,top=534 ,right=286 ,bottom=590 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='������ຸ����(``)' ,left=53 ,top=463 ,right=283 ,bottom=519 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���ں���������(``)' ,left=53 ,top=384 ,right=283 ,bottom=439 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���ޱ�(VAT����)' ,left=56 ,top=318 ,right=286 ,bottom=373 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='ǰ�ǹ�ȣ' ,left=56 ,top=251 ,right=286 ,bottom=307 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='�������ؼ�����' ,left=56 ,top=688 ,right=286 ,bottom=738 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��������' ,left=706 ,top=532 ,right=937 ,bottom=593 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='��������' ,left=1357 ,top=611 ,right=1588 ,bottom=672 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='����â��' ,left=1357 ,top=534 ,right=1588 ,bottom=593 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='���ں�������' ,left=704 ,top=386 ,right=934 ,bottom=442 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<C>id='RQST_NO', left=302, top=191, right=693, bottom=238</C>
	<C>id='TERMS_TRANS', left=296, top=537, right=688, bottom=590</C>
	<C>id='CH_AMT', left=296, top=455, right=688, bottom=513, Dec=0</C>
	<C>id='DB_AMT', left=302, top=386, right=693, bottom=439, Dec=0</C>
	<C>id='TERMS_PAY', left=955, top=534, right=1347, bottom=590</C>
	<C>id='CH_RATE', left=955, top=458, right=1347, bottom=516</C>
	<C>id='DB_RATE', left=955, top=384, right=1347, bottom=442</C>
	<C>id='PREPAY_AMT_RATE', left=955, top=318, right=1347, bottom=368</C>
	<C>id='DATE_CON', left=955, top=251, right=1347, bottom=304</C>
	<C>id='RQST_DATE', left=955, top=185, right=1347, bottom=241</C>
	<C>id='PREPAY_AMT', left=296, top=320, right=688, bottom=368, Dec=0</C>
	<C>id='CON_NO', left=302, top=257, right=693, bottom=304</C>
	<C>id='AC_DATE', left=1609, top=185, right=1942, bottom=241</C>
	<C>id='BUR_TRANS', left=1603, top=254, right=1942, bottom=310</C>
	<C>id='VEND_NM', left=1606, top=318, right=1939, bottom=373</C>
	<C>id='TERM_GRN', left=1609, top=381, right=1939, bottom=437</C>
	<C>id='PUT_WH', left=1606, top=534, right=1939, bottom=590</C>
	<C>id='DATE_DDL', left=1606, top=609, right=1937, bottom=669</C>
	<C>id='OSV_PVR', left=299, top=691, right=1939, bottom=738, align='left'</C>
	<C>id='SITE_NM', left=1609, top=460, right=1939, bottom=516</C>
	<L> left=50 ,top=527 ,right=1950 ,bottom=529 </L>
	<L> left=50 ,top=804 ,right=1950 ,bottom=804 </L>
	<L> left=291 ,top=180 ,right=291 ,bottom=878 </L>
	<T>id='û��Ư�����' ,left=56 ,top=743 ,right=286 ,bottom=804 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='ǰ��Ư�����' ,left=56 ,top=812 ,right=286 ,bottom=873 ,face='Tahoma' ,size=8 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<T>id='÷������' ,left=58 ,top=609 ,right=288 ,bottom=675 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
	<C>id='CON_NOTE', left=296, top=810, right=1945, bottom=870, align='left'</C>
	<L> left=50 ,top=680 ,right=1950 ,bottom=680 </L>
	<L> left=701 ,top=180 ,right=701 ,bottom=606 </L>
	<C>id='REAL_FILE', left=299, top=616, right=1347, bottom=669</C>
	<C>id='RQST_MEMO', left=296, top=746, right=1937, bottom=804, align='left'</C>
	<L> left=950 ,top=180 ,right=950 ,bottom=606 </L>
</B>
<A>id=Area1 ,left=0,top=0 ,right=2101 ,bottom=132
	<R>id='pu070s_s1.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default7'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=188 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='* ������ü' ,left=50 ,top=50 ,right=450 ,bottom=111 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<X>left=50 ,top=111 ,right=1950 ,bottom=188 ,backcolor=#A6CAF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=201 ,top=111 ,right=201 ,bottom=188 </L>
			<L> left=1701 ,top=111 ,right=1701 ,bottom=188 </L>
			<L> left=799 ,top=111 ,right=799 ,bottom=188 </L>
			<L> left=1410 ,top=111 ,right=1410 ,bottom=188 </L>
			<T>id='����' ,left=58 ,top=119 ,right=196 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='���»��' ,left=214 ,top=122 ,right=791 ,bottom=183 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�����ݾ�' ,left=807 ,top=119 ,right=1093 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�����ݾ�' ,left=1109 ,top=119 ,right=1402 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='������' ,left=1418 ,top=119 ,right=1691 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=1101 ,top=111 ,right=1101 ,bottom=188 </L>
			<T>id='��������(%)' ,left=1717 ,top=119 ,right=1939 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=77 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=0 ,right=1950 ,bottom=77 ,border=true</X>
			<L> left=201 ,top=0 ,right=201 ,bottom=77 </L>
			<L> left=799 ,top=0 ,right=799 ,bottom=77 </L>
			<L> left=1410 ,top=0 ,right=1410 ,bottom=77 </L>
			<L> left=1101 ,top=0 ,right=1101 ,bottom=77 </L>
			<L> left=1701 ,top=0 ,right=1701 ,bottom=77 </L>
			<C>id='{CurRow}', left=58, top=5, right=196, bottom=71</C>
			<C>id='UD_EST_AMT', left=1418, top=5, right=1693, bottom=71, align='right', Dec=0, Decao=0</C>
			<C>id='TOT_FN_EST_AMT', left=1109, top=5, right=1400, bottom=71, align='right', Dec=0, Decao=0</C>
			<C>id='TOT_EST_AMT', left=804, top=5, right=1093, bottom=71, align='right', Dec=0, Decao=0</C>
			<C>id='VEND_NM', left=214, top=5, right=791, bottom=71</C>
			<C>id='UD_RATE', left=1709, top=5, right=1937, bottom=71</C>
		</B>
	</R>
</A>
<A>id=Area2 ,left=0,top=0 ,right=2101 ,bottom=132
	<R>id='pu070s_s2.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default8'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=270 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=111 ,right=1950 ,bottom=270 ,backcolor=#A6CAF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<T>id='* ǰ��' ,left=50 ,top=50 ,right=450 ,bottom=111 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<L> left=1341 ,top=191 ,right=1945 ,bottom=191 </L>
			<T>id='�԰�' ,left=439 ,top=122 ,right=754 ,bottom=257 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=762 ,top=111 ,right=762 ,bottom=270 </L>
			<T>id='����' ,left=773 ,top=122 ,right=881 ,bottom=257 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=889 ,top=191 ,right=1341 ,bottom=191 </L>
			<T>id='�ܰ�' ,left=894 ,top=196 ,right=1019 ,bottom=262 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=897 ,top=124 ,right=1238 ,bottom=185 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=1029 ,top=191 ,right=1029 ,bottom=270 </L>
			<T>id='�ݾ�' ,left=1035 ,top=198 ,right=1230 ,bottom=265 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=1249 ,top=122 ,right=1577 ,bottom=183 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ܰ�' ,left=1249 ,top=196 ,right=1373 ,bottom=262 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ݾ�' ,left=1392 ,top=196 ,right=1574 ,bottom=262 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=1582 ,top=111 ,right=1582 ,bottom=270 </L>
			<T>id='����' ,left=1590 ,top=119 ,right=1931 ,bottom=180 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ܰ�' ,left=1590 ,top=204 ,right=1728 ,bottom=259 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=1733 ,top=191 ,right=1733 ,bottom=270 </L>
			<T>id='�ݾ�' ,left=1746 ,top=201 ,right=1929 ,bottom=262 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='ǰ��' ,left=58 ,top=119 ,right=426 ,bottom=257 ,supplevel=1 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=431 ,top=114 ,right=431 ,bottom=267 </L>
			<L> left=889 ,top=114 ,right=889 ,bottom=267 </L>
			<L> left=1386 ,top=191 ,right=1386 ,bottom=270 </L>
			<L> left=1244 ,top=111 ,right=1244 ,bottom=265 </L>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=80 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=0 ,right=1950 ,bottom=79 ,backcolor=#FFFBF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<C>id='ITEM_NM', left=56, top=5, right=421, bottom=71</C>
			<L> left=431 ,top=0 ,right=431 ,bottom=79 </L>
			<C>id='ITEM_SIZE', left=439, top=5, right=751, bottom=71</C>
			<L> left=762 ,top=0 ,right=762 ,bottom=79 </L>
			<C>id='EST_CNT', left=767, top=5, right=886, bottom=71, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0</C>
			<L> left=889 ,top=0 ,right=889 ,bottom=79 </L>
			<C>id='DG_AMT', left=894, top=5, right=1029, bottom=71, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0, Decao=0</C>
			<L> left=1029 ,top=0 ,right=1029 ,bottom=79 </L>
			<L> left=1733 ,top=0 ,right=1733 ,bottom=79 </L>
			<C>id='FN_SUM_AMT', left=1738, top=5, right=1939, bottom=71, align='right', Dec=0, Decao=0</C>
			<L> left=1246 ,top=3 ,right=1246 ,bottom=77 </L>
			<L> left=1585 ,top=3 ,right=1585 ,bottom=77 </L>
			<L> left=1389 ,top=0 ,right=1389 ,bottom=74 </L>
			<C>id='DG_SUM_AMT', left=1035, top=8, right=1241, bottom=74, align='right', MargineX=3, Dec=0, Decao=0</C>
			<C>id='FN_EST_AMT', left=1590, top=5, right=1733, bottom=71, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Dec=0, Decao=0</C>
			<C>id='YS_SUM_AMT', left=1394, top=5, right=1582, bottom=71, align='right', MargineX=3, Dec=0, Decao=0</C>
			<C>id='YS_AMT', left=1251, top=8, right=1386, bottom=74, align='right', face='Tahoma', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3, Dec=0, Decao=0</C>
		</B>
	</R>
</A>
<A>id=Area3 ,left=0,top=0 ,right=2101 ,bottom=132
	<R>id='pu070s_s3.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default9'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=191 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='* ������缱' ,left=50 ,top=50 ,right=450 ,bottom=111 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<X>left=50 ,top=111 ,right=1950 ,bottom=191 ,backcolor=#A6CAF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=603 ,top=111 ,right=603 ,bottom=191 </L>
			<L> left=402 ,top=111 ,right=402 ,bottom=191 </L>
			<L> left=1000 ,top=111 ,right=1000 ,bottom=191 </L>
			<L> left=1201 ,top=111 ,right=1201 ,bottom=191 </L>
			<L> left=1601 ,top=111 ,right=1601 ,bottom=191 </L>
			<L> left=201 ,top=111 ,right=201 ,bottom=191 </L>
			<T>id='����' ,left=58 ,top=116 ,right=193 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='������' ,left=209 ,top=119 ,right=394 ,bottom=185 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=407 ,top=116 ,right=595 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�μ�' ,left=611 ,top=116 ,right=992 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=1008 ,top=116 ,right=1196 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ǰ�' ,left=1207 ,top=116 ,right=1593 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�����Ͻ�' ,left=1609 ,top=116 ,right=1942 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=79 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=0 ,right=1950 ,bottom=79 ,backcolor=#FFFBF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=198 ,top=3 ,right=198 ,bottom=77 </L>
			<L> left=402 ,top=0 ,right=402 ,bottom=79 </L>
			<L> left=603 ,top=0 ,right=603 ,bottom=79 </L>
			<L> left=1000 ,top=0 ,right=1000 ,bottom=79 </L>
			<L> left=1201 ,top=0 ,right=1201 ,bottom=79 </L>
			<L> left=1601 ,top=0 ,right=1601 ,bottom=79 </L>
			<C>id='AP_TYPE_NM', left=58, top=5, right=193, bottom=71</C>
			<C>id='AP_DESC', left=1207, top=5, right=1593, bottom=71</C>
			<C>id='AP_STATUS_D_NM', left=1005, top=5, right=1193, bottom=71</C>
			<C>id='DEPTNM', left=606, top=5, right=995, bottom=71</C>
			<C>id='PAYGRD', left=407, top=5, right=601, bottom=71</C>
			<C>id='EMPNMK', left=212, top=5, right=394, bottom=71</C>
			<C>id='U_DATE', left=1606, top=5, right=1945, bottom=71</C>
		</B>
	</R>
</A>
<A>id=Area4 ,left=0,top=0 ,right=2101 ,bottom=132
	<R>id='pu070s_s4.sbt' ,left=0 ,top=0 ,right=2000 ,bottom=132 ,DetailDataID='ds_default9_1'
		<B>id=DHeader ,left=0,top=0 ,right=2000 ,bottom=191 ,face='Tahoma' ,size=10 ,penwidth=1
			<T>id='* ������缱' ,left=50 ,top=50 ,right=450 ,bottom=111 ,align='left' ,face='Tahoma' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF, MargineX=3</T>
			<X>left=50 ,top=111 ,right=1950 ,bottom=191 ,backcolor=#A6CAF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=603 ,top=111 ,right=603 ,bottom=191 </L>
			<L> left=402 ,top=111 ,right=402 ,bottom=191 </L>
			<L> left=1000 ,top=111 ,right=1000 ,bottom=191 </L>
			<L> left=1201 ,top=111 ,right=1201 ,bottom=191 </L>
			<L> left=1601 ,top=111 ,right=1601 ,bottom=191 </L>
			<T>id='����' ,left=58 ,top=116 ,right=193 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='������' ,left=209 ,top=119 ,right=394 ,bottom=185 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=407 ,top=116 ,right=595 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�μ�' ,left=611 ,top=116 ,right=992 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='����' ,left=1008 ,top=116 ,right=1196 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<T>id='�ǰ�' ,left=1207 ,top=116 ,right=1593 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
			<L> left=201 ,top=111 ,right=201 ,bottom=191 </L>
			<T>id='�����Ͻ�' ,left=1609 ,top=116 ,right=1942 ,bottom=183 ,face='Tahoma' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#A6CAF0</T>
		</B>
		<B>id=default ,left=0,top=0 ,right=2000 ,bottom=79 ,face='Tahoma' ,size=10 ,penwidth=1
			<X>left=50 ,top=0 ,right=1950 ,bottom=79 ,backcolor=#FFFBF0 ,border=true ,penstyle=solid ,penwidth=1</X>
			<L> left=204 ,top=3 ,right=204 ,bottom=77 </L>
			<L> left=402 ,top=0 ,right=402 ,bottom=79 </L>
			<L> left=603 ,top=0 ,right=603 ,bottom=79 </L>
			<L> left=1000 ,top=0 ,right=1000 ,bottom=79 </L>
			<L> left=1201 ,top=0 ,right=1201 ,bottom=79 </L>
			<L> left=1601 ,top=0 ,right=1601 ,bottom=79 </L>
			<C>id='AP_TYPE_NM', left=56, top=3, right=198, bottom=69</C>
			<C>id='AP_DESC', left=1207, top=5, right=1595, bottom=71</C>
			<C>id='AP_STATUS_D_NM', left=1005, top=5, right=1196, bottom=71</C>
			<C>id='PAYGRD', left=410, top=5, right=587, bottom=71</C>
			<C>id='DEPTNM', left=606, top=5, right=990, bottom=71</C>
			<C>id='EMPNMK', left=214, top=5, right=397, bottom=71</C>
			<C>id='U_DATE', left=1606, top=5, right=1945, bottom=71</C>
		</B>
	</R>
</A>



	">
</object> 
<%=HDConstant.COMMENT_END%>
<script language=JavaScript for=pr1 event=OnError()>
    alert(pr1.ErrorMsg);
</script>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		