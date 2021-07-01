<!--

/******************************************************************************************
	Descrition :  //종전근무지 체크 
	parameter  : ds - 데이타셋 명 
	retun      : 
******************************************************************************************/
function Ofc_Apply_Chk(ds) {
	var i=0;
	if(eval(ds).countrow>=1){
		for(i=1;i<=eval(ds).countrow;i++){
			if(eval(ds).namevalue(i, "WKNM")==""){
				alert("회사명을 입력하십시요");
				getObjectFirst("f_WKNM").focus();
				return false;
			}

			if(eval(ds).namevalue(i,"WKRESINO")==""){
				alert("사업자등록번호를 입력하십시요");
				getObjectFirst("f_WKRESINO").Focus();
				return false;
			}

			//사업자번호 체크
			if(!gf_Wkresino(eval(ds).namevalue(i,"WKRESINO"))){
				getObjectFirst("f_WKRESINO").Focus();
				return false;
			}


			if(eval(ds).namevalue(i,"STRTDT")==""||eval(ds).namevalue(i,"ENDDT")==""){
				alert("근무 기간을 입력하십시요");
				getObjectFirst("STRTDT").Focus();
				return false;
			}

//			if(eval(ds).namevalue(i,"BTAXNM01")!==""&&eval(ds).namevalue(i,"BTAXAMT01")=="0"){
//				alert("비과세항목과 금액을 확인하세요");
//				getObjectFirst("BTAXCD01").Focus();
//				return false;
//			}
//
//			if(eval(ds).namevalue(i,"BTAXNM02")!==""&&eval(ds).namevalue(i,"BTAXAMT02")=="0"){
//				alert("비과세항목과 금액을 확인하세요");
//				getObjectFirst("BTAXCD02").Focus();
//				return false;
//			}

		}
	}

	return true;
}


/******************************************************************************************
	Descrition :  //인적공제  체크 
	parameter  : ds - 데이타셋 명 
	retun      : 
******************************************************************************************/
function Basic_Apply_Chk(ds) {

	var i=0;

	if(eval(ds).countrow>=1){

		for(i=1;i<=eval(ds).countrow;i++){

			if(eval(ds).namevalue(i, "FAMNM1")==""){
				alert("성명을 입력하십시요");
				return false;
			}

			if(eval(ds).namevalue(i,"RESINO1")==""){
				alert("주민등록번호를 입력하십시요");
				return false;
			}

			//주민번호 체크
			//외국인이 아닌 경우
			if(eval(ds).namevalue(i,"REF1")!="T"){

				if(!gn_Resino(eval(ds).namevalue(i,"RESINO1"))){

					return false;
				}

			}else{ //외국인인 경우 

                if(!gn_FgResino(eval(ds).namevalue(i,"RESINO1"))){
					return false;

				}

			}

			//추가공제 체크
			//1.본인인경우 - 자녀 양육비와 
		}
	}
	return true;
}

/******************************************************************************************
	Descrition :  //의료비공제  체크 
	parameter  : ds - 데이타셋 명 
	retun      : 
******************************************************************************************/
function Medi_Apply_Chk(ds){
	var i=0;
	if(eval(ds).countrow>=1){
		for(i=1;i<=eval(ds).countrow;i++){

			if(eval(ds).namevalue(i,"PRFCD")!=="1"){
                if(eval(ds).namevalue(i,"INDNO")==""){
					alert("사업자등록번호를 입력하십시요");
					return false;
				}
			}

			if(eval(ds).namevalue(i,"PRFCD")==""){
				alert("증빙코드를 입력하십시요");
				return false;
			}

			if(eval(ds).namevalue(i,"PRFCD")!=="1"){
				if(eval(ds).namevalue(i,"INDNAME")==""){
					alert("상호를 입력하십시요");
					return false;
				}
			}


			//주민번호 체크
			if(eval(ds).namevalue(i,"REF1")!="T"){
				if(!gf_Wkresino(eval(ds).namevalue(i,"INDNO"))){
					return false;
				}
			}

			//공제관계에 따른 체크
			//신용카드 및 현금영수증일 경우
			/*
            if(eval(ds).namevalue(i,"RELATION")=="1"||eval(ds).namevalue(i,"RELATION")=="2"){
               if(eval(ds).namevalue(i,"CARDCNTA")==0&&eval(ds).namevalue(i,"CARDCNTB")==0){
				 alert("건수를 입력하십시요.");
				 return false;
			   }
			}else if(eval(ds).namevalue(i,"RELATION")=="3"){ //현금일경우
			   if(eval(ds).namevalue(i,"CASHCNTA")==0&&eval(ds).namevalue(i,"CASHCNTB")==0){
				 alert("건수를 입력하십시요.");
				 return false;
			   }
			}
			*/
		}
	}
	return true;
}

/******************************************************************************************
	Descrition :  //의료비공제  체크 
	parameter  : ds - 데이타셋 명 
	retun      : 
******************************************************************************************/
function Card_Apply_Chk(ds){
	var i=0;
	if(eval(ds).countrow>=1){
		for(i=1;i<=eval(ds).countrow;i++){
			if(eval(ds).namevalue(i,"CARD11")+eval(ds).namevalue(i,"CARD13")< eval(ds).namevalue(i,"CARD14")){
				alert("의료기관 사용액이 너무 많습니다.");
				return false;
			}

			if(eval(ds).namevalue(i,"CARD21")<eval(ds).namevalue(i,"CARD24")){
				alert("의료기관 사용액이 너무 많습니다.2");
				return false;
			}
		}
	}
	return true;
}


