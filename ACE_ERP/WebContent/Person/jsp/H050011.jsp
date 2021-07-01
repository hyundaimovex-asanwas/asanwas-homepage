<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명 :  인사_출장신청관리(해외&국내)
+ 프로그램 ID :  H050010.html
+ 기 능 정 의 :  국내, 해외 출장을 등록 및 관리하고, 휴일출장의 경우 
                 특근으로 처리하여 근태와 연동한다.
								 저장 후 전자결재와 연동하여 결재한다.
								 그리고, 휴일특근의 경우 출장 결재시 자동 결재된다.
+ 작   성  자 :  정 영 식
+ 작 성 일 자 :  2007.07.13
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------
+ 수 정 내 용 :	
+ 수   정  자 : 
+ 수 정 일 자 :  
-----------------------------------------------------------------------------
+ 서 블 릿 명 : h050010_s1 - 해외,국내 출장 mst 조회
                h050010_s2 - 국내 출장 dtl 조회
                h050010_t1 - 해외출장 
								h050010_t2 - 국내출장
------------------------------------------------------------------------------>
<html>
<head>
    <jsp:include page="/Sales/common/include/head.jsp"/>
<title></title>
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr">
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<link rel="stylesheet" href="../../Common/include/common.css">

<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
<Script language="javascript" src="../../Common/include/PubFun.js"></script>

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
get_cookdata();
lfn_init();
var gs_date_fr = gcurdate.substring(0,4) + gcurdate.substring(5,7) + "01";
var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var g_managegb="";

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	gcem_frdt.text=gs_date_fr;
  gcem_todt.text=gs_date;
	gclx_closeyn.index=0;
	gclx_closeyn_1.index=0;
	gclx_closeyn_2.index=0;
	gclx_closeyn_1.enable=false;
	gclx_closeyn_2.enable=false;
	ln_Before();
}

/******************************************************************************
	Description : 로딩시 조회
******************************************************************************/
function ln_Before(){

  //관리자구분
	gcds_manager.DataID = "/servlet/Person.hclcode_s2?v_str1=2052&v_str2="+gusrid;
	gcds_manager.Reset();	
	//근태구분
	gcds_lazcd.DataID = "/servlet/Person.hclcode_s1?v_str1=1124&v_str2=G";
	gcds_lazcd.Reset();

	gcds_lazcd_1.DataID = "/servlet/Person.hclcode_s1?v_str1=1124&v_str2=G";
	gcds_lazcd_1.Reset();

	gcds_lazcd_2.DataID = "/servlet/Person.hclcode_s1?v_str1=1124&v_str2=G";
	gcds_lazcd_2.Reset();

  /*
	//소속코드[조회조건]
	gcds_deptcd.DataID = "/servlet/Person.hcdept_s1?v_str1=";
	gcds_deptcd.Reset();
  */

  //소속코드[조회조건]
	if(g_managegb=="Y"){
		gcds_deptcd.DataID = "/servlet/Person.hcdept_s4?v_str1="+gdeptcd;
		gcds_deptcd.Reset();
  }else{
		gcds_deptcd.DataID = "/servlet/Person.hcdept_s1?v_str1=";
		gcds_deptcd.Reset();
	}
	
	//직위코드[검색조건]
	gcds_paygrd.DataID = "/servlet/Person.hclcode_s1?v_str1=2002";
	gcds_paygrd.Reset();

	//해외환율구분
	gcds_ovrategb.DataID = "/servlet/Account.a010001_s2?v_str1=1043";
	gcds_ovrategb.Reset();

  ln_Paygrd_info(gusrid);

	 //교통편구분
	gcds_traffic.DataID = "/servlet/Person.hclcode_s1?v_str1=2053";
	gcds_traffic.Reset();	

	 //
	gcds_instamt.DataID = "/servlet/Person.hclcode_s1?v_str1=2055";
	gcds_instamt.Reset();	

	gcds_infdamt.DataID = "/servlet/Person.hclcode_s1?v_str1=2056";
	gcds_infdamt.Reset();	

	gcds_dayamt.DataID = "/servlet/Person.hclcode_s1?v_str1=2054";
	gcds_dayamt.Reset();	

  //환율
  gcds_exchage.DataID = "/servlet/Person.hclcode_s1?v_str1=2057";
	gcds_exchage.Reset();	

}

/******************************************************************************
	Description : 개인별 직위 정보를 가져옴.
******************************************************************************/
function ln_Paygrd_info(userid){
	gcds_data2.DataID = "/servlet/Person.h050001_s3?v_str1="+userid;
	gcds_data2.Reset();
}

/******************************************************************************
	Description : 사용자에 따른 설정
******************************************************************************/
function ln_User_Setting(gbn){
	gcem_frdt_1.ReadOnly=true;

  if(gclx_lazcd.bindcolval=="G02"){ //국내출장
		if(gbn=="Y"){ //관리자
			gcem_empno_fr.ReadOnly = false;
			gcem_empno_to.ReadOnly = false;
			txt_empnmk.disabled=false;
			txt_empnmk.readOnly =false;
			gclx_deptcd.enable=true;
			gclx_paygrd.enable=true;
			gcem_empno_fr.text = gusrid;
			gcem_empno_to.text = gusrid;
			txt_empnmk.value=gusrnm;

			gclx_deptcd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"DEPTCD");
			gclx_paygrd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"PAYGRD");
			
		}else{        //일반사용자
			gcem_empno_fr.ReadOnly = true;
			gcem_empno_to.ReadOnly = true;
			txt_empnmk.disabled=false;
			txt_empnmk.readOnly =true;
			gclx_deptcd.enable=false;
			gclx_paygrd.enable=false;
			gcem_empno_fr.text = gusrid;
			gcem_empno_to.text = gusrid;
			txt_empnmk.value=gusrnm;

			gclx_deptcd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"DEPTCD");
			gclx_paygrd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"PAYGRD");
				
		}
	}else{
		if(gbn=="Y"){ //관리자
			gclx_ovrategb_1.enable=true;
			//gcem_ovrate_1.enable=true;
      gcem_ovrate_1.ReadOnly=true;

			gcem_ovdsamt_1.enable=true;
			gcem_ovwnamt_1.enable=true;
			gcem_caramt_1.enable=true;
			txt_ovetc_1.disabled=false;

		}else{        //일반사용자
		  /*
			gclx_ovrategb_1.enable=false;
			gcem_ovrate_1.enable=false;
			gcem_ovdsamt_1.enable=false;
			gcem_ovwnamt_1.enable=false;
			gcem_caramt_1.enable=false;
			txt_ovetc_1.disabled=true;
			*/

      gcem_ovrate_1.ReadOnly=true;
			gcem_empno_fr.ReadOnly = true;
			gcem_empno_to.ReadOnly = true;

			txt_empnmk.disabled=false;
			gclx_deptcd.enable=false;
			gclx_paygrd.enable=false;

			gcem_empno_fr.text = gusrid;
			gcem_empno_to.text = gusrid;
			txt_empnmk.value=gusrnm;

			gclx_deptcd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"DEPTCD");
			gclx_paygrd.bindcolval=gcds_data2.namevalue(gcds_data2.rowposition,"PAYGRD");
		}
	}
}

/******************************************************************************
	Description : 조회
	Parameter   : 
******************************************************************************/
function ln_Query(){
  var strdeptcd="";
	if(gclx_deptcd.bindcolval==""){ //전체일 경우
		for(i=1;i<=gcds_deptcd.countrow;i++){
			if(i==1){
				strdeptcd = "'"+gcds_deptcd.namevalue(i,"DEPTCD")+"'";
			}else{
				strdeptcd = strdeptcd+",'"+gcds_deptcd.namevalue(i,"DEPTCD")+"'";
			}
		}
	}else{
		strdeptcd =  "'"+gclx_deptcd.bindcolval+"'"
	}

	strdeptcd = "("+strdeptcd+")";

	if(gclx_lazcd.bindcolval=="G02"){//국내출장
		gcds_data02.DataID = "/servlet/Person.h050010_s1?"
		                   + "v_str1=" + gcem_frdt.text
											 + "&v_str2=" + gcem_todt.text
											 + "&v_str3=" + fn_trim(gcem_empno_fr.text)
											 + "&v_str4=" + fn_trim(gcem_empno_to.text)
											 + "&v_str5=" + fn_trim(txt_empnmk.value)
											 + "&v_str6=" + gclx_lazcd.bindcolval
											 + "&v_str7=" + strdeptcd
											 + "&v_str8=" + gclx_paygrd.bindcolval
											 + "&v_str9=" + gclx_closeyn.bindcolval;
		gcds_data02.Reset();
	}else{
		gcds_data01.DataID = "/servlet/Person.h050010_s1?"
		                   + "v_str1=" + gcem_frdt.text
											 + "&v_str2=" + gcem_todt.text
											 + "&v_str3=" + fn_trim(gcem_empno_fr.text)
											 + "&v_str4=" + fn_trim(gcem_empno_to.text)
											 + "&v_str5=" + fn_trim(txt_empnmk.value)
											 + "&v_str6=" + gclx_lazcd.bindcolval
											 + "&v_str7=" + strdeptcd
											 + "&v_str8=" + gclx_paygrd.bindcolval
											 + "&v_str9=" + gclx_closeyn.bindcolval;
		gcds_data01.Reset();
	}
}

/******************************************************************************
	Description : 국내출장상세 조회
	Parameter   : 
******************************************************************************/
function ln_Query_Dtl(row){
	//if(row<1)return;
	gcds_data03.DataID = "/servlet/Person.h050010_s2?"
										 + "v_str1=" + gcds_data02.namevalue(row,"APPDT")
										 + "&v_str2=" + gcds_data02.namevalue(row,"EMPNO")
										 + "&v_str3=" + gcds_data02.namevalue(row,"LAZCD")
										 + "&v_str4=" + gcds_data02.namevalue(row,"FRDT");	
	gcds_data03.Reset();
}

/******************************************************************************
	Description : 추가
	              Mst Data를 2건이상 동시에 입력하지 못함.
******************************************************************************/
function ln_Add(){
  var cnt=0;
	ln_SetDataHeader();
	if(gclx_lazcd.bindcolval=="G02"){ //국내출장
	  //if(ln_Chk_Save()){
		  var intc=0;
      for(i=1;i<=gcds_data02.countrow;i++){
				if(gcds_data02.SysStatus(i)==1||gcds_data02.SysStatus(i)==2||gcds_data02.SysStatus(i)==3){
					intc+=1;
				}
			}

			if(intc>0){
				alert("저장 후 등록 하십시요.");
				return false;
			}

			for(i=1;i<=gcds_data03.countrow;i++){
				if(gcds_data03.SysStatus(i)==1||gcds_data03.SysStatus(i)==2||gcds_data03.SysStatus(i)==3){
					alert("저장 후 등록하십시요.");
					return false;
				}
			}
			gcds_data02.addrow();
			gcds_data02.namevalue(gcds_data02.rowposition,"APPDT")=gs_date;
			txt_deptnm_2.value	=  gcds_data2.namevalue(gcds_data2.rowpostion,"DEPTNM");		//소속명
			txt_paygrdnm_2.value = gcds_data2.namevalue(gcds_data2.rowpostion,"MINORNM");	//직위
			txt_empnmk_2.value	= gusrnm;																//성명	
			gcem_empno_2.text = gcds_data2.namevalue(gcds_data2.rowpostion,"EMPNO");	 
			txt_deptcd_2.value =gcds_data2.namevalue(gcds_data2.rowpostion,"DEPTCD");	
			txt_paygrd_2.value =gcds_data2.namevalue(gcds_data2.rowpostion,"PAYGRD");	

			gclx_lazcd_2.index=0;
			gcds_lazcd_2.Filter();
			gclx_closeyn_2.index=0;
			gcds_data03.Addrow();
			ln_Query_Dtl(gcds_data02.rowposition);
      ln_User_Setting(g_managegb);
		//}
	}else{
		gcds_data01.addrow();
		gcds_data01.namevalue(gcds_data01.rowposition,"APPDT")=gs_date;
		gclx_lazcd_1.index=0;
		gcds_lazcd_1.Filter();
		gclx_closeyn_1.index=0;
		txt_deptnm_1.value	= gcds_data2.namevalue(gcds_data2.rowpostion,"DEPTNM");		//소속명
		txt_paygrdnm_1.value = gcds_data2.namevalue(gcds_data2.rowpostion,"MINORNM");	//직위
		txt_empnmk_1.value	= gusrnm;																//성명	
		gcem_empno_1.text = gcds_data2.namevalue(gcds_data2.rowpostion,"EMPNO");	 
		txt_deptcd_1.value =gcds_data2.namevalue(gcds_data2.rowpostion,"DEPTCD");	
		txt_paygrd_1.value =gcds_data2.namevalue(gcds_data2.rowpostion,"PAYGRD");	

		gcem_ovrate_1.text = gcds_exchage.namevalue(gcds_exchage.rowposition,"MINORNM");
    gclx_ovrategb_1.index =1;
		gcem_sum_1.text=0;
		
		ln_User_Setting(g_managegb);
 }
}

