<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - �ý��۸� 	     : �ⳳ ���Ե��
 - ���α׷�ID 	 : PMS/SI030I
 - J  S  P		     : si030i.jsp
 - �� �� ��		 : Si010I
 - �� �� ��		 : ������
 - �� �� ��		 : 2012-06-07
 - �������		 : �ⳳ��ϰ� �� ���� ���ǿ� ���Ͽ� ��ȸ ������.
 - [ �������� ][������] ����
 - [2012-05-21][������] �ű�
 -----------------------------------------------------------------------------
 - [ �������� ][������] ����
 - [2013-01-15][������] ���̰��������� ��� ���������� �鼼�� �����ϰ�� ���Ե�� �Ұ�  
 - [ �������� ][������] ����
 - [2014-04-14][������] �����ڵ� �߰� 

 =============================================================================*/
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
	var v_default_row = 1;
    var v_job = ""; //Transaction Job�� �Ӽ�����. S:��ȸ, I:�ʱ�, N:�ű�, SD:��������ȸ, A:����

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");  //grid ����
		cfStyleGrid(getObjectFirst("gr_default2"), "comn");  //grid ���� 
		fnInit();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {

	    v_job ="I";
	    
        ds_ingb_cd_0.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI001&s_item1=Y";
        ds_ingb_cd_0.Reset(); //�Է±��� 
        
        ds_ingb_cd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI001&s_item1=Y";
        ds_ingb_cd.Reset();  //�Է±��� 
    
        ds_fdcode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	    ds_fdcode.Reset();   //���� 
	    
	    ds_cocode.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2210"; 
	    ds_cocode.Reset();  //����� 
    
	    ds_tax_knd.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	    ds_tax_knd.Reset();  //��������[����]
	    
	    ds_tax_div.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	    ds_tax_div.Reset();   //�ͼӱ���[����]
	    
	    ds_gubun.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2200"; 
	    ds_gubun.Reset();   //���౸��
	    
	    
        vt_fr_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        vt_fr_inout_dt.Text = vt_fr_inout_dt.Text .substring(0,6)+"01";
        vt_to_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";

        //vt_fr_inout_dt.Text = "20120401";
        //vt_to_inout_dt.Text = "20120430";
        
        v_empnmk.value=gusrnm;
        v_empno.value=gusrid;

        return;
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si030I1",
            "JSP(O:DS_DEFAULT=ds_default)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
             tr_post(tr1);      
             
       		lc_fdcode.bindcolval = gfdcode;
      	    lc_cocode.bindcolval = gcocode;             
    }
    
    <%//���� ��ȸ  %>
    function fnSelect() {
    

		if (ds_default.IsUpdated ) {
			alert("�������� ���� �ֽ��ϴ�.");
		} else {
		    v_job="S";    
		    
		    if(v_cost_nm_0.value==""||v_cost_cd_0.value==""){
		      	alert("������ �Է��Ͻʽÿ�.");
		      	return false;
		    }
		    
		    
	        var fr_date = vt_fr_inout_dt.Text.trim();
	        var to_date = vt_to_inout_dt.Text.trim();
	
	        if(fr_date.length!=8) {
	            alert("�������(From)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	        }
	        
	        if(to_date.length!=8) {
	            alert("�������(To)�� �Է��Ͻñ� �ٶ��ϴ�.");
	            return;
	    	}
	    
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>"
	                         + ",v_cost_cd=" + v_cost_cd_0.value
	                         + ",v_ingb_cd=" + lc_ingb_cd_0.bindcolval
	                         + ",v_fr_inout_dt =" + fr_date
	                         + ",v_to_inout_dt =" + to_date
	                         + ",v_empno =" + v_empno.value;
	                 
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_SI%>Si030I1",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	           // prompt('',param);
	       tr_post(tr1);
		}
    }    

	<%//���� %>
	function fnApply(){
		v_job = "A";
		var row=ds_default.countRow;
		
		if (ds_default.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr2, 
                "<%=dirPath%><%=HDConstant.PATH_SI%>Si030I2",
                "JSP(I:DS_DEFAULT=ds_default,I:DS_MST=ds_taxmst,I:DS_DTL=ds_taxdtl,O:DS_NBR=ds_taxnbr)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
                
                //prompt('',ds_default.text );
                //prompt('',ds_taxmst.text );
                //prompt('',ds_taxdtl.text );
        		tr_post(tr2);
        	}
		}else {
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}
	}

	<%//�Է°� üũ %>
	function ln_Chk() {

		for(i=1;i<=ds_taxmst.countrow;i++) {
		   //�ʼ��׸� üũ 
		   
		   if(ds_taxmst.RowStatus(i)==1||ds_taxmst.RowStatus(i)==2||ds_taxmst.RowStatus(i)==3) {
		    
			   // ��꼭��ȣ 
			   if(ds_taxmst.namevalue(i,"TAXNBR")!="") {
			   		alert("��꼭 ��ȣ�� ���� �մϴ�.  �ű� �Է� �Ұ� �Դϴ�.");
			   		return false;
			   }
			   
			   
			   if(ds_taxmst.namevalue(i,"COST_CD")=="") {
			   		alert("������  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   
			    //����
			   if(ds_taxmst.namevalue(i,"FDCODE")=="") {
			   		alert("������  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //����� 
			   if(ds_taxmst.namevalue(i,"COCODE")=="") {
			   		alert("����Ҹ�  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   
			    //��꼭����
			   if(ds_taxmst.namevalue(i,"TAXDAT")=="") {
				   alert("��꼭���ڸ�  �Է��� �ֽʽÿ�");
			   	   return false;	
			   }
			    
			   if(ds_taxmst.namevalue(i,"TAXDAT").trim().length!=8){
				   alert("��꼭���ڸ�  ���̸� Ȯ���� �ֽʽÿ�");
			   	   return false;
			   }
			    
			    //�ŷ�ó
			   if(ds_taxmst.namevalue(i,"VEND_CD")=="") {
			   		alert("�ŷ�ó��  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   
			    //���������
			   if(ds_taxmst.namevalue(i,"ATCODE")=="") {
			   		alert("��������  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //�μ��ڵ�
			   if(ds_taxmst.namevalue(i,"DEPTCD")=="") {
			   		alert("�μ��ڵ带  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   
			    //�����
			   if(ds_taxmst.namevalue(i,"EMPNO")=="") {
			   		alert("�����ڸ�  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   
			    //��꼭����
			   if(ds_taxmst.namevalue(i,"TAXIODIV")=="") {
			   		alert("��꼭������  �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			      
			   //�ͼӱ���
			   if(ds_taxmst.namevalue(i,"TAXDIV")=="") {
			   		alert("�ͼӱ�����  �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			   
			   //��꼭����
			   if(ds_taxmst.namevalue(i,"TAXKND")=="") {
			   		alert("��꼭������  �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			   
			    //����
			   if(ds_taxmst.namevalue(i,"REMARK")=="") {
			   		alert("���並  �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			   
			   //���ް�+�ΰ��� = �հ�  
			   if(Number(ds_taxmst.namevalue(i,"TAXTOT"))!=Number(ds_taxmst.namevalue(i,"TAXVATAMT"))+Number(ds_taxmst.namevalue(i,"TAXSUM"))) {
			   		alert("���ް�+�ΰ���=�հ谡 ���� �Ƚ��ϴ�. ");
			   		return false;
			   } 
			   
			   //����||�鼼 �ϰ�� �ΰ��� =0 		    
			   if(ds_taxmst.namevalue(i,"TAXKND")==""||ds_taxmst.namevalue(i,"TAXKND")=="2"||ds_taxmst.namevalue(i,"TAXKND")=="3") {
			   		if(ds_taxmst.namevalue(i,"TAXVATAMT")!="0") {
			   			alert("�ΰ����� 0 ���Դϴ�. ");
			   			return false;
			   		}
			   }else{
			   		if(ds_taxmst.namevalue(i,"TAXVATAMT")=="0") {
			   			alert("�ΰ����� �Է��� �ֽʽÿ�. ");
			   			return false;
			   		}
			   }
			        
			        
			  //�ͼӱ��� 
			  if(ds_default.namevalue(i,"TAX_DIV")=="") {
			  		alert("�ͼӱ����� �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
				   
			   //���౸��
		   	    if(ds_default.namevalue(i,"GUBUN")=="") {
			   		alert("���౸���� �Է��� �ֽʽÿ�. ");
			   		return false;
			   }    
			   
			   
			   //2013.01.15. JYS ���̰������� üũ 
			   //���̰������� 
			   
			   if(ds_default.namevalue(i,"COCOMYN")=="T") {
			   		if(ds_default.namevalue(i,"TAX_KND")!="3") {  //�鼼�� �ƴѰ��� �Է� �Ұ� 
			   			alert("���̰������Դϴ�. �ŷ�ó�� Ȯ���Ͻʽÿ�.");
			   			return false;
			   		}
			   }
			   	   
			   //2015.01.21
			    //�̿���
			    //���̰������� ��� �ΰ����� 0��  ( �� üũ )
			    if(ds_default.namevalue(i,"COCOMYN")=="T" ){   
			    	if(ds_taxmst.namevalue(i,"TAXVATAMT")!=0){
			    		alert("���̰��� ��ü�Դϴ�. �ΰ������� Ȯ�� �Ͻʽÿ�.");
			    		return false;
			    	}
			    }
			   
			   
			   
			   //2014.06.30 JYS �鼼���� üũ 
			    if(ds_default.namevalue(i,"COCOMYN")=="M") {
			    	//alert("TAXKND::"+ds_default.namevalue(i,"TAX_KND"));
			   		if(ds_default.namevalue(i,"TAX_KND")!="3") {  //�鼼�� �ƴѰ��� �Է� �Ұ� 
			   			alert("�鼼��ü�� ���������� [�鼼]�� �����մϴ�. �ŷ�ó�� Ȯ���Ͻʽÿ�.");
			   			return false;
			   		}
			   }
			   
			   
			   if(ds_taxmst.namevalue(i,"INGB_CD")=="1") {  //����ī��
			   	   if(ds_taxmst.namevalue(i,"CARD_NUM")=="") {
				   		alert("ī���ȣ��  �Է��� �ֽʽÿ�. ");
				   		return false;
				   }
			   }else if (ds_taxmst.namevalue(i,"INGB_CD")=="2") { //���θ����ī��
			       if(ds_taxmst.namevalue(i,"CARD_NUM")=="") {
				   		alert("ī���ȣ��  �Է��� �ֽʽÿ�. ");
				   		return false;
				   }
				    if(ds_taxmst.namevalue(i,"CARD_KND")=="") {
				   		alert("ī�������� �Է��� �ֽʽÿ�. ");
				   		return false;
				   }
			   }else if (ds_taxmst.namevalue(i,"INGB_CD")=="3") { //������ 
			   		//ī�� �����ϸ� �ȵ� .
			   		
			   		//alert("i::"+i+"::INGB_CD::"+ds_taxmst.namevalue(i,"INGB_CD")+":TAXCDNBR:"+ds_taxmst.namevalue(i,"TAXCDNBR"))+"::";
			   		
			   	 	if(ds_taxmst.namevalue(i,"TAXCDNBR")!="" && ds_taxmst.namevalue(i,"TAXCDNBR")!=" ") {
				   		alert("�Է±����� ��������  ī���ȣ�� �������� �ʽ��ϴ�.");
				   		return false;
				   }

			   }	
	
			  			   
			   //���������̿� ���� �ڻ� ��ȣ üũ 
			   if (ds_taxmst.namevalue(i,"ATCODE")=="1220100"||ds_taxmst.namevalue(i,"ATCODE")=="1220200"||
			       ds_taxmst.namevalue(i,"ATCODE")=="1220300"||ds_taxmst.namevalue(i,"ATCODE")=="1220400"||
			       ds_taxmst.namevalue(i,"ATCODE")=="1220600"||ds_taxmst.namevalue(i,"ATCODE")=="1220700"||
			       ds_taxmst.namevalue(i,"ATCODE")=="1222100"
			   ){
			   	   if(ds_taxmst.namevalue(i,"H_ASTNBR")==""){
			   	   		alert("�ڻ��ȣ�� �Է��� �ֽʽÿ�.");
			   	   		return false;
			   	   }
			   }	   
			   
			}//RowStatus
		} //for		
		
		
		//ǰ���Է� üũ 
		if ( ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXPDTNAM")==""){
			alert("ǰ���� �Է��� �ֽʽÿ�.");
			return false;
		} 
		return true;
	}

    
      <%//��-üũ %>
    function fnSelPopChk() {
         return true;
    	 if(ds_default.CountRow==0){
            alert("�ű� ��ư���� �� ���� �߰��Ͻñ� �ٶ��ϴ�.");
            return false;
        }
        return true;
    }
    
    
    <%//���� ��- ��ȸ%>
    function fnSelCostPop_0(dirPath) {
        var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCostPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_cost_nm_0.value = arrParam[1];	//NM
            v_cost_cd_0.value = arrParam[0];	//SID
        } else {
			fnSelCostCleanup_0();
        }               
    }

    function fnSelCostCleanup_0(){
        v_cost_nm_0.value = "";
        v_cost_cd_0.value  = "";
    } 
	
	<%//�Է±���, ���, �ŷ�ó, ��������, �ͼӱ���, ���౸�� üũ�� ������ �Ǹ� üũ ������ %>
	function fnCustnmDateChk(crow) {
	
	    for (var i=1; i<=ds_default.countrow;i++){
	    
	        //alert(ds_default.namevalue(i,"CHK")+"::i:::"+i+":::"+ds_default.namevalue(crow,"INGB_CD")+":::::"+ds_default.namevalue(i,"INGB_CD"));	
	    	if(ds_default.namevalue(i,"CHK")=="T"){
	    		if(ds_default.namevalue(crow,"INGB_CD")!=ds_default.namevalue(i,"INGB_CD")){
	    		    alert("�Է±����� �ٸ��ϴ�.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"INOUT_DT")!=ds_default.namevalue(i,"INOUT_DT")){
	    		    alert("���ڰ� �ٸ��ϴ�.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"VEND_CD")!=ds_default.namevalue(i,"VEND_CD")){
	    		    alert("�ŷ�ó�� �ٸ��ϴ�.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"TAX_KND")!=ds_default.namevalue(i,"TAX_KND")){
	    		    alert("���������� �ٸ��ϴ�.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"TAX_DIV")!=ds_default.namevalue(i,"TAX_DIV")){
	    		    alert("�ͼӱ�����  �ٸ��ϴ�.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    		
	    		if(ds_default.namevalue(crow,"GUBUN")!=ds_default.namevalue(i,"GUBUN")){
	    		    alert("���౸����  �ٸ��ϴ�.");
	    		    ds_default.namevalue(crow,"CHK")="F";
	    			return false;
	    		}
	    	}
	    }
	    return true;
   	}
   	
   	
   	<%//�ݾ״��� ó��   %>
	function fnAmtSum() {	
	  var i_xsupamt=0;
	  var i_vatamt=0; 
	  var i_ChkCnt=0;
	
       for(var i =1; i<=ds_default.countrow;i++){
       		if(ds_default.namevalue(i,"CHK")=="T"){
       			i_xsupamt+= Number(ds_default.namevalue(i,"XSUPAMT"));
	    		i_vatamt+=Number(ds_default.namevalue(i,"VATAMT"));
	    		i_ChkCnt+=1;
       		}
       }
       
        vt_xsupamt.text = i_xsupamt;
	    vt_vatamt.text = i_vatamt;
        vt_xsumamt.text = Number(vt_xsupamt.text)+Number(vt_vatamt.text);
        ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXSUM")=vt_xsupamt.text;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXVATAMT")=vt_vatamt.text;
        
        //üũ�� ���� ��� �Է�ȭ�� clear
        //alert("i_ChkCnt::"+i_ChkCnt);
        if(i_ChkCnt==0){
        	ds_taxmst.ClearData();
        	ds_taxdtl.ClearData();
        }
	}
		
	<%//����MST  %>
	function fnTaxmst_Add(crow) {	
	
	    ds_taxmst.clearall();	
		fnSetHeader();
		ds_taxmst.addrow();
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXNBR")=ds_default.namevalue(crow,"TAXNBR");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"COCODE")=gcocode;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"DEPTCD")=gdeptcd;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"EMPNO")=gusrid;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXIODIV")="A";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXDIV")=ds_default.namevalue(crow,"TAX_DIV");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXKND")=ds_default.namevalue(crow,"TAX_KND");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"VEND_CD")=ds_default.namevalue(crow,"VEND_CD");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXDAT")=ds_default.namevalue(crow,"INOUT_DT");
		//ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXSUM")=ds_default.namevalue(crow,"SUPAMT");
		//ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXVATAMT")=ds_default.namevalue(crow,"VATAMT");
		//ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXTOT")=ds_default.namevalue(crow,"SUMAMT");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"REMARK")=ds_default.namevalue(crow,"REMARK");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXCDNBR")=ds_default.namevalue(crow,"CARD_NUM");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"ATCODE")=ds_default.namevalue(crow,"ATCODE");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXPRTYN")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXCNT")=0;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"LASTPRT")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXTYPE")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"FSDAT")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"FSNBR")="";
		
		//���ó�� 
		var strTaxDat=ds_default.namevalue(crow,"INOUT_DT");
		strTaxDat = strTaxDat.substring(4,6);
		ds_taxmst.namevalue(ds_taxmst.rowposition,"TAXKIDIV")=fnKisuFind(strTaxDat);	
		
		ds_taxmst.namevalue(ds_taxmst.rowposition,"FDCODE")=gfdcode;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"WORKTYPE")="A";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"REPORT")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"WRDT")= "<%=DateUtil.getCurrentDate(8)%>";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"WRID")="9999998";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"UPDT")="<%=DateUtil.getCurrentDate(8)%>";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"UPID")=gusrid;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"SSDAT")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"SSNBR")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"SEQ")=0;
		ds_taxmst.namevalue(ds_taxmst.rowposition,"CONVERSATION_ID")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"SUPBUY_TYPE")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"DIRECTION")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"GUBUN")=ds_default.namevalue(crow,"GUBUN");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"AMEND_CODE")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"AMEND_REMARK")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"EXTCHK")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"REMARK2")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"REMARK3")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"S_BIZPLACE")="";
		ds_taxmst.namevalue(ds_taxmst.rowposition,"B_BIZPLACE")="";
		
		ds_taxmst.namevalue(ds_taxmst.rowposition,"VEND_NM")=ds_default.namevalue(crow,"VEND_NM");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"VEND_ID")=ds_default.namevalue(crow,"VEND_ID");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"VD_DIRECT")=ds_default.namevalue(crow,"VD_DIRECT");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"ADDR")=ds_default.namevalue(crow,"ADDR");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"BSNS_CND")=ds_default.namevalue(crow,"BSNS_CND");
		ds_taxmst.namevalue(ds_taxmst.rowposition,"BSNS_KND")=ds_default.namevalue(crow,"BSNS_KND");
        ds_taxmst.namevalue(ds_taxmst.rowposition,"H_ASTNBR")=ds_default.namevalue(crow,"H_ASTNBR");
        
        ds_taxmst.namevalue(ds_taxmst.rowposition,"INGB_CD")=ds_default.namevalue(crow,"INGB_CD");
        
        ds_taxmst.namevalue(ds_taxmst.rowposition,"COCOMYN")=ds_default.namevalue(crow,"COCOMYN");
        ds_taxmst.namevalue(ds_taxmst.rowposition,"COST_CD")=ds_default.namevalue(crow,"COST_CD");
        ds_taxmst.namevalue(ds_taxmst.rowposition,"COST_NM")=ds_default.namevalue(crow,"COST_NM");
        
		//prompt('', ds_taxmst.text);
	}
	
	<%//���Ի� %>
	function fnTaxdtl_Add(crow) {
	
	    ds_taxdtl.clearall();	
		fnSetHeader();
		ds_taxdtl.addrow();
		
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXNBR")=vt_taxnbr.text;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"MMDD")=vt_taxdat.text.substring(4,8);
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXSEQ")="001";
		//ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXPDTNAM")="";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXSTD")="";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXQTY")=0;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXPRIC")=0;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXSUM")=vt_xsupamt.text;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"TAXVATAMT")=vt_vatamt.text;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"BIGO")="";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"WRDT")="<%=DateUtil.getCurrentDate(8)%>";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"WRID")=gusrid;
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"UPDT")="";
		ds_taxdtl.namevalue(ds_taxdtl.rowposition,"UPID")="";
	}
	
	<%//DataSet Head ����� %>
	function fnSetHeader() {	
	
		if (ds_taxmst.countrow < 1){
			var s_temp1="TAXNBR:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,TAXIODIV:STRING,"
							   +"TAXDIV:STRING,TAXKND:STRING,VEND_CD:STRING,TAXDAT:STRING,TAXSUM:DECIMAL,"
							   +"TAXVATAMT:DECIMAL,TAXTOT:DECIMAL,REMARK:STRING,TAXCDNBR:STRING,ATCODE:STRING,"
							   +"TAXPRTYN:STRING,TAXCNT:DECIMAL,LASTPRT:STRING,TAXTYPE:STRING,FSDAT:STRING,"
			   				   +"FSNBR:STRING,TAXKIDIV:STRING,FDCODE:STRING,WORKTYPE:STRING,REPORT:STRING,"
							   +"WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,"
							   +"SSNBR:STRING,SEQ:DECIMAL,CONVERSATION_ID:STRING,SUPBUY_TYPE:STRING,DIRECTION:STRING,GUBUN:STRING,"
							   +"AMEND_CODE:STRING,AMEND_REMARK:STRING,EXTCHK:STRING,REMARK2:STRING,REMARK3:STRING,"
							   +"S_BIZPLACE:STRING,B_BIZPLACE:STRING,"
							   +"VEND_NM:STRING,VEND_ID:STRING,VD_DIRECT:STRING,ADDR:STRING,BSNS_CND:STRING,"
							   +"BSNS_KND:STRING,H_ASTNBR:STRING,INGB_CD:STRING,COCOMYN:STRING,COST_CD:STRING,COST_NM:STRING ";
							   
			ds_taxmst.SetDataHeader(s_temp1);
		}	
		
		
		if (ds_taxdtl.countrow < 1){
			var s_temp1="MMDD:STRING,TAXNBR:VARCHAR,TAXSEQ:VARCHAR,TAXPDTNAM:VARCHAR,TAXSTD:VARCHAR,TAXQTY:DECIMAL,"
							   +"TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:VARCHAR,"
							   +"WRDT:VARCHAR,WRID:VARCHAR,UPDT:VARCHAR,UPID:VARCHAR";
			ds_taxdtl.SetDataHeader(s_temp1);
		}		
	}
	
	
	<%//���ã�� ����� %>
	function fnKisuFind(strMM){
	   	
		if (strMM =='01' ||strMM =='02'|| strMM=='03') {
			return  "1";	//���[1]
		}else if(strMM =='04' ||strMM =='05'|| strMM=='06') {
			return "2";	//���[2]
		}else if(strMM =='07' ||strMM =='08'|| strMM=='09') {
			return "3";	//���[3]
		}else if(strMM =='10' ||strMM =='11'|| strMM=='12') {
			return "4";	//���[4]
		}
	}
	
	
	 <%//�ۼ��� ��- ��ȸ%>
    function fnSelEmpPopup(dirPath){
         //���� üũ 
        //�����ڸ� ��밡����. 
        if (gusrid!="6070001" && gusrid!="6060002" && gusrid != "3150005"  && gusrid != "2020013"){
        	alert("������ �������� �ʽ��ϴ�.");
        	return false;
        }
    
    	var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiEmpPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_empno.value = arrParam[0];	//
            v_empnmk.value = arrParam[1];	//
        } else {
			fnSelEmpCleanup();
        }               
    }
    
     function fnSelEmpCleanup(){
    	 v_empno.value = "";
         v_empnmk.value = "";
    }
     
     
     <%//���� ��- �Է�%>
     function fnSelCostPop(dirPath) {
         if(!fnSelPopChk()) return;
             
         var arrParam    = new Array();
         var arrResult   = new Array();

         arrResult = fnSiCostPop(dirPath);
     
         if (arrResult != null) {
             arrParam = arrResult.split(";");
             v_cost_nm.value = arrParam[1];	//
             v_cost_cd.value = arrParam[0];	//
         } else {
 			fnSelCostCleanup();
         }               
         
         //alert("v_cost_nm.value::"+v_cost_nm.value);
     } 
    
	
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//�հ�ݾ� �ڵ���� %>	
	<script language=JavaScript for=ds_default  event=onColumnChanged(row,colid)>
	
		if(colid=="XSUPAMT"||colid=="VATAMT"){
			ds_default.namevalue(row,"XSUMAMT") = Number(ds_default.namevalue(row,"XSUPAMT")) + Number(ds_default.namevalue(row,"VATAMT")) ;
		}
		
		
	</script>

    <%//�������� ���ý� ó��  %>	
   <script language=JavaScript for= lc_tax_knd event=OnSelChange()>

	 	//alert("bindcolval"+lc_tax_knd.bindcolval);
	 	if (lc_tax_knd.bindcolval==""){
	 		//�ͼӱ���, ���౸�� �� ���� .
	 		v_vend_nm.readOnly = false;
	 		v_vend_nm.value="";
	 		v_vend_cd.value = "";
	 		lc_tax_div.bindcolval="";
	 		lc_gubun.bindcolval="";
	 	}else{
	 	    v_vend_nm.readOnly = true;
	 	    v_vend_cd.value = "";
	 	    v_vend_nm.value="";
	 	}
	</script>
 
    <%//�Է±��� ���ý� ó��  %>
    <script language=JavaScript for= lc_ingb_cd event=OnSelChange()>
   
    	if(ds_default.RowStatus(ds_default.rowposition)=="1"||ds_default.RowStatus(ds_default.rowposition)=="2"||ds_default.RowStatus(ds_default.rowposition)=="3"){
    
	    	if( lc_ingb_cd.bindcolval=="1"){  //����ī�� ������ ���� 
	    		v_owner_nm.value="";
				v_owner.value="";
	    	}else if ( lc_ingb_cd.bindcolval=="3"){ //������ ī�� ���� ��λ��� 
        		vt_card_num.text="";
				lc_card_knd.bindcolval="";
				v_owner_nm.value="";
				v_owner.value="";
	    	}
	    }
	 </script>
	        
     <script language="javascript"  for=gr_default event=OnClick(row,colid)>
		
		if(colid=="CHK" &&  row>0){
			if (ds_default.namevalue(row,"CHK")=="T"){
				 if(!fnCustnmDateChk(row)) return ;
				 fnTaxmst_Add(row);
				 fnAmtSum();
				 fnTaxdtl_Add(row);
			}else{
				 fnAmtSum();
			}
		}	
		
		
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
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>

<script language=JavaScript for=tr1 event=OnFail()>

	alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");

</script>
 
 
 <script language="javascript" for="tr2" event="OnSuccess()">
	if(v_job=="A"){
	    vt_taxnbr.text = ds_taxnbr.namevalue(ds_taxnbr.rowposition,"TAXNBR");
		alert("���Ե����  ���������� ����Ǿ����ϴ�.");
		 fnSelect();
	}
    msgTxt.innerHTML = "<%=HDConstant.S_MSG_SAVE_DONE%>";
</script>


<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
    <script language=JavaScript  for=ds_default event="OnLoadStarted()" >
        msgTxt.innerHTML="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        msgTxt.innerHTML="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}else{
				
			}
		}
		//gr_default.ColumnProp("XSUMAMT","SumText") =ds_default.SUM(33,0,0);
	</script>
	
	<script language=javascript for="ds_tax_knd" event="OnLoadCompleted(row)">
      	ds_tax_knd.insertrow(1);
		ds_tax_knd.namevalue(1,"CDCODE") = "";
		ds_tax_knd.namevalue(1,"CDNAM") = "";
	</script>
	
	<script language=javascript for="ds_tax_div" event="OnLoadCompleted(row)">
      	ds_tax_div.insertrow(1);
		ds_tax_div.namevalue(1,"CDCODE") = "";
		ds_tax_div.namevalue(1,"CDNAM") = "";
	</script>
	
	<script language=javascript for="ds_gubun" event="OnLoadCompleted(row)">
      	ds_gubun.insertrow(1);
		ds_gubun.namevalue(1,"CDCODE") = "";
		ds_gubun.namevalue(1,"CDNAM") = "";
	</script>
	
	
