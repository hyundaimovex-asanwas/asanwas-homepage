<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<%
/******************************************************************************
 * �ý��۸� 	: ����ڵ�� : ��ο� ���� �� ��!
 * ���α׷�ID 	: CU010i
 * J  S  P		: cu010i
 * �� �� ��		: Cu010Ipm
 * �� �� ��		: �̺���
 * �� �� ��		: 2006-05-30
 * �������		: ����� 
 * [��  ��   ��  ��][������] ����
 * [2007-09-17][�ɵ���] �� �޴�Ʈ�� ����
 * [2010-04-09][�ɵ���] ������ ��������, ���ǻ纻 ���ε� �߰�..
 * [2015-09-17][�ɵ���] �ֹ�/���ǹ�ȣ�� - �־ �ڵ� ġȯ����..
 * [2015-09-23][�ɵ���] �����ȣ - ���� API �� , .JS �߰��ϰ� �Լ� ����
 *						�������� [��� ��õ��] �����θ� �����µ� �̰� �ּ�1�� �ؾ� �� �� �ѵ�..
 * [2015-09-30][�ɵ���] �����ȣ - ���� API. https ��ũ��Ʈ �ּҰ� ���� �־ �װɷ� ����
 *****************************************************************************/
%>
<%
///////////////////////////////////////////////////////////////////////////////
// Description 	:  JAVA Import ����
%>
<%@ page import="sales.common.*"%>
<%
// Description 	:  JAVA Import ��
///////////////////////////////////////////////////////////////////////////////
%>
<%	// ContextPath ���� ����.
	String dirPath = request.getContextPath(); //HDASan
%>


<%
	String basePath =  request.getServerName();

    //�븮�� ����
    HDCookieManager cookie = new HDCookieManager(request, response);
    String v_ut = cookie.getCookieValue("ut", request);
    String c_sid = cookie.getCookieValue("c_sid",request);
    String c_cd = cookie.getCookieValue("c_cd",request);
    String c_nm = cookie.getCookieValue("c_nm",request);
    String c_title = cookie.getCookieValue("c_title", request);
    String user_id = cookie.getCookieValue("user_id",request);
    String user_name = cookie.getCookieValue("user_name", request);
    String user_isfrom = cookie.getCookieValue("user_from", request);
%>

<!-- HTML ����-->
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
    <jsp:include page="/Sales/common/include/head.jsp"/>

    <!-- <script language=javascript src="<%=dirPath%>/Sales/common/js/cu010i_pm.js" charset="euc-kr"></script> -->
    

