<%@ page language="java" contentType="text/html;charset=KSC5601" %>

<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>

<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title></title>

<!-----------------------------------------------------------------------------
		L O C A L   S C R I P T   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript">
//get_cookdata();

var gs_date      = gcurdate.substring(0,4) + gcurdate.substring(5,7); //년월
var gs_date1    = gcurdate.substring(0,4) + "01"; //년초
var gs_date2    = gcurdate.substring(0,4) + gcurdate.substring(5,7)+gcurdate.substring(8,10);
var gs_userid   = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd  = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode  = gfdcode;
var gs_cocode = gcocode;
var gs_fsstat = "";
var gs_cntmsg = 0;
var gs_tolcnt = 0;

/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출
	ln_DispChk(0);
	ln_Before();

	gcem_bf_yyyymm.text=gs_date;
	gcem_af_yyyymm.text=gs_date;
}

/******************************************************************************
	Description : 조회
	parameter   : p - 01:전표 조회1
	                  02:전표 조회1 클릭
										03:전표 조회2
******************************************************************************/
function ln_Query(p){

	if (p=='01'){  //전표조회에서
	var str11 = gcem_fsdat_fr.text+"01";         //처리기간 from
	//var str111 = shiftTime(str11,0,1,-1);
	var str12 = gcem_fsdat_to.text+"01";         //처리기간 to
	//var str121 = shiftTime(str12,0,1,-1);
    var str121 =gcem_fsdat_to.text+"31"; 
	var str13 = gclx_sign.bindcolval;		    //결재유무
	var str14 = gclx_fdcode.BindColVal;     //지점코드
	var str15 = gclx_fsdat.BindColVal;      //업무구분
	
	gcds_data1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_s1"+"?v_str1="+str11+"&v_str2="+str121+"&v_str3="+str13+"&v_str4="+str14+"&v_str5="+str15;
	//prompt("01gcds_data1::",gcds_data1.DataID );
	gcds_data1.Reset();

	}else if (p=='02'){  //전표입력더블클릭에서
        var row = gcds_data1.rowposition; 
        var str21 = gcds_data1.namevalue(row,"FDCODE"); //현장코드
		var str22 = gcds_data1.namevalue(row,"FSDAT2").substring(0,9); //전표일자
		var str23 = gcds_data1.namevalue(row,"FSDAT2").substring(10,16); //전표번호
    
		if(str21==""){
			str21=gclx_fdcode02.bindcolval;
		}

		if(str22==""){
			str22=gcem_fs02.text+gcem_fsdat02.text;
		}

		if(str23==""){
			str23=gcem_fsnbr02.text;
		}

		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_s2"+"?v_str1="+str21+"&v_str2="+str22+"&v_str3="+str23;;
		gcds_data2.Reset();
	}else if (p=='03'){  //전표입력조회에서
		var str31 = gclx_fdcode02.bindcolval;
		var str32 = gcem_fs02.text + gcem_fsdat02.text;
		var str33 = gcem_fsnbr02.text;
		gcds_data2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_s2"+"?v_str1="+str31+"&v_str2="+str32+"&v_str3="+str33;
		gcds_data2.Reset();
	}
}

/*****************************************************************
	Description : 전표번호 찾기
	parameter   :
*****************************************************************/
function ln_Find_Slipno(){
    
		var fsdat02 = gcem_fs02.text+gcem_fsdat02.text; 	
        gctr_slipno.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t4f?";
		gctr_slipno.Parameters = "v_str1="+gclx_fdcode02.BindColVal+",v_str2="+fsdat02+",v_str3="+gclx_fdcode02.BindColVal+",v_str4="+gs_userid+",v_str5="+gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10)+",v_str6=U";
		gctr_slipno.post();
		
		
		

}

/*********************************************************************
	Description : 본부코드 찾기
	parameter   :
*********************************************************************/
function ln_Find_Divcd(){

		gcds_divcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s9?v_str1="+gs_deptcd;
		gcds_divcd.Reset();

}

