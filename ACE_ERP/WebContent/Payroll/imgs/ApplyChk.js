<!--

/******************************************************************************************
	Descrition :  //�����ٹ��� üũ 
	parameter  : ds - ����Ÿ�� �� 
	retun      : 
******************************************************************************************/
function Ofc_Apply_Chk(ds) {
	var i=0;
	if(eval(ds).countrow>=1){
		for(i=1;i<=eval(ds).countrow;i++){
			if(eval(ds).namevalue(i, "WKNM")==""){
				alert("ȸ����� �Է��Ͻʽÿ�");
				getObjectFirst("f_WKNM").focus();
				return false;
			}

			if(eval(ds).namevalue(i,"WKRESINO")==""){
				alert("����ڵ�Ϲ�ȣ�� �Է��Ͻʽÿ�");
				getObjectFirst("f_WKRESINO").Focus();
				return false;
			}

			//����ڹ�ȣ üũ
			if(!gf_Wkresino(eval(ds).namevalue(i,"WKRESINO"))){
				getObjectFirst("f_WKRESINO").Focus();
				return false;
			}


			if(eval(ds).namevalue(i,"STRTDT")==""||eval(ds).namevalue(i,"ENDDT")==""){
				alert("�ٹ� �Ⱓ�� �Է��Ͻʽÿ�");
				getObjectFirst("STRTDT").Focus();
				return false;
			}

//			if(eval(ds).namevalue(i,"BTAXNM01")!==""&&eval(ds).namevalue(i,"BTAXAMT01")=="0"){
//				alert("������׸�� �ݾ��� Ȯ���ϼ���");
//				getObjectFirst("BTAXCD01").Focus();
//				return false;
//			}
//
//			if(eval(ds).namevalue(i,"BTAXNM02")!==""&&eval(ds).namevalue(i,"BTAXAMT02")=="0"){
//				alert("������׸�� �ݾ��� Ȯ���ϼ���");
//				getObjectFirst("BTAXCD02").Focus();
//				return false;
//			}

		}
	}

	return true;
}


/******************************************************************************************
	Descrition :  //��������  üũ 
	parameter  : ds - ����Ÿ�� �� 
	retun      : 
******************************************************************************************/
function Basic_Apply_Chk(ds) {

	var i=0;

	if(eval(ds).countrow>=1){

		for(i=1;i<=eval(ds).countrow;i++){

			if(eval(ds).namevalue(i, "FAMNM1")==""){
				alert("������ �Է��Ͻʽÿ�");
				return false;
			}

			if(eval(ds).namevalue(i,"RESINO1")==""){
				alert("�ֹε�Ϲ�ȣ�� �Է��Ͻʽÿ�");
				return false;
			}

			//�ֹι�ȣ üũ
			//�ܱ����� �ƴ� ���
			if(eval(ds).namevalue(i,"REF1")!="T"){

				if(!gn_Resino(eval(ds).namevalue(i,"RESINO1"))){

					return false;
				}

			}else{ //�ܱ����� ��� 

                if(!gn_FgResino(eval(ds).namevalue(i,"RESINO1"))){
					return false;

				}

			}

			//�߰����� üũ
			//1.�����ΰ�� - �ڳ� ������� 
		}
	}
	return true;
}

/******************************************************************************************
	Descrition :  //�Ƿ�����  üũ 
	parameter  : ds - ����Ÿ�� �� 
	retun      : 
******************************************************************************************/
function Medi_Apply_Chk(ds){
	var i=0;
	if(eval(ds).countrow>=1){
		for(i=1;i<=eval(ds).countrow;i++){

			if(eval(ds).namevalue(i,"PRFCD")!=="1"){
                if(eval(ds).namevalue(i,"INDNO")==""){
					alert("����ڵ�Ϲ�ȣ�� �Է��Ͻʽÿ�");
					return false;
				}
			}

			if(eval(ds).namevalue(i,"PRFCD")==""){
				alert("�����ڵ带 �Է��Ͻʽÿ�");
				return false;
			}

			if(eval(ds).namevalue(i,"PRFCD")!=="1"){
				if(eval(ds).namevalue(i,"INDNAME")==""){
					alert("��ȣ�� �Է��Ͻʽÿ�");
					return false;
				}
			}


			//�ֹι�ȣ üũ
			if(eval(ds).namevalue(i,"REF1")!="T"){
				if(!gf_Wkresino(eval(ds).namevalue(i,"INDNO"))){
					return false;
				}
			}

			//�������迡 ���� üũ
			//�ſ�ī�� �� ���ݿ������� ���
			/*
            if(eval(ds).namevalue(i,"RELATION")=="1"||eval(ds).namevalue(i,"RELATION")=="2"){
               if(eval(ds).namevalue(i,"CARDCNTA")==0&&eval(ds).namevalue(i,"CARDCNTB")==0){
				 alert("�Ǽ��� �Է��Ͻʽÿ�.");
				 return false;
			   }
			}else if(eval(ds).namevalue(i,"RELATION")=="3"){ //�����ϰ��
			   if(eval(ds).namevalue(i,"CASHCNTA")==0&&eval(ds).namevalue(i,"CASHCNTB")==0){
				 alert("�Ǽ��� �Է��Ͻʽÿ�.");
				 return false;
			   }
			}
			*/
		}
	}
	return true;
}

