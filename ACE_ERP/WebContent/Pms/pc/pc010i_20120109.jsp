<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	 : ���� ���
 * ���α׷�ID 	 : PMS/PC010I
 * J  S  P		 : pc010i.jsp
 * �� �� ��		 : Pc010I
 * �� �� ��		 : �ɵ���
 * �� �� ��		 : 2011-07-06
 * �������		 : ���� ����/��� ���/��ȸ
 * [ �������� ][������] ����
 * [2011-07-06][�ɵ���] �ű�, ���� �����ϳ�..�Ʊ���..���ȭ��(__)
 * [2011-07-06][�ɵ���] ������ �ʱ�ȭ, ���߰�, �˻� �˵�, , ����  �׽�Ʈ ������ ����
 * [2011-10-25][�ɵ���] 9���� ��������� �̾߱��� ��.. �� ���󰡾� �Ѵ�.. 
 * [2011-10-25][�ɵ���] ��	��ũ��Ʈ �ٵ�� (����) : luxcombo�� event�� OnCloseUp()���� ����!!
 * [2011-10-25][�ɵ���] ��	��翹��(��), �ϵ��޿���(��) �Լ� ó��! : �ѱ� ������ִ� �� �볪�ڴ�..�� 
 * [2011-10-26][�ɵ���] ��	����� ���ΰ� ������ ���� : ���ε� �� ���� (Ȥ�� �𸣴� ������ ���ܳ�����..����� ��������..)
 * [2011-10-26][�ɵ���] ��	���� �� �޼��� : ����Ǿ������.?
 * [2011-10-26][�ɵ���] ��	���� ��� ���� �߰�
 * ������ ���� �� ����ȸ ?
 * ���ް���� ������~�������� ǥ�ÿ��� : �ֳ�? �ϵ��� ����~�������� �Է��ϴϱ�.. �ʿ����� ������.. 
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
// ���� ��Ÿ���� �ݿø� �Լ� ����
	function roundXL(n, digits) {
	  if (digits >= 0) return parseFloat(n.toFixed(digits)); // �Ҽ��� �ݿø�
	
	  digits = Math.pow(10, digits); // ������ �ݿø�
	  var t = Math.round(n * digits) / digits;
	
	  return parseFloat(t.toFixed(0));
	}


	function changeKor() {
		obj=v_act_amt.text +'000';
		if(obj==""){    //���ڸ� �Է����� �ʾ����� alertâ�� ���ϴ�. 
			v_act_amt_kor.innerText = "";
		}else if(isNaN(obj)){   //���ڸ� �Է����� �ʾ��� ��쿡 alertâ�� ���ϴ�. 
//			alert("���ڸ� �Է��Ͻÿ�.");
			v_act_amt_kor.innerText = "";
		}else{
			unit1 = new Array("","��","��","��","��","��","��","ĥ","��","��");
			unit2 = new Array("��","��","õ");
			unit3 = new Array("��","��","��");

			total=obj.length;    //�Է��� ������ ���̸� ������ ����ϴ�. 
			rs="";       //���ڸ� �ѱ۷� ��ȯ�� ������ ���� ������ �����մϴ�. 
			for(i=0; i<total ;i++) {
				num=obj.substring(i,i+1);
				temp1=total-i;
 
				for(j=0; j<unit1.length; j++){//���ڸ� �ѱ۷� ��ȯ�մϴ�. 
					if(num == j)
						rs+=unit1[j];
				}
    
			    if(num != 0 && (total-1)!= i){//���ڰ� 0�̸� �ѱ۷� ��ȯ�����ʽ��ϴ�.
			    	// �׸��� ������ ���ڿ��� ������  ������ �ʽ��ϴ�. 
 					//��,��,õ ������ ���Դϴ�. 
					if(obj.substring(0,(total-i)).length%4 == 0)
				      rs+=unit2[2];
					if(obj.substring(0,(total-i)).length%4 == 3)
				      rs+=unit2[1];
					if(obj.substring(0,(total-i)).length%4 == 2)
				      rs+=unit2[0];
				}
    
				//�� ,��,�� ������ ���Դϴ�. 
			    if(temp1 == 5)
				     rs+=unit3[0];
			    else if(temp1 ==9)
				     rs+=unit3[1];
			    else if(temp1 == 13)
				     rs+=unit3[2];
			}
			v_act_amt_kor.innerText = rs; //  result�� ������ �ؽ�Ʈ�� �Է��մϴ�. 
		}
	}

	function changeKor2() {
		obj=v_act_amt_ha.text +'000';
		if(obj==""){    //���ڸ� �Է����� �ʾ����� alertâ�� ���ϴ�. 
//			alert("�ݾ��� �Է��� �ּ���.");
			v_act_amt_ha_kor.innerText = "";
		}else if(isNaN(obj)){   //���ڸ� �Է����� �ʾ��� ��쿡 alertâ�� ���ϴ�. 
//			alert("���ڸ� �Է��Ͻÿ�.");
			v_act_amt_ha_kor.innerText = "";
		}else{
			unit1 = new Array("","��","��","��","��","��","��","ĥ","��","��");
			unit2 = new Array("��","��","õ");
			unit3 = new Array("��","��","��");

			total=obj.length;    //�Է��� ������ ���̸� ������ ����ϴ�. 
			rs="";       //���ڸ� �ѱ۷� ��ȯ�� ������ ���� ������ �����մϴ�. 
			for(i=0; i<total ;i++) {
				num=obj.substring(i,i+1);
				temp1=total-i;
 
				for(j=0; j<unit1.length; j++){//���ڸ� �ѱ۷� ��ȯ�մϴ�. 
					if(num == j)
						rs+=unit1[j];
				}
    
			    if(num != 0 && (total-1)!= i){//���ڰ� 0�̸� �ѱ۷� ��ȯ�����ʽ��ϴ�.
			    	// �׸��� ������ ���ڿ��� ������  ������ �ʽ��ϴ�. 
 					//��,��,õ ������ ���Դϴ�. 
					if(obj.substring(0,(total-i)).length%4 == 0)
				      rs+=unit2[2];
					if(obj.substring(0,(total-i)).length%4 == 3)
				      rs+=unit2[1];
					if(obj.substring(0,(total-i)).length%4 == 2)
				      rs+=unit2[0];
				}
    
				//�� ,��,�� ������ ���Դϴ�. 
			    if(temp1 == 5)
				     rs+=unit3[0];
			    else if(temp1 ==9)
				     rs+=unit3[1];
			    else if(temp1 == 13)
				     rs+=unit3[2];
			}
			v_act_amt_ha_kor.innerText = rs; //  result�� ������ �ؽ�Ʈ�� �Է��մϴ�. 
		}
	}	
