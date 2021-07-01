    /**
     * DataSet 체크 함수
     */
    function fnCustInfoCheck() {
        if (ds1.IsUpdated || imgDs.IsUpdated) {
            for(var i=1; i<=ds1.CountRow; i++){
                //Insert / Update 작업일 경우에...
                if(ds1.RowStatus(i)==1 || ds1.RowStatus(i)==3){
                    var v_country_gu = ds1.NameValue(i, "COUNTRY_GU");
                    if(v_country_gu==""){
                        alert("국적구분을 선택하시길 바랍니다.");
                        getObjectFirst("lc_country_gu").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CUST_NM")==""){
                        alert("고객 한글성명을 입력하시길 바랍니다.");
                        getObjectFirst("txt_cust_nm").focus();
                        return false;
                    }
                    
                    if(v_country_gu=="10") {
                        if(ds1.NameValue(i, "REGI_NO")==""){
                            alert("고객의 주민번호를 등록하여 주시길 바랍니다.");
                            getObjectFirst("regi_no").Focus();
                            return false;
                        }
                        ds1.NameValue(i, "MANAGE_NO") = ds1.NameValue(i, "REGI_NO");
                        if(ds1.NameValue(i, "REGI_YN")==""){
                            alert("인증여부를 선택하시길 바랍니다.");
                            getObjectFirst("lc_regi_yn").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ZIP_CD")==""){
                            alert("우편번호 입력하시길 바랍니다.");
                            getObjectFirst("zip_cd").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ADDRESS2")==""){
                            alert("주소 2을 입력하시길 바랍니다.");
                            getObjectFirst("txt_address2").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "COMPANY_NM")==""){
                            alert("직장명을 입력하시길 바랍니다.");
                            getObjectFirst("txt_company_nm").focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "POSITIONS")==""){
                            alert("직위명을 입력하시길 바랍니다.");
                            getObjectFirst("txt_positions").focus();
                            return false;
                        }
                    } else {
                         if(ds1.NameValue(i, "PASS_NO")==""){
                            alert("고객의 여권번호를 등록하여 주시길 바랍니다.");
                            getObjectFirst("pass_no").Focus();
                            return false;
                        }
                        ds1.NameValue(i, "MANAGE_NO") = ds1.NameValue(i, "PASS_NO");
                        if(ds1.NameValue(i, "PASS_TYPE")==""){
                            alert("여권 종류를 선택하시길 바랍니다.");
                            getObjectFirst("lc_pass_type").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "PASS_EXPIRE_DATE")==""){
                            alert("여권 만기일 입력하시길 바랍니다.");
                            getObjectFirst("pass_expire_date").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ENG_ADDR1")==""){
                            alert("영문 주소1을 입력하시길 바랍니다.");
                            getObjectFirst("txt_eng_addr1").Focus();
                            return false;
                        }
                         if(ds1.NameValue(i, "ENG_COMPANY_NM")==""){
                            alert("영문회사명을 입력하시길 바랍니다.");
                            getObjectFirst("eng_company_nm").Focus();
                            return false;
                        }
                        if(ds1.NameValue(i, "ENG_POSITION")==""){
                            alert("영문 직위명을 입력하시길 바랍니다.");
                            getObjectFirst("eng_position").Focus();
                            return false;
                        }
                    }
                    if(ds1.NameValue(i, "BIRTHDAY")==""){
                        alert("생년월일을 입력하시길 바랍니다.");
                        getObjectFirst("birthday").Focus();
                        return false;
                    }
                    
                    // 고객구분이 사업자일경우에만 키를 검사
                     if (lc_cust_gu.Index ==1) {
	                    if(ds1.NameValue(i, "HEIGHT")==""){
	                        alert("고객 신장을 입력하시길 바랍니다.");
	                        getObjectFirst("height").Focus();
	                        return false;
	                    }
                    }
                    if(ds1.NameValue(i, "SEX")==""){
                        alert("고객 성별을 선택하시길 바랍니다.");
                        getObjectFirst("lc_sex").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CUST_GU")==""){
                        alert("고객구분을 선택하시길 바랍니다.");
                        getObjectFirst("lc_cust_gu").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "SAUP_GU")==""){
                        alert("사업구분을 선택하시길 바랍니다.");
                        getObjectFirst("lc_saup_gu").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CUST_TYPE")==""){
                        alert("고객유형을 선택하시길 바랍니다.");
                        getObjectFirst("lc_cust_type").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "LAST_NM")==""){
                        alert("고객 영문 성을 입력하시길 바랍니다.");
                        getObjectFirst("last_nm").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "FIRST_NM")==""){
                        alert("고객 영문 이름을 입력하시길 바랍니다.");
                        getObjectFirst("first_nm").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "ADDRESS1")==""){
                        alert("주소 1을 입력하시길 바랍니다.");
                        getObjectFirst("txt_address1").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "TEL_NO")==""){
                        alert("자택전화번호를 입력하시길 바랍니다.");
                        getObjectFirst("tel_no").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "MOBILE_NO")==""){
                        alert("핸드폰번호를 입력하시길 바랍니다.");
                        getObjectFirst("mobile_no").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "COUNTRY_CD")==""){
                        alert("국적을 입력하시길 바랍니다.");
                        getObjectFirst("country_cd").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "NATION_CD")==""){
                        alert("민족을 선택하시길 바랍니다.");
                        getObjectFirst("lc_nation").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "CLIENT_ID")==""){
                        alert("매출처를 선택하시길 바랍니다.");
                        getObjectFirst("client_sid").Focus();
                        return false;
                    }
                }
            }
            return true;
         }
    }

    /**
     * 우편번호 팝업
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
     * 민족코드 팝업
     */
    function fnNationPopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        strURL = dirPath+"/Sales/help/sy001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrParam[0] = "SY005";
        arrParam[1] = "민족";
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
     * 국적코드 팝업
     */
    function fnCountryPopup(dirPath) {
        var arrParam    = new Array();
        var arrResult   = new Array();
        var strURL; 
        var strPos;
        
        strURL = dirPath+"/Sales/help/sy001h.jsp";
        strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
        arrParam[0] = "SY005";
        arrParam[1] = "국적";
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
     * 화면 컨트롤 관리
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
            	// 내국인일경우 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "남측";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "조선";
            		
					lc_cust_gu.Index = 0;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            } else if (v_country=="20") {
            	// 영주권일경우 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "남측";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "조선";
            		
					lc_cust_gu.Index = 0;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            } else if (v_country=="30") {
            	// 시민권 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "조선";
            		
					lc_cust_gu.Index = 0;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            } else if (v_country=="40") {
            	// 외국인 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "";
	            	lc_nation_nm.value = "";
            		
            		
					lc_cust_gu.Index = 0;
					lc_saup_gu.Index = 0;
					lc_cust_type.Index = 0;
            
            }  else if (v_country=="50") {
            	// 조선족 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "CHN";
            		country_nm.value = "중국";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "조선";
            		
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
     * 매출처  팝업
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
     * 검색조건 매출처  팝업 
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
     * 화일명 체크
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
     * 신청서 번호 팝업
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
