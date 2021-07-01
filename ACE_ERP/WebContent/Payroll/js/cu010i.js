    /**
     * DataSet üũ �Լ�
     */
    function fnCustInfoCheck() {
        if (ds1.IsUpdated || imgDs.IsUpdated) {
            for(var i=1; i<=ds1.CountRow; i++){
                //Insert / Update �۾��� ��쿡...
                if(ds1.RowStatus(i)==1 || ds1.RowStatus(i)==3){
                    var v_country_gu = ds1.NameValue(i, "COUNTRY_GU");
                    if(v_country_gu==""){
                        alert("���������� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_country_gu").Focus();
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
                            getObjectFirst("regi_no").Focus();
                            return false;
                        }
                        ds1.NameValue(i, "MANAGE_NO") = ds1.NameValue(i, "REGI_NO");
                        if(ds1.NameValue(i, "REGI_YN")==""){
                            alert("�������θ� �����Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("lc_regi_yn").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ZIP_CD")==""){
                            alert("�����ȣ �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("zip_cd").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ADDRESS2")==""){
                            alert("�ּ� 2�� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("txt_address2").Focus();
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
                            getObjectFirst("pass_no").Focus();
                            return false;
                        }
                        ds1.NameValue(i, "MANAGE_NO") = ds1.NameValue(i, "PASS_NO");
                        if(ds1.NameValue(i, "PASS_TYPE")==""){
                            alert("���� ������ �����Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("lc_pass_type").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "PASS_EXPIRE_DATE")==""){
                            alert("���� ������ �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("pass_expire_date").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ENG_ADDR1")==""){
                            alert("���� �ּ�1�� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("txt_eng_addr1").Focus();
                            return false;
                        }
                         if(ds1.NameValue(i, "ENG_COMPANY_NM")==""){
                            alert("����ȸ����� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("eng_company_nm").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ENG_POSITION")==""){
                            alert("���� �������� �Է��Ͻñ� �ٶ��ϴ�.");
                            getObjectFirst("eng_position").Focus();
                            return false;
                        }
                    }
                    if(ds1.NameValue(i, "BIRTHDAY")==""){
                        alert("��������� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("birthday").Focus();
                        return false;
                    }
                    
                    // �������� ������ϰ�쿡�� Ű�� �˻�
                     if (lc_cust_gu.Index ==1) {
	                    if(ds1.NameValue(i, "HEIGHT")==""){
	                        alert("�� ������ �Է��Ͻñ� �ٶ��ϴ�.");
	                        getObjectFirst("height").Focus();
	                        return false;
	                    }
                    }
                    if(ds1.NameValue(i, "SEX")==""){
                        alert("�� ������ �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_sex").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CUST_GU")==""){
                        alert("�������� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_cust_gu").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "SAUP_GU")==""){
                        alert("��������� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_saup_gu").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CUST_TYPE")==""){
                        alert("�������� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_cust_type").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "LAST_NM")==""){
                        alert("�� ���� ���� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("last_nm").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "FIRST_NM")==""){
                        alert("�� ���� �̸��� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("first_nm").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "ADDRESS1")==""){
                        alert("�ּ� 1�� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("txt_address1").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "TEL_NO")==""){
                        alert("������ȭ��ȣ�� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("tel_no").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "MOBILE_NO")==""){
                        alert("�ڵ�����ȣ�� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("mobile_no").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "COUNTRY_CD")==""){
                        alert("������ �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("country_cd").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "NATION_CD")==""){
                        alert("������ �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_nation").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CLIENT_ID")==""){
                        alert("����ó�� �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("client_sid").Focus();
                        return false;
                    }
                }
            }
            return true;
         }
    }

    /**
     * �����ȣ �˾�
     */
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
        if(v_country=="" || v_country=="10"){
            for(var i=0; i<getObjectList("inner_person").length; i++)
                getObjectList("inner_person")[i].style.display = "inline";
            for(var i=0; i<getObjectList("outer_person").length; i++)
                getObjectList("outer_person")[i].style.display = "none";
        } else {
            for(var i=0; i<getObjectList("inner_person").length; i++)
                getObjectList("inner_person")[i].style.display = "none";
            for(var i=0; i<getObjectList("outer_person").length; i++)
                getObjectList("outer_person")[i].style.display = "inline";
        }
		
		if(ds1.CountRow>0 && ds1.SysStatus(ds1.RowPosition) == 1){
	    	if (v_country=="10") {
            	// �������ϰ�� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "����";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
					lc_cust_gu.Index = 0;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            } else if (v_country=="20") {
            	// ���ֱ��ϰ�� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "����";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
					lc_cust_gu.Index = 0;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            } else if (v_country=="30") {
            	// �ùα� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
					lc_cust_gu.Index = 0;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            } else if (v_country=="40") {
            	// �ܱ��� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "";
	            	lc_nation_nm.value = "";
            		
            		
					lc_cust_gu.Index = 0;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            }  else if (v_country=="50") {
            	// ������ 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "CHN";
            		country_nm.value = "�߱�";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
					lc_cust_gu.Index = 0;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            }
        }
            
            
        if(ds1.CountRow>0){
            getObjectFirst("confirm_btn").style.display = "inline";
            if(getObjectFirst("find_btn")!=undefined)
                getObjectFirst("find_btn").style.display = "inline";
            getObjectFirst("zipcode_btn").style.display = "inline";
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
