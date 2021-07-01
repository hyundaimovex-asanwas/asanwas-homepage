<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : Ȩ>����>�������>�۾�����>�۾� ���
 * ���α׷�ID 	 : PMS/SI110I
 * J  S  P		 : si110i.jsp
 * �� �� ��		 : Si110I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2014-03-27
 * [ �������� ][������] ����
 * [2014-03-27][�ɵ���] �ű� ���� 
 * [2014-04-07][�ɵ���] GAUCE MX component 5.x�� Ŭ����ID����
 *						CSS �߰� : �׸��� Į��� ������ ���̺� ���. ����
 * [2014-04-11][�ɵ���] ���� ��¥ �Է½� ���.. �� �̷��� ó���ؾ� �մϴ�.
 * [2014-06-13][�ɵ���] ��� �� ��ũ��Ʈ, ������ �߰�
 * [2014-06-26][�ɵ���] ȭ�� ������ �ٵ��, �ο�GRID�� ���� �߰�, ����ƻ� dummy������ �߰� (TPC010, TBC030 �� ���̺�)
 *						�����ο� �˾� â ���� = ���� �߰�, �ߺ�üũ ��ũ��Ʈ ����, �μ�Ʈ/���� ������ ���� �߰�
 * [2014-06-27][�ɵ���] ���� ���� �߰�. �ۼ���(110)�� ��� �����մϴ�.
 
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
%>
<!-- HTML ����-->
<!DOCTYPE html PUBLIC "-//W3C//Dtd XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/Dtd/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko" xml:lang="ko">
	<head>
    <!--  head.jsp -->
    <jsp:include page="/Pms/common/include/head.jsp"/>
    
    <!--  //head.jsp -->
    
   
