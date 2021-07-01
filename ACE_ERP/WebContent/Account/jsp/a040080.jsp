<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	회계관리/부가세관리/자재구매매입등록
+ 프로그램 ID: A040080.jsp
+ 기 능 정 의	: 자재구매매입등록 및 전표생성 
+ 최 초 이 력	: 정영식
+ 생 성 일 자 : 2012.04.03 화  
+ 변 경 이 력	:  
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정  자 : 
+ 수 정 일 자 : 
-----------------------------------------------------------------------------
+ 서 블 릿 명	: a040080_s1 , a040080_s2 ,  a040080_s3 , a040080_s4 ,  


------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>매입관리</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">
<!--
//-->
</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">

var g_arrParam	= new Array();

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

    ln_Before();

    //gcem_frdt.text="20090901";
	//gcem_todt.text="20090930";
	//gclx_supbuy.index=0;

	gcem_frdt_0.text=ln_Load_Date('s');
    gcem_todt_0.text=ln_Load_Date('c');
    
  //  gcem_frdt_0.text="20120301";
  //  gcem_todt_0.text="20120331";
    
    txt_deptnm_0.value =gdeptnm;
    txt_empnmk_0.value =gusrnm;
        
    gclx_fdcode_1.index = 1 ; 
    gclx_cocode_1.index =0 ; 
    
    gclx_taxtype_1.index =0;
    
    gclx_taxdiv_1.index=1; //귀속구분 (일반매입)
	
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){
	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();
	
	
	//귀속구분[매입구분]
	gcds_taxdiv.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0014"; 
	gcds_taxdiv.Reset();
	
	
	//부가세종류[매입]
	gcds_taxknd.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_taxknd.Reset();

   //ln_Authority();
}


/******************************************************************************
	Description : 권한조회
******************************************************************************/
function ln_Authority(){
	
	//login자와 부가세 관리자확인---------------------------------------------------------
	gcds_login.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0901&v_str2="+gusrid;
	gcds_login.Reset();

	if( gcds_login.countrow>0){
		hid_login.value="M";
		gs_empnos="";
		gs_deptcds="";
	}else{
		hid_login.value="";	
	
		//로그인자의 권한.-----------------------------------------------------------------------
		gcds_right.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0902&v_str3="+gusrid;
		//prompt(this,gcds_right.DataID);
		gcds_right.Reset();

		for(i=1;i<=gcds_right.countrow;i++){
			if(gcds_right.namevalue(i,"CDREMARK")!=""){   // 개인별권한 가져옴.empno
				gs_empnos=gs_empnos+gcds_right.namevalue(i,"CDREMARK")+"','";
			}else if(gcds_right.namevalue(i,"GBCD")!=""){ // 부서별권한 가져옴.deptcd
				gs_deptcds=gs_deptcds+gcds_right.namevalue(i,"GBCD")+"','"; 
			}
		}

		//맨마지막에 콤마를 떼어난다.
		if(gs_empnos.length>1){
			gs_empnos = gs_empnos.substring(0,gs_empnos.length-3);
		}

		if(gs_deptcds.length>1){
			gs_deptcds = gs_deptcds.substring(0,gs_deptcds.length-3);
		}
		//------------------------------------------------------------------------------------
	} 
}


/******************************************************************************
	Description : 검수 조회
******************************************************************************/
function ln_Query(){
  var strid = gusrid; 
  //strid = '2060001';
  strid = '';
  
  gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040080_s1?v_str1="+gclx_fdcode_1.bindcolval  //지점                
                                                                                                                                +"&v_str2="+strid                   	       //사번               
																																+"&v_str3="+gcem_frdt_0.text			   //검수기간    
																																+"&v_str4="+gcem_todt_0.text			   //검수기간      
																																+"&v_str5="+gcem_vendcd_0.text		   //거래처코드    
																																+"&v_str6="+gcem_vendnm_0.text;	   //거래처명     
   //prompt('', gcds_data.DataID);																																
  gcds_data.Reset();
  gcds_subdata.clearall();
  
  //매입등록 - 전표등록 데이터  초기화 
    gcds_venddata.clearall();
	gcds_taxmst.clearall();
	gcds_taxdtl.clearall();
	
	gcds_slipref.clearall();
	gcds_slipno.clearall();
	
	 ln_Vend_Clear();
	 ln_Slip_Cancel();
	  
	 //작성일자, 공급가액, 세액,합계,적요 
	 //회계일자 
	 //관리항목 
	 gcem_taxdat_1.text="";
	 gcem_taxsum_1.text=0;
	 gcem_taxvatamt_1.text=0;
	 gcem_taxtot_1.text=0;
	 txt_remark_1.value="";
	 
	 gcem_actdat_1.text="";
	 
	 ln_Ref_Clear();
	 
	 
	 
  
  
}

/******************************************************************************
	Description : 검수 상세  조회 
	Parameter :  strCon_no - 품의번호 ,  strDate_cgcd - 상세검수일자 
******************************************************************************/
function ln_SubQuery(strCon_no, strDate_cgcd){
  gcds_subdata.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040080_s2?v_str1="+gclx_fdcode_1.bindcolval  //지점                
                                                                                                                                      +"&v_str2="+strCon_no            	         //품의 번호      
																														       		  +"&v_str3="+strDate_cgcd;			         //상세검수일자 																															
  gcds_subdata.Reset();
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){

  if(ln_Save_Chk()){
  
	  if (gcds_slipmst.IsUpdated) {
			if (confirm("저장 하시겠습니까?")){	
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040080_t1"
				//gctr_data.Parameters = "v_str1="+gusrid;
				
				gctr_data.Parameters = "v_str1="+gf_Auto_Taxnbr_Gb(gclx_fdcode_1.bindcolval,'A')+",v_str2="+gfdcode;
				//prompt('gcds_taxmst',gcds_taxmst.text);
				//prompt('gcds_taxdtl',gcds_taxdtl.text);
				//prompt('gcds_slipmst',gcds_slipmst.text);
				//prompt('gcds_slipdtl',gcds_slipdtl.text);
				//prompt('gcds_banjaerel',gcds_banjae.text);
				//prompt('gcds_banjaemst',gcds_banjaemst.text);
				//prompt('gcds_pmsmch',gcds_pmsmch.text);
				gctr_data.post();
			}	
		}
	}
}

/******************************************************************************
	Description : 체크 ( 저장시점 )
******************************************************************************/
function ln_Save_Chk(){


	//저장시체크 
	//상태값은 체크 안함. 왜냐하면 수정건은 존재하지 않음...무조건 삭제 해야 함. 
	
	//작성일자 체크 
	
	//지점 확인 
	if(gcds_slipmst.namevalue(1,"FDCODE")==""){
		alert("지점을 확인 하십시요");
		return false;
	}
	
	//차변합계 와 대변합계 비교 
	if(gcds_slipmst.namevalue(1,"DETOT")!=gcds_slipmst.namevalue(1,"CRTOT")){
		alert("차변합계와 대변합계 금액을  확인 하십시요");
		return false;
	}
	
	//회계일자 확인
	if(gcds_slipmst.namevalue(1,"ACTDAT")==""){
		alert("회계일자를 확인 하십시요");
		return false;
	}
	
	//자산번호가 존재할 경우 계정은 ??
	
	if(gcem_astnbr_1.text!=""){
		if( gcem_atcode1_1.text=="1220400"||gcem_atcode2_1.text=="1220400"||
		    gcem_atcode1_1.text=="1220600"||gcem_atcode2_1.text=="1220600"||
		    gcem_atcode1_1.text=="1220700"||gcem_atcode2_1.text=="1220700"||
		    gcem_atcode1_1.text=="1222100"||gcem_atcode2_1.text=="1222100"){
		}else{
			alert("자산번호가 필요한 계정이 없습니다.");
			return true;
		}
	}
	
	//계정건별
	for ( var i=1;i<gcds_slipdtl.countrow;i++){
	
	     //계정코드 
		if(gcds_slipdtl.namevalue(i,"ATCODE")==""){
			 gcds_slipdtl.rowposition = i;
			 alert("계정코드를 입력하십시요");
			 return false;
		}
		
		//계정명 
		if(gcds_slipdtl.namevalue(i,"ATKORNAM")==""){
		    gcds_slipdtl.rowposition = i;
			alert("계정명을 입력하십시요");
			return false;
		}
		
		//금액
		if(gcds_slipdtl.namevalue(i,"CHAAMT")==0&&gcds_slipdtl.namevalue(i,"DAEAMT")==0){
			gcds_slipdtl.rowposition = i;
			alert("금액을 입력하십시요");
			return false;
		}
		
		//차변 및 대변 금액 
		if(gcds_slipdtl.namevalue(i,"CHAAMT")!=0&&gcds_slipdtl.namevalue(i,"DAEAMT")!=0){
			gcds_slipdtl.rowposition = i;
			alert("차변금액과 대변금액을 확인 하십시요");
			return false;
		}
		
		//증빙번호는 자동생성 함 
		
		 //거래처 
		if(gcds_slipdtl.namevalue(i,"ARBALDIV02")=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL02")==""||gcds_slipdtl.namevalue(i,"FSRVALNM02")=="")){
			gcds_slipdtl.rowposition = i;
			alert("거래처는 필수항목입니다.");
			return false;
		}
		
			//부서 
		if(gcds_slipdtl.namevalue(i,"ARBALDIV01")=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL01")==""||gcds_slipdtl.namevalue(i,"FSRVALNM01")=="")){
			gcds_slipdtl.rowposition = i;
			alert("부서는 필수항목입니다.");
			return false;
		}

		//적요
		if(gcds_slipdtl.namevalue(i,"REMARK")==""){
			gcds_slipdtl.rowposition = i;
			alert("적요을 입력하십시요");
			return false;
		}
		
		//관리항목체크
		var m=0;
		for(var k=3;k<=9;k++){
			if(gcds_slipdtl.namevalue(i,"ARBALDIV0"+k)=="N"&&(gcds_slipdtl.namevalue(i,"FSREFVAL0"+k)==""||gcds_slipdtl.namevalue(i,"FSRVALNM0"+k)=="")){
				if(gcds_slipdtl.namevalue(i,"FSWRKDIV")!="01"){	
				  m=k;
					tempnm = gcds_slipdtl.namevalue(i,"FSREFNM0"+k);
					alert("관리항목 "+tempnm+"는 필수항목입니다.");
					gcds_slipdtl.rowposition = i;
					return false;
				}
			}
		}//for k
	
		
	    // 반제 데이터 (-)금액  입력 방지 	
		if(gcds_slipdtl.namevalue(i,"BANJAEYN")=="Y"){ //반제
			 if(gcds_slipdtl.namevalue(i,"ATDECR")=="1"){ //차변
					if(gcds_slipdtl.namevalue(i,"CHAAMT")<0){
						alert("해당 반제 발생은 (-) 금액 입력 불가합니다. all ");
						gcds_slipdtl.rowposition = i;
						return false;
					}
			 }else if(gcds_slipdtl.namevalue(i,"ATDECR")=="2"){ //대변
					if(gcds_slipdtl.namevalue(i,"DAEAMT")<0){
						alert("해당 반제 발생은 (-) 금액 입력 불가합니다. all ");
						gcds_slipdtl.rowposition = i;
						return false;
					}
			 }
		}
		
		//금강산 지점 ,개성지점 계정의 경우 자재구매팀일 경우 구매품의 번호체크 
		if(gcds_slipdtl.namevalue(i,"ATCODE")=="1250000"||gcds_slipdtl.namevalue(i,"ATCODE")=="1260000" ){ //금강산지점 개성지점 
			if(txt_deptcd02.value=="C320" ){ //전표작성부서가 구매자재팀일 경우  ***여긴 조직 변경때마다 바꿔줘야함.
				for(var k=3;k<=9;k++){
					if(gcds_slipdtl.namevalue(i,"FSREFCD0"+k)=="1241"){ //구매품의번호
						 if(fn_trim(gcds_slipdtl.namevalue(i,"FSRVALNM0"+k))==""||fn_trim(gcds_slipdtl.namevalue(i,"FSRVALNM0"+k))=="-"||fn_trim(gcds_slipdtl.namevalue(i,"FSRVALNM0"+k))=="0"){
								alert("구매품의번호는 꼭 입력하셔야 합니다.");
								gcds_slipdtl.rowposition = i;
								return false;
						 }else{
						    if(gcds_slipdtl.SysStatus(i)==1){ //신규건만 체크
 								if(!ln_Buy_No_Find(gcds_slipdtl.namevalue(i,"FDCODE"),gcds_slipdtl.namevalue(i,"ATCODE"),gcds_slipdtl.namevalue(i,"FSRVALNM0"+k))){
									 gcds_slipdtl.rowposition = i;
									 return false;
								}
							}
						}
					}
				}//for k                     
			}
		}
		
		
	   //신용카드(공제), 현금영수증(공제)일 경우 선급부가가치세가 기타부가세가 아니면 체크 
		if(gcds_slipdtl.namevalue(i,"DOCUMCD")=="103"||gcds_slipdtl.namevalue(i,"DOCUMCD")=="104" ){ 
			for(var x=3;x<=9;x++){
				if(gcds_slipdtl.namevalue(i,"FSREFCD0"+x)=="0998"){ //선급부가가치세
					if(gcds_slipdtl.namevalue(i,"FSREFVAL0"+x)!="04"){
					    gcds_slipdtl.rowposition = i;
						alert("증빙명이 신용카드(공제), 현금영수증(공제)일 경우 선급부가가치세 항목은 기타부가세입니다. ");
						return false;
					}
				}
			}
		}	
	} //for i 
	return true;
}


/******************************************************************************
	Description : 구매품의번호 확인
	parameter   : fdcode:지점, atcode:계정, fsrefval:구매품의번호값
	ref         :  
******************************************************************************/
function ln_Buy_No_Find(fdcode,atcode,fsrefval){
	gcds_buyno.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_ref_s1?v_str1="+fdcode+"&v_str2="+atcode+"&v_str3="+fsrefval; 
	gcds_buyno.Reset();
	if(gcds_buyno.namevalue(gcds_buyno.rowposition,"CNT")>0){
		alert("동일한 구매품의 번호가 존재합니다. 확인 바랍니다.");
		return false;
	}else{
		return true;
	}
}