/******************************************************************************
	Description : 저장
******************************************************************************/
function ln_Save(){
	 if(gclx_lazcd.bindcolval=="G02"){ //국내출장
			if(gcds_data02.IsUpdated||gcds_data03.IsUpdated){
				var row = gcds_data02.rowposition;
				ln_Calc_Days(); //출장일수계산
				if(ln_Chk_Save()){
					if(gcds_data02.SysStatus(row)==3){
						if(gcds_data02.namevalue(row,"CLOSYN")=="I"){
							alert("결재 진행중입니다. 저장할 수 없습니다.");
							return false;
						}else if(gcds_data02.namevalue(row,"CLOSYN")=="Y"){
							alert("결재완료 되었습니다. 저장할 수 없습니다.");
							return false;
						}else if(gcds_data02.namevalue(row,"CLOSYN")=="J"){
							alert("접수완료 되었습니다. 저장할 수 없습니다.");
							return false;
						}else if(gcds_data02.namevalue(row,"CLOSYN")=="S"){
							alert("수신결재완료 되었습니다. 저장할 수 없습니다.");
							return false;
						}
					}

					if(!ln_Chk_Otdt())return;
          
					//국내출장MST
          //DIVCD찾기 
					gcds_data02.namevalue(gcds_data02.rowposition,"DIVCD")=ln_Find_Divcd(gcds_data02.namevalue(gcds_data02.rowposition,"DEPTCD"));
          gcds_data02.namevalue(gcds_data02.rowposition,"APPLYID")=gusrid;
					gcds_data02.namevalue(gcds_data02.rowposition,"WRDT")=gs_date;
					gcds_data02.namevalue(gcds_data02.rowposition,"WRID")=gusrid;
					gcds_data02.namevalue(gcds_data02.rowposition,"UPDT")=gs_date;
					gcds_data02.namevalue(gcds_data02.rowposition,"UPID")=gusrid;

          //국내출장DTL
					for(i=1;i<=gcds_data03.countrow;i++){
					  if(gcds_data03.SysStatus(i)==1||gcds_data03.SysStatus(i)==3){
							gcds_data03.namevalue(i,"WRDT")=gs_date;
							gcds_data03.namevalue(i,"WRID")=gusrid;
							gcds_data03.namevalue(i,"UPDT")=gs_date;
							gcds_data03.namevalue(i,"UPID")=gusrid;
							gcds_data03.namevalue(i,"DEPTCD")=gcds_data02.namevalue(gcds_data02.rowposition,"DEPTCD");
							gcds_data03.namevalue(i,"PAYGRD")=gcds_data02.namevalue(gcds_data02.rowposition,"PAYGRD");
							gcds_data03.namevalue(i,"MEMO")=gcds_data02.namevalue(gcds_data02.rowposition,"MEMO");
							gcds_data03.namevalue(i,"HLNO")=gcds_data02.namevalue(gcds_data02.rowposition,"HLNO");
						}
					}

					if (confirm("저장 하시겠습니까?")){	
						gctr_data02.Action = "/servlet/Person.h050010_t2?";
						//prompt("gcds_data02",gcds_data02.text);
            //prompt("gcds_data03",gcds_data03.text);
						gctr_data02.post();
						ln_Query();
					}	
				}
			}			
	 }else{
			if (gcds_data01.IsUpdated){
				var row = gcds_data01.rowposition;
				ln_Calc_Days(); //출장일수계산
				if(ln_Chk_Save()){
					if(gcds_data01.SysStatus(row)==3){
						if(gcds_data01.namevalue(row,"CLOSYN")=="I"){
							alert("결재 진행중입니다. 저장할 수 없습니다.");
							return false;
						}else if(gcds_data01.namevalue(row,"CLOSYN")=="Y"){
							alert("결재완료 되었습니다. 저장할 수 없습니다.");
							return false;
						}else if(gcds_data01.namevalue(row,"CLOSYN")=="J"){
							alert("접수완료 되었습니다. 저장할 수 없습니다.");
							return false;
						}else if(gcds_data01.namevalue(row,"CLOSYN")=="S"){
							alert("수신결재완료 되었습니다. 저장할 수 없습니다.");
							return false;
						}
					}
          //DIVCD찾기 
          gcds_data01.namevalue(gcds_data01.rowposition,"DIVCD")=ln_Find_Divcd(gcds_data01.namevalue(gcds_data01.rowposition,"DEPTCD"));
          gcds_data01.namevalue(gcds_data01.rowposition,"APPLYID")=gusrid;
					gcds_data01.namevalue(gcds_data01.rowposition,"WRDT")=gs_date;
					gcds_data01.namevalue(gcds_data01.rowposition,"WRID")=gusrid;
					gcds_data01.namevalue(gcds_data01.rowposition,"UPDT")=gs_date;
					gcds_data01.namevalue(gcds_data01.rowposition,"UPID")=gusrid;

					if (confirm("저장 하시겠습니까?")){	
						gctr_data01.Action = "/servlet/Person.h050010_t1?";
						gctr_data01.post();
						ln_Query();
					}	
				}
			}			
	 }
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(){
  if(gclx_lazcd.bindcolval=="G02"){ //국내출장
	  if(!ln_Chk_Delete(gclx_lazcd.bindcolval))return;
		if (confirm("선택한 정보를 삭제하시겠습니까?")){
		  gcds_data02.ClearAllMark();
			for(i=1;i<=gcds_data02.countrow;i++){
				if(gcds_data02.namevalue(i,"CHK")=="T"){
					gcds_data02.MarkRows(i,i);
				}
			}
			gcds_data02.DeleteMarked();
			gctr_data02.action = "/servlet/Person.h050010_t2?";
			gctr_data02.post();
      ln_Query();
		}
	}else{
	  if(!ln_Chk_Delete(gclx_lazcd.bindcolval))return;
		if (confirm("선택한 정보를 삭제하시겠습니까?")){
			gcds_data01.ClearAllMark();
			for(i=1;i<=gcds_data01.countrow;i++){
				if(gcds_data01.namevalue(i,"CHK")=="T"){
					gcds_data01.MarkRows(i,i);
				}
			}
			gcds_data01.DeleteMarked();
			gctr_data01.action = "/servlet/Person.h050010_t1?";
			gctr_data01.post();
		}
	}
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
	Description : 팝업
	Parameter   : 1 - 해외출장
	              2 - 국내출장 mst
******************************************************************************/
function ln_Popup(gbn){
	var arrResult	= new Array();
	var arrSend	= new Array();
	var strURL;	
	var strPos;

	if(g_managegb!="Y"){ //부서관리자가 아닐 경우
		return;
	}else{
		arrSend[1]=gusrid;
	}

	if(gbn=="1"){
	  if(gcds_data01.SysStatus(gcds_data01.rowposition)!=1){
			return false;
		}
	}else if(gbn=="2"){
		if(gcds_data02.SysStatus(gcds_data02.rowposition)!=1){
			return false;
		}
	}

	//arrSend[0]="EMPNO";
	arrSend[0]="H050005";
	strURL = "../../Person/html/H030003_popup.html"
	strPos = "dialogWidth:377px;dialogHeight:383px;dialogTop:270px;dialogLeft:348px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrSend,strPos);

	if(gbn=="0"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_empnmk.value = arrParam[0]; //성명
		} else {
			txt_empnmk.value ="";			//성명
		}
	}else if(gbn=="1"||gbn=="2"){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			eval("txt_empnmk_"+gbn).value = arrParam[0]; //성명
			eval("gcem_empno_"+gbn).text = arrParam[1];  //사번
			eval("txt_deptcd_"+gbn).value=arrParam[4];   //
			eval("txt_deptnm_"+gbn).value=arrParam[2];   //
			eval("txt_paygrd_"+gbn).value=arrParam[5];   //
			eval("txt_paygrdnm_"+gbn).value=arrParam[3]; //
			gcds_data02.namevalue(gcds_data02.rowposition,"MEMO")= arrParam[6];

			if(gbn=="2")ln_Key_Change(gcds_data02.rowposition); //국내출장 상세에 키값 자동 변동함.
		} else {
			eval("txt_empnmk_"+gbn).value  ="";			//성명
			eval("gcem_empno_"+gbn).text="";
			eval("txt_deptcd_"+gbn).value="";   //
			eval("txt_deptnm_"+gbn).value="";   //
			eval("txt_paygrd_"+gbn).value="";   //
			eval("txt_paygrdnm_"+gbn).value=""; //
	  	gcds_data02.namevalue(gcds_data02.rowposition,"MEMO")= "";

		}
	}
}