<%
/*=============================================================================
				Developer Java Script
=============================================================================*/
%>
<script language="javascript">
	var v_default_row = 1; //����Ʈ �����ͼ��� 1��. ������ �����ͼ��� ��ȸ�ϱ� ����
	var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	/*
	 * �������ε�
	 */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		
		cfStyleGrid(getObjectFirst("gr_wd"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail1"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail2"), "comn");
		cfStyleGrid(getObjectFirst("gr_detail3"), "comn");
		
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {
	    v_job ="I";
	    v_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
//	    v_date.Text = "20140329";

	    gr_wd.RowHeight = "70";	//�׸��� �ο�����Ʈ ����

        ds_gc_weather.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=SY017&s_item1=Y";
        ds_gc_weather.Reset();	//���� �ڵ� SY017 (����+)

        ds_gc_wdcode.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI004&s_item1=Y";
        ds_gc_wdcode.Reset();	//�۾� ����(������) SI004

        ds_gc_bskind.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT001&s_item1=Y";
        ds_gc_bskind.Reset();	//���� ���� CT001 

        ds_gc_bpjob.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI006&s_item1=Y";
        ds_gc_bpjob.Reset();	//�����ο� ���� SI006 

        
        
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WM=ds_wm,O:DS_WD=ds_wd,O:DS_DETAIL1=ds_detail1,O:DS_DETAIL2=ds_detail2,O:DS_DETAIL3=ds_detail3)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
        
		//����ں� ��� ���� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CT%>Ct013I",
            "JSP(O:DS_SITE_EMP=ds_site_emp)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

        
    }
    
    
    
    <%//���� ��ȸ %>
    function fnSelect() {
    	v_job="S";
        var v_wdate = v_date.Text.trim();

        if(v_wdate.length!=8) {
            alert("���ڸ� �Է��Ͻñ� �ٶ��ϴ�.");
            return;
        }
        if(v_site_sid.value==""){
        	alert("���� ������ ������ �ּ���.");
        	return;
        }
    
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
			+ ",v_site_sid="+ v_site_sid.value
			+ ",v_date=" + v_wdate
			;

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WM=ds_wm)",
            param);
        tr_post(tr1);
    }

    <%// ������ �׸��� ��ȸ%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_dwr_sid="+ ds_wm.namevalue(ds_wm.row,"DWR_SID");
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
            "JSP(O:DS_WD=ds_wd,O:DS_DETAIL1=ds_detail1,O:DS_DETAIL2=ds_detail2,O:DS_DETAIL3=ds_detail3)",
            v_param);
        tr_post(tr2);
    }

	<%//���� %>
	function fnApply(){
		v_job = "A";
		v_default_row = ds_wm.RowPosition;
		
		if (ds_wm.IsUpdated || ds_wd.IsUpdated || ds_detail1.IsUpdated || ds_detail2.IsUpdated || ds_detail3.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
                "JSP(I:DS_WM=ds_wm,I:DS_WD=ds_wd,I:DS_DETAIL1=ds_detail1,I:DS_DETAIL2=ds_detail2,I:DS_DETAIL3=ds_detail3)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>"
                	+ ",v_dwr_sid="+ ds_wm.namevalue(ds_wm.row,"DWR_SID")
                	);
        		tr_post(tr1);
        	}
		}else {
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}
	}
	<%// �Է°� üũ %>
	function ln_Chk() {
		var row1=ds_wm.countrow;
		//var row2=ds_tender.countrow;

		if(w_date.Text.length<8) {
			alert("��¥�� ��Ȯ�� �Է��� �ֽʽÿ�");
			w_date.focus();
			return;
		}
		return true;
	}

	
	


	<%//���� ��- ��ȸ%>
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

    function fnSelSiteCleanup(){
        v_site_nm.value = "";
        v_site_sid.value  = "";
    }
    

    <%// Work Master �ű� %>
	function fnNewDWR(){
		if(ds_wm.IsUpdated||ds_wd.IsUpdated) {
			alert("�������� �⺻���� �Ǵ� �������� ������\n\n�ű� �۾������� ������ �� �����ϴ�.");
			return;
		}else {
			if(v_site_sid.value==""||v_site_sid.value=="0"){
				alert("���� ������ ������ �ּ���.");
				return;
			}
			v_job="N";
			
			//��¥ �ߺ� üũ
	        var v_wdate = v_date.Text.trim();
	        if(v_wdate.length!=8) {
	            alert("���ڸ� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
				+ ",v_site_sid="+ v_site_sid.value
				+ ",v_date=" + v_wdate
				;
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_SI%>Si110I",
	            "JSP(O:DS_WM_CHK=ds_wm_chk)",
	            param);
	        tr_post(tr1);
			
	        //tr1 ����� ���� �۵�
		}
	}
    <%// Work Master �ű� %>
	function fnNewDWR1(){	
	    ds_wm.ClearData();
	    ds_wd.ClearData();
	    ds_detail1.ClearData();
	    ds_detail2.ClearData();
	    ds_detail3.ClearData();
	    
		ds_wm.addrow();
		site_sid.value = v_site_sid.value;	//����sid �ޱ�
	    w_date.Text = v_date.Text.trim();
	    lc_gc_weather.index = 1;
		TEMP_MIN.text="0";
		TEMP_MAX.text="0";
		RATE_PLAN.text="0.0";
		RATE_RESULT.text="0.0";
		PROG_RATE.value="0.0";
		man_pre.text="0";
		machine_pre.text="0";
		man_now.text="0";
		machine_now.text="0";
		w_pre.value="";
		w_now.value="";
		w_remark.value="";
	
		w_date.focus();
	}

	
	
    <%// Work Detail �ű� %>
	function fnAddRowWd(){
		if(ds_wm.IsUpdated) {
			alert("�۾� �⺻������ �������Դϴ�. ���� �� �߰��� �ּ���.");
			return;
		}
		
		if (ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == undefined || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == "" || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == 0 ) {
			alert("�۾� �⺻������ ��ȸ �Ǵ� ���� �� �������� �߰��� �ּ���.");
		} else {
			ds_wd.addrow();
			ds_wd.namevalue(ds_wd.RowPosition, "dwr_sid") = ds_wm.namevalue(ds_wm.rowposition,"dwr_sid");
			msgTxt.innerHTML="�۾� �� ���� ���ԵǾ����ϴ�.";
		}
	}

	<%// Work Detail ���� %>
	function fnDeleRowWd() {
		ds_wd.DeleteRow(ds_wd.RowPosition);
	};

	<%// �ű� �Է� ��� %>
	function fnCancel() {
        ds_wm.undoall();
        ds_wd.undoall();
        ds_detail1.undoall();
        ds_detail2.undoall();
        ds_detail3.undoall();
		msgTxt.innerHTML="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
	

    <%// Work Detail �ű� %>
	function fnAddRowDt1(){
		if(ds_wm.IsUpdated) {
			alert("�۾� �⺻������ �������Դϴ�. ���� �� �߰��� �ּ���.");
			return;
		}
		
		if (ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == undefined || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == "" || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == 0 ) {
			alert("�۾� �⺻������ ��ȸ �Ǵ� ���� �� �������� �߰��� �ּ���.");
		} else {
			ds_detail1.addrow();
			msgTxt.innerHTML="[�ο�] ���� ���ԵǾ����ϴ�.";
		}
	}
	function fnAddRowDt2(){
		if(ds_wm.IsUpdated) {
			alert("�۾� �⺻������ �������Դϴ�. ���� �� �߰��� �ּ���.");
			return;
		}
		
		if (ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == undefined || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == "" || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == 0 ) {
			alert("�۾� �⺻������ ��ȸ �Ǵ� ���� �� �������� �߰��� �ּ���.");
		} else {
			ds_detail2.addrow();
			msgTxt.innerHTML="[���] ���� ���ԵǾ����ϴ�.";
		}
	}
	function fnAddRowDt3(){
		if(ds_wm.IsUpdated) {
			alert("�۾� �⺻������ �������Դϴ�. ���� �� �߰��� �ּ���.");
			return;
		}
		
		if (ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == undefined || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == "" || ds_wm.namevalue(ds_wm.rowposition,"dwr_sid") == 0 ) {
			alert("�۾� �⺻������ ��ȸ �Ǵ� ���� �� �������� �߰��� �ּ���.");
		} else {
			ds_detail3.addrow();
			msgTxt.innerHTML="[�ֿ�����] ���� ���ԵǾ����ϴ�.";
		}
	}
	
	
	
	
	<%//���� ���»� ��ȸ�ϱ�%>
	function fnPopBP(dirPath,row){	

		if(ds_detail1.namevalue(row,"NEW_VAL")=="N"){	// �߰��� ���� �ƴ� �̹� �ִ� ���»�.
			alert("�̹� �Է��� ���»縦 ������ ���� �����ϴ�.\n\n�� ���� �߰����ּ���.");
			return;
		};
		
   		var arrParam	= new Array();
   		var arrResult	= new Array();
   		var strURL;	 
   		var strPos;
   		var origin_bp_sid;
   		var origin_bp_nm;
   		var origin_bid_site_kind;
   			
   		arrParam[0] = getObjectFirst("site_sid").value;
   		arrParam[1] = getObjectFirst("v_site_nm").value;

   		
   		strURL = dirPath+"/Pms/help/si110h_01.jsp";
   		strPos = "dialogWidth:575px;dialogHeight:379px;status:no;scroll:no;resizable:no";
   		arrResult = showModalDialog(strURL,arrParam,strPos);	

   		if (arrResult != null) {
   			arrParam = arrResult.split(";");
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_sid")  		= arrParam[0];
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_nm")   		= arrParam[1];
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bid_site_kind")   = arrParam[2];
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bid_sid")   		= arrParam[3];
   	   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_job")   		= arrParam[4];	//���� �߰�	2016-06-23
   	   		
  			for (row = 1; row < ds_detail1.countrow; row++) {
  				//ȸ��� ������ ������ �ߺ� �Է� �ȵ�
  				if (ds_detail1.namevalue(row,"bp_sid") == arrParam[0] && ds_detail1.namevalue(row,"bid_site_kind") == arrParam[2] && ds_detail1.namevalue(row,"bp_job") == arrParam[4]) {
  					alert("���� ����ȸ��(=����)�� ������ �ߺ� ����� �� �����ϴ�!\n\n�̹� �Էµ� ���� ���� ���� ���� �Է��� �ּ���.");
  					ds_detail1.namevalue(ds_detail1.rowposition,"bp_sid") = "";
			   		ds_detail1.namevalue(ds_detail1.rowposition,"bp_nm") = "";
			   		ds_detail1.namevalue(ds_detail1.rowposition,"bid_site_kind") = "";
			   		ds_detail1.namevalue(ds_detail1.rowposition,"bid_sid") = "";
			   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_job")  	="";
  					return;
  				}
  			}
   		} else {
				ds_detail1.namevalue(ds_detail1.rowposition,"bp_sid") = "";
		   		ds_detail1.namevalue(ds_detail1.rowposition,"bp_nm") = "";
		   		ds_detail1.namevalue(ds_detail1.rowposition,"bid_site_kind") = "";
		   		ds_detail1.namevalue(ds_detail1.rowposition,"bid_sid") = "";
		   		ds_detail1.namevalue(ds_detail1.rowposition, "bp_job")  	="";
   		}				
     	
	}

	<%//�ֿ� ���� ��ȸ�ϱ�%>
	function fnPopITEMx(dirPath,row){	

		if(ds_detail2.namevalue(row,"item_sid")>0){
			alert("���� ����� ���� �̹� �Է��� ��� ������ ���� �����ϴ�.\n\n�� ���� �߰����ּ���.");
			return;
		};
		
   		var arrParam	= new Array();
   		var arrResult	= new Array();
   		var strURL;	 
   		var strPos;
   		var origin_bp_sid;
   		var origin_bp_nm;
   		var origin_bid_site_kind;
   			
   		arrParam[0] = getObjectFirst("site_sid").value;
   		arrParam[1] = getObjectFirst("v_site_nm").value;

   		
   		strURL = dirPath+"/Pms/help/si110h_02.jsp";
   		strPos = "dialogWidth:695px;dialogHeight:379px;status:no;scroll:no;resizable:no";
   		arrResult = showModalDialog(strURL,arrParam,strPos);	

   		if (arrResult != null) {
   			arrParam = arrResult.split(";");
   	   		ds_detail2.namevalue(ds_detail2.rowposition, "item_sid")  = arrParam[0];
   	   		ds_detail2.namevalue(ds_detail2.rowposition, "item_nm")   = arrParam[1];
   	   		ds_detail2.namevalue(ds_detail2.rowposition, "item_size")   = arrParam[2];
   	   		ds_detail2.namevalue(ds_detail2.rowposition, "item_nm_s")   = arrParam[3];

  			for (row = 1; row < ds_detail2.countrow; row++) {
  				//ȸ��� ������ ������ �ߺ� �Է� �ȵ�
  				if (ds_detail2.namevalue(row,"bp_sid") == arrParam[0] && ds_detail2.namevalue(row,"bid_site_kind") == arrParam[2]) {
  					alert("���� ��� �ߺ� ����� �� �����ϴ�!");
  					ds_detail2.namevalue(ds_detail2.rowposition,"item_sid") = "";
			   		ds_detail2.namevalue(ds_detail2.rowposition,"item_nm") = "";
			   		ds_detail2.namevalue(ds_detail2.rowposition,"item_size") = "";
			   		ds_detail2.namevalue(ds_detail2.rowposition,"item_nm_s") = "";
  					return;
  				}
  			}
   		} else {
				ds_detail2.namevalue(ds_detail2.rowposition,"item_sid") = "";
		   		ds_detail2.namevalue(ds_detail2.rowposition,"item_nm") = "";
		   		ds_detail2.namevalue(ds_detail2.rowposition,"item_size") = "";
		   		ds_detail2.namevalue(ds_detail2.rowposition,"item_nm_s") = "";
   		}				
     	
	}

	
	<%//�ֿ� ���� ��ȸ�ϱ�%>
	function fnPopITEM(dirPath,row){	

		if(ds_detail3.namevalue(row,"item_sid")>0){
			alert("���� ����� ���� �̹� �Է��� ���縦 ������ ���� �����ϴ�.\n\n�� ���� �߰����ּ���.");
			return;
		};
		
   		var arrParam	= new Array();
   		var arrResult	= new Array();
   		var strURL;	 
   		var strPos;
   		var origin_bp_sid;
   		var origin_bp_nm;
   		var origin_bid_site_kind;
   			
   		arrParam[0] = getObjectFirst("site_sid").value;
   		arrParam[1] = getObjectFirst("v_site_nm").value;

   		
   		strURL = dirPath+"/Pms/help/si110h_03.jsp";
   		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
   		arrResult = showModalDialog(strURL,arrParam,strPos);	

   		if (arrResult != null) {
   			arrParam = arrResult.split(";");
   	   		ds_detail3.namevalue(ds_detail3.rowposition, "item_sid")  = arrParam[0];
   	   		ds_detail3.namevalue(ds_detail3.rowposition, "item_nm")   = arrParam[1];
   	   		ds_detail3.namevalue(ds_detail3.rowposition, "item_size")   = arrParam[2];
   	   		ds_detail3.namevalue(ds_detail3.rowposition, "item_unit")   = arrParam[3];

  			for (row = 1; row < ds_detail3.countrow; row++) {
  				//ȸ��� ������ ������ �ߺ� �Է� �ȵ�
  				if (ds_detail3.namevalue(row,"bp_sid") == arrParam[0] && ds_detail3.namevalue(row,"bid_site_kind") == arrParam[2]) {
  					alert("���� ���縦 �ߺ� ����� �� �����ϴ�!");
  					ds_detail3.namevalue(ds_detail3.rowposition,"item_sid") = "";
			   		ds_detail3.namevalue(ds_detail3.rowposition,"item_nm") = "";
			   		ds_detail3.namevalue(ds_detail3.rowposition,"item_size") = "";
			   		ds_detail3.namevalue(ds_detail3.rowposition,"item_unit") = "";
  					return;
  				}
  			}
   		} else {
				ds_detail3.namevalue(ds_detail3.rowposition,"item_sid") = "";
		   		ds_detail3.namevalue(ds_detail3.rowposition,"item_nm") = "";
		   		ds_detail3.namevalue(ds_detail3.rowposition,"item_size") = "";
		   		ds_detail3.namevalue(ds_detail3.rowposition,"item_unit") = "";
   		}				
     	
	}

	
	
	
    <%//���-�˾� = �۾��Ϻ� Daily Work Report %>
    function fnDraft() {
        if(ds_wm.CountRow==0){
            alert("����� �۾��Ϻ��� ���� ��ȸ�� �ּ���.");
            return false;
        }
        
    	//alert(ds_wm.NameValue(ds_wm.row, "W_STS"));
    	if(ds_wm.NameValue(ds_wm.row, "W_STS")=="010"){
			// �˾� ���
    	}else if(ds_wm.NameValue(ds_wm.row, "W_STS")=="011"||ds_wm.NameValue(ds_wm.row, "W_STS")=="012"){
    		alert("�̹� ����� �۾��Ϻ��Դϴ�.\n\n�Ϻ� ��ȸ �޴��� �̿��� Ȯ���� �ּ���.");
    		return;
    	}else if(ds_wm.NameValue(ds_wm.row, "W_STS")=="013"){
			if(confirm("�ݷ��� �۾��Ϻ��Դϴ�.\n\n�����Ͻðڽ��ϱ�?")){	
				// �˾� ���
			}else{
				return;
			}
    	}
    	
        var link ="si110i_h1.jsp?v_dwr_sid="+ ds_wm.namevalue(ds_wm.row,"DWR_SID")+"&v_status=010&";
        var dialogWidth = 930; 
        //a4����� ����ٸ� 630*891 �ٵ� �װ� �� �ȵ� -_- ���� A4 ���θ� ���ߴ°�..��
        // �˾�â 930�� ���� 891��..?
        var features ="top=0,left="+ ((screen.availWidth - dialogWidth) / 2)+",height="+(screen.availHeight-52)+", width="+dialogWidth+",toolbar=no,menubar=no,status=yes,scrollbars=yes,resizable=yes";
        /* titlebar=no, 
        	location=no, �ּҰ� ���� �������� ���� 
        	menubar=no, scrollbars=yes,status=no,toolbar=no, directories=no,
        	resizable=yes ũ�� ���� ���� ����
        */
        var pop_ap_dwr = window.open(link, 'pop_ap_dwr', features); 

    
    }   		
	</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//������1 : ���� �ο� �� %>	
	<script language=JavaScript for=gr_detail1 event=OnPopup(row,colid,data)>
		if(colid=="BP_NM") {
			fnPopBP('<%=dirPath%>', row);
		}
	</script>
	<%//������2 : ���� ��� �� %>	
	<script language=JavaScript for=gr_detail2 event=OnPopup(row,colid,data)>
		if(colid=="ITEM_NM_S"||colid=="ITEM_NM") {
			fnPopITEMx('<%=dirPath%>', row);
		}
	</script>

	<%//������3 : ���� ���� �� %>	
	<script language=JavaScript for=gr_detail3 event=OnPopup(row,colid,data)>
		if(colid=="ITEM_NM") {
			fnPopITEM('<%=dirPath%>', row);
		}
	</script>

	
	<%//�˻� ���ڿ��� ���ͽ� �ٷ� ��ȸ %>
	<script language=JavaScript for=v_date event=onKeyDown(kcode,scode)>
		if (kcode == 13) fnSelect();
	</script>
	
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
		fnSelect(); // �����ϵ� ��ȸ�ϱ�
	}
	
	if(v_job=="N"){// �ű��� Ŭ���� ��¥ ��ȸ
	    for(var i=1; i<=ds_wm_chk.CountRow; i++){
	        if(ds_wm_chk.NameValue(i, "S_YN")!="Y"){ // ������ �ƴϸ� 
	            if(ds_wm_chk.NameValue(i, "MSG_CD")!="0000"){
	                alert(ds_wm_chk.NameValue(i, "MSG"));
	                return;
	            }
	        } else {
	            //alert(ds_wm_chk.NameValue(i, "MSG"));
	            	//alert("239����");        
	            getObjectFirst("ds_wm_chk").ClearAll();
	            fnNewDWR1();
	        }
	    }

	}	
	
</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language="JavaScript"  for="ds_wm" event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
    <script language=JavaScript  for=ds_wm event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			    ds_wm.ClearData();
			    ds_wd.ClearData();
			    ds_detail1.ClearData();
			    ds_detail2.ClearData();
			    ds_detail3.ClearData();
			}else{
				fnSelectDetail(row);
			}
		}
    </script>

    <script language="JavaScript"  for="ds_site_emp" event="OnLoadCompleted(row)" >
	    if(row==0){
	        alert("���� ����� ������ �Ǿ� ���� �ʽ��ϴ�.\n\n������ �˻����ּ���.\n\n���� ����� ���� ��û �� ���������� ���� ������");
	    }else{
	    	getObjectFirst("v_site_nm").value = ds_site_emp.NameValue(row,"SITE_NM");
	    	getObjectFirst("v_site_sid").value = ds_site_emp.NameValue(row,"SITE_SID");
	    }
    </script>

    
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<object id=ds_wm classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_wd classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail1 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail2 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_detail3 classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_wm_chk classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_site_emp classid=<%=HDConstant.MxDataSet_CLSID_S%>> 
    <param name="SyncLoad"  value="false"/>