/******************************************************************************
	Description : 찾기 - 거래처코드 (검색조건 )
******************************************************************************/
/*
function ln_Popup(){

        var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVAT[0]="VAT";

		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_vendcd.text  = arrParam[0];
			gcem_vendnm.text	= arrParam[1];
		} else {
			gcem_vendcd.text	= "";
			gcem_vendnm.text	= "";
		}
}
*/

/******************************************************************************
	Description : 찾기 - 거래처코드 (매입등록)
******************************************************************************/

function ln_PopupA(){
        var arrVAT	= new Array(); 
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		arrVAT[0]="VAT";

		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrVAT,strPos);

		if (arrResult != null) {
	    	arrParam = arrResult.split(";");
			gcem_vendcd_1.text   = arrParam[0];
			txt_vendnm_1.value = arrParam[1];
			gcem_vendid_1.text  = arrParam[5];
			txt_vddirect_1.value = arrParam[2];
			txt_bsnscnd_1.value = arrParam[3];
			txt_bsnsknd_1.value = arrParam[4];
			txt_address_1.value = "";
			//txt_address_1.value =  arrParam[6];
			
		} else {
			ln_Vend_Clear(); //매입등록 거래처 정보 초기화 
		}
}


/******************************************************************************
	Description : 매입등록 거래처 정보 초기화 
	Parameter :
******************************************************************************/
function ln_Vend_Clear(){
		gcem_vendcd_1.text	 = "";
		txt_vendnm_1.value = "";
		gcem_vendid_1.text  = "";
		txt_vddirect_1.value = "";
		txt_bsnscnd_1.value =  "";
		txt_bsnsknd_1.value =  "";
		txt_address_1.value="";
}



/******************************************************************************
	Description : 찾기 - 계정코드 찾기 
	Parameter : strGB  1 - 계정 코드1,  2- 계정코드2
******************************************************************************/
function ln_PopupB(strGB){
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

    if(strGB=="1") {
		if (result != null) {
			arrResult = result.split(";");
			gcem_atcode1_1.text	=	arrResult[0];
			txt_atkornam1_1.value	=	arrResult[1];
			txt_atdecr1_1.value		=	arrResult[2];
			//hid_atdecr.value        =	arrResult[2];
			
		    hid_banjaeref.value      =  arrResult[4]; //반제단위 
		    
		    //계정코드 선택할 경우 금액 자동으로 가져오기 
		    if(txt_atdecr1_1.value=="1"){
			    gcem_chaamt1_1.text=gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM"); 
			    gcem_daeamt1_1.text=0;
			}else if (txt_atdecr1_1.value=="2"){
				gcem_chaamt1_1.text=0;
			    gcem_daeamt1_1.text=cds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM"); 
			}
		} else {
			gcem_atcode1_1.text	=	"";
			txt_atkornam1_1.value	=	"";
			txt_atdecr1_1.value		=	"";
			//hid_atdecr.value ="";
			hid_banjaeref.value      = "";
			
			//금액 Clear 
			gcem_chaamt1_1.text=0;
			gcem_daeamt1_1.text=0;
			
		}
   }else if (strGB=="2"){
   		if (result != null) {
			arrResult = result.split(";");
			gcem_atcode2_1.text	=	arrResult[0];
			txt_atkornam2_1.value	=	arrResult[1];
			//hid_atdecr.value   =	arrResult[2];
			txt_atdecr2_1.value		=	arrResult[2];
			hid_banjaeref.value      =  arrResult[4]; //반제단위 
		} else {
			gcem_atcode2_1.text	=	"";
			txt_atkornam2_1.value	=	"";
			txt_atdecr2_1.value		=	"";
			//hid_atdecr.value   ="";
			hid_banjaeref.value     = "";
			
			//금액 Clear 
			gcem_chaamt2_1.text=0;
			gcem_daeamt2_1.text=0;
		}
   }
}


/******************************************************************************
	Description : 찾기 -  반제계정코드 찾기 
	Parameter : 
******************************************************************************/
function ln_PopupC(obj){
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	arrParam[1]=eval(obj).value;
	arrParam[2]="ATDEBTYN";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
		gcem_atcode3_1.text	=	arrResult[0];
		txt_atkornam3_1.value	=	arrResult[1];
		txt_atdecr3_1.value		=	arrResult[2];
		
		//hid_atdecr.value   =arrResult[2];
		hid_banjaeref.value      =  arrResult[4]; //반제단위 
	} else {
		gcem_atcode3_1.text	=	"";
		txt_atkornam3_1.value	=	"";
		txt_atdecr3_1.value		=	"";
		hid_banjaeref.value      =  ""; //반제단위 
	}
 }


/******************************************************************************
	Description : DataSet Header 설정
	parameter   :            
******************************************************************************/
function ln_SetDataHeader(){

        gcds_pmsmch.clearAll();
		if (gcds_pmsmch.countrow<1){
			var s_temp = "CON_SID:DECIMAL,CGCD_SID:DECIMAL,DATE_CGCD:STRING,TAXNBR:STRING,FDCODE:STRING,"
			                   + "FSDAT:STRING,FSNBR:STRING,H_ASTNBR:STRING";	
			gcds_pmsmch.SetDataHeader(s_temp);
		}

    
        gcds_taxmst.clearAll();
  
		if (gcds_taxmst.countrow<1){
			var s_temp = "TAXNBR:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,TAXIODIV:STRING,TAXDIV:STRING,"	
          					  + "TAXKND:STRING,VEND_CD:STRING,TAXDAT:STRING,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,"
		   					  + "TAXTOT:DECIMAL,REMARK:STRING,TAXCDNBR:STRING,ATCODE:STRING,TAXPRTYN:STRING,"
							  + "TAXCNT:DECIMAL,LASTPRT:STRING,TAXTYPE:STRING,FSDAT:STRING,FSNBR:STRING,"
							  + "TAXKIDIV:STRING,FDCODE:STRING,WORKTYPE:STRING,REPORT:STRING,WRDT:STRING,"
							  + "WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,SSNBR:STRING,SEQ:DECIMAL,"
							  + "CONVERSATION_ID:STRING,SUPBUY_TYPE:STRING,DIRECTION:STRING,GUBUN:STRING,AMEND_CODE:STRING,"
							  + "AMEND_REMARK:STRING,EXTCHK:STRING,REMARK2:STRING,REMARK3:STRING,S_BIZPLACE:STRING,"
							  + "B_BIZPLACE:STRING";	 
			gcds_taxmst.SetDataHeader(s_temp);
		}
		
		gcds_taxdtl.clearAll();
		if (gcds_taxdtl.countrow<1){
			var s_temp = "MMDD:STRING,TAXNBR:STRING,TAXSEQ:STRING,TAXPDTNAM:STRING,TAXSTD:STRING,"	
          					  + "TAXQTY:DECIMAL,TAXPRIC:DECIMAL,TAXSUM:DECIMAL,TAXVATAMT:DECIMAL,BIGO:STRING,"   	
          					   + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";			
			gcds_taxdtl.SetDataHeader(s_temp);
		}
}

/******************************************************************************
	Description : 매입등록 
	parameter   :            
******************************************************************************/
function ln_Tax_A_Create(){

 	//체크사항 
 	//1. 체크 항목 건의 거래처가 서로  다른 경우  하나의 매입 세금계산서 안됨 .
 	//2. 동일검수건에 대해서 매입 세금계산서 중복 발행 되면 안됨 .
 	
 	if (!ln_Tax_A_Chk()) return ; 
 	
 	//거래처정보 FIND 
 	ln_Vend_Info_Find(ln_VendCD());
 	
 	//매입등록 MST 설정  
    ln_SetDataHeader();
    
 	gcds_taxmst.Addrow();
 	gcds_taxdtl.Addrow();
 	
 	ln_Tpu_Data_Setting();
 	
 	ln_Tax_Data_Setting();
 	
 	//prompt('',gcds_taxmst.text);
 
    //매입등록 DTL  설정
}


/******************************************************************************
	Description : 매입생성시 체크   
	parameter   :            
******************************************************************************/
function ln_Tax_A_Chk(){

	var strGB="F";	
	var intCnt=0;
	var strBefVendCd="";
	var strAftVendCd="";
	//선택항목이 없을 경우
	
	for (var i =1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			strGB="T";
			intCnt+=1;
		}
	}
	
	if(strGB=="F"){
		alert("선택된 항목이 없습니다.");
		return false;
	}
	
	//선택항목이 2개 이상일 경우 거래처가 상이 할 경우
	if(intCnt>1){
		intCnt = 0; 	
		for (var i =1;i<=gcds_data.countrow;i++){
			if(gcds_data.namevalue(i,"CHK")=="T"){
			    intCnt+=1;
			    if(intCnt==1){
					strBefVendCd = gcds_data.namevalue(i,"VENDCD")
				}else{
					strAftVendCd = gcds_data.namevalue(i,"VENDCD")
					if(strBefVendCd!=strAftVendCd){
						alert("거래처가 동일하지 않습니다.");
						return false;
					}
				}
			}
		}
	}
	
	
	return true;
}

/******************************************************************************
	Description : DATA 설정  
	parameter   :            
******************************************************************************/
function ln_Tpu_Data_Setting(){  
	for(var i =1; i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			gcds_pmsmch.Addrow();
			gcds_pmsmch.namevalue(gcds_pmsmch.rowposition,"CON_SID")   = gcds_data.namevalue( i,"CON_SID");
			gcds_pmsmch.namevalue(gcds_pmsmch.rowposition,"CGCD_SID")   = gcds_data.namevalue( i,"CGCD_SID");
			gcds_pmsmch.namevalue(gcds_pmsmch.rowposition,"DATE_CGCD")=  gcds_data.namevalue( i,"DATE_CGCD");
			gcds_pmsmch.namevalue(gcds_pmsmch.rowposition,"H_ASTNBR")=  gcem_astnbr_1.text;     // 대표자산번호 
		}
	}
}


/******************************************************************************
	Description : DATA 설정  
	parameter   :            
******************************************************************************/
function ln_Tax_Data_Setting(){  

    var m_row = gcds_taxmst.rowposition;
    var d_row = gcds_taxdtl.rowposition;
    
    //세금계산서 MST 
	gcds_taxmst.namevalue(m_row,"COCODE")= gclx_cocode_1.bindcolval;
	gcds_taxmst.namevalue(m_row,"DEPTCD")= gdeptcd;
	gcds_taxmst.namevalue(m_row,"EMPNO")= gusrid;
	gcds_taxmst.namevalue(m_row,"TAXIODIV")= "A";
	gcds_taxmst.namevalue(m_row,"TAXDIV")= gclx_taxdiv_1.bindcolval;
	gcds_taxmst.namevalue(m_row,"TAXKND")= gclx_taxknd_1.bindcolval;
	gcds_taxmst.namevalue(m_row,"VEND_CD")= gcem_vendcd_1.text;
	gcds_taxmst.namevalue(m_row,"TAXDAT")= gcem_taxdat_1.text;
	gcds_taxmst.namevalue(m_row,"TAXSUM")= gcem_taxsum_1.text;
	gcds_taxmst.namevalue(m_row,"TAXVATAMT")= gcem_taxvatamt_1.text;
	gcds_taxmst.namevalue(m_row,"TAXTOT")= gcem_taxtot_1.text;
	gcds_taxmst.namevalue(m_row,"REMARK")= txt_remark_1.value;
	gcds_taxmst.namevalue(m_row,"TAXCDNBR")= "";
	gcds_taxmst.namevalue(m_row,"ATCODE")= "";
	gcds_taxmst.namevalue(m_row,"TAXPRTYN")= "N";
	gcds_taxmst.namevalue(m_row,"TAXCNT")= 0 ; 
	gcds_taxmst.namevalue(m_row,"LASTPRT")= "";
	gcds_taxmst.namevalue(m_row,"TAXTYPE")= "";
	gcds_taxmst.namevalue(m_row,"FSDAT")= "";
	gcds_taxmst.namevalue(m_row,"FSNBR")= "";
	gcds_taxmst.namevalue(m_row,"TAXKIDIV")= "";
	gcds_taxmst.namevalue(m_row,"FDCODE")= gclx_fdcode_1.bindcolval;
	gcds_taxmst.namevalue(m_row,"WORKTYPE")= "A";
	gcds_taxmst.namevalue(m_row,"REPORT")= "";
	gcds_taxmst.namevalue(m_row,"WRDT")= ln_Load_Date('c');
	gcds_taxmst.namevalue(m_row,"WRID")=  "9999999";
	gcds_taxmst.namevalue(m_row,"UPDT")= ln_Load_Date('c');
	gcds_taxmst.namevalue(m_row,"UPID")=   gusrid;
	gcds_taxmst.namevalue(m_row,"SSDAT")= "";
	gcds_taxmst.namevalue(m_row,"SSNBR")= "";
	gcds_taxmst.namevalue(m_row,"SEQ")= 0;
	gcds_taxmst.namevalue(m_row,"CONVERSATION_ID")= "";
	gcds_taxmst.namevalue(m_row,"SUPBUY_TYPE")= "";
	gcds_taxmst.namevalue(m_row,"DIRECTION")="";
	gcds_taxmst.namevalue(m_row,"GUBUN")= gclx_taxtype_1.bindcolval;
	gcds_taxmst.namevalue(m_row,"AMEND_CODE")= "";
	gcds_taxmst.namevalue(m_row,"AMEND_REMARK")= "";
	gcds_taxmst.namevalue(m_row,"EXTCHK")= "";
	gcds_taxmst.namevalue(m_row,"REMARK2")= "";
	gcds_taxmst.namevalue(m_row,"REMARK3")= "";
	gcds_taxmst.namevalue(m_row,"S_BIZPLACE")=""; 
	gcds_taxmst.namevalue(m_row,"B_BIZPLACE")="";

    //세금계산서DTL	
	gcds_taxdtl.namevalue(d_row,"MMDD")=gcem_taxdat_1.text.substring(4,8);
	
	gcds_taxdtl.namevalue(d_row,"TAXSEQ")="001";
	gcds_taxdtl.namevalue(d_row,"TAXPDTNAM")="";
	gcds_taxdtl.namevalue(d_row,"TAXSTD")="";
	gcds_taxdtl.namevalue(d_row,"TAXQTY")="";
	gcds_taxdtl.namevalue(d_row,"TAXPRIC")="";
	gcds_taxdtl.namevalue(d_row,"TAXSUM")="";
	gcds_taxdtl.namevalue(d_row,"TAXVATAMT")="";	

}


