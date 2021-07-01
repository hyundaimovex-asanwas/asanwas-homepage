
//회계 전표에서 공통으로 사용하는 함수를 입력하는 곳임.
//2008.07.23 부터 사용함.

//2011.01.01 사업자단위과세 적용으로 사업자등록번호 통일함.
//var gs_regno_s = "1018510695";   //서울 사업자 등록번호
var gs_regno_s = "2218113834";   //서울 사업자 등록번호
var gs_regno_g = "2218113834";   //고성 사업자 등록번호 

//var gs_comname_s = "현대아산주식회사(서울지점)";   //현대아산주식회사(지점 서울)
var gs_comname_s = "현대아산주식회사(고성본사)";   //현대아산주식회사(지점 서울)
var gs_comname_g = "현대아산주식회사(고성본사)";   //현대아산주식회사(본사 고성)

//var gs_url="http://203.242.32.193:10000";
//2013.12.23.JYS 변경 
//var gs_url="http://203.242.32.193:80"; 이전 세금계산서 중계서버 
var gs_url="http://203.242.32.126:80";   //가상화 세금계산서 중계서버  

var gc_date=""; 

/*****************************************************************************
	Description : 로딩시 해당 월의 일수 가져오기
	parameter   : gb - s : 시작일자
	                   c : 현재일자
******************************************************************************/
function ln_Load_Date(gb){

	if(gb=="s"){
		gc_date = gcurdate.substring(0,4) + gcurdate.substring(5,7)+"01";     
	}else if(gb=="c"){
  	    gc_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	}
	return gc_date;
}
/*****************************************************************************
	Description : 금액 lock설정
	parameter   : row  - rowposition 임.
******************************************************************************/
function ln_Dtl_Amt_Lock(row){

	//반제 정산 계정일 때 금액 LOCK=========================================================
	//2008.07.23. 정영식
	gcem_detot02.Enable = true;
	gcem_crtot02.Enable = true;
	if(gcds_dtl.namevalue(row,"BANJAEYN")=="Y"){
		if(gcds_dtl.namevalue(row,"ATDECR")=="1" &&gcds_dtl.namevalue(row,"DAEAMT")!=0){
			gcem_detot02.Enable = false;
			gcem_crtot02.Enable = false;
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"&&gcds_dtl.namevalue(row,"CHAAMT")!=0){
			gcem_detot02.Enable = false;
			gcem_crtot02.Enable = false;	
		}
	}
	//======================================================================================
	
	if(gs_team_user=="false"){ //회계팀이 아닐경우
		//선급부가가치세/선수부가가치세 일 경우
		if(gcds_dtl.namevalue(row,"ATCODE")=="1112300"||gcds_dtl.namevalue(row,"ATCODE")=="2101100"){
			gcem_detot02.ReadOnly = "true"; 
			gcem_crtot02.ReadOnly = "true"; 
		}else{
			gcem_detot02.ReadOnly = "false"; 
			gcem_crtot02.ReadOnly = "false"; 
		}
	}
}

/*****************************************************************************
	Description : 반제계정 lock설정
	parameter   : row  - rowposition 임.
******************************************************************************/
function ln_Atcode_Lock(row){
	//반제 정산 계정일 때 금액 LOCK=========================================================
	//2008.07.23. 정영식
	if(gcds_dtl.namevalue(row,"BANJAEYN")=="Y"){
		if(gcds_dtl.namevalue(row,"ATDECR")=="1" &&gcds_dtl.namevalue(row,"DAEAMT")!=0){
			gcem_atcode02.Enable = false;
			gcem_atkornam02.Enable = false;
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"&&gcds_dtl.namevalue(row,"CHAAMT")!=0){
			gcem_atcode02.Enable = false;
			gcem_atkornam02.Enable = false;	
		}else{
			gcem_atcode02.Enable = true;
			gcem_atkornam02.Enable = true;
		}
	}else{
		gcem_atcode02.Enable = true;
		gcem_atkornam02.Enable = true;
	}
	//======================================================================================
	
	if(gs_team_user=="false"){ //회계팀이 아닐경우
		//선급부가가치세/선수부가가치세 일 경우
		if(gcds_dtl.namevalue(row,"ATCODE")=="1112300"||gcds_dtl.namevalue(row,"ATCODE")=="2101100"){
			gcem_atcode02.Enable = false;
			gcem_atkornam02.Enable = false;	
		}
	}
}

