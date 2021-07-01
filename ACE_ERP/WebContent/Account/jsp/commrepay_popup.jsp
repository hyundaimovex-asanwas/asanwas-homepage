<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 반제처리 팝업
+ 프로그램 ID	:  Commrepay_popup.html
+ 기 능 정 의	:  반제처리
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2006.01.13
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 가수금 계정은 가수 기일로 조회 가능하게함.   
+ 수   정  자 :  정 영 식
+ 수 정 일 자 :  2006.10.04
-----------------------------------------------------------------------------
+ 서 블 릿 명	: 
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>반제처리</title>

<!-----------------------------------------------------------------------------
		L O C A L   S T Y L E   S H E E T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<style type="text/css">

</style>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
get_cookdata();
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_fdcode="";
var gs_fsdat="";
var gs_fsnbr="";
var gs_seq="";
var gs_userid = gusrid;
var gs_banjaeyn = ""; //반제 구분
var gs_save="N";    //저장확인:반제연결 테이블에 저장 했는지 확인함. 
var gs_rechaamt=0 ; //항목이 2개 이상일때 리턴해주는 금액
var gs_redaeamt=0 ; //항목이 2개 이상일때 리턴해주는 금액
var gs_cnt=0;

//var g_date_fr = gcurdate.substring(0,4)+"0101";
var g_date_fr = "19900101";
var g_gubun="N";   //미결 
var strParam = new Array();
strParam=window.dialogArguments;

function ln_Start(){
 
	txt_custcd_fr.value= strParam.g_arrParam[2];
	txt_custnm_fr.value= strParam.g_arrParam[3];
	
	txt_atcode_fr.value= strParam.g_arrParam[0];
	txt_atcodenm_fr.value= strParam.g_arrParam[1];
	
	gs_fdcode=strParam.g_arrParam[4];
	gs_fsdat=strParam.g_arrParam[5];
	gs_fsnbr=strParam.g_arrParam[6];
	gs_seq=strParam.g_arrParam[7];   //전표행번호

   gclx_fsrefcd.bindcolval = strParam.g_arrParam[8]; 
	txt_fsrefcd_fr.value = strParam.g_arrParam[9]; 
	txt_fsrefnm_fr.value = strParam.g_arrParam[10]; 

  //계정코드가 가수금이면
	if(txt_atcode_fr.value=="2101300"){
		txt_label.value="입금일자";
	}else{
		
	}

	//alert("gs_seq" + gs_seq);

	//**gcra_gubun.codevalue="N";

  /**
	gcem_fsdat_fr.text =gs_date;
	gcem_fsdat_to.text =gs_date;


  gcds_data03.DataID = g_servlet+"/Account.a020001_s12?v_str1="+txt_atcode_fr.value
																									  +"&v_str2="+txt_atcode_to.value
																									  +"&v_str3="+txt_custcd_fr.value
																										+"&v_str4="+txt_custcd_to.value;
																									 
	//prompt("gcds_data03",gcds_data03.DataID);
	gcds_data03.Reset();
 **/
  //alert("" + gcds_data03.namevalue(1,"COUNT"));
	//gs_cnt=gcds_data03.namevalue(1,"COUNT");

  
	ln_Query();
	ln_Before();
	ln_Before2();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){
 
 /**
	gcds_data01.DataID = g_servlet+"/Account.a020001_s10?v_str1="+gcem_fsdat_fr.text 
	                                                  +"&v_str2="+gcem_fsdat_fr.text
	                                                  +"&v_str3="+gcra_gubun.codevalue
																										+"&v_str4="+txt_atcode_fr.value
																									  +"&v_str5="+txt_atcode_to.value
																									  +"&v_str6="+txt_custcd_fr.value
																										+"&v_str7="+txt_custcd_to.value
																										+"&v_str8="+gs_cnt;																									;
	//prompt("gcds_data01",gcds_data01.DataID);
	gcds_data01.Reset();
	**/
  
	//기간이 존재하지 않을 경우 현재년 01월 01일 ~ 현재년월일 까지
	//기간이 존재하는 경우는 기간을 넣는다.
    if(gcem_actdat_fr.text==""||gcem_actdat_fr.text==undefined){
		var strfrdt = g_date_fr;
	}else{
    var strfrdt = gcem_actdat_fr.text;
	}

	if(gcem_actdat_to.text==""||gcem_actdat_to.text==undefined){
		var strtodt = gs_date;
	}else{
    var strtodt = gcem_actdat_to.text;
	}

	var date_fr="";
	var date_to="";
	var fsrefcd2="";

  //가수금의 경우 입금일자 및 관리항목 코드 넘김
	if(txt_atcode_fr.value=="2101300"){
		date_fr=gcem_date_fr.text;
		date_to=gcem_date_to.text;
		if(gcem_date_fr.text!=""&&gcem_date_to.text!=""){
			fsrefcd2="1125";
		}else{
      fsrefcd2="";
		}
	}

	gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020003_s1?v_str1="+gs_fdcode                 //지점       
																										+"&v_str2="+strfrdt 			           //처리기간FR 
																										+"&v_str3="+strtodt			             //처리기간TO 
																										+"&v_str4="+g_gubun		               //구분       
																										+"&v_str5="+txt_custcd_fr.value			 //거래처FR   
																										+"&v_str6="+txt_atcode_fr.value      //계정과목FR 
																										+"&v_str7="+gclx_fsrefcd.bindcolval  //관리항목 
																										+"&v_str8="+txt_fsrefcd_fr.value     //관리항목FR  
																										+"&v_str9="+txt_fsrefcd_fr.value     //관리항목FR
																										+"&v_str10="+date_fr                 // 
																										+"&v_str11="+date_to                 //  
																										+"&v_str12="+fsrefcd2;               //관리항목2
																									
	 //prompt("gcds_data01",gcds_data01.DataID);
   gcds_data01.Reset();

}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Before(){
	//관리항목[검색]
	gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0050&v_str2=";  
	gcds_fsrefcd.Reset();
}

/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Before2(){
	gcds_code01.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s0?v_str1="+txt_atcode_fr.value
	                                                  +"&v_str2="+txt_atcodenm_fr.value
	                                                  +"&v_str3=&v_str4=ATUSEYN"
																										+"&v_str5=ATDEBTYN&v_str6="; 
	//prompt("",gcds_code01.DataID);
	gcds_code01.Reset();
}

/******************************************************************************
	Description : 추가
******************************************************************************/
function ln_Add(){

}

/******************************************************************************
	Description : 저장 
	              반제연결 테이블 저장
								전표테이블에 데이타 return;
******************************************************************************/
function ln_Save(){

  ln_SetDataHeader();
  
  if (ln_Chk()){
		if (gcds_data02.IsUpdated ){
			if (confirm("저장하시겠습니까?")){	
				gctr_data01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t5?";
				//gctr_data01.Parameters = "v_str1=" + gs_date +",v_str2=" + gs_userid;					
				 gctr_data01.post();
			   //prompt("", gcds_data02.text);
				 //prompt("", gcds_data03.text);
			}	
		}
	}
}