/******************************************************************************************
	Descrition :  //기부금  체크 
	parameter  : ds - 데이타셋 명 
	retun      : 
******************************************************************************************/
function Gibu_Apply_Chk(ds){
	var i=0;
	var strGivsaup ="";
	if(eval(ds).countrow>=1){
		for(i=1;i<=eval(ds).countrow;i++){

			if(eval(ds).namevalue(i, "GIVPRNM")==""){
				alert("기부자의 성함을 입력하십시오");
				return false;
			}


			if(eval(ds).namevalue(i, "GIVJYO")==""){
				alert("기부내용을 입력하십시요");
				return false;
			}


			if(eval(ds).namevalue(i, "GIVCOMP")==""){
				alert("상호를 입력하십시요");
				return false;
			}
		
            //정치자금은 예외
			if(eval(ds).namevalue(i,"GIVCOD")!="20"){
                if(eval(ds).namevalue(i,"GIVSAUP")==""){
					alert("사업자등록번호를 입력하십시요");
					return false;
				}

				strGivsaup=eval(ds).namevalue(i, "GIVSAUP");
				if(strGivsaup.length ==10){
					//사업자번호 체크
					if(!gf_Wkresino(eval(ds).namevalue(i,"GIVSAUP"))){
						return false;
					}
				}else if(strGivsaup.length==13){
					//주민번호 체크
					if(!gn_Resino(eval(ds).namevalue(i,"GIVSAUP"))){
						return false;
					}
				}else{
					alert("자리수가 맞지 않습니다.");
					return false;
				}
			}
			
			if(eval(ds).SysStatus(i)==3&&eval(ds).namevalue(i,"FLAGCOL")=="U"){//수정
				if(eval(ds).namevalue(i, "GIVCOD") !=eval(ds).OrgNameValue(i, "GIVCOD")){
					alert("유형은 변경할 수 없습니다. 삭제 후 다시 입력하십시요.");
					return false;
				}
			}
		}
	}
	return true;
}

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 공통
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/

/******************************************************************************************
		Descrition : 주민번호 체크
		parameter  : 주민번호
		retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gn_Resino(p) {
	var jumin=p;
	var vindex="234567892345";
	var total=0;

	for(var i=0;i<12;i++) total+=parseInt(jumin.charAt(i)*vindex.charAt(i));

	total=11-total%11;
	if(total==10)	total=0;
	else if(total==11) total=1;


	//alert("total::"+total+"jumin.charAt(12)::::"+jumin.charAt(12));

	if(total!=jumin.charAt(12)){
		alert("주민등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요.");
		return false;
	}

	return true;
}

/******************************************************************************************
	Descrition : 사업자번호 체크
	parameter  : 사업자번호
	retun      : true - 가능 , false - 불가능
******************************************************************************************/
function gf_Wkresino(p) {
	var int_val=0;
	var int_getpam =new Array(10);
	var int_chkval =new Array("1","3","7","1","3","7","1","3","5");
	var int_result=0;
	var int_chk=0;
	var i=0;
	var j=0;

	for (i=0;i<10;i++){int_getpam[i]= p.substring(i,i+1);} 
	for (j=0;j<9;j++){ int_val += int_getpam[j]*int_chkval[j];} 

	int_val=int_val + Math.floor((int_getpam[8]*5)/10);
	int_result = int_val%10; 

	if(int_result==0){ int_chk = 0;}
	else{ int_chk = 10 - int_result;}

	if(int_chk!= int_getpam[9]){
		alert("사업자등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요.");
		return false;
	}else{
		return true;
	}
}

function gf_msg(){
	alert("작업을 완료 하였습니다.");
}



/******************************************************************************************
		Descrition : 주민번호 체크 (외국인)
		parameter  : 주민번호
		retun      : true - 가능 , false - 불가능
******************************************************************************************/
/********************************************
 외국인 주민번호 체크 
*******************************************/
function gn_FgResino(fgnno) {  
	var sum=0;  
	var odd=0;  
	buf = new Array(13);  
	for(i=0; i<13; i++) { 
		buf[i]=parseInt(fgnno.charAt(i)); 
	}  
	
	odd = buf[7]*10 + buf[8];  
	
	if(odd%2 != 0) { 
		alert("외국인 주민등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요0.");
		return false;
	}
	
	if( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ) {   
		alert("외국인 주민등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요00.");
		return false;  
	}  
	
	multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];  
	
	for(i=0, sum=0; i<12; i++) { sum += (buf[i] *= multipliers[i]); }  
	
	sum = 11 - (sum%11);  
	
	if(sum >= 10) { sum -= 10; }  
	
	sum += 2;  
	
	if(sum >= 10) { sum -= 10; }  
	
	if(sum != buf[12]) { 
	    alert("외국인 주민등록번호가 맞지 않습니다.\n\n다시 입력하여 주십시요000.");	
		return false; 
	}  
	
	return true; 
}

 

//-->