/******************************************************************************
	Description : 그룹웨어 결재 연동
******************************************************************************/
function ln_Submit(){
	var arrMst	= new Array();
	var arrDtl	= new Array();
	var m=0; //
	var dblovwnamt=0;
	var cnt =0;
	var strFrdt="";
	var yy="";
	var mm="";
	var dd="";
	var strTodt="";
	var yy2="";
	var mm2="";
	var dd2="";
	var strTemp="";
	var strTemp2="";
	var strOtdt="";

	if(!ln_Chk_Submit(gclx_lazcd.bindcolval)) return;

	if(gclx_lazcd.bindcolval=="G02"){ //국내출장
		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"CHK")=="T"){
			   arrMst[0]="HA2";                                        //양식코드
				 arrMst[1]=gusrid;                                       //기안자사번
				 arrMst[2]=fn_trim(gcds_data02.namevalue(i,"OBJECT"));   //출장지       
				 arrMst[3]=fn_trim(gcds_data02.namevalue(i,"TRIPOBJ"));  //출장목적       
				
				 //출장기간
				 strFrdt = gcds_data02.namevalue(i,"FRDT");      //
				 yy = strFrdt.substring(0,4);
				 mm = strFrdt.substring(4,6);
				 dd = strFrdt.substring(6,8);
				 strTemp=yy+" 년 "+mm+" 월 "+dd+" 일"+"  ( "+ gf_dayOfWeek(yy,mm,dd) +" )"  

				 strTodt = gcds_data02.namevalue(i,"TODT");      //
				 yy2 = strTodt.substring(0,4);
				 mm2 = strTodt.substring(4,6);
				 dd2 = strTodt.substring(6,8);
				 strTemp2=yy2+" 년 "+mm2+" 월 "+dd2+" 일"+"  ( "+ gf_dayOfWeek(yy2,mm2,dd2) +" )"  
				 arrMst[4]=strTemp +"~"+ strTemp2;
				 
				 arrMst[7]=fn_trim(gcds_data02.namevalue(i,"REMARK1"));   //비고1
				 arrMst[8]=fn_trim(gcds_data02.namevalue(i,"REMARK2"));   //비고2
				 break; 
			}
		}

		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"CHK")=="T"){
				dblovwnamt=dblovwnamt+gcds_data02.namevalue(i,"OVWNAMT")+gcds_data02.namevalue(i,"CARAMT");
			}
		}
		arrMst[5]=gf_setnum(dblovwnamt);      
    //국내출장 DTL
		//부서, 직위, 사번, 성명, 일자,  구간,  교통, 교통비, 숙박비, 식대, 일비, 계 
		for(j=1;j<=gcds_data02.countrow;j++){
			if(gcds_data02.namevalue(j,"CHK")=="T"){
 				ln_Query_Dtl(j);
				for(k=1;k<=gcds_data03.countrow;k++){
				  cnt+=1;
					arrDtl[0+m]=fn_trim(gcds_data02.namevalue(j,"DIVNM"))//+"/"+fn_trim(gcds_data02.namevalue(j,"DEPTNM"));//부서
					arrDtl[1+m]=gcds_data02.namevalue(j,"PAYGRDNM");//직위
					arrDtl[2+m]=gcds_data02.namevalue(j,"EMPNMK");  //성명
					strOtdt=gcds_data03.namevalue(k,"OTDT");        //일자
					strOtdt = strOtdt.substring(4,6)+"/"+ strOtdt.substring(6,8);
          arrDtl[3+m]=strOtdt;  
					arrDtl[4+m]=gcds_data03.namevalue(k,"SECTION"); //구간
					arrDtl[5+m]=gcds_data03.namevalue(k,"TRAFFICNM"); //교통편
					arrDtl[6+m]=gf_setnum(gcds_data03.namevalue(k,"CARFARE")); //교통비
					arrDtl[7+m]=gf_setnum(gcds_data03.namevalue(k,"INSTAMT")); //숙박비
					arrDtl[8+m]=gf_setnum(gcds_data03.namevalue(k,"INFDAMT")); //식비
					arrDtl[9+m]=gf_setnum(gcds_data03.namevalue(k,"INDAYAMT")); //일비
					arrDtl[10+m]=gf_setnum(gcds_data03.namevalue(k,"CARFARE")+gcds_data03.namevalue(k,"INSTAMT")+gcds_data03.namevalue(k,"INFDAMT")+gcds_data03.namevalue(k,"INDAYAMT")); //계					
					arrDtl[11+m]=gcds_data02.namevalue(j,"HLNO");  //출장번호
					m+=12;
				}
			}
		}
		arrMst[6]=cnt; 
	}else{                       //해외출장
		//해외출장 MST
		//출장지, 출장목적, 출장기간
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
				 arrMst[0]="HA3";                                        //양식코드
				 arrMst[1]=gusrid;                                       //기안자사번
				 arrMst[2]=fn_trim(gcds_data01.namevalue(i,"OBJECT"));   //출장지       
	 		   arrMst[3]=fn_trim(gcds_data01.namevalue(i,"TRIPOBJ"));  //출장목적       
				
         //출장기간
				 strFrdt = gcds_data01.namevalue(i,"FRDT");      //
				 yy = strFrdt.substring(0,4);
				 mm = strFrdt.substring(4,6);
				 dd = strFrdt.substring(6,8);
				 strTemp=yy+" 년 "+mm+" 월 "+dd+" 일"+"  ( "+ gf_dayOfWeek(yy,mm,dd) +" )";  

				 strTodt = gcds_data01.namevalue(i,"TODT");      //
				 yy2 = strTodt.substring(0,4);
				 mm2 = strTodt.substring(4,6);
				 dd2 = strTodt.substring(6,8);
				 strTemp2=yy2+" 년 "+mm2+" 월 "+dd2+" 일"+"  ( "+ gf_dayOfWeek(yy2,mm2,dd2) +" )";  
 
         arrMst[4]=strTemp +"~"+ strTemp2;
				 arrMst[6]=gcds_data01.namevalue(i,"OVRATE");//환율  

				 arrMst[8]=fn_trim(gcds_data01.namevalue(i,"REMARK1"));   //비고1       
	 		   arrMst[9]=fn_trim(gcds_data01.namevalue(i,"REMARK2"));   //비고2  
				 break;
			}
		}

		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
				dblovwnamt=dblovwnamt+gcds_data01.namevalue(i,"OVWNAMT")+gcds_data01.namevalue(i,"CARAMT")+gcds_data01.namevalue(i,"OVFDAMT");
				cnt+=1;
			}
		}
		arrMst[5]=gf_setnum(dblovwnamt);      
		arrMst[7]=cnt; 

    //해외출장 DTL
		//부서, 직위, 사번, 성명, 기간,  일수,  출장비, 환율, 식비, 교통비 
		for(j=1;j<=gcds_data01.countrow;j++){
			if(gcds_data01.namevalue(j,"CHK")=="T"){
        arrDtl[0+m]=fn_trim(gcds_data01.namevalue(j,"DIVNM")) //+"/"+fn_trim(gcds_data01.namevalue(j,"DEPTNM"));//부서
				arrDtl[1+m]=gcds_data01.namevalue(j,"PAYGRDNM");//직위
				arrDtl[2+m]=gcds_data01.namevalue(j,"EMPNMK");//성명
				strFrdt = gcds_data01.namevalue(j,"FRDT");      //
				mm = strFrdt.substring(4,6);
				dd = strFrdt.substring(6,8);
				strTodt = gcds_data01.namevalue(j,"TODT");      //
				mm2 = strTodt.substring(4,6);
				dd2 = strTodt.substring(6,8);
				arrDtl[3+m]=mm+"/"+dd+"-"+mm2+"/"+dd2;//기간
				arrDtl[4+m]=gcds_data01.namevalue(j,"INTRDAY");//일수
				arrDtl[5+m]=gcds_data01.namevalue(j,"OVETC");  //출장비
				arrDtl[6+m]=gf_setnum(gcds_data01.namevalue(j,"OVFDAMT"));//식비
				arrDtl[7+m]=gf_setnum(gcds_data01.namevalue(j,"CARAMT"));//교통비
				arrDtl[8+m]=gf_setnum(gcds_data01.namevalue(j,"OVWNAMT")+gcds_data01.namevalue(j,"OVFDAMT")+gcds_data01.namevalue(j,"CARAMT"));//합계
				arrDtl[9+m]=gcds_data01.namevalue(j,"HLNO");  //출장번호
				m+=10;
			}
		}
	}

	//기안호출
	//document.all("ifrm").src ="../../Person/html/GP_form.html";
	ifrm.ln_Popup(arrMst[0],arrMst,arrDtl);
}
/******************************************************************************
	Description : 화면 Display
	prameter    : 
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp01","div_disp02");
	for(var i=0;i<=1;i++)	{
		if(i==index) {
			eval("document.all."+div_cm[i]+".style.display='block';");
		}else{
		  eval("document.all."+div_cm[i]+".style.display='none';");
		}
	}
}

/******************************************************************************
	Description : 국내출장 상세 행추가
	prameter    : 
******************************************************************************/
function ln_Dtl_Add(){
   var row=gcds_data02.rowposition;
  //상위 그리드가 아무것도 없을 경우 행추가 안됨.
	//상위 그리드의 키값을 입력했을 경우 가져옴.
	//만약 상위 그리드의 키값을 변경할 경우 하위 그리드도 함께 변경되어야함.
	ln_SetDataHeader2();
	if(gclx_lazcd.bindcolval=="G02"){ //국내출장
	 
		if(gcds_data02.countrow==0||row<1){
			alert("행추가 할 수 없습니다.");
			return false;
		}

		if(fn_trim(gcds_data02.namevalue(row,"APPDT"))==""||fn_trim(gcds_data02.namevalue(row,"EMPNO"))==""||
		   fn_trim(gcds_data02.namevalue(row,"EMPNMK"))==""||fn_trim(gcds_data02.namevalue(row,"LAZCD"))==""||
			 fn_trim(gcds_data02.namevalue(row,"FRDT"))==""){
			 alert("입력값이 없습니다. 입력 후 행 추가하십시요.");
			 return false;
		}
		gcds_data03.addrow();
		gcds_data03.namevalue(gcds_data03.rowposition,"APPDT")=gcds_data02.namevalue(row,"APPDT");
		gcds_data03.namevalue(gcds_data03.rowposition,"EMPNO")=gcds_data02.namevalue(row,"EMPNO");
		gcds_data03.namevalue(gcds_data03.rowposition,"EMPNMK")=gcds_data02.namevalue(row,"EMPNMK");
		gcds_data03.namevalue(gcds_data03.rowposition,"LAZCD")=gcds_data02.namevalue(row,"LAZCD");
		gcds_data03.namevalue(gcds_data03.rowposition,"FRDT")=gcds_data02.namevalue(row,"FRDT");
		gcds_data03.namevalue(gcds_data03.rowposition,"OTDT")=gcds_data02.namevalue(row,"FRDT");
		gcds_data03.namevalue(gcds_data03.rowposition,"MEMO")=gcds_data02.namevalue(row,"MEMO");
		ln_Todt_Setting();
		gclx_traffic_2.index=0;

	}
}

/******************************************************************************
	Description : 국내출장 상세 행삭제
	prameter    : 
******************************************************************************/
function ln_Dtl_Del(){
	if(gclx_lazcd.bindcolval=="G02"){ //국내출장
		gcds_data03.deleterow(gcds_data03.rowposition);
		ln_Wn_AutoSum();
		ln_Todt_Setting();
	}else{
		ln_OV_AutoSum();
	}
}

/******************************************************************************
	Description : 국내출장 Mst변경시 상세도 변경함.
	prameter    : 
******************************************************************************/
function ln_Key_Change(row){
	for(i=1;i<=gcds_data03.countrow;i++){
		gcds_data03.namevalue(i,"APPDT")=gcds_data02.namevalue(row,"APPDT");
		gcds_data03.namevalue(i,"EMPNO")=gcds_data02.namevalue(row,"EMPNO");
		gcds_data03.namevalue(i,"EMPNMK")=gcds_data02.namevalue(row,"EMPNMK");
		gcds_data03.namevalue(i,"LAZCD")=gcds_data02.namevalue(row,"LAZCD");
		gcds_data03.namevalue(i,"FRDT")=gcds_data02.namevalue(row,"FRDT");
		gcds_data03.namevalue(i,"HLNO")=gcds_data02.namevalue(row,"HLNO");
	}
}

/************************************************************************************************************
	Description : 본부코드 찾기
	parameter   :
*************************************************************************************************************/
function ln_Find_Divcd(strdeptcd){
	  if(strdeptcd=="")return;
		gcds_divcd.DataID = g_servlet+"/Account.a020001_s9?v_str1="+strdeptcd;		
		//prompt('',gcds_divcd.DataID);
		gcds_divcd.Reset();
    if(gcds_divcd.countrow>0){
			return gcds_divcd.namevalue(gcds_divcd.rowposition,"DIVCD");
		}else{
			return;
		}
}
/******************************************************************************
	Description : 출장일수계산
	prameter    : 
******************************************************************************/
function ln_Calc_Days(){
  if(gclx_lazcd.bindcolval=="G02"){ //국내출장
		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.SysStatus(i)==1||gcds_data02.SysStatus(i)==3){
				 gcds_data02.namevalue(i,"INTRDAY") = ln_DataChk(gcds_data02.namevalue(i,"FRDT"),gcds_data02.namevalue(i,"TODT"));
			}
		}
	}else{
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.SysStatus(i)==1||gcds_data01.SysStatus(i)==3){
				 gcds_data01.namevalue(i,"INTRDAY") = ln_DataChk(gcds_data01.namevalue(i,"FRDT"),gcds_data01.namevalue(i,"TODT"));
			}
		}
	} 
}