/******************************************************************************
	Description : 체크
******************************************************************************/
function ln_Chk(){

	var strRetrun="";

	for(i=1;i<=gcds_data01.CountRow;i++){
		if(gcds_data01.namevalue(1,"CHK")=="T"){
			strRetrun="true";
		}
	}

	if(strRetrun=="true"){
		if(ln_Data()){
			return true;
		}else{
		  alert("반제금액이 더 많습니다.")
			return false;
		}
	}
	return false;
}


/******************************************************************************
	Description : 체크
	              반제단위가 동일한 건에 한해서만 반제가능함.
******************************************************************************/
function ln_Chk2(){

  _out:
	for(j=1;j<=gcds_data01.CountRow-1;j++){
		if(gcds_data01.namevalue(j,"CHK")=="T"){
			for(k=j+1;k<=gcds_data01.CountRow;k++){
				if(gcds_data01.namevalue(k,"CHK")=="T"){
					if(gcds_data01.namevalue(j,"VENDCD")==gcds_data01.namevalue(k,"VENDCD")&&gcds_data01.namevalue(j,"FSREFCD")==gcds_data01.namevalue(k,"FSREFCD")&&gcds_data01.namevalue(j,"FSREFVAL")==gcds_data01.namevalue(k,"FSREFVAL")){

					}else{
					    return false;
						break _out;
					}
				}
			}//for k 
		}
	}//for j 

  return true;
	 

}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){

}

/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(){

}

/******************************************************************************
	Description : 출력
******************************************************************************/
function ln_Print(){

}

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){

}


/******************************************************************************
	Description : 반제저장용 데이타 
******************************************************************************/
function ln_Data(){
  //alert("ln_Data");

	var strFtstat ="N";
	var dblSum=0;
	var dblTotal=0;
	var dblTemp=0;
	gs_banjaeyn="N";
  
  for (i=1;i<=gcds_data01.countrow;i++){
	  //alert("i::"+i+"FDCODE:"+gcds_data01.namevalue(i,"FDCODE")+"::FSNBR::"+gcds_data01.namevalue(i,"FSNBR")+"::chk::"+gcds_data01.namevalue(i,"CHK"));
		if(gcds_data01.namevalue(i,"CHK")=="T"){ //체크된 항목
		  //alert("i::"+i);
		  gcds_data02.addrow();
			//alert("position"+gcds_data02.rowposition);
			gcds_data02.namevalue(gcds_data02.rowposition,"FTSTAT") = strFtstat;
			gcds_data02.namevalue(gcds_data02.rowposition,"FDCODE") = gcds_data01.namevalue(i,"FDCODE");
			gcds_data02.namevalue(gcds_data02.rowposition,"TSDAT")  = gcds_data01.namevalue(i,"FSDAT");
			gcds_data02.namevalue(gcds_data02.rowposition,"TSNBR")  = gcds_data01.namevalue(i,"FSNBR");
			gcds_data02.namevalue(gcds_data02.rowposition,"TSSEQ")  = gcds_data01.namevalue(i,"FSSEQ");
			gcds_data02.namevalue(gcds_data02.rowposition,"BTSDAT") = gs_fsdat;
			gcds_data02.namevalue(gcds_data02.rowposition,"BTSNBR") = gs_fsnbr;
			gcds_data02.namevalue(gcds_data02.rowposition,"BTSSEQ") = gs_seq;
			gcds_data02.namevalue(gcds_data02.rowposition,"BANJAEYN") = gs_banjaeyn; 
			gcds_data02.namevalue(gcds_data02.rowposition,"WRDT") = gs_date;
			gcds_data02.namevalue(gcds_data02.rowposition,"WRID") = gs_userid;
			gcds_data02.namevalue(gcds_data02.rowposition,"UPDT") = gs_date;
			gcds_data02.namevalue(gcds_data02.rowposition,"UPID") = gs_userid;

			//합계금액
		  if(gcds_data01.namevalue(i,"ATDECR")=="1"){
				dblSum+=gcds_data01.namevalue(i,"CHAAMT");
				gs_rechaamt +=gcds_data01.namevalue(i,"CHAAMT"); 
			}else if(gcds_data01.namevalue(i,"ATDECR")=="2"){
				dblSum+=gcds_data01.namevalue(i,"DAEAMT");
				gs_redaeamt +=gcds_data01.namevalue(i,"CHAAMT"); 
			}
      
      //alert("dblSum"+dblSum);
			dblTotal+=gcds_data01.namevalue(i,"TOTAL");
			//alert("dblTotal"+dblTotal);
     
		}else{                       //체크안된항목

			if(gcds_data01.namevalue(i,"ATDECR")=="1"){
				dblSum+=gcds_data01.namevalue(i,"CHAAMT");
			}else if(gcds_data01.namevalue(i,"ATDECR")=="2"){
				dblSum+=gcds_data01.namevalue(i,"DAEAMT");
			}
		}//
	}
  
	//alert("dblSum"+dblSum);
	//alert("dblTotal"+dblTotal);
	
	if(dblSum>dblTotal){
		return false;
	}else if(dblSum==dblTotal){  //반제완료건.
		gs_banjaeyn = "Y"
		gcds_data02.namevalue(gcds_data02.rowposition,"BANJAEYN") = gs_banjaeyn; 
	}
	return true;
}

/******************************************************************************
	Description : 반제연결테이블용(사용안함.)
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(){

		var s_temp = "FTSTAT:STRING,FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,"
							 + "BTSDAT:STRING,BTSNBR:STRING,BTSSEQ:STRING,BANJAEYN:STRING,"
							 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
		gcds_data02.SetDataHeader(s_temp);
}

/******************************************************************************
	Description : 반제테이블용
  parameter   : p1 - BANJAEMST  반제원장
	                   BANJAE     반제연결
******************************************************************************/
function ln_SetDataHeader2(p1){

	if(p1=="BANJAEMST"){
		var s_fslipdtl14 = "FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,ATCODE:STRING,"
		                 + "DEPTCD:STRING,VENDCD:STRING,FSREFCD:STRING,FSREFVAL:STRING,DEAMT:DECIMAL,"	
                     + "CRAMT:DECIMAL,STATUS:STRING,SSDAT:STRING,SSNBR:STRING,FSNUM:STRING,"	 
										 + "REMARK:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,AMT:DECIMAL,SEQ:STRING";
    strParam.gcds_banjaemst.SetDataHeader(s_fslipdtl14);
	}else if(p1=="BANJAE"){
		var s_fslipdtl5 = "FTSTAT:STRING,FDCODE:STRING,TSDAT:STRING,TSNBR:STRING,TSSEQ:STRING,"
		                + "BTSDAT:STRING,BTSNBR:STRING,BTSSEQ:STRING,BANJAEYN:STRING,"	
                    + "SSDAT:STRING,SSNBR:STRING,FSNUM:STRING,BJDEAMT:DECIMAL,BJCRAMT:DECIMAL,"	 
										+ "BSDAT:STRING,BSNBR:STRING,BSNUM:STRING,"
										+ "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
    strParam.gcds_banjae.SetDataHeader(s_fslipdtl5);
	}
}