<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
<%=HDConstant.COMMENT_START%>
<object id=ds_default classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��ȸ-->
    <param name="SyncLoad"  value="false">
</object>


<object id=ds_taxmst classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--���ݰ�꼭 MST-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_taxdtl classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--���ݰ�꼭 ��-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_taxnbr classid=<%=HDConstant.CT_DATASET_CLSID%>>  <!--��꼭��ȣ-->
    <param name="SyncLoad"  value="false">
</object>

<object id=ds_ingb_cd_0 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �Է±���-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_ingb_cd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �Է±���-->
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_fdcode classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--����-->
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_cocode classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--�����-->
    <param name="SyncLoad"  value="True">
</object>

<object id=ds_tax_knd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �������� -->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_tax_div classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--�ͼӱ���-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_gubun classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--���౸��-->
    <param name="SyncLoad"  value="True">
</object>

<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"     value="">
    <param name="Parameters" value="">
</object>

<object  id="tr2" classid=<%=HDConstant.CT_TR_CLSID%>>
    <param name="KeyName"    value="toinb_dataid4">
    <param name="ServerIP"     value="">
    <param name="Action"         value="">
    <param name="KeyValue"     value="">
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
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
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
                                    <td align="center" class="text" width="70">����</td>                                                                     
                                    <td bgcolor="#FFFFFF" >&nbsp;
                                        <input type="text" name='v_cost_nm_0' id="v_cost_nm_0" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop_0('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_cost_cd_0' id='v_cost_cd_0'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostPop_0('<%=dirPath%>');" alt="��ȸâ ��">
                                        <img src="<%=dirPath%>/Sales/images/trash.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCostCleanup_0();" alt="�� �����">
                                    </td>
                                    <td align="center" class="text" width="70">�Է±���</td>
                                    <td bgcolor="#FFFFFF">&nbsp;
                                       <%=HDConstant.COMMENT_START%>
			                            <object id=lc_ingb_cd_0 classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150  width=120 border="0" align=absmiddle>
			                                <param name=ComboDataID     value=ds_ingb_cd_0>
                                            <param name=BindColumn       value="detail">
                                            <param name=BindColVal         value="detail">
                                            <param name=EditExprFormat   value="%,%,%;head,detail,detail_nm">
                                            <param name=ListExprFormat   value="detail_nm^0^100">
			                            </object>
			                            <%=HDConstant.COMMENT_END%>
                                    </td>
                    			</tr>
                                <tr>
			                        <td align=left class="text"  width="70">�ⳳ����</td>
			                        <td align=left bgcolor="#ffffff" >&nbsp;&nbsp<%=HDConstant.COMMENT_START%>
			                            <object id=vt_fr_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
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
			                            <object id=vt_to_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">            
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
			                        <td align="center" class="text" width="70">�ۼ���</td>
                                    <td bgcolor='#ffffff' >&nbsp;
									    <input type="text"  name='v_empnmk' id="v_empnmk" style="width:70px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelEmpPopup('<%=dirPath%>');" readOnly="readonly">
			                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelEmpPopup('<%=dirPath%>');" alt="��ȸâ ��">
			                            <input type="text"  name='v_empno'   id='v_empno'  style="width:70px;" class='input01'  readOnly="readonly">
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
                        <td valign='top' width="845px">
                            <%=HDConstant.COMMENT_START%>
                            <object id=gr_default classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='233px' border='1'>
                                <param name="DataID"                  value="ds_default">
                                <param name="ColSizing"              value="true">
                                <param name="Editable"                value="true">
                                <param name="BorderStyle"          value="0">
                                <param name=UsingOneClick       value="1">
                                <param name="ViewSummary"      value="1">
                                <param name="Format"                  value="
                                     <C> name='����'	           ID='CHK'    	                 width=30 	align=CENTER 	 editstyle=checkbox </C>
                                     <C> name='�Է±���'	   ID='INGB_CD'    	         width=90 	align=CENTER	 edit=none  editstyle=lookup Data='ds_ingb_cd:detail:detail_nm'  sumtext='��'  sumtextalign='center'</C>
                                     <C> name='����'	   	       ID='INOUT_DT' 		         width=69 	align=CENTER	 edit=none  mask='XXXX/XX/XX'   sumtext='@cnt'    sumtextalign='center'   </C>
                                     <C> name='����'            ID='ATKORNAM'       	     width=140 	align=left 		     edit=none   sumtextalign='center'</C>
									 <C> name='���԰��ް�'  ID='XSUPAMT'    	         width=80 	align=right    	 edit=none  sumtext='@sum'  </C>
                                     <C> name='�ΰ���'  	   ID='VATAMT'                   width=60 	align=right 		 edit=none  sumtext='@sum'  </C>
                                     <C> name='��'    	       ID='XSUMAMT'   	         width=80 	align=right 	     edit=none  sumtext='{SUM(Number(XSUMAMT))}'  Value={Number(XSUMAMT)} </C>
                                     <C> name='����'   	       ID='REMARK'   	              width=120 	align=left   	     edit=none </C>
                                     <C> name='�ŷ�ó'    	   ID='VEND_NM'      	          width=120 	align=left  	     edit=none </C>
                                     <C> name='�ŷ�ó�ڵ�'   ID='VEND_CD'      	          width=120 	align=left  	     edit=none </C>
                                     <C> name='��������'      ID='TAX_KND'	              width=60 	align=left  	     edit=none  editstyle=lookup Data='ds_tax_knd:CDCODE:CDNAM'</C>
                                     <C> name='��ü����'      ID='COCOMYN'	              width=80 	align=left  	     edit=none  editstyle=Combo Data='T:���̰�����'</C>
                                     <C> name='�ͼӱ���'	   ID='TAX_DIV'    	              width=80 	align=left 	         edit=none  editstyle=lookup Data='ds_tax_div:CDCODE:CDNAM'</C>
                                     <C> name='ī���ȣ'	   ID='CARD_NUM'              width=125 	align=center 	 mask='XXXX-XXXX-XXXX-XXXX'</C>
                                     <C> name='�ڻ��ȣ'	   ID='H_ASTNBR'    	          width=80 	align=center 	 </C>
                         
                             ">
                            </object>   
                            <%=HDConstant.COMMENT_END%>
                        </td>                      
                    </tr>
                </table>
			</td>
        </tr>
        
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        
        <tr>
        	<td>
        		<table border="0" cellpadding="0" cellspacing="1" width="100%" bgcolor="#666666" align="right">
        			
        			<tr>
        				<td width="80px"  class="boardt02">
        					<input type="checkbox"  name='v_chk_cost'   id='v_chk_cost'  style="width:20px;" >����
        				</td>
        				<td bgcolor='#ffffff' colspan="7">&nbsp;
						    <input type="text" name='v_cost_nm' id="v_cost_nm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_cost_cd' id='v_cost_cd'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick=" fnSelCostPop('<%=dirPath%>');" alt="��ȸâ ��">
						</td>
        			</tr>
        			
        			<tr height="21px">	
        			    <td width="70px" class="boardt02"><font size="2" color="red">*</font>���� </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_fdcode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_fdcode>
								<param name=BindColumn       value="FDCODE">
								<param name=BindColVal         value="FDCODE">
								<param name=ListExprFormat   value="FDNAME^0^90">
								<param name=Index                  value="2">
								<param name=Enable               value="true">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02"><font size="2" color="red">*</font>����� </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_cocode classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_cocode>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
								<param name=Enable               value="true">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">��꼭���� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_taxdat   classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly     value="false">
                                <param name=SelectAll       value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						
						<td width="70px" class="boardt02">��꼭��ȣ </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_taxnbr classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text           value="">
                                <param name=Alignment   value=1>
                                <param name=Format        value="#######-####">
                                <param name=Cursor        value="iBeam">
                                <param name=Border        value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="true">
                                <param name=SelectAll      value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
							</object><%=HDConstant.COMMENT_END%> 
						</td> 			
        			</tr>
                  
        			<tr >
        				<td width="70px"  class="boardt02">�ŷ�ó</td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_vend_nm' id="v_vend_nm" style="width:235px;"   class='input01'   readOnly="readonly">
                            <input type="text"  name='v_vend_cd' id='v_vend_cd'  style="width:80px;"    class='input01'  readOnly="readonly" >
						</td>
	
						<td width="70px" class="boardt02">��Ϲ�ȣ</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=vt_vend_id classid=<%=HDConstant.CT_EMEDIT_CLSID%>  height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
							    <param name=Text           value="">
                                <param name=Alignment   value=1>
                                <param name=Format        value="000-00-00000">
                                <param name=Cursor        value="iBeam">
                                <param name=Border        value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly    value="true">
                                <param name=SelectAll      value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						
						<td width="70px" class="boardt02">��ǥ��</td>
						<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_vd_direct' id="v_vd_direct" style="width:100px;" class='input01'  readOnly="readonly">
						</td>
					</tr>	
					 
					<tr>	
						<td width="70px" class="boardt02">�ּ� </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_addr' id="v_addr" style="width:320px;" class='input01'  readOnly="readonly">
						</td>
						
						<td width="70px" class="boardt02">���� </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_bsns_cnd' id="v_bsns_cnd" style="width:100px;" class='input01' >
						</td>
						<td width="70px" class="boardt02">���� </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_bsns_knd' id="v_bsns_knd" style="width:100px;" class='input01' >
						</td>
        			</tr>
        			
        			<tr>	
        			    <td width="70px" class="boardt02">�������� </td>
        					<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_tax_knd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_tax_knd>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
								<param name=Enable               value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">���԰��ް�</td>
        				<td bgcolor='#ffffff' >&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_xsupamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text            value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="true">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						<td width="70px" class="boardt02">�ΰ��� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_vatamt   classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="true">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						
						<td width="70px" class="boardt02">�հ� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_xsumamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=100 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:100px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="true">
								<param name=Numeric	  value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%> 
						</td>
        			
        			</tr>
        			<tr>	
						<td width="70px" class="boardt02">���� </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_remark' id="v_remark" style="width:320px;" class='input01'  readOnly="readonly">
						</td>
						
						<td width="70px" class="boardt02">�������� </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_remark2' id="v_remark2" style="width:270px;" class='input02' >
						</td>
        			</tr>
        			
        			<tr>	
						<td width="70px" class="boardt02">�ͼӱ��� </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_tax_div classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_tax_div>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
								<param name=Enable               value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">���౸�� </td>
        				<td bgcolor='#ffffff'>&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_gubun classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_gubun>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
								<param name=Enable               value="false">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						
						<td width="70px" class="boardt02">ī���ȣ </td>
        				<td bgcolor='#ffffff' >&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=vt_card_num classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:120px; height:17px;">
                                <param name=Text           value="">
                                <param name=Alignment   value=1>
                                <param name=Format        value="0000-0000-0000-0000">
                                <param name=Cursor        value="iBeam">
                                <param name=Border        value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly        value="true">
                                <param name=SelectAll          value="true">
                                <param name=SelectAllOnClick        value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object><%=HDConstant.COMMENT_END%>  
						</td>
						<td width="70px" class="boardt02">�ڻ��ȣ </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_h_astnbr' id="v_h_astnbr" style="width:100px;" class='input01'   readOnly="readonly">
						</td>
        			</tr>
        		</table>
        	</td>	
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
        </tr>
        
        <tr>
	         <td valign='top' width="845px">
	          	<%=HDConstant.COMMENT_START%>
	           		<object id=gr_default2 classid=<%=HDConstant.CT_GRID_CLSID%> width='845px' height='41px' border='1'>
								<param name="dataid"			  value="ds_taxdtl">
								<param name="borderstyle"   value="0">
								<param name="indwidth"        value="0">
								<param name="fillarea"		  value="true">
								<param name="colsizing"      value="true">
								<param name="editable"        value="true">
								<param name="format"			  value="  
								<C>  Name='����'			ID=MMDD                    Width=60 	    align=center   edit=none  mask='XX/XX'</C>
								<C>  Name='ǰ��'         ID=TAXPDTNAM           Width=250 	align=left  	    bgcolor = yellow</C>			
								<C>  Name='�԰�'         ID=TAXSTD          	   Width=130	    align=left  	    edit=none</C>			  					
								<C>  Name='����'		    ID=TAXQTY          	   Width=50 	    align=right        edit=none</C>
								<C>  Name='�ܰ�'         ID=TAXPRIC                 Width=110	    align=right	    edit=none</C>					
								<C>  Name='���ް���'  ID=TAXSUM                  Width=110  	align=right	    edit=none</C>					
								<C>  Name='�ΰ�����'  ID=TAXVATAMT             Width=110	align=right	    edit=none</C>					
						    	 ">
					</object>
			   <%=HDConstant.COMMENT_END%>
			  <td>			   
          </tr>						
        
    </table>
    
    <%=HDConstant.COMMENT_START%>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds_taxmst">
	             <param name=BindInfo    value="
					<C>Col=FDCODE           Ctrl=lc_fdcode         Param=BindColVal </C>
					<C>Col=COCODE           Ctrl=lc_cocode        Param=BindColVal </C>
					<C>Col=TAXDAT           Ctrl=vt_taxdat           Param=Text </C>
					<C>Col=TAXNBR           Ctrl=vt_taxnbr           Param=Text </C>
					<C>Col=VEND_NM          Ctrl=v_vend_nm      Param=Value </C>
					<C>Col=VEND_CD          Ctrl=v_vend_cd       Param=Value </C>
					<C>Col=VEND_ID            Ctrl=vt_vend_id       Param=Text </C>
					<C>Col=VD_DIRECT        Ctrl=v_vd_direct      Param=Value </C>
					<C>Col=ADDR                Ctrl=v_addr              Param=Value </C>
					<C>Col=TAXSUM           Ctrl=vt_xsupamt         Param=Text </C>
					<C>Col=TAXVATAMT        Ctrl=vt_vatamt            Param=Text </C>
					<C>Col=TAXTOT           Ctrl=vt_xsumamt         Param=Text </C>
					<C>Col=BSNS_CND         Ctrl=v_bsns_cnd    Param=Value </C>
					<C>Col=BSNS_KND         Ctrl=v_bsns_knd     Param=Value </C>
					<C>Col=TAXKND             Ctrl=lc_tax_knd        Param=BindColVal </C>
					<C>Col=REMARK            Ctrl=v_remark            Param=Value </C>
					<C>Col=TAXDIV              Ctrl=lc_tax_div          Param=BindColVal </C>
					<C>Col=GUBUN              Ctrl=lc_gubun          Param=BindColVal </C>
					<C>Col=TAXCDNBR         Ctrl=vt_card_num    Param=Text </C>
					<C>Col=H_ASTNBR         Ctrl=v_h_astnbr        Param=Value </C>
					<C>Col=COST_CD         Ctrl=v_cost_cd        Param=Value </C>
					<C>Col=COST_NM         Ctrl=v_cost_nm        Param=Value </C>
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 


	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		