/******************************************************************************
	Description : 날짜 사이 조회
	Parameter   : frdt - 출발일, todt - 복귀일
******************************************************************************/
function ln_DataChk(frdt,todt) { 
	var fryy =frdt.substring(0,4);
	var frmm =frdt.substring(4,6);
	var frdd =frdt.substring(6,8);

	var toyy =todt.substring(0,4);
	var tomm =todt.substring(4,6);
	var todd =todt.substring(6,8);

	frdate=new Date(fryy,frmm-1,frdd); //월에서는 1을 뺀다 
	todate=new Date(toyy,tomm-1,todd); //오늘날짜 

	frtime=frdate.getTime(); //출발시각 
	totime=todate.getTime(); //복구시각
	cha=totime-frtime;       //시각차이 
	conv=Math.floor(cha/(60*60*24*1000))+1; //시각차이를 일자차이로 계산 
	return conv
}

/******************************************************************************
	Description : 저장시 체크
	prameter    : 
******************************************************************************/
function ln_Chk_Save(){
  
	if(gclx_lazcd.bindcolval=="G02"){//국내출장
		
		for(j=1;j<=gcds_data02.countrow;j++){
			if(gcds_data02.SysStatus(j)==1||gcds_data02.SysStatus(j)==3){
				if(gcds_data02.namevalue(j,"EMPNO")==""||gcds_data02.namevalue(j,"EMPNMK")==""){
					alert("성명을 확인하세요.");
					return false;
				}
				if(gcds_data02.namevalue(j,"DEPTCD")==""||gcds_data02.namevalue(j,"DEPTNM")==""){
					alert("부서를 확인하세요.");
					return false;
				}
				if(gcds_data02.namevalue(j,"PAYGRD")==""||gcds_data02.namevalue(j,"PAYGRDNM")==""){
					alert("직위를 확인하세요.");
					return false;
				}
				if(gcds_data02.namevalue(j,"LAZCD")==""){
					alert("근태구분을 확인하세요.");
					return false;
				}
				if(gcds_data02.namevalue(j,"TRIPOBJ")==""){
					alert("출장목적을 확인하세요.");
					return false;
				}
				if(gcds_data02.namevalue(j,"FRDT")==""){
					alert("출발일을 확인하세요.");
					return false;
				}
        if(gcds_data02.namevalue(j,"TODT")==""){
					alert("복귀일을 확인하세요.");
					return false;
				}
				if(gcds_data02.namevalue(j,"FRDT")<=gs_date){
					alert("출발일은 현재일보다 크야합니다.");
					return false;
				}
				if(gcds_data02.namevalue(j,"FRDT")>gcds_data02.namevalue(j,"TODT")){
					alert("복귀일이 출발일보다 같거나 크야합니다.");
					return false;
				}
				if(gcds_data02.namevalue(j,"OBJECT")==""){
					alert("목적지를 확인하세요.");
					return false;
				}
			}
		}
		
	
		//상세입력확인///////////////////////
		for(i=1;i<=gcds_data03.countrow;i++){
			if(fn_trim(gcds_data03.namevalue(i,"OTDT"))==""){
				alert("일자를 확인하십시요.");
				return false;
			}

			/*
			if(gcds_data03.namevalue(i,"SECTION")==""){
				alert("구간을 확인하세요.");
				return false;
			}
			*/
			//출장일은 출발일과 복귀일 사이에 있어야한다.
			if(gcds_data03.namevalue(i,"OTDT")<gcem_frdt_2.text||gcds_data03.namevalue(i,"OTDT")>gcem_todt_2.text){
				alert("일자를 확인하십시요.");
				return false;
			}

			if(gcds_data03.namevalue(i,"CARFARE")==0&&gcds_data03.namevalue(i,"INSTAMT")==0&&
			   gcds_data03.namevalue(i,"INFDAMT")==0&&gcds_data03.namevalue(i,"INDAYAMT")==0){
				alert("상세입력에서 비용을 입력하십시요");
				return false;
			}
		}
		////////////////////////////////////

	}else{
		/***공통***/
		if(gcem_empno_1.text==""||txt_empnmk_1.value==""){//성명
			alert("성명을 확인하세요.");
			return false;
		}
		if(txt_deptcd_1.value==""||txt_deptnm_1.value==""){//소속
			alert("소속을 확인하세요.");
			return false;
		}
		if(txt_paygrd_1.value==""||txt_paygrdnm_1.value==""){//직위
			alert("직위를 확인하세요.");
			return false;
		}
		if(gclx_lazcd_1.bindcolval==""||gclx_lazcd_1.text==""){//근태
			alert("근태구분을 확인하세요.");
			return false;
		}
		if(txt_tripobj_1.value==""){//출장목적
			alert("출장목적을 확인하세요.");
			return false;
		}
		if(gcem_frdt_1.text==""){//
			alert("출발일을 확인하세요.");
			return false;
		}
		if(gcem_todt_1.text==""){//
			alert("복귀일을 확인하세요.");
			return false;
		}
    //출발일>=현재일보
		if(gcem_frdt_1.text<=gs_date){
			alert("출발일은 현재일보다 크야합니다.");
			return false;
		}
		//복귀일>=출발일
		if(gcem_frdt_1.text>gcem_todt_1.text){
			alert("복귀일이 출발일보다 같거나 크야합니다.");
			return false;
		}
		if(txt_object_1.value==""){//
			alert("목적지를 확인하세요.");
			return false;
		}

		//if(g_managegb=="Y"){ //관리자
			if(gclx_ovrategb_1.bindcolval==""||gclx_ovrategb_1.text==""){//
				alert("환율구분을 확인하세요.");
				return false;
			}
		  if(gcem_ovrate_1.text==""||gcem_ovrate_1.text==0){//
				alert("환율를 확인하세요.");
				return false;
			}
      if(gcem_ovdsamt_1.text==""||gcem_ovdsamt_1.text==0){//
				alert("달러를 확인하세요.");
				return false;
			}
			if(gcem_ovwnamt_1.text==""||gcem_ovwnamt_1.text==0){//
				alert("원화를 확인하세요.");
				return false;
			}
			if(gcem_caramt_1.text==""||gcem_caramt_1.text==0){//
				alert("교통비를 확인하세요.");
				return false;
			}
			if(fn_trim(txt_ovetc_1.value)==""){//
				alert("비고를 확인하세요.");
				return false;
			}

		//}
	}
	return true;
}

/******************************************************************************
	Description : 국내출장에서 출발일과 복귀일 사이의 날짜와 출장일 비교
  parameter   :
******************************************************************************/
function ln_Chk_Otdt(){
	var chk="";
	//출장일과 복귀일 사이의 모든 일자가 존재해야한다.
	step2:
	for(k=gcds_data02.namevalue(gcds_data02.rowposition,"FRDT");k<=gcds_data02.namevalue(gcds_data02.rowposition,"TODT");k++){
		step1:
		for(j=1;j<=gcds_data03.countrow;j++){
			if(k==gcds_data03.namevalue(j,"OTDT")){
			  chk="1";
				break step1;
			}else{
				chk="0";
			}
		}
		if(chk==""||chk=="0"){
			alert(k+" 일자가 존재하지 않습니다.");
			return false;
			break step2;
		}
	}
	return true;
}

/******************************************************************************
	Description : 국내출장 금액 자동 Sum
  parameter   :
******************************************************************************/
function ln_Wn_AutoSum(){
	var lngovamt =0;
	for(i=1;i<=gcds_data03.countrow;i++){
		if(gcds_data03.SysStatus(i)!=2){
			lngovamt=lngovamt+gcds_data03.namevalue(i,"CARFARE")+gcds_data03.namevalue(i,"INSTAMT")
							+gcds_data03.namevalue(i,"INFDAMT")+gcds_data03.namevalue(i,"INDAYAMT");
		}
	}
	gcds_data02.namevalue(gcds_data02.rowposition,"OVWNAMT")=lngovamt
}

/******************************************************************************
	Description : 해외 금액 자동 Sum
  parameter   :
******************************************************************************/
function ln_OV_AutoSum(){
	var row = gcds_data01.rowposition;
	if(gcds_data01.SysStatus(row)!=2){
		gcem_sum_1.text=gcds_data01.namevalue(row,"OVWNAMT")+gcds_data01.namevalue(row,"CARAMT")+gcds_data01.namevalue(row,"OVFDAMT");
	}
}

/******************************************************************************
	Description : 국내출장 복귀일 자동으로 상세에서 찾아서 설정함.
  parameter   :
******************************************************************************/
function ln_Todt_Setting(){
	gcds_data02.namevalue(gcds_data02.rowposition,"TODT")=gcds_data03.Max(5,0,0);
}
/******************************************************************************
	Description : Dataset Head 설정 - 해외/국내 출장 mst
  parameter   :
******************************************************************************/
function ln_SetDataHeader(){
	if(gclx_lazcd.bindcolval=="G02"){ //국내출장 MST
		if (gcds_data02.countrow<1){
			var s_temp = "CHK:STRING(1),APPDT:STRING(8),EMPNO:STRING(7),LAZCD:STRING(4),FRDT:STRING(8),TODT:STRING(8),"
								 + "DIVCD:STRING(4),DEPTCD:STRING(4),PAYGRD:STRING(4),OBJECT:STRING(30),TRIPOBJ:STRING(50),"
								 + "CARAMT:DECIAML(7.0),OVRATEGB:STRING(4),OVRATE:DECIAML(8.4),OVDSAMT:DECIAML(7.0),OVWNAMT:DECIAML(7.0),OVETC:STRING(100),"
								 + "INTRDAY:DECIAML(7.0),APPLYID:STRING(7),CLOSYN:STRING(1),"
								 + "WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10),"
                 + "EMPNMK:STRING(20),PAYGRDNM:STRING(30),DEPTNM:STRING(50),ORGFRDT:STRING(8),ORGTODT:STRING(8),MEMO:STRING(30),"
								 + "DIVNM:STRING(50),OVFDAMT::DECIAML(7.0), HLNO:STRING(14), REMARK1:STRING(130), REMARK2:STRING(130)";
			gcds_data02.SetDataHeader(s_temp);
		}
	}else{
		if (gcds_data01.countrow<1){
			var s_temp = "CHK:STRING(1),APPDT:STRING(8),EMPNO:STRING(7),LAZCD:STRING(4),FRDT:STRING(8),TODT:STRING(8),"
								 + "DIVCD:STRING(4),DEPTCD:STRING(4),PAYGRD:STRING(4),OBJECT:STRING(30),TRIPOBJ:STRING(50),"
								 + "CARAMT:DECIAML(7.0),OVRATEGB:STRING(4),OVRATE:DECIAML(8.4),OVDSAMT:DECIAML(7.0),OVWNAMT:DECIAML(7.0),OVETC:STRING(100),"
								 + "INTRDAY:DECIAML(7.0),APPLYID:STRING(7),CLOSYN:STRING(1),"
								 + "WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),UPID:STRING(10),"
								 + "EMPNMK:STRING(20),PAYGRDNM:STRING(30),DEPTNM:STRING(50),ORGFRDT:STRING(8),ORGTODT:STRING(8),MEMO:STRING(30),"
								 + "DIVNM:STRING(50),OVFDAMT::DECIAML(7.0), HLNO:STRING(14), REMARK1:STRING(130), REMARK2:STRING(130)";
			gcds_data01.SetDataHeader(s_temp);
		}
	}
}