</object>

<object id=ds_gc_weather classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_wdcode classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bskind classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>
<object id=ds_gc_bpjob	classid=<%=HDConstant.MxDataSet_CLSID_S%>> <!-- general code-->
    <param name="SyncLoad"  value="false"/>
</object>

<object  id="tr1" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
<object  id="tr2" classid=<%=HDConstant.MxLogicalTR_CLSID_S%>>
    <param name="KeyName"    value="toinb_dataid4"/>
    <param name="ServerIP"   value=""/>
    <param name="Action"     value=""/>
    <param name="KeyValue"   value=""/>
    <param name="Parameters" value=""/>
</object>
</head>

<!-- //body_s.jsp -->
    <jsp:include page="/Common/sys/body_s10.jsp"/>
<!-- //body_s.jsp -->

<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		
    <table border='0' cellpadding='0' cellspacing='0'> 
		<tr>
            <td class="r">
                <table border='0' cellpadding='0' cellspacing='0' width='890px'>
                    <tr>
			     		<td align=left >
							<img src="<%=dirPath%>/Sales/images/ap_up.gif"		style="cursor:pointer" onclick="fnDraft()">
						</td>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:pointer" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:pointer"  onClick="fnNewDWR()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:pointer" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:pointer"  onclick="fnCancel()">
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td class="r">
           		<table  border='0' cellpadding="0" cellspacing="1" bgcolor="#666666" width='890px'>
           			<tr>
                        <td align="center" class="text" width="70">�����</td>
                        <td bgcolor="#FFFFFF" >&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly" value="">
                            <input type="hidden"  name='v_site_sid' id='v_site_sid' value="">
                            <img src="<%=dirPath%>/Sales/images/help.gif" style="cursor:pointer" onclick="fnSelSitePopup('<%=dirPath%>');" alt="��ȸâ ��">
                            <img src="<%=dirPath%>/Sales/images/trash.gif" style="cursor:pointer" onclick="fnSelSiteCleanup();" alt="�� �����">
                        </td>
                        <td align="left" class="text" width="70">����</td>
                        
                        <td align="left" bgcolor="#ffffff">&nbsp;
                            <object id=v_date classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:2px;width:79px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=VAlign	    value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="false">
                                <param name=SelectAll   value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object>
                        </td>                                
					</tr>
           		</table>
            </td>
        </tr> 
        <tr height='6px'>
            <td></td>
        </tr>
        <tr>
            <td valign="top">
                <table  border='0' cellpadding='0' cellspacing='0'>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
								<tr height="16px">
									<td width="129px"  bgcolor="#ffffff" rowspan="2" class="c">
										<input type="hidden" name='site_sid' id="site_sid"  readOnly="readonly">
			                            <object id=w_date classid=<%=HDConstant.MxMaskEdit_CLSID_S%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;" tabindex="1">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=VAlign	    value=1>
			                                <param name=Format      value="YYYY-MM-DD">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>  
									</td>
									<td width="80px"  class="c" bgcolor="#eeeeee" rowspan="2" >����</td>
									<td width="110px" bgcolor="#ffffff" rowspan="2" >&nbsp;
			                            <object id=lc_gc_weather classid=<%=HDConstant.MxCombo_CLSID_S%> height=150 width=100 border="0"  tabindex="2">
			                                <param name=ComboDataID     value=ds_gc_weather>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
									</td>
									<td width="80px"  class="c" bgcolor="#eeeeee" >�������</td>
									<td width="80px" bgcolor="#ffffff" align="center">
			                            <object id=TEMP_MIN classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:30px; height:16px;"  tabindex="3">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=VAlign	    value=1>
			                                <param name=Numeric  	value="true">
			                                	<param name=MaxLength	value=3>
												<param name=MaxDecimalPlace	value=0>
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>&nbsp;��C</td>
									<td width="80px"  class="c" bgcolor="#eeeeee"  rowspan="2" >������</td>
									<td width="60px" class="c" bgcolor="#eeeeee">��ȹ</td>
									<td width="80px" bgcolor="#ffffff" align="center">
			                            <object id=RATE_PLAN classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:16px;" tabindex="5">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=VAlign	    value=1>
			                                <param name=Numeric  	value="true">
			                                	<param name=MaxLength	value=3>
												<param name=MaxDecimalPlace	value=2>
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>&nbsp;%</td>
									<td width="80px" class="c" bgcolor="#eeeeee"  rowspan="2" >���</td>
									<td width="100px" bgcolor="#ffffff"  rowspan="2"  align="center">
										<input type="text" name='PROG_RATE' id="PROG_RATE" style="width:44px;" class='input01' readOnly="readonly">&nbsp;%</td>																	
								</tr>

								<tr height="16px">
									<td class="c" bgcolor="#eeeeee" >�ְ���</td>
									<td width="80px" bgcolor="#ffffff" align="center">
			                            <object id=TEMP_MAX classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:30px; height:17px;"  tabindex="4">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=Numeric  	value="true">
			                                	<param name=MaxLength	value=3>
												<param name=MaxDecimalPlace	value=0>
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>&nbsp;��C</td>

									<td  class="c" bgcolor="#eeeeee" >����</td>
									<td bgcolor="#ffffff" align="center">
			                            <object id=RATE_RESULT classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style="position:relative;left:0px;top:2px;width:40px; height:17px;" tabindex="6">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=VAlign	    value=1>
			                                <param name=Numeric  	value="true">
			                                	<param name=MaxLength	value=3>
												<param name=MaxDecimalPlace	value=2>
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value="false">
			                            </object>&nbsp;%</td>								
								</tr>
							</table>
						</td>
					</tr>
                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right">
								<tr height="20px">
									<td colspan="2" class="c" bgcolor="#eeeeee">�ο�/���</td>
									<td colspan="2" class="c" bgcolor="#eeeeee" >�ֿ��۾�</td>
									<td width="150px" rowspan="2"  class="c" bgcolor="#eeeeee">���</td>
								</tr>
								<tr height="20px">
									<td width="100px"  class="c" bgcolor="#eeeeee" >����</td>
									<td width="100px"  class="c" bgcolor="#eeeeee" >����</td>
									<td width="267px"  class="c" bgcolor="#eeeeee" >����</td>
									<td width="267px"  class="c" bgcolor="#eeeeee" >����</td>
								</tr>
								<tr height="50px">
									<td bgcolor="#ffffff" align="center">
			                            <object id=man_pre classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:0px;width:30px; height:17px;" tabindex="7">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=VAlign	    value=1>
			                                <param name=Format      value="000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                            <span style= "position:relative;left:0px;top:0px;width:10px; height:17px;">&nbsp;/&nbsp;</span>
			                            <object id=machine_pre classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:0px;width:30px; height:17px;" tabindex="8">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=VAlign	    value=1>
			                                <param name=Format      value="000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
									</td>
									<td bgcolor="#ffffff" align="center">
			                            <object id=man_now classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:0px;width:30px; height:17px;" tabindex="9">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=VAlign	    value=1>
			                                <param name=Format      value="000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
			                            <span style= "position:relative;left:0px;top:0px;width:10px; height:17px;">&nbsp;/&nbsp;</span>
			                            <object id=machine_now classid=<%=HDConstant.MxMaskEdit_CLSID_S%> class="textbox" style= "position:relative;left:0px;top:0px;width:30px; height:17px;"  tabindex="10">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=1>
			                                <param name=VAlign	    value=1>
			                                <param name=Format      value="000">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
			                                <param name=SelectAll   value="true">
			                                <param name=SelectAllOnClick    value="true">
			                                <param name=SelectAllOnClickAny   value=false>
			                            </object>
									</td>
									<td bgcolor="#ffffff" align="center" >
										<textarea name="w_pre" id="w_pre"  class=textbox cols=39 rows=3  tabindex="11"></textarea>
									</td>
									<td bgcolor="#ffffff" align="center" >
										<textarea name="w_now" id="w_now"  class=textbox cols=39 rows=3  tabindex="12"></textarea>
								
									</td>
									<td bgcolor="#ffffff" align="center">
										<textarea name="w_remark" id="w_remark"  class=textbox cols=21 rows=3  tabindex="13"></textarea>
									
									</td>
								</tr>
							</table>
						</td>
					</tr>					
                    <tr>
                        <td height="4" align="right">
						<!-- <img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowWd()" > -->
						<!-- <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDelRowWd()" > -->
						</td>
					</tr>
                    <tr>
                        <td valign='top' align="right">
                        <object id=gr_wd classid=<%=HDConstant.MxGrid_CLSID_S%> width='888px' height='300px' border='1'>
                            <param name="DataID"            value="ds_wd">
                            <param name="Editable"          value="true">
                            <param name="BorderStyle"       value="0">
                            <param name="Format"            value="
                                 <C> name='����'		ID='WD_CODE'	width=100 	align=CENTER	edit=none editstyle=lookup Data='ds_gc_wdcode:detail:detail_nm'</C>
                                 <C> name='�����۾�'	ID='WD_NOW'   	width=370 	align=left	Edit=true  multiline=true</C>
                                 <C> name='�����۾�'    ID='WD_POST'	width=418 	align=left	Edit=true  multiline=true</C>
                         ">                             
                        </object>                        
                        </td>
                    </tr>
                    <tr>
                        <td valign='top'>
                        <table border="0" cellpadding="0" cellspacing="0">
	                      <tr>
	                        <td height="22" width="150" class="r b bold ">�ο�</td>
	                        <td class="r">
								<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt1()" >
							</td>
							<td height="22" width="140" class="r b bold ">���</td>
	                        <td height="22" align="right">
								<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt2()" >
								<!-- <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDelRowDt2()" > -->
							</td>
							<td height="22" width="170" class="r b bold ">�ֿ�����</td>
	                        <td height="22" align="right">
								<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer" onClick="fnAddRowDt3()" >
								<!-- <img src="<%=dirPath%>/Sales/images/minus.gif"  style="cursor:pointer" onClick="fnDelRowDt3()" > -->
							</td>
						  </tr>
                          <tr>
                          	<td class="t" colspan="2">
		                        <object id=gr_detail1 classid=<%=HDConstant.MxGrid_CLSID_S%> width='316px' height='120px' border='1'>
		                            <param name="DataID"            value="ds_detail1">
		                            <param name="ColSizing"         value="true">
		                            <param name="Editable"          value="true">
		                            <param name="SuppressOption"    value="1">
		                            <param name="BorderStyle"       value="0">
		                            <param name="ViewSummary"       value="1">
		                            <param name="Format"            value="
		                                 <C> name='ȸ��'		ID='BP_NM'  width=80 	align=left  EditStyle=popup sumtext='�Ұ�'  </C>
		                                 <C> name='ȸ��sid'		ID='BP_SID' width=80 	align=CENTER  edit=none  show=false</C>
		                                 <C> name='����sid'		ID='BID_SID' width=80 	align=CENTER  edit=none  show=false</C>
		                                 <C> name='����'		ID='BID_SITE_KIND'   	width=60 	align=left	Edit=None editstyle=lookup Data='ds_gc_bskind:detail:detail_nm'</C>
										<C> name='����'		ID='BP_JOB'  				width=60 	align=CENTER	Edit=None editstyle=lookup Data='ds_gc_bpjob:detail:detail_nm'</C>
										<C> name='����'    	ID='NOW_COMMIT'		width=40 	align=right Edit=true decao=0 sumtext=@sum </C>
										<C> name='����'    	ID='TOT_COMMIT'		width=60 	align=right Edit=None decao=0 sumtext=@sum </C>
		                         ">
		                        </object>
                          	</td>
                          	<td class="t" colspan="2">
		                        <object id=gr_detail2 classid=<%=HDConstant.MxGrid_CLSID_S%> width='256px' height='120px' border='1'>
		                            <param name="DataID"            value="ds_detail2">
		                            <param name="ColSizing"         value="true">
		                            <param name="Editable"          value="true">
		                            <param name="SuppressOption"    value="1">
		                            <param name="BorderStyle"       value="0">
		                            <param name="ViewSummary"       value="1">
		                            <param name="Format"            value="
		                                 <C> name='���'		ID='ITEM_NM_S'		width=80 	align=left		 EditStyle=popup sumtext='�Ұ�'  </C>
		                                 <C> name='���SID'		ID='ITEM_SID'		width=80 	align=CENTER	edit=none  show=false</C>
		                                 <C> name='�԰�'		ID='ITEM_SIZE'   	width=60 	align=CENTER	Edit=None</C>
		                                 <C> name='����'    	ID='NOW_COMMIT'		width=40 	align=CENTER	Edit=true  sumtext=@sum </C>
		                                 <C> name='����'    	ID='TOT_COMMIT'		width=60 	align=CENTER	Edit=None  sumtext=@sum </C>
		                         ">                             
		                        </object>   
                          	</td>
                          	<td class="t" colspan="2">
		                        <object id=gr_detail3 classid=<%=HDConstant.MxGrid_CLSID_S%> width='314px' height='120px' border='1'>
		                            <param name="DataID"            value="ds_detail3">
		                            <param name="ColSizing"         value="true">
		                            <param name="Editable"          value="true">
		                            <param name="SuppressOption"    value="1">
		                            <param name="BorderStyle"       value="0">
		                            <param name="ViewSummary"       value="1">
		                            <param name="Format"            value="
		                                 <C> name='ǰ��'		ID='ITEM_NM'		width=80 	align=left   EditStyle=popup sumtext='�Ұ�'  </C>
		                                 <C> name='ǰ��SID'		ID='ITEM_SID'		width=80 	align=CENTER	edit=none  show=false</C>
		                                 <C> name='�԰�'		ID='ITEM_SIZE'   	width=60 	align=CENTER	Edit=None</C>
		                                 <C> name='����'		ID='ITEM_UNIT'   	width=58 	align=CENTER	Edit=None</C>
		                                 <C> name='����'    	ID='NOW_COMMIT'		width=40 	align=CENTER	Edit=true  sumtext=@sum </C>
		                                 <C> name='����'    	ID='TOT_COMMIT'		width=60 	align=CENTER	Edit=None  sumtext=@sum </C>
		                         ">                             
		                        </object>   

                          	</td>
                          </tr>
                        </table>
                        </td>
                    </tr>

                    <tr>
                        <td valign='top'>
							<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" align="right" width="100%">
								<tr height="21px">
									<td width="160px"class="text">���� ��û����</td>
									<td bgcolor="#ffffff" align="center" >
										<textarea name="remark" id="remark"  class=textbox cols=116 rows=3  tabindex="14"></textarea>
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
	
	     <object id=bn1 classid=<%=HDConstant.MxBinder_CLASSID%>>
	             <param name="DataId" value="ds_wm">
	             <param name=BindInfo    value="
					<C>Col=SITE_SID    		Ctrl=site_sid		Param=Value </C>
					<C>Col=W_DATE			Ctrl=w_date        Param=Text </C>
					<C>Col=WED      		Ctrl=lc_gc_weather     Param=BindColVal </C>
					<C>Col=TEMP_MAX       	Ctrl=TEMP_MAX      Param=Text </C>
					<C>Col=TEMP_MIN        	Ctrl=TEMP_MIN       Param=Text </C>
					<C>Col=RATE_PLAN		Ctrl=RATE_PLAN  	Param=Text </C>
					<C>Col=RATE_RESULT		Ctrl=RATE_RESULT    Param=Text </C>
					<C>Col=PROG_RATE	    Ctrl=PROG_RATE     Param=Value </C>
					<C>Col=MAN_PRE       	Ctrl=man_pre       Param=Text </C>
					<C>Col=MACHINE_PRE      Ctrl=machine_pre   Param=Text </C>
					<C>Col=MAN_NOW     		Ctrl=man_now   Param=Text </C>
					<C>Col=MACHINE_NOW  	Ctrl=machine_now    Param=Text </C>
					<C>Col=W_PRE        	Ctrl=w_pre        Param=Value </C>
					<C>Col=W_NOW    		Ctrl=w_now    	Param=Value </C>
					<C>Col=W_REMARK   		Ctrl=w_remark	Param=Value </C>
					<C>Col=REMARK   		Ctrl=remark		Param=Value </C>
	              ">
	      </object>
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		