<!-- cu010i_pm.js ���� -->
    <script>
    /**
     * DataSet 
     */
    function fnCustInfoCheck() {
        if (ds1.IsUpdated || imgDs.IsUpdated) {
            for(var i=1; i<=ds1.CountRow; i++){
                //Insert / Update �۾��� ��쿡...
                if(ds1.RowStatus(i)==1 || ds1.RowStatus(i)==3){
                    var v_country_gu = ds1.NameValue(i, "COUNTRY_GU");
                    if(v_country_gu==""){
                        alert("���������� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_country_gu").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CUST_NM")==""){
                        alert("�� �ѱۼ����� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("txt_cust_nm").focus();
                        return false;
                    }
                    
                    if(v_country_gu=="10") {
                        if(ds1.NameValue(i, "REGI_NO")==""){
                            alert("���� �ֹι�ȣ�� ����Ͽ� �ֽñ� �ٶ��ϴ�.");
                            getObjectFirst("regi_no").focus();
                            return false;
                        }
                        ds1.NameValue(i, "MANAGE_NO") = ds1.NameValue(i, "REGI_NO");
                        //if(ds1.NameValue(i, "REGI_YN")==""){
                          //  alert("�������θ� �����Ͻñ� �ٶ��ϴ�.");
                            //getObjectFirst("lc_regi_yn").focus();
                            //return false;
                        //}
                        if(ds1.NameValue(i, "ZIP_CD")==""){
                            alert("�����ȣ �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("zip_cd").focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ADDRESS2")==""){
                            alert("�ּ� 2�� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("txt_address2").focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "COMPANY_NM")==""){
                            alert("������� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("txt_company_nm").focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "POSITIONS")==""){
                            alert("�������� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("txt_positions").focus();
                            return false;
                        }
                    } else {
                         if(ds1.NameValue(i, "PASS_NO")==""){
                            alert("���� ���ǹ�ȣ�� ����Ͽ� �ֽñ� �ٶ��ϴ�.");
                            getObjectFirst("pass_no").focus();
                            return false;
                        }
                        ds1.NameValue(i, "MANAGE_NO") = ds1.NameValue(i, "PASS_NO");
                        if(ds1.NameValue(i, "PASS_TYPE")==""){
                            alert("���� ������ �����Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("lc_pass_type").focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "PASS_EXPIRE_DATE")==""){
                            alert("���� ������ �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("pass_expire_date").focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ENG_ADDR1")==""){
                            alert("���� �ּ�1�� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("txt_eng_addr1").focus();
                            return false;
                        }
                         if(ds1.NameValue(i, "ENG_COMPANY_NM")==""){
                            alert("����ȸ����� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("eng_company_nm").focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ENG_POSITION")==""){
                            alert("���� �������� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("eng_position").focus();
                            return false;
                        }
                    }
                    if(ds1.NameValue(i, "BIRTHDAY")==""){
                        alert("��������� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("birthday").focus();
                        return false;
                    }
                    
                    // �������� ������ϰ�쿡�� Ű�� �˻�
                    /*if (lc_cust_gu.Index ==1) {
	                    if(ds1.NameValue(i, "HEIGHT")==""){
	                        alert("�� ������ �Է��Ͻñ� �ٶ��ϴ�.");
	                        getObjectFirst("height").focus();
	                        return false;
	                    }
                    }*/
                    if(ds1.NameValue(i, "SEX")==""){
                        alert("�� ������ �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_sex").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CUST_GU")==""){
                        alert("�������� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_cust_gu").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "SAUP_GU")==""){
                        alert("��������� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_saup_gu").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CUST_TYPE")==""){
                        alert("�������� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_cust_type").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "LAST_NM")==""){
                        alert("�� ���� ���� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("last_nm").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "FIRST_NM")==""){
                        alert("�� ���� �̸��� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("first_nm").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "ADDRESS1")==""){
                        alert("�ּ� 1�� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("txt_address1").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "TEL_NO")==""){
                        alert("������ȭ��ȣ�� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("tel_no").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "MOBILE_NO")==""){
                        alert("�ڵ�����ȣ�� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("mobile_no").focus();
                        return false;
                    }

                    if(ds1.NameValue(i, "Company_Sid")==0){
                        alert("�Ҽ�ȸ����� �˻��� ���� �Է����ֽñ� �ٶ��ϴ�.");
                        getObjectFirst("txt_company_nm").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "RealCompany_Sid")==0){
                        alert("���δ�ȸ����� �˻��� ���� �Է����ֽñ� �ٶ��ϴ�.");
                        getObjectFirst("txt_realcompany_nm").focus();
                        return false;
                    }

                    
                    if(ds1.NameValue(i, "COUNTRY_CD")==""){
                        alert("������ �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("country_cd").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "NATION_CD")==""){
                        alert("������ �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_nation").focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CLIENT_ID")==""){
                        alert("����ó�� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("client_sid").focus();
                        return false;
                    }
                }
            }
            return true;
         }
    }

    <%// ���� �����ȣ �˾�- 20150923 �η� ��� ���� ���� %>
    function fnZipCodePopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
            
        strURL = dirPath+"/Sales/help/sy002h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrResult = showModalDialog(strURL,arrParam,strPos);    
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            zip_cd.Text= arrParam[0];
            txt_address1.value = arrParam[1];
            zip_sid.value = arrParam[2];
            
        } else {
         zip_cd.Text= "";
         txt_address1.value = "";
         zip_sid.value = "";
          client_sid.value = "";
        }       
    }
    <%// ���� API �����ȣ �˾� - 20150923 %>
    function openDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.
                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ְ�, Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.

                //http://postcode.map.daum.net/guide �� �� �Ӽ� ������ �Ǿ� ����~!!
                //alert(data.zonecode); 	//�������ȣ
                //alert(data.address);	//�⺻�ּ�
                var strzonecode = data.zonecode;	//�ű� �����ȣ ( 5�ڸ� )
            	var addr1 = data.address ;
            	var firstSpaceIndex = addr1.search(" ");	// ó�� ��ĭ�� �ε���
            	var secondSpaceIndex = addr1.substring(firstSpaceIndex+1).search(" ") ;
            	//alert(t.substring(0, firstSpaceIndex) ); //0 ~ firstSpaceIndex���� ���꽺Ʈ�� 
            	//alert(t.substring(firstSpaceIndex+1) ); // firstSpaceIndex+1���� �� ������ ���꽺Ʈ��
            	//alert(secondSpaceIndex ); // "firstSpaceIndex+1���� �� ������ ���꽺Ʈ��"���� �ٽ� ù ��ĭ�� �ε���
            	//alert("�ʿ��� �� = "+ addr1.substring(0, firstSpaceIndex) +" "+ addr1.substring(firstSpaceIndex+1).substring(0, secondSpaceIndex) );
            	//alert("������ �ּ� = "+ addr1.substring(firstSpaceIndex+1).substring(secondSpaceIndex+1) );
            	
                
                document.getElementById('zip_cd').text = strzonecode;	//�����ȣ
                document.getElementById('txt_address1').value = addr1.substring(0, firstSpaceIndex) +" "+ addr1.substring(firstSpaceIndex+1).substring(0, secondSpaceIndex);	//�ּ�1 (������ �μ�� 2����)
                document.getElementById('txt_address2').value = addr1.substring(firstSpaceIndex+1).substring(secondSpaceIndex+1) ; //�ּ�2. 1���� ©�� ������ 
                document.getElementById('txt_address2').focus();				//�ּ�2 ��Ŀ��
                
                
                //��ü �ּҿ��� ���� ���� �� ()�� ���� �ִ� �ΰ������� �����ϰ��� �� ���,
                //�Ʒ��� ���� ���Խ��� ����ص� �ȴ�. ���Խ��� �������� ������ �°� �����ؼ� ��� �����ϴ�.
                //var addr = data.address.replace(/(\s|^)\(.+\)$|\S+~\S+/g, '');
                //document.getElementById('addr').value = addr;
            }
        }).open();
    }
    
    
    
	//�Ҽ�ȸ��� ��
    function fnCompanyPopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        strURL = dirPath+"/Sales/help/pm001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrParam[0] = "SY005";
        arrParam[1] = "";
        arrResult = showModalDialog(strURL,arrParam,strPos);    

//		alert(arrResult);
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            
            sCompanySid.value = arrParam[0];
            txt_company_nm.value = arrParam[1];
        
        } else {
          sCompanySid.value = "";
          txt_company_nm.value = "";
        }
        return ;    
    }

	//���δ�ȸ��� ��
    function fnCompanyPopup1(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        strURL = dirPath+"/Sales/help/pm001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrParam[0] = "SY005";
        arrParam[1] = "";
        arrResult = showModalDialog(strURL,arrParam,strPos);    

//		alert(arrResult);
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            
            sRealCompanySid.value = arrParam[0];
            txt_realcompany_nm.value = arrParam[1];
        
        } else {
          sRealCompanySid.value = "";
          txt_realcompany_nm.value = "";
        }
        return ;    
    }



    /**
     * �����ڵ� �˾�
     */
    function fnNationPopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        strURL = dirPath+"/Sales/help/sy001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrParam[0] = "SY005";
        arrParam[1] = "����";
        arrResult = showModalDialog(strURL,arrParam,strPos);    
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
              lc_nation.value = arrParam[1];
            lc_nation_nm.value = arrParam[2];
          

        } else {
          lc_nation.value = "";
          lc_nation_nm.value = "";
        }
        return ;    
    }

    /**
     * �����ڵ� �˾�
     */
    function fnCountryPopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        strURL = dirPath+"/Sales/help/sy001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrParam[0] = "SY005";
        arrParam[1] = "����";
        arrResult = showModalDialog(strURL,arrParam,strPos);    

        if (arrResult != null) {
            arrParam = arrResult.split(";");
            
            country_cd.value = arrParam[1];
             country_nm.value = arrParam[2];
        
        } else {
          country_cd.value = "";
          country_nm.value = "";
        }
        return ;    
    }

    /**
     * ȭ�� ��Ʈ�� ����
     */
    function fnScreenDisplay(v_country){
        if(v_country=="" || v_country=="10"){ //���������� ���ų� �������ΰ��
            for(var i=0; i<getObjectList("inner_person").length; i++)
                getObjectList("inner_person")[i].style.display = "inline";
            for(var i=0; i<getObjectList("outer_person").length; i++)
                getObjectList("outer_person")[i].style.display = "none";
        } else {
            for(var i=0; i<getObjectList("inner_person").length; i++)
                getObjectList("inner_person")[i].style.display = "none";
            for(var i=0; i<getObjectList("outer_person").length; i++)
                getObjectList("outer_person")[i].style.display = "inline";

			lc_pass_type.Index = 0;	//�������� 0����. �Ϲݿ������� ����
        }

		if(ds1.CountRow>0 && ds1.SysStatus(ds1.RowPosition) == 1){
	    	if (v_country=="10") {
            	// �������ϰ�� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "����";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
					lc_cust_gu.Index = 1;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            } else if (v_country=="20") {
            	// ���ֱ��ϰ�� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "����";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
					lc_cust_gu.Index = 1;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            } else if (v_country=="30") {
            	// �ùα� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
					lc_cust_gu.Index = 1;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
           
            } else if (v_country=="40") {
            	// �ܱ��� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "";
	            	lc_nation_nm.value = "";
            		
            		
					lc_cust_gu.Index = 1;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            }  else if (v_country=="50") {
            	// ������ 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "CHN";
            		country_nm.value = "�߱�";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
					lc_cust_gu.Index = 1;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            }
        }
            
            
        if(ds1.CountRow>0){
            getObjectFirst("confirm_btn").style.display = "inline";
            if(getObjectFirst("find_btn")!=undefined)
                getObjectFirst("find_btn").style.display = "inline";
            getObjectFirst("zipcode_btn").style.display = "inline";
            getObjectFirst("company_btn").style.display = "inline";			//�Ҽ�ȸ��
            getObjectFirst("realcompany_btn").style.display = "inline";		//���δ�ȸ��     
            getObjectFirst("country_btn").style.display = "inline";
            getObjectFirst("client_btn").style.display = "inline";
            getObjectFirst("nation_btn").style.display= "inline";
            if(getObjectFirst("gcip_file")!=undefined){
                getObjectFirst("gcip_file").Enable      = "True";
            }
            
            getObjectFirst("lc_country_gu").Enable  = "True";
            getObjectFirst("height").Enable         = "True";
            getObjectFirst("group_cd").Enable       = "True";
            getObjectFirst("regi_no").Enable        = "True";
            getObjectFirst("lc_regi_yn").Enable     = "false";
            getObjectFirst("pass_no").Enable        = "True";
            getObjectFirst("lc_pass_type").Enable   = "false";
            getObjectFirst("pass_expire_date").Enable= "True";
            getObjectFirst("birthday").Enable       = "True";
            getObjectFirst("lc_sex").Enable         = "True";
            getObjectFirst("lc_cust_gu").Enable     = "True";
            getObjectFirst("lc_saup_gu").Enable     = "True";
            getObjectFirst("lc_cust_type").Enable   = "True";
         
            getObjectFirst("last_nm").Enable        = "True";
            getObjectFirst("first_nm").Enable       = "True";
            getObjectFirst("zip_cd").Enable         = "True";
            getObjectFirst("tel_no").Enable         = "True";
            getObjectFirst("mobile_no").Enable      = "True";
            getObjectFirst("eng_company_nm").Enable = "True";
            getObjectFirst("eng_position").Enable   = "True";
            getObjectFirst("country_cd").Enable     = "True";
            getObjectFirst("lc_nation").Enable      = "True";
             getObjectFirst("lc_job_gu").Enable      = "True";
         
            getObjectFirst("txt_company_nm").readOnly     = false;
            getObjectFirst("txt_positions").readOnly      = false;
            getObjectFirst("txt_cust_nm").readOnly      = false;
            getObjectFirst("txt_address1").readOnly      = false;
            getObjectFirst("txt_address2").readOnly      = false;
            getObjectFirst("txt_eng_addr1").readOnly      = false;
        } else {
            getObjectFirst("confirm_btn").style.display = "none";
            if(getObjectFirst("find_btn")!=undefined)
                getObjectFirst("find_btn").style.display = "inline";
            getObjectFirst("zipcode_btn").style.display = "none";
            getObjectFirst("company_btn").style.display = "none";			//�Ҽ�ȸ��
            getObjectFirst("realcompany_btn").style.display = "none";		//���δ�ȸ��     
            getObjectFirst("country_btn").style.display = "none";
            getObjectFirst("client_btn").style.display = "none";
            getObjectFirst("nation_btn").style.display= "none";
            if(getObjectFirst("gcip_file")!=undefined) {
                getObjectFirst("gcip_file").Enable      = "False";
            }
            getObjectFirst("lc_country_gu").Enable  = "False";
         
            getObjectFirst("height").Enable         = "False";
            getObjectFirst("group_cd").Enable       = "False";
            getObjectFirst("regi_no").Enable        = "False";
            getObjectFirst("lc_regi_yn").Enable     = "False";
            getObjectFirst("pass_no").Enable        = "False";
            getObjectFirst("lc_pass_type").Enable   = "False";
            getObjectFirst("pass_expire_date").Enable= "False";
            getObjectFirst("birthday").Enable       = "False";
            getObjectFirst("lc_sex").Enable         = "False";
            getObjectFirst("lc_cust_gu").Enable     = "False";
            getObjectFirst("lc_saup_gu").Enable     = "False";
            getObjectFirst("lc_cust_type").Enable   = "False";
            getObjectFirst("last_nm").Enable        = "False";
            getObjectFirst("first_nm").Enable       = "False";
            getObjectFirst("zip_cd").Enable         = "False";
            getObjectFirst("tel_no").Enable         = "False";
            getObjectFirst("mobile_no").Enable      = "False";
            getObjectFirst("eng_company_nm").Enable = "False";
            getObjectFirst("eng_position").Enable   = "False";
            getObjectFirst("country_cd").Enable     = "False";
            getObjectFirst("lc_nation").Enable      = "False";
             getObjectFirst("lc_job_gu").Enable      = "False";
            getObjectFirst("txt_company_nm").readOnly     = true;
            getObjectFirst("txt_positions").readOnly      = true;
            getObjectFirst("txt_cust_nm").readOnly      = true;
            getObjectFirst("txt_address1").readOnly      = true;
            getObjectFirst("txt_address2").readOnly      = true;
            getObjectFirst("txt_eng_addr1").readOnly      = true;
            
        }
    }
    
    /**
     * ����ó  �˾�
     */
    function fnClientPopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        arrResult = fnClientPop(dirPath,'');
        
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            client_nm.value = arrParam[1];
            client_sid.value = arrParam[0];
        } else {
          client_nm.value = "";
          client_sid.value = "";
        }               
    }
    
    /**
     * �˻����� ����ó  �˾� 
     */
    function fnSelectClientPopup(dirPath) {
        
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        arrResult = fnClientPop(dirPath,'');
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            sClientNm.value = arrParam[1];
            sClientSid.value = arrParam[0];
        } else {
          sClientNm.value = "";
          sClientSid.value = "";
        }               
    }   

    /**
     * ȭ�ϸ� üũ
     */
    function fnDivide(str, delim){
        var strArr=str.split(delim);
        var rtn="";
        var a=strArr.length;
        
        if(a>0){rtn=strArr[a-1];}
        strArr=null;
        return rtn;
    }
    
      /*
     * ��û�� ��ȣ �˾�
     */

	function fnAcceptNoPopup(dirPath) {
	
	    var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        arrResult = fnAcceptNoPop(dirPath);
        
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            sAccpt_no.value = arrParam[1];
        } else {
          sAccpt_no.value = "";
        }          
	}

    </script>