/******************************************************************************
	Description : Dataset Head 설정 
  parameter   :
******************************************************************************/
function ln_SetDataHeader2(){
	if(gclx_lazcd.bindcolval=="G02"){ //국내출장상세
		if (gcds_data03.countrow<1){
			var s_temp = "APPDT:STRING(8),EMPNO:STRING(7),LAZCD:STRING(4),FRDT:STRING(8),OTDT:STRING(8),"
			           + "OTSEQ:STRING(2),SECTION:STRING(20),TRAFFIC:STRING(4),CARFARE:DECIAML(7.0),INSTAMT:DECIAML(7.0),"
								 + "INFDAMT:DECIAML(7.0),INDAYAMT:DECIAML(7.0),WRDT:STRING(8),WRID:STRING(10),UPDT:STRING(8),"
								 + "UPID:STRING(10),EMPNMK:STRING(20),"
								 + "ORGAPPDT:STRING(8),ORGEMPNO:STRING(7),ORGLAZCD:STRING(4),ORGFRDT:STRING(8),ORGOTDT:STRING(8),"
								 + "ORGOTSEQ:STRING(2),DEPTCD:STRING(4),PAYGRD:STRING(4),MEMO:STRING(30)";
			gcds_data03.SetDataHeader(s_temp);
		}
	}
}

/******************************************************************************
	Description : 달력관련
  parameter   : 수정건의 경우 출발일은 key값이라서 수정 못하게 막음.
******************************************************************************/
function ln_Calendar(gbn){
  if(gclx_lazcd.bindcolval=="G02"){ //국내출장	
		if(gbn=="fr"){
			if(gcds_data02.SysStatus(gcds_data02.rowposition)!=1){
				return false;
			}
			__GetCallCalendar('gcem_frdt_2','Text');
		}else if(gbn=="ot"){
			__GetCallCalendar('gcem_otdt_2','Text');
      gcem_otdt_2.Focus();
		}
  }else{
		if(gbn=="fr"){
			if(gcds_data01.SysStatus(gcds_data01.rowposition)!=1){
				return false;
			}
			__GetCallCalendar('gcem_frdt_1','Text');
		}
	}
}

/******************************************************************************
	Description : 조회시 Loading bar start
  parameter   :
******************************************************************************/
function ln_Loading_Start(){
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.1";
	//document.all.LowerFrame.style.visibility="visible";
}
/******************************************************************************
	Description : 조회시 Loading bar end
  parameter   :
******************************************************************************/
function ln_Loading_End(row){
	window.status="조회가 완료 되었습니다.";
	lbl_search.innerText = "( " + row + " 건 )";
	//document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
}

/******************************************************************************
	Description : 결재시체크
	Parameter :
******************************************************************************/
function ln_Chk_Submit(gbn){
	var cnt=0;
	if(gusrid==""||gusrid==null) return false;
	if(gbn=="") return false;
	if(gbn=="G02"){//국내
		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"CHK")=="T"){
				if(gcds_data02.namevalue(i,"CLOSYN")!=""&&gcds_data02.namevalue(i,"CLOSYN")!="N"){
					alert("결재할 수 없습니다.결재상태를 확인하십시요.");
					return false;
				}
				cnt+=1;
			}
		}
		if(cnt==0){
			alert("결재할 대상을 선택하십시요.");
			return false;
		}
	}else if(gbn=="G03"){
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
				if(gcds_data01.namevalue(i,"CLOSYN")!=""&&gcds_data01.namevalue(i,"CLOSYN")!="N"){
					alert("결재할 수 없습니다.결재상태를 확인하십시요.");
					return false;
				}
				cnt+=1;
			}
		}
		if(cnt==0){
			alert("결재할 대상을 선택하십시요.");
			return false;
		}
	}
	return true;
}

