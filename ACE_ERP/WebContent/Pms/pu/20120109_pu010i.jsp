
<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 	 : ����_û��
 * ���α׷�ID 	 : PMS/PU010I
 * J  S  P		 	 : pu010i.jsp
 * �� �� ��		 : Pu010I
 * �� �� ��		 : �ڰ汹
 * �� �� ��		 : 2011-11-14
 * �������		 : ����_û��
 * [ �������� ][������] ����
 * [2011-11-14][�ڰ汹] �ű�
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="pms.common.HDConstant"%>
<%@ page import="sales.common.DateUtil"%>
<%@ page import="sales.org.common.request.SmartRequest"%>
<%@ page import="sales.menu.my.My710Manager" %>
<%@ page import="sales.menu.my.My710DTO" %>
<%@ page import="sales.org.common.*"%>

<%@ page import="kr.co.imjk.util.*"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_board_ma_bean"%>
<%@ page import="kr.co.imjk.board.bean.Tbrd_attach_file_de_bean"%>
<%@ page import="kr.co.imjk.board.dao.TourGalleryBoard"%>
<%@ page import="kr.co.imjk.board.dao.CommonBoard"%>
<%@ page import="java.util.*"%>


<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
	//���� �ҷ����� ����
	String v_login_name ="";
	String v_login_id = "";
	v_login_id=(String)session.getAttribute("vusrid");
	v_login_name=(String)session.getAttribute("vusrnm");
	//���� �ҷ����� ��
	
	//÷������ 
	String virtual_name	= "";
	String real_name		= "";
	String fullFilename	= "";
	String fileNameList = "";	//���� ����Ʈ ������ (������)
	Tbrd_attach_file_de_bean[] fileRecord = null;	//���� ÷�ο� ��~!
	
	 SmartRequest sr3 = new SmartRequest(request);
	 My710Manager manager3 = new My710Manager();
     My710DTO dto = manager3.select(sr3);
	
	//���ϸ���Ʈ html �����
    StringBuffer sb = new StringBuffer();
	String real_fileList = dto.getReal_file();	//���� �ҷ��ͼ� 
	String sys_fileList = dto.getSys_file();
	fileNameList = real_fileList;				// �ý����� ����Ʈ�� ����.

	String real_file[] = real_fileList.split(":");	//�迭�� ����
	String sys_file[] = sys_fileList.split(":");	//�迭�� ����
	
		for(int j=0; j<sys_file.length; j++){

			sb.append("<option value='"+sys_file[j]+ "'>" + real_file[j] +"</option>"); 
		};

	//÷�ζ��� ���� html�ڵ� �����                     
 	fullFilename = sb.toString();     
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
    <jsp:include page="/Pms/common/include/head.jsp"/>
    
    <script language=javascript src="<%=dirPath%>/Pms/common/js/common_pop.js"></script>
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
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
       
        v_fr_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_rqst_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

        //v_fr_rqst_date.Text = "20111114";
        //v_to_rqst_date.Text = "20111114";


       ds_srch_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=PU001&s_item1=Y";
       ds_srch_rqst_status.Reset();	//�۾�����(��ȸ)
       
       ds_rqst_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU001&s_item1=Y";
       ds_rqst_status.Reset();	//�۾�����
        
       ds_rqst_use.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=PU002&s_item1=Y";
       ds_rqst_use.Reset();	//���ó
      
      
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu010I",
            "JSP(O:DS_DEFAULT=ds_default,O:DS_TENDER=ds_tender)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
    }
    
    <%//���� ��ȸ  %>
    function fnSelect() {
		if (ds_default.IsUpdated || ds_tender.IsUpdated) {
			alert("�������� ���� �ֽ��ϴ�.");
		} else {
		    v_job="S";
		    
	        var fr_date = v_fr_rqst_date.Text.trim();
	        var to_date = v_to_rqst_date.Text.trim();
	
	        if(fr_date.length!=8) {
	            alert("û������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("û������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	    	}
	    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
		    	      + ",v_empno="+ sNowEmpno.value
	                  + ",v_site_sid="+ v_site_sid.value
	                  + ",v_fr_rqst_date=" + fr_date
	                  + ",v_to_rqst_date=" + to_date
	                  + ",v_rqst_status=" + lc_srch_rqst_status.ValueOfIndex("detail", lc_srch_rqst_status.Index) ;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu010I",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
		};
    }    

    <%//������ ��ȸ%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_rqst_sid="+getObjectFirst("ds_default").NameValue(row, "RQST_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu010I",
            "JSP(O:DS_TENDER=ds_tender)",
            v_param);
        tr_post(tr2);
     
    }

	<%//���� %>
	function fnApply(){
		v_job = "A";
		
		var row=ds_default.countRow;
			
		if (ds_default.IsUpdated) {
				//÷�����ϸ� 
				if(ff.fileList.options.length > 0)
				{
					f.sys_file.value = "";
					f.real_file.value = "";
					for(i=0;i<ff.fileList.options.length;i++)
					{
					  if(i==0){
						  f.sys_file.value += ff.fileList.options[i].value;
						  f.real_file.value += ff.fileList.options[i].text;
					  }else{
					    f.sys_file.value += ":"+ff.fileList.options[i].value;
					    f.real_file.value += ":"+ff.fileList.options[i].text;
					  }
					}
				}else{
					//alert("������ ���ε� ���ּ���.");
					//return;
				}
		  ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PU%>Pu010I",
            "JSP(I:DS_DEFAULT=ds_default)",
            "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
    		tr_post(tr1);
    		fnSelect();
    	}else if(ds_tender.IsUpdated)
    	{
    	 ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PU%>Pu010I",
                "JSP(I:DS_TENDER=ds_tender)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
        		
        		
        }else
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}

	<%//�׼� �ٿ�ε� %>
    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:����û����; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("����û����", "����û����.xls", 8);        
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
            v_site_sid.value = arrParam[2];	//SID
        } else {
			fnSelSiteCleanup();
        }               
    }
    <%//����� ��- ��ȸ%>
    function  fnSelSitePopup1(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnPuSitePop1(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
			v_pu_site_cd.value= arrParam[0];	//�����ڵ�
			v_site_nm1.value= arrParam[1];	//�����
            v_pu_empno.value = arrParam[2];	//����ڻ��
            v_site_sid1.value = arrParam[4];	//SID
        } else {
			fnSelSiteCleanup1();
        }               
    }
    
	<%//���� ��- �Է�%>
    function fnSelSitePopup1______________(dirPath) {
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
			//v_rqst_date.text = arrParam[1];//DATE_CT //
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

	<%// ������ �ű� %>
	function fnAddRowDsDefault(){
		if(ds_tender.IsUpdated) {
			alert("�������� ���� ������ �ű� û�������� ������ �� �����ϴ�.");
			return;
		}else {
			v_job="N";
			ds_default.addrow();
			ds_tender.clearall();
			v_rqst_date.text="<%=DateUtil.getCurrentDate(8)%>";
			lc_rqst_status.index = 0;			
			
			v_rqst_date.focus();
			
			return;
		}
	}

	<%// ������ ���� %>
	function fnDeleteRowDsDefault() {
		if(ds_default.IsUpdated) {
			alert("�������� �۾��� �־� ������ �� �����ϴ�.");
			return;
		}else {
			ds_default.DeleteRow(ds_default.RowPosition);
		};
	};

	<%//������ ���߰� %>
	function fnAddRowDs2() {
		if (ds_default.namevalue(ds_default.rowposition,"RQST_SID") == undefined || ds_default.namevalue(ds_default.rowposition,"RQST_SID") == "" || ds_default.namevalue(ds_default.rowposition,"RQST_SID") == 0 ) {
			alert("û�������� ��ȸ/���� �� �߰��� �ּ���.");
		} else {
			ds_tender.addrow();
			ds_tender.namevalue(ds_tender.RowPosition, "RQST_SID") = ds_default.namevalue(ds_default.rowposition,"RQST_SID");
			
			window.status="û��ǰ�� ���� ���ԵǾ����ϴ�.";
		}
	}

	<%//������ ����� %>
	function fnDeleteRowDs2(){
		ds_tender.deleterow(ds_tender.rowposition);
		window.status="û��ǰ�� ���� �����Ǿ����ϴ�.";
	}

	<%// �׸��� ���� ��� %>
	function fnCancel() {
        ds_default.undoall();
        ds_tender.undoall();
		window.status="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
	
	//���Ͼ��ε� �Լ� 5
	//���� �̹����� ���
	var oldFileNames = "<%=fileNameList%>";
	
	//���Ͼ��ε� �Լ� 1
		//�̹��� ������ �ø���
	function tempUpload()
	{
		//document.domain="imjk.co.kr";
		f = document.fileForm;
	    //alert(f);
		if(f.file1.value.length == 0 || f.file1.value == "÷������ �ѿ뷮 ���� : 5M")
		{
			alert('���ε��� ������ �����Ͽ� �ֽʽÿ�');
			return;
		}
	
		var realFileName = f.file1.value;
		var idx = realFileName.lastIndexOf("\\");
		realFileName = realFileName.substring(idx+1);
		//alert(realFileName);
		if(realFileName.indexOf(".mp3") > 0 ||realFileName.indexOf(".wma") > 0 || realFileName.indexOf(".asf") > 0){
			alert("���۱� ������ ������ �ִ� mp3, wma, asf ������ �������� ÷�δ� ���� �ʽ��ϴ�.");
			return;
		}
		strArray = realFileName.split("."); 
		strArray2 = realFileName.split("|"); 
	  
		//�����̸��� [.] �� ������ �ȵȴ�.(Ȯ���� ����)
		if(strArray.length > 2){
		  alert("�����̸��� '.' �� ������ �����Ͽ� �ֽʽÿ� ");
		  return;
		}
		
		if(strArray.length < 1){
		  alert("Ȯ���ڸ��� �ݵ�� �־�� �մϴ�.  ");
		  return;
		}
		//�����̸��� [|] �� ������ �ȵȴ�.
		if(strArray2.length > 1){
		  alert("�����̸��� '|' �� ������ ��� �����Ͽ� �ֽʽÿ� ");
		  return;
		}
		
		f.target="tempUpload";	//���ε� ���� Ÿ���� iFrame !
		f.realFileName.value=realFileName;
		f.mode.value="insert";
		 
		f.action = "./my710_upload.jsp";
		f.submit();
	}

	//���Ͼ��ε� 2
		//���� ��Ͽ� �߰�: iFrame �ȿ��� ȣ���Ѵ�
	function addFileList(realName, virtualName)	{
		f = document.fileForm;
	
		if(realName!=""){
			f.fileList.options[f.fileList.options.length] = new Option(realName,virtualName);
		}
		f.file1.value ="÷���������ִ�5M���������մϴ�." ;  //f.file1.title;
	}


	//���Ͼ��ε� 3
	// ���� ��Ͽ��� ���� 
	function fileDelete(){
		f = document.fileForm;
	  
		if(f.fileList.selectedIndex==null || f.fileList.selectedIndex < 0){
			alert('������ ������ ������ �ֽʽÿ�');
			f.fileList.focus();
			return;
		}	
	
		if(confirm('������ ���� �Ͻðڽ��ϱ�?')){
			var i = f.fileList.options.selectedIndex;
			var select_val = f.fileList.options[i].value;
			var realFileName = f.file1.value;
		    var fileArray = oldFileNames.split(":");
	
			//alert(select_val);
			//alert(oldFileNames);
	
			//******** START ������ �ִ� �������� ���� ***********/
			var isNew = "i_del"; // �̰� �ݹ� �ø� ������ ���... insert_file
			 
	
			if(fileArray.length>1){
				 for(j=0;j< fileArray.length;j++){
				    tempFileName = fileArray[j];
				   if(tempFileName == select_val){
				      isNew = "u_del";		// ���Ⱑ ���� ����	update_file 
				      break;
				    }
				 }
			}
			 
			if(fileArray.length <=1){
			   if(oldFileNames == select_val){
					      isNew = "u_del";
				}
			}
			//******** END  ������ �ִ� �������� ���� ***********/
			 
			//alert(isNew);
	
			document.file_del.target="tempUpload";
			document.file_del.realFileName.value=realFileName;
			document.file_del.virtualFileName.value = select_val;
	//		document.file_del.saveDir.value = "memGalleryUpload";
			document.file_del.mode.value=isNew;
			document.file_del.action = "./my710_deleteFile.jsp";	//����� ����
			document.file_del.submit();
		}
	}




	//���Ͼ��ε� 4
	// ������ �������� ���� �� ����Ʈ���� ����
	function delResult(){
		f = document.fileForm;
	
		idx = f.fileList.selectedIndex;
		cnt = f.fileList.options.length;
		for(i=idx;i< f.fileList.options.length-1;i++){
			f.fileList.options[i] = new Option(f.fileList.options[i+1].text,f.fileList.options[i+1].value);
		}
		f.fileList.options[cnt - 1] = null;
		f.file1.value = "÷���������ִ�5M���������մϴ�.";
	}
	
	/*
	* ǰ�� �˾� : �� �׸��忡�� 
	*/
	function fnITEMPopup() {
			
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL;	 
		var strPos;
		strURL = "<%=dirPath%>/Pms/help/pu001h_01.jsp"
		strPos = "dialogWidth:570px;dialogHeight:350px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);	
	
		//alert(arrResult);
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			ds_tender.namevalue(ds_tender.rowposition,"ITEM_SID") = arrParam[0];
	   		ds_tender.namevalue(ds_tender.rowposition, "ITEM_NM") = arrParam[1];
	   		ds_tender.namevalue(ds_tender.rowposition, "ITEM_SIZE") = arrParam[2];
	   		ds_tender.namevalue(ds_tender.rowposition, "ITEM_UNIT") = arrParam[3];
		} else {
			ds_tender.namevalue(ds_tender.rowposition,"ITEM_SID") = "";
	   		ds_tender.namevalue(ds_tender.rowposition, "ITEM_NM") = "";
			ds_tender.namevalue(ds_tender.rowposition,"ITEM_SIZE") = "";
			ds_tender.namevalue(ds_tender.rowposition,"ITEM_UNIT") = "";			
   		}				
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
			alert("��� �� ������ ��ȸ �� �ּ���");
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
		arrParam[0]="310";  // AP006 ( 010 ������� , 020 ��������, 030 ��������, 040 ��������, 100 ���񽺿�û .310 ����û��, 320 ����û������, 330 ����ǰ��)
		arrParam[1]=ds_default.namevalue(ds_default.rowposition,"RQST_SID");  //û��SID
		arrParam[2]=sApproveLine;      // ���缱���� 
		
		
		strURL = "<%=dirPath%>/Pms/help/pu010h.jsp?";
		strPos = "dialogWidth:740px;dialogHeight:580px;status:no;scroll:no;resizable:no";
		
		result = showModalDialog(strURL,arrParam,strPos);
		      
		if(result != null){
			arrResult = result.split(";");
			if(arrResult[0]=="Y"){
				 fnSelect(); 
			}
		} 
	}  
	
	function fnExcel() {
  	
	        getObjectFirst("gr_tender").SetExcelTitle(0, "");
	        getObjectFirst("gr_tender").GridToExcel("Sheet2","û���⺻����.xls", 32);   
	        
	        getObjectFirst("gr_default").SetExcelTitle(0, "");
	        getObjectFirst("gr_default").GridToExcel("Sheet1","û��ǰ��.xls", 32);   
    }
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//û������ Ŭ���� û��ǰ�� ��ȸ %>
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
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
	//	 var count=1;
       //     for ( i=1;i<=ds1.CountRow;i++ ) {
          //  	if ( ds_default.namevalue(i,"RQST_NO") == '' )
		     //       ds_default.namevalue(i,"RQST_NO") = rqstNoDS.namevalue(count++,"RQST_NO");
            //}
           // ds_default.ResetStatus();
	}
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>
alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
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
				fnSelectDetail(v_default_row);
			}
		}
	</script>
	<script language=JavaScript for=gr_tender event=OnPopup(row,colid,data)>
		if (colid=="ITEM_NM") {
			fnITEMPopup();
		}
		if(colid=="DATE_USE") {
		//alert("1");
		fnCalPopup('<%=dirPath%>', row);
		//alert("2");
		}
	</script>    
	<script language=javascript for=gr_tender event="OnExit(Row,Colid,OldData)">
	    if(Row==0) return;
	    if(Colid=="DG_AMT"){
		   	ds_tender.NameValue(Row, "DG_SUM_AMT") = 	ds_tender.NameValue(Row, "DG_AMT") * ds_tender.NameValue(Row, "RQST_CNT");
	   	}else if(Colid=="YS_AMT"){
		   	ds_tender.NameValue(Row, "YS_SUM_AMT") = 	ds_tender.NameValue(Row, "YS_AMT") * ds_tender.NameValue(Row, "RQST_CNT");
	   	}else{return;
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

<object id=ds_srch_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��ȸ: �۾����� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �۾����� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_rqst_use classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ���ó -->
    <param name="SyncLoad"  value="True">
</object>
<object id=rqstNoDS classid=<%=HDConstant.CT_DATASET_CLSID%>><!--  û����ȣ -->
    <param name="SyncLoad"  value="False">
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
							<img src="<%=dirPath%>/Sales/images/ap_line.gif"	style="cursor:hand" onclick="fnApproval()">
							<img src="<%=dirPath%>/Sales/images/ap_up.gif"		style="cursor:hand" onclick="fnDraft()">
						</td>
                        <td align=right >
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:hand"  onClick="fnAddRowDsDefault()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
							<!-- <img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()"> -->
							<!-- <img src="<%=dirPath%>/Sales/images/delete.gif" 	style="cursor:hand" onClick="fnDeleteRowDsDefault()" >-->
							<!-- <img src="<%=dirPath%>/Sales/images/excel.gif"		style="cursor:hand"	onClick="fnExcel()">	-->	<!-- ���� -->
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
									<td align="center" class="text" width="70">�����</td>
									<td align="left"  bgcolor="#ffffff">&nbsp;
			                            <input type="text" name='sNowEmpnm' id='sNowEmpnm' value='<%=v_login_name%>' size='8' readonly='readonly'  class='boardt04'>
			                            <input type="text" name='sNowEmpno' id='sNowEmpno' value='<%=v_login_id%>' size='7' readonly='readonly'  class='boardt04'>
									</td>
								    <td align="center" class="text" width="70">�����</td>
                                    <td bgcolor="#FFFFFF" colspan="2">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSiteCleanup();" alt="�� �����">
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">û������</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
			                            <object id=v_to_rqst_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
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
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top' width="300px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='233px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='�۾�����'	ID='RQST_STATUS'    	width=80 	align=CENTER	Edit=None 		show=false	suppress=1</C>
                                     <C> name='�۾�����'	ID='RQST_STATUS_NM'    	width=80 	align=CENTER	Edit=None 		show=true</C>
                                     <C> name='����' 		ID='RQST_DATE'    		width=80 	align=CENTER	Edit=None 		suppress=2</C>
                                     <C> name='û����ȣ'	ID='RQST_NO' 			width=120 align=CENTER	Edit=None	</C>
                                     <C> name='û��SID'    ID='RQST_SID'       		show=false width=60 	align=CENTER	Edit=None 		decao=0	Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='�����ڵ�'	ID='SITE_CD'    			width=80 	align=CENTER	Edit=None 		show=TRUE</C>
                                     <C> name='�������ڻ��'	ID='PU_EMPNO'    	width=60 	align=CENTER	Edit=None 		</C>
                                     <C> name='�����'		ID='SITE_NM' 				width=120 align=CENTER	Edit=None	</C>
                                     <C> name='����SID'    ID='SITE_SID'       		width=60 	show=false align=CENTER	Edit=None 		 </C>
                                     <C> name='���ó'		ID='RQST_USE' 			width=120 align=CENTER	Edit=None	</C>
                                     
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">�۾�����</td>
									<td colspan="3"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_rqst_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_rqst_status>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^80">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
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
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object><%=HDConstant.COMMENT_END%>  
									</td>
									<td width="120px" class="text">û����ȣ</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text" name='v_rqst_no' id="v_rqst_no" style="width:130px;" class='input01' readOnly="readonly" > </td>
								</tr>
								<tr>
									<td width="120px" class="text">�����ڵ�</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text" name='v_pu_site_cd' id="v_pu_site_cd" style="width:100px;" class='textbox' > </td>
									<td width="120px" class="text">��������</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text" name='v_pu_empno' id="v_pu_empno" style="width:100px;" class='textbox' > </td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">�����</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid1' id='v_site_sid1'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup1('<%=dirPath%>');" alt="��ȸâ ��">
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">���ó</td>
									<td colspan="1"	bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_rqst_use classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_rqst_use>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>
									<td width="120px" class="text">û��SID</td>
									<td  width="145px"	bgcolor='#ffffff'>&nbsp;<input type="text" name='v_rqst_sid' id="v_rqst_sid" style="width:130px;" class='textbox'  > </td>
								</tr>			
							</table>
                        </td>
                    </tr>
                </table>
			</td>
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td align=right>
				<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:hand" onClick="fnAddRowDs2()" >
				<img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:hand" onClick="fnDeleteRowDs2()" >
			</td>
        </tr>
        <tr>
            <td valign="top">
                <%=HDConstant.COMMENT_START%>
                <object id="gr_tender" classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='150px' border='1'>
                    <param name="DataID"            value="ds_tender">
                    <param name="ColSizing"         value="true">
                    <param name="Editable"          value="true">
                    <param name="SuppressOption"    value="1">
                    <param name="BorderStyle"       value="0">
                    <param name="Format"            value="
                         <C> name='RQST_SID' 		ID='RQST_SID'   		width=40 		align=CENTER	edit=none show=false</C>
                         <C> name='ITEM_SID' 		ID='ITEM_SID'   		width=40 		align=CENTER	edit=none show=false</C>
                         <C> name='ǰ��' 				ID='ITEM_NM'    		width=150 	align=CENTER	 editstyle=popup bgColor=<%=HDConstant.GRID_ITEM%></C>
                         <C> name='�԰�' 				ID='ITEM_SIZE'   		width=80 		align=CENTER	 </C>
                         <C> name='����' 				ID='ITEM_UNIT'   		width=80 		align=CENTER	 </C>
                         <C> name='����' 				ID='RQST_CNT'   		width=60 		align=CENTER	 </C>
                         <C> name='���޴ܰ�'    		ID='DG_AMT'    	    width=85 		align=CENTER	 show=true decao=0	 </C>
                         <C> name='���޾�(�ڵ�)'   	ID='DG_SUM_AMT'   width=85 		align=CENTER	 show=true edit=none	decao=0	 </C>
                         <C> name='����ܰ�' 			ID='YS_AMT'   			width=85 		align=CENTER	 decao=0</C>
                         <C> name='�����(�ڵ�)'    	ID='YS_SUM_AMT'    width=85 		align=CENTER	 show=true edit=none	decao=0	 </C>
                         <C> name='�뵵' 				ID='RQST_USE'    	width=150 	align=CENTER	 show=false</C>
                         <C> name='�ҿ���' 				ID='DATE_USE'    	width=80 		align=CENTER	 EditStyle=popup</C>
                         <C> name='���' 				ID='RQST_NOTE'    	width=50 	align=LEFT	 	 </C>
                 ">                             
                </object>   
                <%=HDConstant.COMMENT_END%>

                �� <b>��</b>
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
					<C>Col=RQST_STATUS     Ctrl=lc_rqst_status    Param=BindColVal </C>
					<C>Col=RQST_STATUS_NM	 Ctrl=v_rqst_status_nm        	 Param=value </C>
					<C>Col=RQST_DATE       	 Ctrl=v_rqst_date        Param=Text </C>
					<C>Col=RQST_NO       	 	 Ctrl=v_rqst_no        	 Param=value </C>
					<C>Col=RQST_SID	       	 Ctrl=v_rqst_sid 	     Param=Value </C>
					<C>Col=RQST_USE     		 Ctrl=lc_rqst_use	     Param=BindColVal </C>
					<C>Col=SITE_CD       	 	 Ctrl=v_pu_site_cd     Param=value </C>
					<C>Col=SITE_NM       	 	 Ctrl=v_site_nm1        Param=value </C>
					<C>Col=SITE_SID	       	 	 Ctrl=v_site_sid1 	     Param=Value </C>
					<C>Col=PU_EMPNO    	 	 Ctrl=v_pu_empno   	 Param=value </C>
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		