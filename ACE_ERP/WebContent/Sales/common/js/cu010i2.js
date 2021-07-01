    /**
     * DataSet ?? ?? ????
     */
    function fnCustInfoCheck() {
        if (ds1.IsUpdated) {
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
                    }
                    if(ds1.NameValue(i, "BIRTHDAY")==""){
                        alert("생년월일을 입력하시길 바랍니다.");
                        getObjectFirst("birthday").Focus();
                        return false;
                    }
                    
                    if(ds1.NameValue(i, "SEX")==""){
                        alert("고객 성별을 선택하시길 바랍니다.");
                        getObjectFirst("lc_sex").Focus();
                        return false;
                    }
                    if(ds1.NameValue(i, "MOBILE_NO")==""){
                        alert("핸드폰번호를 입력하시길 바랍니다.");
                        getObjectFirst("mobile_no").Focus();
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
     * 화면 컨트롤 관리
     */
    function fnScreenDisplay(v_country){
        if(v_country=="" || v_country=="10"){ //국적구분이 없거나 내국인인경우
            for(var i=0; i<getObjectList("inner_person").length; i++)
                getObjectList("inner_person")[i].style.display = "inline";
            for(var i=0; i<getObjectList("outer_person").length; i++)
                getObjectList("outer_person")[i].style.display = "none";
        } else {
            for(var i=0; i<getObjectList("inner_person").length; i++)
                getObjectList("inner_person")[i].style.display = "none";
            for(var i=0; i<getObjectList("outer_person").length; i++)
                getObjectList("outer_person")[i].style.display = "inline";

			lc_pass_type.Index = 0;	//여권종류 0번재. 일반여권으로 고정
        }

/*		if(ds1.CountRow>0 && ds1.SysStatus(ds1.RowPosition) == 1){
	    	if (v_country=="10") {
            	// 내국인일경우 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "남측";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "조선";
            		
            
            } else if (v_country=="20") {
            	// 영주권일경우 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "KOR";
            		country_nm.value = "남측";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "조선";
            		
            
            } else if (v_country=="30") {
            	// 시민권 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "조선";
            		
           
            } else if (v_country=="40") {
            	// 외국인 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "";
            		country_nm.value = "";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "";
	            	lc_nation_nm.value = "";
            		
            		
            
            }  else if (v_country=="50") {
            	// 조선족 
            		ds1.namevalue(ds1.rowposition,"country_cd") = "CHN";
            		country_nm.value = "중국";
            		ds1.namevalue(ds1.rowposition,"nation_cd") = "JSN";
	            	lc_nation_nm.value = "조선";
            		

            
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