/*******************************************************************************************
	Description : 미지급금(개인명법인카드)의 거래처 선택시 은행, 카드번호, 카드종류, 계좌번호 
	              자동설정 및 LOCK
	parameter   : row  - rowposition 임.
*********************************************************************************************/
function ln_Ref_Card_Lock(gb,row){
	if(gb=="T"){ //true
		gcem_fsrvalnm03.Enable = true;
		gcem_fsrvalnm04.Enable = true;
		gcem_fsrvalnm05.Enable = true;
		gcem_fsrvalnm06.Enable = true;
	}else{ //false 
        gcem_fsrvalnm03.Enable = false;
		gcem_fsrvalnm04.Enable = false;
		gcem_fsrvalnm05.Enable = false;
		gcem_fsrvalnm06.Enable = false;
	}
}

/*******************************************************************************************
	Description : 미지급금(개인명법인카드)의 거래처 선택시 은행, 카드번호, 카드종류, 계좌번호 
	              자동설정 및 LOCK
	parameter   : row  - rowposition 임.
*********************************************************************************************/
function ln_Card_Data_Setting(){
	
	//alert("ln_Card_Data_Setting");

	gcds_card.DataID = g_servlet+"/Account.comm_card_s2?v_str1="+txt_vendcd02.value
							+"&v_str2="+gcem_actdat02.text  
							
    //prompt("",gcds_card.dataid);							
	gcds_card.Reset();		 

	if(gcds_card.countrow>0){
		strPo="";
		strPo = ln_Ref_position_find("2168"); //은행
		eval("txt_fsrefval"+strPo).value = gcds_card.namevalue(gcds_card.rowposition,"CAACCBANK");
		eval("gcem_fsrvalnm"+strPo).text = gcds_card.namevalue(gcds_card.rowposition,"BANKNM");

		strPo="";
		strPo =  ln_Ref_position_find("2167"); //카드번호
		eval("txt_fsrefval"+strPo).value = gcds_card.namevalue(gcds_card.rowposition,"CANBR");
		eval("gcem_fsrvalnm"+strPo).text = gcds_card.namevalue(gcds_card.rowposition,"CARDNO");

		strPo="";
		strPo = ln_Ref_position_find("1134"); //카드종류
		eval("txt_fsrefval"+strPo).value = gcds_card.namevalue(gcds_card.rowposition,"CACARDSPEC");
		eval("gcem_fsrvalnm"+strPo).text = gcds_card.namevalue(gcds_card.rowposition,"CARDKD");

		strPo="";
		strPo = ln_Ref_position_find("2166"); //계좌번호
		eval("txt_fsrefval"+strPo).value = gcds_card.namevalue(gcds_card.rowposition,"CABANKNO");
		eval("gcem_fsrvalnm"+strPo).text = gcds_card.namevalue(gcds_card.rowposition,"ACCNO");
		return true;
	}else{

	//  거래처 초기화
		//alert("["+gcem_vendnm02.text+"]에 대한 개인명법인카드 정보가 존재하지 않습니다.");           
		txt_vendcd02.value="";
		gcem_vendnm02.text = "";
		//LOCK 해제 
		ln_Ref_Card_Lock("F",gcds_dtl.rowposition);
		strPo="";
		strPo = ln_Ref_position_find("2168"); //은행
		eval("txt_fsrefval"+strPo).value = "";
		eval("gcem_fsrvalnm"+strPo).text ="";

		strPo="";
		strPo =  ln_Ref_position_find("2167"); //카드번호
		eval("txt_fsrefval"+strPo).value = "";
		eval("gcem_fsrvalnm"+strPo).text ="";

		strPo="";
		strPo = ln_Ref_position_find("1134"); //카드종류
		eval("txt_fsrefval"+strPo).value = "";
		eval("gcem_fsrvalnm"+strPo).text = "";

		strPo="";
		strPo = ln_Ref_position_find("2166"); //계좌번호
		eval("txt_fsrefval"+strPo).value = "";
		eval("gcem_fsrvalnm"+strPo).text = "";
		return false;
	}
}