/******************************************************************************
	Description : 거래처 정보 찾기  
	parameter   :            
******************************************************************************/
function ln_Vend_Info_Find(strVendcd){
	gcds_venddata.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040080_s3?v_str1="+strVendcd;  //거래처코드                                                                                                                                																														
    //prompt('',gcds_venddata.DataID );
    gcds_venddata.Reset();
}


/******************************************************************************
	Description : 거래처코드  
	parameter   :            
******************************************************************************/
function ln_VendCD(){
	for(i=1;i<=gcds_data.countrow;i++){
		if(gcds_data.namevalue(i,"CHK")=="T"){
			return gcds_data.namevalue(i,"VEND_CD");
		}
	}	
}


/******************************************************************************
	Description : 전표발행취소  
	parameter   :            
******************************************************************************/
function ln_Slip_Cancel(){
	gcds_slipmst.clearAll();
	gcds_slipdtl.clearAll();
	
	//계정코드1 
	ln_Atcode_Clear('gcem_atcode1_1','txt_atkornam1_1');
	gcem_chaamt1_1.text=0;
    gcem_daeamt1_1.text=0; 
		
	//계정코드2
	ln_Atcode_Clear('gcem_atcode2_1','txt_atkornam2_1');
	gcem_chaamt2_1.text=0;
    gcem_daeamt2_1.text=0;
	
	//반제정산
	ln_Atcode_Clear('gcem_atcode3_1','txt_atkornam3_1');
	ln_Popup_Repay_Cancel();
	
	//자산번호
	gcem_astnbr_1.text="";
}

/******************************************************************************
	Description : 계정초기화   
	parameter   :            
******************************************************************************/
function ln_Atcode_Clear(obj_text1, obj_val2 ){
	eval(obj_text1).text="";
	eval(obj_val2).value="";
}


/******************************************************************************
	Description : 계정 및 관리항목 생성 
	parameter   :            
******************************************************************************/
function ln_Slip_Create(){

    //필수항목 체크 
    if(!ln_Slip_Chk()) return;
    
    //1.회계일자 
    //2.계정1, 계정2 
    //3.거래처 
    //4.지점 
    //5.공급가액, 부가세액 
    //6.반제정산 일경우 정산내역 존재 
    //7.정산내역 금액합과 반제정산 금액 비교 
    //8.전표등록에서 금액이 차변 / 대변 동시에 존재하지 못하게 함. 
    
    // 기본설정 
    //공급가액 -> 계정코드 1
    //공급가액+부가세액 --> 계정코드 2
        
    gcds_slipmst.clearall();
    gcds_slipdtl.clearall();
    
    ln_Slip_SetDataHeader('slipmst');   
    ln_Slip_SetDataHeader('slipdtl');
    
    
    ln_Slipdtl_Settting();
    ln_Slipmst_Settting();
    
}

/******************************************************************************
	Description : 전표발행시 체크 
	parameter   :            
******************************************************************************/
function ln_Slip_Chk(){

    //작성일자
    if (gcem_taxdat_1.text==""){
    	alert("작성일자는 필수항목입니다.");
    	return false;
    }
    //적요
     if (txt_remark_1.value==""){
    	alert("적요는 필수항목입니다.");
    	return false;
    }
   
    //품목 
    if (gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM")=="") {
    	alert("품목은 필수항목입니다. ");
    	return false;
    }
   
    //공급가액
     if (gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXPDTNAM")=="") {
    	alert("공급가액은 필수입니다. ");
    	return false;
    }
   

	if(gcem_actdat_1.text==""){
		alert("회계일자를 입력하십시요.");
		return false;
	}
	
	if(gcem_atcode1_1.text==""){
		alert("계정코드1를 입력하십시요.");
		return false;
	}
	
	//계정코드 금액 체크 
	if(gcem_chaamt1_1.text==0&&gcem_daeamt1_1.text==0){
		alert("계정코드1의 금액을 입력하십시요.");
		return false;
	}
			
	if(gcem_atcode2_1.text==""){
		alert("계정코드2를 입력하십시요.");
		return false;
	}
		
	//계정코드 금액 체크 
	if(gcem_chaamt2_1.text==0&&gcem_daeamt2_1.text==0){
		alert("계정코드2의 금액을 입력하십시요.");
		return false;
	}
	
	if(gcem_vendcd_1.text==""){
		alert("거래처를 입력하십시요");
		return false;
	}
	
	if(gclx_fdcode_1.bindcolval==""){
		alert("지점을 입력하십시요");
		return false;
	}
	
	if(gcem_taxsum_1.text==""||gcem_taxsum_1.text==0){
		alert("공급가액을  입력하십시요");
		return false;
	}
	
	if(gcem_atcode3_1.text!=""){ // 반제 계정이 존재하는 경우 
		if(txt_atdecr3_1.value =="1"){//차변 계정 일경우 
			if(gcem_daeamt3_1.text==0){
				alert("반제 정산금액을 입력하십시요1.");
				return false;
			}else{
				if(gcds_banjae.countRow==0){
					alert("반제 정산 내역이 존재하지 않습니다.");
					return false;
				}
				
				if(gcds_banjae.sum(14,0,0)!=(gcem_daeamt3_1.text)){
					alert("반제 정산 내역 금액이 틀립니다.");
					return false;
				}
			}			
		}else if(txt_atdecr3_1.value =="2"){ // 대변 계정일 경우 
			if(gcem_chaamt3_1.text==0){
				alert("반제 정산금액을 입력하십시요2.");
				return false;
			}else{
				if(gcds_banjae.countRow==0){
					alert("반제 정산 내역이 존재하지 않습니다.");
					return false;
				}
				
				if(gcds_banjae.sum(13,0,0)!=(gcem_chaamt3_1.text)){
					alert("반제 정산 내역 금액이 틀립니다.");
					return false;
				}
			}	
		}	
	}

    //6.반제정산 일경우 정산내역 존재 
    //7.정산내역 금액합과 반제정산 금액 비교 
    //8.전표등록에서 금액이 차변 / 대변 동시에 존재하지 못하게 함. 
	
	return true;
}

/******************************************************************************
	Description : 전표mst 데이터 설정 
	parameter   :            
******************************************************************************/
function ln_Slipmst_Settting(){
    var srow = 0;
	gcds_slipmst.addrow();
	
	srow = gcds_slipmst.rowposition; 
	
	gcds_slipmst.namevalue(srow,"FDCODE")=  gcds_slipdtl.namevalue(1, "FDCODE" );
	gcds_slipmst.namevalue(srow,"FSDAT") =  gcds_slipdtl.namevalue(1, "FSDAT" );
	gcds_slipmst.namevalue(srow,"FSNBR")="000000";
	gcds_slipmst.namevalue(srow,"FSKND")= "A";         //자동 - 구매   
	gcds_slipmst.namevalue(srow,"FSWRTDAT")= ln_Load_Date('c');
	gcds_slipmst.namevalue(srow,"COCODE")=gclx_cocode_1.bindcolval;
	gcds_slipmst.namevalue(srow,"DEPTCD")= gdeptcd;
	gcds_slipmst.namevalue(srow,"EMPNO")=gusrid;
	gcds_slipmst.namevalue(srow,"DIVCD")= "";
	gcds_slipmst.namevalue(srow,"FSAMT")= gcds_slipdtl.Sum(9,0,0);   //차변 
	gcds_slipmst.namevalue(srow,"FSVAT")= 0 ;
	gcds_slipmst.namevalue(srow,"DETOT")= gcds_slipdtl.Sum(9,0,0);   //차변 
	gcds_slipmst.namevalue(srow,"CRTOT")= gcds_slipdtl.Sum(10,0,0); //대변 
	gcds_slipmst.namevalue(srow,"REMARK")=  gcds_slipdtl.namevalue(1,"REMARK"); //대변 
	gcds_slipmst.namevalue(srow,"SGNDAT")= "";
	gcds_slipmst.namevalue(srow,"FSSTAT")= "N";
	gcds_slipmst.namevalue(srow,"ACTDAT")= gcem_actdat_1.text;
	gcds_slipmst.namevalue(srow,"SSDAT")= "";
	gcds_slipmst.namevalue(srow,"SSNBR")= "";
	gcds_slipmst.namevalue(srow,"WRDT")=  ln_Load_Date('c');
	gcds_slipmst.namevalue(srow,"WRID")= gusrid;

}


/******************************************************************************
	Description : 전표dlt 데이터 설정  
	parameter   :            
******************************************************************************/
function ln_Slipdtl_Settting(){

    var  i=0;
       
    i+=1;
	//1.계정코드1
    ln_Popup_Atcode('1', gcem_atcode1_1.text, txt_atkornam1_1.value, i );
    
    
    //과세 
    if(gclx_taxknd_1.bindcolval=="1"){
	    i+=1;
	    //2.과세 - 선급부가세
	    ln_Popup_Atcode('2', '1112300','선급부가가치세', i);
	}
	    
    i+=1;
    //3.계정코드2
    ln_Popup_Atcode('3', gcem_atcode2_1.text, txt_atkornam2_1.value,i);
    
    //반제 계정이 존재할 경우 
    if (gcem_atcode3_1.text!=""){
    	 i+=1;
    	ln_Popup_Atcode('4', gcem_atcode3_1.text, txt_atkornam3_1.value,i);
    }
    
}


/******************************************************************************
	Description : 계정 및 관리항목 생성 
	                   : 금액 자동 설정 
	parameter   :            
******************************************************************************/
function ln_Popup_Atcode(strGB, strAtcode,strAtkornam,strFsnum){
   var strChaamt=0; //차변 
   var strDaeamt=0; //대변 
   var strFsseq ="";
    
    //strFsnum = "00"+strFsnum;
    strFsseq  =  ln_Seqno_Format(strFsnum,5);
    strFsnum =  ln_Seqno_Format(strFsnum,3);
    
    gcds_slipdtl.addrow();
    
    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FDCODE" ) = gclx_fdcode_1.bindcolval;
    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSDAT" ) = "A"+ln_Load_Date('c'); 
    //gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSDAT" ) = "A20121226"; 
    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNBR" ) = "000000"; 
    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSSEQ" ) = strFsseq; 
    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATCODE" ) = strAtcode;   
    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "ATKORNAM" ) = strAtkornam; 
   
    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "REMARK" ) = txt_remark_1.value;
   
	if (strGB==1){
		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "CHAAMT" )= gcem_chaamt1_1.text; 
	    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DAEAMT" )= gcem_daeamt1_1.text; 
	   // hid_atdecr.value = txt_atdecr1_1.text;
	}else if (strGB==2){
		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "CHAAMT" )= gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT"); 
	    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DAEAMT" )= 0; 
	   // hid_atdecr.value = txt_atdecr1_1.text;
	}else if (strGB==3){
		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "CHAAMT" )=gcem_chaamt2_1.text; 
		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DAEAMT" )=gcem_daeamt2_1.text; 
	}else if (strGB==4){
		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "CHAAMT" )=gcem_chaamt3_1.text;
		gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DAEAMT" )=gcem_daeamt3_1.text;
	}

    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSWRKDIV" )="01"; //예산 미적용 

    //과세구분으로 인한 증빙코드 찾기 
    //과세 , 영세, 불공 --> 세금계산서 101
    if (gclx_taxknd_1.bindcolval =="1"||gclx_taxknd_1.bindcolval =="2"||gclx_taxknd_1.bindcolval =="4"){
    	gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUMCD" )="101";
    }else if (gclx_taxknd_1.bindcolval =="3"){ //면세 -> 계산서 
        gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUMCD" )="102";
    }else if (gclx_taxknd_1.bindcolval =="7"){ //현금영수증 -> 현금영수증(공제) 
        gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUMCD" )="104";
    }else if (gclx_taxknd_1.bindcolval =="8"){ //신용카드 -> 신용카드(공제) 
    	gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "DOCUMCD" )="103";
    }
	
	 gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSNUM" ) = strFsnum;  
	 gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFCD01" )= "0002"; 
	 	
    //거래처 
    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSREFVAL02" )  = gcem_vendcd_1.text; 
    gcds_slipdtl.namevalue(gcds_slipdtl.rowposition, "FSRVALNM02" ) = txt_vendnm_1.value;   
      
    //계정 관리항목
    gcds_actcode.DataID="/servlet/Account.actcode_s1f?v_str1="+strAtcode+"&v_str2='Y'&v_str3="+gclx_fdcode_1.bindcolval;
    //prompt("",gcds_actcode.DataID);                                                   
	gcds_actcode.Reset();
	
    if (gcds_actcode.Countrow>0){
    	 //ln_Ref_Data_Clear();         //관리항목 Clear();
        ln_Ref_Find();     //관리항목찾기	
    }	
}

/******************************************************************************
	Description :  관리항목 데이타 Clear();
	parameter   :  
******************************************************************************/
function ln_Ref_Data_Clear(){

}