/********************************************************************************************
	Description : 전표 신규등록
	parameter   :
*********************************************************************************************/
function ln_Add(p){
  
	if (p=='01'){ //전표조회에서 등록

		ln_DispChk(1);
		gcds_data1.clearall();
		ln_SetDataHeader("MASTER");
		gcds_data1.addrow();
		gcds_data2.clearall();//그리드
		ln_SetDataHeader("DETAIL");
		gcds_data2.addrow();
		ln_Data();
		ln_Find_Slipno();//전표번호찾기
		//ln_Data1();//Master와 Detail데이터셋 설정
		gcgd_disp02.setcolumn("ATKORNAM");
	  	gcem_wrdt02.text = gs_date2;
	
	}else if(p=='02'){//전표입력에서 등록버튼시
		alert("여기");

		gcds_data1.clearall();
		ln_SetDataHeader("MASTER");
		gcds_data1.addrow();
		gcds_data2.clearall();//그리드
		ln_SetDataHeader("DETAIL");
		gcds_data2.addrow();
		ln_Data();
		ln_Find_Slipno();//전표번호찾기
		//ln_Data1();//Master와 Detail데이터셋 설정
		gcgd_disp02.setcolumn("ATKORNAM");

	}else if(p=='99'){//행추가버튼시
		//detail 데이터셋(프라이머리키)
		if (ln_Status()){//결재중이나 완료여부
			gcds_data2.addrow();
			gcgd_disp02.setcolumn("ATKORNAM");
			if(gcds_data2.countrow<2){
				gcds_data2.namevalue(gcds_data2.rowposition,"FSSEQ")="00001";
				gcds_data2.namevalue(gcds_data2.rowposition,"FSNUM")="001";
			}else {
				var max1=0;
				var max2="";
				for(i=1;i<=gcds_data2.countrow;i++){
					if(Number(gcds_data2.namevalue(i,"FSSEQ"))>max1)
						//max1=Number(gcds_data2.namevalue(i,"FSSEQ"));
						max1 = Number(gcds_data2.Max(4,0,0));
				}
				max1++;
				if(max1<10) max2 = "0000"+max1;
				else if(max1>=10 && max1<100) max2 = "000"+max1;
				else if(max1>=100 && max1<1000) max2 = "00"+max1;
				else if(max1>=1000 && max1<10000) max2 = "0"+max1;
				else max2 = "" +max1;
				gcds_data2.namevalue(gcds_data2.rowposition,"FSSEQ")=max2;
			}

			gcds_data2.namevalue(gcds_data2.rowposition,"FDCODE") = gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE");
			gcds_data2.namevalue(gcds_data2.rowposition,"FSDAT") = gcds_data1.namevalue(gcds_data1.rowposition,"FSDAT");
			gcds_data2.namevalue(gcds_data2.rowposition,"FSNBR") = gcds_data1.namevalue(gcds_data1.rowposition,"FSNBR");
			if(gcds_data2.countrow>=2) {
				gcds_data2.namevalue(gcds_data2.rowposition,"REMARK") = gcds_data2.namevalue(gcds_data2.rowposition-1,"REMARK");
			}
			gcds_data2.namevalue(gcds_data2.rowposition,"WRDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
			gcds_data2.namevalue(gcds_data2.rowposition,"WRID") = gs_userid;
      //순번설정
			gcds_data2.namevalue(gcds_data2.rowposition,"FSNUM")= ln_Fsnum_Find();
		}
	}
}

/******************************************************************************
	Description : 저장
	parameter   :
******************************************************************************/
function ln_Save(p0){
	if(p0 == "01") {//결재대기와 결재요청시
		if(gcds_data1.IsUpdated){
			if (confirm("저장하시겠습니까?1")){
				gctr_data1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t1";
				
				prompt('',gcds_data1.text);
				
				gctr_data1.post();
				ln_Query("01");
			}
		}
	}else if(p0 == "02") {//전표등록에서 저장
		ln_Column();//Master와 Detail데이터셋
		if (gcds_data1.IsUpdated||gcds_data2.IsUpdated){
			if(ln_Chk()){//유효한 값이면
				if (confirm("저장하시겠습니까?0")){
				  //지점코드 luxe_combo와 동일하게 함.
					ln_fdcode();
					gctr_data01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t1";
					//prompt('gcds_data1',gcds_data1.text);
					//prompt('gcds_data2',gcds_data2.text);
					gctr_data01.post();
					ln_Query("03");
				}
			}
		}
	}else if(p0 == "03") {//전표등록에서 결재저장
		if(gcds_data1.IsUpdated) {
			if (confirm("저장하시겠습니까?")) {
				//gctr_data1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t1";
				//gctr_data1.post();
				//gctr_data1.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t2";
				//gctr_data1.post();
				//ln_Query("03");
			}
		}
	}
}


/******************************************************************************
	Description : 지점코드 변경시 동일하게 함.
	parameter   :
******************************************************************************/
function ln_fdcode(){
	for(i=1;i<=gcds_data2.countrow;i++){
	  if(gcds_data2.SysStatus(i)==1){ //insert
			gcds_data2.namevalue(i,"FDCODE") = gclx_fdcode02.bindcolval;
		}
	}
}

/******************************************************************************
	Description : 삭제
	parameter   :
******************************************************************************/
function ln_Delete(p){
	if(p=='02'){ //전표등록의 전표삭제버튼
		if(!ln_Status()) return;

    if (confirm("삭제하시겠습니까?")){	
			gcds_data2.deleteall();
			gcds_mst.clearAll();
			ln_SetDataHeader("DELETE");
      		gcds_mst.addrow();
			gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gclx_fdcode02.bindcolval;
      		gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcem_fs02.text+gcem_fsdat02.text;
			gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcem_fsnbr02.text;
			gcds_mst.UserStatus(gcds_mst.rowposition)=2;
      
			gctr_delete.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t1";
			gctr_delete.post();
		}
	}else if(p=='dis'){  //전표증록의 행삭제버튼
	  if(ln_Status()){   //결재중이나 완료여부
			gcds_data2.deleterow(gcds_data2.rowposition);

			//이후 순번은 재설정함
			ln_Fsnum_Reset(gcds_data2.rowposition,"02");
		}
	}
}

/******************************************************************************
	Description : 결재
******************************************************************************/
function ln_Approval(e){
  	gcds_temp01.ClearData();
	var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,ACTDAT:STRING,ACTYYMM:STRING";
	gcds_temp01.SetDataHeader(s_temp);

	gs_cntmsg = 1;
	gs_tolcnt = 0;

	if(e=="01"){
		if(gcds_data1.countrow>0){
			if (!gcds_data1.IsUpdated) {
				alert("선택된 정보가 없습니다."); 
				return false;
			}
				
			var tolcnt = 0;
			for(var i=1;i<=gcds_data1.countrow;i++){
				if(gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")!=0 && gcds_data1.namevalue(i,"FSSTAT")=="N"){
					tolcnt++;
				}
			}

			gs_tolcnt=tolcnt;
			
			//var g_msg = "F";
			for(var i=1;i<=gcds_data1.countrow;i++){
				if(gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")!=0 && (gcds_data1.namevalue(i,"FSSTAT")=="N"||gcds_data1.namevalue(i,"FSSTAT")=="C")){
					g_msg="T";
					gcds_temp01.AddRow();
					
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")  = gcds_data1.namevalue(i,"FDCODE");
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")   = gcds_data1.namevalue(i,"FSDAT");
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")   = gcds_data1.namevalue(i,"FSNBR");
					gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTDAT")  = gcds_data1.namevalue(i,"ACTDAT");
					gcds_temp01.namevalue(gcds_temp01.rowposition,"ACTYYMM") = gcds_data1.namevalue(i,"ACTDAT").substring(0,6);
							
				}else if (gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")==0 && gcds_data1.namevalue(i,"FSSTAT")=="N"){
					alert("금액이 '0'인 정보는 결재할 수 없습니다. ");
					gcds_temp01.rowposition = i ; 
					return false;
				}else if (gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")!=0 && gcds_data1.namevalue(i,"FSSTAT")!="N"){
					//alert("결재대기인 건만 결재가능합니다.");
					///return false;
				}
			}//for

			if(confirm("결재 하시겠습니까?")){
				gctr_data2.Keyvalue = "a040010_t3(I:USER=gcds_temp01)";
				gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t3";
				gctr_data2.Parameters = "v_str1="+gs_date+",v_str2="+gusrid;
				gctr_data2.post();
				++gs_cntmsg;
				ln_Query('01');
				gcds_temp01.ClearAll();
		  	}else{
				gcds_temp01.ClearAll();
			}
		}else alert("결재할 정보가 없습니다.");
	}else if(e=="02"){
		if(gcds_data2.countrow>1){
			gcds_temp01.ClearData();
			gs_tolcnt=1;
			gs_cntmsg=1;
			if((gclx_fsstat02.bindcolval=="N"||gclx_fsstat02.bindcolval=="C") && gcem_fsamt02.text!=0){
				if(confirm("결재 하시겠습니까?")){
					gcds_temp01.AddRow();
					
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")  = gclx_fdcode02.bindcolval;
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")   = gcem_fs02.text+gcem_fsdat02.text;
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")   = gcem_fsnbr02.text;
					
					gctr_data2.Keyvalue = "a040010_t3(I:USER=gcds_temp01)";
					prompt("결재2:gcds_temp01:",gcds_temp01.text);
					gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t3";
					gctr_data2.Parameters = "v_str1="+gs_date+",v_str2="+gusrid;
					gctr_data2.post();
					ln_Query('02');
					ln_Query('01');
				}
			}else if (gclx_fsstat02.bindcolval=="N" && gcem_fsamt02.text==0){
				alert("금액이 '0'인 정보는 결재할 수 없습니다. ");
				return false;
			}else if (gclx_fsstat02.bindcolval!="N" && gcem_fsamt02.text!=0){
				//alert("결재대기인 건만 결재가능합니다.");
				//return false;
			}
		}else alert("결재할 정보가 없습니다.");
	}
}

/******************************************************************************
	Description : 결재취소
******************************************************************************/
function ln_AppCancel(e){
  gcds_temp01.ClearAll();
	var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,ACTDAT:STRING,ACTYYMM:STRING";
	gcds_temp01.SetDataHeader(s_temp);
	if(e=="01"){
		if(gcds_data1.countrow>0){
			if (!gcds_data1.IsUpdated) {
				alert("선택된 정보가 없습니다."); 
				return false;
			}
			
			for(var i=1;i<=gcds_data1.countrow;i++){
				if(gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSAMT")!=0 && gcds_data1.namevalue(i,"FSSTAT")=="Y"){
						gcds_temp01.AddRow();
						gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")  = gcds_data1.namevalue(i,"FDCODE");
						gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")   = gcds_data1.namevalue(i,"FSDAT");
						gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")   = gcds_data1.namevalue(i,"FSNBR");
					
				}else if (gcds_data1.namevalue(i,"SELECT2")=="T" && gcds_data1.namevalue(i,"FSSTAT")!="Y"){
					alert("결재완료인 건만 결재취소 가능합니다.");
					gcds_data1.rowposition = i;
					return false;
				}
			}//for

			if(confirm("결재취소 하시겠습니까?")){
				gctr_data2.Keyvalue = "a040010_t4(I:USER=gcds_temp01)";
				gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t4";
				gctr_data2.Parameters = "v_str1="+gs_date+",v_str2="+gusrid;
				gctr_data2.post();
				ln_Query('01');
				gcds_temp01.ClearAll();
			}else{
				gcds_temp01.ClearAll();
			}
		}else alert("결재취소할 정보가 없습니다.");
	}else if(e=="02"){
		if(gcds_data2.countrow>1){
			gcds_temp01.ClearData();
			if(gclx_fsstat02.bindcolval=="Y"){
				if(confirm("결재취소 하시겠습니까?")){
					gcds_temp01.AddRow();
					
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FDCODE")  = gclx_fdcode02.bindcolval;
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSDAT")   = gcem_fs02.text+gcem_fsdat02.text;
					gcds_temp01.namevalue(gcds_temp01.rowposition,"FSNBR")   = gcem_fsnbr02.text;
					
					gctr_data2.Keyvalue = "a040010_t4(I:USER=gcds_temp01)";
					gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t4";
					gctr_data2.Parameters = "v_str1="+gs_date+",v_str2="+gusrid;
					//prompt("gcds_temp01::",gcds_temp01.text);
					gctr_data2.post();
					ln_Query('02');
					ln_Query('01');
					gcds_temp01.ClearAll();
				}
			}else if (gclx_fsstat02.bindcolval!="Y"){
				alert("결재완료인 건만 결재취소 가능합니다.");
				return false;
			}
		}else alert("결재취소할 정보가 없습니다.");	
	}
}

/******************************************************************************
	Description : 상위집계
******************************************************************************/
function ln_HighTotal(e,e1){
	var strfdcode="";
	if(gclx_fdcode.bindcolval==""){
		strfdcode = "A"; 
	}else{
		strfdcode = gclx_fdcode.bindcolval;
	}

	if(e=="01"){
		if (gcds_upatcode.countrow<1){
			var s_temp = "FDCODE:STRING";
			gcds_upatcode.SetDataHeader(s_temp);
		}
		
		if(gcem_fsdat_fr.text != gcem_fsdat_to.text){
			alert("처리기간을 1개월단위로 지정해 주십시오. \n\n예) '2006/01~2006/01'");
			return false;
		}
    	gcds_upatcode.addrow();
    	gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")="99";
    	gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t3?";
		gctr_upatcode.Parameters = "v_str1="+gcem_fsdat_fr.text+",v_str2="+strfdcode+",v_str3="+gusrid;
		gctr_upatcode.post();																 
    	gcds_upatcode.ClearAll();
	}else if(e=="02"){
		if (gcds_upatcode.countrow<1){
			var s_temp = "FDCODE:STRING";
			gcds_upatcode.SetDataHeader(s_temp);
		}
		
		if(gcem_actdat02.text == ""){
			alert("회계년월을 입력하십시요");
			return false;
		}

    //alert("gcem_actdat02::"+gcem_actdat02.text);

    	gcds_upatcode.addrow();
   	 	gcds_upatcode.namevalue(gcds_upatcode.rowposition,"FDCODE")="99";
    	gctr_upatcode.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_upatcode_t3?";
		gctr_upatcode.Parameters = "v_str1="+gcem_actdat02.text+",v_str2="+strfdcode+",v_str3="+gusrid;
		gctr_upatcode.post();																 
    	gcds_upatcode.ClearAll();
	}
}

/******************************************************************************
	Description : 출력
	parameter   : 
******************************************************************************/
function ln_Print(){
		
}

/******************************************************************************
	Description : 엑셀
	parameter   : 
******************************************************************************/
function ln_Excel(){
	gcgd_disp02.GridToExcel("수정분개","",2);
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before() {

	gcem_fsdat_fr.text	= gs_date;	    //계산서기간 from(년초)
	gcem_fsdat_to.text	= gs_date;			//계산서기간 to(년월)
	gclx_sign.bindcolval = ""; //결재유무

	gclx_fsstat02.bindcolval = ""; //전표상태
	txt_deptnm02.value = gs_deptnm; //담당부서
	txt_empnmk02.value = gs_usernm; //담당자
	gcem_actdat02.text  = gs_date; //회계월

    //지점코드1
	gcds_fdcode1.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_fdcode1.Reset();

	//업무구분
	gcds_fsdat.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=1155";
	gcds_fsdat.Reset();

    //지점코드2
	gcds_fdcode2.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	gcds_fdcode2.Reset();

	//ln_Find_Divcd();//본부코드
	gcds_divcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s9?v_str1="+gs_deptcd;
	gcds_divcd.Reset();

}


/******************************************************************************
	Description : TextBox 값
	parameter   : 
******************************************************************************/
function ln_Data(){
	
	gclx_fdcode02.bindcolval = gs_fdcode;
	//if(gf_Dept_Enable(gs_deptcd)) {
	gcem_fs02.text = "A";
	//}

	gcem_fsdat02.text = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcem_fsnbr02.text = "000000";


}

/******************************************************************************
	Description : Master와 Detail Dataset값
	parameter   : 
******************************************************************************/
function ln_Data1(){

	//Master
	//gclx_fdcode02.bindcolval = gs_fdcode;
	gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE") = gclx_fdcode02.bindcolval;
	//if(gf_Dept_Enable(gs_deptcd)) {
		//gcem_fs02.text = "A";
	//}
	//gcem_fsdat02.text = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data1.namevalue(gcds_data1.rowposition,"FSDAT") = gcem_fs02.text + gcem_fsdat02.text;
	gcem_fsnbr02.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
	gcds_data1.namevalue(gcds_data1.rowposition,"FSNBR") = gcem_fsnbr02.text;
	gcds_data1.namevalue(gcds_data1.rowposition,"FSKND") = "";
	gcds_data1.namevalue(gcds_data1.rowposition,"FSWRTDAT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data1.namevalue(gcds_data1.rowposition,"COCODE") = gs_cocode;
	gcds_data1.namevalue(gcds_data1.rowposition,"DEPTCD") = gs_deptcd;
	gcds_data1.namevalue(gcds_data1.rowposition,"EMPNO") = gs_userid;
	gcds_data1.namevalue(gcds_data1.rowposition,"DIVCD") = gcds_divcd.namevalue(1,"DIVCD");
	gcds_data1.namevalue(gcds_data1.rowposition,"FSVAT") = 0;
	
	gcds_data1.namevalue(gcds_data1.rowposition,"SGNDAT") = "";
	gclx_fsstat02.bindcolval="N";
	gcds_data1.namevalue(gcds_data1.rowposition,"FSSTAT") = gclx_fsstat02.bindcolval;
	gcds_data1.namevalue(gcds_data1.rowposition,"ACTDAT") = shiftTime(gcem_actdat02.text+"01",0,1,-1);
	gcds_data1.namevalue(gcds_data1.rowposition,"WRDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data1.namevalue(gcds_data1.rowposition,"WRID") = gs_userid;
	gcds_data1.namevalue(gcds_data1.rowposition,"UPDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data1.namevalue(gcds_data1.rowposition,"UPID") = gs_userid;
	
	//Detail
	gcgd_disp02.setcolumn("ATKORNAM");
	gcds_data2.namevalue(gcds_data2.rowposition,"FDCODE") = gclx_fdcode02.bindcolval;
	gcds_data2.namevalue(gcds_data2.rowposition,"FSDAT") = gcem_fs02.text + gcem_fsdat02.text;
	gcds_data2.namevalue(gcds_data2.rowposition,"FSNBR") = gcem_fsnbr02.text;
	gcds_data2.namevalue(gcds_data2.rowposition,"FSSEQ") = "00001";
	
	gcds_data2.namevalue(gcds_data2.rowposition,"FSREFSEQ01") = "01";
	gcds_data2.namevalue(gcds_data2.rowposition,"FSREFCD01") = "0030";
	//FSREFVAL01
	gcds_data2.namevalue(gcds_data2.rowposition,"FSREFNM01") = "원가코드";
	gcds_data2.namevalue(gcds_data2.rowposition,"FSRVALNM01") = "공통";
	gcds_data2.namevalue(gcds_data2.rowposition,"WRDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data2.namevalue(gcds_data2.rowposition,"WRID") = gs_userid;

	gcds_data2.namevalue(gcds_data2.rowposition,"FSNUM") = "001";

}

/******************************************************************************
	Description : Detail Dataset값
	parameter   : 
******************************************************************************/
function ln_Data2(){

}

/******************************************************************************
	Description : 체크
	parameter   : p1-구분
******************************************************************************/
function ln_Chk(){

	var de = 0, cr = 0;
	var row = gcds_data2.countrow;

	if(ln_Trim(gcem_fs02.text)=="") {
		alert("전표번호를 입력하십시오.");
		return false;
	}
	if(ln_Trim(gcem_fsdat02.text)=="") {
		alert("전표번호를 입력하십시오.");
		return false;
	}
	if(ln_Trim(gcem_fsnbr02.text)=="") {
		alert("전표번호를 입력하십시오.");
		return false;
	}

	for(i=1;i<=row;i++) {
		de+=gcds_data2.namevalue(i,"CHAAMT");
		cr+=gcds_data2.namevalue(i,"DAEAMT");
	}
	if(de!=cr){
		alert("차변합계와 대변합계가 같지 않습니다.");
		return false;
	}

	return true;

}

/******************************************************************************
	Description : 결재중이나 완료여부
	prameter    :  
******************************************************************************/
function ln_Status(){

	if(gclx_fsstat02.bindcolval=="Y"){
		alert("결재완료?거나 결재중인 전표입니다."); 
		return false;
	}
		return true;
}

/******************************************************************************
	Description : 차변, 대변과 적요를 Master로
	parameter   :
******************************************************************************/
function ln_Column(){

	var sum = 0;
	var detot = 0;
	var crtot = 0;

	for(i=1;i<=gcds_data2.countrow;i++) {
		sum+=gcds_data2.namevalue(i,"CHAAMT");
		detot+=gcds_data2.namevalue(i,"CHAAMT");
		crtot+=gcds_data2.namevalue(i,"DAEAMT");
		if(gcds_data2.namevalue(i,"CHAAMT") != 0 && gcds_data2.namevalue(i,"DAEAMT") == 0) {
			gcds_data2.namevalue(i,"ATDECR") = "1";
			gcds_data2.namevalue(i,"FSAMT") = gcds_data2.namevalue(i,"CHAAMT");
		}
		else if(gcds_data2.namevalue(i,"CHAAMT") == 0 && gcds_data2.namevalue(i,"DAEAMT") != 0) {
			gcds_data2.namevalue(i,"ATDECR") = "2";
			gcds_data2.namevalue(i,"FSAMT") = gcds_data2.namevalue(i,"DAEAMT");
		}	
	}
	gcem_fsamt02.text = sum;
	gcds_data1.namevalue(gcds_data1.rowposition,"FSAMT") = gcem_fsamt02.text;
	gcds_data1.namevalue(gcds_data1.rowposition,"DETOT") = detot;
	gcds_data1.namevalue(gcds_data1.rowposition,"CRTOT") = crtot;
	gcem_remark02.text = gcds_data2.namevalue(1,"REMARK");
	gcds_data1.namevalue(gcds_data1.rowposition,"REMARK") = gcem_remark02.text;

	gcds_data1.namevalue(gcds_data1.rowposition,"ACTDAT") = gcem_actdat02.text+"30";
}

/******************************************************************************
	Description : 결재대기
	parameter   :
******************************************************************************/
function ln_Confirm_Ready(){

	for(i=1;i<=gcds_data1.countrow;i++) {
		if(gcds_data1.namevalue(i,"SELECT2")=="T"&&gcds_data1.namevalue(i,"FSSTAT")=="R")
			gcds_data1.namevalue(i,"FSSTAT")="N";
	}
	ln_Save("01");//결재저장

}

/******************************************************************************
	Description : 결재요청
	parameter   :
******************************************************************************/
function ln_Confirm_Request(){

	for(i=1;i<=gcds_data1.countrow;i++) {
		if(gcds_data1.namevalue(i,"SELECT2")=="T"&&gcds_data1.namevalue(i,"FSSTAT")=="N")
			gcds_data1.namevalue(i,"FSSTAT")="R";
	}
	ln_Save("01");//결재저장

}

/******************************************************************************
	Description : 결재요청
	parameter   :
******************************************************************************/
/**
function ln_Confirm_Request1(){

	if (confirm("결재 하시겠습니까?")) {
		if(gcds_data1.namevalue(gcds_data1.rowposition,"FSSTAT")=="N") {
			gcds_data1.namevalue(gcds_data1.rowposition,"FSSTAT")="R";
			ln_Save("03");//결재저장
		}
	}

}
********/



/******************************************************************************
	Description : 결재시 저장
	parameter   :  p - 결재자 사번
******************************************************************************/
function ln_Confirm_Save(p){
		var row1 = gcds_data01.rowposition;
		var row2 = gcds_data01_2.rowposition;
		var strfdcode="";
		var strfsdat="";
		var strfsnbr="";
		var strempno="";
		var strtogb="03" //예산일경우는 02 로 변경해야함.

		if((gcds_data01_2.namevalue(row2,"FDCODE"))==""||(gcds_data01_2.namevalue(row2,"FDCODE"))==undefined){
			strfdcode = gcds_data01.namevalue(row1,"FDCODE");
		}else{
			strfdcode = gcds_data01_2.namevalue(row2,"FDCODE");
		}

		if(gcds_data01_2.namevalue(row2,"FSDAT")==""||gcds_data01_2.namevalue(row2,"FSDAT")==undefined){
			strfsdat = gcds_data01.namevalue(row1,"FSDAT");
		}else{
			strfsdat = gcds_data01_2.namevalue(row2,"FSDAT");
		}

		if(gcds_data01_2.namevalue(row2,"FSNBR")==""||gcds_data01_2.namevalue(row2,"FSNBR")==undefined){
			strfsnbr = gcds_data01.namevalue(row1,"FSNBR");
		}else{
			strfsnbr = gcds_data01_2.namevalue(row2,"FSNBR");
		}

		if(gcds_data01_2.namevalue(row2,"EMPNO")==""||gcds_data01_2.namevalue(row2,"EMPNO")==undefined){
			strempno = txt_empno02.value;
		}else{
			strempno = gcds_data01_2.namevalue(row2,"FSNBR");
		}

		gcds_confirm.clearall();
		ln_SetDataHeader("CONFIRM");
    	gcds_confirm.addrow();
    	gcds_confirm.namevalue(gcds_confirm.rowposition,"FDCODE")=strfdcode; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSDAT")=strfsdat;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSNBR")=strfsnbr;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"SEQ")=""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNID")=p;      //결재자
		gcds_confirm.namevalue(gcds_confirm.rowposition,"EMPNO")= strempno;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNDAT") ="";  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNEND") ="R"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FROMGB") ="04"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"TOGB") =strtogb; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"BIGO") =""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRDT") =gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRID") =gs_userid;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPDT") =gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPID") =gs_userid;  

		if (confirm("결재하시겠습니까?")){	
			gctr_data06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t6";
			gctr_data06.post();
    }
}

/******************************************************************************
	Description : 일반증빙 팝업 테스트
	parameter   : 
******************************************************************************/
function ln_Popup_Proof(){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="01";
	arrParam[1]="A20060324";
	arrParam[2]="900001";
	arrParam[3]="005";

	strURL = "./com_proof.jsp";
	strPos = "dialogWidth:615px;dialogHeight:375px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

	if (result != null) {
		arrResult = result.split(";");
	}
	else {
		alert("검색결과가 없습니다.");
	}
}

/******************************************************************************
	Description : 수정분개 팝업 테스트
	parameter   : 
******************************************************************************/
function ln_A040010_Popup(){
	
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0]="01";
	arrParam[1]="A20060324";
	arrParam[2]="900001";

	strURL = "./a040010_popup.jsp";
	strPos = "dialogWidth:900px;dialogHeight:600px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);

}

