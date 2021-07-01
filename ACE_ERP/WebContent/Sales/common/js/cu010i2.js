    /**
     * DataSet ?? ?? ????
     */
    function fnCustInfoCheck() {
        if (ds1.IsUpdated) {
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
                    }
                    if(ds1.NameValue(i, "BIRTHDAY")==""){
                        alert("��������� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("birthday").Focus();
                        return false;
                    }
                    
                    if(ds1.NameValue(i, "SEX")==""){
                        alert("�� ������ �����Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("lc_sex").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "MOBILE_NO")==""){
                        alert("�ڵ�����ȣ�� �Է��Ͻñ� �ٶ��ϴ�.");
                        getObjectFirst("mobile_no").Focus();
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

/*		if(ds1.CountRow>0 && ds1.SysStatus(ds1.RowPosition) == 1){
	    	if (v_country=="10") {
            	// �������ϰ�� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "����";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
            
            } else if (v_country=="20") {
            	// ���ֱ��ϰ�� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "����";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
            
            } else if (v_country=="30") {
            	// �ùα� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		
           
            } else if (v_country=="40") {
            	// �ܱ��� 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "";
	            	lc_nation_nm.value = "";
            		
            		
            
            }  else if (v_country=="50") {
            	// ������ 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "CHN";
            		country_nm.value = "�߱�";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "����";
            		

            
            }
        }*/
            
            
        if(ds1.CountRow>0){
            getObjectFirst("client_btn").style.display = "inline";
            getObjectFirst("lc_country_gu").Enable  = "True";
            getObjectFirst("group_cd").Enable       = "True";
            getObjectFirst("regi_no").Enable        = "True";
            getObjectFirst("lc_regi_yn").Enable     = "false";
            getObjectFirst("pass_no").Enable        = "True";
            getObjectFirst("lc_pass_type").Enable   = "false";
            getObjectFirst("pass_expire_date").Enable= "True";
            getObjectFirst("birthday").Enable       = "True";
            getObjectFirst("lc_sex").Enable         = "True";
            getObjectFirst("mobile_no").Enable      = "True";
            getObjectFirst("txt_cust_nm").readOnly      = false;
        } else {
            getObjectFirst("client_btn").style.display = "none";
            getObjectFirst("lc_country_gu").Enable  = "False";
            getObjectFirst("group_cd").Enable       = "False";
            getObjectFirst("regi_no").Enable        = "False";
            getObjectFirst("lc_regi_yn").Enable     = "False";
            getObjectFirst("pass_no").Enable        = "False";
            getObjectFirst("lc_pass_type").Enable   = "False";
            getObjectFirst("pass_expire_date").Enable= "False";
            getObjectFirst("birthday").Enable       = "False";
            getObjectFirst("lc_sex").Enable         = "False";
            getObjectFirst("mobile_no").Enable      = "False";
            getObjectFirst("txt_cust_nm").readOnly      = true;
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