/******************************************************************************************
	Descrition :  //�Ƿ�����  üũ 
	parameter  : ds - ����Ÿ�� �� 
	retun      : 
******************************************************************************************/
function Card_Apply_Chk(ds){
	var i=0;
	if(eval(ds).countrow>=1){
		for(i=1;i<=eval(ds).countrow;i++){
			if(eval(ds).namevalue(i,"CARD11")+eval(ds).namevalue(i,"CARD13")< eval(ds).namevalue(i,"CARD14")){
				alert("�Ƿ��� ������ �ʹ� �����ϴ�.");
				return false;
			}

			if(eval(ds).namevalue(i,"CARD21")<eval(ds).namevalue(i,"CARD24")){
				alert("�Ƿ��� ������ �ʹ� �����ϴ�.2");
				return false;
			}
		}
	}
	return true;
}


/******************************************************************************************
	Descrition :  //��α�  üũ 
	parameter  : ds - ����Ÿ�� �� 
	retun      : 
******************************************************************************************/
function Gibu_Apply_Chk(ds){
	var i=0;
	var strGivsaup ="";
	if(eval(ds).countrow>=1){
		for(i=1;i<=eval(ds).countrow;i++){

			if(eval(ds).namevalue(i, "GIVPRNM")==""){
				alert("������� ������ �Է��Ͻʽÿ�");
				return false;
			}


			if(eval(ds).namevalue(i, "GIVJYO")==""){
				alert("��γ����� �Է��Ͻʽÿ�");
				return false;
			}


			if(eval(ds).namevalue(i, "GIVCOMP")==""){
				alert("��ȣ�� �Է��Ͻʽÿ�");
				return false;
			}
		
            //��ġ�ڱ��� ����
			if(eval(ds).namevalue(i,"GIVCOD")!="20"){
                if(eval(ds).namevalue(i,"GIVSAUP")==""){
					alert("����ڵ�Ϲ�ȣ�� �Է��Ͻʽÿ�");
					return false;
				}

				strGivsaup=eval(ds).namevalue(i, "GIVSAUP");
				if(strGivsaup.length ==10){
					//����ڹ�ȣ üũ
					if(!gf_Wkresino(eval(ds).namevalue(i,"GIVSAUP"))){
						return false;
					}
				}else if(strGivsaup.length==13){
					//�ֹι�ȣ üũ
					if(!gn_Resino(eval(ds).namevalue(i,"GIVSAUP"))){
						return false;
					}
				}else{
					alert("�ڸ����� ���� �ʽ��ϴ�.");
					return false;
				}
			}
			
			if(eval(ds).SysStatus(i)==3&&eval(ds).namevalue(i,"FLAGCOL")=="U"){//����
				if(eval(ds).namevalue(i, "GIVCOD") !=eval(ds).OrgNameValue(i, "GIVCOD")){
					alert("������ ������ �� �����ϴ�. ���� �� �ٽ� �Է��Ͻʽÿ�.");
					return false;
				}
			}
		}
	}
	return true;
}

/*&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&
 ����
&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&*/

/******************************************************************************************
		Descrition : �ֹι�ȣ üũ
		parameter  : �ֹι�ȣ
		retun      : true - ���� , false - �Ұ���
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
		alert("�ֹε�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�.");
		return false;
	}

	return true;
}

/******************************************************************************************
	Descrition : ����ڹ�ȣ üũ
	parameter  : ����ڹ�ȣ
	retun      : true - ���� , false - �Ұ���
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
		alert("����ڵ�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�.");
		return false;
	}else{
		return true;
	}
}

function gf_msg(){
	alert("�۾��� �Ϸ� �Ͽ����ϴ�.");
}



/******************************************************************************************
		Descrition : �ֹι�ȣ üũ (�ܱ���)
		parameter  : �ֹι�ȣ
		retun      : true - ���� , false - �Ұ���
******************************************************************************************/
/********************************************
 �ܱ��� �ֹι�ȣ üũ 
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
		alert("�ܱ��� �ֹε�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�0.");
		return false;
	}
	
	if( (buf[11]!=6) && (buf[11]!=7) && (buf[11]!=8) && (buf[11]!=9) ) {   
		alert("�ܱ��� �ֹε�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�00.");
		return false;  
	}  
	
	multipliers = [2,3,4,5,6,7,8,9,2,3,4,5];  
	
	for(i=0, sum=0; i<12; i++) { sum += (buf[i] *= multipliers[i]); }  
	
	sum = 11 - (sum%11);  
	
	if(sum >= 10) { sum -= 10; }  
	
	sum += 2;  
	
	if(sum >= 10) { sum -= 10; }  
	
	if(sum != buf[12]) { 
	    alert("�ܱ��� �ֹε�Ϲ�ȣ�� ���� �ʽ��ϴ�.\n\n�ٽ� �Է��Ͽ� �ֽʽÿ�000.");	
		return false; 
	}  
	
	return true; 
}

 

//-->