<!-- cu010i_pm.js �� -->    
<%
/****************************************************************************
				����� ��ũ��Ʈ
******************************************************************************/
%>		
	<script language="javascript">
	    var v_job = "";
	/* �������ε� */
	function fnOnLoad(tree_idx){
		fnInit_tree(tree_idx);	//Ʈ���ʱ�ȭ ȣ��
		fnInit(); 
		
		lc_cust.Index = 2;
		lc_country.Index = 1;
	}
	 
	/* ������ �ʱ�ȭ : �⺻ �ڵ������� ���´�	 */
	function fnInit(){
        v_job = "H";
        cfStyleGrid(getObjectFirst("gr1"), "comn");
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010Ipm",
			"JSP(O:DEFAULT=ds1,O:CUSTALL=searchds1,O:SAUP=initds8,O:NATIONALL=searchds2,O:NATION=initds1,O:AUTH=initds2,O:SEX=initds3,O:CUST=initds4,O:TRAD=initds5,O:PASS=initds6,O:CU020=initds11)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);

        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010Ipm",
			"JSP(O:CUST_TYPE=initds7,O:BUY_TYPE=initds9,O:CU019=initds10)",
            "proType=<%=HDConstant.PROCESS_TYPE_INIT%>,dsType=1");
        tr_post(tr1);
	
	}

	/* ��ȸ */
	function fnSelect() {
        v_job = "S";
        if(ds1.IsUpdated!=false && confirm("���� ���� �۾����� �����Ͱ� �ֽ��ϴ�. �����Ͻðڽ��ϱ�")==false){
            return;
		}
        
        var manage_no = sManegeNo.value;	//150917 sdh
		if(sAccpt_no.value == "" &&sCustNm.value == "" && manage_no == ""){
			alert("��û����ȣ, ���� �Ǵ� �ֹ�/���ǹ�ȣ �Ѱ����� �ݵ�� �ԷµǾ� �մϴ�.")
			return;
		}
	
        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=1"
                  + ",sClientSid="+ sClientSid.value
                  + ",sCustGu=" + lc_cust.ValueOfIndex("detail", lc_cust.Index)
                  + ",sCountryGu=" + lc_country.ValueOfIndex("detail", lc_country.Index)
                  + ",sCustNm=" + sCustNm.value
                  + ",sAcceptNo=" + sAccpt_no.value
                  + ",sManegeNo=" + manage_no.replace(/-/g, "") ;	// ������ ����
        ln_TRSetting(tr1, 
            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010Ipm",
            "JSP(O:DEFAULT=ds1)",
            param);
        tr_post(tr1);
	}


	/* �׸��� ���߰�*/
	function fnAddRow() {
		ds1.addRow();
		ds1.namevalue(ds1.rowposition,"group_cd") = sAccpt_no.value;
		
		ds1.namevalue(ds1.rowposition,"cust_nm") = sCustNm.value;
		ds1.namevalue(ds1.rowposition,"regi_no") = sManegeNo.value;
		
		 getObjectFirst("regi_no").Focus();
//        imgDs.addRow();
        lc_pass_type.Index = 0;	//0��° �� , �Ϲݿ���(2) ���� ����. �̰� 2�� = �ڵ� 30 �������
        lc_regi_yn.Index = 0;
        lc_country_gu.Index = 0;	//���߰��� �������п� ���������� �⺻ ����.
	}

	/* �׸��� ����� */
	function fnDeleteRow() {
		if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        		alert("������ �ڷ��Դϴ�. �����Ҽ� �����ϴ�");
        		
        		ds1.undo(ds1.rowposition);
        		return;
        	}
		ds1.DeleteRow(ds1.RowPosition);
//        imgDs.DeleteRow(ds1.RowPosition);
	}

	/* �׸��� ���� ���*/
	function fnCancel() {
        ds1.undoall();
//        imgDs.undoall();
		window.status="������ ������ ��ҵǾ����ϴ�.";
		return;		
	}

    /* ����(������Ʈ/�μ�Ʈ) �Լ�  */
    function fnApply() {    
        if (ds1.IsUpdated){	// || imgDs.IsUpdated) {
        	if (ds1.namevalue(ds1.rowposition,"close_yn") == "Y") {
        		alert("������ �ڷ��Դϴ�\n\n�����Ҽ�  �����ϴ�");
        		
        		ds1.undo(ds1.rowposition);
        		return;
        	}
        	
        
            if(fnCustInfoCheck()!=true) return;

//            fnOnProgressStart();

            ln_TRSetting(tr_save, 
                "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010Ipm",
                "JSP(I:REGIST=ds1,O:RESULT=ds_result)",
                "proType=<%=HDConstant.PROCESS_TYPE_APPLY%>");
            tr_post(tr_save);
            
        } else {
            alert("�� ������ ���� ������ �����ϴ�.");
        }
    }
    
    
    /* ���� 1 */
	function fnConfirm() {
    	var url = "http://com.hdasan.com/cNameCheckSYS.asp?Jumin="+ regi_no.Text +"&Name="+ txt_cust_nm.value +"&returnURL=erp.hdasan.com/services/Sales/common/include/confirm.jsp";
		top.confirm = 	window.open(url, "comfirm" ,"width=400,height=280,left=300,top=0,toolbar=yes,status=yes,menubar=no,scrollbars=no,resize=no,resizable=no");    
	  	top.confirm.opener = this;
    }
    
    /* ��û����ȣ     */
	function fnSelectAcceptNo() {
	
		if(sClientNm.value != "") {
	        var param = "proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>,dsType=2"
	                  + ",sClientSid="+ sClientSid.value
	        fnOnProgressStart();
	        ln_TRSetting(tr1, 
	            "<%=dirPath%><%=HDConstant.PATH_CU%>Cu010Ipm",
	            "JSP(O:SEARCH_DS4=searchds4)",
	            param);
	        tr_post(tr1);
	       } else {
	       		alert("�븮���� �������ּ���!");
	       		return;
	       }
	}
	
	
	/* �븮���� ��û�� ��ȣ ����	 */
	 
	 function fnAcceptApply() {
	 	if (sAccpt_no.value == "") {
	 		alert("������ ��û�� ��ȣ�� �����ϴ�!");
	 		return;
	 	}
	 	group_cd.value = sAccpt_no.value;
	 }

    /* �����ȣ�� ������ ã��  */
    function fnZipCdPopup1() {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        arrParam[0] = getObjectFirst("zip_cd").Text;
            
        strURL = "<%=dirPath%>/Sales/help/sy006h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrResult = showModalDialog(strURL,arrParam,strPos);    
    
        if (arrResult != null) {
            arrParam = arrResult.split(";");
            zip_cd.Text= arrParam[0];
            txt_address1.value = arrParam[1];
            zip_sid.value = arrParam[2];
            
        } else {
         zip_cd.Text= "";
         txt_address1.value = "";
         zip_sid.value = "";
        }       
    }


	//2010-04-09 ������ ���ε�â ------------------------------------------
	function fnUploadPop(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/bsfoto_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}

	//2010-04-09 �������� ���ε�â ------------------------------------------
	function fnUploadPop_employ(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/employ_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}

	//2010-04-09 ���ǻ纻 ���ε�â ------------------------------------------
	function fnUploadPop_pass(){
	  sw = screen.width;  // to center: use desired width
	  sh = screen.height;  // to center: use desired height
	  cx = (sw-710) * 0.5  // to center: (.5*sw) - (w*.5)
	  cy = (sh-375) * 0.5  // to center: (.5*sh) - (h*.5)
		window.open("http://203.242.32.42/pass_frm.asp","fotoUp","width=710,height=375,top="+cy+",left="+cx+",titlebar=1");
	}




	</script>
	