/******************************************************************************
	Description : 저장할 Data를 위한 DataSetHead 설정
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(p1){

	if(p1=="MASTER"){ //Master
		var s_fslipmst = "FDCODE:STRING,FS1:STRING,FSDAT:STRING,FSDAT1:STRING,FSNBR:STRING,FSDAT2:STRING,FSKND:STRING,FSWRTDAT:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSVAT:DECIMAL,FSAMT:DECIMAL,DETOT:DECIMAL,CRTOT:DECIMAL,REMARK:STRING,SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
		gcds_data1.SetDataHeader(s_fslipmst);
	}else if(p1=="DETAIL"){ //Detail
		var s_fslipdtl1 = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,ATKORNAM:STRING,ATDECR:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,FSAMT:DECIMAL,REMARK:STRING,FSREFSEQ01:STRING,FSREFCD01:STRING,FSREFVAL01:STRING,FSREFVAL:STRING,FSREFNM01:STRING,FSRVALNM01:STRING,WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,FSNUM:STRING";
		gcds_data2.SetDataHeader(s_fslipdtl1);
	}	else if(p1=="DELETE"){ //Master
		var s_fslipmst = "FDCODE:STRING,FS1:STRING,FSDAT:STRING,FSDAT1:STRING,FSNBR:STRING,FSDAT2:STRING,FSKND:STRING,FSWRTDAT:STRING,COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSVAT:DECIMAL,FSAMT:DECIMAL,DETOT:DECIMAL,CRTOT:DECIMAL,REMARK:STRING,SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING";
		gcds_mst.SetDataHeader(s_fslipmst);
	}


}

/******************************************************************************
	Description : 달력
	prameter    :	    
******************************************************************************/
function ln_Calendar(){

	if(gclx_fsstat02.bindcolval=="Y"||gclx_fsstat02.bindcolval=="R"||gclx_fsstat02.bindcolval=="C"){
		alert("결재완료?거나 결재중인 전표입니다.");
	}else{
		__GetCallCalendar('gcem_actdat02', 'Text');
	}

}