/******************************************************************************
	Description :  계정 관리항목찾기
	parameter   :  
******************************************************************************/
function ln_Ref_Find(){

    //alert("관리항목 찾기 ")
   
    //거래처  
    eval("txt_fsrefcd02").value  = gcds_actcode.namevalue(gcds_actcode.rowposition,"CDCODE2");
	eval("txt_fsrefnm02").value = gcds_actcode.namevalue(gcds_actcode.rowposition,"CDNAM2");
    eval("txt_type02").value = gcds_actcode.namevalue(gcds_actcode.rowposition,"TYPE2");
	eval("txt_arbaldiv02").value = gcds_actcode.namevalue(gcds_actcode.rowposition,"ARBALDIV2");
    
    //부서    
    eval("txt_fsrefcd01").value  = gcds_actcode.namevalue(gcds_actcode.rowposition,"CDCODE1");
	eval("txt_fsrefnm01").value = gcds_actcode.namevalue(gcds_actcode.rowposition,"CDNAM1");
    eval("txt_type01").value = gcds_actcode.namevalue(gcds_actcode.rowposition,"TYPE1");
	eval("txt_arbaldiv01").value = gcds_actcode.namevalue(gcds_actcode.rowposition,"ARBALDIV1");
    
    //부서 외 관리항목  
	for (var k=3;k<=9;k++){
		eval("txt_fsrefcd0"+k).value  = gcds_actcode.namevalue(gcds_actcode.rowposition,"CDCODE"+k);
	    eval("txt_fsrefnm0"+k).value = gcds_actcode.namevalue(gcds_actcode.rowposition,"CDNAM"+k);
	    //eval("ttxt_fsrefseq0"+k).value = gcds_actcode.namevalue(gcds_actcode.rowposition,"TYPE"+k);
	    eval("txt_type0"+k).value = gcds_actcode.namevalue(gcds_actcode.rowposition,"TYPE"+k);
	    eval("txt_arbaldiv0"+k).value = gcds_actcode.namevalue(gcds_actcode.rowposition,"ARBALDIV"+k);
	    
	    //관리항목 자동설정////////////////////////////////////////////////////// 
	    if(eval("txt_fsrefcd0"+k).value=="1135" ){//자산코드번호 
	    	eval("txt_fsrefval0"+k).value =gcem_astnbr_1.text;
	    	eval("gcem_fsrvalnm0"+k).text = gcem_astnbr_1.text;
	    }
	    
	    if(eval("txt_fsrefcd0"+k).value=="0970" ){ //계산서일자 
	    	eval("txt_fsrefval0"+k).value =gcem_taxdat_1.text;
	    	eval("gcem_fsrvalnm0"+k).text = gcem_taxdat_1.text;
	    }
	    
	    if(eval("txt_fsrefcd0"+k).value=="1011" ){ //외상매입금   
	    	eval("txt_fsrefval0"+k).value ="02";
	    	eval("gcem_fsrvalnm0"+k).text = "일반업체";
	    }
	    
	    if(eval("txt_fsrefcd0"+k).value=="1043" ){ //통화명 
	    	eval("txt_fsrefval0"+k).value ="01";
	    	eval("gcem_fsrvalnm0"+k).text = "WON";
	    }
	    
	     if(eval("txt_fsrefcd0"+k).value=="1045" ){ //외화금액  
	    	eval("txt_fsrefval0"+k).value ="0";
	    	eval("gcem_fsrvalnm0"+k).text = "0";
	    }
	    
	    //////////////////////////////////////////////////////////////////////////
	}
	
	hid_atdecr.value = gcds_actcode.namevalue(gcds_actcode.rowposition,"ATDECR");
	
	//반제계정일 경우 계정정보 저장  
	if (gcds_actcode.namevalue(gcds_actcode.rowposition,"ATDEBTYN")=="Y"){
	   hid_banjaeref.value = gcds_actcode.namevalue(gcds_actcode.rowposition,"BANJAEREF"); //반제단위 
	   hid_banjaeyn.value = gcds_actcode.namevalue(gcds_actcode.rowposition,"ATDEBTYN");  //반제
	}else{
	   hid_banjaeyn.value ="";
	   hid_banjaeref.value ="";//반제 단위 
	} 
	
	//alert("BANJAEREF::"+gcds_actcode.namevalue(gcds_actcode.rowposition,"BANJAEREF"))
   
    //반제 ref   

	/*
		txt_fsrefcd02.value = "0002";
	    txt_fsrefnm02.value = "0002";
	    txt_fsrefseq02.value = "0002";
	    txt_type02.value = "0002";
	    txt_arbaldiv02.value = "0002"; 
	       
	    gcem_fsrvalnm02.text="";
	    txt_fsrefval02.value="";
     */
     
     //자산코드번호가 존재할 경우 자산번호를 자동으로 가져옴 
     
}


/******************************************************************************
	Description :  계정 관리항목 초기화 
	parameter   :  
******************************************************************************/
function ln_Ref_Clear(){
    
    //관리항목  
	for (var k=1;k<=9;k++){
		eval("txt_fsrefcd0"+k).value  ="";
	    eval("txt_fsrefnm0"+k).value = "";
	    eval("txt_type0"+k).value = "";
	    eval("txt_arbaldiv0"+k).value = "";
	    
	    if(k!=2){ //거래처가 아닌 경우 
	    	eval("txt_fsrefval0"+k).value ="";
	    	eval("gcem_fsrvalnm0"+k).text = "";
	    }
	}
	
	hid_atdecr.value = "";
	hid_banjaeyn.value ="";
	hid_banjaeref.value ="";//반제 단위 
	
	gcem_fsnum.text ="";
	
	
	//순번 
	//관리항목 값 
	
}