<%
/*=============================================================================
			Gauce Components Event Scripts
=============================================================================*/
%>
	<script language="javascript" for="gcip_file" event=OnClick()>
	    if (fn_trim(gcip_file.value)!="") {
	    	txt_file.value = gcip_file.value;
	    	photo.src = gcip_file.value;
	    }
	</script>
<%
/*=============================================================================
			Transaction Component's Event Message Scripts
=============================================================================*/
%>	
	<script language="javascript" for="tr1" event="OnSuccess()">
	    fnOnProgressEnd();
	    if(ds1.CountRow>0)
	        fnScreenDisplay(ds1.NameValue(ds1.RowPosition, "COUNTRY_GU"));
	    else
	        fnScreenDisplay("");
	
	    var info_cnt = tr1.SrvErrCount("INFO");
	    var info_msg = "";
	    for(var i=0; i<info_cnt; i++){
	        info_msg += tr1.SrvErrMsg("INFO", i) + "\n";
	    }
	    if(info_msg!="") 
	        alert("============= �ȳ� �޽���=============\n\n" + info_msg);
	        
	</script>
	
	<script language="javascript" for="tr1" event="OnFail()">
	    fnOnProgressEnd();
	    
	    var error_cnt = tr1.SrvErrCount("ERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr1.SrvErrMsg("ERROR", i)+"\n";
	    }
	    if(error_msg!="") 
	        alert("�����κ��� ������ ���� ���� �޽����� ����߽��ϴ�.\n\n" + error_msg);
	    else
	        alert("Error Code : " + tr1.ErrorCode + "\n" + "Error Message : " + tr1.ErrorMsg + "\n");
	
	</script>
	
	<script language="javascript" for="tr_save" event="OnSuccess()">
	    fnOnProgressEnd();
	    if(ds_result.CountRow>0){
	        for(var i=1, j=1; i<=ds1.CountRow; i++){
	            if(ds1.RowStatus(i)==1){
	                ds1.NameValue(i, "CUST_SID")=ds_result.NameValue(j, "CUST_SID");
	                j++;
	            }
	        }
	    }
	    ds1.ResetStatus();
//	    imgDs.ResetStatus();
	    
	    if(ds1.CountRow>0)
	        fnScreenDisplay(ds1.NameValue(ds1.RowPosition, "COUNTRY_GU"));
	    else
	        fnScreenDisplay("");
	
	    var info_cnt = tr_save.SrvErrCount("SrvINFO");
	    var info_msg = "";
	    for(var i=0; i<info_cnt; i++){
	        info_msg += tr_save.SrvErrMsg("SrvINFO", i) + "\n";
	    }
	    if(info_msg!="") 
	        alert("============= �ȳ� �޽���=============\n\n" + info_msg);
	        
	</script>
	
	<script language="javascript" for="tr_save" event="OnFail()">
	    fnOnProgressEnd();
	    
	    var error_cnt = tr_save.SrvErrCount("SrvERROR");
	    var error_msg = "";
	    for(var i=0; i<error_cnt; i++){
	        error_msg += tr_save.SrvErrCode("SrvERROR", i)+"\n"+tr_save.SrvErrMsg("SrvERROR", i)+"\n";
	    }
	    
	    if(error_msg!=""){ 
	        alert(error_msg);
    	}else{
	        alert("Error Code : " + tr_save.ErrorCode + "\n" + "Error Message : " + tr_save.ErrorMsg + "\n");
    	}
	</script>

<%
/*=============================================================================
			DataSet Component's Event Message Scripts
=============================================================================*/
%>
	<%
	///////////////////////////////////////////////////////////////////////////////
	// Description	:  ��ȸ�� 
	%>
	<script language=JavaScript  for=ds1 event="OnLoadError()">
	</script>
	<script language=JavaScript  for=searchds4 event="OnLoadCompleted(row)">
		sAccpt_no.value = searchds4.namevalue(searchds4.rowposition,"ACCEPT_NO");
	</script>
	
	<script language=JavaScript  for=ds1 event="OnLoadCompleted(row)">
		
	    fnOnProgressEnd();
	     
	    if (ds1.countrow == 2000) {
			alert("�����ʹ� "+ ds1.countrow + "�� �̻� ��ȸ �� �� �����ϴ�!");
		}
	    if(v_job == "H") return;
	    if( row < 1){
	        alert(row + " �˻��� ����Ÿ�� �����ϴ�."); 
	    }
	</script>
	
	<script language=JavaScript  for=ds1 event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
//	    imgDs.RowPosition = Row;
	    fnScreenDisplay(ds1.NameValue(Row, "COUNTRY_GU"));
        photo.src  = "<%=HDConstant.PIC_NEW_PATH%>"+ds1.NameValue(Row,"MANAGE_NO").substr(0,1)+"/"+ds1.NameValue(Row,"MANAGE_NO")+".JPG";
        photo2.src = "<%=HDConstant.PIC_NEW_PATH%>"+ds1.NameValue(Row,"MANAGE_NO").substr(0,1)+"/"+ds1.NameValue(Row,"MANAGE_NO")+"_����.JPG";
        photo3.src = "<%=HDConstant.PIC_NEW_PATH%>"+ds1.NameValue(Row,"MANAGE_NO").substr(0,1)+"/"+ds1.NameValue(Row,"MANAGE_NO")+"_����.JPG";

	</script>
	
	<script language=JavaScript  for=imgDs event="OnRowPosChanged(Row, Colid)">
	    if(Row<1) return;
//		alert(ds1.NameValue(Row, "MANAGE_NO").substr(1,1));
//        photo.src  = "<%=HDConstant.PIC_NEW_PATH%>"+ds1.NameValue(Row,"MANAGE_NO").substr(0,1)+"/"+ds1.NameValue(Row,"MANAGE_NO")+".JPG";
//        photo2.src = "<%=HDConstant.PIC_NEW_PATH%>"+ds1.NameValue(Row,"MANAGE_NO").substr(0,1)+"/"+ds1.NameValue(Row,"MANAGE_NO")+"_����.JPG";
//        photo3.src = "<%=HDConstant.PIC_NEW_PATH%>"+ds1.NameValue(Row,"MANAGE_NO").substr(0,1)+"/"+ds1.NameValue(Row,"MANAGE_NO")+"_����.JPG";
        
        
        
	</script>
	
	
	
	
	
	
	
	<script language="javascript"  for=gr1 event=OnClick(row,colid)>
	        if(row==0){
	            if(ds1.CountRow==0) return;
	            
	            if(colid=="GROUP_CD"){
	                for(var i=1; i<=ds1.CountRow; i++){
	                    ds1.NameValue(i, "GROUP_CD") = ds1.NameValue(1, "GROUP_CD");
	                }
	            } 
	            return;
	        }
	 </script>
	
	<script language=javascript for=ds_zip_temp event=OnLoadCompleted(row)>
		if(row==0){
			alert("��Ȯ�� �����ȣ�� �Է��Ͻñ� �ٶ��ϴ�.");
			fnZipCdPopup1();
		} else if(row>1){
			alert("�Է��� �����ȣ�� ���� �����Ͱ� �������Դϴ�.");
			fnZipCdPopup1();
		} else {
			ds1.NameValue(ds1.RowPosition, "ZIP_SID") = ds_zip_temp.NameValue(row, "ZIP_SID");
			ds1.NameValue(ds1.RowPosition, "ZIP_CD") = ds_zip_temp.NameValue(row, "ZIP_CD");
			ds1.NameValue(ds1.RowPosition, "ADDRESS1") = ds_zip_temp.NameValue(row, "ADDRESS");
		}
	</script>
	
	<script language=javascript for=ds_zip_temp event=OnLoadError()>
		alert("�����ȣ�θ� ã���� ������ �����߽��ϴ�.");
		ds1.NameValue(ds1.RowPosition, "ZIP_SID") = 0;
		ds1.NameValue(ds1.RowPosition, "ZIP_CD") = "";
		ds1.NameValue(ds1.RowPosition, "ADDRESS1") = "";
	</script>
	
	<script language=javascript for=zip_cd event=OnKillFocus()>
		//�����ȣ�ڵ� ��ȸ
		if(zip_cd.modified){
			ds_zip_temp.Dataid  = "<%=dirPath%><%=HDConstant.PATH_HELP%>Sy006H?dsType=1&proType=<%=HDConstant.PROCESS_TYPE_SEARCH%>&sKeyWord="+getObjectFirst("zip_cd").Text;
			ds_zip_temp.Reset();
		}
	</script>