/***********************************************************************************************
	Description : 계정코드 및 거래처 찾기
	parameter   : p1:  01 - 계정코드   02 - 거래처, 03 - 관리항목
	              p2:  fr 또는 to
**********************************************************************************************/
function ln_Popup(p1,p2){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if (p1=="01"){

		strURL = "./actcode_popup.jsp";
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);	

		if (arrResult != null) {
			arrParam = arrResult.split(";");
			//eval(e).value  = arrParam[0];
			 if(p2=="fr"){
			    txt_atcode_fr.value = arrParam[0];
					txt_atcodenm_fr.value = arrParam[1];
			 }else if(p2=="to"){
			   //** txt_atcode_to.value = arrParam[0];
				 //**	txt_atcodenm_to.value = arrParam[1];
		   }
		} else {
			if(p2=="fr") {
			  txt_atcode_fr.value="";
				txt_atcodenm_fr.value="";
			}else if(p2=="to"){
			 //** txt_atcode_to.value ="";
				//**txt_atcodenm_to.value="";
			}
		}
		
	}else if(p1=="02"){
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,'',strPos);

		if (arrResult != null) {
				arrParam = arrResult.split(";");
			 if(p2=="fr") {
			    txt_custcd_fr.value = arrParam[0];
					txt_custnm_fr.value = arrParam[1];
			 }else if(p2=="to"){
			   //** txt_custcd_to.value = arrParam[0];
					//**txt_custnm_to.value = arrParam[1];
			 }
		} else {
			if(p2=="fr") {
			  txt_custcd_fr.value="";
				txt_custnm_fr.value ="";
			}else if(p2=="to"){
			  //**txt_custcd_to.value="";
				//**txt_custnm_to.value = "";
			}
		}
  }else if(p1=="03"){//관리항목
		strURL = "./commdtil_popup_banjae.jsp";
		if(p2=="fr"){
			arrParam[0]=gclx_fsrefcd.bindcolval;
		}else{
      arrParam[0]="";
		}

		if(txt_fsrefcd_fr.value!=""){
			arrParam[1]= txt_fsrefcd_fr.value;
		}else{
			arrParam[1]= txt_fsrefnm_fr.value;
		}
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if(arrResult != null){
			arrParam = arrResult.split(";");
			if(p2=="fr") {
			  txt_fsrefcd_fr.value = arrParam[0];
				txt_fsrefnm_fr.value = arrParam[1];
		  }
		}else{
			if(p2=="fr") {
			  txt_fsrefcd_fr.value="";
				txt_fsrefnm_fr.value ="";
			}
		}
	}
}


/******************************************************************************
	Description : 전표로 넘길 데이타 저장 (반제Mst)
	parameter   : 
******************************************************************************/
function ln_Data_Mst_Save(i){
    var dblamt=0;
	var dbldeamt=0;
	var dblcramt=0;
	var row=0;

	if(strParam.gcds_banjaemst.countrow<=0){
		ln_SetDataHeader2("BANJAEMST");
	}
	strParam.gcds_banjaemst.AddRow();
	//alert("rowposition::"+gcds_banjaemst.rowposition);
	row = strParam.gcds_banjaemst.rowposition;

    strParam.gcds_banjaemst.namevalue(row,"FDCODE")=gcds_data01.namevalue(i,"FDCODE");
	strParam.gcds_banjaemst.namevalue(row,"TSDAT")=gcds_data01.namevalue(i,"FSDAT");
	strParam.gcds_banjaemst.namevalue(row,"TSNBR")=gcds_data01.namevalue(i,"FSNBR");
	strParam.gcds_banjaemst.namevalue(row,"TSSEQ")=gcds_data01.namevalue(i,"FSSEQ");
	strParam.gcds_banjaemst.namevalue(row,"ATCODE")=gcds_data01.namevalue(i,"ATCODE");

	strParam.gcds_banjaemst.namevalue(row,"DEPTCD")=gcds_data01.namevalue(i,"DEPTCD");   
	strParam.gcds_banjaemst.namevalue(row,"VENDCD")=gcds_data01.namevalue(i,"VENDCD");   
	strParam.gcds_banjaemst.namevalue(row,"FSREFCD")=gcds_data01.namevalue(i,"FSREFCD");   
	strParam.gcds_banjaemst.namevalue(row,"FSREFVAL")=gcds_data01.namevalue(i,"FSREFVAL");

	//차변과 대변을 바꿔서 입력함...............(정산되기 때문)////////////////////////////////////
	strParam.gcds_banjaemst.namevalue(row,"DEAMT")= gcds_data01.namevalue(i,"DAEAMT");
	strParam.gcds_banjaemst.namevalue(row,"CRAMT")= gcds_data01.namevalue(i,"CHAAMT"); 
	///////////////////////////////////////////////////////////////////////////////////////////////
	strParam.gcds_banjaemst.namevalue(row,"STATUS")="";
	strParam.gcds_banjaemst.namevalue(row,"SSDAT")=gcds_data01.namevalue(i,"SSDAT");
	strParam.gcds_banjaemst.namevalue(row,"SSNBR")=gcds_data01.namevalue(i,"SSNBR");
	strParam.gcds_banjaemst.namevalue(row,"FSNUM")=gcds_data01.namevalue(i,"FSNUM");
    strParam.gcds_banjaemst.namevalue(row,"REMARK")=gcds_data01.namevalue(i,"REMARK");

	strParam.gcds_banjaemst.namevalue(row,"WRDT")=gs_date;
	strParam.gcds_banjaemst.namevalue(row,"WRID")=gs_userid;
	strParam.gcds_banjaemst.namevalue(row,"UPDT")=gs_date;
	strParam.gcds_banjaemst.namevalue(row,"UPID")=gs_userid;
	strParam.gcds_banjaemst.namevalue(row,"SEQ")=gs_seq;//전표 행번호

	//반제대상 원래의 금액(정산하기 전의 금액임)///////////////////////////////////////////////////
    if(gcds_data01.namevalue(i,"CHAAMT")==0){ 
		dblAmt = gcds_data01.namevalue(i,"DAEAMT");
		dbldeamt=gcds_data01.namevalue(i,"BANJAEAMT");
		dblcramt=0;
	}else if(gcds_data01.namevalue(i,"DAEAMT")==0){
		dblAmt = gcds_data01.namevalue(i,"CHAAMT");
		dbldeamt=0;
		dblcramt = gcds_data01.namevalue(i,"BANJAEAMT");
	}else{
		if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
			//dblAmt = gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT");
			dblAmt = gcds_data01.namevalue(i,"CHAAMT");
			dbldeamt=0;
			dblcramt = gcds_data01.namevalue(i,"BANJAEAMT");
		}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
			//dblAmt = gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT");
			dblAmt = gcds_data01.namevalue(i,"DAEAMT");
			dbldeamt=gcds_data01.namevalue(i,"BANJAEAMT");
			dblcramt=0;
		}
	}

	strParam.gcds_banjaemst.namevalue(row,"AMT")=dblAmt;

	//차변과 대변 정산 금액    ////////////////////////////////////////////////////////////////////
	strParam.gcds_banjaemst.namevalue(row,"DEAMT")= dbldeamt;
	strParam.gcds_banjaemst.namevalue(row,"CRAMT")= dblcramt; 
	///////////////////////////////////////////////////////////////////////////////////////////////
	
	//prompt('',strParam.gcds_banjaemst.text);

}