/******************************************************************************
	Description : 관리항목 찾기
	parameter   : p1 - 관리항목 구분값
	                     obj - object명 
******************************************************************************/
function ln_Ref_Popup(p1,obj,strkeycode){

    var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var strposition="";
	var strpo2="";
	var strpo3="";
	var strPopGubun ="";
	var strPo="";                  // 관리항목위치
	var divcd="";
	var intp=0;                      //관리항목 위치
	
	
	/////////////////////////////////////////////////////
	// 관리항목 구분자  ( 거래처 제외 ) 
	/////////////////////////////////////////////////////
		
	arrParam[0] = eval("txt_fsrefcd"+p1).value;        //관리항목 구분코드  
	arrParam[1] = eval("gcem_fsrvalnm"+p1).text;   //관리항목 값 
		
	//alert("arrParam[0]::"+arrParam[0]);
		
	//부서 
	if (arrParam[0]=="0002"){
		arrParam[2]="A";
		arrParam[3]="";
		arrParam[4]=gclx_fdcode_1.bindcolval;

		//2007.10.08.회계일자 추가(부서 CHGYM 관련)
	  var stractdat = gcem_taxdat_1.text;
	  arrParam[5]=stractdat.substring(0,6);
	
	   strURL = "./hcdept_popup.jsp";
	   strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";	   
	}else if (arrParam[0]=="0029"){
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";	
	}else if (arrParam[0]=="0003"){//예산부서 
		arrParam[2]=hid_bgtdiv.value;
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if (arrParam[0]=="0030"){ //원가
		arrParam[2]="";
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if (arrParam[0]=="1113"){//카드번호 
		 arrParam[2]="";
	     for(p=3;p<=9;p++){
				if(eval("txt_fsrefcd0"+p).value=="1134"){
					arrParam[2]=eval("txt_fsrefval0"+p).value;
					break;
				}
		 }
		 strURL = "./commdtil_popup_card.jsp";
		 strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if (arrParam[0]=="1135"){//자산코드번호 
		arrParam[1]= gclx_fdcode_1.bindcolval;   //지점
		arrParam[2]= gcds_slipdtl.namevalue(gcds_slipdtl.rowposition,"ATCODE");         //계정코드
		strURL = "./commdtil_popup_astnbr.jsp";
		strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else{
		 if(arrParam[0]=="0997")arrParam[2]="A";
		 strURL = "./commdtil_popup_ifrm.jsp";
		 strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";	
	}

	result = showModalDialog(strURL,arrParam,strPos);	

	if(result != null) {
		arrResult = result.split(";");
		eval("txt_fsrefval"+p1).value =arrResult[0];
		eval("gcem_fsrvalnm"+p1).text =arrResult[1];
		
		if (arrParam[0]=="0002"){
			hid_divcd.value = arrResult[3]; //본부
		}
    }	
}


/******************************************************************************
	Description : 반제 
	parameter   :            
******************************************************************************/
function ln_Popup_Repay(){
   
    var row = gcds_slipdtl.rowposition;
    var result="";
    var arrResult	= new Array();
	var strURL;	
	var strPos;
	var strseq="000";
	var strbanjaeref ="";
	var strbanjaerefval ="";
	var strbanjaerefnm = "";
	
	//반제단위 관리항목값을 저장함.
	_out2:
	 for(k=1;k<=9;k++){
			if(gcds_slipdtl.namevalue(row,"FSREFCD0"+k)==gcds_slipdtl.namevalue(row,"BANJAEREF")){
				 strbanjaeref = gcds_slipdtl.namevalue(row,"BANJAEREF");
				 break _out2;
			}
	 }//k	
	
    g_arrParam[0]=gcem_atcode3_1.text;                       //계정코드
	g_arrParam[1]=txt_atkornam3_1.value;                      //계정명
	g_arrParam[2]=gcem_vendcd_1.text;                        //거래처코드
	g_arrParam[3]=txt_vendnm_1.value;                          //거래처명
	g_arrParam[4]=gclx_fdcode_1.bindcolval;				  //반제전표 FDCODE
	g_arrParam[5]="A"+gcem_actdat_1.text;	                  //반제전표 FSDAT
	g_arrParam[6]="000000";				                		      //반제전표 FSNBR
	
    //과세이면 004, 과세 아니면 003
    
    //선급부가가치세 존재 하는 경우 , 과세, 불공, 현금영수증, 신용카드 
    if (gclx_taxknd_1.bindcolval =="1"||gclx_taxknd_1.bindcolval =="4"||gclx_taxknd_1.bindcolval =="7"||gclx_taxknd_1.bindcolval =="8"){
    	strseq="00004";
    }else if ( gclx_taxknd_1.bindcolval =="2"||gclx_taxknd_1.bindcolval =="3"){ //영세, 면세 일경우 선급부가가치세 미존재 
    	strseq="00003";
    }
    
	g_arrParam[7]=strseq;					                          //전표행번호 seq
	g_arrParam[8]=strbanjaeref;                                     //반제단위 관리항목 
	g_arrParam[9]=strbanjaerefval;                                 //반제단위값
	g_arrParam[10]=strbanjaerefnm;                               //반제단위값 명칭

	strURL = "./repay_popup_A.jsp";
	strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,window,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		if(arrResult[0]!=0){         //차변이 0이 아닐 경우 대변 금액
			gcem_daeamt3_1.text=arrResult[0];
		}else if(arrResult[1]!=0){   //대변이 0이 아닐 경우 차변 금액
			gcem_chaamt3_1.text=arrResult[1];
		}
	}
}

/******************************************************************************
	Description : 반제 
	parameter   :            
******************************************************************************/
function ln_Popup_Repay_Cancel(){
    gcem_chaamt3_1.text =0 ; 
	gcem_daeamt3_1.text =0 ; 
	gcds_banjae.clearAll();
	gcds_banjaemst.clearAll();
}

/******************************************************************************
	Description : 자산번호  
	parameter   :            
******************************************************************************/
/*
function ln_Popup_Astnbr(){
   
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

    arrParam[1]=gclx_fdcode_1.bindcolval;   //지점
	//arrParam[2]=gcem_atcode02.text;         //계정코드
	arrParam[2]="";
	strURL = "./commdtil_popup_astnbr.jsp";
	strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	
	result = showModalDialog(strURL,arrParam,strPos);	
 
    if(result != null) {
		 arrResult = result.split(";");
		 gcem_astnbr_1.text =arrResult[0];
    }
} 
*/


/******************************************************************************
	Description : DataSet Header 설정
	parameter   :            
******************************************************************************/
function ln_Slip_SetDataHeader(strParam){

 	if (gcds_slipmst.countrow<1){  
		  var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSKND:STRING,FSWRTDAT:STRING,"
							 + "COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSAMT:DECIAML,"
							 + "FSVAT:DECIAML,DETOT:DECIAML,CRTOT:DECIAML,REMARK:STRING,"
							 + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
							 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
		gcds_slipmst.SetDataHeader(s_temp);
	}


   if(strParam=="slipdtl"){
		if (gcds_slipdtl.countrow<1){
		
			 var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
							   + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
								+ "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
								+ "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09:STRING,"
								+ "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								+ "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								+ "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								+ "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
								+ "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
								+ "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
								+ "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
								+ "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"
								+ "TYPE01:STRING,TYPE02:STRING,TYPE03:STRING,TYPE04:STRING,TYPE05:STRING,"
								+ "TYPE06:STRING,TYPE07:STRING,TYPE08:STRING,TYPE09:STRING,"
								+ "ARBALDIV01:STRING,ARBALDIV02:STRING,ARBALDIV03:STRING,ARBALDIV04:STRING,ARBALDIV05:STRING,"
								+ "ARBALDIV06:STRING,ARBALDIV07:STRING,ARBALDIV08:STRING,ARBALDIV09:STRING,"
								+ "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
								+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
								+ "BANJAEYN:STRING,FSSTAT:STRING,DOCUVAL:STRING,FSNUM:STRING,DIVCD:STRING,"
								+ "BGTDIV:STRING,FUNDDIV:STRING,BANJAEREF:STRING,LASTREF:STRING,BANJAEMOD:STRING,ATCURTYPE:STRING";
			gcds_slipdtl.SetDataHeader(s_temp);
		
		   /**
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,ATKORNAM:STRING,"
	 						  + "ATDECR:STRING,FSAMT:DECIAML,ACCNNBR:STRING,BANJAEYN:STRING,PRIMCOST:STRING,"
	 						  + "DOCUMCD:STRING,DOCUVAL:STRING,FSWRKDIV:STRING,REMARK:STRING,FSNUM:STRING,"
	 						  + "DIVCD:STRING,BGTDIV:STRING,SSDAT:STRING,SSNBR:STRING,"
							  + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING ";
			gcds_slipdtl.SetDataHeader(s_temp);
			**/
		}
	}


    /*
    if(strParam=="slipdtl"){
		if (gcds_slipdtl.countrow<1){
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
	 						  + "ATDECR:STRING,FSAMT:DECIAML,ACCNNBR:STRING,BANJAEYN:STRING,PRIMCOST:STRING,"
	 						  + "DOCUMCD:STRING,DOCUVAL:STRING,FSWRKDIV:STRING,REMARK:STRING,FSNUM:STRING,"
	 						  + "DIVCD:STRING,BGTDIV:STRING,SSDAT:STRING,SSNBR:STRING,"
							  + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING ";
			gcds_slipdtl.SetDataHeader(s_temp);
		}
	}
	*/
}

/******************************************************************************
	Description : 기수 찾기 
	parameter   :            
******************************************************************************/
function ln_Kisu_Find(strMM){
	
	if (strMM >='01' || strMM<='03') {
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKIDIV") = "1";	//기수[1]
	}else if(strMM >='04' || strMM <='06') {
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKIDIV") = "2";	//기수[2]
	}else if(strMM >='07' || strMM <='09') {
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKIDIV") = "3";	//기수[3]
	}else if(strMM >='10' || strMM <='12') {
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXKIDIV") = "4";	//기수[4]
	}
}

/******************************************************************************
Description : 관리항목 KillFocus시 발생
parameter   : obj - 관리항목의 gcem object명
                     p - 자리수 
******************************************************************************/
function ln_onblur(obj, p){
  //alert("obj::"+obj);
    var row = gcds_slipdtl.rowposition;
    
    
    if(obj=="gcem_fsrvalnm"+p){
		if(gcds_slipdtl.namevalue(row,"TYPE"+p)=="C"){
			eval("txt_fsrefval"+p).value =eval("gcem_fsrvalnm"+p).text; 	
		}
		
		if(eval("gcem_fsrvalnm"+p).text==""){
			eval("txt_fsrefval"+p).value=""; 
		}
	}
  
   /* 
    
  
   if(obj=="gcem_vendnm01"){
		if(gcds_slipdtl.namevalue(row,"TYPE01")=="C"){
			txt_fsrefval01.value =gcem_fsrvalnm01.text; 	
		}
		if(gcem_fsrvalnm01.text==""){
			txt_fsrefval01.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm03"){
		if(gcds_slipdtl.namevalue(row,"TYPE03")=="C"){
			txt_fsrefval03.value =gcem_fsrvalnm03.text; 	
		}
		if(gcem_fsrvalnm03.text==""){
			txt_fsrefval03.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm04"){
		if(gcds_slipdtl.namevalue(row,"TYPE04")=="C"){
			txt_fsrefval04.value =gcem_fsrvalnm04.text; 	
		}
		if(gcem_fsrvalnm04.text==""){
			txt_fsrefval04.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm05"){
		if(gcds_dtl.namevalue(row,"TYPE05")=="C"){
			txt_fsrefval05.value =gcem_fsrvalnm05.text; 	
		}
    if(gcem_fsrvalnm05.text==""){
			txt_fsrefval05.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm06"){
		if(gcds_dtl.namevalue(row,"TYPE06")=="C"){
			txt_fsrefval06.value =gcem_fsrvalnm06.text; 	
		}
   	    if(gcem_fsrvalnm06.text==""){
			txt_fsrefval06.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm07"){
		if(gcds_dtl.namevalue(row,"TYPE07")=="C"){
			txt_fsrefval07.value =gcem_fsrvalnm07.text; 	
		}
		if(gcem_fsrvalnm07.text==""){
			txt_fsrefval07.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm08"){
		if(gcds_dtl.namevalue(row,"TYPE08")=="C"){
			txt_fsrefval08.value =gcem_fsrvalnm08.text; 	
		}
		if(gcem_fsrvalnm08.text==""){
			txt_fsrefval08.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm09"){
		if(gcds_dtl.namevalue(row,"TYPE09")=="C"){
			txt_fsrefval09.value =gcem_fsrvalnm09.text; 	
		}
		if(gcem_fsrvalnm09.text==""){
			txt_fsrefval09.value=""; 
		}
	}
	*/
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object id=gcds_data classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_subdata classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_venddata classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_taxmst  classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_taxdtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<object id=gcds_actcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_slipmst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=gcds_slipdtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=gcds_slipref classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>


<object id=gcds_banjaemst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

<!--반제history -->
<object id=gcds_banjae classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

 <!-- 구매품의번호 중복찾기-->
  <object  id=gcds_buyno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>


 <!--접수번호 -->
  <object  id=gcds_slipno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>


 <!--구매매치-->
  <object  id=gcds_pmsmch classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>


<object id=gcds_fdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_temp classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>




<!-- 권한관리 -->
<object id=gcds_right classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object id=gcds_login classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id="gcds_taxdiv" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true"><!-- 귀속구분[매입] -->
</object>

<object  id="gcds_taxknd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true"><!-- 부가세종류[매입] -->
</object>

</comment><script>__ws__(__NSID__);</script>

<!----------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__">
	<object  id=gctr_data classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
		<param name="keyname"		value="toinb_dataid4">
		<!--<param name="keyvalue"          value="a040080_t1(I:USER1=gcds_taxmst,I:USER2=gcds_taxdtl,I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER5=gcds_banjaemst,I:USER6=gcds_banjae,O:USER7=gcds_slipno)">  -->
		<param name="keyvalue"          value="a040080_t1(I:USER1=gcds_taxmst,I:USER2=gcds_taxdtl,I:USER3=gcds_slipmst,I:USER4=gcds_slipdtl,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=gcds_pmsmch,O:USER5=gcds_slipno )">    
	</object>
	
	<object id=gctr_data2 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
		<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
		<PARAM NAME="KeyValue" VALUE="a040065_t2(I:USER=gcds_temp,O:USER2=gcds_return)">
  </object>
 </comment><script>__ws__(__NSID__);</script>
	
<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript event="OnLoadError()" for=gcds_data>
	alert("에러가 발생 했습니다.");
	document.all.LowerFrame.style.visibility="hidden";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(rowcount)>
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";

	if (rowcount ==0 ){
		alert("검색된 데이타가 없습니다.");
	}

	//lbl_search.innerText = "총 ( " + rowcount + " ) 건     ";
	//window.status = "정상적으로 조회되었습니다.";

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_cocode event=OnSelChange()>
  
  //ln_Find_Regno();
  //ln_Query(gcem_regno.text);

</script>

<script language="javascript"  for=gcgd_data event="OnClick(row,colid)">
  
	if(row==0 && colid=="CHK"){ //전체선택              
		if(gcds_data.namevalue(1,"CHK")=="T"){ //첫행이 체크 되어 있을 경우
			for(i=1;i<=gcds_data.Countrow;i++){
				gcds_data.namevalue(i,"CHK") = "F";
			}//for
		}else{
			for(i=1;i<=gcds_data.Countrow;i++){  //첫행이  체크 되지 않을 경우 모두 체크 
				gcds_data.namevalue(i,"CHK") = "T";
			}//for
		}
	}else if (row!=0 && colid=="CHK"){  //개별선택
      
		if(gs_gubun=="") gs_gubun=1;
		else if(gs_gubun=="1") gs_gubun=2;
		else if(gs_gubun=="2") gs_gubun=1;

		if(gs_gubun=="1"||gs_gubun==""){
			gcds_data.namevalue(row,"CHK")="T";
		}else{
			gcds_data.namevalue(row,"CHK")="F";
		}
	}
	
	if(row>0 && colid !="CHK"){
		ln_SubQuery(gcds_data.namevalue(row,"CON_NO"), gcds_data.namevalue(row,"DATE_CGCD"));
	}
</script>

<script language=JavaScript for=gclx_supbuy event=OnSelChange()>

</script>

<script language=JavaScript for= gclx_status event=OnSelChange()>
  
</script>

<script language=JavaScript for= gcem_taxdat_1 event=onKillFocus()>
    gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXDAT")=gcem_taxdat_1.text;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD")=gcem_taxdat_1.text.substring(4,8);
	gcem_actdat_1.text = gcem_taxdat_1.text;
	ln_Kisu_Find(gcem_taxdat_1.text.substring(4,6));
</script>

<script language=JavaScript for=gcem_taxdat_1 event=OnSetFocus()>
    gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXDAT")=gcem_taxdat_1.text;
	gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"MMDD")=gcem_taxdat_1.text.substring(4,8);
	gcem_actdat_1.text = gcem_taxdat_1.text;
	ln_Kisu_Find(gcem_taxdat_1.text.substring(4,6));
</script>

 
<script language=JavaScript for=gcds_taxdtl event=onColumnChanged(row,colid)>

	if (colid == "TAXSUM") {
	    gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT") = gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM") *0.1;
		gcem_taxsum_1.text= gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXSUM");
		gcem_taxvatamt_1.text = gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT") ;
		gcem_taxtot_1.text = Number(gcem_taxsum_1.text) + Number(gcem_taxvatamt_1.text);
		
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXSUM") = gcem_taxsum_1.text;
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT") = gcem_taxvatamt_1.text;
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXTOT") = gcem_taxtot_1.text;
	}
	
	if (colid == "TAXVATAMT") {
		gcem_taxvatamt_1.text = gcds_taxdtl.namevalue(gcds_taxdtl.rowposition,"TAXVATAMT") ;
		gcem_taxtot_1.text = Number(gcem_taxsum_1.text) + Number(gcem_taxvatamt_1.text);
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXVATAMT") = gcem_taxvatamt_1.text;
		gcds_taxmst.namevalue(gcds_taxmst.rowposition,"TAXTOT") = gcem_taxtot_1.text;
	}

</script>


<script language=JavaScript for=gcem_fsrvalnm01 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Ref_Popup('01','gcem_fsrvalnm01',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm03 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Ref_Popup('03','gcem_fsrvalnm03',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm04 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Ref_Popup('04','gcem_fsrvalnm04',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm05 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Ref_Popup('05','gcem_fsrvalnm05',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm06 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Ref_Popup('06','gcem_fsrvalnm06',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm07 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Ref_Popup('07','gcem_fsrvalnm07',kcode);
</script>


<script language=JavaScript for=gcem_fsrvalnm08 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Ref_Popup('08','gcem_fsrvalnm08',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm09 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Ref_Popup('09','gcem_fsrvalnm09',kcode);
</script>



<!-- 부서 / 거래처 / 관리항목 -->
<script language=JavaScript for=gcem_fsrvalnm01 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm01", '01');
</script>

<script language=JavaScript for=gcem_fsrvalnm03 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm03", '03');
</script>

<script language=JavaScript for=gcem_fsrvalnm04 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm04", '04');
</script>

<script language=JavaScript for=gcem_fsrvalnm05 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm05", '05');
</script>

<script language=JavaScript for=gcem_fsrvalnm06 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm06", '06');
</script>

<script language=JavaScript for=gcem_fsrvalnm07 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm07", '07');
</script>

<script language=JavaScript for=gcem_fsrvalnm08 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm08", '08');
</script>

<script language=JavaScript for=gcem_fsrvalnm09 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm09", '09');
</script>



<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language=JavaScript for=gctr_data event=OnSuccess()>
	var temp="";
    gclx_fdcode_1.bindcolval = gcds_slipno.namevalue(gcds_slipno.rowposition,"FDCODE");
	gcem_fsdat_1.text =  gcds_slipno.namevalue(gcds_slipno.rowposition,"FSDAT");
	gcem_fsnbr_1.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
																								
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language=JavaScript for=gctr_data event=OnFail()>
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>


<script language=JavaScript for=gctr_data2 event=OnSuccess()>

</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>
 
 
</HEAD>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
    <tr>
    	<td colspan=2 > 
    		<img src="../../Common/img/btn/com_b_query.gif"    style="cursor:hand;position:relative;left:835px;top:-3px;"   onclick="ln_Query()"  >
    	 </td>
    </tr>
	<tr>
	 <td colspan=2>
		<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;" >
		<tr> 
      		<td width="100px" align=center  bgcolor="#eeeeee" class="tab15" ><nobr>검수기간</nobr></td>
			<td class="tab18"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_frdt_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
					<param name=Alignment		  value=0>
					<param name=Border	          value=true>
					<param name=Format	          value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					<param name=Enable			  value="true">
					<param name=ClipMode        value=true>
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt_0', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
				<comment id="__NSID__">
				<object  id=gcem_todt_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
					style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
					<param name=Alignment		  value=0>
					<param name=Border	          value=true>
					<param name=Format	          value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					<param name=Enable			  value="true">
					<param name=ClipMode        value=true>
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_todt', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab18" ><nobr>소속</nobr></td>
			<td class="tab18" style="width:120px;">
			<input id="txt_deptnm_0" type="text"   class="txtbox" style= "width:100px;height:20px;position:relative;left:3px;background-color:#d7d7d7"  readOnly="true";></nobr>	
			</td>
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab18" ><nobr>담당자</nobr></td>
			<td class="tab18" style="width:120px;">
			<input id="txt_empnmk_0" type="text"   class="txtbox" style= "width:100px;height:20px;position:relative;left:3px;background-color:#d7d7d7"  readOnly="true";></nobr>	
			</td>
		</tr>
		<tr> 
			<td width="100px" align=center  bgcolor="#eeeeee" class="tab17" ><nobr>거래처명</nobr></td>
			<td width="150px" class="tab19" colspan=5><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_vendnm_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:250px" onKeydown="if(event.keyCode==13) gf_Popup_Vend('gcem_vendcd_0','gcem_vendnm_0')">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=GeneralEdit  value="true">
					<param name=PromptChar	value="_">
				</object>
				</comment><script>__ws__(__NSID__);</script>&nbsp;
				<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="gf_Popup_Vend('gcem_vendcd_0','gcem_vendnm_0')">
			  <comment id="__NSID__">
				<object  id=gcem_vendcd_0 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px" onKeydown="if(event.keyCode==13) gf_Popup_Vend('gcem_vendcd_0','gcem_vendnm_0')">
					<param name=Text				value="">
					<param name=Alignment		value=0>
					<param name=Border			value=true>
					<param name=Format			value="#############">
					<param name=PromptChar	value="_">
				</object>
				</comment><script>__ws__(__NSID__);</script> 
				<img name="btn_find" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm_0.text = '';gcem_vendcd_0.text = '';">
			  </nobr> 
			</td>
		</tr>
		</table>
   </td>
	</tr>
	<tr>
		<td colspan=2>	  
		<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:3px;width:876px;border:0 solid #708090;">
		<tr>
			<td><font  color="blue"><b>[검수완료]</b></font></td>
			<td><font  color="blue"><b>[검수상세]</b></font></td>
		</tr>
		<tr> 			
			<td>
				<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data style="WIDTH:500px;HEIGHT:100px;border:1 solid #777777;display:block;">
						<PARAM NAME="DataID"			  VALUE="gcds_data">
						<PARAM NAME="BorderStyle"     VALUE="0">
						<param name="IndWidth"           value="0">
						<param name="Fillarea"		      VALUE="true">
						<param name="ColSizing"          value="true">
						<param name="editable"            value="true">
						<PARAM NAME="Format"			  VALUE="  
						<FC> Name='선택'	             ID=CHK         	                  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	    align=center   EditStyle=CheckBox </FC> 
						<FC> Name='거래처명'			 ID=VEND_NM   	              HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left		  edit=none </FC>
						<C>  Name='청구번호'           ID=RQST_NO                     HeadAlign=Center HeadBgColor=#B9D4DC Width=90	    align=center   edit=none  </C>
						<C>  Name='품의번호'			 ID=CON_NO                       HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center   edit=none </C>
						<C>  Name='합계금액'            ID=CGCD_NOW_AMT  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=right  	  edit=none </C>			
						<C>  Name='현장'                  ID=PU_SITE_NM   	          HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	  edit=none  </C>			  					
						<C>  Name='검수일자'		     ID=DATE_CGCD  	              HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center   edit=none  mask ='XXXX/XX/XX'</C>
						<C>  Name='검수상태'           ID=DATE_CGCD                  HeadAlign=Center HeadBgColor=#B9D4DC Width=70  	align=center   edit=none   show=false</C>					
					">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			  <input id="hid_sbdescription" type="hidden" class="txtbox" style= "width:400px;height:20px;"  readOnly="true";> 
				<input id="hid_email" type="hidden" class="txtbox" style= "width:400px;height:20px;"  readOnly="true";> 
			</td>
			<td>
				<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_data_d style="WIDTH:372px;HEIGHT:100px;border:1 solid #777777;display:block;">
						<PARAM NAME="DataID"			  VALUE="gcds_subdata">
						<PARAM NAME="BorderStyle"     VALUE="0">
						<param name="IndWidth"           value="0">
						<param name="Fillarea"		      VALUE="true">
						<param name="ColSizing"          value="true">
						<param name="editable"            value="false">
						<param name=ViewSummary   value="1">
						<PARAM NAME="Format"			  VALUE="  
						<FC> Name='순'			        ID=Currow    	           HeadAlign=Center HeadBgColor=#B9D4DC Width=28	align=center  SumBgColor=#C3D0DB sumtext=''    Value={CurRow} </FC>
						<FC> Name='검수품목'			 ID=ITEM_NM   	           HeadAlign=Center HeadBgColor=#B9D4DC Width=115	align=left		  SumBgColor=#C3D0DB sumtext=''     </FC>
						<C>  Name='검수규격'           ID=ITEM_SIZE              HeadAlign=Center HeadBgColor=#B9D4DC Width=55	align=center   SumBgColor=#C3D0DB sumtext='계'  </C>
				        <C>  Name='금액'                  ID=CGCD_NOW_AMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=75	align=right	  SumBgColor=#C3D0DB sumtext='@sum' </C>					
						<C>  Name='단위'			         ID=ITEM_UNIT             HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=center   SumBgColor=#C3D0DB sumtext=''	 </C>
						<C>  Name='수량'                  ID=CGCD_NOW_CNT   HeadAlign=Center HeadBgColor=#B9D4DC Width=40 	align=right      SumBgColor=#C3D0DB sumtext=''	 </C>			
					">
					</object>
				</comment><script>__ws__(__NSID__);</script>
			     <input id="hid_sbdescription" type="hidden" class="txtbox" style= "width:400px;height:20px;"  readOnly="true";> 
				<input id="hid_email" type="hidden" class="txtbox" style= "width:400px;height:20px;"  readOnly="true";> 
			</td>
		</tr>
		</table> 
    </td>
	</tr>
	<tr>
		<td colspan=2>
			<table  cellpadding="0" cellspacing="0" border="0" style="position:relative;left:1px;top:5px;width:876px;height:200px;font-size:9pt;background-color:#ffffff;" > 
				<tr>
					<td width="210px"    colspan=2><font  color="blue"><b>[매입등록]</b></font></td>
				    <td width="70px"      class="tab32"    align=center  bgcolor="#eeeeee"  >지점 </td>
					<td width="140px"    class="tab35"    style=" height:25px;" >
					    <comment id="__NSID__">
						<object  id=gclx_fdcode_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;width:100px;height:110px;" >
						<param name=ComboDataID		value="gcds_fdcode">
						<param name=CBDataColumns	value="FDCODE,FDNAME">
						<param name=SearchColumn	    value="FDNAME">
						<param name=Enable                  value="true">
						<param name=ListExprFormat	    value="FDNAME^0^100">
						<param name=BindColumn		    value="FDCODE">
						<param name=Index                    value="2">
						</object>
						</comment><script>__ws__(__NSID__);</script> 	
					</td>
					<td width="70px"      class="tab35"  align=center  bgcolor="#eeeeee" >사업소 </td>
					<td width="140px"    class="tab35" > 
						<comment id="__NSID__">
						<object  id=gclx_cocode_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;font-size:12px;width:90px;height:100px;">
									<param name=CBData					value="02^서울,01^고성,04^홍성">
									<param name=CBDataColumns	value="CDCODE,CDNAM">
									<param name=SearchColumn		value="CDNAM">
									<param name=Sort						value="false">
									<param name=ListExprFormat	    value="CDNAM^0^90">
									<param name=BindColumn			value="CDCODE">
									<param name=Enable                  value=true>
					    </object>
					    </comment><script>__ws__(__NSID__);</script>
					</td>
                    <td colspan = 2  width="207px"    class="tab35" >					
					<img src="../../Common/img/btn/com_btn_tax_a.gif"    style="cursor:hand;position:relative;left:142px;top:0px;"  align="right"   onclick="ln_Tax_A_Create()"  >
					</td>
				</tr>
				<tr>
					<td width="70px"  align=center  bgcolor="#eeeeee" class="tab25">거래처 </td>
					<td colspan=3  width="360px"   class="tab26"   style=" height:25px;"><nobr>
						<comment id="__NSID__">
						<object  id=gcem_vendcd_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:80px">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="#############">
							<param name=PromptChar	value="_">
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:5px;cursor:hand"	 onclick="ln_PopupA()">
						<input id=txt_vendnm_1  type="text"  class="txt11"  style="position:relative;top:-4px;left:1px;width:230px;background-color:#ccffcc" readOnly>
					</td>
					<td width="70px"      class="tab26"    align=center  bgcolor="#eeeeee"  >등록번호 </td>
					<td width="140px"    class="tab26"  style=" height:25px;">	
					   <comment id="__NSID__"><object  id=gcem_vendid_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:80px;">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="###-##-#####">
							<param name=PromptChar	value="_">
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object></comment><script>__ws__(__NSID__);</script></nobr> 					
					</td>
					<td width="70px"      class="tab26"  align=center  bgcolor="#eeeeee" >성명 </td>
					<td width="140px"    class="tab26" >
						<input id=txt_vddirect_1  type="text"  class="txt11"  style="position:relative;top:0px;left:5px;width:100px;background-color:#ccffcc" readOnly>
					</td>
				</tr>
				
				<tr>
					<td  width="70px"   class="tab30"    align=center  bgcolor="#eeeeee"  >주소 </td>
					<td  colspan=3       width="360px"    class="tab28"  style=" height:25px;">	
					  	<input id=txt_address_1  type="text"  class="txt11"  style="position:relative;top:0px;left:5px;width:350px;background-color:#ccffcc" readOnly>	
					</td>
					<td width="70px"      class="tab28"  align=center  bgcolor="#eeeeee" >업태 </td>
					<td width="140px"    class="tab28" > 
						<input id=txt_bsnscnd_1  type="text"  class="txt11"  style="position:relative;top:0px;left:5px;width:100px;background-color:#ccffcc" readOnly>
					</td>
					<td width="70px"      class="tab28"  align=center  bgcolor="#eeeeee" >업종 </td>
					<td width="140px"    class="tab28" >
						<input id=txt_bsnsknd_1  type="text"  class="txt11"  style="position:relative;top:0px;left:5px;width:100px;background-color:#ccffcc" readOnly>
					 </td>
				</tr>
				<tr>
					<td class="tab30"  align=center  bgcolor="#eeeeee"  >작성일자 </td>
					<td class="tab28"  style=" height:25px;" > 
						 <comment id="__NSID__"><object  id=gcem_taxdat_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:68px;">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="YYYY/MM/DD">
							<param name=PromptChar	value="_">
							<param name=Enable			value="true">
						</object></comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_taxdat_1', 'Text');gcem_taxdat_1.Focus();" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;">	
					</td>
					<td class="tab28" align=center  bgcolor="#eeeeee" >공급가액 </td>
					<td class="tab28" > 
						<comment id="__NSID__"><object  id=gcem_taxsum_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:100px;">
							<param name=Text				value="">
							<param name=Alignment		value=2>
							<param name=Border			value=true>
							<param name=Numeric		value=true>
							<param name=Format			value="000,000,000">
							<param name=PromptChar	value="_">
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object></comment><script>__ws__(__NSID__);</script>	
					</td>
					<td class="tab28" align=center  bgcolor="#eeeeee" >세액 </td>
					<td class="tab28" >
						<comment id="__NSID__"><object  id=gcem_taxvatamt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:100px;">
							<param name=Text				value="">
							<param name=Alignment		value=2>
							<param name=Border			value=true>
							<param name=Numeric		value=true>
							<param name=Format			value="000,000,000">
							<param name=PromptChar	value="_">
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object></comment><script>__ws__(__NSID__);</script>
					 </td>
					<td class="tab28" align=center  bgcolor="#eeeeee" >합계 </td>
					<td class="tab28"  >
						<comment id="__NSID__"><object  id=gcem_taxtot_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:100px;">
							<param name=Text				value="">
							<param name=Alignment		value=2>
							<param name=Border			value=true>
							<param name=Numeric		value=true>
							<param name=Format			value="000,000,000">
							<param name=PromptChar	value="_">
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
				</tr>
			
				<tr>
					<td class="tab30"  align=center  bgcolor="#eeeeee"  >적요 </td>
					<td class="tab28" colspan=3  style=" height:25px;" > 
						<input id=txt_remark_1  type="text"  class="txt11"  style="position:relative;top:0px;left:5px;width:350px;" >		
					</td>
					<td class="tab28" align=center  bgcolor="#eeeeee" >수정사유 </td>
					<td class="tab28" colspan=3  style=" height:25px;" >
						<input id=txt_amend_remark_1  type="text"  class="txt11"  style="position:relative;top:0px;left:5px;width:320px;" >		
					 </td>
				</tr>
				<tr>
					<td class="tab30" align=center  bgcolor="#eeeeee" >귀속구분 </td>
					<td class="tab28" style=" height:25px;" > 
						<comment id="__NSID__">
						<object  id=gclx_taxdiv_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=106 style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:200px;">
							<param name=ComboDataID			value="gcds_taxdiv">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		    value="CDNAM">
							<param name=Sort						    value="false">
							<param name=ListExprFormat	        value="CDNAM^0^90">
							<param name=BindColumn			    value="CDCODE">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab28" align=center  bgcolor="#eeeeee" >과세구분 </td>
					<td class="tab28" > 
						<comment id="__NSID__">
						<object  id=gclx_taxknd_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_taxknd">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		    value="CDNAM">
							<param name=Sort						    value="false">
							<param name=ListExprFormat	        value="CDNAM^0^90">
							<param name=BindColumn		    	value="CDCODE">
						</object>
					     </comment><script>__ws__(__NSID__);</script> 
					</td>
					<td class="tab28" align=center  bgcolor="#eeeeee" >발행구분 </td>
					<td class="tab28" >
						<comment id="__NSID__">
						<object  id=gclx_taxtype_1  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;font-size:12px;width:100px;height:100px;">
									<param name=CBData					value="1^전자발행,2^수기발행">
									<param name=CBDataColumns	value="CDCODE,CDNAM">
									<param name=SearchColumn		value="CDNAM">
									<param name=Sort						value="false">
									<param name=ListExprFormat	    value="CDNAM^0^90">
									<param name=BindColumn			value="CDCODE">
									<param name=Enable                  value=true>
					    </object>
					    </comment><script>__ws__(__NSID__);</script> 
					 </td>
					<td class="tab28" align=center  bgcolor="#eeeeee" >접수번호 </td>
					<td class="tab28"   >
						  <comment id="__NSID__">
						  <object  id=gcem_fsdat_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:5px;top:2px;width:70px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric		value=false>
								<param name=Format			value="#########">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object> &nbsp;-
							<object  id=gcem_fsnbr_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;left:3px;top:2px;width:45px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=ClipMode		value=true>
								<param name=Numeric		value=false>
								<param name=Format			value="######">
								<param name=PromptChar	value="_">
								<param name=Enable			value="false">
							</object></comment><script>__ws__(__NSID__);</script> 
					 </td>
				</tr>
				<tr>
				<td colspan=8>
				<comment id="__NSID__">
					<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_taxdtl style="WIDTH:874px;HEIGHT:43px;border:1 solid #777777;display:block;">
						<param name="dataid"			  value="gcds_taxdtl">
						<param name="borderstyle"   value="0">
						<param name="indwidth"        value="0">
						<param name="fillarea"		  value="true">
						<param name="colsizing"      value="true">
						<param name="editable"        value="true">
						<param name="format"			  value="  
						<C>  Name='월일'			ID=MMDD                            HeadAlign=Center HeadBgColor=#B9D4DC Width=70 	align=center   edit=none  mask='XX/XX'</C>
						<C>  Name='품목'         ID=TAXPDTNAM       	       HeadAlign=Center HeadBgColor=#B9D4DC Width=250 	align=left  	   </C>			
						<C>  Name='규격'         ID=TAXSTD          	           HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left  	   </C>			  					
						<C>  Name='수량'		    ID=TAXQTY          	           HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=right       </C>
						<C>  Name='단가'         ID=TAXPRIC                        HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=right	   </C>					
						<C>  Name='공급가액'  ID=TAXSUM                         HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=right	   </C>					
						<C>  Name='부가세액'  ID=TAXVATAMT                   HeadAlign=Center HeadBgColor=#B9D4DC Width=110	align=right	   </C>					
				    	">
					</object>
				</comment><script>__ws__(__NSID__);</script>
				</td>
				</tr> 
				
			</table>
		</td>
	</tr>
	<tr>
		<td colspan=2>
			<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:25px;font-size:9pt;background-color:#ffffff;" > 
				<tr>
					<td  style="position:relative;top:5px;height:20px;text-color:blue;"><font  color="blue"><b>[전표등록]</b></font></td>
					<td >
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand;position:relative;left:455px;top:2px;"  align="right"  onClick="ln_Save()"  >
						<img src="../../Common/img/btn/com_b_taxissue.gif"  style="cursor:hand;position:relative;left:455px;top:2px;"  align="right"  onClick="ln_Slip_Create()" >
					     <img src="../../Common/img/btn/b_cancel.gif"       style="cursor:hand;position:relative;left:455px;top:2px;"  align="right"  onClick="ln_Slip_Cancel()" >				
					</td>
				</tr>
			</table>
			
			<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:100px;font-size:9pt;background-color:#ffffff;" > 
				<tr>
					<td class="tab25" align=center  bgcolor="#eeeeee"   width="70px"  >계정코드1 </td>
					<td class="tab26" style=" height:27px; width:275px"> 
					    <nobr><comment id="__NSID__">
						<object id=gcem_atcode1_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
						</object></comment><script>__ws__(__NSID__);</script> 
						
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_PopupB('1')">
						<input id=txt_atkornam1_1 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:170px;">
						<input id=txt_atdecr1_1     type="text" class="txt11" style="position:relative;left:5px;width:70px;display:none">
					</td>
					<td class="tab26" style=" height:27px; width:175px"> 	
	                   <comment id="__NSID__">
						<object  id=gcem_chaamt1_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:80px;color=blue">
							<param name=Text				value="0">
							<param name=Alignment		value=2>
							<param name=Border			value=true>
							<param name=Numeric		value=true>
							<param name=Format			value="000,000,000">
							<param name=InheritColor		value=true>
						</object>
						&nbsp;
						<object  id=gcem_daeamt1_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:80px;color=red">
							<param name=Text				value="0">
							<param name=Alignment		value=2>
							<param name=Border			value=true>
							<param name=Numeric		value=true>
							<param name=Format			value="000,000,000">
							<param name=InheritColor		value=true>
						</object>
						</comment><script>__ws__(__NSID__);</script>
						
					</td>
					<td class="tab26" align=center  bgcolor="#eeeeee"  width="70px"  >회계일자</td>
					<td class="tab26"  style=" height:27px;width:300px"> 
						 <comment id="__NSID__">
						 <object  id=gcem_actdat_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:68px;">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="YYYY/MM/DD">
							<param name=PromptChar	value="_">
							<param name=Enable			value="true">
						 </object>
						 </comment><script>__ws__(__NSID__);</script>
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_1', 'Text');gcem_actdat_1.Focus();" style="position:relative;width:20px;left:5px;top:1px;cursor:hand;">		
					</td>
				</tr>
				<tr>
					<td class="tab30" align=center  bgcolor="#eeeeee" >계정코드2 </td>
					<td class="tab28"  style=" height:27px;"><nobr>
						<comment id="__NSID__">
						<object id=gcem_atcode2_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
						</object>
						</comment><script>__ws__(__NSID__);</script> 
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_PopupB('2')">
						<input id=txt_atkornam2_1 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:170px;">
						<input id=txt_atdecr2_1     type="text" class="txt11" style="position:relative;left:5px;width:70px;display:none"></nobr> 
					</td>
					 <td class="tab28" > 
						 <comment id="__NSID__">
						<object  id=gcem_chaamt2_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:80px;color=blue">
							<param name=Text				value="0">
							<param name=Alignment		value=2>
							<param name=Border			value=true>
							<param name=Numeric		value=true>
							<param name=Format			value="000,000,000">
							<param name=InheritColor		value=true>
						</object>
						&nbsp;
						<object  id=gcem_daeamt2_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:80px;color=red">
							<param name=Text				value="0">
							<param name=Alignment		value=2>
							<param name=Border			value=true>
							<param name=Numeric		value=true>
							<param name=Format			value="000,000,000">
							<param name=InheritColor		value=true>
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
					<td class="tab28"  align=center  bgcolor="#eeeeee"  rowspan=3>반제내역(정산)</td>
					<td class="tab28"  rowspan=3   height="81"> 
						<comment id="__NSID__">
						<object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_banjaerel style="WIDTH:300px;HEIGHT:80px;border:1 solid #777777;display:block;">
							<param name="dataid"			  value="gcds_banjae">
							<param name="borderstyle"   value="0">
							<param name="indwidth"        value="0">
							<param name="fillarea"		  value="true">
							<param name="colsizing"      value="true">
							<param name="format"			  value="  
							<C>  Name='전표일자'   ID=SSDAT            	          HeadAlign=Center HeadBgColor=#B9D4DC Width=60	    align=center 	   </C>	
							<C>  Name='번호'         ID=SSNBR           	              HeadAlign=Center HeadBgColor=#B9D4DC Width=42 	align=center 	   </C>		
							<C>  Name='순'            ID=FSNUM           	              HeadAlign=Center HeadBgColor=#B9D4DC Width=24 	align=center 	   </C>			  					
							<C>  Name='차변'		    ID=BJDEAMT          	          HeadAlign=Center HeadBgColor=#B9D4DC Width=77 	align=right      color =#0000FF </C>
							<C>  Name='대변'         ID=BJCRAMT                      HeadAlign=Center HeadBgColor=#B9D4DC Width=77	    align=right	  color =#FF0000 </C>							
								">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				<tr>
					<td class="tab30" align=center  bgcolor="#eeeeee"  >반제정산 </td>
					<td class="tab28" style=" height:27px;">  <nobr>
						<comment id="__NSID__">
						<object id=gcem_atcode3_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:50px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="#######">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
						</object>
						</comment><script>__ws__(__NSID__);</script> 
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="ln_PopupC('txt_atkornam3_1')">
						<input id=txt_atkornam3_1 type="text" class="txt11" style="position:relative;top:-4px;left:5px;width:170px;">
						<input id=txt_atdecr3_1     type="text" class="txt11" style="position:relative;left:5px;width:70px;display:none"></nobr> 
					   </td>
					   <td class="tab28" > 	 
						 <comment id="__NSID__">
						<object  id=gcem_chaamt3_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:80px;">
							<param name=Text				value="0">
							<param name=Alignment		value=2>
							<param name=Border			value=true>
							<param name=Numeric		value=true>
							<param name=Format			value="000,000,000">
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=ReadOnlyForeColor    value="blue">
						</object>
						&nbsp;
						<object  id=gcem_daeamt3_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:80px;">
							<param name=Text				value="0">
							<param name=Alignment		value=2>
							<param name=Border			value=true>
							<param name=Numeric		value=true>
							<param name=Format			value="000,000,000">
							<param name=ReadOnly      value=true>
							<param name=ReadOnlyBackColor   value="#CCFFCC">
							<param name=ReadOnlyForeColor    value="red">
						</object>
						</comment><script>__ws__(__NSID__);</script>
					</td>
				</tr>
				<tr>
					<td class="tab30" align=center  bgcolor="#eeeeee"  >자산번호 </td>
					<td class="tab28"  style=" height:27px;" >  <nobr>
						<comment id="__NSID__">
						<object id=gcem_astnbr_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:70px">
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="###-#####">
						<param name=PromptChar	value="_">
						<param name=Enable			value="false">
						</object>
						</comment><script>__ws__(__NSID__);</script> 
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:7px;cursor:hand"	 onclick="gf_Popup_Astnbr('gclx_fdcode_1','gcem_astnbr_1')">
					</td>
					 <td class="tab28" > 					
						<img src="../../Common/img/btn/com_btn_repay_cancel.gif"	style="cursor:hand;position:relative;left:60px;top:0px;"  align="right"  onClick="ln_Popup_Repay_Cancel()"  >
						<img src="../../Common/img/btn/com_btn_repay.gif"		    style="cursor:hand;position:relative;left:60px;top:0px;"  align="right"  onClick="ln_Popup_Repay()"  >
					</td>
				</tr>
			</table>
			
			<table  cellpadding="0" cellspacing="0" border="0" style="width:876px;height:200px;font-size:9pt;background-color:#ffffff;" > 
				<tr>
					<td colspan =9 style="height:145px;">
						<comment id="__NSID__"><object classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
							style="width:874px; height:140px; border:1 solid #708090;display:block;" viewastext>
								<param name="dataid"			        value="gcds_slipdtl">
								<param name="indwidth"		        value ='0'>
								<param name="borderstyle"         value="0">
								<param name="fillarea"		        value="true">
								<param name="sortview"		        value="left">
								<param name="ViewSummary"	value=1>
								<param name="ColSizing"            value="true">
								<param name="Editable"              value="true">
								<param name="ColSelect"		    value=false>
								<param name="Format"		  	    value=" 
								    <FC>Name='순번'		   ID=FSNUM 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=26	   align=center  edit=none   SumBgColor=#C3D0DB </FC> 
									<FC>Name='계정코드'  ID=ATCODE 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=51     align=left	   edit=none  SumBgColor=#C3D0DB </FC> 
									<FC>Name='계정명'	   ID=ATKORNAM	      HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=left	    edit=none  SumBgColor=#C3D0DB SumText='합   계'</FC> 
									<FC>Name='차변금액'  ID=CHAAMT 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=95     align=right	 edit=none  SumBgColor=#C3D0DB SumText=@sum  color =#0000FF  sumcolor =#0000FF</FC> 
									<FC>Name='대변금액'  ID=DAEAMT 	          HeadAlign=Center HeadBgColor=#B9D4DC Width=95	    align=right  edit=none  SumBgColor=#C3D0DB SumText=@sum  color =#FF0000  sumcolor =#FF0000</FC> 
									<C> Name='증빙명'	   ID=DOCUMCD 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=95	    align=left   edit=none  SumBgColor=#C3D0DB SumText='차변-대변'  EditStyle=Combo Data='000:,101:세금계산서,102:계산서,103:신용카드(공제),104:현금영수증(공제),201:신용카드(불공),202:간주공급,203:간이영수증'</C> 
									<C> Name='적요'		   ID=REMARK             HeadAlign=Center HeadBgColor=#B9D4DC Width=205	align=left	  SumBgColor=#C3D0DB SumText={sum(CHAAMT)-sum(DAEAMT)} SumTextAlign=right </C> 
									<C> Name='예산'		   ID=FSWRKDIV 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=40	    align=center edit=none  SumBgColor=#C3D0DB EditStyle=Combo Data='01:미적용,02:적용'</C> 
									<C> Name='거래처'	   ID=FSRVALNM02 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left   edit=none  SumBgColor=#C3D0DB </C> 
									<C> Name='부서'		   ID=FSRVALNM01 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left   edit=none  SumBgColor=#C3D0DB </C> 
									<C> Name='관리항목3' ID=FSRVALNM03 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
									<C> Name='관리항목4' ID=FSRVALNM04 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
									<C> Name='관리항목5' ID=FSRVALNM05 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
									<C> Name='관리항목6' ID=FSRVALNM06 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
									<C> Name='관리항목7' ID=FSRVALNM07 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
									<C> Name='관리항목8' ID=FSRVALNM08	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
									<C> Name='관리항목9' ID=FSRVALNM09 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left	 edit=none  SumBgColor=#C3D0DB </C> 
								">
						</object></comment><script>__ws__(__NSID__);</script>   			
					</td>
				</tr>
				<tr>
				    <td width="25px"   class="tab32"     align=center  bgcolor="#B9D4DC" style="height:20px;" >순번</td>
				    <td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" >
				    	<input type=text       id=txt_fsrefnm01   name=txt_fsrefnm02  value="부서"          size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
				        <input type=hidden  id=txt_fsrefcd01   value=''>
						<input type=hidden  id=txt_fsrefseq01 value=''>
						<input type=hidden  id=txt_type01       value=''>
						<input type=hidden  id=txt_arbaldiv01 value=''>
				    </td>
					<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
						<input type=text    id=txt_fsrefnm03   name=txt_fsrefnm03  value="관리항목3"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					    <input type=hidden  id=txt_fsrefcd03   value=''>
						<input type=hidden  id=txt_fsrefseq03 value=''>
						<input type=hidden  id=txt_type03       value=''>
						<input type=hidden  id=txt_arbaldiv03 value=''>					
					</td>
					<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
					    <input type=text    id=txt_fsrefnm04   name=txt_fsrefnm04  value="관리항목4"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					    <input type=hidden  id=txt_fsrefcd04   value=''>
						<input type=hidden  id=txt_fsrefseq04 value=''>
						<input type=hidden  id=txt_type04       value=''>
						<input type=hidden  id=txt_arbaldiv04 value=''>
					</td>
					
					<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
					    <input type=text    id=txt_fsrefnm05   name=txt_fsrefnm05  value="관리항목5"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					    <input type=hidden  id=txt_fsrefcd05   value=''>
						<input type=hidden  id=txt_fsrefseq05 value=''>
						<input type=hidden  id=txt_type05       value=''>
						<input type=hidden  id=txt_arbaldiv05 value=''>
					</td>
					<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
					    <input type=text       id=txt_fsrefnm06   name=txt_fsrefnm06  value="관리항목6"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					    <input type=hidden  id=txt_fsrefcd06   value=''>
						<input type=hidden  id=txt_fsrefseq06 value=''>
						<input type=hidden  id=txt_type06       value=''>
						<input type=hidden  id=txt_arbaldiv06 value=''>
					</td>
					<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
					    <input type=text        id=txt_fsrefnm07   name=txt_fsrefnm07  value="관리항목7"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					    <input type=hidden  id=txt_fsrefcd07   value=''>
						<input type=hidden  id=txt_fsrefseq07 value=''>
						<input type=hidden  id=txt_type07       value=''>
						<input type=hidden  id=txt_arbaldiv07 value=''>
					</td>
					<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
					    <input type=text        id=txt_fsrefnm08   name=txt_fsrefnm08  value="관리항목8"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					    <input type=hidden  id=txt_fsrefcd08   value=''>
						<input type=hidden  id=txt_fsrefseq08 value=''>
						<input type=hidden  id=txt_type08       value=''>
						<input type=hidden  id=txt_arbaldiv08 value=''>
					</td>
					<td width="104px" class="tab35"     align=center  bgcolor="#B9D4DC" > 
					    <input type=text    id=txt_fsrefnm09   name=txt_fsrefnm09  value="관리항목9"  size="15"  class=txt41  style="position:relative;top:1px;width:100px;height:17px;background-color:#B9D4DC;text-align:center;" readonly tabindex=-1>
					    <input type=hidden  id=txt_fsrefcd09   value=''>
						<input type=hidden  id=txt_fsrefseq09 value=''>
						<input type=hidden  id=txt_type09       value=''>
						<input type=hidden  id=txt_arbaldiv09 value=''>
						
						<input type=hidden  id=hid_banjaeref    value=''><!--반제단위-->
						<input type=hidden  id=hid_banjaeyn    value=''><!--반제유무-->
						<input type=hidden  id=hid_atdecr         value=''><!--차대구분-->
						<input type=hidden  id=hid_bgtdiv          value=''><!--예산-->
						<input type=hidden  id=hid_divcd           value=''><!--본부-->
						<!--거래처-->
						<input type=hidden  id=txt_fsrefcd02   value=''>
						<input type=hidden  id=txt_fsrefseq02 value=''>
						<input type=hidden  id=txt_type02       value=''>
						<input type=hidden  id=txt_arbaldiv02 value=''>
					</td>
				</tr>	
				<tr>
				    <td width="24px"   class="tab25"   align=center  style="height:22px;" >
				       <comment id="__NSID__">
				    	 <object  id=gcem_fsnum         classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:24px;height:18;position:relative;top:3px;">				
							<param name=Text				value="">
							<param name=Border          value=false>
						    <param name=Format          value="000">
							<param name=Enable          value=false>
							<param name=GeneralEdit   value="true">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor   value=false> 
						</object></comment><script>__ws__(__NSID__);</script>
				    </td>
				    <td width="104px" class="tab26"     align=center  >
				   	    <object  id=gcem_fsrvalnm01  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
						<param name=Text		        value="">
						<param name=Border          value=false>
						<param name=Format          value="">
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=true>
						</object>
						<input type=hidden  id=txt_fsrefval01   value=''>
				    </td>
					<td width="104px" class="tab26"     align=center > 
						<object  id=gcem_fsrvalnm03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
						<param name=Text		        value="">
						<param name=Border          value=false>
						<param name=Format          value="">
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=true>
						</object>
						<input type=hidden  id=txt_fsrefval03   value=''>
					</td>
					<td width="104px" class="tab26"     align=center > 
					 	<object  id=gcem_fsrvalnm04  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
						<param name=Text		        value="">
						<param name=Border          value=false>
						<param name=Format          value="">
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=true>
						</object>
						<input type=hidden  id=txt_fsrefval04   value=''>
					</td>
					<td width="104px" class="tab26"     align=center > 
						<object  id=gcem_fsrvalnm05  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
						<param name=Text		        value="">
						<param name=Border          value=false>
						<param name=Format          value="">
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=true>
						</object>
						<input type=hidden  id=txt_fsrefval05   value=''>
					</td>
					<td width="104px" class="tab26"     align=center > 
						<object  id=gcem_fsrvalnm06  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
						<param name=Text		        value="">
						<param name=Border          value=false>
						<param name=Format          value="">
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=true>
						</object>
						<input type=hidden  id=txt_fsrefval06   value=''>
					</td>
					<td width="104px" class="tab26"     align=center > 
						<object  id=gcem_fsrvalnm07  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
						<param name=Text		        value="">
						<param name=Border          value=false>
						<param name=Format          value="">
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=true>
						</object>
						<input type=hidden  id=txt_fsrefval07   value=''>
					</td>
					<td width="104px" class="tab26"     align=center > 
						<object  id=gcem_fsrvalnm08  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
						<param name=Text		        value="">
						<param name=Border          value=false>
						<param name=Format          value="">
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=true>
						</object>
						<input type=hidden  id=txt_fsrefval08   value=''>
					</td>
					<td width="104px" class="tab26"     align=center > 
						<object  id=gcem_fsrvalnm09  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:100px;height:20px;position:relative;top:4px;" tabindex=8>				
						<param name=Text		        value="">
						<param name=Border          value=false>
						<param name=Format          value="">
						<param name=GeneralEdit   value="true">
						<param name=BackColor     value="#CCCCCC">
						<param name=InheritColor   value=true>
						</object>
						<input type=hidden  id=txt_fsrefval09   value=''>
					</td>	
					
					<!--관리항목 cd/ 관리항목 SEQ / 관리항목 val  / 관리항목 nm / 필수 / 타입 -->
					
				</tr>
				
			</table>
		</td>
	</tr>
	
	<input type="hidden" class="txt11" id="hid_login"  style="position:relative;left:0px;width:60px;background-color:#d7d7d7" readOnly>
 </table>
 
 <comment id="__NSID__">
 	<object id=gcbn_tax_a     classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
		<param name=DataID		   value=gcds_venddata>
		<param name=ActiveBind    value=true>
		<param name=BindInfo	   value='
		<C>Col=VEND_CD        Ctrl=gcem_vendcd_1      Param=text</C>
		<C>Col=VEND_ID    	   Ctrl=gcem_vendid_1       Param=text</C>
		<C>Col=VEND_NM	   Ctrl=txt_vendnm_1           Param=value</C>
		<C>Col=VD_DIRECT     Ctrl=txt_vddirect_1	 	      Param=value</C>
		<C>Col=BSNS_CND     Ctrl=txt_bsnscnd_1	 	  Param=value</C>
		<C>Col=BSNS_KND	   Ctrl=txt_bsnsknd_1	 	  Param=value</C>
		<C>Col=ADDRESS	   Ctrl=txt_address_1	 	  Param=value</C>
	'>
	</object>
	
	
	<object  id=gcbn_data02   classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID          value=gcds_slipdtl>
	<param name=BindInfo  value='  
	<C>Col=FDCODE           Ctrl=hid_fdcode   	     Param=value</C>
	<C>Col=FSDAT              Ctrl=hid_fsdat           Param=value</C>
    <C>Col=FSNBR              Ctrl=hid_fsnbr           Param=value</C>
	<C>Col=FSSEQ              Ctrl=hid_fsseq           Param=value</C>
	<C>Col=ATCODE            Ctrl=gcem_atcode02       Param=Text</C>
	<C>Col=ATKORNAM       Ctrl=gcem_atkornam02		 Param=Text</C>
	<C>Col=ATDECR            Ctrl=hid_atdecr	         Param=value</C>
	<C>Col=REMARK            Ctrl=gcem_remark02_1     Param=Text</C>
	<C>Col=CHAAMT            Ctrl=gcem_detot02  	     Param=Text</C>
	<C>Col=DAEAMT            Ctrl=gcem_crtot02        Param=Text</C>
	<C>Col=FSREFSEQ01     Ctrl=txt_fsrefseq01      Param=value</C>
	<C>Col=FSREFSEQ02     Ctrl=txt_fsrefseq02      Param=value</C>
	<C>Col=FSREFSEQ03     Ctrl=txt_fsrefseq03      Param=value</C>
	<C>Col=FSREFSEQ04     Ctrl=txt_fsrefseq04      Param=value</C>
	<C>Col=FSREFSEQ05     Ctrl=txt_fsrefseq05	     Param=value</C>
	<C>Col=FSREFSEQ06     Ctrl=txt_fsrefseq06      Param=value</C>
    <C>Col=FSREFSEQ07     Ctrl=txt_fsrefseq07      Param=value</C>
	<C>Col=FSREFSEQ08     Ctrl=txt_fsrefseq08      Param=value</C>
	<C>Col=FSREFSEQ09     Ctrl=txt_fsrefseq09      Param=value</C>
	<C>Col=FSREFCD01      Ctrl=txt_fsrefcd01		   Param=value</C>
	<C>Col=FSREFCD02      Ctrl=txt_fsrefcd02	   	    Param=value</C>
	<C>Col=FSREFCD03      Ctrl=txt_fsrefcd03     	 Param=value</C>
	<C>Col=FSREFCD04      Ctrl=txt_fsrefcd04	   	 Param=value</C>
	<C>Col=FSREFCD05      Ctrl=txt_fsrefcd05     	 Param=value</C>
	<C>Col=FSREFCD06      Ctrl=txt_fsrefcd06     	 Param=value</C>
	<C>Col=FSREFCD07      Ctrl=txt_fsrefcd07     	 Param=value</C>
	<C>Col=FSREFCD08      Ctrl=txt_fsrefcd08     	 Param=value</C>
	<C>Col=FSREFCD09      Ctrl=txt_fsrefcd09     	 Param=value</C>
	<C>Col=FSREFVAL01     Ctrl=txt_fsrefval01        Param=value</C>
    <C>Col=FSREFVAL03     Ctrl=txt_fsrefval03      Param=value</C>
	<C>Col=FSREFVAL04     Ctrl=txt_fsrefval04      Param=value</C>
	<C>Col=FSREFVAL05     Ctrl=txt_fsrefval05      Param=value</C>
	<C>Col=FSREFVAL06     Ctrl=txt_fsrefval06		   Param=value</C>
	<C>Col=FSREFVAL07     Ctrl=txt_fsrefval07	     Param=value</C>
	<C>Col=FSREFVAL08     Ctrl=txt_fsrefval08      Param=value</C>
	<C>Col=FSREFVAL09     Ctrl=txt_fsrefval09	     Param=value</C>
	<C>Col=FSREFNM01      Ctrl=txt_fsrefnm01			 Param=value</C>
	<C>Col=FSREFNM03      Ctrl=txt_fsrefnm03			 Param=value</C>
	<C>Col=FSREFNM04      Ctrl=txt_fsrefnm04			 Param=value</C>
	<C>Col=FSREFNM05      Ctrl=txt_fsrefnm05			 Param=value</C>
	<C>Col=FSREFNM06      Ctrl=txt_fsrefnm06			 Param=value</C>
	<C>Col=FSREFNM07      Ctrl=txt_fsrefnm07			 Param=value</C>
    <C>Col=FSREFNM08      Ctrl=txt_fsrefnm08			 Param=value</C>
	<C>Col=FSREFNM09      Ctrl=txt_fsrefnm09			 Param=value</C>
	<C>Col=FSRVALNM01     Ctrl=gcem_fsrvalnm01     Param=Text</C>
	<C>Col=FSRVALNM03     Ctrl=gcem_fsrvalnm03	   Param=Text</C>
	<C>Col=FSRVALNM04     Ctrl=gcem_fsrvalnm04     Param=Text</C>
	<C>Col=FSRVALNM05     Ctrl=gcem_fsrvalnm05	 Param=Text</C>
	<C>Col=FSRVALNM06     Ctrl=gcem_fsrvalnm06     Param=Text</C>
	<C>Col=FSRVALNM07     Ctrl=gcem_fsrvalnm07     Param=Text</C>
	<C>Col=FSRVALNM08     Ctrl=gcem_fsrvalnm08     Param=Text</C>
	<C>Col=FSRVALNM09     Ctrl=gcem_fsrvalnm09     Param=Text</C>
	<C>Col=TYPE01              Ctrl=txt_type01				   Param=value</C>
	<C>Col=TYPE02              Ctrl=txt_type02				   Param=value</C>
	<C>Col=TYPE03              Ctrl=txt_type03				   Param=value</C>
    <C>Col=TYPE04              Ctrl=txt_type04				   Param=value</C>
	<C>Col=TYPE05              Ctrl=txt_type05				   Param=value</C>
	<C>Col=TYPE06              Ctrl=txt_type06				   Param=value</C>
	<C>Col=TYPE07              Ctrl=txt_type07				   Param=value</C>
	<C>Col=TYPE08              Ctrl=txt_type08				   Param=value</C>
	<C>Col=TYPE09              Ctrl=txt_type09				   Param=value</C>
	<C>Col=ARBALDIV01     Ctrl=txt_arbaldiv01	  Param=value</C>          
	<C>Col=ARBALDIV02     Ctrl=txt_arbaldiv02      Param=value</C>
	<C>Col=ARBALDIV03     Ctrl=txt_arbaldiv03      Param=value</C>
	<C>Col=ARBALDIV04     Ctrl=txt_arbaldiv04      Param=value</C>
	<C>Col=ARBALDIV05     Ctrl=txt_arbaldiv05      Param=value</C>
	<C>Col=ARBALDIV06     Ctrl=txt_arbaldiv06      Param=value</C>
	<C>Col=ARBALDIV07     Ctrl=txt_arbaldiv07	  Param=value</C>
	<C>Col=ARBALDIV08     Ctrl=txt_arbaldiv08      Param=value</C>
    <C>Col=ARBALDIV09     Ctrl=txt_arbaldiv09      Param=value</C>
	<C>Col=CNT                 Ctrl=hid_cnt                Param=value</C>
	<C>Col=DOCUMCD       Ctrl=gclx_documcd02 Param=BindColVal</C>
	<C>Col=BANJAEYN       Ctrl=hid_banjaeyn        Param=value</C>
	<C>Col=FSSTAT           Ctrl=hid_fsstat             Param=value</C>
	<C>Col=DOCUVAL        Ctrl=hid_docuval         Param=value</C>
    <C>Col=FSNUM            Ctrl=gcem_fsnum	       Param=Text</C>
	<C>Col=DIVCD              Ctrl=hid_divcd             Param=value</C>
    <C>Col=BGTDIV            Ctrl=hid_bgtdiv            Param=value</C>
	<C>Col=FUNDDIV          Ctrl=hid_funddiv           Param=value</C>
	<C>Col=BANJAEREF      Ctrl=hid_banjaeref       Param=value</C>
	<C>Col=LASTREF          Ctrl=hid_lastref            Param=value</C>
	<C>Col=BANJAEMOD     Ctrl=hid_banjaemod    Param=value</C>
	<C>Col=ATCURTYPE      Ctrl=hid_atcurtype      Param=value</C>

	'>
</object>

<object id=gcbn_taxmst     classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		   value=gcds_taxmst>
	<param name=ActiveBind    value=true>
	<param name=BindInfo	   value='
	<C>Col=REMARK                Ctrl=txt_remark_1                  Param=value</C>
	<C>Col=ATCODE                Ctrl=gcem_atcode2_1           Param=text</C>
	'>
</object>
	<!--
	<object id=gcbn_taxmst     classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
		<param name=DataID		   value=gcds_taxmst>
		<param name=ActiveBind    value=true>
		<param name=BindInfo	   value='
		<C>Col=COCODE              Ctrl=gclx_cocode_1           Param=bindcolval</C>
		<C>Col=TAXDIV                Ctrl=gclx_taxdiv_1 	          Param=bindcolval</C>
		<C>Col=TAXKND              Ctrl=txt_bsnsknd_1 	          Param=value</C>
		<C>Col=VEND_CD            Ctrl=gcem_vendcd_1          Param=text</C>
		<C>Col=TAXDAT               Ctrl=gcem_taxdat_1            Param=text</C>
		<C>Col=TAXSUM              Ctrl=gcem_taxsum_1          Param=text</C>
		<C>Col=TAXVATAMT         Ctrl=gcem_taxvatamt_1       Param=text</C>
		<C>Col=TAXTOT                Ctrl=gcem_taxtot_1 	          Param=text</C>
		<C>Col=REMARK               Ctrl=txt_remark_1 	          Param=value</C>
		<C>Col=ATCODE               Ctrl=gcem_atcode1_1         Param=text</C>
		<C>Col=FSDAT                  Ctrl=gcem_fsdat_1 	           Param=text</C>
		<C>Col=FSNBR                  Ctrl=gcem_fsnbr_1 	           Param=text</C>
		<C>Col=FDCODE                Ctrl=gclx_fdcode_1            Param=bindcolval</C>
		<C>Col=AMEND_REMARK   Ctrl=txt_amend_remark_1  Param=value</C>
	'>
	</object>
	-->
</comment><script>__ws__(__NSID__);</script>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 