/******************************************************************************
	Description : 합계잔액 Sum 계산
******************************************************************************/
function ln_Sum(){

}

/******************************************************************************
	Description : 닫기
	parameter   : 
******************************************************************************/
function ln_Close(p){
	
	ln_DispChk(0);

}

/******************************************************************************
	Description : 전표조회/전표입력
	prameter    : 0-전표조회, 1-전표입력
******************************************************************************/
function ln_DispChk(index){

  var div_cm = new Array("div_disp1","div_disp2");

	for(var i=0;i<=1;i++)	{
		if(i==index) eval("document.all."+div_cm[i]+".style.display='block';");
		else eval("document.all."+div_cm[i]+".style.display='none';");
	}
	
}

/******************************************************************************
	Description : 날짜계산
	prameter    : 
******************************************************************************/

/**
 * Time 스트링을 자바스크립트 Date 객체로 변환
 * parameter time: Time 형식의 String
 */
function toTimeObject(time) { //parseTime(time)
    var year  = time.substr(0,4);
    var month = time.substr(4,2) - 1; // 1월=0,12월=11
    var day   = time.substr(6,2);
    return new Date(year,month,day);
}

/**
 * 자바스크립트 Date 객체를 Time 스트링으로 변환
 * parameter date: JavaScript Date Object
 */