/******************************************************************************
	Description : 삭제시 체크
	Parameter :
******************************************************************************/
function ln_Chk_Delete(gbn){
	var cnt=0;
	if(gbn=="") return false;
	if(gbn=="G02"){//국내
		for(i=1;i<=gcds_data02.countrow;i++){
			if(gcds_data02.namevalue(i,"CHK")=="T"){
				if(gcds_data02.namevalue(i,"CLOSYN")!=""&&gcds_data02.namevalue(i,"CLOSYN")!="N"){
					alert("삭제할 수 없습니다.");
					return false;
				}
				cnt+=1;
			}
		}
		if(cnt==0){
			alert("삭제할 대상을 선택하십시요.");
			return false;
		}
	}else if(gbn=="G03"){
		for(i=1;i<=gcds_data01.countrow;i++){
			if(gcds_data01.namevalue(i,"CHK")=="T"){
				if(gcds_data01.namevalue(i,"CLOSYN")!=""&&gcds_data01.namevalue(i,"CLOSYN")!="N"){
					alert("삭제할 수 없습니다.");
					return false;
				}
				cnt+=1;
			}
		}
		if(cnt==0){
			alert("삭제할 대상을 선택하십시요.");
			return false;
		}
	}
	return true;
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<OBJECT id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 해외출장 -->
</OBJECT>

<OBJECT id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!--국내출장mst-->
</OBJECT>

<OBJECT id=gcds_data03 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!--국내출장dtl-->
</OBJECT>

<OBJECT id=gcds_lazcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_lazcd_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"  VALUE="false">
	<param name="UseFilter"	value="true">
</OBJECT>

<OBJECT id=gcds_lazcd_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad"  VALUE="false">
	<param name="UseFilter"	value="true">
</OBJECT>

<OBJECT id=gcds_deptcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_paygrd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<OBJECT id=gcds_ovrategb classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_manager classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 관리자구분 -->
</OBJECT>

<OBJECT  id=gcds_divcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!--부서로 본부코드 찾기-->
</OBJECT>

<OBJECT id=gcds_traffic classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 교통편구분 -->
</OBJECT>

<OBJECT id=gcds_instamt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 숙박비 -->
</OBJECT>

<OBJECT id=gcds_infdamt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 식비-->
</OBJECT>

<OBJECT id=gcds_dayamt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 일비 -->
</OBJECT>

<OBJECT id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>


<OBJECT id=gcds_exchage classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 출장환율 -->
</OBJECT>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
 <comment id="__NSID__"><OBJECT id=gctr_data01 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050010_t1(I:USER=gcds_data01)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

 <comment id="__NSID__"><OBJECT id=gctr_data02 classid=clsid:0A2233AD-E771-11D2-973D-00104B15E56F VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="h050010_t1(I:USER=gcds_data02,I:USER2=gcds_data03)">
</OBJECT></comment><script>__ws__(__NSID__);</script>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	ln_Loading_Start();
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	ln_Loading_End(row);
</script>

<script language="javascript" for="gcds_data02" event="OnLoadStarted()">
	ln_Loading_Start();
</script>

<script language="javascript" for="gcds_data02" event="onloadCompleted(row,colid)">
	ln_Loading_End(row);
	if(row>0)	ln_Query_Dtl(gcds_data02.rowposition);
	else ln_Query_Dtl(0);
</script>

<script language="javascript" for="gcds_manager" event="onloadCompleted(row,colid)">
	if(row>0){ //관리자
		ln_User_Setting('Y');
		g_managegb="Y";
	}else{     //일반사용자
    ln_User_Setting('N'); 
		g_managegb="N";
	}
</script>

<script language="javascript"  for="gcds_data2"  event=onLoadCompleted(rowcount)>
	var row = gcds_data2.rowposition;
	
	if(row>0){
		txt_deptnm_1.value	=  gcds_data2.namevalue(row,"DEPTNM");		//소속명
		txt_paygrdnm_1.value = gcds_data2.namevalue(row,"MINORNM");	//직위
		txt_empnmk_1.value	= gusrnm;																//성명	
		gcem_empno_1.text = gcds_data2.namevalue(row,"EMPNO");	 
		txt_deptcd_1.value =gcds_data2.namevalue(row,"DEPTCD");	
		txt_paygrd_1.value =gcds_data2.namevalue(row,"PAYGRD");	

		txt_deptnm_2.value	=  gcds_data2.namevalue(row,"DEPTNM");		//소속명
		txt_paygrdnm_2.value = gcds_data2.namevalue(row,"MINORNM");	//직위
		txt_empnmk_2.value	= gusrnm;																//성명	
		gcem_empno_2.text = gcds_data2.namevalue(row,"EMPNO");	 
		txt_deptcd_2.value =gcds_data2.namevalue(row,"DEPTCD");	
		txt_paygrd_2.value =gcds_data2.namevalue(row,"PAYGRD");	

	} else {
		txt_deptnm_1.value	= "";
		txt_paygrdnm_1.value = "";
		txt_empnmk_1.value	= gusrnm;	

		txt_deptnm_2.value	= "";
		txt_paygrdnm_2.value = "";
		txt_empnmk_2.value	= gusrnm;	
	}
</script>

<!-- <script language="javascript" for="gcds_lazcd" event="onloadCompleted(row,colid)">
		gcds_lazcd.insertrow(1);
		gcds_lazcd.namevalue(1,"MINORCD") = "";
		gcds_lazcd.namevalue(1,"MINORNM") = "전체";
		gclx_lazcd.index = 0;
</script>
 -->
<script language="javascript" for="gcds_deptcd" event="onloadCompleted(row,colid)">
	gcds_deptcd.insertrow(1);
	gcds_deptcd.namevalue(1,"DEPTCD") = "";
	gcds_deptcd.namevalue(1,"DEPTNM") = "전체";
	gclx_deptcd.index = 0;
</script>

<script language="javascript" for="gcds_paygrd" event="onloadCompleted(row,colid)">
	//직위[검색조건]
	gcds_paygrd.insertrow(1);
	gcds_paygrd.namevalue(1,"MINORCD") = "";
	gcds_paygrd.namevalue(1,"MINORNM") = "전체";
	gclx_paygrd.index = 0;
</script>

<script language="javascript" for="gcds_traffic" event="onloadCompleted(row,colid)">
	//교통편
	gcds_traffic.insertrow(1);
	gcds_traffic.namevalue(1,"MINORCD") = "";
	gcds_traffic.namevalue(1,"MINORNM") = "";
	gclx_traffic_2.index = 0;
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gclx_lazcd event=OnSelChange()>
	if(gclx_lazcd.bindcolval=="G02"){//국내출장
		ln_DispChk(1);
		gcds_lazcd_2.Filter();
	}else{
    ln_DispChk(0);
		gcds_lazcd_1.Filter();
	}
	
  if(g_managegb=="Y"){
     ln_User_Setting('Y'); 
	}else if(g_managegb=="N"){
     ln_User_Setting('N'); 
	}

</script>

<script language=JavaScript for=gcds_lazcd_1 event=onFilter(row)>
  if(gclx_lazcd.bindcolval!="G02"){//해외출장
		if(gcds_lazcd_1.namevalue(row,"MINORCD")!="G02") return true;
		else return false;
	}
</script>

<script language=JavaScript for=gcds_lazcd_2 event=onFilter(row)>
  if(gclx_lazcd.bindcolval=="G02"){//국내출장
		if(gcds_lazcd_2.namevalue(row,"MINORCD")=="G02") return true;
		else return false;
	}
</script>

<script language=JavaScript for=gcem_ovrate_1 event=onKillFocus()>
		gcem_ovwnamt_1.text = Math.round(gcem_ovrate_1.text*gcem_ovdsamt_1.text);
		ln_OV_AutoSum();
</script>
<script language=JavaScript for=gcem_ovdsamt_1 event=onKillFocus()>
		gcem_ovwnamt_1.text = Math.round(gcem_ovrate_1.text*gcem_ovdsamt_1.text);
		ln_OV_AutoSum();
</script>
<script language=JavaScript for=gcem_caramt_1 event=onKillFocus()>
		ln_OV_AutoSum();
</script>
<script language=JavaScript for=gcem_ovfdamt_1 event=onKillFocus()>
		ln_OV_AutoSum();
</script>

<script language="javascript"  for=gcgd_disp01 event=OnClick(row,colid)>
	if(row<1)return;
	if(row>=1&&colid!="CHK"){
		ln_OV_AutoSum();
	}
</script>

<!-- 국내출장 -->
<script language=JavaScript for=gcem_otdt_2 event=onKillFocus()>
		ln_Todt_Setting();
</script> 
<script language=JavaScript for=gcem_carfare_2 event=onKillFocus()>
    ln_Wn_AutoSum();
</script>
<script language=JavaScript for= gcem_instamt_2 event=onKillFocus()>
    ln_Wn_AutoSum();
</script>
 <script language=JavaScript for= gclx_infdamt_2 event=OnSelChange()>
    ln_Wn_AutoSum();
</script>
<script language=JavaScript for= gclx_dayamt_2 event=OnSelChange()>
    ln_Wn_AutoSum();
</script>

<script language="javascript"  for=gcgd_disp02 event=OnClick(row,colid)>
	if(row<1)return;
	if(row>=1&&colid!="CHK"){
		ln_Query_Dtl(row);
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data01" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language=JavaScript for=gctr_data01 event=OnFail()>
	alert("Error Code : " + gctr_data01.ErrorCode + "\n" + "Error Message : " + gctr_data01.ErrorMsg + "\n");
</script>
<script language="javascript" for="gctr_data02" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>
<script language=JavaScript for=gctr_data02 event=OnFail()>
	alert("Error Code : " + gctr_data02.ErrorCode + "\n" + "Error Message : " + gctr_data02.ErrorMsg + "\n");
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s01.jsp"  flush="true"/>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>


<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" >
				<tr> 
					<td ><img src="../img/h050011_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
					  <img src="../../Common/img/btn/com_b_result.gif"	style="cursor:hand" onclick="ln_Submit()">
						<!-- <img src="../../Common/img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print()"> -->
					  <img src="../../Common/img/btn/com_b_excel.gif"   style="cursor:hand" onclick="ln_Excel()">
						<img src="../../Common/img/btn/com_b_delete.gif"	style="cursor:hand" onclick="ln_Delete()">
						<img src="../../Common/img/btn/com_b_insert.gif"	style="cursor:hand" onclick="ln_Add()" >
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onclick="ln_Save()">
						<img src="../../Common/img/btn/com_b_query.gif"		style="cursor:hand" onclick="ln_Query()">&nbsp;</td>
				</tr>
       </table>
    </td>
	</tr>
	<!-- 검색조건 Start -->
	<tr>
		<td>
			<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
				<tr> 
					<td width="60px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;출장일자&nbsp;</nobr></td>
					<td class="tab18" style="width:210px;"><nobr>&nbsp;
					<comment id="__NSID__">
						<object  id=gcem_frdt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
						 </object></comment><script>__ws__(__NSID__);</script> 
						 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_frdt','Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
							~&nbsp;
						 <comment id="__NSID__"><object  id=gcem_todt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=true>
											<param name=Format        value="YYYY/MM/DD">
											<param name=PromptChar    value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script> 
							 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_todt','Text')" style="position:relative;width:20px;left:2px;cursor:hand;">  
							</nobr>
					</td>
          <td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;사번&nbsp;</nobr></td>
          <td class="tab18" style="width:140px;"><nobr>&nbsp;
					<comment id="__NSID__">
						<object id=gcem_empno_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " validFeatures="ignoreStatus=yes" validExp="">
											<param name=Text          value="">
											<param name=Alignment	    value=0>
											<param name=Border	      value=True>
											<param name=Format	      value="0000000">
											<param name=PromptChar	  value="_">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										~ &nbsp;
          <comment id="__NSID__"><object id=gcem_empno_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:0px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " validFeatures="ignoreStatus=yes" validExp="">
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
							</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td>
					<td width="80px"  bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;성명</nobr></td>
          <td class="tab18" style="width:160px;" align=center><nobr>&nbsp;
						<input id="txt_empnmk"  type="text"  class="txtbox"  style= "position:relative;left:-8px;top:-2px;width:90px;height:20px;"   onkeydown="if(event.keyCode==13) ln_Query();" ReadOnly=true>
						<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-8px;top:2px;" onclick="ln_Popup('0')" >
					  </nobr>
					</td>
          <td width="80px"  bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;결재상태</nobr></td>
          <td class="tab18" style="width:140px;" align=center><nobr>&nbsp;
							<comment id="__NSID__">
							<object id=gclx_closeyn classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:-8px;top:2px;" >
								<param name=CBData			    value="''^전체,N^결재대기,I^결재중,Y^결재완료,J^접수완료,S^수신결재완료,R^회수,B^반송,H^회송">
								<param name=CBDataColumns	  value="MINORCD,MINORNM">
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort						value="FALSE">
								<param name=ListExprFormat	value="MINORNM^0^100">
								<param name=BindColumn			value="MINORCD">
								<param name=Enable          value="true">
							</object></comment><script>__ws__(__NSID__);</script>
					  </nobr>
					</td> 
				</tr>
				<tr>
					<td width="60px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;근태구분&nbsp;</nobr></td>
					<td class="tab19" ><nobr>&nbsp;
						<comment id="__NSID__"><object id=gclx_lazcd  classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  
						style="position:relative;left:0px;top:2px;font-size:12px;width:173px;"  >
						<param name=ComboDataID			value="gcds_lazcd">
						<param name=SearchColumn		value="MINORNM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="MINORNM^0^173">
						<param name=BindColumn			value="MINORCD">
						</object></comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
					<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;소속&nbsp;</nobr></td>
          <td class="tab19" ><nobr>&nbsp;
						<comment id="__NSID__"><OBJECT id=gclx_deptcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:0px;top:2px;font-size:12px;width:125px;">
							<param name=ComboDataID			value="gcds_deptcd">
							<param name=SearchColumn		value="DEPTNM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="DEPTNM^0^130">
							<param name=BindColumn			value="DEPTCD">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
						</nobr>
					</td>			
					<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;직위&nbsp;</nobr></td>
          <td class="tab19" colspan=3><nobr>&nbsp;
					 <comment id="__NSID__"><OBJECT id=gclx_paygrd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
						style="position:relative;left:-4px;top:2px;font-size:12px;width:135px;">
							<param name=ComboDataID			value="gcds_paygrd">
							<param name=CBDataColumns		value="MINORCD, MINORNM">
							<param name=SearchColumn		value=MINORNM>
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="MINORNM^0^130">
							<param name=BindColumn			value=MINORCD>
					</OBJECT></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
      </table>
		</td>
	</tr>
	<!-- 검색조건 End -->
  <!-- Grid 와 입력창 -->
	<tr>
		<td>
		  <!-- 해외출장 Start -->
		  <div id="div_disp01" style="display:none;">
			<table>
				<tr>
				  <td>
					  <!--Grid-->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:280px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
										style="position:relative;left:2px;width:637px; height:400px; border:1 solid #708090;display:block;" viewastext>
											<param name="dataid"			value="gcds_data01">
											<param name="indwidth"		value ='0'>
											<param name="borderstyle" value="0">
											<param name="fillarea"		value="true">
											<param name="sortview"		value="left">
											<param name="ColSelect"   value="false">
											<param name="colsizing"   value="true">
											<param name=MultiRowSelect	value=true>
											<param name="editable"    value="true">
											<param name="format"			value="  
											<X> Name='품의부서'      HeadAlign=Center HeadBgColor=#B9D4DC
												<FC> Name='선택'		   ID=CHK       HeadAlign=Center HeadBgColor=#B9D4DC Width=28	align=center	sort=false SumBgColor=#C3D0DB EditStyle=CheckBox </FC> 
												<FC> Name='신청일'		 ID=APPDT     HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center	sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX' </FC> 
												<FC> Name='근태구분'   ID=LAZCD     HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB Edit=None EditStyle=Lookup Data='gcds_lazcd_1:MINORCD:MINORNM'</</FC> 
												<FC> Name='소속'       ID=DEPTNM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left    sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<FC> Name='직위'       ID=PAYGRDNM 	HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left    sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<FC> Name='사번'       ID=EMPNO 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 align=center  sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<FC> Name='성명'       ID=EMPNMK    HeadAlign=Center HeadBgColor=#B9D4DC Width=55	align=center  sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<C> Name='출장목적'    ID=TRIPOBJ   HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB Edit=None </C> 
												<G> Name='출장일정'    HeadAlign=Center HeadBgColor=#B9D4DC
													<C> Name='출발일'    ID=FRDT 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center  sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX'</C> 
													<C> Name='복귀일'    ID=TODT 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center  sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX'</C> 
													<C> Name='목적지'    ID=OBJECT    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=left    sort=false SumBgColor=#C3D0DB Edit=None </C> 
												</G>
											</X>
											<X> Name='총무부'        HeadAlign=Center HeadBgColor=#B9D4DC
												<G> Name='출장비'      HeadAlign=Center HeadBgColor=#B9D4DC
													<C> Name='환율구분'	 ID=OVRATEGB  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=center sort=false SumBgColor=#C3D0DB SumText='합   계' Edit=None EditStyle=Lookup Data='gcds_ovrategb:CDCODE:CDNAM'</C> 
													<C> Name='환율'      ID=OVRATE 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=right  sort=false SumBgColor=#C3D0DB Edit=None dec=4 </C> 
                          <C> Name='달러'      ID=OVDSAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=right  sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
													<C> Name='원화'      ID=OVWNAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=right  sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
													<C> Name='교통비'    ID=CARAMT    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=right  sort=false SumBgColor=#C3D0DB </C> 
													<C> Name='달러산출'  ID=OVETC     HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left   sort=false SumBgColor=#C3D0DB </C> 
												</G>
											</X>
											<C> Name='결재상태'      ID=CLOSYN    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left   sort=false Edit=None EditStyle=Combo Data='N:결재대기,I:결재중,Y:결재완료,J:접수완료,S:수신결재완료,R:회수,B:반송,H:회송'</C> 
											">
									</object></comment><script>__ws__(__NSID__);</script>   
								</td>
							</tr>
						</table>
					</td>
					<td>
						<!--입력창 -->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:215px;height:402px;border:1 solid #708090;">
						<tr>
							<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>성명</nobr></td>
							<td class="tab13"><nobr>
							<comment id="__NSID__">
							<object id=gcem_empno_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:6px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=MaxLength     value=13>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;
							<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-3px;top:2px;" onclick="ln_Popup('1')" >
              <input id="txt_empnmk_1" type="text" class="txt21" style="position:relative;left:-5px;top:-3px;width:70px;"  ReadOnly> 
						</nobr>
					  </td>
            </tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>소속</nobr></td>
							<td class="tab13"><nobr> 
							  <input id="txt_deptcd_1"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;" ReadOnly>
								<input id="txt_deptnm_1" type="text"   class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>직위</nobr></td>
							<td class="tab13"><nobr>
								<input id="txt_paygrd_1"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;" ReadOnly>
								<input id="txt_paygrdnm_1"  type="text" class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>근태구분</nobr></td>
							<td class="tab13" ><nobr>
							<comment id="__NSID__">
							<object id=gclx_lazcd_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=150 class="txtbox"  style="position:relative;left:-9px;" >
								<param name=ComboDataID			value=gcds_lazcd_1>
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort						value="FALSE">
								<param name=ListExprFormat	value="MINORNM^0^150">
								<param name=BindColumn			value="MINORCD">
								<!-- <param name=Enable          value=false> -->
							</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>출장목적</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="txt_tripobj_1" type="text"   class="txtbox"  style="position:relative;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>출발일</nobr></td>
              <td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_frdt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('fr')" style="position:relative;width:20px;left:7px;cursor:hand;">  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>복귀일</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_todt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_todt_1','Text')" style="position:relative;width:20px;left:7px;cursor:hand;">  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>목적지</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="txt_object_1" type="text"   class="txtbox"  style="position:relative;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>합계</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_sum_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=8>
											<param name=IsComma       value=true>
											<param name=ReadOnly      value="true">
											<param name=ReadOnlyBackColor   value="#CCFFCC">
											<param name=BackColor     value="#CCCCCC">
									 </object></comment><script>__ws__(__NSID__);</script> 
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>환율</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gclx_ovrategb_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=70 class="txtbox"  style="position:relative;left:5px;top:3px" >
									<param name=ComboDataID			value=gcds_ovrategb>
									<param name=SearchColumn		value="CDNAM">
									<param name=Sort						value="FALSE">
									<param name=ListExprFormat	value="CDNAM^0^70">
									<param name=BindColumn			value="CDCODE">
									<!-- <param name=Enable          value=false> -->
								</object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/
							<comment id="__NSID__">
								<object  id=gcem_ovrate_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
										<param name=Text					value=0>
										<param name=Alignment     value=2>
										<param name=Numeric       value="false">
										<param name=Border        value=true>
										<!-- <param name=format        value="0000.0000"> -->
										<param name=MaxLength     value=4>
										<param name=MaxDecimalPlace   value=4>
										<param name=IsComma       value=true>
										<param name=ReadOnly      value="true">
										<param name=ReadOnlyBackColor   value="#CCFFCC">
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script> 
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>달러/원화</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_ovdsamt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/ 
								<comment id="__NSID__">
									<object  id=gcem_ovwnamt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=ReadOnly      value="true">
										  <param name=ReadOnlyBackColor   value="#CCFFCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr>
						<!-- <tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>원화</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							
								</nobr></td>
						</tr> -->
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>교통/식비</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_caramt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/ 
									 <comment id="__NSID__">
									<object  id=gcem_ovfdamt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr>
					<!-- 	<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>식비</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_ovfdamt_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value=0>
											<param name=Alignment     value=2>
											<param name=Numeric       value="true">
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=BackColor     value="#CCCCCC">
											<param name=SelectAll     value="true">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr> -->
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>달러산출</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_ovetc_1" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="48" onBlur="bytelength(this,this.value,100);"></textarea>&nbsp;</nobr>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>비고1</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_remark1_1" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,120);"></textarea>&nbsp;</nobr>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>비고2</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_remark2_1" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,120);"></textarea>&nbsp;</nobr>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" align=center style="border:0 solid #708090;border-right-width:1px;"><nobr>결재상태</nobr></td>
							<td style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gclx_closeyn_1 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:5px;" >
									<param name=CBData			    value="N^결재대기,I^결재중,Y^결재완료,J^접수완료,S^수신결재완료,R^회수,B^반송,H^회송">
									<param name=CBDataColumns	  value="MINORCD,MINORNM">
									<param name=SearchColumn		value="MINORNM">
									<param name=Sort						value="FALSE">
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value="MINORCD">
									<param name=Enable          value="true">
								</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td><nobr></nobr></td>
							<td><nobr></nobr></td>
						</tr>
						</table>
					</td>
        </tr>
			</table>
			</div>
		</td>
	</tr>
	<!-- 해외출장 End -->
  <tr>
		<td>
			 <!-- 국내출장 Start-->
		  <div id="div_disp02" style="display:block;">
			<table>
				<tr>
				  <td>
					  <!--Grid-->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:260px;border:0 solid #708090;">
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
										style="position:relative;left:2px;width:637px; height:217px; border:1 solid #708090;display:block;" viewastext>
											<param name="dataid"			value="gcds_data02">
											<param name="indwidth"		value ='0'>
											<param name="borderstyle" value="0">
											<param name="fillarea"		value="true">
											<param name="sortview"		value="left">
											<param name="colsizing"   value="true">
											<param name=MultiRowSelect	value=true>
											<param name="ViewSummary"	value=1>
											<param name="editable"    value="true">
											<param name="format"			value="  
												<FC> Name='선택'		   ID=CHK         HeadAlign=Center HeadBgColor=#B9D4DC Width=28	align=center	sort=false SumBgColor=#C3D0DB EditStyle=CheckBox </FC> 
												<FC> Name='신청일'		 ID=APPDT  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center	sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX' </FC> 
												<FC> Name='소속'       ID=DEPTNM 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left    sort=false SumBgColor=#C3D0DB Edit=None</FC> 
												<FC> Name='직위'       ID=PAYGRDNM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left    sort=false SumBgColor=#C3D0DB Edit=None SumText='합   계'</FC> 
												<FC> Name='사번'       ID=EMPNO 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=center  sort=false SumBgColor=#C3D0DB Edit=None</FC> 
												<FC> Name='성명'       ID=EMPNMK	    HeadAlign=Center HeadBgColor=#B9D4DC Width=55	align=left    sort=false SumBgColor=#C3D0DB Edit=None </FC> 
												<C> Name='출장목적'    ID=TRIPOBJ 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB Edit=None </C> 
												<G> Name='출장일정'    HeadAlign=Center HeadBgColor=#B9D4DC																									 
													<C> Name='출발일'    ID=FRDT 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center  sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX'</C> 
													<C> Name='복귀일'    ID=TODT 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=65	align=center  sort=false SumBgColor=#C3D0DB Edit=None Mask='XXXX/XX/XX'</C> 
													<C> Name='목적지'    ID=OBJECT 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=left    sort=false SumBgColor=#C3D0DB Edit=None</C> 
												</G>
												<C> Name='일수'        ID=INTRDAY 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	align=right   sort=false SumBgColor=#C3D0DB Edit=None</C> 
												<C> Name='금액계'      ID=OVWNAMT 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=right   sort=false SumBgColor=#C3D0DB Edit=None SumText=@sum</C> 
												<C> Name='결재상태'    ID=CLOSYN      HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left    sort=false SumBgColor=#C3D0DB Edit=None EditStyle=Combo Data='N:결재대기,I:결재중,Y:결재완료,J:접수완료,S:수신결재완료,R:회수,B:반송,H:회송'</C> 
											">
									</object></comment><script>__ws__(__NSID__);</script>   
								</td>
							</tr>
              <tr>
								<td height=25px><nobr>				
										<font style="position:relative;top:0px;left:0px; color=#0000FF">[상세입력]</font>&nbsp;
										<font style="position:relative;top:0px;left:290px; color=#FF0000">금액계:</font>&nbsp;
										<comment id="__NSID__"> 
										<object  id=gcem_ovwnamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:280px;top:3px">		
												<param name=Text					value="">
												<param name=Alignment     value=2>
												<param name=Border        value=true>
												<param name=MaxLength     value=7>
												<param name=IsComma       value=true>
												<param name=ReadOnly      value="true">
												<param name=ReadOnlyBackColor   value="#CCFFCC">
												<param name=BackColor     value="#CCCCCC">
										 </object></comment><script>__ws__(__NSID__);</script> 
										<img src="../../Common/img/btn/com_b_rowdel.gif"	style="cursor:hand;position:relative;top:3px;left:300px;" onClick="ln_Dtl_Del()">
										<img src="../../Common/img/btn/com_b_rowadd.gif"  style="cursor:hand;position:relative;top:3px;left:300px;" onclick="ln_Dtl_Add()">
										</nobr>
								</td>
							</tr>
							<tr> 			
								<td ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp03  
										style="position:relative;left:2px;width:637px; height:153px; border:1 solid #708090;display:block;" viewastext>
											<param name="dataid"			value="gcds_data03">
											<param name="indwidth"		value ='0'>
											<param name="borderstyle" value="0">
											<param name="fillarea"		value="true">
											<param name="sortview"		value="left">
											<param name="colsizing"   value="true">
											<param name="editable"    value="false">
											<param name="ViewSummary"	value=1>
											<param name=TitleHeight   value="30">
											<param name="format"			value="  
												<C> Name='사번'		      ID=EMPNO    HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center	sort=false SumBgColor=#C3D0DB Edit=None  </C> 
												<C> Name='성명'		      ID=EMPNMK   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=left	  sort=false SumBgColor=#C3D0DB Edit=None  </C> 
												<C> Name='일자'         ID=OTDT     HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=center  sort=false SumBgColor=#C3D0DB Mask='XXXX/XX/XX' </C> 
												<C> Name='구간'         ID=SECTION  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB SumText='합   계'</C> 
												<C> Name='교통편'       ID=TRAFFIC  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left    sort=false SumBgColor=#C3D0DB EditStyle=Lookup Data='gcds_traffic:MINORCD:MINORNM'</C> 
												<C> Name='교통비  '     ID=CARFARE  HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=right   sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
												<C> Name='숙박비'       ID=INSTAMT  HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=right   sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
												<C> Name='식비'         ID=INFDAMT  HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=right   sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
												<C> Name='일비'         ID=INDAYAMT HeadAlign=Center HeadBgColor=#B9D4DC Width=68	align=right   sort=false SumBgColor=#C3D0DB SumText=@sum</C> 
											">
									</object></comment><script>__ws__(__NSID__);</script>   
								</td>
							</tr>
						</table>
					</td>
					<td>
						<!--국내출장 입력창 -->
						<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:-5px;width:215px;height:400px;border:1 solid #708090;">
						<tr height="25px">
							<td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>성명</nobr></td>
							<td class="tab13"><nobr>
							<comment id="__NSID__">
							<object id=gcem_empno_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  tabindex="1"	style="position:relative;left:6px;top:2px; width:50px; height:20px; font-family:dotum; font-size:9pt; " >
								<param name=Text          value="">
								<param name=Alignment	    value=0>
								<param name=Border	      value=True>
								<param name=Format	      value="0000000">
								<param name=MaxLength     value=13>
								<param name=PromptChar	  value="_">
								<param name=BackColor     value="#CCCCCC">
								<param name=InheritColor  value=false>
								<param name=ReadOnly      value=false>
							</object></comment><script>__ws__(__NSID__);</script>&nbsp;
							<img src="../../Common/img/btn/com_b_find.gif" id=img_1 style="cursor:hand;position:relative;left:-3px;top:2px;" onclick="ln_Popup('2')" >
              <input id="txt_empnmk_2" type="text" class="txt21" style="position:relative;left:-5px;top:-3px;width:70px;"  ReadOnly> 
						</nobr>
					  </td>
            </tr>
						<tr height="25px">
						  <td width="80px" height="20px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>소속</nobr></td>
							<td class="tab13" height="20px" ><nobr> 
							  <input id="txt_deptcd_2"  type="text"   class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;"  ReadOnly>
								<input id="txt_deptnm_2" type="text"    class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>직위</nobr></td>
							<td class="tab13"><nobr>
								<input id="txt_paygrd_2"    type="text" class="txtbox"  style= "position:relative;left:0px;width:45px;height:20px;" ReadOnly>
								<input id="txt_paygrdnm_2"  type="text" class="txtbox"  style= "position:relative;left:0px;width:116px;height:20px;" ReadOnly>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>근태구분</nobr></td>
							<td class="tab13" ><nobr>
							<comment id="__NSID__">
							<object id=gclx_lazcd_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=150 class="txtbox"  style="position:relative;left:-9px;" >
								<param name=ComboDataID			value=gcds_lazcd_2>
								<param name=SearchColumn		value="MINORNM">
								<param name=Sort						value="FALSE">
								<param name=ListExprFormat	value="MINORNM^0^150">
								<param name=BindColumn			value="MINORCD">
								<!-- <param name=Enable          value=false> -->
							</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>출장목적</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="txt_tripobj_2" type="text"   class="txtbox"  style="position:relative;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="23px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>출발/복귀</nobr></td>
              <td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__"><nobr>
									<object  id=gcem_frdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script>
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('fr')" style="position:relative;width:20px;left:7px;cursor:hand;">  
									  <comment id="__NSID__">
									<object  id=gcem_todt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:2px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=ReadOnly      value="true">
											      <param name=ReadOnlyBackColor   value="#CCFFCC">
														<param name=ReadOnly      value="true">
									</object></comment><script>__ws__(__NSID__);</script> 
							</nobr></td>
						</tr>
						<!-- <tr>
              <td width="80px" height="23px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>복귀일</nobr></td>
              <td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
									<object  id=gcem_todt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
														<param name=ReadOnly      value="true">
											      <param name=ReadOnlyBackColor   value="#C0C0C0">
														<param name=ReadOnly      value="true">
									</object></comment><script>__ws__(__NSID__);</script> 
  								<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('to')" style="position:relative;width:20px;left:7px;cursor:hand;">   -->
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>목적지</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<input id="txt_object_2" type="text"   class="txtbox"  style="position:relative;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<!-- <tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>금액계</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__"> 
									<object  id=gcem_ovwnamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20px;position:relative;left:5px;top:0px">		
											<param name=Text					value="">
											<param name=Alignment     value=2>
											<param name=Border        value=true>
											<param name=MaxLength     value=7>
											<param name=IsComma       value=true>
											<param name=ReadOnly      value="true">
											<param name=ReadOnlyBackColor   value="#C0C0C0">
											<param name=BackColor     value="#CCCCCC">
									 </object></comment><script>__ws__(__NSID__);</script> 
								</nobr></td>
						</tr> -->
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>비고1</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_remark1_2" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,120);"></textarea>&nbsp;</nobr>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>비고2</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							 <textarea id="txt_remark2_2" class="txtbox"  style= "width:167px; height:20px; overflow:auto;position:relative;left:5px" maxlength="60" onBlur="bytelength(this,this.value,120);"></textarea>&nbsp;</nobr>
						</tr>

						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>결재상태</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object id=gclx_closeyn_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=100 class="txtbox"  style="position:relative;left:5px;" >
									<param name=CBData			    value="N^결재대기,I^결재중,Y^결재완료,J^접수완료,S^수신결재완료,R^회수,B^반송,H^회송">
									<param name=CBDataColumns	  value="MINORCD,MINORNM">
									<param name=SearchColumn		value="MINORNM">
									<param name=Sort						value="FALSE">
									<param name=ListExprFormat	value="MINORNM^0^100">
									<param name=BindColumn			value="MINORCD">
									<param name=Enable          value="true">
								</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td height=13px colspan=2><nobr><font style="position:relative;top:2px;left:0px; color=#0000FF">[상세입력]</font></nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab18" align=center ><nobr>일자</nobr></td>
							<td class="tab31" style="text-align:left"><nobr>
							<comment id="__NSID__">
								<object  id=gcem_otdt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
													<param name=Text					value="">
													<param name=Alignment     value=0>
													<param name=Border        value=true>
													<param name=Format        value="YYYY/MM/DD">
													<param name=PromptChar    value="_">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
								 </object></comment><script>__ws__(__NSID__);</script> 
								 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar('ot')" style="position:relative;width:20px;left:7px;cursor:hand;">  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>구간</nobr></td>
						  <td class="tab13" style="text-align:left"><nobr>
								 <input id="txt_section_2" type="text"   class="txtbox"  style="position:relative;top:-1px;left:5px;width:167px;height:20px;">
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>교통비/편</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
								<object  id=gcem_carfare_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:2px">		
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Numeric       value="true">
										<param name=Border        value=true>
										<param name=MaxLength     value=7>
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/
								 <comment id="__NSID__">
									<object id=gclx_traffic_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=80 class="txtbox"  style="position:relative;top:2px;left:0px;" >
										<param name=ComboDataID			value=gcds_traffic>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="FALSE">
										<param name=ListExprFormat	value="MINORNM^0^80">
										<param name=BindColumn			value="MINORCD">
										<!-- <param name=Enable          value=false> -->
									</object></comment><script>__ws__(__NSID__);</script>
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" bgcolor="#eeeeee" class="tab19" align=center ><nobr>숙박비</nobr></td>
							<td class="tab13" style="text-align:left"><nobr>
								<comment id="__NSID__">
								<object  id=gcem_instamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:0px">		
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Numeric       value="true">
										<param name=Border        value=true>
										<param name=MaxLength     value=7>
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script>  
							</nobr></td>
						</tr>
						<tr>
						  <td width="80px" height="25px" style="border:0 solid #708090;border-right-width:1px;" bgcolor="#eeeeee" align=center ><nobr>식비/일비</nobr></td>
							<td style="text-align:left"><nobr>
							<comment id="__NSID__">
                <object id=gclx_infdamt_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=70 class="txtbox"  style="position:relative;top:2px;left:5px;" >
										<param name=ComboDataID			value=gcds_infdamt>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="FALSE">
										<param name=ListExprFormat	value="MINORNM^0^50,MEMO^0^120">
										<param name=BindColumn			value="MINORNM">
										<!-- <param name=Enable          value=false> -->
								</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;/
              <comment id="__NSID__">
								<object id=gclx_dayamt_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 width=80 class="txtbox"  style="position:relative;top:2px;left:0px;" >
										<param name=ComboDataID			value=gcds_dayamt>
										<param name=SearchColumn		value="MINORNM">
										<param name=Sort						value="FALSE">
										<param name=ListExprFormat	value="MINORNM^0^50,MEMO^0^70">
										<param name=BindColumn			value="MINORNM">
										<!-- <param name=Enable          value=false> -->
								</object></comment><script>__ws__(__NSID__);</script>
							  
								<!-- <comment id="__NSID__">
								<object  id=gcem_infdamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Numeric       value="true">
										<param name=Border        value=true>
										<param name=MaxLength     value=7>
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script>&nbsp;&nbsp;/

								 <comment id="__NSID__">
								<object  id=gcem_dayamt_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:5px;top:3px">		
										<param name=Text					value="">
										<param name=Alignment     value=2>
										<param name=Numeric       value="true">
										<param name=Border        value=true>
										<param name=MaxLength     value=7>
										<param name=IsComma       value=true>
										<param name=BackColor     value="#CCCCCC">
										<param name=SelectAll     value="true">
								 </object></comment><script>__ws__(__NSID__);</script>  -->
							</nobr></td>
						</tr>
						</table>
					</td>
        </tr>
			</table>
			</div>
      <!-- 국내출장 End -->
		</td>
  </tr>
	<tr>
		<td colspan="2" height="24" align="left">조회건수 : <label id="lbl_search"></label></td>
  </tr>	
