<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/*=============================================================================
 - �ý��۸� 	     : �ⳳ ��� ����
 - ���α׷�ID 	 : PMS/SI060I
 - J  S  P		     : si060i.jsp
 - �� �� ��		 : Si060I
 - �� �� ��		 : ������
 - �� �� ��		 : 2013-01-29
 - �������		 : 
 - [ �������� ][������] ����
 - [2013-01-29][������] �ű�  - �����ڿ�  ������ȣ �� ��꼭��ȣ �� ��� ���� ������.
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
    var gstrAuthgr="";

	
	<%//�������ε� %> 
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		cfStyleGrid(getObjectFirst("gr_default"), "comn");  //grid ���� 
		fnInit();	
		fnAuthority();
	}
	
    <%//�ʱ��۾� %>
    function fnInit() {

	    v_job ="I";
        ds_ingb_cd_0.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=4&s_Head=SI001&s_item1=Y";
        ds_ingb_cd_0.Reset();  //�Է±��� 
        
        ds_ingb_cd.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI001&s_item1=Y";
        ds_ingb_cd.Reset();  //�Է±��� 

    
	    ds_tax_knd.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	    ds_tax_knd.Reset();  //��������[����]
	    
	    ds_tax_div.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	    ds_tax_div.Reset();   //�ͼӱ���[����]
	    
	    ds_gubun.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2200"; 
	    ds_gubun.Reset();   //���౸��
	    
        ds_inout_gb.DataId = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy001H?proType=S&dsType=2&s_Head=SI002&s_item1=Y";
        ds_inout_gb.Reset();	//�ⳳ����
        
		ds_card_knd.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1134";
	    ds_card_knd.Reset();   //ī������
	    
	    ds_non_pay.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=1011";
	    ds_non_pay.Reset();   //�̺ұ���
	    
	    
        vt_fr_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        vt_fr_inout_dt.Text = vt_fr_inout_dt.Text .substring(0,6)+"01";
        vt_to_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        
        vt_inout_dt.Text = "<%=DateUtil.getCurrentDate(8)%>";
        
        v_chk_cost.checked = true;
        v_chk_ingb.checked = true;

        //�ӽ�
        //vt_fr_inout_dt.Text = "20121201";
       // vt_to_inout_dt.Text = "20121231";
        
        v_empnmk.value=gusrnm;
        v_empno.value=gusrid;
        
        return;
            
		//�����ͼ� ��� �ʱ�ȭ = �� ��ȸ
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_SI%>Si060I1",
            "JSP(O:DS_DEFAULT=ds_default)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
             tr_post(tr1);      
             
    }
    
    
 <%   
 /******************************************************************************
 ����
******************************************************************************/
%>
	function fnAuthority(){
		gcds_empno_chk.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_s1?v_str1=&v_str2="+gusrid+"&v_str3=si060i&v_str4=Y";
		gcds_empno_chk.Reset();
		
		if(gcds_empno_chk.countrow>0){
			gstrAuthgr=gcds_empno_chk.namevalue(gcds_empno_chk.rowposition,"AUTHGR");
		}else{
			gstrAuthgr="";
		}
		//alert("gstrAuthgr::::"+gstrAuthgr);
	}
	    
    
    
    <%//���� ��ȸ  %>
    function fnSelect() {
		if (ds_default.IsUpdated ) {
			alert("�������� ���� �ֽ��ϴ�.");
		} else {
		    v_job="S";
		    
	        var fr_date = vt_fr_inout_dt.Text.trim();
	        var to_date = vt_to_inout_dt.Text.trim();
	        
	         if(v_cost_cd_0.value==""){
	       		alert("������ �ʼ��׸��Դϴ�.");
	       		return false;
	        }
	
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
	                         + ",v_empno =" + v_empno.value
	                         + ",v_inout_gb =1" ;  // 1:��� 
	                        
	                 
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_SI%>Si060I1",
	            "JSP(O:DS_DEFAULT=ds_default)",
	            param);
	            //prompt('',param);
	        tr_post(tr1);
		}
    }    

	<%//���� %>
	function fnApply(){
	
	    //���ǰ� üũ�Ͽ� NULL�̸� ���� �ȵǰ� ��. 
	
		v_job = "A";
		var row=ds_default.countRow;
		
		if (ds_default.IsUpdated) {
			if(ln_Chk()){
			  ln_TRSetting(tr1, 
                "<%=dirPath%><%=HDConstant.PATH_SI%>Si060I1",
                "JSP(I:DS_DEFAULT=ds_default)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
               // prompt('',ds_default.text );
                + ",v_userid =" + gusrid;
            
        		tr_post(tr1);
        	}
		}else {
     		alert("������Ʈ�� ���� �����ϴ�.");
	 	}
	}
	<%//�Է°� üũ %>
	function ln_Chk() {
	
	   //return true;
	   //alert("gusrid:::"+gusrid+"::::");
	   
	   if(gusrid==""){
	   	alert("�ٽ� �α��� ���ּ���");
	   	return false;
	   }
	
	   //�ۼ��� üũ : ������ ���θ� ������. 

		for(i=1;i<=ds_default.countrow;i++) {
		   //�ʼ��׸� üũ 
		   
		   if(ds_default.RowStatus(i)==1||ds_default.RowStatus(i)==2||ds_default.RowStatus(i)==3) { //insert delete update
		   
		       /*
		       alert("RowStatus::"+ds_default.RowStatus(i));
		       alert("SUPAMT OrgNameValue::"+ds_default.OrgNameValue(i, "SUPAMT")+"::::NameValue:::"+ds_default.NameValue(i,"SUPAMT"));
		       alert(" VATAMT OrgNameValue::"+ds_default.OrgNameValue(i, "VATAMT")+"::::NameValue:::"+ds_default.NameValue(i,"VATAMT"));
		       alert("SUMAMT OrgNameValue::"+ds_default.OrgNameValue(i, "SUMAMT")+"::::NameValue:::"+ds_default.NameValue(i,"SUMAMT"));
		       alert("XSUPAMTOrgNameValue::"+ds_default.OrgNameValue(i, "XSUPAMT")+"::::NameValue:::"+ds_default.NameValue(i,"XSUPAMT"));
		       */
		                 
		                 
		       /*������ ��� ���� 
		                  
		       if(ds_default.RowStatus(i)==2 ||ds_default.RowStatus(i)==3){ //����  ������ �ۼ��ڿ� ��
		           
		           //alert("EMPNO::"+ds_default.namevalue(i,"I_EMPNO")+"::gusrid::"+gusrid);
		       		if(ds_default.namevalue(i,"I_EMPNO")!=gusrid){
		       			alert("���� �� ���� ������ �������� �ʽ��ϴ�.");
		       			alert("EMPNO::"+ds_default.namevalue(i,"I_EMPNO")+"::id::"+gusrid);
		       			return false;
		       		}
		       }
		       
		       //��꼭 �ۼ��� �����Ұ�
		       if(ds_default.namevalue(i,"TAXNBR")!=""){
		       		alert("��꼭�� �ۼ� �Ǿ����ϴ�. ������ �� �����ϴ�.");
		       		return false;
		       }
		       
		       //��ǥ �ۼ��� �����Ұ� 
		       if(ds_default.namevalue(i,"FSDAT")!=""){
		       		alert("��ǥ�� �ۼ��Ǿ����ϴ�. ������ �� �����ϴ�.");
		       		return false;
		       }
		       
		       **/
		    
			   //���� 
			   if(ds_default.namevalue(i,"COST_CD")=="") {
			   		alert("�����ڵ带 �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //������
			   if(ds_default.namevalue(i,"COST_NM")=="") {
			   		alert("��������  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //�Է±��� 
			   if(ds_default.namevalue(i,"INGB_CD")=="") {
			   		alert("�Է±�����  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //�ⳳ����
			   if(ds_default.namevalue(i,"INOUT_DT")=="") {
			   		alert("�ⳳ���ڸ�  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   			   
			   if(ds_default.namevalue(i,"INOUT_DT").length!=8) {
			   		alert("�ⳳ���ڸ�  Ȯ���� �ֽʽÿ�");
			   		return false;
			   }
			   
			    //���������ڵ�
			   if(ds_default.namevalue(i,"ATCODE")=="") {
			   		alert("�����ڵ带  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //���������
			   if(ds_default.namevalue(i,"ATKORNAM")=="") {
			   		alert("��������  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   
			   /*********************************************
			    //2012.06.20 JYS ������ �ӽ÷� �ʼ��׸񿡼� ���� 
			    //�����ڵ�
			   if(ds_default.namevalue(i,"BID_SITE_KIND")=="") {
			   		alert("�����ڵ带  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			    //������
			   if(ds_default.namevalue(i,"BID_SITE_KIND_NM")=="") {
			   		alert("��������  �Է��� �ֽʽÿ�");
			   		return false;
			   }
			   ************************************************/
			   
			   //�������� --�ʼ��׸��� �ƴ�.
			  
			   if(ds_default.namevalue(i,"SUPAMT")=="") {
			   		alert("���ް��� �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			      
			   if(ds_default.namevalue(i,"SUMAMT")=="") {
			   		alert("�հ踦 �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			    
			   //���ް�+�ΰ��� = �հ�  
			   if(Number(ds_default.namevalue(i,"SUMAMT"))!=Number(ds_default.namevalue(i,"SUPAMT"))+Number(ds_default.namevalue(i,"VATAMT"))) {
			   		alert("���ް�+�ΰ���=�հ谡 ���� �Ƚ��ϴ�. ");
			   		return false;
			   } 
			    
			   //����||�鼼 �ϰ�� �ΰ��� =0 
			   //alert("i::"+i+"::TAX_KND::"+ds_default.namevalue(i,"TAX_KND")+"::"); 
			   if(ds_default.namevalue(i,"TAX_KND")==""||ds_default.namevalue(i,"TAX_KND")=="2"||ds_default.namevalue(i,"TAX_KND")=="3") {
			   		if(ds_default.namevalue(i,"VATAMT")!="0") {
			   			alert("�ΰ����� 0 ���Դϴ�. ");
			   			return false;
			   		}
			   }else{
			   		if(ds_default.namevalue(i,"VATAMT")=="0") {
			   			alert("�ΰ����� �Է��� �ֽʽÿ�. ");
			   			return false;
			   		}
			   }
			    
			   //���������� ���µ� �ΰ����� �����ϴ� ��� �ȵ� 
			   if(ds_default.namevalue(i,"TAX_KND")==""){
			    	if(ds_default.namevalue(i,"VATAMT")!="0") {
			    		alert("�������о��� �ΰ����� �����մϴ�. ");
			   			return false;
			    	}
			    	
			    	if(ds_default.namevalue(i,"XSUPAMT")!="0") {
			    		alert("�������о��� ���԰��ް��� �����մϴ�. ");
			   			return false;
			    	}
			   }else{
			   		if(ds_default.namevalue(i,"XSUPAMT")=="0") {
			    		alert("���԰��ް��� �Է��� �ֽʽÿ�. ");
			   			return false;
			    	}
			   }
			   
			   //���԰��ް��� �����ϰ� �ΰ����� ������ ��� �����ϸ� �ȵ� .2012.10.11 jys �߰� 
			   if(ds_default.namevalue(i,"XSUPAMT")!="0"&& ds_default.namevalue(i,"VATAMT")!="0"){
			   		 if(ds_default.namevalue(i,"XSUPAMT")==ds_default.namevalue(i,"VATAMT")){
			   		     alert("���԰��ް��� �ΰ������� �����մϴ�. Ȯ�ιٶ��ϴ�.");
			   		     return false;
			   		 }
			   }
			   
			    //�ŷ�ó�� 
			   if(ds_default.namevalue(i,"VEND_NM")=="") {
			   		alert("�ŷ�ó���� �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			    
			    //����
			   if(ds_default.namevalue(i,"REMARK")=="") {
			   		alert("���並 �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			    
			    //�������������� ��� 
			       //�����ϰ�� �ΰ��� �Է� 
			   	if(ds_default.namevalue(i,"TAX_KND")!="") {
			   	
			   	  //�ŷ�ó�ڵ�
				   if(ds_default.namevalue(i,"VEND_CD")=="") {
				   		alert("�ŷ�ó�ڵ带 �Է��� �ֽʽÿ�. ");
				   		return false;
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
			   	}else{ //���������� ���� ��� �ŷ�ó�ڵ� /�ͼӱ���/���ڹ��� �ʿ����.
			   	
			   	   //�������о��� ��쵵 �ŷ�ó �ڵ� üũ ����. 
			   	   /**
			   	   //�ŷ�ó�ڵ�
				   if(ds_default.namevalue(i,"VEND_CD")!="") {
				   		alert("�ŷ�ó�ڵ带 ������ �ֽʽÿ�.");
				   		return false;
				   }
				   **/
			   		//�ͼӱ��� 
			   	   if(ds_default.namevalue(i,"TAX_DIV")!="") {
				   		alert("�ͼӱ����� ������ �ֽʽÿ�.");
				   		return false;
				   }
				   //���౸��
			   	    if(ds_default.namevalue(i,"GUBUN")!="") {
				   		alert("���౸���� ������ �ֽʽÿ�.");
				   		return false;
				   }
			   	}
				    
				//�ⳳ����
			   if(ds_default.namevalue(i,"INOUT_GB")=="") {
			   		alert("�ⳳ������  �Է��� �ֽʽÿ�. ");
			   		return false;
			   }
			   
			   if(ds_default.namevalue(i,"INOUT_GB")!="1") {
			   		alert("��ݸ� �Է� �����մϴ�. ");
			   		return false;
			   }
			   
			   
			   if(ds_default.namevalue(i,"INGB_CD")=="1") {  //����ī��
			   	   if(ds_default.namevalue(i,"CARD_NUM")=="") {
				   		alert("ī���ȣ��  �Է��� �ֽʽÿ�. ");
				   		return false;
				   }
				   
				   //���������� ���ų� �ſ�ī�常 ���� 
				   if(ds_default.namevalue(i,"TAX_KND")==""||ds_default.namevalue(i,"TAX_KND")=="8"){
				   }else{
				   		alert("����ī���� ���������� ���� �Ǵ� �ſ�ī�常 �����մϴ�.");
				   		return false;
				   }
				   
				   //���������� �ſ�ī���̸� ������ุ ���� 
				   if(ds_default.namevalue(i,"TAX_KND")=="8"){
				    	if(ds_default.namevalue(i,"GUBUN")!="2") {
				   		    alert("���������� [�ſ�ī��] �ϰ�� ���౸���� [�������]�� �����մϴ�. ");
				   			return false;
				  		}
				   }
				   
			   }else if (ds_default.namevalue(i,"INGB_CD")=="2") { //���θ����ī��
			       if(ds_default.namevalue(i,"CARD_NUM")=="") {
				   		alert("ī���ȣ��  �Է��� �ֽʽÿ�. ");
				   		return false;
				   }
				    if(ds_default.namevalue(i,"CARD_KND")=="") {
				   		alert("ī�������� �Է��� �ֽʽÿ�. ");
				   		return false;
				   }
				   if(ds_default.namevalue(i,"OWNER")=="") {
				   		alert("ī�� ������ �����  �Է��� �ֽʽÿ�. ");
				   		return false;
				   }
				    if(ds_default.namevalue(i,"OWNER_NM")=="") {
				   		alert("ī�� �����ڸ���  �Է��� �ֽʽÿ�. ");
				   		return false;
				   }
				   
				    //���������� ���ų� �ſ�ī�常 ���� 
				   if(ds_default.namevalue(i,"TAX_KND")==""||ds_default.namevalue(i,"TAX_KND")=="8"){
				   
				   }else{
				   		alert("���θ� ����ī���� ���������� ���� �Ǵ� �ſ�ī�常 �����մϴ�.");
				   		return false;
				   }
				   
				    //���������� �ſ�ī���̸� ������ุ ���� 
				   if(ds_default.namevalue(i,"TAX_KND")=="8"){
				    	if(ds_default.namevalue(i,"GUBUN")!="2") {
				   		    alert("���������� [�ſ�ī��] �ϰ�� ���౸���� [�������]�� �����մϴ�. ");
				   			return false;
				  		}
				   }
				   
				   
			   }else if (ds_default.namevalue(i,"INGB_CD")=="3" || ds_default.namevalue(i,"INGB_CD")=="4" ) { //������ �Ǵ� �̺� 
			   		//ī�� �����ϸ� �ȵ� .
			   	 	if(ds_default.namevalue(i,"CARD_NUM")!="") {
				   		alert("�Է±����� ��������  ī���ȣ�� �������� �ʽ��ϴ�.");
				   		return false;
				   }
				   
				    //���������� �ſ�ī���̸� �ȵ�  
				   if(ds_default.namevalue(i,"TAX_KND")=="8"){
				   		alert("�������� ���������� �ſ�ī��� �Ұ��Դϴ� .");
				   		return false;
				   }  
			   }	
			   
			   //alert("i:::"+i+":NONPAY:"+ds_default.namevalue(i,"NONPAY"));
			   if(ds_default.namevalue(i,"INGB_CD")=="4"){    //�̺� 
				   if(ds_default.namevalue(i,"NONPAY")==""){
				   		alert("�Է±��� �̺��� �̺ұ����� �ʼ��׸��Դϴ�.");
				   		return false;
				   }  
			   }
			   
			   //�ܻ���Ա��� ��� �̺ұ��� �ʼ� 
			   if(ds_default.namevalue(i,"ATCODE")=="2100120"){
			   		 if(ds_default.namevalue(i,"NONPAY")==""){
				   		alert("�Է±��� �̺��� �̺ұ����� �ʼ��׸��Դϴ�.");
				   		return false;
				   }  
			   }
			   			   
			  			   
			   //���������̿� ���� �ڻ� ��ȣ üũ 
			   if (ds_default.namevalue(i,"ATCODE")=="1220100"||ds_default.namevalue(i,"ATCODE")=="1220200"||
			       ds_default.namevalue(i,"ATCODE")=="1220300"||ds_default.namevalue(i,"ATCODE")=="1220400"||
			       ds_default.namevalue(i,"ATCODE")=="1220600"||ds_default.namevalue(i,"ATCODE")=="1220700"||
			       ds_default.namevalue(i,"ATCODE")=="1222100"
			   ){
			   	   if(ds_default.namevalue(i,"H_ASTNBR")==""){
			   	   		alert("�ڻ��ȣ�� �Է��� �ֽʽÿ�.");
			   	   		return false;
			   	   }
			   }else{
			   		 if(ds_default.namevalue(i,"H_ASTNBR")!=""){
			   	   		alert("�ڻ��ȣ�� �Է��� �� �����ϴ�.");
			   	   		return false;
			   	   }
			   }	   
			   
			}//RowStatus
		} //for		
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

        arrResult = fnSiCostPop(dirPath );
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_cost_nm_0.value = arrParam[1];	//NM
            v_cost_cd_0.value = arrParam[0];	//SID
        } else {
			fnSelCostCleanup_0();
        }               
    }
    
    <%//�ۼ��� ��- ��ȸ%>
    function fnSelEmpPopup(dirPath){
    
        //���� üũ         
        if(gstrAuthgr=="A" ||gstrAuthgr=="B"){
        
        
        }else{
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
    
    
     <%//�ۼ��� ��- ��ȸ%>
    function fnSelEmpPopup02(dirPath){
    
        //���� üũ         
        if(gstrAuthgr=="A" ||gstrAuthgr=="B"){
        
        
        }else{
        	alert("������ �������� �ʽ��ϴ�.");
        	return false;
        }
        
    	var arrParam  = new Array();
        var arrResult   = new Array();

        arrResult = fnSiEmpPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_empno02.value = arrParam[0];	//
            v_empnmk02.value = arrParam[1];	//
        } else {
			fnSelEmpCleanup02();
        }               
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

	<%//�����ڵ�%>
    function fnSelAccPopup(dirPath) {
        if(!fnSelPopChk()) return;
          
        var arrParam    = new Array();
        var arrResult   = new Array();
        
        arrResult = fnSiAccPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_atkornam.value = arrParam[1]; //NM
            v_atcode.value = arrParam[0];	//cd
            
	   		if(lc_ingb_cd.bindcolval =="3"){ //������
	   			if(v_atcode.value=="2100110"){ //�ܻ���Ա�
	   				lc_non_pay.Enable=true;
	   			}else{
	   				lc_non_pay.Enable=false;
	   				lc_non_pay.bindcolval ="";
	   			}
	   		}else if(lc_ingb_cd.bindcolval =="4"){ //�̺�
	   		    lc_non_pay.Enable=true;
	   		}else{ //�̺ҿ�...
	   			lc_non_pay.Enable=false;
	   			lc_non_pay.bindcolval ="";
	   		}
        } else {
			fnSelAccCleanup();
        }               
    }
    

	<%//���� ��- ��ȸ%>
    function fnSelKindPopup(dirPath) {
        if(!fnSelPopChk()) return;
        
        var arrParam    = new Array();
        var arrResult   = new Array();
        var p_costcd = v_cost_cd.value;  
        

        if(p_costcd==""){
        	alert("������ �����Ͻʽÿ�.");
        	return false;
        }

        arrResult = fnSiBidSitePop(dirPath,p_costcd);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_dcstr_sid.value = arrParam[0];
            v_bid_site_kind.value = arrParam[1];
            v_bid_site_kind_nm.value = arrParam[2];
            
        } else {
		    fnSelKindCleanup();
        }               
    }

	<%//�ŷ�ó ��- �Է�%>
    function fnSelVendPopup(dirPath) {
        if(!fnSelPopChk()) return;
        var arrParam    = new Array();
        var arrResult   = new Array();

        arrResult = fnSiCustPop(dirPath);
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_vend_cd.value  = arrParam[0];
			v_vend_nm.value = arrParam[1]; 
        } else {
			fnSelVendCleanup();
        }               
    }
    

	<%// ī�� �˾�  %>
    function fnSelCardPopup(dirPath) {
        
        if(!fnSelPopChk()) return;
        var arrParam  = new Array();
        var arrResult   = new Array();      
        
        if(lc_ingb_cd.bindcolval =="1"){ //����ī�� 
        	arrResult = fnSiCardPop1(dirPath);
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            vt_card_num.text= arrParam[0];	
	            lc_card_knd.bindcolval= arrParam[1];	
	        } else {
	             fnSelCardCleanup();
	        }               
        }else if (lc_ingb_cd.bindcolval =="2"){//���θ�  ����ī�� 
        	arrResult = fnSiCardPop2(dirPath);
	        if (arrResult != null) {
	            arrParam = arrResult.split(";");
	            vt_card_num.text= arrParam[0];	
	            lc_card_knd.bindcolval= arrParam[2];	
	            v_owner.value= arrParam[4];	
	            v_owner_nm.value= arrParam[5];	
	        } else {
	             fnSelCardCleanup();
	        }               
        }else if (lc_ingb_cd.bindcolval =="3"){//������ 
        	alert("�������� ī�� ������ �� �����ϴ�.");
        }          
    }
    
    <%//�ڻ��ȣ%>
    function fnSelAstnbrPopup(dirPath) {
        if(!fnSelPopChk()) return;
        var arrParam    = new Array();
        var arrResult   = new Array();
        var p_costcd = v_cost_nm.value;  
        arrResult = fnSiAstnbrPop(dirPath,p_costcd );
        
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            v_h_astnbr.value= arrParam[0];	
            v_astnm.value= arrParam[1];	
        } else {
             fnSelAstnbrCleanup();
        }               
    }
   
    function fnSelCostCleanup_0(){
        v_cost_nm_0.value = "";
        v_cost_cd_0.value  = "";
    } 
    
    function fnSelCostCleanup(){
        v_cost_nm.value = "";
        v_cost_cd.value  = "";
    }
    
    function fnSelAccCleanup(){
        v_atkornam.value = "";
        v_atcode.value  = "";
    }
    
    function fnSelKindCleanup(){
        v_dcstr_sid.value = "";
        v_bid_site_kind.value = "";
        v_bid_site_kind_nm.value  = "";
    }
    
    function fnSelVendCleanup(){
        v_vend_cd.value = "";
        v_vend_nm.value  = "";
    }
    
    function fnSelCardCleanup(){
         vt_card_num.text= "";
         lc_card_knd.bindcolval= "";
         v_owner.value= "";
         v_owner_nm.value= "";
    }
    
    function fnSelAstnbrCleanup(){
         v_h_astnbr.value= "";
         v_astnm.value="";
    }
    
    function fnSelEmpCleanup(){
    	 v_empno.value = "";
         v_empnmk.value = "";
    }
    
    function fnSelEmpCleanup02(){
    	 v_empno02.value = "";
         v_empnmk02.value = "";
    }
    
    
    
	<%// ������ �ű� %>
	function fnAddRowDsDefault(){
		v_job="N";
		var str_cost_nm=v_cost_nm.value;
		var str_cost_cd =v_cost_cd.value;
		
		var str_ingb_cd=lc_ingb_cd.bindcolval;
		
		ds_default.addrow();	
		fnAddSetting();
		//alert("v_chk_cost.checked::"+v_chk_cost.checked);
		if(v_chk_cost.checked==true){
			v_cost_nm.value = str_cost_nm;
			v_cost_cd.value = str_cost_cd;
		}
		
		if(v_chk_ingb.checked==true){
			lc_ingb_cd.bindcolval = str_ingb_cd;
		}
		
	}
	
	<%//�ű� �߰��� ���� %>
	function fnAddSetting(){
		lc_inout_gb.bindcolval ="1";
		vt_inout_dt.text = "<%=DateUtil.getCurrentDate(8)%>";
        
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

	<%// �׸��� ���� ��� %>
	function fnCancel() {
        ds_default.undoall();
		window.status="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}
</script>

<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<%//�հ�ݾ� �ڵ���� %>	
	<script language=JavaScript for=ds_default  event=onColumnChanged(row,colid)>
	
		if(colid=="SUPAMT"||colid=="VATAMT"){
			ds_default.namevalue(row,"SUMAMT") = ds_default.namevalue(row,"SUPAMT") + ds_default.namevalue(row,"VATAMT") ;
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
	    	
	    	if(lc_ingb_cd.bindcolval =="4" ){ //�̺� 
	   			lc_non_pay.Enable=true;
	   		}else if(lc_ingb_cd.bindcolval =="3"){ //������
	   			if(v_atcode.value=="2100110"){ //�ܻ���Ա�
	   				lc_non_pay.Enable=true;
	   			}else{
	   				lc_non_pay.Enable=false;
	   				lc_non_pay.bindcolval ="";
	   			}
	   		}else{ //�̺ҿ�...
	   			lc_non_pay.Enable=false;
	   			lc_non_pay.bindcolval ="";;
	   		}
	    }
	 </script>
	    
	 <%//���ް� �Է½� �ΰ��� �ڵ� ����  %>   
     <script language=JavaScript for=vt_supamt  event=onKillFocus()>
     
     	if(lc_tax_knd.bindcolval=="1"||lc_tax_knd.bindcolval=="4"||lc_tax_knd.bindcolval=="7"||lc_tax_knd.bindcolval=="8"){
     		if(vt_supamt.text!=0){
     			//vt_vatamt.text = vt_supamt.text*0.1;
     			//vt_sumamt.text = Number(vt_supamt.text)+Number(vt_vatamt.text);
     		}
     	}
     	
     	//����������� ���ް��� ���԰��ް��� Ʋ�� ��� msg�� �˷���. 
     	//���԰��ް��� 0 �Ǵ� ������ ��츸 ���ް� �ݾ� ������. 
     	if(vt_xsupamt.text ==0 ||vt_xsupamt.text ==""){
     		vt_xsupamt.text = Number(vt_supamt.text);
     	}
     	     
     </script>
     
      <%//���ް� �Է½� �ΰ��� �ڵ� ����  %>   
     <script language=JavaScript for=vt_vatamt  event=onKillFocus()>
     
     	if(lc_tax_knd.bindcolval=="1"||lc_tax_knd.bindcolval=="4"||lc_tax_knd.bindcolval=="7"||lc_tax_knd.bindcolval=="8"){
       		//vt_sumamt.text = Number(vt_supamt.text)+Number(vt_vatamt.text);
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
        //window.status="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
        msgTxt.innerHTML ="����Ÿ ��ȸ���Դϴ�..��ø� ��ٷ� �ֽʽÿ�.";
      
    </script>
 
	<script language=javascript for="ds_default" event="OnLoadCompleted(row)">
        //window.status="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
        msgTxt.innerHTML ="��ȸ�� �Ϸ� �Ǿ����ϴ�.";
		if(v_job=="S"){
		    if(row==0){
		        alert("<%=HDConstant.S_MSG_NO_DATA%>");
			}
		}
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
	
	<script language=javascript for="ds_card_knd" event="OnLoadCompleted(row)">
      	ds_card_knd.insertrow(1);
		ds_card_knd.namevalue(1,"CDCODE") = "";
		ds_card_knd.namevalue(1,"CDNAM") = "";
	</script>
	
	
	<script language=javascript for="ds_non_pay" event="OnLoadCompleted(row)">
      	for(var i =1 ;i<=row ;i++){
      		if(ds_non_pay.namevalue(i,"CDCODE")=="02"||ds_non_pay.namevalue(i,"CDCODE")=="03"||ds_non_pay.namevalue(i,"CDCODE")=="05"){
      		}else{
      			ds_non_pay.DeleteRow(i);
      		}
      	}
      	
      	ds_non_pay.insertrow(1);
		ds_non_pay.namevalue(1,"CDCODE") = "";
		ds_non_pay.namevalue(1,"CDNAM") = "";
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
<object id=ds_ingb_cd_0 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �Է±���-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_ingb_cd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!-- �Է±���-->
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
<object id=ds_inout_gb classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--�ⳳ����-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_card_knd classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--ī������-->
    <param name="SyncLoad"  value="True">
</object>
<object id=ds_non_pay classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--�̺�-->
    <param name="SyncLoad"  value="True">
</object>

<object id=gcds_empno_chk classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--����üũ -->
    <param name="SyncLoad"  value="True">
</object>


<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
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
							<img src="<%=dirPath%>/Sales/images/new.gif"		style="cursor:hand"  onClick="fnAddRowDsDefault()" >
							<img src="<%=dirPath%>/Sales/images/save.gif"		style="cursor:hand" onClick="fnApply();">
							<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:hand"  onclick="fnCancel()">
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
                                    <td align="center" class="text" width="70">����</td>                                                                     
                                    <td bgcolor="#FFFFFF" >&nbsp;
                                        <input type="text" name='v_cost_nm_0' id="v_cost_nm_0" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop_0('<%=dirPath%>');" readOnly="readonly">
                                        <input type="hidden"  name='v_cost_cd_0' id='v_cost_cd_0'>
                                        <img src="<%=dirPath%>/Sales/images/help.gif"  align="absmiddle" style="cursor:hand" onclick="fnSelCostPop_0('<%=dirPath%>');" alt="��ȸâ ��">
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
			                                <param name=Format      value="YYYY-MM-DD">
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
			                                <param name=Format      value="YYYY-MM-DD">
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
                                <param name="Editable"                value="false">
                                <param name="BorderStyle"          value="0">
                                <param name="ViewSummary"      value="1">
                                <param name="Format"                 value="
                                     <C> name='�Է±���'	   ID='INGB_CD'    	         width=90 	align=CENTER	 editstyle=lookup Data='ds_ingb_cd:detail:detail_nm'</C>
                                     <C> name='����'	   	       ID='INOUT_DT' 		         width=69 	align=CENTER	 mask='XXXX/XX/XX'   sumtext='��'   sumtextalign='center'</C>
                                     <C> name='����'            ID='ATKORNAM'       	     width=140 	align=left 		     sumtext='@cnt' sumtextalign='center'</C>
									 <C> name='����' 		   ID='CSTR_NM'               width=60 	    align=left       	 sumtext='��'</C>
									 <C> name='���ް�' 		   ID='SUPAMT'    	         width=80 	align=right    	 sumtext='@sum'  </C>
                                     <C> name='�ΰ���'  	   ID='VATAMT'                   width=60 	align=right 		 sumtext='@sum'  </C>
                                     <C> name='��'    	       ID='SUMAMT'   	              width=80 	align=right 	     sumtext='@sum'  </C>
                                     <C> name='���԰��ް�'   ID='XSUPAMT'   	          width=80 	align=right 	     sumtext='@sum'  </C>
                                     <C> name='����'   	       ID='REMARK'   	              width=120 	align=left   	     </C>
                                     <C> name='�ŷ�ó'    	   ID='VEND_NM'      	          width=120 	align=left  	    </C>
                                     <C> name='�ŷ�ó�ڵ�'   ID='VEND_CD'      	          width=120 	align=left  	    </C>
                                     <C> name='��������'      ID='TAX_KND'	              width=60 	align=left  	     editstyle=lookup Data='ds_tax_knd:CDCODE:CDNAM'</C>
                                     <C> name='�ͼӱ���'	   ID='TAX_DIV'    	              width=80 	align=left 	         editstyle=lookup Data='ds_tax_div:CDCODE:CDNAM'</C>
                                     <C> name='�ⳳ'	           ID='INOUT_GB'    	          width=80 	align=left 	         editstyle=lookup Data='ds_inout_gb:detail:detail_nm'</C>
                                     <C> name='������'	       ID='OWNER_NM'              width=60 	align=center 	 </C>
                                     <C> name='ī���ȣ'	   ID='CARD_NUM'              width=125 	align=center 	 mask='XXXX-XXXX-XXXX-XXXX'</C>
                                     <C> name='�ڻ��ȣ'	   ID='H_ASTNBR'    	          width=80 	align=center 	 </C>
                                     <C> name='�����ڵ�'	   ID='COST_CD'    	          width=80 	align=center 	 </C>
                                     <C> name='������'	       ID='COST_NM'    	          width=80 	align=left 	         </C>
                                     <C> name='��꼭��ȣ'  ID='TAXNBR'       	          width=80 	align=center 	 mask='XXXXXXX-XXXX'</C>
                                     <C> name='��������'      ID='FSDAT'       	          width=60 	align=center 	</C>
                                     <C> name='������ȣ'      ID='FSNBR'       	          width=60 	align=center 	</C>
                                     <C> name='�ۼ���'         ID='U_EMPNO'       	      width=60 	align=center 	</C>
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
        			<tr height="21px">
        				<td width="80px"  class="boardt02">
        					<input type="checkbox"  name='v_chk_cost'   id='v_chk_cost'  style="width:20px;" >����
        				</td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_cost_nm' id="v_cost_nm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelCostPop('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_cost_cd' id='v_cost_cd'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick=" fnSelCostPop('<%=dirPath%>');" alt="��ȸâ ��">
						</td>
	
						<td width="80px" class="boardt02">
							<input type="checkbox"  name='v_chk_ingb'   id='v_chk_ingb'  style="width:20px;" >�Է±���
						</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_ingb_cd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=110 border="0" align=absmiddle>
								<param name=ComboDataID    value=ds_ingb_cd>
								<param name=BindColumn      value="detail">
								<param name=BindColVal        value="detail">
								<param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						
						<td width="70px" class="boardt02">�ⳳ����</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
                            <object id=vt_inout_dt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=80 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:79px; height:17px;">
                                <param name=Text        value="">
                                <param name=Alignment   value=1>
                                <param name=Format      value="YYYY-MM-DD">
                                <param name=Cursor      value="iBeam">
                                <param name=Border      value="false">      
                                <param name=InheritColor      value="true">                                                                                                                                                                                                             
                                <param name=ReadOnly     value="false">
                                <param name=SelectAll      value="true">
                                <param name=SelectAllOnClick    value="true">
                                <param name=SelectAllOnClickAny   value=false>
                            </object><%=HDConstant.COMMENT_END%>  
						</td>
					</tr>	
					<tr>	
						<td width="70px" class="boardt02">�������� </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_atkornam' id="v_atkornam" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelAccPopup('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_atcode' id='v_atcode'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelAccPopup('<%=dirPath%>');" alt="��ȸâ ��">
						</td>
						
						<td width="70px" class="boardt02">���� </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_bid_site_kind_nm' id="v_bid_site_kind_nm" style="width:250px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelKindPopup('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_bid_site_kind' id='v_bid_site_kind'>
                            <input type="hidden"  name='v_dcstr_sid' id='v_dcstr_sid'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelKindPopup('<%=dirPath%>');" alt="��ȸâ ��">
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
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">�ͼӱ��� </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_tax_div classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_tax_div>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">���౸�� </td>
        				<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_gubun classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_gubun>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						
						<td width="70px" class="boardt02">�ⳳ���� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_inout_gb classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_inout_gb>
								<param name=BindColumn       value="detail">
								<param name=BindColVal         value="detail">
								<param name=EditExprFormat   value="%,%,%;head,detail,detail_nm">
								<param name=ListExprFormat   value="detail_nm^0^100">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
        			</tr>
        				<tr>	
						<td width="70px" class="boardt02">���ް� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_supamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text            value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						<td width="70px" class="boardt02">�ΰ��� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_vatamt   classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	   value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%>  
						</td>
						
						<td width="70px" class="boardt02">�հ� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_sumamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	  value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%> 
						</td>
						<td width="70px" class="boardt02">���԰��ް� </td>
        				<td bgcolor='#ffffff' >&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
						    <object id=vt_xsupamt classid=<%=HDConstant.CT_EMEDIT_CLSID%> height=17 width=120 align=center class="textbox" style= "position:relative;left:0px;top:0px;width:105px; height:17px;">
								<param name=Text           value="">
								<param name=Alignment   value=2>
								<param name=Format        value="">
								<param name=Cursor        value="iBeam">
								<param name=Border        value="false">      
								<param name=InheritColor      value="true">                                                                                                                                                                                                             
								<param name=ReadOnly    value="false">
								<param name=Numeric	  value="true">
								<param name=IsComma     value=true>
							</object><%=HDConstant.COMMENT_END%> 
						</td>
        			</tr>
        			<tr>	
						<td width="70px" class="boardt02">�ŷ�ó </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_vend_nm' id="v_vend_nm" style="width:300px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelVendPopup('<%=dirPath%>');" readOnly="readonly">
                            <input type="hidden"  name='v_vend_cd' id='v_vend_cd'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelVendPopup('<%=dirPath%>');" alt="��ȸâ ��">
						</td>
						
						<td width="70px" class="boardt02">���� </td>
        				<td bgcolor='#ffffff' colspan="3">&nbsp;
						    <input type="text" name='v_remark' id="v_remark" style="width:250px;" class='input02' >
						</td>
        			</tr>
        			<tr>	
        			   <td width="70px" class="boardt02">ī���ȣ </td>
        				<td bgcolor='#ffffff'  colspan =3 >&nbsp;
                            <%=HDConstant.COMMENT_START%>
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
                            </object><%=HDConstant.COMMENT_END%>  &nbsp;
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelCardPopup('<%=dirPath%>');" alt="��ȸâ ��">				
						</td>
						
						<td width="70px" class="boardt02">ī������</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_card_knd classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_card_knd>
								<param name=Enable               value="false">
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
						<td width="70px" class="boardt02">������ </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_owner_nm' id="v_owner_nm" style="width:100px;" class='input01'  readOnly="readonly">
                            <input type="hidden"  name='v_owner' id='v_owner'>
						</td>
					</tr>
        			<tr>
        				<td width="70px" class="boardt02">�ڻ��ȣ </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_h_astnbr' id="v_h_astnbr" style="width:100px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelAstnbrPopup('<%=dirPath%>');" readOnly="readonly">
                            <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelAstnbrPopup('<%=dirPath%>');" alt="��ȸâ ��">
						</td>
        		        <td width="70px" class="boardt02">�ڻ�� </td>
        				<td bgcolor='#ffffff' >&nbsp;
						    <input type="text" name='v_astnm' id="v_astnm" style="width:130px;" class='input01'   readOnly="readonly">
						</td>
						<td width="70px" class="boardt02">�̺ұ���</td>
        				<td bgcolor='#ffffff'  colspan=3>&nbsp;&nbsp;<%=HDConstant.COMMENT_START%>
							<object id=lc_non_pay classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=110 border="0" align=absmiddle>
								<param name=ComboDataID     value=ds_non_pay>
								<param name=BindColumn       value="CDCODE">
								<param name=BindColVal         value="CDCODE">
								<param name=ListExprFormat   value="CDNAM^0^90">
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
        			</tr>
        			<tr>
        				<td width="70px" class="boardt02">������ȣ</td>
        				<td bgcolor='#ffffff' colspan=3 >&nbsp;
						    <%=HDConstant.COMMENT_START%>
							<object  id=gcem_fdcode02 classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="width:18px;height:20px;position:relative;left:0px;top:2px">		
												<param name=Text			   value="A">
												<param name=Alignment     value=0>
												<param name=Border         value=true>
												<param name=Format          value="##">
												<param name=UpperFlag    value="1">
												<param name=PromptChar  value="_">
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor   value=false>
							 </object>
							 &nbsp;
							<object  id=gcem_fsdat02 classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="width:80px;height:20px;position:relative;left:0px;top:2px">		
												<param name=Text			   value="">
												<param name=Alignment     value=0>
												<param name=Border         value=true>
												<param name=Format          value="#####/##/##">
												<param name=PromptChar    value="_">
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
							 </object>
							 &nbsp;
							 <object  id=gcem_fsnbr02 classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="width:50px;height:20px;position:relative;left:0px;top:2px">		
												<param name=Text				qkzoqvalue="">
												<param name=Alignment       value=0>
												<param name=Border           value=true>
												<param name=Format            value="######">
												<param name=PromptChar    value="_">
												<param name=BackColor     value="#CCCCCC">
												<param name=InheritColor  value=false>
							 </object> 
							 <%=HDConstant.COMMENT_END%>
						    
						</td>
        		  
						<td width="70px" class="boardt02">�ۼ���</td>
        				<td bgcolor='#ffffff'  colspan=3>&nbsp;
     	        			<input type="text"  name='v_empnmk02' id="v_empnmk02" style="width:70px;" class='input01'  onkeydown="if(event.keyCode==113) fnSelEmpPopup02('<%=dirPath%>');" readOnly="readonly">
	                        <img src="<%=dirPath%>/Sales/images/help.gif" align="absmiddle" style="cursor:hand" onclick="fnSelEmpPopup02('<%=dirPath%>');" alt="��ȸâ ��">
	                        <input type="text"  name='v_empno02'   id='v_empno02'  style="width:70px;" class='input01'  readOnly="readonly">
        				
						</td>
        			</tr>
        			<tr>
        				<td width="70px" class="boardt02">��꼭��ȣ</td>
        				<td bgcolor='#ffffff' colspan=7>&nbsp;
        				   <%=HDConstant.COMMENT_START%> 
						   <object  id=gcem_taxnbr02  classid=<%=HDConstant.CT_EMEDIT_CLSID%>  style="position:relative;left:0px;top:1px;width:85px;height:20px;"   >
								<param name=Text            value="">
								<param name=Alignment	  value=0>
								<param name=Border	      value=True>
								<param name=ClipMode	  value=true>
								<param name=Format	      value="#######-####">
								<param name=MaxLength  value=10>
								<param name=PromptChar value="_">
								<param name=BackColor    value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=Enable		   value=true>
							</object>
							<%=HDConstant.COMMENT_END%>
						</td>
        			</tr>
        			<tr>
        			    <td bgcolor='#ffffff'  colspan = 8>
        			     <font size="2" color="blue"> �� ) ������ȣ 02 A20130101 000001,     ��꼭��ȣ A2013010001</font>
        			    </td>
        			</tr>
        		</table>
        	</td>	
        </tr>
        <tr height='10px'>
            <td>&nbsp;</td>
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
					<C>Col=COST_CD                Ctrl=v_cost_cd          Param=Value </C>
					<C>Col=COST_NM                Ctrl=v_cost_nm         Param=Value </C>
					<C>Col=INGB_CD                  Ctrl=lc_ingb_cd         Param=BindColVal </C>
					<C>Col=INOUT_DT                 Ctrl=vt_inout_dt         Param=Text </C>
					<C>Col=ATCODE                    Ctrl=v_atcode           Param=Value </C>
					<C>Col=ATKORNAM               Ctrl=v_atkornam        Param=Value </C>
					<C>Col=BID_SITE_KIND          Ctrl=v_bid_site_kind  Param=Value </C>
					<C>Col=CSTR_NM                 Ctrl=v_bid_site_kind_nm  Param=Value </C>
					<C>Col=DCSTR_SID               Ctrl=v_dcstr_sid      Param=Value </C>
					<C>Col=SUPAMT                    Ctrl=vt_supamt         Param=Text </C>
					<C>Col=VATAMT                     Ctrl=vt_vatamt           Param=Text </C>
					<C>Col=SUMAMT                    Ctrl=vt_sumamt        Param=Text </C>
					<C>Col=REMARK                    Ctrl=v_remark            Param=Value </C>
					<C>Col=TAX_KND                   Ctrl=lc_tax_knd         Param=BindColVal </C>
					<C>Col=VEND_CD                  Ctrl=v_vend_cd         Param=Value </C>
					<C>Col=VEND_NM                 Ctrl=v_vend_nm         Param=Value </C>
					<C>Col=TAX_DIV                   Ctrl=lc_tax_div            Param=BindColVal </C>
					<C>Col=GUBUN                    Ctrl=lc_gubun            Param=BindColVal </C>
					<C>Col=INOUT_GB               Ctrl=lc_inout_gb         Param=BindColVal </C>
					<C>Col=OWNER                   Ctrl=v_owner              Param=Value </C>
					<C>Col=OWNER_NM            Ctrl=v_owner_nm        Param=Value </C>
					<C>Col=CARD_KND              Ctrl=lc_card_knd        Param=BindColVal </C>
					<C>Col=CARD_NUM             Ctrl=vt_card_num        Param=Text </C>
					<C>Col=H_ASTNBR              Ctrl=v_h_astnbr          Param=Value </C>
					<C>Col=ASTNM                    Ctrl=v_astnm              Param=Value </C>
					<C>Col=XSUPAMT                Ctrl=vt_xsupamt         Param=Text </C>
					<C>Col=NONPAY                  Ctrl=lc_non_pay         Param=BindColVal </C>
					<C>Col=TAXNBR                  Ctrl=gcem_taxnbr02   Param=Text </C>
					<C>Col=FDCODE                  Ctrl=gcem_fdcode02  Param=Text </C>
					<C>Col=FSDAT                     Ctrl=gcem_fsdat02      Param=Text </C>
					<C>Col=FSNBR                     Ctrl=gcem_fsnbr02     Param=Text </C>
					<C>Col=U_EMPNO                Ctrl=v_empno02         Param=Value </C>
					<C>Col=EMP_NM                  Ctrl=v_empnmk02         Param=Value </C>
					
					
	              ">
	      </object>
	<%=HDConstant.COMMENT_END%> 
	
	
<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		