function toTimeString(date) { //formatTime(date)
    var year  = date.getFullYear();
    var month = date.getMonth() + 1; // 1월=0,12월=11이므로 1 더함
    var day   = date.getDate();

    if (("" + month).length == 1) { month = "0" + month; }
    if (("" + day).length   == 1) { day   = "0" + day;   }

    return ("" + year + month + day);
}

/**
 * 주어진 Time 과 y년 m월 d일 차이나는 Time을 리턴
 *
 * ex) var time = form.time.value; //'20000101'
 *     alert(shiftTime(time,0,0,-100));
 *     => 2000/01/01 으로부터 100일 전 Time
 *
 * http://www.oramaster.net
 */
function shiftTime(time,y,m,d) { //moveTime(time,y,m,d)
    var date = toTimeObject(time);

    date.setFullYear(date.getFullYear() + y); //y년을 더함
    date.setMonth(date.getMonth() + m);       //m월을 더함
    date.setDate(date.getDate() + d);         //d일을 더함

    return toTimeString(date);
}

/******************************************************************************
	Description : 공백제거
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 

} 


/******************************************************************************
	Description : 월별 데이타 일괄 복사
******************************************************************************/
function ln_Batch_Copy(){
  
	if(gclx_fdcode.bindcolval==""){
		alert("지점을 선택하십시요.");
		return;
	}

	gcds_batch_copy.ClearData();
	var s_temp = "FDCODE:STRING,BFYYYYMM:STRING,AFYYYYMM:STRING,WRDT:STRING,WRID:STRING";
	gcds_batch_copy.SetDataHeader(s_temp);

	if(confirm("현재 데이타를 일괄 복사 하시겠습니까?")){
	  	gcds_batch_copy.addrow();
    	gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"FDCODE")= gclx_fdcode.bindcolval; 
		gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"BFYYYYMM")=gcem_bf_yyyymm.text;  //복사월
		gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"AFYYYYMM")=gcem_af_yyyymm.text;  //원본월
		gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"WRDT")=gs_date2;                 //현재일자
		gcds_batch_copy.namevalue(gcds_batch_copy.rowposition,"WRID")=gs_userid;                //사용자
	 
		gctr_batch_copy.Keyvalue = "a040010_t5(I:USER=gcds_batch_copy)";
		gctr_batch_copy.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040010_t5";
		//prompt(this,gcds_batch_copy.text );
		gctr_batch_copy.post();
	}
}

/******************************************************************************
	Description : 행삽입
	parameter   : 
******************************************************************************/
function ln_Insert(){
  	var insertrow=0;
	var fsdat=gcem_fs02.text+gcem_fsdat02.text;

	if(!ln_Status())return;
	
	insertrow = gcds_data2.rowposition + 1 ; 

	if(gcds_data2.rowposition>0){
		gcds_data2.Insertrow(insertrow);
		//순번설정
		gcds_data2.namevalue(gcds_data2.rowposition,"FSNUM")= ln_Fsnum_Find();
		//이후 순번은 재설정함
    
		alert("gcds_data2.rowposition::"+gcds_data2.rowposition);
		ln_Fsnum_Reset(gcds_data2.rowposition,"01");
	}
	ln_Data_Fdcode_Fsdat_Fsnbr();
}


/******************************************************************************
	Description : 전표등록 - 순번 찾기
	parameter   : 
******************************************************************************/
function ln_Fsnum_Find(){
  	var ifsnum=0;
	_out:
	for(k=1;k<=gcds_data2.countrow;k++){
		if(gcds_data2.namevalue(k,"FSNUM")==""){
			ifsnum=k;
			break _out;
		}
	}
	return ln_Seqno_Format(Number(ifsnum),3);
}


/******************************************************************************
	Description : Insert 또는 Delete 후 순번 재설정
	parameter   : ipo - 현재 rowposition
	              strGubun - 01: Insert
								           02: Delete
******************************************************************************/
function ln_Fsnum_Reset(ipo,strGubun){
	if(strGubun=="01"){
		ipo=ipo+1;
	}
	//alert("ipo::"+ipo);
	for(k=ipo;k<=gcds_data2.countrow;k++){
		gcds_data2.namevalue(k,"FSNUM") = ln_Seqno_Format(Number(k),3);
	}
}


/************************************************************************************************************
	Description : 키값 자동 생성
	parameter   :    
*************************************************************************************************************/
function ln_Data_Fdcode_Fsdat_Fsnbr(){
  	var intseq =0;
  
	intseq = Number(gcds_data2.Max(4,0,0))+1;

	//alert(" hid_fsseq.value:1:"+ hid_fsseq.value);
	gcds_data2.namevalue(gcds_data2.rowposition,"FSSEQ")= ln_Seqno_Format(intseq,5);

	gcds_data2.namevalue(gcds_data2.rowposition,"FDCODE")= gcds_data1.namevalue(gcds_data1.rowposition,"FDCODE");
	gcds_data2.namevalue(gcds_data2.rowposition,"FSDAT") = gcds_data1.namevalue(gcds_data1.rowposition,"FSDAT");
	gcds_data2.namevalue(gcds_data2.rowposition,"FSNBR") = gcds_data1.namevalue(gcds_data1.rowposition,"FSNBR");
	if(gcds_data2.countrow>=2) {
		gcds_data2.namevalue(gcds_data2.rowposition,"REMARK") = gcds_data2.namevalue(gcds_data2.rowposition-1,"REMARK");
	}
	gcds_data2.namevalue(gcds_data2.rowposition,"WRDT") = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
	gcds_data2.namevalue(gcds_data2.rowposition,"WRID") = gs_userid;

}

</script>

<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 그리드1 -->
<comment id="__NSID__"><object  id=gcds_data1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 그리드2 -->
<comment id="__NSID__"><object  id=gcds_data2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 전표 Master 조회 -->
<comment id="__NSID__"><object  id=gcds_data01_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 지점코드1 -->
<comment id="__NSID__"><object  id="gcds_fdcode1" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 지점코드2 -->
<comment id="__NSID__"><object  id="gcds_fdcode2" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 업무구분 -->
<comment id="__NSID__"><object  id="gcds_fsdat" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 전표번호 -->
<comment id="__NSID__"><object  id="gcds_slipno" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 본부코드 -->
<comment id="__NSID__"><object  id="gcds_divcd" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 결재 -->
<comment id="__NSID__"><object  id="gcds_confirm" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<comment id="__NSID__"><object  id="gcds_temp01" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script>

<comment id="__NSID__"><object  id=gcds_upatcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true"><!-- 상위잔액관련 프로시저 -->
</object></comment><script>__ws__(__NSID__);</script> 