<%
/*=============================================================================
			DataSet Components(DS) ����
=============================================================================*/
%>
	
	<object id=ds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=ds_result classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=imgDs classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <param name="SyncLoad"  value="False">
	</object>
	<object id=gcds_data00 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds4 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds5 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds6 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds7 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds8 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds9 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds10 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=initds11 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=searchds1 classid=<%=HDConstant.CT_DATASET_CLSID%>>
		<PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=searchds2 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	<object id=searchds3 classid=<%=HDConstant.CT_DATASET_CLSID%>>
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	
	<object id=searchds4 classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  ��û�� ��ȣ -->
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	
	<object id=ds_zip_temp classid=<%=HDConstant.CT_DATASET_CLSID%>> <!--  �����ȣ -->
	    <PARAM NAME="SyncLoad" VALUE="False">
	</object>
	
	<object  id="tr1" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	</object>
	<object  id="tr_save" classid=<%=HDConstant.CT_TR_CLSID%>>
	    <param name="ServerIP"   value="">
	    <param name="Action"     value="">
	    <param name="KeyName"    value="">
	    <param name="KeyValue"   value="">
	    <param name="Parameters" value="">
	    <param name="StatusResetType" value="2">
	</object>


</head>
<jsp:include page="/Common/sys/body_s04.jsp"  flush="true"/>
<!--------------------------------- �ڵ� �κ� ���� ------------------------------->		

<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr height="50px">
		<td>
			<table  border="0" cellpadding="0" cellspacing="0"  width="845px">
				<tr>
					<td colspan='8'>
						<table  width='345px' border="0" cellspacing="0" cellpadding="0" align="right">
							<tr>
								<td align='right'>
								<img src="<%=dirPath%>/Sales/images/refer.gif"  style="cursor:pointer" align=absmiddle onclick="fnSelect()">
								<img src="<%=dirPath%>/Sales/images/plus.gif"	style="cursor:pointer"	align=absmiddle onClick="fnAddRow()">