/******************************************************************************
	Description : 전표로 넘길 데이타 저장 (반제연결)
	parameter   : 
******************************************************************************/
function ln_Data_Rel_Save(i){
  var row=0;

	if(strParam.gcds_banjae.countrow<=0){
		ln_SetDataHeader2("BANJAE");
	}

	strParam.gcds_banjae.AddRow();
	//alert("rowposition::"+gcds_banjae.rowposition);
    row = strParam.gcds_banjae.rowposition;

    strParam.gcds_banjae.namevalue(row,"FTSTAT")="Y";
	strParam.gcds_banjae.namevalue(row,"FDCODE")=gcds_data01.namevalue(i,"FDCODE");
	strParam.gcds_banjae.namevalue(row,"TSDAT")=gcds_data01.namevalue(i,"FSDAT");
	strParam.gcds_banjae.namevalue(row,"TSNBR")=gcds_data01.namevalue(i,"FSNBR");
	strParam.gcds_banjae.namevalue(row,"TSSEQ")=gcds_data01.namevalue(i,"FSSEQ");

	strParam.gcds_banjae.namevalue(row,"BTSDAT")=gs_fsdat;   //반제접수일자 저장시 접수일자
	strParam.gcds_banjae.namevalue(row,"BTSNBR")="";         //반제접수번호
	strParam.gcds_banjae.namevalue(row,"BTSSEQ")=gs_seq;     //반제SEQ  저장시 접수 SEQ
	strParam.gcds_banjae.namevalue(row,"BANJAEYN")="0";
	strParam.gcds_banjae.namevalue(row,"SSDAT")=gcds_data01.namevalue(i,"SSDAT");  

	strParam.gcds_banjae.namevalue(row,"SSNBR")=gcds_data01.namevalue(i,"SSNBR");
	strParam.gcds_banjae.namevalue(row,"FSNUM")=gcds_data01.namevalue(i,"FSNUM");
	//gcds_banjae.namevalue(row,"BJDEAMT")=gcds_data01.namevalue(i,"CHAAMT");
	//gcds_banjae.namevalue(row,"BJCRAMT")=gcds_data01.namevalue(i,"DAEAMT");
	strParam.gcds_banjae.namevalue(row,"BSDAT")="";

	strParam.gcds_banjae.namevalue(row,"BSNBR")="";
	strParam.gcds_banjae.namevalue(row,"BSNUM")="";
	strParam.gcds_banjae.namevalue(row,"WRDT")=gs_date;  
	strParam.gcds_banjae.namevalue(row,"WRID")=gs_userid;


	if(gcds_data01.namevalue(i,"CHAAMT")==0){ 
		strParam.gcds_banjae.namevalue(row,"BJDEAMT") = gcds_data01.namevalue(i,"BANJAEAMT"); 
		strParam.gcds_banjae.namevalue(row,"BJCRAMT") = 0;
	}else if(gcds_data01.namevalue(i,"DAEAMT")==0){
		strParam.gcds_banjae.namevalue(row,"BJDEAMT") = 0; 
		strParam.gcds_banjae.namevalue(row,"BJCRAMT") = gcds_data01.namevalue(i,"BANJAEAMT");
	}else{
		if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
			strParam.gcds_banjae.namevalue(row,"BJDEAMT") = 0; 
			strParam.gcds_banjae.namevalue(row,"BJCRAMT") = gcds_data01.namevalue(i,"BANJAEAMT");
		}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
			strParam.gcds_banjae.namevalue(row,"BJDEAMT") = gcds_data01.namevalue(i,"BANJAEAMT"); 
			strParam.gcds_banjae.namevalue(row,"BJCRAMT") = 0;
		}
	}
	
	//prompt('',strParam.gcds_banjae.text);

}

/******************************************************************************
	Description : 잔액 계산시 적용
	prameter    : p1 - 01 차변금액만 존재
	                   02 대변금액만 존재
******************************************************************************/
function ln_Amt_Chk(p1,i){
 // alert("p1::"+p1+":i:"+i);
  var tempbjdeamt=0;
	var tempbjcramt=0;
	//alert("strParam.gcds_banjae.countrow::"+strParam.gcds_banjae.countrow);
	if(strParam.gcds_banjae.countrow>0){
		for(j=1;j<=strParam.gcds_banjae.countrow;j++){
			if(gcds_data01.namevalue(i,"FDCODE")==strParam.gcds_banjae.namevalue(j,"FDCODE")&&
				 gcds_data01.namevalue(i,"FSDAT")==strParam.gcds_banjae.namevalue(j,"TSDAT")&&
				 gcds_data01.namevalue(i,"FSNBR")==strParam.gcds_banjae.namevalue(j,"TSNBR")&&
				 gcds_data01.namevalue(i,"FSSEQ")==strParam.gcds_banjae.namevalue(j,"TSSEQ")){
				 
				 if(p1=="02") {
					 tempbjdeamt +=strParam.gcds_banjae.namevalue(j,"BJDEAMT");
				 }else if(p1=="01") {
					 tempbjcramt +=strParam.gcds_banjae.namevalue(j,"BJCRAMT");
				 }
			}
		}//for j
	}//if
  if (p1=="02"){
		return  tempbjdeamt; 
	}else if(p1=="01"){
		return  tempbjcramt; 
	}
}