</table>

<!-- 해외출장 -->
<comment id="__NSID__"><object id=gcbn_date01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data01>
	<param name=BindInfo  value="
	<C>Col=EMPNO   	  Ctrl=gcem_empno_1	     Param=text</C>
	<C>Col=LAZCD   	  Ctrl=gclx_lazcd_1			 Param=bindcolval</C>
	<C>Col=FRDT    	  Ctrl=gcem_frdt_1			 Param=text</C>
	<C>Col=TODT    	  Ctrl=gcem_todt_1			 Param=text</C>
	<C>Col=DEPTCD  	  Ctrl=txt_deptcd_1			 Param=value</C>
	<C>Col=PAYGRD  	  Ctrl=txt_paygrd_1			 Param=value</C>
	<C>Col=OBJECT  	  Ctrl=txt_object_1			 Param=value</C>
	<C>Col=TRIPOBJ 	  Ctrl=txt_tripobj_1		 Param=value</C>
	<C>Col=CARAMT  	  Ctrl=gcem_caramt_1		 Param=text</C>
	<C>Col=OVRATEGB	  Ctrl=gclx_ovrategb_1	 Param=bindcolval</C>
	<C>Col=OVRATE  	  Ctrl=gcem_ovrate_1		 Param=text</C>
	<C>Col=OVDSAMT 	  Ctrl=gcem_ovdsamt_1		 Param=text</C>
	<C>Col=OVWNAMT 	  Ctrl=gcem_ovwnamt_1		 Param=text</C>
	<C>Col=OVETC   	  Ctrl=txt_ovetc_1		   Param=value</C>
	<C>Col=CLOSYN  	  Ctrl=gclx_closeyn_1		 Param=bindcolval</C>
	<C>Col=EMPNMK  	  Ctrl=txt_empnmk_1	     Param=value</C>
	<C>Col=DEPTNM   	Ctrl=txt_deptnm_1	     Param=value</C>
	<C>Col=PAYGRDNM   Ctrl=txt_paygrdnm_1	   Param=value</C>
	<C>Col=LAZCDNM    Ctrl=gclx_lazcd_1	     Param=Text</C>
	<C>Col=OVFDAMT    Ctrl=gcem_ovfdamt_1	   Param=Text</C>
	<C>Col=REMARK1    Ctrl=txt_remark1_1	   Param=value</C>
	<C>Col=REMARK2    Ctrl=txt_remark2_1	   Param=value</C>
	">