<comment id="__NSID__"><object  id=gcds_batch_copy classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 상위잔액관련 프로시저 -->
</object></comment><script>__ws__(__NSID__);</script> 



<comment id="__NSID__"><object  id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false"><!-- 개별전표 삭제시 전표 mst-->
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 전표번호 생성 -->
<comment id="__NSID__"><object  id=gctr_slipno classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t4f(O:USER=gcds_slipno)">   
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gctr_data1 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"          value="a040010_t1(I:USER=gcds_data1)">   
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 입력/수정 -->
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a040010_t1(I:USER=gcds_data1,I:USER2=gcds_data2)">   
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 입력/수정 -->
<comment id="__NSID__"><object  id=gctr_data06 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t6(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gctr_data2 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 상위잔액관련 프로시저 -->
<comment id="__NSID__"><object  id=gctr_upatcode classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"          value="comm_upatcode_t1(I:USER=gcds_upatcode)">   
</object></comment><script>__ws__(__NSID__);</script> 


<!-- 상위복사 -->
<comment id="__NSID__"><object  id=gctr_batch_copy classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a040010_t5(I:USER=gcds_batch_copy)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표삭제 -->
<comment id="__NSID__"><object  id=gctr_delete classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a040010_t1(I:USER=gcds_mst,I:USER2=gcds_data2)">   
</object></comment><script>__ws__(__NSID__);</script> 



<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data1" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data1" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script><!-- 그리드 1 -->

<script language="javascript" for="gcds_data2" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data2" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt2.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) {
		gclx_fsstat02.bindcolval = gs_fsstat;
		alert("검색된 데이터가 없습니다.");
	}
</script><!-- 그리드 2 -->

<script language="javascript" for="gcds_fdcode1" event="onloadCompleted(row,colid)">
	gcds_fdcode1.InsertRow(1);
	gcds_fdcode1.NameValue(1,"FDCODE")="";
	gcds_fdcode1.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode.index=2;
	}else{
		gclx_fdcode.bindcolval=gs_fdcode;
	}
</script><!-- 지점코드1 -->

<script language="javascript" for="gcds_fdcode2" event="onloadCompleted(row,colid)">
	gcds_fdcode2.InsertRow(1);
	gcds_fdcode2.NameValue(1,"FDCODE")="";
	gcds_fdcode2.NameValue(1,"FDNAME")="전체";
	if(gs_userid=="ACCOUNT"){
		gclx_fdcode02.index=2;
	}else{
		gclx_fdcode02.bindcolval=gs_fdcode;
	}
</script><!-- 지점코드2 -->

<script language="javascript" for="gcds_fsdat" event="onloadCompleted(row,colid)">
	gcds_fsdat.insertrow(1);
	gcds_fsdat.namevalue(1,"CDCODE") = "";
	gcds_fsdat.namevalue(1,"CDNAM") = "전체";
	gclx_fsdat.index = 0;
</script><!-- 업무구분 -->

<script language="javascript" for="gcds_divcd" event="onloadCompleted(row,colid)">
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
	if(row<1) {
		if(colid=="SELECT2") {
			for(i=1;i<=gcds_data1.countrow;i++) {
				gcds_data1.namevalue(i,"SELECT2") = "T";
			}
		}
		else
			return;
	}
	else {
		ln_DispChk(1);
		gs_fsstat=gcds_data1.namevalue(gcds_data1.rowposition,"FSSTAT");
		gcem_actdat02.text = gcds_data1.namevalue(gcds_data1.rowposition,"ACTDAT");
		gcem_wrdt02.text = gcds_data1.namevalue(gcds_data1.rowposition,"UPDT");

		ln_Query('02');
	}
</script>

<script language=JavaScript for=gcgd_disp01 event=Onclick(row,colid)>
	if(row<1) return;
	if(gcds_data1.namevalue(row,"SELECT2") == "T"&&colid=="SELECT2")
		gcds_data1.namevalue(row,"SELECT2") = "F";
	else if(gcds_data1.namevalue(row,"SELECT2") == "F"&&colid=="SELECT2")
		gcds_data1.namevalue(row,"SELECT2") = "T";
</script>

<script language=JavaScript for=gcgd_disp02 event=OnPopup(row,colid,data)>
	var arrParam1	= new Array();
	var arrParam2 = new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam1[0]="";
	arrParam1[1]="";
	arrParam2[0]="0030";
	arrParam2[1]="";

	if(colid == "ATKORNAM") {
		strURL = "./actcode_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam1,strPos);
    
		if (arrResult != null) {
			arrParam1 = arrResult.split(";");
			gcds_data2.namevalue(gcds_data2.rowposition,"ATCODE") = arrParam1[0];
			gcds_data2.namevalue(gcds_data2.rowposition,"ATKORNAM") = arrParam1[1];
		} else {
		}
	}else if(colid == "FSREFVAL") {
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam2,strPos);
    
		if (arrResult != null) {
			arrParam2 = arrResult.split(";");
			gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL01") = arrParam2[0];
			gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL") = arrParam2[1];
		} else {
		}
	}
			
</script>

<script language="javascript"  for=gcgd_disp02 event=OnExit(row,colid,olddata)>
	
	if(gcds_data2.namevalue(row,"CHAAMT") != 0 && gcds_data2.namevalue(row,"DAEAMT") != 0)
		alert("차변과 대변 금액을 확인하십시오.");
	ln_Column();

</script>

<script language=JavaScript for=gclx_sign event=onSelChange()>
	//alert("");
</script>

<script language=JavaScript for=gcgd_disp02 event=onkeypress(key)>

	var arrParam1	= new Array();
	var arrParam2 = new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	arrParam1[0]="";
	arrParam1[1]="";
	arrParam2[0]="0030";
	arrParam2[1]="";

	if(key!=113) return;

	if(gcds_data2.countrow >= 1) {
		if(gcgd_disp02.getcolumn() == "ATKORNAM") {
			gcgd_disp02.setcolumn("FSREFVAL");
			gcgd_disp02.setcolumn("ATKORNAM");
			strURL = "./actcode_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrParam1[0] = gcds_data2.namevalue(gcds_data2.rowposition,"ATKORNAM");
			arrResult = showModalDialog(strURL,arrParam1,strPos);
			if (arrResult != null) {
				arrParam1 = arrResult.split(";");
				gcds_data2.namevalue(gcds_data2.rowposition,"ATCODE") = arrParam1[0];
				gcds_data2.namevalue(gcds_data2.rowposition,"ATKORNAM") = arrParam1[1];
			} else {
			}
			gcgd_disp02.setcolumn("FSREFVAL");
			gcgd_disp02.setcolumn("ATKORNAM");
		}else if(gcgd_disp02.getcolumn() == "FSREFVAL") {
			gcgd_disp02.setcolumn("ATKORNAM");
			gcgd_disp02.setcolumn("FSREFVAL");
			strURL = "./commdtil_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrParam2[1] = gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL");
			arrResult = showModalDialog(strURL,arrParam2,strPos);
			if (arrResult != null) {
				arrParam2 = arrResult.split(";");
				gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL01") = arrParam2[0];
				gcds_data2.namevalue(gcds_data2.rowposition,"FSREFVAL") = arrParam2[1];
			} else {
			}
			gcgd_disp02.setcolumn("ATKORNAM");
			gcgd_disp02.setcolumn("FSREFVAL");
		}
	}
</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gctr_slipno event=OnSuccess()>
		ln_Data1();
</script>

<script language="javascript" for="gctr_slipno" event="onfail()">
    alert("Error Code : " + gctr_slipno.ErrorCode + "\n" + "Error Message : " + gctr_slipno.ErrorMsg + "\n");
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script><!-- 입력/수정 -->


<script language="javascript" for="gctr_data01" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script><!-- 입력/수정 -->

<script language="javascript" for="gctr_data01" event="onfail()">
    alert("Error Code : " + gctr_data01.ErrorCode + "\n" + "Error Message : " + gctr_data01.ErrorMsg + "\n");
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script><!-- 입력/수정 -->

<script language="javascript" for="gctr_data06" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script><!-- 결재 -->

<script language="javascript" for="gctr_data06" event="onfail()">
    alert("Error Code : " + gctr_data06.ErrorCode + "\n" + "Error Message : " + gctr_data06.ErrorMsg + "\n");
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script><!-- 결재 -->