/******************************************************************************
	Description : 잔액과 gcds_banjae 금액 체크 Row별로 Retrun;
	Parameter   : i - 반제원장의 row
	              gubun - return 값 구분
******************************************************************************/               
function ln_Dtl_Amt_Chk_Return(i,gubun){
	var dblChaamt=0;
	var dblDaeamt=0;

	///alert("ln_Dtl_Amt_Chk_Return");
	for(k=1;k<=strParam.gcds_banjae.countrow;k++){
		if(gcds_data01.namevalue(i,"FDCODE")==strParam.gcds_banjae.namevalue(k,"FDCODE")&&
			 gcds_data01.namevalue(i,"FSDAT")==strParam.gcds_banjae.namevalue(k,"TSDAT")&&
			 gcds_data01.namevalue(i,"FSNBR")==strParam.gcds_banjae.namevalue(k,"TSNBR")&&
			 gcds_data01.namevalue(i,"FSSEQ")==strParam.gcds_banjae.namevalue(k,"TSSEQ")){
        
			 if(gcds_data01.namevalue(i,"DAEAMT")==0){       //차변발생
					dblDaeamt += strParam.gcds_banjae.namevalue(k,"BJCRAMT"); 
			 }else if(gcds_data01.namevalue(i,"CHAAMT")==0){ //대변발생
					dblChaamt+= strParam.gcds_banjae.namevalue(k,"BJDEAMT");
			 }else{
					if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){ //차변발생
						 //dblDaeamt=dblDaeamt+gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")+strParam.gcds_banjae.namevalue(k,"BJDEAMT");
						 dblDaeamt=dblDaeamt+strParam.gcds_banjae.namevalue(k,"BJCRAMT");
						 //alert("dblChaamt"+dblChaamt);
					}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){  //대변발생
						 //dblChaamt=dblChaamt+gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT")+strParam.gcds_banjae.namevalue(k,"BJCRAMT");
						  //alert("dblChaamt"+dblChaamt);
						 dblChaamt=dblChaamt+strParam.gcds_banjae.namevalue(k,"BJDEAMT");
						// alert("222dblChaamt"+dblChaamt);
					}
			 }
		}//if
	}// k for
			
	if(gcds_data01.namevalue(i,"DAEAMT")==0){  //차변발생
		gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"CHAAMT")-dblDaeamt;
	}else if(gcds_data01.namevalue(i,"CHAAMT")==0){
		gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"DAEAMT")-dblChaamt;
	}else{
		if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
      gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")-dblDaeamt;
		}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
			gcds_data01.namevalue(i,"JANAMT")=gcds_data01.namevalue(i,"DAEAMT")-gcds_data01.namevalue(i,"CHAAMT")-dblChaamt;
		}
	}

	if(gubun=="2"){
		return dblDaeamt+dblChaamt;
	}else{
		return gcds_data01.namevalue(i,"JANAMT");
	}
}

/******************************************************************************
	Description : 반제금액 전체 합
	parameter   : 
******************************************************************************/
function ln_Data_Sum(){


}


/******************************************************************************
	Description : 창닫기
	parameter   : A - 선택
******************************************************************************/
function ln_Close(){

    var strfsrefcd="";
	var strfsrefval="";
	var strfsrefvalnm="";
    var strrefcd2="";
	var strrefval2="";
	var strrefvalnm2="";
	var strremark="";  //적요추가 2006.10.25

    gs_rechaamt=0;
	gs_redaeamt=0;

  if(!ln_Chk2()){
		alert("동일항목만 가능합니다.");
		return;
	}

  for(i=1;i<=gcds_data01.countrow;i++){
		if(gcds_data01.namevalue(i,"CHK")=="T"){
			ln_Data_Mst_Save(i);
			ln_Data_Rel_Save(i);

            if(strremark==""){
				strremark =gcds_data01.namevalue(i,"REMARK");
			}
      
			if(gcds_data01.namevalue(i,"DAEAMT")==0){
				gs_rechaamt +=gcds_data01.namevalue(i,"BANJAEAMT");  
			}else if(gcds_data01.namevalue(i,"CHAAMT")==0){
				gs_redaeamt +=gcds_data01.namevalue(i,"BANJAEAMT");  
			}else{
				if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")>0){
					gs_rechaamt +=gcds_data01.namevalue(i,"BANJAEAMT"); 
				}else if(gcds_data01.namevalue(i,"CHAAMT")-gcds_data01.namevalue(i,"DAEAMT")<0){
					gs_redaeamt +=gcds_data01.namevalue(i,"BANJAEAMT");  
				}
			}
      
			//반제단위
			if(strfsrefcd==""&&strfsrefval==""){
				strfsrefcd = gcds_data01.namevalue(i,"FSREFCD");  
				strfsrefval = gcds_data01.namevalue(i,"FSREFVAL");  
				strfsrefvalnm = gcds_data01.namevalue(i,"FSREFNM"); 
				
				//alert("::"+gcds_data01.namevalue(i,"REFCD2")+"::"+gcds_data01.namevalue(i,"REFVAL2"));
				if(gcds_data01.namevalue(i,"REFCD2")!=""&&gcds_data01.namevalue(i,"REFCD2")!=undefined&&gcds_data01.namevalue(i,"REFVAL2")!=""&&gcds_data01.namevalue(i,"REFVAL2")!=undefined){
					strrefcd2=gcds_data01.namevalue(i,"REFCD2");
					strrefval2=gcds_data01.namevalue(i,"REFVAL2");
					strrefvalnm2=gcds_data01.namevalue(i,"REFVALNM2");
				}else{
          strrefcd2="";
					strrefval2="";
					strrefvalnm2="";
				}
			}
		}
	}
  
	window.returnValue = gs_rechaamt+";" 
										 + gs_redaeamt+";"
										 + strfsrefcd+";"
										 + strfsrefval+";"
										 + strfsrefvalnm+";"
										 + strrefcd2+";"
										 + strrefval2+";"
										 + strremark+";"
										 + strrefvalnm2;																				 
	window.close();
	strremark="";
}

/************************************************************************************
	Description : 반제팝업 조회시 동일전표에서 반제한 금액이 존재할 경우 잔액에서 뺌
	              해당 fsseq의 전표를 수정할 경우 이 금액은 제외함.
	parameter   :
******************************************************************************/
function ln_Data_Research(){
  var i=0;
	var j=0;
	var tempbjdeamt=0;
	var tempbjcramt=0;
  
	//반제 연결
	for(i=1;i<=gcds_data01.countrow;i++){
	 
	  tempbjdeamt=0;
    tempbjcramt=0;
		for(j=1;j<=strParam.gcds_banjae.countrow;j++){
			if(gcds_data01.namevalue(i,"FDCODE")==strParam.gcds_banjae.namevalue(j,"FDCODE")&&
				 gcds_data01.namevalue(i,"FSDAT")==strParam.gcds_banjae.namevalue(j,"TSDAT")&&
				 gcds_data01.namevalue(i,"FSNBR")==strParam.gcds_banjae.namevalue(j,"TSNBR")&&
				 gcds_data01.namevalue(i,"FSSEQ")==strParam.gcds_banjae.namevalue(j,"TSSEQ")){
				 
				 if(gcds_data01.namevalue(i,"ATDECR")=="2"){
					 tempbjdeamt += strParam.gcds_banjae.namevalue(j,"BJDEAMT");
				 }else if(gcds_data01.namevalue(i,"ATDECR")=="1"){
					 tempbjcramt += strParam.gcds_banjae.namevalue(j,"BJCRAMT");
				 }
			}
		}//for j
    
		//alert("tempbjdeamt::"+tempbjdeamt+"tempbjcramt::"+tempbjcramt);
		if(gcds_data01.namevalue(i,"ATDECR")=="1"){
			gcds_data01.namevalue(i,"JANAMT")= gcds_data01.namevalue(i,"JANAMT") - tempbjcramt; 
    }else if(gcds_data01.namevalue(i,"ATDECR")=="2"){
      gcds_data01.namevalue(i,"JANAMT")= gcds_data01.namevalue(i,"JANAMT") - tempbjdeamt; 
		}else{
      gcds_data01.namevalue(i,"JANAMT")=0;
		}
	}//for i
}