</object></comment><script>__ws__(__NSID__);</script>


<!-- 국내출장 MST -->
<comment id="__NSID__"><object id=gcbn_date02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data02>
	<param name=BindInfo  value="
	<C>Col=EMPNO   	  Ctrl=gcem_empno_2	     Param=text</C>
	<C>Col=LAZCD   	  Ctrl=gclx_lazcd_2			 Param=bindcolval</C>
	<C>Col=FRDT    	  Ctrl=gcem_frdt_2			 Param=text</C>
	<C>Col=TODT    	  Ctrl=gcem_todt_2			 Param=text</C>
	<C>Col=DEPTCD  	  Ctrl=txt_deptcd_2			 Param=value</C>
	<C>Col=PAYGRD  	  Ctrl=txt_paygrd_2			 Param=value</C>
	<C>Col=OBJECT  	  Ctrl=txt_object_2			 Param=value</C>
	<C>Col=TRIPOBJ 	  Ctrl=txt_tripobj_2		 Param=value</C>
	<C>Col=CARAMT  	  Ctrl=gcem_caramt_2		 Param=text</C>
	<C>Col=OVRATEGB	  Ctrl=gclx_ovrategb_2	 Param=bindcolval</C>
	<C>Col=OVRATE  	  Ctrl=gcem_ovrate_2		 Param=text</C>
	<C>Col=OVDSAMT 	  Ctrl=gcem_ovdsamt_2		 Param=text</C>
	<C>Col=OVWNAMT 	  Ctrl=gcem_ovwnamt_2		 Param=text</C>
	<C>Col=OVETC   	  Ctrl=txt_ovetc_2		   Param=value</C>
	<C>Col=CLOSYN  	  Ctrl=gclx_closeyn_2		 Param=bindcolval</C>
	<C>Col=EMPNMK  	  Ctrl=txt_empnmk_2	     Param=value</C>
	<C>Col=DEPTNM   	Ctrl=txt_deptnm_2	     Param=value</C>
	<C>Col=PAYGRDNM   Ctrl=txt_paygrdnm_2	   Param=value</C>
	<C>Col=LAZCDNM    Ctrl=gclx_lazcd_2	     Param=Text</C>
	<C>Col=REMARK1    Ctrl=txt_remark1_2	   Param=value</C>
	<C>Col=REMARK2    Ctrl=txt_remark2_2	   Param=value</C>
	">
</object></comment><script>__ws__(__NSID__);</script>

<!-- 국내출장 DTL-->
<comment id="__NSID__"><object id=gcbn_date03 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data03>
	<param name=BindInfo  value="
	<C>Col=OTDT  	    Ctrl=gcem_otdt_2			 Param=text</C>
	<C>Col=SECTION  	Ctrl=txt_section_2		 Param=value</C>
	<C>Col=TRAFFIC  	Ctrl=gclx_traffic_2		 Param=bindcolval</C>
	<C>Col=CARFARE  	Ctrl=gcem_carfare_2		 Param=text</C>
	<C>Col=INSTAMT  	Ctrl=gcem_instamt_2		 Param=text</C>
	<C>Col=INFDAMT	  Ctrl=gclx_infdamt_2	   Param=bindcolval</C>
	<C>Col=INDAYAMT  	Ctrl=gclx_dayamt_2		 Param=bindcolval</C>
	">
</object></comment><script>__ws__(__NSID__);</script>
<iframe type="hidden" id="ifrm" name="ifrm" src ="../../Person/html/GP_form.html" frameborder=1 style="width:1;height:1px;border:0 solid #708090;"></iframe>
<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px"> </iframe> 
</body>
</html><jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>