<!--								<img src="<%=dirPath%>/Sales/images/minus.gif" style="cursor:pointer" align=absmiddle onClick="fnDeleteRow()">-->
								<img src="<%=dirPath%>/Sales/images/save.gif"	style="cursor:pointer" align=absmiddle onClick="fnApply();">
								<img src="<%=dirPath%>/Sales/images/cancel.gif"	style="cursor:pointer"	align=absmiddle onclick="fnCancel()">
							
								</td>
							</tr>
						</table>
					</td>
				</tr>
				<tr height="10px">
					<td ></td>
				</tr>
				<tr>
					<td>
						<table border="0" cellpadding="0" cellspacing="1" bgcolor="#666666" width='845px'>
							<tr>
								<td align="center" width="100px" height="30px" class="text" >�븮��</td>
								<td align="left"  bgcolor="#ffffff" >&nbsp;
		                                                   <input type="text" name='sClientNm' id='sClientNm' value='<%=c_nm%>' size='20' readonly='readonly'  class='textbox'>
		                                                   <input type="hidden" name='sClientSid' id='sClientSid' value='<%=c_sid%>'>
		                                                   <%if(v_ut.equals("")){%>
		                                                   <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:pointer"  onclick="javascript:fnSelectClientPopup('<%=dirPath%>');" align='absmiddle'>
		                                                   <%}%>
								</td>
								<td align="center" width="100px" height="30px" class="text" >��û����ȣ</td>
								<td align="left"  bgcolor="#ffffff" >&nbsp;
		                                                   <input type="text" name='sAccpt_no' id='sAccpt_no' value='' size='20'   class='textbox'>
		                                                   <img src="<%=dirPath%>/Sales/images/help.gif" border="0" 		ALT="��û����ȣ��  �˻��մϴ�"  style="cursor:pointer"  onclick="javascript:fnAcceptNoPopup('<%=dirPath%>');" align='absmiddle'>
		                                                   <img src="<%=dirPath%>/Sales/images/n_create.gif" border="0" 	ALT="��û����ȣ����"  		style="cursor:pointer"  onclick="javascript:fnSelectAcceptNo();" align='absmiddle'>
								</td>
							</tr>
						</table>
					</td>
					
				</tr>
				<tr height="5px">
					<td></td>
				</tr>
				<tr>
					<td colspan='5'>
						<table border="0" cellspacing="1" cellpadding="0" bgcolor="#666666" width='845px'>
							<tr>
								<td align="center" width="100px" height="30px" class="text">������</td>
								<td align="center" bgcolor="#ffffff">
									
									<object id=lc_cust classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=searchds1>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
										
								</td>
							
								<td align="center" width="100px"  class="text">��������</td>
								<td align="center" bgcolor="#ffffff">
									
			                                        	<object id=lc_country classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
										<param name=ComboDataID		value=searchds2>
										<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
										<param name=ListExprFormat  value="detail_nm^0^100">
									</object>
										
								</td>
								<td align="center" width="100px" class="text">����</td>
								<td align="center" bgcolor="#ffffff"><input type="text" name="sCustNm" value="" size="15" maxlength="10" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"></td>
							
								<td align="center" width="100px" class="text">�ֹ�/���ǹ�ȣ</td>
								<td align="center" bgcolor="#ffffff"><input type="text" name="sManegeNo" value="" size="15" maxlength="20" class="textbox" onkeydown="if(event.keyCode==13) fnSelect();"></td>
							</tr>
						</table>
					</td>

				</tr>
			</table>
		</td>
	</tr>

	<tr height="5px">
		<td></td>										
	</tr>
	
	<tr>
	  <td width="845" colspan="6">
		<table border="0" cellpadding="1" cellspacing="0" width="100%" >
		  <tr>
			<td  valign="top">
			  <table border="0" cellpadding="0" cellspacing="1" width="270px" >
				<tr>
				  <td>
					
					<object  classid=<%=HDConstant.CT_GRID_CLSID%>  id=gr1  style="width=272px; height:442px" border="1">
					    <param name="DataID"            value="ds1">
					    <param name="BorderStyle"       value="0">
					    <!-- param name="Fillarea"          value="true"-->
					    <param name="ColSizing"         value="true">
					    <param name="editable"          value="false">
					    <param name=SortView  value="Right">
						<param name="Format"            value=" 
							<FC>name='�ѱۼ���'       ID='CUST_NM'            Width=70  align=Left sort=true</FC>
							<C> name='�ֹ�/���ǹ�ȣ'    ID='MANAGE_NO'          Width=100 align=Left sort=true</C>
							<C> name='��û����ȣ'    ID='GROUP_CD'          Width=120 align=Left </C>
							<C> name='����'      	ID='REGI_YN_NAME'    	Width=60  align=center show=false </C>
							<C> name='��'      	ID='CUST_GU_NAME'    	Width=50  align=center show=false</C>
							<C> name='����'         	ID='COUNTRY_CD' 	Width=50  align=center show=true</C>
							<C> name='����'       	ID='NATION_CD_NAME'     Width=40  align=center show=false</C>
							<C> name='����'       	ID='nation_cd'     	Width=40  align=center show=false</C>
							<C> name='����'  		ID='SEX_GU_NAME'        Width=40  align=center </C>
							<C> name='�븮����'    	ID='CLIENT_NM'  		Width=100 align=Left</C>
							<C> name='������'    	ID='COUNTRY_NM'  		Width=100 align=Left</C>
							<C> name='������'    	ID='NATION_CD_NM'  		Width=100 align=Left</C>
							<C> name='������'    	ID='LAST_NM'  		Width=100 align=Left</C>
							<C> name='�����̸�'    	ID='FIRST_NM'  		Width=100 align=Left</C>
							<C> name='����'    	ID='TEL_NO'  		Width=100 align=Left</C>
							<C> name='����'    	ID='MOBILE_NO'  		Width=100 align=Left</C>
						">
					</object>
															
				  </td>
				</tr>
			  </table>
			</td>
			<td width="15px"></td>
			<td valign="top">

			  <table border="0" cellpadding="0" cellspacing="0" width="560px" bgcolor="#666666">
				<tr width="560px" bgcolor="#ffffff">
				  <td width="90px" bgcolor="#ffffff" valign=top>

					<table border="0" cellpadding="0" cellspacing="1" width="103px" bgcolor="#666666">
					  <tr bgcolor="#ffffff">
						<td align=center height='25px' class='boardt02'>�� ����</td>
					  </tr>
					  <tr bgcolor="#ffffff">
						<td align=center><img id="photo" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="103px"></td>
					  </tr>
					  <tr bgcolor="#ffffff"><td height=26></td></tr>
					  <tr bgcolor="#ffffff">
						<td align=center height='25px' class='boardt02' onclick="fnUploadPop_employ()" style="cursor:pointer">[��������]</td>
					  </tr>
					  <tr bgcolor="#ffffff">
						<td align=center ><img id="photo2" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="103px"></td>
					  </tr>
					  <tr bgcolor="#ffffff"><td height=25></td></tr>
					  <tr bgcolor="#ffffff">
						<td align=center height='25' class='boardt02' onclick="fnUploadPop_pass()" style="cursor:pointer">[���ǻ纻]</td>
					  </tr>
					  <tr bgcolor="#ffffff">
						<td align=center><img id="photo3" src="<%=dirPath%>/Sales/images/00000.gif" align="center" border=0 width="100px" height="103px"></td>
					  </tr>
					</table>
				  </td>
				  <td width="5px"></td>
				  <td width="455px" valign="top" >
				  
					<table border="0" cellpadding="0" cellspacing="1" width="455px" bgcolor="#666666">
					  <tr bgcolor="#ffffff">
						<td width='100px' height='25px' class='boardt02'>��������</td>
						<td  align=absmiddle >&nbsp;&nbsp;
							
							<object id=lc_country_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=100 border="0" align=absmiddle>
								<param name=ComboDataID		value=initds1>
	                            <param name=BindColumn      value="detail">
	                            <param name=BindColVal      value="detail">
								<param name=ListExprFormat  value="detail_nm^0^100">
							</object>
								
                              <script language=JavaScript for=lc_country_gu event=OnSelChange()>
                                  if (lc_country_gu.Text != "") {
                                      ds1.NameValue(ds1.RowPosition, "country_gu_name") = lc_country_gu.Text;
                                      
                                      fnScreenDisplay(lc_country_gu.ValueOfIndex("detail", lc_country_gu.Index));
                                  }
                              </script>
						</td>
					  </tr>
					  <tr>
						<td width='100px' height='22px'  class='boardt02'>�ѱۼ���</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
							<input type=text name=txt_cust_nm id=txt_cust_nm size=30 class="textbox" OnKeyUp="cfLengthCheck(this, 30);">
						</td>
					  </tr>		
					  <tr id=inner_person style="display:inline">
						<td width='100px' height='22px'  class='boardt02'>�ֹι�ȣ</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
							
                            <object id=regi_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                            	<param name=Format      value="000000-0000000">
                                <param name=Alignment   value=1>
                                <param name=ClipMode    value=true>
                                <param name=Border      value=false>
                                <param name=MaxLength   value="13">
                                <param name=SelectAll   value=true>
                                <param name=SelectAllOnClick      value=true>
                                <param name=SelectAllOnClickAny   value=false>
							</object>
                            
                              <script language=javascript for=regi_no event="OnKillFocus()">
                                  if(getObjectFirst("regi_no").Text!="" && fnJuminNoCheck(getObjectFirst("regi_no").Text)!=true) {
                                      getObjectFirst("birthday").Text = "";
                                      getObjectFirst("regi_no").Text = "";
                                      getObjectFirst("regi_no").Focus();
                                      return;
                                  }
                                     
                                  if(getObjectFirst("regi_no").Text.length==13){
                                      var v_sex_gubn = getObjectFirst("regi_no").Text.substr(6, 1);
                                      if(v_sex_gubn=="1" || v_sex_gubn=="2")
                                          getObjectFirst("birthday").Text = "19" + getObjectFirst("regi_no").Text.substr(0, 6);
                                      else 
                                         getObjectFirst("birthday").Text = "20" + getObjectFirst("regi_no").Text.substr(0, 6);
                                      
                                      if(v_sex_gubn=="1" || v_sex_gubn=="3") ds1.NameValue(ds1.RowPosition, "SEX") = "M";
                                      else ds1.NameValue(ds1.RowPosition, "SEX") = "F";
                                  }
                              </script>
							&nbsp;&nbsp;
							<img src="<%=dirPath%>/Sales/images/confirm.gif" border="0" align=absmiddle style="cursor:pointer" id="confirm_btn" onClick="fnConfirm();">
						</td>
					  </tr>	
					  <tr id=inner_person style="display:inline">
						<td width='100px' height='22px'  class='boardt02'>��������</td>
						<td bgcolor='#ffffff' >&nbsp;&nbsp;
					    
						<object id=lc_regi_yn classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=120 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=initds2>
        					<param name=BindColumn      value="detail">
							<param name=BindColVal      value="detail">
							<param name=ListExprFormat  value="detail_nm^0^100">
							<param name=ReadOnly 		value="true">
						</object>
						
		                  <script language=JavaScript for=lc_regi_yn event=OnSelChange()>
		                      if (lc_regi_yn.Text != "")
		                          ds1.NameValue(ds1.RowPosition, "regi_yn_name") = lc_regi_yn.Text;
		                  </script>
						</td>																								
					  </tr>
                      <tr id=outer_person style="display:none">
						<td width='100px' height='22px'  class='boardt02'>���ǹ�ȣ</td>
                        <td bgcolor='#ffffff'>&nbsp;&nbsp;
						
						<object id=pass_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                          <param name=Format      value="###############">
                          <param name=Alignment   value=1>
                          <param name=ClipMode    value=true>
                          <param name=UpperFlag   value=1>
                          <param name=Border      value=false>
                          <param name=MaxLength   value="15">
                          <param name=SelectAll   value=true>
                          <param name=SelectAllOnClick      value=true>
                          <param name=SelectAllOnClickAny   value=false>
						</object>
						
                        </td>
					  </tr>
					  <tr id=outer_person style="display:none">
                      	<td width='100px' height='25px'  class='boardt02'>��������</td>
                      	<td bgcolor='#ffffff'>
                          <table border=0 cellspacing=0 cellpadding=0>
                          	<tr>
                              <td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
                              	
                                <object id=lc_pass_type classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                                	<param name=ComboDataID     value=initds6>
                                    <param name=BindColumn      value="detail">
                                    <param name=BindColVal      value="detail">
                                    <param name=ListExprFormat  value="detail_nm^0^150">
								</object>
								
                                  <script language=JavaScript for=lc_pass_type event=OnSelChange()>
                                      if (lc_pass_type.Text != "")
                                          ds1.NameValue(ds1.RowPosition, "pass_type_name") = lc_pass_type.Text;
                                  </script>
							  </td>       
							  <td bgcolor='#ffffff' height='22px' class='boardt02'>���Ǹ�����
                              </td>
                              <td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
								
                                  <object id=pass_expire_date classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>            
                                      <param name=Format      value="YYYY-MM-DD">
                                      <PARAM NAME=InputFormat value="YYYYMMDD">
                                      <param name=Alignment   value=1>
                                      <param name=ClipMode    value=true>
                                      <param name=Border      value=false>
                                      <param name=SelectAll   value=true>
                                      <param name=SelectAllOnClick      value=true>
                                      <param name=SelectAllOnClickAny   value=false>
                                  </object>
								
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr>
						<td width='100px' height='22px'  class='boardt02'>�������</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
                        
                        <object id=birthday classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='80px' align='absmiddle' class='textbox'>            
                          <param name=Format      value="YYYY-MM-DD">
                          <PARAM NAME=InputFormat value="YYYYMMDD">
                          <param name=Alignment   value=1>
                          <param name=ClipMode    value=true>
                          <param name=Border      value=false>
                          <param name=SelectAll   value=true>
                          <param name=SelectAllOnClick      value=true>
                          <param name=SelectAllOnClickAny   value=false>
						</object>
                         
						</td>																		
					  </tr>
                      <tr>
						<td width='100px' class='boardt02'>��û����ȣ</td>
                        <td  bgcolor='#ffffff'>&nbsp;&nbsp;
                          <input type="text" name='group_cd' id='group_cd' value='' class='textbox' size='15'>
                          <img src="<%=dirPath%>/Sales/images/apply.gif" border="0" ALT="��û����ȣ�� �����մϴ�"  style="cursor:pointer"  onclick="javascript:fnAcceptApply();" align='absmiddle'>
	                    </td>
	                  </tr>
					</table>
					
					<table border="0" cellpadding="0" cellspacing="1" width="455px" bgcolor="#666666">
					  <tr>
						<td width='100px' class='boardt02'>����</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
						
						<object id=lc_sex classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=initds3>
		                    <param name=BindColumn      value="detail">
		                    <param name=BindColVal      value="detail">
							<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
							<param name=ListExprFormat  value="detail_nm^0^100">
						</object>
						
                        <script language=JavaScript for=lc_sex event=OnSelChange()>
                            if (lc_sex.Text != "")
                                ds1.NameValue(ds1.RowPosition, "sex_gu_name") = lc_sex.Text;
                        </script>
						</td>		
						<td width='100px' class='boardt02'>������</td>
						<td bgcolor='#ffffff' height='23px'>&nbsp;&nbsp;
						
						<object id=lc_cust_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=initds4>
							<param name=BindColumn      value="detail">
							<param name=BindColVal      value="detail">
							<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
							<param name=ListExprFormat  value="detail_nm^0^100">
						</object>
						
                        <script language=JavaScript for=lc_cust_gu event=OnSelChange()>
                        	if (lc_cust_gu.Text != "")
                            	ds1.NameValue(ds1.RowPosition, "cust_gu_name") = lc_cust_gu.Text;
                                
                        	/*if (lc_cust_gu.Index ==1) {
                        		document.all.tttt.style.display = "inline";
                        	} else {
                        		document.all.tttt.style.display = "none";
                        	}*/
                        </script>
						</td>
					  </tr>
					  <tr>
						<td class='boardt02'>�������</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
						
                        <object id=lc_saup_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                            <param name=ComboDataID     value=initds8>
                            <param name=BindColumn      value="detail">
                            <param name=BindColVal      value="detail">
                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                            <param name=ListExprFormat  value="detail_nm^0^100">
                        </object>
                        
                        <script language=JavaScript for=lc_saup_gu event=OnSelChange()>
                            if (lc_saup_gu.Text != "")
                                ds1.NameValue(ds1.RowPosition, "saup_gu_name") = lc_saup_gu.Text;
                        </script>
						</td>		
						<td class='boardt02'>������</td>
						<td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
						
                        <object id=lc_cust_type classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
                            <param name=ComboDataID     value=initds7>
                            <param name=BindColumn      value="detail">
                            <param name=BindColVal      value="detail">
                            <param name=EditExprFormat  value="%,%,%;head,detail,detail_nm">
                            <param name=ListExprFormat  value="detail_nm^0^200">
                        </object>
                        
                        <script language=JavaScript for=lc_cust_type event=OnSelChange()>
                            if (lc_cust_type.Text != ""){
                                ds1.NameValue(ds1.RowPosition, "cust_type_name") = lc_cust_type.Text;
                            }
                        </script>
						</td>
					  </tr>
					  <tr>
						<td class='boardt02'>������</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
						
                        <object id=last_nm classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                            <param name=Format      value="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ">
                            <param name=Alignment   value=1>
                            <param name=ClipMode    value=true>
                            <param name=Border      value=false>
                            <param name=SelectAll   value=true>
                            <param name=SelectAllOnClick      value=true>
                            <param name=SelectAllOnClickAny   value=false>
                            <param name=UpperFlag   value=1>
                            
                        </object>
                        
						</td>		
						<td class='boardt02'>�����̸�
						</td>
						<td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
						
                        <object id=first_nm classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                            <param name=Format      value="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ">
                            <param name=Alignment   value=1>
                            <param name=ClipMode    value=true>
                            <param name=Border      value=false>
                            <param name=SelectAll   value=true>
                            <param name=SelectAllOnClick      value=true>
                            <param name=SelectAllOnClickAny   value=false>
                            <param name=UpperFlag   value=1>
                        </object>
                        
						</td>
					  </tr>	
					  <tr id=inner_person style="display:inline">
						<td class='boardt02'>�����ȣ</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
						
						<object id=zip_cd classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='60px' align='absmiddle' class='textbox'>			
							<param name=Alignment 	value=1>
							<param name=Format 		value="#####">
							<param name=Cursor	 	value="Hand">
							<param name=Enable      value="False">
                                              <param name=ReadOnly    value="false">
                                              <param name=Border   	value=false>
                                              <param name=SelectAll   value=true>
                                              <param name=SelectAllOnClick      value=true>
                                              <param name=SelectAllOnClickAny   value=false>
						</object>
						&nbsp;&nbsp;
						<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ȣ�� �˻��մϴ�"  style="cursor:pointer" id="zipcode_btn" onclick="openDaumPostcode();" align='absmiddle'>
							<input type='hidden' name='zip_sid' id='zip_sid' value=''>
						</td>		
						<td class='boardt02'>����</td>
						<td bgcolor='#ffffff' height='23px'>&nbsp;&nbsp;
						
						<object id=lc_job_gu classid=<%=HDConstant.CT_LUXECOMBO_CLSID%> height=150 width=100 border="0" align=absmiddle>
							<param name=ComboDataID		value=initds11>
                                                             <param name=BindColumn      value="detail">
                                                             <param name=BindColVal      value="detail">
							<param name=EditExprFormat	value="%,%,%;head,detail,detail_nm">
							<param name=ListExprFormat  value="detail_nm^0^160">
						</object>
						
						</td>
					  </tr>																																																						
					  <tr>
						<td class='boardt02'>�ּ�1</td>
						<td bgcolor='#ffffff' colspan="3">&nbsp;
                        	<input type=text name=txt_address1 id=txt_address1 size=20 class="textbox" OnKeyUp="cfLengthCheck(this, 40);"> ��) ��� ��õ��, ���� ���α�
						</td>
					  </tr>																																																						
					  <tr id=inner_person style="display:inline">
						<td class='boardt02'>�ּ�2</td>
						<td bgcolor='#ffffff' colspan="3">&nbsp;
							<input type=text name=txt_address2 id=txt_address2 size=50 class="textbox" OnKeyUp="cfLengthCheck(this, 60);">
						</td>		
					  </tr>																																																						
					  <tr id=outer_person style="display:none">
						<td class='boardt02'>�����ּ�1</td>
						<td bgcolor='#ffffff' colspan="3">&nbsp;&nbsp;
							<input type=text name=txt_eng_addr1 id=txt_eng_addr1 size=50  class="textbox" OnKeyUp="cfLengthCheck(this, 60);">
						</td>		
					  </tr>																																																						
					  <tr>
						<td class='boardt02'>������ȭ</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
						
                        <object id=tel_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                            <param name=Format      value="99999999999999999999">
                            <param name=Alignment   value=1>
                            <param name=ClipMode    value=true>
                            <param name=Border      value=false>
                            <param name=SelectAll   value=true>
                            <param name=SelectAllOnClick      value=true>
                            <param name=SelectAllOnClickAny   value=false>
                            <param name=UpperFlag   value=1>
                        </object>
                        
						</td>		
						<td class='boardt02'>�ڵ���</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
						
                        <object id=mobile_no classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                            <param name=Format      value="99999999999999999999">
                            <param name=Alignment   value=1>
                            <param name=ClipMode    value=true>
                            <param name=Border      value=false>
                            <param name=SelectAll   value=true>
                            <param name=SelectAllOnClick      value=true>
                            <param name=SelectAllOnClickAny   value=false>
                            <param name=UpperFlag   value=1>
                        </object>
						
						</td>
					  </tr>																																																						
					  <tr>
						<td class='boardt02'>�Ҽ�ȸ���</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
							<input type=text name=txt_company_nm id=txt_company_nm size=11 class="textbox" OnKeyUp="cfLengthCheck(this, 30);">
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�Ҽ�ȸ�縦 �˻��մϴ�"  style="cursor:pointer" id="company_btn" onclick="javascript:fnCompanyPopup('<%=dirPath%>');" align='absmiddle'>
						</td>
						<td class='boardt02'>�Ҽ�ȸ��SID</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
                        	<input type="text" name='sCompanySid' id='sCompanySid' value='' disabled  class='textbox' size=10>
						</td>
								
					  </tr>																																																						
					  <tr>
						<td class='boardt02'>���ȸ���</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
							<input type=text name=txt_realcompany_nm id=txt_realcompany_nm size=11 class="textbox" OnKeyUp="cfLengthCheck(this, 30);">
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="���δ�ȸ�縦 �˻��մϴ�"  style="cursor:pointer" id="realcompany_btn" onclick="javascript:fnCompanyPopup1('<%=dirPath%>');" align='absmiddle'>
						</td>
						<td class='boardt02'>���ȸ��SID</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
                        	<input type="text" name='sRealCompanySid' id='sRealCompanySid' value='' disabled  class='textbox' size=10>
						</td>
								
					  </tr>																																																						

					  <tr id=outer_person style="display:none">
						<td class='boardt02'>���������</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
						
                        <object id=eng_company_nm classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                            <param name=Format      value="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ">
                            <param name=Alignment   value=1>
                            <param name=ClipMode    value=true>
                            <param name=Border      value=false>
                            <param name=SelectAll   value=true>
                            <param name=SelectAllOnClick      value=true>
                            <param name=SelectAllOnClickAny   value=false>
                            <param name=UpperFlag   value=1>
                        </object>
                        
                        </td>		
						<td class='boardt02'>��������</td>
						<td bgcolor='#ffffff' height='22px'>&nbsp;&nbsp;
						
                        <object id=eng_position classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                        	<param name=Format      value="ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ">
                            <param name=Alignment   value=1>
                            <param name=ClipMode    value=true>
                            <param name=Border      value=false>
                            <param name=SelectAll   value=true>
                            <param name=SelectAllOnClick      value=true>
                            <param name=SelectAllOnClickAny   value=false>
                            <param name=UpperFlag   value=1>
                        </object>
                        
						</td>
					  </tr>																																																						
					  <tr>
						<td class='boardt02'>����</td>
                        <td bgcolor='#ffffff'>&nbsp;
							<input type='hidden' name='country_cd' id='country_cd' value=''  readonly='readolny' size='10' class='textbox'>
							<input type='text' name='country_nm' id='country_nm' value=''  readonly='readolny' size='11' class='textbox'>
                            <img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ڵ带  �˻��մϴ�"  style="cursor:pointer" id="country_btn" onclick="javascript:fnCountryPopup('<%=dirPath%>');" align='absmiddle'>
						</td>
						<td bgcolor='#ffffff' height='22px' class='boardt02'>����</td>
						<td bgcolor='#ffffff'>&nbsp;
							<input type='hidden' id='lc_nation' value='' readonly='readolny' size='10' class='textbox'>
							<input type='text' id='lc_nation_nm' value='' readonly='readolny' size='10' class='textbox'>
							<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�����ڵ带  �˻��մϴ�"  style="cursor:pointer" id="nation_btn" onclick="javascript:fnNationPopup('<%=dirPath%>');" align='absmiddle'>
						</td>
					  </tr>																																																						
					  <tr>
						<td class='boardt02'>�븮��</td>
						<td bgcolor='#ffffff' >&nbsp;
                        	<input type="hidden" name='client_sid' id='client_sid' value=''>
                        	<input type="text" name='client_nm' id='client_nm' value='' size='11' readonly='readonly'  class='textbox'>
                        	<img src="<%=dirPath%>/Sales/images/help.gif" border="0" ALT="�븮����  �˻��մϴ�"  style="cursor:pointer" id="client_btn" onclick="javascript:fnClientPopup('<%=dirPath%>');" align='absmiddle'>
						</td>	
						<td class='boardt02'>����</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
							<input type=text name=txt_positions id=txt_positions size=10 class="textbox" OnKeyUp="cfLengthCheck(this, 20);">
						</td>
					  </tr>
					  <tr style="display:none">
						<td height='22px'  class='boardt02'>����</td>
                        <td bgcolor='#ffffff'>&nbsp;&nbsp;
                        
                        <object id=height classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='50px' align='absmiddle' class='textbox'>            
                            <param name=Format      value="000">
                            <param name=Alignment   value=1>
                            <param name=ClipMode    value=true>
                            <param name=Border      value=false>
                            <param name=SelectAll   value=true>
                            <param name=SelectAllOnClick      value=true>
                            <param name=SelectAllOnClickAny   value=false>
                        </object>
                        ��cm
                        </td>

						<td class='boardt02'>�����湮Ƚ��</td>
						<td bgcolor='#ffffff'>&nbsp;&nbsp;
                        
                        <object id=north_cnt classid=<%=HDConstant.CT_EMEDIT_CLSID%>   height='16px' width='100px' align='absmiddle' class='textbox'>            
                            <param name=Alignment   value=2>
                            <param name=ClipMode    value=true>
                            <param name=Border      value=false>
                            <param name=ReadOnly 	value="true">
                            <param name=SelectAll   value=true>
                            <param name=SelectAllOnClick      value=true>
                            <param name=SelectAllOnClickAny   value=false>
                        </object>
                        
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
	<tr>
	  <td>�� ��������, ���ǻ纻 ������ Ŭ���ϸ� ���ε�â�� ��ϴ�. ���ε� �� ���� ��ȸ�ϼž� �մϴ�.<br>
	  	�� �̹� �ԷµǾ� �ִ� �������� ��ȸ�� �� <font color=red>[������]="�����"�� �ڵ� ����Ǿ� ��ȸ</font>�մϴ�.<br>
	  ������, ��ȸ����� ���� ����ڷ� �Ǵ��ϸ� �ȵǰ� �˻����ǿ��� "�����"�� �˻��� �Ǿ�� 
	  ����� ����� �����Դϴ�.<br>
	  ���ѹ��� �������� ��ȸ�ؼ� ������ ������ ������ �ǵ����� ���� ������ �����������ڷ� ����� �� ������
	  �������ּ���.<br><br>

		�� �ֹ�/���ǹ�ȣ ���� - (���) �ԷµǾ� �־ <font color=red>�����ϰ� ��ȸ</font>�մϴ�. �׳� Enter�� ��������~!<br>
		�� ������ȭ, �ڵ��� �Է½� ���� ���̿� <font color=red>����(��:02 3669 3000)�� �� �Է�</font>���ּ���. ���� ���迡 �ʿ��մϴ�. (2015.10.15����)	  

	  </td>
	</tr>	