/******************************************************************************
	Description : 반제 입력 후 다시 수정 할 경우
	              전표행번호로 반제연결의 BTSSEQ이 동일한 것을 찾아서
								반제연결을 삭제하고, 해당 반제연결의 FDCODE, TSDAT, TSNBR, TSSEQ로
								반제원장을 찾아서 금액만큼 차감함.
	parameter   :
******************************************************************************/
function ln_Banjae_Clear(){
	var dblDeamt=0;  //차변
	var dblCramt=0;  //대변

	//반제연결
	for(i=1;i<=strParam.gcds_banjae.countrow;i++){
		if(gs_seq==strParam.gcds_banjae.namevalue(i,"BTSSEQ")){
			 dblDeamt += strParam.gcds_banjae.namevalue(i,"BJDEAMT");	
			 dblCramt += strParam.gcds_banjae.namevalue(i,"BJCRAMT");	
			 strParam.gcds_banjae.DeleteRow(i);
		}
	}//for i

  
	//반제원장
	for(i=1;i<=strParam.gcds_banjaemst.countrow;i++){
		if(gs_seq==strParam.gcds_banjaemst.namevalue(i,"BTSSEQ")){
			 for(j=1;j<=strParam.gcds_banjaemst.countrow;j++){
					if(strParam.gcds_banjae.namevalue(i,"FDCOCD")==strParam.gcds_banjaemst.namevalue(j,"FDCOCD")&&
					   strParam.gcds_banjae.namevalue(i,"TSDAT")==strParam.gcds_banjaemst.namevalue(j,"TSDAT")&&
						 strParam.gcds_banjae.namevalue(i,"TSNBR")==strParam.gcds_banjaemst.namevalue(j,"TSNBR")&&
						 strParam.gcds_banjae.namevalue(i,"TSSEQ")==strParam.gcds_banjaemst.namevalue(j,"TSSEQ")){
						 
						 //반제원장 금액만큼 삭감...
					}
			 }//for j

			 //반제연결 삭제
		}
	}//for i
}

/******************************************************************************
	Description : lost focus 시 
	prameter    : p1 - 01 전표작성
	                   02 내역조회
								p2 - atcode:계정
								obj
******************************************************************************/
function ln_Blur(p1,p2){
	if(p1=="01"){
		if(p2=="fsref_fr"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
			 ln_Popup('03','fr');
		}else if(p2=="fsref_to"){
		   if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
			 ln_Popup('03','to');
		}
	}
}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 반제조회 -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제저장 -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제연결테이블건수 -->
<comment id="__NSID__"><object  id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_fsrefcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
	<PARAM NAME=SortExpr	value="+CDNAM">
</object></comment><script>__ws__(__NSID__);</script> <!--관리항목-->

<!-- 반제단위 -->
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제원장 -->
<comment id="__NSID__"><object  id=gcds_banjaemst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제연결 -->
<comment id="__NSID__"><object  id=gcds_banjae classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t5(I:USER=gcds_data02)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ft_cnt01.innerText="데이타 조회중입니다.";
	//document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
  
 
	if(gcds_data01.countrow<=0){
		alert("조회된 데이타가 없습니다.");
	}else{
	  //2007.06.28 추가한 내용
		if(gcds_data01.namevalue(row,"ATCODE")=="2100520"){
            gcgd_disp01.ColumnProp("REFVALNM2", "Show") = "true";
			gcgd_disp01.ColumnProp("REFVAL2", "Show") = "false";
			gcgd_disp01.ColumnProp("REFVALNM2","Name")="거래처";
		}else{
			gcgd_disp01.ColumnProp("REFVALNM2", "Show") = "false";
			gcgd_disp01.ColumnProp("REFVAL2", "Show") = "true";
			gcgd_disp01.ColumnProp("REFVALNM2","Name")="관리항목2";
		}		

		ln_Data_Research(); //동일 전표에서 반제한 데이타가 존재할 경우 잔액을 뺌 (반제원장, 반제연결)
		
	}

	ft_cnt01.innerText = "조회건수 : " + row + " 건";
	window.status="조회가 완료 되었습니다.";
	//document.all.LowerFrame.style.visibility="hidden";
</script>

<script language="javascript" for="gcds_data03" event="onloadCompleted(row,colid)">
 
 // alert("row"+row);
	if (row==0){
   gs_cnt=0;
	}else{
   gs_cnt=gcds_data03.namevalue(gcds_data03.rowposition,"CNT");
	}
	//alert("gs_cnt"+gs_cnt);	
</script>

<!-- 관리항목 -->
<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
	gcds_fsrefcd.InsertRow(1);
	gcds_fsrefcd.NameValue(1,"CDCODE")="";
	gcds_fsrefcd.NameValue(1,"CDNAM")="";
	gclx_fsrefcd.index=0;
</script>