<script language="javascript" for="gctr_data2" event="onsuccess()">
    alter("gs_tolcnt"+gs_tolcnt+"gs_cntmsg"+gs_cntmsg);

	if(gs_tolcnt==gs_cntmsg) alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_data2" event="onfail()">
    alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_upatcode" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_upatcode" event="onfail()">
	alert("Error Code : " + gctr_upatcode.ErrorCode + "\n" + "Error Message : " + gctr_upatcode.ErrorMsg + "\n");
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_batch_copy" event="onfail()">
	alert("Error Code : " + gctr_batch_copy.ErrorCode + "\n" + "Error Message : " + gctr_batch_copy.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_delete" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_delete" event="onfail()">
	alert("Error Code : " + gctr_delete.ErrorCode + "\n" + "Error Message : " + gctr_delete.ErrorMsg + "\n");
</script>



</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>



<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
		<td>
			
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td><img src="../img/a040010_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;">
						<img src="../../Common/img/btn/com_b_sanctionsby.gif"	    style="cursor:hand" onClick="ln_Confirm_Ready('01')" >
						<img src="../../Common/img/btn/com_b_hitotal.gif"			style="cursor:hand" onclick="ln_HighTotal('01')">
						<img src="../../Common/img/btn/com_b_result.gif"			style="cursor:hand" onclick="ln_Approval('01')">
						<img src="../../Common/img/btn/com_b_sanctioncal.gif"	    style="cursor:hand" onclick="ln_AppCancel('01')">
						<img src="../../Common/img/btn/com_b_insert.gif"			style="cursor:hand" onClick="ln_Add('01')" >
						<img src="../../Common/img/btn/com_b_query.gif"				style="cursor:hand" onclick="ln_Query('01')">
					</td>
				</tr>
			</table>

			<table>
				<tr>
					<td>
						
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>처리기간</nobr></td>
								<td class="tab18" align=center><nobr>
									<comment id="__NSID__"><object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										~&nbsp;
									 <comment id="__NSID__"><object  id=gcem_fsdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>

               					<td style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>결재유무</nobr></td>
								<td class="tab18" align=center><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gclx_sign classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:0px;font-size:12px;width:80px;">
											<param name=CBData         value="^전체,N^결재대기,R^결재요청,Y^결재완료,B^반송,C^결재취소">
											<param name=CBDataColumns	 value="FSCODE,FSSTAT">
											<param name=SearchColumn	 value=FSSTAT>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FSSTAT">								
											<param name=BindColumn		 value="FSCODE">
									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr>
								</td> 

								<td style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>지점코드</nobr></td>
								<td class="tab18" align=center><nobr>
									<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:0px;font-size:12px;width:80px;">
											<param name=ComboDataID    value="gcds_fdcode1">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value=FDNAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FDNAME">								
											<param name=BindColumn		 value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>

								<td style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>업무구분</nobr></td>
								<td class="tab18" width="320" align=left><nobr>
									<comment id="__NSID__"><object  id=gclx_fsdat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:5px;top:0px;font-size:12px;width:80px;">
											<param name=ComboDataID  value="gcds_fsdat">
											<param name=CBDataColumns	 value="CDCODE,CDNAM">
											<param name=SearchColumn	 value="CDNAM">
											<param name=Sort			     value="false">
											<param name=ListExprFormat value="CDNAM">								
											<param name=BindColumn		 value="CDCODE">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
							</tr>
					 </table>

					</td>
				</tr> 
				<tr>
					<td width="876px"  class="tab15" align="right" >
					<nobr>				
						<font style="position:relative;top:-4px;left:0px">[데이타 일괄 복사]>>>>[원본월]</font>&nbsp;
						<comment id="__NSID__">&nbsp;
								<object  id=gcem_bf_yyyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:2px">		
													<param name=Text					value="">
													<param name=Alignment     value=0>
													<param name=Border        value=true>
													<param name=Format        value="####/##">
													<param name=Format        value="YYYY/MM">
													<param name=PromptChar    value="_">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
								 </object></comment><script>__ws__(__NSID__);</script> 
						<font style="position:relative;top:-4px;left:0px">==>[복사월]</font>
							
							<comment id="__NSID__">&nbsp;
								<object  id=gcem_af_yyyymm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:2px">		
													<param name=Text					value="">
													<param name=Alignment     value=0>
													<param name=Border        value=true>
													<param name=Format        value="####/##">
													<param name=Format        value="YYYY/MM">
													<param name=PromptChar    value="_">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
								 </object></comment><script>__ws__(__NSID__);</script> &nbsp;
							<img src="../../Common/img/btn/com_b_total.gif"		style="cursor:hand;position:relative;top:2px;left:0px" onClick="ln_Batch_Copy()">
						</nobr>
					</td>
				</tr>
			</table>

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
				<tr> 			
					<td style="width:280" ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:3px;width:875px; height:420px; border:1 solid #708090;display:block;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data1">
								<PARAM NAME="IndWidth"		VALUE="0">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value="1">
								<param name="ColSizing"   value="true">
								<param name="Editable"    value="false">
								<PARAM NAME="Format"			VALUE="
								<C> Name='선택'		ID=SELECT2	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=50	  align=center  EditStyle=CheckBox</C> 
								<C> Name='지점구분'		ID=FDCODE 	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=80	  align=center	 sort=true  EditStyle=Lookup Data='gcds_fdcode1:FDCODE:FDNAME'</C> 
								<C> Name='업무구분'		ID=FS1 	     HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=80	  align=center	 sort=true  EditStyle=Lookup Data='gcds_fsdat:CDCODE:CDNAM'</C> 
								<C> Name='전표번호'		ID=FSDAT2 	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=110	  align=center sort=true </C> 
								<C> Name='적요'			  ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=350	  align=left	 sort=true  SumText='합   계'</C> 
								<C> Name='금액'		  	ID=FSAMT 	   HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=110	  align=right  sort=true  SumText=@sum</C> 
								<C> Name='결재여부'		ID=FSSTAT 	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=77	  align=center	 sort=true  EditStyle=Combo Data='N:결재대기,R:결재요청,Y:결재완료,B:반송,C:결재취소' </C> 
								">
						</object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;">조회건수 :</font>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>		

<!--------- 전표입력 ----------->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td><img src="../img/a040010_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
						<img src="../../Common/img/btn/com_b_exit.gif"  style="cursor:hand" onclick="ln_Close('02')">
						<img src="../../Common/img/btn/com_b_hitotal.gif"  style="cursor:hand" onclick="ln_HighTotal('02')">
						<!-- <img src="../../common/img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print('02')"> --><!-- 출력 -->
					 	<!--img src="../../common/img/btn/com_b_sanctionreq.gif"	style="cursor:hand" onClick="ln_Popup_Confirm()"--><!--요청-->
					 	<img src="../../Common/img/btn/com_b_result.gif"	style="cursor:hand" onclick="ln_Approval('02')"><!--결재-->
						<img src="../../Common/img/btn/com_b_sanctioncal.gif"	style="cursor:hand" onclick="ln_AppCancel('02')">
						<img src="../../Common/img/btn/com_btn_slipdel.gif"	style="cursor:hand" onClick="ln_Delete('02')" ><!--전표삭제-->
						<img src="../../Common/img/btn/com_b_insert.gif"  style="cursor:hand" onclick="ln_Add('02')"><!--등록-->
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save('02')"><!--저장-->
						<img src="../../Common/img/btn/com_b_excel.gif"		style="cursor:hand" onClick="ln_Excel()">
						<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('03');"><!--조회-->
					</td>
				</tr>
			</table>

			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;전표번호</nobr></td>
								<td class="tab18" style="width:160px;"><nobr>&nbsp;
                  					<comment id="__NSID__"><object  id=gcem_fs02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:17px;height:20px;position:relative;left:-3px;top:3px">				
														<param name=Text					value="">
														<param name=Border        value=true>
														<param name=Format        value="#">
														<param name=PromptChar    value="_">
														<param name=UpperFlag     value=1>
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
									<comment id="__NSID__"><object  id=gcem_fsdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:-3px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										-&nbsp;
									 <comment id="__NSID__"><object  id=gcem_fsnbr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:46px;height:20px;position:relative;left:-3px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="######">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
                				<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;전표상태&nbsp;</nobr></td>
								<td class="tab18" style="width:130px;"><nobr>&nbsp;	
									<comment id="__NSID__"><object  id=gclx_fsstat02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:-3px;top:2px;font-size:12px;width:80px;">
											<param name=CBData         value="^전체,N^결재대기,R^결재요청,Y^결재완료,B^반송,C^결재취소">
											<param name=CBDataColumns	 value="FSCODE,FSSTAT">
											<param name=SearchColumn	 value=FSSTAT>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FSSTAT">								
											<param name=BindColumn		 value="FSCODE">
											<param name=enable         value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr> 
								</td>
                
                				<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;담당부서&nbsp;</nobr></td>
								<td class="tab18" style="width:120px;"><nobr>&nbsp;	
									<input id="txt_deptcd02" type="hidden" class="txtbox" style= "width:50px;height:20px;position:relative;left:-4px"  readOnly="true"> 
									<input id="txt_deptnm02" type="text" class="txtbox"  style= "width:120px;height:20px;position:relative;left:-8px;background-color:#d7d7d7"  readOnly="true"></nobr>	
								</td>

								<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;담당자&nbsp;</nobr></td>
								<td class="tab18" style="width:130px;"><nobr>&nbsp;
								 <input id="txt_empno02" type="hidden" class="txtbox"  style= "width:50px;height:20px;position:relative;left:-4px"  readOnly="true">
								 <input id="txt_empnmk02" type="text" class="txtbox"   style= "width:120px;height:20px;position:relative;left:-8px;background-color:#d7d7d7" readOnly="true">
									</nobr>
								</td>
							</tr>
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center><nobr>&nbsp;지점</nobr></td>
								<td class="tab19" style="width:160px;" ><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gclx_fdcode02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:-3px;top:2px;font-size:12px;width:145px;">
											<param name=ComboDataID    value="gcds_fdcode2">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value="FDNAME">
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FDNAME^0^150">								
											<param name=BindColumn		 value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr>
								</td>
								
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;회계월&nbsp;</nobr></td>
								<td class="tab19" style="width:120px;"><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gcem_actdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative;left:-3px;top:2px;width:55px;height:20px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM">
											<param name=PromptChar	  value="_">
											</object></comment><script>__ws__(__NSID__);</script> 
											<!--img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar()" style="position:relative;width:20px;left:2px;cursor:hand;"-->
											<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat02', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
											<!--img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_A040010_Popup()" style="position:relative;width:20px;left:2px;cursor:hand;"-->
											</nobr>
								</td>
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;금액&nbsp;</nobr></td>
								<td class="tab19" style="width:130px;" ><nobr>&nbsp;	
									<comment id="__NSID__"><object  id=gcem_fsamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:-4px;top:3px">				
											<param name=Text					value="0">
											<param name=Border        value=true>
									    	<param name=Alignment     value=2>
						                    <param name=Numeric       value="true">
						                    <param name=IsComma       value=true>
											<param name=MaxLength     value=12>
											<param name=BackColor     value="#CCCCCC">
                      						<param name=ReadOnlyBackColor   value="#D7D7D7">
											<param name=InheritColor  value=false>
											<param name=ReadOnly      value=true>
									</object></comment><script>__ws__(__NSID__);</script> 
									<input id="txt_atkornam" type="hidden" class="txtbox" style= "width:50px;height:20px;position:relative;left:-4px"> 
									</nobr>	
								</td>

								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;작성일자&nbsp;</nobr></td>
								<td class="tab19" style="width:120px;"><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gcem_wrdt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative;left:-3px;top:2px;width:75px;height:20px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
											<param name=ReadOnly      value=true>
											</object></comment><script>__ws__(__NSID__);</script> 
											<!--img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar()" style="position:relative;width:20px;left:2px;cursor:hand;"-->
											<!-- <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_actdat02', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;"> -->
											<!--img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_A040010_Popup()" style="position:relative;width:20px;left:2px;cursor:hand;"-->
											</nobr>
								</td>
							</tr>
              
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center><nobr>&nbsp;적요</nobr></td>
								<td colspan=7 class="tab19" style="width:795px;" ><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gcem_remark02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:788px;height:20px;position:relative;left:-3px;top:3px">				
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=ReadOnlyBackColor   value="#D7D7D7">
										<param name=InheritColor  value=false>
										<param name=ReadOnly      value=true>
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>

							</tr>
							<tr width="876px"> 
							</tr>
					 </table>
					</td>
				</tr>
				<tr>
					<td>
						<table width=876px cellpadding=0 cellspacing=0 border=0 style=position:relative;left:0px>
             				<tr>			
							  <td colspan=5 color="#0000FF"></td>
								<td width="240px" align=right colspan=2 >
								  <img src="../../Common/img/btn/com_b_rowdel.gif"	       style="cursor:hand;position:relative;left:125px" onClick="ln_Delete('dis')">
									<img src="../../Common/img/btn/com_b_rowadd.gif"         style="cursor:hand;position:relative;left:125px" onclick="ln_Add('99')">
									<img src="../../Common/img/btn/com_btn_insert_add.gif"   style="cursor:hand;position:relative;left:125px" onclick="ln_Insert()">
								</td>
							</tr>
							<tr>
								<td width=77px></td>	
								<td width=165px></td>	
								<td width=89px></td>	
								<td width=89px></td>	
								<td width=98px></td>	
								<td width=275px></td>	
								<td width=100px></td>
							</tr>	
							
				 			<tr>
								<td colspan=7>
								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:0px">
								<tr>
								<td style="width:280" ALIGN=LEFT VALIGN=TOP>
								<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
							  style="position:relative;left:0px;width:875px; height:355px; border:1 solid #708090;display:block;" viewastext>
								<PARAM NAME="DataID"			VALUE="gcds_data2">
								<PARAM NAME="IndWidth"		VALUE="0">
								<PARAM NAME="BorderStyle" VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value="1">
								<param name="ColSizing"   value="true">
								<param name="Editable"    value="true">
								<PARAM NAME="Format"			VALUE="  
								<C> Name='순번'		    ID=FSNUM  	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=40	  align=center	 </C> 
								<C> Name='계정코드'		ID=ATCODE 	 HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=80	  align=center sort=true</C> 
								<C> Name='계정명'		    ID=ATKORNAM  HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=160  align=left	 sort=true EditStyle=Popup sumtext='합 계'</C> 
								<C> Name='차변금액'		ID=CHAAMT    HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=100	align=right	 sort=true color=blue SumText=@sum sumcolor=blue</C> 
								<C> Name='대변금액'		ID=DAEAMT	   HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=100	align=right  sort=true color=red  SumText=@sum sumcolor=red</C> 
								<C> Name='적요'			ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=175	align=left	 sort=true</C> 
								<C> Name='원가코드'	    ID=FSREFVAL  HeadAlign=Center HeadBgColor=#B9D4DC sumbgcolor=#c3d0db Width=200	align=left	 sort=true EditStyle=Popup</C> 
								">
								</object></comment><script>__ws__(__NSID__);</script> 
								<fieldset style="position:relative;left:0px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt2 style="position:relative;top:4px;">조회건수 :</font>
								</fieldset>
								</td>
								</tr>
								</table>
								</td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
    </td>
	</tr>
</table>

<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<!-- 전표등록 MASTER-->
<comment id="__NSID__"><object  id=gcbn_data1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data1>
	<param name=BindInfo  value='
		<C>Col=FDCODE              Ctrl=gclx_fdcode02            Param=bindcolval</C>
		<C>Col=FS1                 Ctrl=gcem_fs02                Param=text</C>
		<C>Col=FSDAT1              Ctrl=gcem_fsdat02             Param=text</C>
		<C>Col=FSNBR               Ctrl=gcem_fsnbr02             Param=text</C>
		<C>Col=REMARK              Ctrl=gcem_remark02            Param=text</C>
		<C>Col=FSAMT               Ctrl=gcem_fsamt02             Param=text</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표등록 MASTER 조회-->
<comment id="__NSID__"><object  id=gcbn_data2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data2>
	<param name=BindInfo  value='  
		<C>Col=FSSTAT              Ctrl=gclx_fsstat02            Param=bindcolval</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!--	L O A D I N G  B A R   D E F I N I T I O N -->


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