</table>						


<%
/*=============================================================================
			Bind ����
=============================================================================*/
%>
	
	     <object id=imgBn classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="imgDs">
	             <param name=BindInfo    value="
	                <C>Col=PICTURE_INFO     Ctrl=gcip_file          Param=value</C>
	                <C>Col=PICTURE_URL      Ctrl=gcip_file          Param=value</C>
	              ">
	      </object>
	     <object id=bn1 classid=<%=HDConstant.CT_BINDER_CLASSID%>>
	             <param name="DataId" value="ds1">
	             <param name=BindInfo    value="
	                <C>Col=group_cd         Ctrl=group_cd           Param=Value</C>
	                <C>Col=regi_no          Ctrl=regi_no            Param=Text</C>
	                <C>Col=regi_yn_t          Ctrl=lc_regi_yn         Param=BindColVal </C>
	                <C>Col=cust_gu          Ctrl=lc_cust_gu         Param=BindColVal</C>
	                <C>Col=country_gu       Ctrl=lc_country_gu      Param=BindColVal </C>
	                <C>Col=saup_gu          Ctrl=lc_saup_gu         Param=BindColVal</C>
	                <C>Col=cust_type        Ctrl=lc_cust_type       Param=BindColVal </C>
	                <C>Col=CUST_NM          Ctrl=txt_cust_nm        Param=Value</C>
	                <C>Col=last_nm          Ctrl=last_nm            Param=Text</C>
	                <C>Col=first_nm         Ctrl=first_nm           Param=Text</C>
	                <C>Col=country_cd       Ctrl=country_cd         Param=Value</C>
	                <C>Col=nation_cd        Ctrl=lc_nation          Param=Value </C>
	                <C>Col=birthday         Ctrl=birthday            Param=Text</C>
	                <C>Col=sex              Ctrl=lc_sex             Param=BindColVal</C>
	                <C>Col=tel_no           Ctrl=tel_no             Param=Text</C>
	                <C>Col=mobile_no        Ctrl=mobile_no          Param=Text</C>
					<C>Col=zip_sid           Ctrl=zip_sid             Param=Value</C>                
	                <C>Col=zip_cd           Ctrl=zip_cd             Param=Text</C>
	                <C>Col=address1         Ctrl=txt_address1       Param=value</C>
	                <C>Col=address2         Ctrl=txt_address2       Param=value</C>
	                <C>Col=eng_zip_cd       Ctrl=eng_zip_cd         Param=Text</C>
	                <C>Col=eng_addr1        Ctrl=txt_eng_addr1      Param=value</C>
	                <C>Col=pass_type        Ctrl=lc_pass_type       Param=BindColVal</C>
	                <C>Col=pass_no          Ctrl=pass_no            Param=Text</C>
	                <C>Col=pass_expire_date Ctrl=pass_expire_date   Param=Text</C>
	                <C>Col=company_nm       Ctrl=txt_company_nm         Param=Value</C>
	                <C>Col=positions        Ctrl=txt_positions          Param=Value</C>
	                <C>Col=eng_company_nm   Ctrl=eng_company_nm     Param=Text</C>
	                <C>Col=eng_position     Ctrl=eng_position       Param=Text</C>
	                <C>Col=north_cnt        Ctrl=north_cnt          Param=Text </C>
	                <C>Col=client_sid       Ctrl=client_sid       Param=Value</C>
	                <C>Col=client_nm		Ctrl=client_nm			Param=Value</C>
	                
	                <C>Col=country_nm       Ctrl=country_nm       Param=Value</C>
	                <C>Col=nation_cd_nm       Ctrl=lc_nation_nm       Param=Value</C>
	                <C>Col=job_cd			Ctrl=lc_job_gu			Param=BindColVal</C>
	                
	                <C>Col=Company_Sid      Ctrl=sCompanySid        Param=Value</C>
	                <C>Col=RealCompany_Sid  Ctrl=sRealCompanySid    Param=Value</C>
   	                <C>Col=Realcompany_nm   Ctrl=txt_realcompany_nm         Param=Value</C>
	              ">
	      </object>
	      


<!--------------------------------- �ڵ� �κ� �� -------------------------------->	
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>		