<!-- 관리항목 -->
<script language="javascript" for="gcds_code01" event="onloadCompleted(row,colid)">
	
	if(gcds_code01.countrow>0){
		gclx_fsrefcd.bindcolval = gcds_code01.namevalue(gcds_code01.rowposition,"FSREFCD");
		gclx_fsrefcd.Enable = false;
	}else{
    gclx_fsrefcd.Enable = true;
	}
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">




  var dbltemp=0;


  if(row>0){
		if(colid=="CHK") {
			
			/*
			if(gs_userid=="6070001"){
				alert("row::"+row+":GCUSTPAY_CHK:"+gcds_data01.namevalue(row,"GCUSTPAY_CHK"));
			}
			*/
		    
		    //2015.07.01 jys  대금지급 생성건은 msgbox 처리 ///////////////////////////////////
		    if(gcds_data01.namevalue(row,"GCUSTPAY_CHK")=="Y"){
		    	if(gcds_data01.namevalue(row,"ATCODE")=="2100110"){
		    		alert("외상매입금 (일반업체)는 일괄 대금지급건입니다. 건별 반제 불가.  ");
		    		return false;
		    	}else if(gcds_data01.namevalue(row,"ATCODE")=="2100510"){
		    		alert("미지급금   (일반업체)는 일괄 대금지급건입니다. 건별 반제 불가.  ");
		    		return false;
		    	}
		    }
		    //////////////////////////////////////////////////////////////////////////////
			
			if(gcds_data01.namevalue(row,"CHK") == "T"){
				if(strParam.gcds_banjae.countrow<=0){
					gcds_data01.namevalue(row,"CHK") = "F";
					gcds_data01.namevalue(row,"JANAMT") = gcds_data01.OrgNameValue(row,"JANAMT");
					gcds_data01.namevalue(row,"BANJAEAMT")=0;
				}else{
					gcds_data01.namevalue(row,"CHK") = "F";
					dbltemp=ln_Dtl_Amt_Chk_Return(row,'');
					gcds_data01.namevalue(row,"JANAMT") =dbltemp;
					gcds_data01.namevalue(row,"BANJAEAMT")=0;
				}
			}else{
				if(strParam.gcds_banjae.countrow<=0){
					gcds_data01.namevalue(row,"CHK") = "T";
					gcds_data01.namevalue(row,"BANJAEAMT")=gcds_data01.namevalue(row,"JANAMT");
					gcds_data01.namevalue(row,"JANAMT")=gcds_data01.namevalue(row,"JANAMT")-gcds_data01.namevalue(row,"BANJAEAMT");
				}else{
					gcds_data01.namevalue(row,"CHK") = "T";
					dbltemp=ln_Dtl_Amt_Chk_Return(row,'');
					//alert("dbltemp::"+dbltemp);
					gcds_data01.namevalue(row,"BANJAEAMT")=dbltemp;
					gcds_data01.namevalue(row,"JANAMT")=dbltemp-gcds_data01.namevalue(row,"BANJAEAMT");
				}
			}
		}
	}

	if(colid=="BANJAEAMT"&&gcds_data01.namevalue(row,"CHK")=="T") {
		gcgd_disp01.editable="true";
	}else{
		gcgd_disp01.editable="false";
	}

  //alert("CHK::"+gcds_data01.namevalue(row,"CHK"));

	/*
  if (gcds_data01.namevalue(row,"GUBUN")=="T"){
		if(gcds_data01.namevalue(row,"CHK")=="T"){
		  gcgd_disp01.ColumnProp('CHK','Edit')="";
			gcgd_disp01.ColumnProp('CHAAMT','Edit')="";
			gcgd_disp01.ColumnProp('DAEAMT','Edit')="";
    }else{
			gcgd_disp01.ColumnProp('CHK','Edit')="";
			gcgd_disp01.ColumnProp('CHAAMT','Edit')="None";
			gcgd_disp01.ColumnProp('DAEAMT','Edit')="None";
		}
		
  }else if (gcds_data01.namevalue(row,"GUBUN")=="D") {
      gcgd_disp01.ColumnProp('CHK','Edit')="None";
			gcgd_disp01.ColumnProp('CHAAMT','Edit')="None";
			gcgd_disp01.ColumnProp('DAEAMT','Edit')="None";
	}
  
	if((row==0) && (gcgd_disp01.GetColumn()=="CHK")){

		if(gcds_data01.namevalue(1,"CHK")=="T"){
			for(i=1;i<=gcds_data01.countrow;i++){
        gcds_data01.namevalue(i,"CHK")="F";
			}
		}else{
			for(i=1;i<=gcds_data01.countrow;i++){
        gcds_data01.namevalue(i,"CHK")="T";
			}
		}
	}

	*/

</script>


<script language="javascript"  for=gcgd_disp01 event=OnExit(row,colid,olddata)>
	var dblAmt=0;
	var dblAmt2=0;
	var tempamt=0;
  
	if(colid=="BANJAEAMT"){
		if(gcds_data01.namevalue(row,"CHAAMT")!=0&&gcds_data01.namevalue(row,"DAEAMT")==0){ //차변발생
			tempamt = ln_Amt_Chk("01",row);
			dblAmt=gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT");
		}else if(gcds_data01.namevalue(row,"CHAAMT")==0&&gcds_data01.namevalue(row,"DAEAMT")!=0){
			tempamt = ln_Amt_Chk("02",row);
			dblAmt=gcds_data01.namevalue(row,"DAEAMT")-gcds_data01.namevalue(row,"CHAAMT");
		}else{
		  if(gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT")>0){ //차변발생
			  tempamt = ln_Amt_Chk("01",row);
				dblAmt=gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT")
      }else if(gcds_data01.namevalue(row,"CHAAMT")-gcds_data01.namevalue(row,"DAEAMT")<0){ //대변발생
		  	tempamt = ln_Amt_Chk("02",row);
        dblAmt=gcds_data01.namevalue(row,"DAEAMT")-gcds_data01.namevalue(row,"CHAAMT");
			}
		}

		if(dblAmt <gcds_data01.namevalue(row,"BANJAEAMT")+tempamt) {
			alert("반제금액이 잔액보다 클 수 없습니다.");
			gcds_data01.namevalue(row,"BANJAEAMT")=olddata;
		}else{
			gcds_data01.namevalue(row,"JANAMT")=Number(dblAmt)-gcds_data01.namevalue(row,"BANJAEAMT")-Number(tempamt);
		}
	}
	  
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_data01 event=OnSuccess()>
	alert("작업이 성공적으로 완료되었습니다.");
	//gs_save="Y";
	//ln_Close();
</script>

<script language=JavaScript for=gctr_data01 event=OnFail()>
	alert("작업이 성공적으로 완료되지 못했습니다.");
	//gs_save="N";
</script>


</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<BODY border="0" cellpadding="0" cellspacing="0" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" OnLoad="ln_Start()">
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td><img src="../img/a020003_head.gif"></td>
		<td width="685px" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
		 <!--  <img src="../../common/img/btn/com_b_close.gif"	  style="cursor:hand" onClick="ln_Close()" > -->
			<img src="../../Common/img/btn/com_btn_send.gif"	  style="cursor:hand" onClick="ln_Close()" >
			<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query()">
		</td>
	</tr>
</table>