</script> 



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
        ds_srch_bid_style.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=3&s_Head=CT005&s_item1=Y";
        ds_srch_bid_style.Reset();	//��������
        ds_srch_bid_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=CT016&s_item1=Y";
        ds_srch_bid_status.Reset();	//��������

        ds_bid_style.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT005&s_item1=Y";
        ds_bid_style.Reset();	//��������
        ds_bid_status.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT016&s_item1=Y";
        ds_bid_status.Reset();	//��������
        ds_result_cp.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT017&s_item1=Y";
        ds_result_cp.Reset();	//�������
        ds_reco_dept.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=CT006&s_item1=Y";
        ds_reco_dept.Reset();	//��õ�μ�

        v_fr_bid_date.Text = "<%=DateUtil.getCurrentDate(8)%>";
        v_to_bid_date.Text = "<%=DateUtil.getCurrentDate(8)%>";

//        v_fr_bid_date.Text = "20101201";
//        v_to_bid_date.Text = "20101201";

		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_PC%>Pc010I1",
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
		    
	        var fr_date = v_fr_bid_date.Text.trim();
	        var to_date = v_to_bid_date.Text.trim();
	
	        if(fr_date.length!=8) {
	            alert("�������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        if(to_date.length!=8) {
	            alert("�������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	    	}
	    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                  + ",v_site_sid="+ v_site_sid.value
	                  + ",v_bid_kind_cd=" + v_bid_kind_cd.value
	                  + ",v_fr_bid_date=" + fr_date
	                  + ",v_to_bid_date=" + to_date
	                  + ",v_bid_style=" + lc_srch_bid_style.ValueOfIndex("detail", lc_srch_bid_style.Index)
	                  + ",v_bid_status=" + lc_srch_bid_status.ValueOfIndex("detail", lc_srch_bid_status.Index) ;
	        //alert(param);
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_PC%>Pc010I1",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           
	        tr_post(tr1);
		};
    }    

    <%//������ ��ȸ%>
    function fnSelectDetail(row) {
        v_default_row = row;
        var v_param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                    + ",v_bid_sid="+getObjectFirst("ds_default").NameValue(row, "BID_SID");
                    
        ln_TRSetting(tr2, 
            "<%=dirPath%><%=HDConstant.PATH_PC%>Pc010I1",
            "JSP(O:DS_TENDER=ds_tender)",
            v_param);
        tr_post(tr2);
    }

	<%//���� %>
	function fnApply(){
		v_job = "A";
		var row=ds_default.countRow;
		
		if (ds_default.IsUpdated || ds_tender.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_PC%>Pc010I1",
                "JSP(I:DS_DEFAULT=ds_default,I:DS_TENDER=ds_tender)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
        		tr_post(tr1);
        	}
		}else {
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}
	}
	<%//�Է°� üũ %>
	function ln_Chk() {
		/*
		var row1=ds_default.countrow;
		var row2=ds_tender.countrow;

		for(i=1;i<=row1;i++) {
			if(ds_default.namevalue(i,"site_nm")=="") {
				alert("���ް�� ���� �Է��� �ֽʽÿ�");
				site_nm.focus();
				return;
			}else if (ds_default.namevalue(i,"orderer_nm")=="") {			
				alert("����ó�� �Է��� �ֽʽÿ�");
				orderer_nm.focus();
				return;
			}
		}		*/
		return true;
	}



	
	<%//�׼� �ٿ�ε� %>
    function fnExcelDsDefault() {
        if(ds_default.CountRow==0){
            alert("�����͸� ���� ��ȸ�Ͻñ� �ٶ��ϴ�.");
            return;
        }
        getObjectFirst("gr_default").SetExcelTitle(0, "");
        getObjectFirst("gr_default").SetExcelTitle(1, "value:���庰 ������Ȳ; font-face:; font-size:30pt; font-color:black;font-bold; bgcolor:white; align:center; line-color:black;line-width:2pt; skiprow:1;");
        getObjectFirst("gr_default").GridToExcel("������Ȳ", "������Ȳ.xls", 8);        
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
    

	<%//���� ��- ��ȸ%>
    function fnSelKindPopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtKindPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_bid_kind_cd.value = arrParam[0];
            v_bid_kind_nm.value = arrParam[1];
        } else {
		    fnSelKindCleanup();
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

        
        // ����� ��ȣ�� ����� ������ ��!
		arrResult = fnCtSitePop(dirPath);
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            v_site_nm1.value = arrParam[1];	//NM
            v_site_sid1.value = arrParam[2];	//SID
        } else {
			fnSelSiteCleanup1();
        }               
        //���Ⱑ ������������ �ҷ����� ����-��� �� : Ȯ��!?
        /*
        arrResult = fnCtSitePop1(dirPath);
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_site_sid1.value = arrParam[0];//SITE_SID //
			v_bid_day.text = arrParam[1];//DATE_CT //
			v_site_nm1.value = arrParam[2];//SITE_NM //
			v_orderer_sid.value = arrParam[3];//ORDERER_SID //
			v_orderer_nm.value = arrParam[4];//ORDERER_NM //
			// = arrParam[5]; //SITE_SEQ_CT_CD //
			// = arrParam[6]; //SITE_SEQ_CH_CD //
			v_site_seq_ct.value = arrParam[7]; //SITE_SEQ_CT //
			v_site_seq_ch.value = arrParam[8]; //SITE_SEQ_CH //
			v_amt_ct_tot.text = arrParam[9]; //AMT_CT_TOT //
			v_amt_ct.text = arrParam[10]; //AMT_CT //
			v_amt_ct_vat.text = arrParam[11]; //AMT_CT_VAT //
			v_ct_date_begin.text = arrParam[12]; //DATE_BEGIN //
			v_ct_date_end.text = arrParam[13]; //DATE_END //

        } else {
			fnSelSiteCleanup1();
        } */              
    }

	<%//���� ��- �Է�%>
    function fnSelKindPopup1(dirPath) {
        if(ds_default.CountRow==0){
            alert("�ű� ��ư���� �� ���� �߰��Ͻñ� �ٶ��ϴ�.");
            return;
        }

        var arrParam    = new Array();
        var arrResult   = new Array();

        
        arrResult = fnCtKindPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_bid_kind_cd1.value = arrParam[0];
            v_bid_kind_nm1.value = arrParam[1];
        } else {
		    fnSelKindCleanup1();
        }               
    }
    

	<%//���»� ��- GRID%>
    function fnSelCoopPopup(dirPath,row) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnCtCoopPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            //v_coop_cd.value = arrParam[0];	//CD
            ds_tender.namevalue(ds_tender.RowPosition, "COOP_NM")= arrParam[1];	//NM
            ds_tender.namevalue(ds_tender.RowPosition, "COOP_SID")= arrParam[2];	//SID
        } else {
            ds_tender.namevalue(ds_tender.RowPosition, "COOP_NM")= "";	//NM
            ds_tender.namevalue(ds_tender.RowPosition, "COOP_SID")= 0;	//SID
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

    function fnSelKindCleanup(){
        v_bid_kind_cd.value = "";
        v_bid_kind_nm.value  = "";
    }
    function fnSelKindCleanup1(){
        v_bid_kind_cd1.value = "";
        v_bid_kind_nm1.value  = "";
    }
    function fnSelCoopCleanup(){
        v_coop_nm.value = "";
        v_coop_sid.value  = "";
    }
    


	<%// ������ �ű� %>
	function fnAddRowDsDefault(){
		if(ds_tender.IsUpdated) {
			alert("�������� ���� ������ �ű� ���������� ������ �� �����ϴ�.");
			return;
		}else {
			v_job="N";
			ds_default.addrow();
			ds_tender.clearall();
			v_bid_day.text="<%=DateUtil.getCurrentDate(8)%>";
			lc_bid_style.index = 0;
			lc_bid_status.index = 0;			
			v_date_begin.text="<%=DateUtil.getCurrentDate(8)%>";
			v_date_end.text="<%=DateUtil.getCurrentDate(8)%>";
			
			v_bid_day.focus();
			
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
		if (ds_default.namevalue(ds_default.rowposition,"BID_SID") == undefined || ds_default.namevalue(ds_default.rowposition,"BID_SID") == "" || ds_default.namevalue(ds_default.rowposition,"BID_SID") == 0 ) {
			alert("���������� ��ȸ/���� �� �߰��� �ּ���.");
		} else {
			ds_tender.addrow();
			ds_tender.namevalue(ds_tender.RowPosition, "BID_SID") = ds_default.namevalue(ds_default.rowposition,"BID_SID");
			ds_tender.namevalue(ds_tender.RowPosition, "RESULT_CP") = "2";
			
			window.status="���� ��ü ���� ���ԵǾ����ϴ�.";
		}
	}

	<%//������ ����� %>
	function fnDeleteRowDs2(){
		ds_tender.deleterow(ds_tender.rowposition);
		window.status="���� ��ü ���� �����Ǿ����ϴ�.";
	}

	<%// �׸��� ���� ��� %>
	function fnCancel() {
        ds_default.undoall();
        ds_tender.undoall();
		window.status="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//�������� Ŭ���� ������ü ��ȸ %>
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
	
	<%//������ �Է� �� % ���%>	
	<script language="javascript"  for="gr_tender" event=OnExit(row,colid,olddata)>
		//alert("Occur OnExit Event :\r" + "<ROW :" + row +">"+ "<Colid :" + colid + ">" + "<Before Data :" + olddata + ">" );
		var rateVal ;
		if(colid=="BID_AMT"){
			rateVal = roundXL(ds_tender.namevalue(ds_tender.RowPosition, "BID_AMT")/ds_default.namevalue(ds_default.RowPosition, "ACT_AMT")*100,1);
			ds_tender.namevalue(ds_tender.RowPosition, "BID_AMT_PCT2")=rateVal; //����(%)

			rateVal = roundXL(ds_tender.namevalue(ds_tender.RowPosition, "BID_AMT")/ds_default.namevalue(ds_default.RowPosition, "ACT_AMT_HA")*100,1);
			ds_tender.namevalue(ds_tender.RowPosition, "BID_AMT_PCT1")=rateVal; //����(%)
			
		}			 
			//BID_AMT_PCT1
		if(colid=="BID_AMT2"){
			rateVal = roundXL(ds_tender.namevalue(ds_tender.RowPosition, "BID_AMT2")/ds_default.namevalue(ds_default.RowPosition, "ACT_AMT")*100,1);
			ds_tender.namevalue(ds_tender.RowPosition, "BID_AMT2_PCT2")=rateVal;			
			rateVal = roundXL(ds_tender.namevalue(ds_tender.RowPosition, "BID_AMT2")/ds_default.namevalue(ds_default.RowPosition, "ACT_AMT_HA")*100,1);
			ds_tender.namevalue(ds_tender.RowPosition, "BID_AMT2_PCT1")=rateVal; //����(%)

		}
	</script>

	<%//��ü�� ���%>
	<script language="JavaScript" for="gr_tender" event="OnPopup(row,colid,data)">
		if(colid=="COOP_NM") {
			fnSelCoopPopup("<%=dirPath%>", row);
		}
	</script>

	<%//�������� ����- ������ �����ϸ� �����൵ ��� ������~ %>
	<script language="JavaScript" for="lc_bid_status" event="OnCloseUp()">
		if(lc_bid_status.ValueOfIndex("detail", lc_bid_status.Index)=="DLY" ){
			//alert(lc_bid_status.ValueOfIndex("detail", lc_bid_status.Index));
			var row2=ds_tender.countrow;
			for(i=1;i<=row2;i++) {
				if(ds_tender.namevalue(i, "RESULT_CP") != "9"){
					ds_tender.namevalue(i, "RESULT_CP") = "9";
				}
			}
			
		};
	</script>

	<script language="javascript"  for="v_act_amt" event="OnKeyUp()">
		changeKor();
	</script>	
	<script language="javascript"  for="v_act_amt_ha" event="OnKeyUp()">
		changeKor2();
	</script>		
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>
<script language="javascript" for="tr1" event="OnSuccess()">
	if(v_job=="A"){
		alert("���������� ����Ǿ����ϴ�.");
		fnSelect();
	}
    window.status = "<%=HDConstant.S_MSG_SAVE_DONE%>";
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

<object id=ds_srch_bid_style classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��ȸ: �������� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_srch_bid_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��ȸ: �������� -->
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_bid_style classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_bid_status classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �������� -->
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_result_cp classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ������� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_reco_dept classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- ��õ�μ� -->
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
<jsp:include page="/Common/sys/body_s10.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

   
    <table border='0' cellpadding='0' cellspacing='0' width="845px"> 
        <tr>
            <td align='right'>
                <table border='0' cellpadding='0' cellspacing='0' width='300px'>
                    <tr>
                        <td height='25px' align='right'>
							<img src="<%=dirPath%>/Sales/images/refer.gif"		style="cursor:hand" onclick="fnSelect()">
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:hand"  onClick="fnAddRowDsDefault()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"		style="cursor:hand"  onclick="fnCancel()">
							<img src="<%=dirPath%>/Sales/images/delete.gif" 	style="cursor:hand" onClick="fnDeleteRowDsDefault()" >
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
                                    <td bgcolor="#FFFFFF" colspan="3">&nbsp;<input type="text" name='v_site_nm' id="v_site_nm" style="width:360px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid' id='v_site_sid'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSiteCleanup();" alt="�� �����">
                                    </td>
                                    <td align="center" class="text" width="70">����</td>
                                    <td bgcolor="#FFFFFF">&nbsp;<input type="text" name='v_bid_kind_nm' id='v_bid_kind_nm' style="width:130px;" class='input01' onkeydown="if(event.keyCode==113) fnSelKindPopup('<%=dirPath%>');" readOnly="readonly">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelKindPopup('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelKindCleanup();" alt="�� �����">
                                        <input type="hidden" name='v_bid_kind_cd' id='v_bid_kind_cd' style="width:40px;" class='input01' readOnly>
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">��������</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_fr_bid_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
			                            <object id=v_to_bid_date classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
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
                    				<td align=left class="text">��������</td>
			                        <td align=left bgcolor="#ffffff">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_srch_bid_style classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_srch_bid_style>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
			                        </td>
                    				<td align=left class="text">��������</td>
			                        <td align=left bgcolor="#ffffff" WIDTH="220">&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_srch_bid_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_srch_bid_status>
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
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='300px' height='207px' border='1'>
                                <param name="DataID"            value="ds_default">
                                <param name="ColSizing"         value="true">
                                <param name="Editable"          value="false">
                                <param name="SuppressOption"    value="1">
                                <param name="BorderStyle"       value="0">
                                <param name="ViewSummary"       value="1">
                                <param name="Format"            value="
                                     <C> name='����' 		ID='BID_DAY'    	width=60 	align=CENTER	Edit=None suppress=1</C>
                                     <C> name='����'		ID='BID_STYLE' 		width=60 	align=CENTER	edit=none editstyle=lookup Data='ds_bid_style:detail:detail_nm' suppress=2 sumtext='��'  sumtextalign='right'</C>
                                     <C> name='�����'      ID='SITE_NM'       	width=120 	align=left 		Edit=None suppress=3 sumtext='@cnt' sumtextalign='right'</C>
                                     <C> name='����'  		ID='CT_KIND_NM'    	width=60 	align=left 		Edit=None suppress=4 sumtext='��' sumtextalign='left'</C>
                                     <C> name='����'    	ID='ACT_AMT'   		width=80 	align=right 	Edit=None decao=0 show=false</C>
                                     <C> name='����(��)'   	ID='ACT_AMT_KOR'   	width=80 	align=right 	Edit=None decao=0 show=false</C>
                                     <C> name='����'    	ID='ACT_AMT_HA'   	width=60 	align=right 	Edit=None decao=0 show=false</C>
                                     <C> name='����(��)'   	ID='ACT_AMT_HA_KOR'	width=60 	align=right 	Edit=None decao=0 show=false</C>
                                     <C> name='��������'	ID='BID_STATUS'    	width=80 	align=right 	Edit=None decao=0 show=false</C>
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>

                        </td>
			            <td width="9px"></td>
                        <td valign="top">
							<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
								<tr height="21px">
									<td width="120px" class="text">����</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_bid_day classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
									<td width="120px" class="boardt02">��������</td>
									<td width="145px" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=lc_bid_style classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=80 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_bid_style>
                                            <param name=BindColumn      value="detail">
                                            <param name=BindColVal      value="detail">
                                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat  value="detail_nm^0^80">
			                            </object>
										<%=HDConstant.COMMENT_END%>
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="text">�����</td>
									<td bgcolor='#ffffff' colspan="3">&nbsp;<input type="text" name='v_site_nm1' id="v_site_nm1" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelSitePopup1('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_site_sid1' id='v_site_sid1'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelSitePopup1('<%=dirPath%>');" alt="��ȸâ ��">
									</td>
								</tr>
								<tr height="21px">
									<td width="120px" class="boardt02">�ϵ��� ������</td>
									<td bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_begin classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
									<td width="120px" class="boardt02">�ϵ��� ������</td>
									<td bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_date_end classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
								</tr>
								<tr height="21px">
									<td width="120px" class="boardt02">�����ڵ�</td>
									<td bgcolor='#ffffff'>&nbsp;<input type="text" name='v_bid_kind_nm1' id='v_bid_kind_nm1' style="width:90px;" class='textbox' onkeydown="if(event.keyCode==113) fnSelKindPopup1('<%=dirPath%>');" readOnly="readonly">
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelKindPopup1('<%=dirPath%>');" alt="��ȸâ ��">
                                        <input type="hidden" name='v_bid_kind_cd1' id='v_bid_kind_cd1' style="width:40px;" class='input01' readOnly>
									</td>
									<td width="120px" class="boardt02">��������</td>
									<td bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
										<object id=lc_bid_status classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
											<param name=ComboDataID     value=ds_bid_status>
											<param name=BindColumn      value="detail">
											<param name=BindColVal      value="detail">
											<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
											<param name=ListExprFormat  value="detail_nm^0^100">
										</object>
										<%=HDConstant.COMMENT_END%>
									</td>

								</tr>
								<tr height="21px">
									<td width="120px" class="boardt02">����</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_act_amt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=90 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:115px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=Format      value="">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
											<param name=Numeric		value="true">
											<param name=IsComma   	value=true>
			                            </object><%=HDConstant.COMMENT_END%>  										
									</td>
									<td width="120px" class="boardt02">����(��)</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_act_amt_kor' id="v_act_amt_kor" style="width:120px;" class='textbox' > ��</td>
								</tr>								
								<tr height="21px">
									<td width="120px" class="boardt02">����</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
			                            <object id=v_act_amt_ha classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=130 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:115px; height:17px;">
			                                <param name=Text        value="">
			                                <param name=Alignment   value=2>
			                                <param name=Format      value="">
			                                <param name=Cursor      value="iBeam">
			                                <param name=Border      value="false">      
			                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
			                                <param name=ReadOnly    value="false">
											<param name=Numeric		value="true">
											<param name=IsComma   	value=true>
			                            </object><%=HDConstant.COMMENT_END%>  										
									</td>
									<td width="120px" class="boardt02">����(��)</td>
									<td colspan="1" bgcolor='#ffffff'>&nbsp;<input type="text" name='v_act_amt_ha_kor' id="v_act_amt_ha_kor" style="width:120px;" class='textbox' > ��</td>
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
                         <C> name='bid' 		ID='BID_SID'   		width=40 	align=CENTER	edit=none show=false</C>
                         <C> name='���' 		ID='SEQ'    		width=40 	align=CENTER	 </C>
                         <C> name='���'		ID='RESULT_CP' 		width=60 	align=CENTER	editstyle=lookup Data='ds_result_cp:detail:detail_nm'</C>
                         <C> name='��ü��'		ID='COOP_NM'		width=80	align=left		EditStyle=popup </C>
                         <C> name='��ü'		ID='COOP_SID'		width=40	align=left 		edit=none show=false</C>                         
					  <G> name='1��'
                         <C> name='������'		ID='BID_AMT'    	width=90 	align=right 	 decao=0</C>
                         <C> name='����(%)'		ID='BID_AMT_PCT2'	width=55 	align=right 	edit=none decao=1</C>
                         <C> name='����(%)'		ID='BID_AMT_PCT1'	width=50 	align=right 	edit=none decao=1</C>
					  </G>
					  <G> name='2��'
                         <C> name='������'		ID='BID_AMT2'    	width=90 	align=right 	 decao=0</C>
                         <C> name='����(%)'		ID='BID_AMT2_PCT2'	width=60 	align=right 	edit=none decao=1</C>
                         <C> name='����(%)'		ID='BID_AMT2_PCT1'	width=50 	align=right 	edit=none decao=1</C>
					  </G>
                         <C> name='��õ�μ�'	ID='RECO_CD'		width=70 	align=center	editstyle=lookup Data='ds_reco_dept:detail:detail_nm'</C>
                         <C> name='���'   		ID='REMARK'			width=165 	align=LEFT		</C>
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
					<C>Col=BID_DAY        Ctrl=v_bid_day        Param=Text </C>
					<C>Col=BID_STYLE      Ctrl=lc_bid_style     Param=BindColVal </C>
					<C>Col=SITE_SID       Ctrl=v_site_sid1      Param=Value </C>
					<C>Col=SITE_NM        Ctrl=v_site_nm1       Param=Value </C>
					<C>Col=DATE_BEGIN     Ctrl=v_date_begin     Param=Text </C>
					<C>Col=DATE_END       Ctrl=v_date_end       Param=Text </C>
					<C>Col=CT_KIND        Ctrl=v_bid_kind_cd1   Param=Value </C>
					<C>Col=CT_KIND_NM     Ctrl=v_bid_kind_nm1   Param=Value </C>
					<C>Col=BID_STATUS     Ctrl=lc_bid_status    Param=BindColVal </C>
					<C>Col=ACT_AMT        Ctrl=v_act_amt        Param=Text </C>
					<C>Col=ACT_AMT_KOR    Ctrl=v_act_amt_kor    Param=Value </C>
					<C>Col=ACT_AMT_HA     Ctrl=v_act_amt_ha     Param=Text </C>
					<C>Col=ACT_AMT_HA_KOR Ctrl=v_act_amt_ha_kor Param=Value </C>
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		