<table  cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:860px;height:30px;font-size:9pt;background-color:#ffffff;">
	<tr> 
		<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;계정과목&nbsp;</nobr></td>
		<td class="tab18" style="width:800px;height:30px" ><nobr>&nbsp;
			<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:90px; height:20px;" maxlength="7" onBlur="bytelength(this,this.value,36);">
			<!-- <img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('01','fr');"> -->
			<input id="txt_atcodenm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);">
			<!-- ~&nbsp;
			<input id="txt_atcode_to" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:90px; height:20px;" maxlength="7" onBlur="bytelength(this,this.value,36);" >
	    <img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="계정과목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px;" align=center onclick="ln_Popup('01','to');">
			<input id="txt_atcodenm_to" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" > -->
			</nobr>
		</td> 	
		<td class="tab18" width="70px"  height="30px" style="" bgcolor="#eeeeee"  align=center ><nobr>&nbsp;&nbsp;거래처&nbsp;</nobr></td>
		<td class="tab18" height="30px" style="width:800px;"><nobr>&nbsp;
			<input id="txt_custcd_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:90px; height:20px;" maxlength="13" onBlur="bytelength(this,this.value,36);">
			<!-- <img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="분류코드를 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px" align=center onclick="ln_Popup('02','fr');"> -->
			<input id="txt_custnm_fr" type="text" class="txtbox"  style= "position:relative;top:0px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);">
			<!-- ~&nbsp;
			<input id="txt_custcd_to" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:90px; height:20px;" maxlength="13" onBlur="bytelength(this,this.value,36);" >
	    <img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="분류코드를 검색합니다" style="cursor:hand;position:relative;left:-4px;top:0px" align=center onclick="ln_Popup('02','to');">
			<input id="txt_custnm_to" type="text" class="txtbox"  style= "position:relative;top:3px;left:-4px;width:235px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" > -->
			</nobr>
		</td> 
  </tr>

	<tr>
			<td width="70px"  style="height:30px" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;관리항목&nbsp;</nobr></td>
			<td class="tab19" style="width:800px;height:30px">
			<nobr>&nbsp;<comment id="__NSID__">
				<object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
					style="position:relative;left:3px;top:6px;font-size:12px;width:100px;">
						<param name=ComboDataID    value="gcds_fsrefcd">
						<param name=CBDataColumns	 value="CDCODE,CDNAM">
						<param name=SearchColumn	 value=CDNAM>
						<param name=Sort			     value=false>
						<param name=ListExprFormat value="CDNAM^0^180">								
						<param name=BindColumn		 value="CDCODE">
				</object></comment><script>__ws__(__NSID__);</script> &nbsp;
				<input id="txt_fsrefnm_fr" type="text" class="txtbox"  style= "position:relative;top:-2px;left:-4px;width:155px; height:20px;ime-mode:active; " maxlength="36" onkeydown="ln_Blur('01','fsref_fr','txt_fsrefnm_fr')">
				<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="관리항목을 검색합니다" style="cursor:hand;position:relative;left:-4px;top:4px; height:20px" align=center onclick="ln_Popup('03','fr');"> 
				<input id="txt_fsrefcd_fr" type="text" class="txtbox"  style= "position:relative;top:-2px;left:-4px;width:60px; height:20px;" maxlength="8" onkeydown="ln_Blur('01','fsref_fr','txt_fsrefcd_fr')"><!-- ~&nbsp; -->
			 <!--  <img src="../../common/img/btn/com_b_choice.gif"		style="cursor:hand;position:relative;top:6px;left:0px" onClick="ln_Popup_Choice('02')">  -->
				</nobr>
			</td> 	
			<td class="tab19" width="70px"  height="30px" style="" bgcolor="#eeeeee"  align=center ><nobr>&nbsp;&nbsp;기간&nbsp;</nobr></td>
			<td class="tab19" style="height:30px;width:250px;"><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_actdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_actdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					</nobr> 
			</td>
	</tr>
	<tr>
			<td class="tab17" width="70px"  height="30px" style="" bgcolor="#eeeeee"  align=center >
				<input id="txt_label" type="text"  class="txt41" style= "width:50px;height:20px;position:relative;left:0px;background-color:#eeeeee"  readOnly="true";> 
			</td>
			<td class="tab19" style="height:30px;width:250px;" colspan=3 ><nobr>&nbsp;<comment id="__NSID__">
				<object  id=gcem_date_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">		
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
				 </object></comment><script>__ws__(__NSID__);</script> 
				 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_date_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					~&nbsp;<comment id="__NSID__">
				 <object  id=gcem_date_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">				
									<param name=Text					value="">
									<param name=Alignment     value=0>
									<param name=Border        value=true>
									<param name=Format        value="YYYY/MM/DD">
									<param name=PromptChar    value="_">
									<param name=BackColor     value="#CCCCCC">
									<param name=InheritColor  value=false>
					</object></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_date_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
					</nobr> 
			</td>
	</tr>
	
	<tr>
		<td height=7  colspan =4> </td>
  </tr>
</table>

<fieldset id=field1 style="position:absolute;top:142px;left:4px;height:310px;width:860px;bacground-color:#708090"></fieldset>
<table width="860px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
	<tr> 
		<td>
			<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
			style="position:relative;left:5px;width:850px; height:280px; border:1 solid #708090;display:block;" viewastext>
				<PARAM NAME="DataID"			VALUE="gcds_data01">
				<PARAM NAME="IndWidth"		VALUE ='0'>
				<PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<PARAM NAME="Sortview"		VALUE="left">
				<param name="ColSizing"   value="true">
				<param name="Editable"    value="false">
				<param name="ViewSummary"	value=1>
				<PARAM NAME="Format"			VALUE="              
				<FC> Name='선택'		  ID=CHK 	     HeadAlign=Center HeadBgColor=#B9D4DC Width=28	  align=center SumBgColor=#C3D0DB editstyle=checkbox</FC> 
				<FC> Name='No'		    ID=Currow 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center SumBgColor=#C3D0DB edit=none Value={CurRow} </C> 
				<FC> Name='전표번호'	ID=SSNBR1	   HeadAlign=Center HeadBgColor=#B9D4DC Width=105	  align=center SumBgColor=#C3D0DB edit=none SumText='합   계' </FC> 
				<FC> Name='순번'			ID=FSNUM		 HeadAlign=Center HeadBgColor=#B9D4DC Width=28    align=center SumBgColor=#C3D0DB edit=none </FC> 
				<C> Name='차변'			  ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right	 SumBgColor=#C3D0DB edit=none SumText=@sum color=#0000FF </C> 
				<C> Name='대변'			  ID=DAEAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right  SumBgColor=#C3D0DB edit=none SumText=@sum color=#FF0000</C> 
				<C> Name='잔액'			  ID=JANAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=right  SumBgColor=#C3D0DB edit=none SumText=@sum </C> 
				<C> Name='반제금액'		ID=BANJAEAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=80  	align=right  SumBgColor=#C3D0DB edit=numeric SumText=@sum  BgColor=#ffffcc </C> 
				<C> Name='적요'		    ID=REMARK 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	  align=reft   SumBgColor=#C3D0DB edit=none </C> 
				<C> Name='거래처'		  ID=VENDNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=reft   SumBgColor=#C3D0DB edit=none </C> 
				<C> Name='관리항목'		ID=FSREFNM 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=121	  align=reft   SumBgColor=#C3D0DB edit=none </C> 
				<C> Name='입력일자'	  ID=REFVAL2 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=reft   SumBgColor=#C3D0DB edit=none Mask='XXXX/XX/XX'  </C> 
				<C> Name='관리항목'	  ID=REFVALNM2 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=reft   SumBgColor=#C3D0DB edit=none  </C> 
				">
			</object></comment><script>__ws__(__NSID__);</script> 
			<fieldset style="position:relative;left:5px;width:852px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
				&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
			</fieldset>
		</td>
	</tr>
</table>

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 