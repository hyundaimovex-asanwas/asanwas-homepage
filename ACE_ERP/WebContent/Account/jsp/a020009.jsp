<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  전표관리 - 등록(새로운 화면에서 처리함)
+ 프로그램 ID	:  A020009.html
+ 기 능 정 의	:  전표를 입력/조회 하는 화면이다
+ 작   성  자 :  정 영 식
+ 작 성 일 자 : 
-----------------------------------------------------------------------------
+ 수 정 내 용 :	 
+ 수   정  자 :
+ 수 정 일 자 :
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>전표등록</title>

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



/******************************************************************************
	Description : 페이지 로딩
******************************************************************************/
//get_cookdata();

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var g_strbanjae="N"  //반제유무
var g_taxval=0;         //세금계산서 금액 합계
var g_fsknd="0";       //기표종류  0 - 수동전표, 1- 세금계산서, 2 - 고정자산

var gs_team_user="";
                     //          3 - 자금      6- 반제      
var g_add_gubun="";  //신규건과 수정건 구분하기.(2007.05.11 정영식 추가)

var g_arrParam	= new Array();

function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

    ln_SetDataHeader("01_2");
	gcds_data01_2.addrow();
	
	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1="+gs_userid;
	
	//prompt('',gcds_dept.DataID );
	gcds_dept.Reset();

	ln_Before();
	
	
	if(gf_USER(gs_deptcd,gcds_dept2)){ // 회계팀 체크 
		gs_team_user="true";
	}else{
		gs_team_user="false";
	}
	
	
	//2020.01.21 임시
	if(gs_userid=="asan001"||gs_userid=="asan002"||gs_userid=="asan003"||gs_userid=="asan004"||gs_userid=="asan005"){
		sp3.style.display = "none"; //숨김
		sp4.style.display = "none"; //숨김
	}else{
		sp3.style.display = "";  //보여줌 
		sp4.style.display = "";  //보여줌
	}
	
	
	
	//경리관련부서만 열어놓음.
	if(gf_empno_Enable(gs_userid,gcds_userid2)){
		gclx_fdcode02.bindcolval=gs_fdcode;
		gs_userid2="true";
		sp0.style.display = "";  //보여줌
		if(gs_fdcode!='02') gclx_fdcode02.Enable=false; 
	}else{
    	gclx_fdcode02.bindcolval=gs_fdcode;
		gclx_fdcode02.Enable=false; 
     	gs_userid2="false";
		sp0.style.display = "none"; //숨김
			/*
			if(gs_fdcode !='03'){
				gclx_fdcode02.bindcolval=gs_fdcode;
				gclx_fdcode02.Enable=false; 
				gs_userid2="false";
				sp0.style.display = "none"; //숨김
			}else{
				gclx_fdcode02.bindcolval=gs_fdcode;
				gs_userid2="true";
				sp0.style.display = "";  //보여줌
			}
			*/
	}
	gclx_fdcode02.bindcolval=gs_fdcode;
	gs_userid2="true";
	sp0.style.display = "";  //보여줌
	if(gs_fdcode!='02') gclx_fdcode02.Enable=false; 

	txt_deptnm02.value= fn_trim(gs_deptnm);
	txt_deptcd02.value= gs_deptcd;
	txt_empno02.value=gs_userid;
	txt_empnmk02.value=gs_usernm;

    ln_Add("02",''); 
	ln_Data_Mst_Setting();
	
	
	gclx_fdcode02.Enable=true; 
	
	
	
}

/******************************************************************************
	Description : 전표 MST 초기값 설정
	parameter   : 
******************************************************************************/
function ln_Data_Mst_Setting(){
	   
	    //jys 20160229
	    // 서울에서 개성전표 작성하기 위해 임시로 적용함.  
	    if(gusrid=="2140004"||gusrid=="6180021"||gusrid=="6070001"){
	    	
	    }else{
	      gclx_fdcode02.bindcolval = gs_fdcode;
	    }
	    
		gcem_fs02.text = "A";
		gcem_fsdat02.text=gs_date;
		gcem_fsnbr02.text="000000";
		gclx_fsstat02.bindcolval="N";
		gcem_fswrtdat02.text = gs_date;   //작성일자
		gcem_actdat02.text = gs_date;     //회계일자
		gcem_fsamt02.text = 0; 


		txt_deptnm02.value=gdeptnm;
		txt_deptcd02.value=gdeptcd;
		txt_empno02.value=gusrid;
		txt_empnmk02.value=gusrnm;
	}

/******************************************************************************
	Description : 조회
	parameter   : 01 - 전표 MST 조회 
	

  참고        : 전표 DETAIL 조회 - 전표번호별 (접수번호가 000000 일 경우는 접수일자+전표번호로만 조회함.)
******************************************************************************/
function ln_Query(p){

  ln_Ref_Data_Clear(); //관리항목 데이타 삭제
  ln_Ref_Format_Setting();//초기화

  hid_b_fdcode.value=gclx_fdcode02.bindcolval;
	hid_b_fs.value = gcem_fs02.text; 
	hid_b_fsdat.value=gcem_fsdat02.text; 
	hid_b_fsnbr.value=gcem_fsnbr02.text;
  
	var fsdat=gcem_fs02.text+gcem_fsdat02.text;
	var fsnbr=gcem_fsnbr02.text;
	var ssdat=gcem_ss02.text+gcem_ssdat02.text;
	var ssnbr=gcem_ssnbr02.text;

    if(p=="01"){
		if((fsnbr=="000000"||fn_trim(fsnbr)=="")&&(ssnbr=="000000"||fn_trim(ssnbr)=="")){
			return;
		}
	}else if(p=="03"){
		if((fsnbr=="000000"||fn_trim(fsnbr)=="")&&(ssnbr=="000000"||fn_trim(ssnbr)=="")){
			alert("전표번호 또는 접수번호를 입력하십시요.");
			return;
		}
	}

	if(fsnbr=="000000"||fn_trim(fsnbr)==""){
    	fsdat="";
		fsnbr="";
	}

	if(ssnbr=="000000"||fn_trim(ssnbr)==""){
    	ssdat="";
		ssnbr="";
	}

	ln_DataSet_Clear(); //모든 데이타 셋 clear;

	if(p=="01"){
		gcds_data01_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s8?v_str1="+gclx_fdcode02.bindcolval
																							   	     +"&v_str2="+fsdat
																							         +"&v_str3="+fsnbr
																									 +"&v_str4="+ssdat
																									 +"&v_str5="+ssnbr;										
		//prompt("",gcds_data01_2.DataID );																							
		gcds_data01_2.Reset();
	}else if(p=="03"){
		gcds_dtl.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s7f?v_str1="+gclx_fdcode02.bindcolval
																									 +"&v_str2="+fsdat
																									 +"&v_str3="+fsnbr
																									 +"&v_str4="+ssdat
																									 +"&v_str5="+ssnbr;		
        //prompt("gcds_dtl::",gcds_dtl.DataID);																									 
		gcds_dtl.Reset(); 
	}
}

/************************************************************************************************************
Description : 본부코드 찾기
parameter   :
*************************************************************************************************************/
/*
function ln_Find_Divcd(){
	gcds_divcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s9?v_str1="+gs_deptcd;																						
	gcds_divcd.Reset();
	if(gcds_divcd.countrow>0){
		return gcds_divcd.namevalue(gcds_divcd.rowposition,"DIVCD");
	}else{
		return;
	}
}

/************************************************************************************************************
	Description : 전표 신규등록
	parameter   :   p  02 : 전표등록화면에서 등록,  
									   99 : 행추가
							gubun  TAX : 세금계산서에서 추가 하는 항목으로 ln_Chk_Addrow를 타지않음.

*************************************************************************************************************/
function ln_Add(p,gubun){
  if(p=='02'){
	    ln_DataSet_Clear();
	    ln_Data_Add_Set();
		gcds_dtl.deleteall();
		ln_SetDataHeader("DTL");
		gcds_dtl.Addrow();
		ln_Lock_false();
		ln_Bgt_Amt_Clear();
		ln_MST_Data_Clear();		
		//2014.01.06 jys 추가
		ln_Data_Mst_Setting();
		//순번설정
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")= ln_Fsnum_Find();
		gcem_atkornam02.Focus();
		g_add_gubun = "New";
	}else if(p=='99'){        //행추가 
    	if(gcds_dtl.rowposition>0){
			if(gubun == "TAX"){
				//첫번째에서 두번째 행추가 할때 부서,거래처,적요 저장
				////if(gcds_dtl.countrow==1){
				ln_Copy_Dept_Vend_Reamrk(gcds_dtl.rowposition,'TAX');
				////}
				gcds_dtl.Addrow();
				//순번설정
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")= ln_Fsnum_Find();
			}else{
				if(ln_Chk_Addrow()){
					//첫번째에서 두번째 행추가 할때 부서,거래처,적요 저장
					if(!ln_Chk_Status('U'))return;
					////if(gcds_dtl.countrow==1){
					ln_Copy_Dept_Vend_Reamrk(gcds_dtl.rowposition,'');
					////}
					gcds_dtl.Addrow();
					//순번설정
					gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")= ln_Fsnum_Find();
				}else{
					return false;
				}
			}
		}
	}

	ln_Data_Fdcode_Fsdat_Fsnbr();
	return true;
}

/******************************************************************************
	Description : Mst Data 초기값 설정
	parameter   : 
******************************************************************************/
function ln_Data_Add_Set(){
	gcem_fs02.text = "A";
	gcem_fsdat02.text=gs_date;
	gcem_fsnbr02.text="000000";
	gclx_fsstat02.bindcolval="N";
	gcem_fswrtdat02.text=gs_date; //작성일자
	gcem_actdat02.text=gs_date;     //회계일자
	gcem_fsamt02.text = 0 ; 
}
/************************************************************************************************************
	Description : 키값 자동 생성
	parameter   :    
*************************************************************************************************************/
function ln_Data_Fdcode_Fsdat_Fsnbr(){
  	var t1=0; //gcds_dtl 의 max값 
	var t2=0; //gcds_seq 의 max값
  	hid_fdcode.value="";
	hid_fsdat.value ="";
	hid_fsnbr.value="";
	hid_fsseq.value ="";

	hid_fdcode.value = gclx_fdcode02.bindcolval;
  	hid_fsdat.value = gcem_fs02.text+gcem_fsdat02.text;
 	hid_fsnbr.value = gcem_fsnbr02.text;

	if(gcds_dtl.countrow>0){
		t1 = gcds_dtl.Max(4,0,0);
	}

  	if(gcds_fsseq.countrow>0){
		t2 = gcds_fsseq.Max(4,0,0);
	}
  
  	if(t1>=t2){
		hid_fsseq.value = Number(gcds_dtl.Max(4,0,0))+1;
	}else{
    	hid_fsseq.value = Number(gcds_fsseq.Max(4,0,0))+1;
	}

	//alert(" hid_fsseq.value:1:"+ hid_fsseq.value);
	hid_fsseq.value = ln_Seqno_Format(hid_fsseq.value,5)
  //alert(" hid_fsseq.value:2:"+ hid_fsseq.value);

	//alert("hid_fdcode.value::"+hid_fdcode.value);
}

/******************************************************************************
	Description : 행삽입
	parameter   : 
******************************************************************************/
function ln_Insert(){
 	var insertrow=0;
	var strdocumcd="";
	var strdocuval="";
  	var strvendcd="";
	var strvendnm="";
	var fsdat=gcem_fs02.text+gcem_fsdat02.text;
	
	if(!ln_Chk_Status('U'))return;
	
	
	//2015.02.23.JYS 행삽입시 증빙 안가져옴.. 김양묵 CJ 요청
	//증빙값(세금계산서번호등)이 존재할 경우 증빙코드 및 증빙값을 복사해서 가져옴.
	/*
	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")!=""){
	  //ln_Copy_Dept_Vend_Reamrk(gcds_dtl.rowposition);
		strdocumcd=gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD");
		strdocuval=gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL");
		strvendcd=gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02");
		strvendnm=gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02");
	}
	*/
	
	
	insertrow = gcds_dtl.rowposition + 1 ; 
	if(gcds_dtl.rowposition>0){
		gcds_dtl.Insertrow(insertrow);
		//순번설정
		gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")= ln_Fsnum_Find();
		//이후 순번은 재설정함
		ln_Fsnum_Reset(gcds_dtl.rowposition,"01");
		if(strdocuval!=""){
		  //ln_Paste_Dept_Vend_Reamrk(gcds_dtl.rowposition);
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD")=strdocumcd;
			gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")=strdocuval;
			gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")=strvendcd;
			gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")=strvendnm;
			ln_Dtl_Lock(gcds_dtl.rowposition);

			//세금계산서 데이타 셋에 추가함.
			ln_Tax_Data_Save(strdocuval, gs_date, gs_userid, fsdat);
		} 
	}
	ln_Data_Fdcode_Fsdat_Fsnbr();
}

/******************************************************************************
	Description : 삭제
	parameter   : p - 01 : 전표전체삭제  mst, detail, 관리항목 + (계산서 Master, 계산서 Detail)
	                  99 : detail  및 관리항목 삭제 + (계산서 Master, 계산서 Detail)
										dis: 화면에서만 삭제되고 실제 DB 삭제는 안됨.
******************************************************************************/
function ln_Delete(p){
  var chkgubun="";
  if(!ln_Chk_Status('U'))return;
	if(p=="dis"){

	  if(!ln_Chk_Row_Del_Banjae(gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FDCODE"),
		                        gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSDAT"),
								gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSNBR"),
								gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSSEQ"))){
			
	  //반제테이블에 존재하지 않을 경우
      //반제데이타 셋에 존재하는 경우 삭제 불가,
      		for(m=1;m<=gcds_banjae.countrow;m++){
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(m,"BTSSEQ")){
					chkgubun="1";
				}
			}

	      //반제가 존재함.
	        if(chkgubun=="1"){
				alert("해당 계정은 반제적용입니다. 반제수정 후 삭제하십시요.");
				return;
			}else{
				
				//alert("DOCUVAL::"+gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"DOCUVAL")+"::");
				if(gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"DOCUVAL")!=""&&gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"DOCUVAL")!=undefined){
					ln_Tax_Del_Row(gcds_dtl.rowposition); //세금계산서가 존재할 경우 세금계산서 및 전표번호 저장
				}

				ln_Data_Dtl_Delete(gcds_dtl.rowposition);		
				ln_Data_Bgt_Delete(gcds_dtl.rowposition);	
				//prompt("gcds_dtl_del::",gcds_dtl_del.text);	

				ln_Fsseq_Temp(gcds_dtl.rowposition);
				gcds_dtl.deleterow(gcds_dtl.rowposition);
				//이후 순번은 재설정함
				ln_Fsnum_Reset(gcds_dtl.rowposition,"02");
			}
		}else{
		  //반제테이블에 존재하는 경우
			alert("해당 계정은 반제계정입니다. 행삭제 할 수 없습니다.");
			return;
		}
	}
}

/******************************************************************************
	Description : 전체 삭제
	prameter    :
******************************************************************************/
function ln_Delete_All(){
    var p1 = gclx_fdcode02.bindcolval;
	var p2 = gcem_fs02.text+gcem_fsdat02.text; 
	var p3 = gcem_fsnbr02.text;

	if(!ln_Chk_Status('D'))return;

	if(gcem_fsnbr02.text=="000000") return;
	
	if(txt_fsknd02.value>="1"){
		alert("자동기표로 생성된 전표입니다. 삭제할 수 없습니다.");
		return;
	}

	//반제건인경우 삭제 못하게 함.
	if(ln_Chk_Del_Banjae(p1,p2,p3)){
		alert("반제처리 전표는 삭제할 수 없습니다.");
		return;
	}

	ln_SetDataHeader("MST_DEL");
	gcds_del02.addrow();
	gcds_del02.namevalue(gcds_del02.rowposition,"FDCODE")=p1;
	gcds_del02.namevalue(gcds_del02.rowposition,"FSDAT")=p2;
	gcds_del02.namevalue(gcds_del02.rowposition,"FSNBR")=p3;
	//2017.02.01 전표 종류
	gcds_del02.namevalue(gcds_del02.rowposition,"FSKND")=gcds_data01_2.namevalue(1,"FSKND");
	
	if (gcds_del02.IsUpdated){
	  ln_Del_All_Bgt_find(); //삭제건 중 예산이 존재하는 건 찾기
	  if(ln_Chk_Tax(p1,p2,p3)){
			if(confirm("증빙문서가 존재합니다. 삭제하시겠습니까?")){	
				gctr_data02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t2f?";
			  //prompt("gcds_del02",gcds_del02.text);
				gctr_data02.post();
				ln_Add('02','');
			}else{
				gcds_del02.Undo(gcds_del02.rowposition);
				gcds_bgt_del_all.Undo(gcds_bgt_del_all.rowposition);
				return;
			}
	  }else{
			if (confirm("삭제하시겠습니까?")){	
				gctr_data02.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t2f?";
		        //prompt("gcds_del02",gcds_del02.text);
				//prompt("gcds_bgt_del_all",gcds_bgt_del_all.text);
				gctr_data02.post();
				ln_Add('02','');
			}else{
				gcds_del02.Undo(gcds_del02.rowposition);
				gcds_bgt_del_all.Undo(gcds_bgt_del_all.rowposition);
				return;
			}
		}
	}
}

/******************************************************************************
	Description : 삭제 후 삽입건에 대한 FSSEQ의 MAX값을 유지하기 위한 임시데이타셋
	parameter   :
******************************************************************************/
function ln_Fsseq_Temp(i){
	ln_SetDataHeader("FSSEQ");
    gcds_fsseq.addrow();
	gcds_fsseq.namevalue(gcds_fsseq.rowposition,"FDCODE") = gcds_dtl.namevalue(i,"FDCODE");
	gcds_fsseq.namevalue(gcds_fsseq.rowposition,"FSDAT")  = gcds_dtl.namevalue(i,"FSDAT");
	gcds_fsseq.namevalue(gcds_fsseq.rowposition,"FSNBR")  = gcds_dtl.namevalue(i,"FSNBR");
	gcds_fsseq.namevalue(gcds_fsseq.rowposition,"FSSEQ")  = gcds_dtl.namevalue(i,"FSSEQ");
}

/******************************************************************************
	Description : 저장
	parameter   :
******************************************************************************/
function ln_Save(){
		
	if(ln_Chk_Save()){
		ln_Data_Mst();
		ln_Data_Dtl(gcds_data01_2.namevalue(gcds_data01_2.rowposition,"COCODE"));
		if (gcds_mst.IsUpdated||gcds_dtl.IsUpdated){
			if (confirm("저장하시겠습니까?")){	
				gctr_data01.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020009_t1?";
				//prompt("gctr_data01",gctr_data01.Action);
				if(gcds_mst.countrow==0)          gcds_mst.ClearAll();
				if(gcds_dtl_insert.countrow==0)   gcds_dtl_insert.ClearAll();
				if(gcds_dtl_update.countrow==0)   gcds_dtl_update.ClearAll();
				if(gcds_dtl_del.countrow==0)      gcds_dtl_del.ClearAll();
				if(gcds_banjae.countrow==0)       gcds_banjae.ClearAll();
				if(gcds_banjaemst.countrow==0)    gcds_banjaemst.ClearAll();
				if(gcds_tax.countrow==0)          gcds_tax.ClearAll();
				if(gcds_genrst.countrow==0)       gcds_genrst.ClearAll();
				if(gcds_bgt_insert.countrow==0)   gcds_bgt_insert.ClearAll();
				if(gcds_bgt_update.countrow==0)   gcds_bgt_update.ClearAll();
				if(gcds_bgt_del.countrow==0)      gcds_bgt_del.ClearAll();
				if(gcds_fsnum.countrow==0)        gcds_fsnum.ClearAll();
				if(gcds_tax_del_row.countrow==0)  gcds_tax_del_row.ClearAll();

        
				if(gusrid=="6070001"){
					prompt("gcds_mst",gcds_mst.text);
					prompt("gcds_dtl_insert",gcds_dtl_insert.text);
					prompt("gcds_dtl_update",gcds_dtl_update.text);
					prompt("gcds_dtl_del",gcds_dtl_del.text);
					prompt("gcds_banjae",gcds_banjae.text);
					prompt("gcds_banjaemst",gcds_banjaemst.text);
					prompt("gcds_tax",gcds_tax.text);
					prompt("gcds_genrst",gcds_genrst.text);
					prompt("gcds_bgt_insert",gcds_bgt_insert.text);
					prompt("gcds_bgt_update",gcds_bgt_update.text);
					prompt("gcds_bgt_del",gcds_bgt_del.text);
					prompt("gcds_fsnum",gcds_fsnum.text);
					prompt("gcds_tax_del_row",gcds_tax_del_row.text);
				}
			
			    /*
					prompt("gcds_mst",gcds_mst.text);
					prompt("gcds_dtl_insert",gcds_dtl_insert.text);
					prompt("gcds_dtl_update",gcds_dtl_update.text);
					prompt("gcds_dtl_del",gcds_dtl_del.text);
					prompt("gcds_banjae",gcds_banjae.text);
					prompt("gcds_banjaemst",gcds_banjaemst.text);
					prompt("gcds_tax",gcds_tax.text);
					prompt("gcds_genrst",gcds_genrst.text);
					prompt("gcds_bgt_insert",gcds_bgt_insert.text);
					prompt("gcds_bgt_update",gcds_bgt_update.text);
					prompt("gcds_bgt_del",gcds_bgt_del.text);
					prompt("gcds_fsnum",gcds_fsnum.text);
					prompt("gcds_tax_del_row",gcds_tax_del_row.text);
				  */
		    
				gctr_data01.Parameters = "v_str1="+gs_fdcode;
				gctr_data01.post();

				ln_Query('03');
				ln_Query('01');
				g_add_gubun=""; //신규,수정 구분
			}else{
				gcds_mst.ClearAll();
				gcds_dtl_insert.ClearAll();
				gcds_dtl_update.ClearAll();
				gcds_dtl_del.ClearAll();
				gcds_banjae.ClearAll();
				gcds_banjaemst.ClearAll();
				gcds_tax.ClearAll();
				gcds_bgt_insert.ClearAll();
				gcds_bgt_update.ClearAll();
				gcds_bgt_del.ClearAll();
				gcds_fsnum.ClearAll();
				gcds_tax_del_row.ClearAll();
			}
		}
	}
}

/******************************************************************************
	Description : 전표 MST 저장
	parameter   :
******************************************************************************/
function ln_Data_Mst(){
	    ln_SetDataHeader("MST");
	    var row = gcds_data01_2.rowposition;
		var strcocode = ln_Cocode(gcds_data01_2.namevalue(row,"COCODE"));
        gcds_mst.addrow();

		gcem_fsamt02.text = gcds_dtl.sum(9,0,0);
	  /** 신규건과 수정건을 구분함
		gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01_2.OrgNameString(row,"FDCODE");
		gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcds_data01_2.OrgNameString(row,"FSDAT1")+gcds_data01_2.OrgNameString(row,"FSDAT2") ;
		gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcds_data01_2.OrgNameString(row,"FSNBR");
		**/
		
		//2007.05.11 정영식 신규건과 수정건을 구분함.   
		/*
		if(g_add_gubun=="New"){ //신규건
			gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01_2.namevalue(row,"FDCODE");
			gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcds_data01_2.namevalue(row,"FSDAT1")+gcds_data01_2.namevalue(row,"FSDAT2") ;
			gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcds_data01_2.namevalue(row,"FSNBR");
		}else{ //수정건
      gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01_2.OrgNameString(row,"FDCODE");
			gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcds_data01_2.OrgNameString(row,"FSDAT1")+gcds_data01_2.OrgNameString(row,"FSDAT2") ;
			gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcds_data01_2.OrgNameString(row,"FSNBR");
		}
		*/

		//2007.05.20 정영식 org.사용안함.
		gcds_mst.namevalue(gcds_mst.rowposition,"FDCODE")=gcds_data01_2.namevalue(row,"FDCODE");
		gcds_mst.namevalue(gcds_mst.rowposition,"FSDAT")=gcds_data01_2.namevalue(row,"FSDAT1")+gcds_data01_2.namevalue(row,"FSDAT2") ;
		gcds_mst.namevalue(gcds_mst.rowposition,"FSNBR")=gcds_data01_2.namevalue(row,"FSNBR");
		
		gcds_mst.namevalue(gcds_mst.rowposition,"FSKND")=gcds_data01_2.namevalue(row,"FSKND");
		gcds_mst.namevalue(gcds_mst.rowposition,"FSWRTDAT")=gcds_data01_2.namevalue(row,"FSWRTDAT");

		gcds_mst.namevalue(gcds_mst.rowposition,"COCODE")=strcocode;
		gcds_mst.namevalue(gcds_mst.rowposition,"DEPTCD")=gcds_data01_2.namevalue(row,"DEPTCD");
		gcds_mst.namevalue(gcds_mst.rowposition,"EMPNO")=gcds_data01_2.namevalue(row,"EMPNO");
		gcds_mst.namevalue(gcds_mst.rowposition,"DIVCD")=gcds_data01_2.namevalue(row,"DIVCD");
		gcds_mst.namevalue(gcds_mst.rowposition,"FSAMT")=gcds_data01_2.namevalue(row,"FSAMT");

		gcds_mst.namevalue(gcds_mst.rowposition,"FSVAT")=gcds_data01_2.namevalue(row,"FSVAT");
		gcds_mst.namevalue(gcds_mst.rowposition,"DETOT")=gcds_data01_2.namevalue(row,"DETOT");
		gcds_mst.namevalue(gcds_mst.rowposition,"CRTOT")=gcds_data01_2.namevalue(row,"CRTOT");
		gcds_mst.namevalue(gcds_mst.rowposition,"REMARK")=gcds_data01_2.namevalue(row,"REMARK");
		gcds_mst.namevalue(gcds_mst.rowposition,"SGNDAT")="";  //결재일자

		gcds_mst.namevalue(gcds_mst.rowposition,"FSSTAT")=gcds_data01_2.namevalue(row,"FSSTAT");
		gcds_mst.namevalue(gcds_mst.rowposition,"ACTDAT")=gcds_data01_2.namevalue(row,"ACTDAT"); //회계일자
		gcds_mst.namevalue(gcds_mst.rowposition,"WRDT")=gcds_data01_2.namevalue(row,"WRDT");
		gcds_mst.namevalue(gcds_mst.rowposition,"WRID")=gcds_data01_2.namevalue(row,"WRID");
		gcds_mst.namevalue(gcds_mst.rowposition,"UPDT")=gcds_data01_2.namevalue(row,"UPDT");
		gcds_mst.namevalue(gcds_mst.rowposition,"UPID")=gcds_data01_2.namevalue(row,"UPID");
}

/******************************************************************************
	Description : 전표 Dtl 저장
	parameter   :
******************************************************************************/
function ln_Data_Dtl(strcocode){
  //prompt("gcds_dtl::",gcds_dtl.text);
  //alert("strcocode::"+strcocode);
	for(k=1;k<=gcds_dtl.countrow;k++){
	  //alert("gcds_dtl.count"+ k);
		if(gcds_dtl.namevalue(k,"ATCODE")!=""&&gcds_dtl.namevalue(k,"ATCODE")!=undefined){
			if(gcds_dtl.SysStatus(k)==1){       //Insert
				ln_Data_Dtl_Insert(k);		
				ln_Data_Bgt_Insert(k,strcocode);		
				//prompt("gcds_dtl_insert::",gcds_dtl_insert.text);
			}else if(gcds_dtl.SysStatus(k)==3){ //Update
				ln_Data_Dtl_Update(k);	
				ln_Data_Bgt_Update(k);	
				//prompt("gcds_dtl_update::",gcds_dtl_update.text);	
			}
		}
	}//for
}

/******************************************************************************
	Description : 전표 Dtl DATA INSERT 
	parameter   :
******************************************************************************/
function ln_Data_Dtl_Insert(k){

	ln_SetDataHeader("DTL_INSERT"); 
	gcds_dtl_insert.Addrow();
	var row = gcds_dtl_insert.rowposition;

	gcds_dtl_insert.namevalue(row,"FDCODE")=gcds_dtl.namevalue(k,"FDCODE");
	gcds_dtl_insert.namevalue(row,"FSDAT")=gcds_dtl.namevalue(k,"FSDAT");
	gcds_dtl_insert.namevalue(row,"FSNBR")=gcds_dtl.namevalue(k,"FSNBR");
	gcds_dtl_insert.namevalue(row,"FSSEQ")=gcds_dtl.namevalue(k,"FSSEQ");
	gcds_dtl_insert.namevalue(row,"ATCODE")=gcds_dtl.namevalue(k,"ATCODE");

	gcds_dtl_insert.namevalue(row,"ATDECR")="2";  //프로시저에서 생성함
	gcds_dtl_insert.namevalue(row,"CHAAMT")=gcds_dtl.namevalue(k,"CHAAMT");
	gcds_dtl_insert.namevalue(row,"DAEAMT")=gcds_dtl.namevalue(k,"DAEAMT");
	gcds_dtl_insert.namevalue(row,"DOCUMCD")=gcds_dtl.namevalue(k,"DOCUMCD");

	gcds_dtl_insert.namevalue(row,"FSWRKDIV")=gcds_dtl.namevalue(k,"FSWRKDIV");
	gcds_dtl_insert.namevalue(row,"REMARK")=gcds_dtl.namevalue(k,"REMARK");

	//alert("hid_atdeptyn:"+gcds_dtl.namevalue(k,"BANJAEYN")+"hid_atdecr:"+gcds_dtl.namevalue(k,"ATDECR")+"gcem_detot02"+gcds_dtl.namevalue(k,"CHAAMT")+"gcem_crtot02"+gcds_dtl.namevalue(k,"DAEAMT"));
	strBanjae = ln_Banjae_yn(gcds_dtl.namevalue(k,"BANJAEYN"),gcds_dtl.namevalue(k,"ATDECR"),gcds_dtl.namevalue(k,"CHAAMT"),gcds_dtl.namevalue(k,"DAEAMT"));
	
	gcds_dtl_insert.namevalue(row,"BANJAEYN")=strBanjae;
	gcds_dtl_insert.namevalue(row,"DOCUVAL")=gcds_dtl.namevalue(k,"DOCUVAL");
	gcds_dtl_insert.namevalue(row,"FSNUM")=gcds_dtl.namevalue(k,"FSNUM");
	gcds_dtl_insert.namevalue(row,"DIVCD")=gcds_dtl.namevalue(k,"DIVCD");
	gcds_dtl_insert.namevalue(row,"BGTDIV")=gcds_dtl.namevalue(k,"BGTDIV");

  	for(i=1;i<=9;i++){
		gcds_dtl_insert.namevalue(row,"FSREFSEQ0"+i)=gcds_dtl.namevalue(k,"FSREFSEQ0"+i);
		gcds_dtl_insert.namevalue(row,"FSREFCD0"+i)=gcds_dtl.namevalue(k,"FSREFCD0"+i);
		gcds_dtl_insert.namevalue(row,"FSREFVAL0"+i)=gcds_dtl.namevalue(k,"FSREFVAL0"+i);
	}
	
	gcds_dtl_insert.namevalue(row,"WRDT")=gs_date;
	gcds_dtl_insert.namevalue(row,"WRID")=gusrid;
	gcds_dtl_insert.namevalue(row,"UPDT")=gs_date;
	gcds_dtl_insert.namevalue(row,"UPID")=gusrid;

}

/******************************************************************************
	Description : 전표 Dtl DATA UPDATE 
	parameter   :
******************************************************************************/
function ln_Data_Dtl_Update(){
	
	ln_SetDataHeader("DTL_UPDATE"); 
	gcds_dtl_update.Addrow();
	var row = gcds_dtl_update.rowposition;
	gcds_dtl_update.namevalue(row,"FDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");
	gcds_dtl_update.namevalue(row,"FSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");
	gcds_dtl_update.namevalue(row,"FSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");
	gcds_dtl_update.namevalue(row,"FSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ");
	gcds_dtl_update.namevalue(row,"ATCODE")=gcds_dtl.namevalue(k,"ATCODE");

	gcds_dtl_update.namevalue(row,"ATDECR")="2"; //프로시저에서 생성함
	gcds_dtl_update.namevalue(row,"CHAAMT")=gcds_dtl.namevalue(k,"CHAAMT");
	gcds_dtl_update.namevalue(row,"DAEAMT")=gcds_dtl.namevalue(k,"DAEAMT");
	gcds_dtl_update.namevalue(row,"DOCUMCD")=gcds_dtl.namevalue(k,"DOCUMCD");
	gcds_dtl_update.namevalue(row,"FSWRKDIV")=gcds_dtl.namevalue(k,"FSWRKDIV");
	gcds_dtl_update.namevalue(row,"REMARK")=gcds_dtl.namevalue(k,"REMARK");
	gcds_dtl_update.namevalue(row,"DOCUVAL")=gcds_dtl.namevalue(k,"DOCUVAL");
	
	//alert("k::"+k+"::"+gcds_dtl.namevalue(k,"FSNUM"));
	gcds_dtl_update.namevalue(row,"FSNUM")=gcds_dtl.namevalue(k,"FSNUM");
	gcds_dtl_update.namevalue(row,"DIVCD")=gcds_dtl.namevalue(k,"DIVCD");
	gcds_dtl_update.namevalue(row,"BGTDIV")=gcds_dtl.namevalue(k,"BGTDIV");
	gcds_dtl_update.namevalue(row,"BANJAEYN")=gcds_dtl.namevalue(k,"BANJAEYN");

  	for(i=1;i<=9;i++){
		gcds_dtl_update.namevalue(row,"FSREFSEQ0"+i)=gcds_dtl.namevalue(k,"FSREFSEQ0"+i);
		gcds_dtl_update.namevalue(row,"FSREFCD0"+i)=gcds_dtl.namevalue(k,"FSREFCD0"+i);
		gcds_dtl_update.namevalue(row,"FSREFVAL0"+i)=gcds_dtl.namevalue(k,"FSREFVAL0"+i);
	}

	gcds_dtl_update.namevalue(row,"WRDT")=gs_date;
	gcds_dtl_update.namevalue(row,"WRID")=gs_userid;
	gcds_dtl_update.namevalue(row,"UPDT")=gs_date;
	gcds_dtl_update.namevalue(row,"UPID")=gs_userid;

}

/******************************************************************************
	Description : 전표 Dtl DATA Delete
	parameter   :
******************************************************************************/
function ln_Data_Dtl_Delete(k){
  //계정이 반제 계정일 경우 삭제 못함. 
	ln_SetDataHeader("DTL_DEL"); 
	gcds_dtl_del.Addrow();
	var row = gcds_dtl_del.rowposition;
	//alert("gcds_del01.rowposition::"+gcds_del01.rowposition);
	gcds_dtl_del.namevalue(row,"FDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");
	gcds_dtl_del.namevalue(row,"FSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");
	gcds_dtl_del.namevalue(row,"FSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");
	gcds_dtl_del.namevalue(row,"FSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ"); 
}


/******************************************************************************
	Description : 전표 예산 신규 등록
	parameter   :
******************************************************************************/
function ln_Data_Bgt_Insert(k,strcocode){
	
  //체크
	//예산이 이면서 예산부서가 존재하는 경우.
  //예산관리항목

	var no1 ="";
	var no2 ="";
  	if(gcds_dtl.namevalue(k,"FSWRKDIV")=="02"){ //예산적용
	  
		no1 = ln_Bgt_DataSet_Dept_find(k);
		no2 = ln_Bgt_DataSet_Type_find(k);

		if((no1!=""&&no1!=undefined)&&(no2!=""&&no2!=undefined)){

			ln_SetDataHeader("BGT_INSERT");
			gcds_bgt_insert.Addrow();
			var stractdt = gcem_actdat02.text;
			var row = gcds_bgt_insert.rowposition
			gcds_bgt_insert.namevalue(row,"BGTYY")=stractdt.substring(0,4);           //예산년도
			gcds_bgt_insert.namevalue(row,"BGTMM")=stractdt.substring(4,6);           //예산월  
			gcds_bgt_insert.namevalue(row,"BGTDIV")=gcds_dtl.namevalue(k,"BGTDIV");   //예산본부
			
			gcds_bgt_insert.namevalue(row,"BGTDPT")=gcds_dtl.namevalue(k,"FSREFVAL"+no1); //예산부서         
			gcds_bgt_insert.namevalue(row,"ATCODE")=gcds_dtl.namevalue(k,"ATCODE");       //계정과목         
			gcds_bgt_insert.namevalue(row,"FSREFCD")=gcds_dtl.namevalue(k,"FSREFCD"+no2); //세목 관리항목코드     

			//예산부서가 예산관리항목인 경우 세목은 00로 설정
			if(gcds_dtl.namevalue(k,"FSREFCD"+no2)=="0003"){
				gcds_bgt_insert.namevalue(row,"SATCODE")="00";	 //세목  
			}else{
				gcds_bgt_insert.namevalue(row,"SATCODE")=gcds_dtl.namevalue(k,"FSREFVAL"+no2); //세목  
			}

			gcds_bgt_insert.namevalue(row,"BGTMACT")=gcds_dtl.namevalue(k,"FSWRKDIV");   //예산타입  
			gcds_bgt_insert.namevalue(row,"CHAAMT")=gcds_dtl.namevalue(k,"CHAAMT");      //금액          

			//예산총계정원장 (미승인 실적분)
			gcds_bgt_insert.namevalue(row,"FDCODE")=gcds_dtl.namevalue(k,"FDCODE");  
			gcds_bgt_insert.namevalue(row,"ACTDAT")=gcem_actdat02.text;   
			gcds_bgt_insert.namevalue(row,"COCODE")=ln_Cocode(strcocode); 
			gcds_bgt_insert.namevalue(row,"FSDAT")=gcds_dtl.namevalue(k,"FSDAT");   
			gcds_bgt_insert.namevalue(row,"FSNBR")=gcds_dtl.namevalue(k,"FSNBR");   
			gcds_bgt_insert.namevalue(row,"FSSEQ")=gcds_dtl.namevalue(k,"FSSEQ"); 

			//예산관리항목원장 (미승인 실적분)
			//변경 후 예산관리항목원장 (미승인 실적분)
			for(j=1;j<=9;j++){
				gcds_bgt_insert.namevalue(row,"FSREFCD0"+j)=gcds_dtl.namevalue(k,"FSREFCD0"+j);
				gcds_bgt_insert.namevalue(row,"FSREFVAL0"+j)=gcds_dtl.namevalue(k,"FSREFVAL0"+j);
			}
		}
	}
}

/******************************************************************************
	Description : 전표 예산 수정 
	ref         : 1.예산부서가 변경될 경우
	              2.예산부서는 동일, 세목이 변경될 경우
								3.예산부서, 세목은 동일, 금액이 틀린 경우 
								위의 경우는 기존 금액을 해당 예산에서 빼어주고, 
								새로운 금액을 Insert/Update 함.
	parameter   : k - gcds_dtl의 rowposition
******************************************************************************/
function ln_Data_Bgt_Update(k){

  //예산부서가 존재하면 addrow();
	var no3 =ln_Bf_Bgt_DataSet_Dept_find(k);   //변경 전 예산부서 위치찾기
	var no4 =ln_Bf_Bgt_DataSet_Type_find(k);   //변경 세목위치 찾기

	var no1 =ln_Bgt_DataSet_Dept_find(k);      //변경 후 예산부서 위치찾기
	var no2 =ln_Bgt_DataSet_Type_find(k);      //변경 후 세목위치 찾기

	if(((no1!=""&&no1!=undefined)&&(no2!=""&&no2!=undefined))||((no3!=""&&no3!=undefined)&&(no4!=""&&no4!=undefined))){
		//MST는 생략 ==>DETAIL의 건으로 만듬
		if(gcds_bgt_update.countrow<=0){
			ln_SetDataHeader("BGT_UPDATE");
		}
		gcds_bgt_update.Addrow();
		var stractdt2 = gcem_actdat02.text;
		var row = gcds_bgt_update.rowposition
		
		//변경후
		if((no1!=""&&no1!=undefined)&&(no2!=""&&no2!=undefined)&&gcds_dtl.namevalue(k,"FSWRKDIV")=="02"){
			gcds_bgt_update.namevalue(row,"BGTYY")=stractdt2.substring(0,4);              //예산년도
			gcds_bgt_update.namevalue(row,"BGTMM")=stractdt2.substring(4,6);              //예산월  
			gcds_bgt_update.namevalue(row,"BGTDIV")=gcds_dtl.namevalue(k,"BGTDIV");       //예산본부         
			gcds_bgt_update.namevalue(row,"BGTDPT")=gcds_dtl.namevalue(k,"FSREFVAL"+no1); //예산부서         
			gcds_bgt_update.namevalue(row,"ATCODE")=gcds_dtl.namevalue(k,"ATCODE");       //계정과목         
			gcds_bgt_update.namevalue(row,"FSREFCD")=gcds_dtl.namevalue(k,"FSREFCD"+no2); //관리항목코드
				
			//예산부서가 예산관리항목인 경우 세목은 00로 설정
			if(gcds_dtl.namevalue(k,"FSREFCD"+no2)=="0003"){
				gcds_bgt_update.namevalue(row,"SATCODE")="00";	 //세목  
			}else{
				gcds_bgt_update.namevalue(row,"SATCODE")=gcds_dtl.namevalue(k,"FSREFVAL"+no2); //세목    
			}
			
			gcds_bgt_update.namevalue(row,"BGTMACT")=gcds_dtl.namevalue(k,"FSWRKDIV");   //예산타입  
			gcds_bgt_update.namevalue(row,"CHAAMT")=gcds_dtl.namevalue(k,"CHAAMT");      //금액          

			//예산총계정원장 (미승인 실적분)
			gcds_bgt_update.namevalue(row,"FDCODE")=gcds_dtl.namevalue(k,"FDCODE");  
			gcds_bgt_update.namevalue(row,"ACTDAT")=gcem_actdat02.text;   
			gcds_bgt_update.namevalue(row,"COCODE")=ln_Cocode('');
			gcds_bgt_update.namevalue(row,"FSDAT")=gcds_dtl.namevalue(k,"FSDAT");    
			gcds_bgt_update.namevalue(row,"FSNBR")=gcds_dtl.namevalue(k,"FSNBR");  
			gcds_bgt_update.namevalue(row,"FSSEQ")=gcds_dtl.namevalue(k,"FSSEQ");  

			//변경 후 예산관리항목원장 (미승인 실적분)
			for(j=1;j<=9;j++){
				gcds_bgt_update.namevalue(row,"FSREFCD0"+j)=gcds_dtl.namevalue(k,"FSREFCD0"+j);
				gcds_bgt_update.namevalue(row,"FSREFVAL0"+j)=gcds_dtl.namevalue(k,"FSREFVAL0"+j);
			}
		}else{
			gcds_bgt_update.namevalue(row,"BGTYY")="";    //예산년도
			gcds_bgt_update.namevalue(row,"BGTMM")="";    //예산월  
			gcds_bgt_update.namevalue(row,"BGTDIV")="";	  //예산본부         
			gcds_bgt_update.namevalue(row,"BGTDPT")="";	  //예산부서         
			gcds_bgt_update.namevalue(row,"ATCODE")="";	  //계정과목         
			gcds_bgt_update.namevalue(row,"FSREFCD")="";	//관리항목코드     
			gcds_bgt_update.namevalue(row,"SATCODE")="";	//세목   
			gcds_bgt_update.namevalue(row,"BGTMACT")="";	//예산타입 
			gcds_bgt_update.namevalue(row,"CHAAMT")=""; 	//금액   

			//변경 후 예산관리항목원장 (미승인 실적분)
     		for(j=1;j<=9;j++){
				gcds_bgt_update.namevalue(row,"FSREFCD0"+j)="";
				gcds_bgt_update.namevalue(row,"FSREFVAL0"+j)="";
			}
		}
		
		//변경전
		var stractdt3 = gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT");
		if((no3!=""&&no3!=undefined)&&(no4!=""&&no4!=undefined)&&gcds_dtl.OrgNameValue(k,"FSWRKDIV")=="02"){
			gcds_bgt_update.namevalue(row,"BBGTYY")=stractdt3.substring(0,4);                   //변경전예산년도
			gcds_bgt_update.namevalue(row,"BBGTMM")=stractdt3.substring(4,6);                   //변경전예산월  
			gcds_bgt_update.namevalue(row,"BBGTDIV")=gcds_dtl.OrgNameValue(k,"BGTDIV");         //변경전예산본부  
			gcds_bgt_update.namevalue(row,"BBGTDPT")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no3);   //변경전예산부서  
			gcds_bgt_update.namevalue(row,"BATCODE")=gcds_dtl.OrgNameValue(k,"ATCODE");         //변경전계정과목  
			gcds_bgt_update.namevalue(row,"BFSREFCD")=gcds_dtl.OrgNameValue(k,"FSREFCD"+no4);   //변경전관리항목코드  

			//예산부서가 예산관리항목인 경우 세목은 00로 설정
			if(gcds_dtl.OrgNameValue(k,"FSREFCD"+no4)=="0003"){
				gcds_bgt_update.namevalue(row,"BSATCODE")="00";	 //세목  
			}else{
				gcds_bgt_update.namevalue(row,"BSATCODE")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no4);    //변경전세목
			}
			
			gcds_bgt_update.namevalue(row,"BBGTMACT")=gcds_dtl.OrgNameValue(k,"FSWRKDIV");	       //변경전예산타입 
			gcds_bgt_update.namevalue(row,"BCHAAMT")=gcds_dtl.OrgNameValue(k,"CHAAMT");            //변경전금액  
			gcds_bgt_update.namevalue(row,"BACTDAT")=gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT"); //변경전 회계일자  

			//예산총계정원장 (미승인 실적분)
			gcds_bgt_update.namevalue(row,"BFDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");  
			gcds_bgt_update.namevalue(row,"BCOCODE")=ln_Cocode(gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"COCODE"));
			gcds_bgt_update.namevalue(row,"BFSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");      
			gcds_bgt_update.namevalue(row,"BFSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");    
			gcds_bgt_update.namevalue(row,"BFSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ");  
			//alert("parent.hid_cocode02.value; "+parent.hid_cocode02.value);

			//변경 전 예산관리항목원장 (미승인 실적분)
      		for(j=1;j<=9;j++){
				gcds_bgt_update.namevalue(row,"BFSREFCD0"+j)=gcds_dtl.OrgNameValue(k,"FSREFCD0"+j);
				gcds_bgt_update.namevalue(row,"BFSREFVAL0"+j)=gcds_dtl.OrgNameValue(k,"FSREFVAL0"+j);
			}
		}else{
			gcds_bgt_update.namevalue(row,"BBGTYY")="";       //변경전예산년도
			gcds_bgt_update.namevalue(row,"BBGTMM")="";       //변경전예산월  
			gcds_bgt_update.namevalue(row,"BBGTDIV")="";      //변경전예산본부  
			gcds_bgt_update.namevalue(row,"BBGTDPT")="";      //변경전예산부서  
			gcds_bgt_update.namevalue(row,"BATCODE")="";      //변경전계정과목  
			gcds_bgt_update.namevalue(row,"BFSREFCD")="";     //변경전관리항목코드  
			gcds_bgt_update.namevalue(row,"BSATCODE")="";     //변경전세목
			gcds_bgt_update.namevalue(row,"BBGTMACT")="";	    //변경전예산타입 
			gcds_bgt_update.namevalue(row,"BCHAAMT")="";      //변경전금액  
			gcds_bgt_update.namevalue(row,"BACTDAT")="";      //변경전 회계일자  

			//예산총계정원장 (미승인 실적분)
			gcds_bgt_update.namevalue(row,"BFDCODE")="";  
			gcds_bgt_update.namevalue(row,"BACTDAT")="";   
			gcds_bgt_update.namevalue(row,"BCOCODE")="";
			gcds_bgt_update.namevalue(row,"BFSDAT")="";   
			gcds_bgt_update.namevalue(row,"BFSNBR")="";   
			gcds_bgt_update.namevalue(row,"BFSSEQ")=""; 

			//변경 전 예산관리항목원장 (미승인 실적분)
			for(j=1;j<=9;j++){
				gcds_bgt_update.namevalue(row,"BFSREFCD0"+j)="";
				gcds_bgt_update.namevalue(row,"BFSREFVAL0"+j)="";
			}
		}
	}
}

/******************************************************************************
	Description : 전표 예산 삭제
	parameter   :
******************************************************************************/
function ln_Data_Bgt_Delete(k){

 //예산부서가 존재하면 addrow();
	var no3 =ln_Bf_Bgt_DataSet_Dept_find(k);   //변경 전 예산부서 위치찾기
	var no4 =ln_Bf_Bgt_DataSet_Type_find(k);   //변경 세목위치 찾기

	if((no3!=""&&no3!=undefined)&&(no4!=""&&no4!=undefined)&&gcds_dtl.OrgNameValue(k,"FSWRKDIV")=="02"){
		//MST는 생략 ==>DETAIL의 건으로 만듬
		if(gcds_bgt_del.countrow<=0){
			ln_SetDataHeader("BGT_DEL");
		}
		gcds_bgt_del.Addrow();
		var row = gcds_bgt_del.rowposition
		var stractdt3 = gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT");
		gcds_bgt_del.namevalue(row,"BGTYY")=stractdt3.substring(0,4);          //변경전예산년도
		gcds_bgt_del.namevalue(row,"BGTMM")=stractdt3.substring(4,6);          //변경전예산월  
		gcds_bgt_del.namevalue(row,"BGTDIV")=gcds_dtl.OrgNameValue(k,"BGTDIV");          //변경전예산본부  
		gcds_bgt_del.namevalue(row,"BGTDPT")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no3);    //변경전예산부서  
		gcds_bgt_del.namevalue(row,"ATCODE")=gcds_dtl.OrgNameValue(k,"ATCODE");          //변경전계정과목  
		gcds_bgt_del.namevalue(row,"FSREFCD")=gcds_dtl.OrgNameValue(k,"FSREFCD"+no4);    //변경전관리항목코드 
		 
		//예산부서가 예산관리항목인 경우 세목은 00로 설정
		if(gcds_dtl.OrgNameValue(k,"FSREFCD"+no4)=="0003"){
			gcds_bgt_del.namevalue(row,"SATCODE")="00";	 //세목  
		}else{
			gcds_bgt_del.namevalue(row,"SATCODE")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no4);     //변경전세목
		}
		
		gcds_bgt_del.namevalue(row,"BGTMACT")=gcds_dtl.OrgNameValue(k,"FSWRKDIV");	        //변경전예산타입 
		gcds_bgt_del.namevalue(row,"CHAAMT")=gcds_dtl.OrgNameValue(k,"CHAAMT");             //변경전금액  
		gcds_bgt_del.namevalue(row,"ACTDAT")=gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT");         //변경전 회계일자  

		//예산총계정원장 (미승인 실적분)
		gcds_bgt_del.namevalue(row,"FDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");   
		gcds_bgt_del.namevalue(row,"COCODE")=ln_Cocode(gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"COCODE"));
		gcds_bgt_del.namevalue(row,"FSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");      
		gcds_bgt_del.namevalue(row,"FSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");    
		gcds_bgt_del.namevalue(row,"FSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ");  

		//변경 전 예산관리항목원장 (미승인 실적분)
		//예산관리항목원장
		
		for(j=1;j<=9;j++){
			gcds_bgt_del.namevalue(row,"FSREFCD0"+j)=gcds_dtl.OrgNameValue(k,"FSREFCD0"+j);
			gcds_bgt_del.namevalue(row,"FSREFVAL0"+j)=gcds_dtl.OrgNameValue(k,"FSREFVAL0"+j);
		}
	}
}


//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 대체전표관련 함수 (Start :::::::::::::::::::::::  >>>>>>>>>>>>>>>>>>>>>>>>>>> )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/******************************************************************************
	Description : 출력 - 대체전표
	parameter   : 지점코드, 지점명, 부서명, 접수번호, 회계일자, 작성일자
	수정        : 지점코드, 접수번호
******************************************************************************/
function ln_Print(){
  	var p1 = gclx_fdcode02.bindcolval;
	var p2 = gcem_fs02.text+gcem_fsdat02.text;
	var p3 = gcem_fsnbr02.text;
	gcds_print.ClearAll();
	gcds_prttemp1.ClearAll();
	gcds_prttemp2.ClearAll();

	ln_PrtSetDataHeader();
	///////////////ln_PrintQuery(p1,p2,p3);	//대체전표 REPORT조회 ==>20061012 막음
	ln_PrintSubQuery()
}

/******************************************************************************
	Description : 조회 - 출력(head)
  Parameter   : p1-fdcode, p2-fsdat, p3-fsnbr 
	              사용안함.
******************************************************************************/
/*
function ln_PrintQuery(p1,p2,p3){
	gcds_prttemp1.DataID = "/services/servlet/Account.a020001_s15?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3;
	//prompt("",gcds_prttemp1.DataID);
	gcds_prttemp1.Reset();
}
*/

/******************************************************************************
	Description : 조회 - 출력(detail)
  Parameter   : 
******************************************************************************/
function ln_PrintSubQuery(){
	var p1 = gclx_fdcode02.bindcolval;
	var p2 = gcem_fs02.text+gcem_fsdat02.text;
	var p3 = gcem_fsnbr02.text;
	gcds_prttemp2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s16?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3;
	
	//prompt("",gcds_prttemp2.DataID);
	gcds_prttemp2.Reset(); 
}

/******************************************************************************
	Description : 조회 - 출력(detail)
  Parameter   : p1-fdcode, p2-fsdat, p3-fsnbr 
******************************************************************************/
function ln_PrintSubQuery2(){
  /*==========================================================================*/
	var fdcd01 = gclx_fdcode02.bindcolval;														    //지점코드
	var fdcd02 = gclx_fdcode02.text;																	    //지점명
	var dept03 = fn_trim(txt_deptnm02.value);													    //부서
	var fsnb04 = gcem_fs02.text+gcem_fsdat02.text+"-"+gcem_fsnbr02.text;	//접수번호
	var arrfsnb = new Array();
	var strgubun=""; //A - 현금 계정 존재
  	arrfsnb = fsnb04.split("-");

	if(gcds_data01_2.namevalue(1,"ACTDAT")==undefined){
		var cudt05 = gcds_data01_1.namevalue(1,"ACTDAT");					//회계일자
	}else{
		var cudt05 = gcds_data01_2.namevalue(1,"ACTDAT");					//회계일자
	}

	if (gcds_data01_2.namevalue(1,"ACTDAT")==undefined){
		var cudt06 = gcds_data01_1.namevalue(1,"FSWRTDAT");				//작성일자
	}else{
		var cudt06 = gcds_data01_2.namevalue(1,"FSWRTDAT");				//작성일자
	}
	  /*==========================================================================*/
  //alert("출력0");
	var cnt = gcds_prttemp2.countrow;
	for(i=1;i<=gcds_prttemp2.countrow;i++){

		gcds_print.ImportData(gcds_prttemp2.ExportData(i,1,false));

    	if(gcds_prttemp2.namevalue(i,"ATCODE")=="1110110"||gcds_prttemp2.namevalue(i,"ATCODE")=="1110120"||gcds_prttemp2.namevalue(i,"ATCODE")=="1110130"){
			strgubun="A";
		}
		
		gcds_print.namevalue(1,"DATA01") = "회계단위 : "+fdcd01+" "+fdcd02+"지점";	//지점
		//2011.09.08 수정
		//gcds_print.namevalue(1,"DATA02") = "집행부서 : "+dept03;										//부서
		gcds_print.namevalue(1,"DATA02") = "담당부서 : "+dept03;										//부서									//부서
		
		/*
		if (gcds_prttemp1.namevalue(1,"COST") != null && gcds_prttemp1.namevalue(1,"COST") != "" ) {
			sv_cost = gcds_prttemp1.namevalue(1,"COST");
		}else{
			sv_cost = gcds_prttemp1.namevalue(1,"DEPTNM3");
		}
		*/
		sv_cost = gcds_prttemp2.namevalue(1,"DEPTNM");
		var s_ssnbr = gcds_print.namevalue(1,"SSNBR");
		//2011.09.08 수정
		//gcds_print.namevalue(1,"DATA03") = "부 서 명 : "+sv_cost;	  //부서
		gcds_print.namevalue(1,"DATA03") = "담 당 자 : "+fn_trim(txt_empnmk02.value);	  //작성자성명
		
		gcds_print.namevalue(1,"DATA04") = s_ssnbr;		                  //전표번호
		gcds_print.namevalue(1,"DATA05") = "입력일자 : "+fsnb04.substring(1,16);		//입력일자
		
		if(gcds_print.namevalue(1,"FSSTAT") == 'Y'){	//전표완료
			gcds_print.namevalue(1,"CURDT")	 = cudt05;	//회계일자
		}else{
			gcds_print.namevalue(1,"CURDT")	 = "        ";	//회계일자
		}
		gcds_print.namevalue(1,"CURDT2")="";		//작성일자
	}

	if(strgubun=="A"){
		gcds_print.namevalue(1,"PTITLE")="입 (출) 금  전  표";
	}else{
    	gcds_print.namevalue(1,"PTITLE")="대   체   전   표";
	}

  //alert("출력1");
	for(j=1;j<=gcds_print.countrow;j++){
		var s_leng1 = gcds_print.namevalue(j,"FOCHAAMT").length;
		var s_leng2 = gcds_print.namevalue(j,"FODAEAMT").length;

    
		if(s_leng1>0){
		  gcds_print.namevalue(j,"FOCHAAMT")= gcds_print.namevalue(j,"FOCHAAMT").substring(0,1)
																				+ gf_setnum2(gcds_print.namevalue(j,"FOCHAAMT").substring(1,s_leng1));
		}else if(s_leng2>0){
			gcds_print.namevalue(j,"FODAEAMT")= gcds_print.namevalue(j,"FODAEAMT").substring(0,1)
																				+ gf_setnum2(gcds_print.namevalue(j,"FODAEAMT").substring(1,s_leng2));
		}
	}

 
	if(fdcd01!="03"){
		gcds_print.namevalue(1,"CHASUM") = "￦"+gf_setnum2(gcds_prttemp2.Sum(10,0,cnt));
		gcds_print.namevalue(1,"DAESUM") = "￦"+gf_setnum2(gcds_prttemp2.Sum(11,0,cnt));
	}else{
		gcds_print.namevalue(1,"CHASUM") = "＄"+gf_setnum2(gcds_prttemp2.Sum(10,0,cnt));
		gcds_print.namevalue(1,"DAESUM") = "＄"+gf_setnum2(gcds_prttemp2.Sum(11,0,cnt));
	}	

  	if(fdcd01=="03"){ //금강산
    	gcds_print.namevalue(1,"C1")="소  장";
		gcds_print.namevalue(1,"C2")="총소장";
		gcds_print.namevalue(1,"C3")="";
		gcds_print.namevalue(1,"C4")="담당팀";
		gcds_print.namevalue(1,"C5")="재정팀";
	}else if(fdcd01=="04"){ //개성
    	gcds_print.namevalue(1,"C1")="소(부)장";
		gcds_print.namevalue(1,"C2")="총소장";
		gcds_print.namevalue(1,"C3")="";
		gcds_print.namevalue(1,"C4")="담당부";
		gcds_print.namevalue(1,"C5")="지원부";
	}else{ //서울, 본사 (02, 01)
    	//gcds_print.namevalue(1,"C1")="부서장";
    	gcds_print.namevalue(1,"C1")="팀  장";
		//gcds_print.namevalue(1,"C2")="중  역";
		gcds_print.namevalue(1,"C2")="임  원";
		gcds_print.namevalue(1,"C3")="본부장";
		//gcds_print.namevalue(1,"C4")="담당부";
		gcds_print.namevalue(1,"C4")="담당팀";
		//gcds_print.namevalue(1,"C5")="경리부";
		//gcds_print.namevalue(1,"C5")="재경지원부";
		gcds_print.namevalue(1,"C5")="경영관리팀";
	}
  	
  	//결재상태가 결재 대기/반송일 경우   2014.10.07 jys   	
  	if(gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSSTAT")=="N"){
  		gcds_print.namevalue(1,"C6")="전산 결재 대기중 입니다. 전산 결재 요청 바랍니다."; 
  	}else if (gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSSTAT")=="B"){
  		gcds_print.namevalue(1,"C6")="전산 결재 반송중 입니다. 전산 결재 요청 바랍니다."; 
  	}else{
  		
  		//2020.05.13
  		gcds_print.namevalue(1,"C6")="";
  		//2018.04.11. 이상원 울면서 왔음. 고상무님 요청건
  		if(gs_userid=="2020013"||gs_userid=="2040046"||gs_userid=="2080031"||gs_userid=="2110014"||gs_userid=="2130002"||gs_userid=="2190020"||gs_userid=="2080012"){
  			gcds_print.namevalue(1,"C7")="전결";
  		}
  	}
  	
	gcrp_print.preview();

}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 대체전표관련 함수 (End :::::::::::::::::::::::  <<<<<<<<<<<<<<<<<<<<<<<<<< )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


/******************************************************************************
	Description : 엑셀
	parameter   : 
******************************************************************************/
function ln_Excel(){
	
}

/******************************************************************************
	Description : FILE 
******************************************************************************/
function ln_File(){

}

/******************************************************************************
	Description : 코드 작업
******************************************************************************/
function ln_Before() {

  	//지점구분
	gcds_comfield02.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield02.Reset();


    //증빙코드
	gcds_documcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0052"
	//prompt("",gcds_documcd.DataID);
	gcds_documcd.Reset();
	
	
	//외상매입금 일반업체 체크 2015.03.05
	gcds_chk1.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s5?v_str1=2230&v_str2="+gs_userid;
	gcds_chk1.Reset();
	
	if(gcds_chk1.countrow>0){
		sp1.style.display = ""; //숨김
	}else{
		sp1.style.display = "none"; //숨김
	}

}


/******************************************************************************
	Description : 저장시 체크박스값 변환
	prameter : 
******************************************************************************/
function ln_Chkbox(){

}

/******************************************************************************
	Description : 계정코드 찾기
	parameter   : p1 - 구분,  01-전표일괄 복사(비릿지 ==> 전표)
	                          02-계정
														03-관리항목 ==>사용하지 않은것 같음
														09-전표상태
	              p2 - Data, row - grid의 rowposition
******************************************************************************/
function ln_Popup(p1,p2,row){
  
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if ((p1=="01")) {
		strURL = "./commiface_popup.jsp";
		arrParam[0]="";
		strPos = "dialogWidth:878px;dialogHeight:490px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if(result != null){
			arrResult = result.split(";");
			gcds_data02.namevalue(row,"ATCODE")=arrResult[0];
			gcds_data02.namevalue(row,"ATKORNAM")=arrResult[1];
			gcds_data02.namevalue(row,"ATDECR")=arrResult[2];

		}else{
			gcds_data02.namevalue(row,"ATCODE")="";
			gcds_data02.namevalue(row,"ATKORNAM")="";
			gcds_data02.namevalue(row,"ATDECR")="";

			gcds_data02.namevalue(row,"REMARK")=""
			gcds_data02.namevalue(row,"CHAAMT")="0";
			gcds_data02.namevalue(row,"DAEAMT")="0";
		}

	}else if (p1=="02"){
		

		strURL = "./actcode_popup.jsp";
		arrParam[0]="ATUSEYN" 
		arrParam[1]=p2;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if (result != null) {
			arrResult = result.split(";");
			gcds_data02.namevalue(row,"ATCODE")=arrResult[0];
			gcds_data02.namevalue(row,"ATKORNAM")=arrResult[1];
			gcds_data02.namevalue(row,"ATDECR")=arrResult[2];
		} else {
			gcds_data02.namevalue(row,"ATCODE")="";
			gcds_data02.namevalue(row,"ATKORNAM")="";
			gcds_data02.namevalue(row,"ATDECR")="";

			gcds_data02.namevalue(row,"REMARK")=""
			gcds_data02.namevalue(row,"CHAAMT")="0";
			gcds_data02.namevalue(row,"DAEAMT")="0";
		}
		
	
	}else if(p1=="03"){
	  /*****
		strURL = "./Slipref_popup.html";
		arrParam[0]=p2;
		strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);

		if (result != null) {
			arrResult = result.split(";");
			gcds_data04.namevalue(row,"FSREFVAL")=arrResult[0];
			gcds_data04.namevalue(row,"FSREFVALNM")=arrResult[1];
		} else {
			gcds_data04.namevalue(row,"FSREFVAL")="";
			gcds_data04.namevalue(row,"FSREFVALNM")="";
		}
		****/
	}else if (p1=="09"){
    	if(gcem_fsnbr02.text=="000000") return;

		strURL = "./slipno_loca_popup.jsp";    
		if(gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE")!=undefined){
			arrParam[0]=gcds_data01.namevalue(gcds_data01.rowposition,"FDCODE"); 
			arrParam[1]=gcds_data01.namevalue(gcds_data01.rowposition,"FSDAT"); 
			arrParam[2]=gcds_data01.namevalue(gcds_data01.rowposition,"FSNBR"); 	
		}else{
			arrParam[0]=gclx_fdcode02.bindcolval; 
			arrParam[1]=gcem_fs02.text+gcem_fsdat02.text; 
			arrParam[2]=gcem_fsnbr02.text; 	
		}

		strPos = "dialogWidth:800px;dialogHeight:425px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
   	/*
		if (result != null) {
		 
		  arrResult = result.split(";");
      gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FDCODE")=arrResult[0];		
      gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FSDAT")=arrResult[1];
		  gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FSNBR")=arrResult[2];

		} else {
      gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FDCODE")="";	
      gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FSDAT")="";
		  gcds_data01_1.namevalue(gcds_data01_1.rowposition,"FSNBR")="";	   
		}
    */

	}
}

/******************************************************************************
	Description : 결재 팝업
	parameter   : 
******************************************************************************/
function ln_Popup_Confirm(){
  
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if (gclx_fsstat02.bindcolval!="B"&&gclx_fsstat02.bindcolval!="N"){ //Y-결재완료,C-결재취소, N-결재대기, R-결재요청, B-반송
		alert("전표상태가 결재요청 할 수 없습니다.");
		return;
	}

	if(!ln_Chk_Confirm()){ //결재요청 체크
		alert("전표상태가 결재요청 할 수 없습니다.");
		return;
	}

	strURL = "./confirm_popup_new.jsp";
	strPos = "dialogWidth:330px;dialogHeight:180px;status:no;scroll:no;resizable:no";

	result = showModalDialog(strURL,window,strPos);
	//return result;
	if (result != null) {
		arrResult = result.split(";");
		gcds_confirm.ClearData();
		if (arrResult[1]= "Y" ){ //결재저장시
			ln_Confirm_Save(arrResult[0],arrResult[3],arrResult[4]); //결재자, 회계(예산)구분 01 회계, 02예산, 03 자금 ,  Y -회계일자 변경
		}
	}
}

/******************************************************************************
	Description : 결재시 저장
	parameter   :  p - 결재자 사번
	               p1 - 회계/ 예산 / 자금  구분 01/02/03   
								 p2 - 회계일자 변경시 전표등록에서 함(Y)
******************************************************************************/
function ln_Confirm_Save(p,p1,p2){
    //alert("p:"+p+":p1:"+p1+":p2::"+p2)
		var row1 = gcds_data01.rowposition;
		var row2 = gcds_data01_2.rowposition;
		var strfdcode="";
		var strfsdat="";
		var strfsnbr="";
		var strempno="";
    	var strtogb="";

		if (p1=="01"){        //회계
			strtogb="03";       //예산일경우는 02 로 변경해야함.
    	}else if(p1=="02"){   //예산
      		strtogb="02";
		}else if(p1=="03"){   //자금
      		strtogb="06";
		}

		ln_SetDataHeader("CONFIRM");

		//alert("strtogb"+strtogb);

    	if((gcds_data01_2.namevalue(row2,"FDCODE"))==""||(gcds_data01_2.namevalue(row2,"FDCODE"))==undefined){
			strfdcode = gcds_data01.namevalue(row1,"FDCODE");
		}else{
			strfdcode = gcds_data01_2.namevalue(row2,"FDCODE");
		}

		if(gcds_data01_2.namevalue(row2,"FSDAT")==""||gcds_data01_2.namevalue(row2,"FSDAT")==undefined){
			strfsdat = gcds_dtl.namevalue(1,"FSDAT");
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
			strempno = gcds_data01_2.namevalue(row2,"EMPNO");
		}

    	gcds_confirm.addrow();
    	gcds_confirm.namevalue(gcds_confirm.rowposition,"FDCODE")=strfdcode; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSDAT")=strfsdat;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FSNBR")=strfsnbr;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"SEQ")=""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNID")=p;      //결재자
		gcds_confirm.namevalue(gcds_confirm.rowposition,"EMPNO")= strempno;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNDAT") ="";  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"ACCSGNEND") ="R"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"FROMGB") ="01"; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"TOGB") =strtogb; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"BIGO") =""; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"BGTGB")=p2; 
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRDT") =gs_date;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"WRID") =gs_userid;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPDT") =gs_date;  
		gcds_confirm.namevalue(gcds_confirm.rowposition,"UPID") =gs_userid;  

		if (confirm("결재요청 하시겠습니까?")){	
			gctr_data06.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_t6?";
			//prompt("gcds_confirm",gcds_confirm.text);
			gctr_data06.post();
    	}
}

/******************************************************************************
	Description : Dataset Head 설정 - 전표 Detail
  parameter   : p - dataset 순서
	              02 : 전표 Detail 테이블
                 05 : 관리항목 테이블
                  01_1 : 전표 Master 테이블
								02_2 : 전표 결재 테이블(전표등록시 사용)
								key : 회계전표번호
******************************************************************************/
function ln_SetDataHeader(p){
   
	if(p=="02"){
		if (gcds_data02.countrow<1){
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:DECIAML,CHAAMT:DECIAML,"
								 + "ATCODE:STRING,ATKORNAM:STRING,DAEAMT:DECIAML,ATDECR:STRING,REMARK:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,SSNBR:STRING ";
			gcds_data02.SetDataHeader(s_temp);
		}

	}else if(p=="05"){
		if (gcds_data04.countrow<1){
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:DECIAML,FSREFSEQ:STRING,"
								 + "FSREFCD:STRING,FSREFVAL:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,SSDAT:STRING,SSNBR:STRING ";
			gcds_data04.SetDataHeader(s_temp);
		}
	}else if(p=="01_1"){
		if (gcds_data01_1.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSDAT1:STRING,FSDAT2:STRING,FSNBR:STRING,FSKND:STRING,"
			           + "FSWRTDAT:STRING,COCODE:STRING,DEPTCD:STRING,DEPTNM:STRING,EMPNO:STRING,EMPNMK:STRING,DIVCD:STRING,"
								 + "FSAMT:DECIMAL,FSVAT:DECIMAL,DETOT:DECIMAL,CRTOT:DECIMAL,REMARK:STRING,"
								 + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,DIVNM:STRING,SSDAT:STRING,SSNBR:STRING,SSDAT1:STRING,SSDAT2:STRING ";

			gcds_data01_1.SetDataHeader(s_temp);
		}
  }else if(p=="01_2"){
		if (gcds_data01_2.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSDAT1:STRING,FSDAT2:STRING,FSNBR:STRING,FSKND:STRING,"
			           + "FSWRTDAT:STRING,COCODE:STRING,DEPTCD:STRING,DEPTNM:STRING,EMPNO:STRING,EMPNMK:STRING,DIVCD:STRING,"
								 + "FSAMT:DECIMAL,FSVAT:DECIMAL,DETOT:DECIMAL,CRTOT:DECIMAL,REMARK:STRING,"
								 + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,DIVNM:STRING,SSDAT:STRING,SSNBR:STRING,SSDAT1:STRING,SSDAT2:STRING ";

			gcds_data01_2.SetDataHeader(s_temp);
		}
  }else if(p=="CONFIRM"){
		if (gcds_confirm.countrow<1){                   
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,SEQ:STRING,ACCSGNID:STRING,EMPNO:STRING,"
								 + "ACCSGNDAT:STRING,ACCSGNEND:STRING,FROMGB:STRING,TOGB:STRING,BIGO:STRING,BGTGB:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
			gcds_confirm.SetDataHeader(s_temp);
		}

  }else if(p=="MST"){
	  if (gcds_mst.countrow<1){  
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSKND:STRING,FSWRTDAT:STRING,"
										 + "COCODE:STRING,DEPTCD:STRING,EMPNO:STRING,DIVCD:STRING,FSAMT:DECIAML,"
										 + "FSVAT:DECIAML,DETOT:DECIAML,CRTOT:DECIAML,REMARK:STRING,"
										 + "SGNDAT:STRING,FSSTAT:STRING,ACTDAT:STRING,"
										 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING";
			gcds_mst.SetDataHeader(s_temp);
		}
  }else if(p=="DTL"){
		if (gcds_dtl.countrow<1){                   
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
								 + "BGTDIV:STRING,FUNDDIV:STRING,BANJAEREF:STRING,LASTREF:STRING,BANJAEMOD:STRING,ATCURTYPE:STRING,CREDGB:STRING";
			gcds_dtl.SetDataHeader(s_temp);
		}
	}else if(p=="DTL_INSERT"){
	  if (gcds_dtl_insert.countrow<1){ 
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
										 + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
										 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
										 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09,"
										 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
										 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
										 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
										 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
										 + "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
										 + "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
										 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
										 + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"
										 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
										 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
										 + "BANJAEYN:STRING,DOCUVAL:STRING,FSNUM:STRING,DIVCD:STRING,BGTDIV:STRING ";
			gcds_dtl_insert.SetDataHeader(s_temp);
		}
	}else if(p=="DTL_UPDATE"){
		if (gcds_dtl_update.countrow<1){ 
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
										 + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,CHAAMT:DECIMAL,DAEAMT:DECIMAL,"
										 + "FSREFSEQ01:STRING,FSREFSEQ02:STRING,FSREFSEQ03:STRING,FSREFSEQ04:STRING,FSREFSEQ05:STRING,"
										 + "FSREFSEQ06:STRING,FSREFSEQ07:STRING,FSREFSEQ08:STRING,FSREFSEQ09,"
										 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
										 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
										 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
										 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
										 + "FSREFNM01:STRING,FSREFNM02:STRING,FSREFNM03:STRING,FSREFNM04:STRING,FSREFNM05:STRING,"
										 + "FSREFNM06:STRING,FSREFNM07:STRING,FSREFNM08:STRING,FSREFNM09:STRING,"
										 + "FSRVALNM01:STRING,FSRVALNM02:STRING,FSRVALNM03:STRING,FSRVALNM04:STRING,FSRVALNM05:STRING,"
										 + "FSRVALNM06:STRING,FSRVALNM07:STRING,FSRVALNM08:STRING,FSRVALNM09:STRING,"
										 + "CNT:DECIMAL,DOCUMCD:STRING,DOCUMNM:STRING,FSWRKDIV:STRING,"
										 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,"
										 + "BANJAEYN:STRING,DOCUVAL:STRING,FSNUM:STRING,DIVCD:STRING,BGTDIV:STRING ";								
			gcds_dtl_update.SetDataHeader(s_temp);
		}
  }else if(p=="DTL_DEL"){
		if (gcds_dtl_del.countrow<1){ 
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING";               
			gcds_dtl_del.SetDataHeader(s_temp);
		}
  }else if(p=="MST_DEL"){
		if (gcds_del02.countrow<1){ 
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,FSKND:STRING";
			gcds_del02.SetDataHeader(s_temp);
		}
  }else if (p=="BGT_INSERT"){
	  if (gcds_bgt_insert.countrow<1){ 
			var s_temp = "BGTYY:STRING,BGTMM:STRING,BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,"
								 + "FSREFCD:STRING,SATCODE:STRING,BGTMACT:STRING,CHAAMT:DECIMAL, "
								 + "FDCODE:STRING,ACTDAT:STRING,COCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING, " 
								 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING";
			gcds_bgt_insert.SetDataHeader(s_temp);
		}
	}else if (p=="BGT_UPDATE"){
		if (gcds_bgt_update.countrow<1){ 
			var s_temp = "BGTYY:STRING,BGTMM:STRING,BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,"
								 + "FSREFCD:STRING,SATCODE:STRING,BGTMACT:STRING,CHAAMT:DECIMAL,"
								 + "BBGTYY:STRING,BBGTMM:STRING,BBGTDIV:STRING,BBGTDPT:STRING,BATCODE:STRING,"
								 + "BFSREFCD:STRING,BSATCODE:STRING,BBGTMACT:STRING,BCHAAMT:DECIMAL,"
								 + "BACTDAT:STRING,"
								 + "FDCODE:STRING,ACTDAT:STRING,COCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING, " 
								 + "BFDCODE:STRING,BCOCODE:STRING,BFSDAT:STRING,BFSNBR:STRING,BFSSEQ:STRING, " 
								 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING,"
								 + "BFSREFCD01:STRING,BFSREFCD02:STRING,BFSREFCD03:STRING,BFSREFCD04:STRING,BFSREFCD05:STRING,"
								 + "BFSREFCD06:STRING,BFSREFCD07:STRING,BFSREFCD08:STRING,BFSREFCD09:STRING,"
								 + "BFSREFVAL01:STRING,BFSREFVAL02:STRING,BFSREFVAL03:STRING,BFSREFVAL04:STRING,BFSREFVAL05:STRING,"
								 + "BFSREFVAL06:STRING,BFSREFVAL07:STRING,BFSREFVAL08:STRING,BFSREFVAL09:STRING";
			gcds_bgt_update.SetDataHeader(s_temp);
		}
	}else if (p=="BGT_DEL"){
		if (gcds_bgt_del.countrow<1){ 
			var s_temp = "BGTYY:STRING,BGTMM:STRING,BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,"
								 + "FSREFCD:STRING,SATCODE:STRING,BGTMACT:STRING,CHAAMT:DECIMAL,"
								 + "FDCODE:STRING,ACTDAT:STRING,COCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING," 
								 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING"; 
			gcds_bgt_del.SetDataHeader(s_temp);
		}
	}else if (p=="BGTDTL_DEL_ALL"){
		if (gcds_bgt_del_all.countrow<1){ 
			var s_temp = "BGTYY:STRING,BGTMM:STRING,BGTDIV:STRING,BGTDPT:STRING,ATCODE:STRING,"
								 + "FSREFCD:STRING,SATCODE:STRING,BGTMACT:STRING,CHAAMT:DECIMAL,"
								 + "FDCODE:STRING,ACTDAT:STRING,COCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING," 
								 + "FSREFCD01:STRING,FSREFCD02:STRING,FSREFCD03:STRING,FSREFCD04:STRING,FSREFCD05:STRING,"
								 + "FSREFCD06:STRING,FSREFCD07:STRING,FSREFCD08:STRING,FSREFCD09:STRING,"
								 + "FSREFVAL01:STRING,FSREFVAL02:STRING,FSREFVAL03:STRING,FSREFVAL04:STRING,FSREFVAL05:STRING,"
								 + "FSREFVAL06:STRING,FSREFVAL07:STRING,FSREFVAL08:STRING,FSREFVAL09:STRING"; 
			gcds_bgt_del_all.SetDataHeader(s_temp);
		}
  }else if(p=="TAX"){
		if (gcds_tax.countrow<1){       
			var s_temp = "TAXNBR:STRING,FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,UPDT:STRING,UPID:STRING";
			gcds_tax.SetDataHeader(s_temp);
		}
	}else if(p=="TAX_DEL_ROW"){
		if (gcds_tax_del_row.countrow<1){       
			var s_temp = "TAXNBR:STRING,FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,UPDT:STRING,UPID:STRING";
			gcds_tax_del_row.SetDataHeader(s_temp);
		}
	}else if(p=="FSSEQ"){
		if (gcds_fsseq.countrow<1){       
			var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING";
			gcds_fsseq.SetDataHeader(s_temp);
		}
	}else if(p=="AUTOMST"){
	   
        if (gcds_automst.countrow<1){
			var s_temp = "FDCODE:STRING,WKNO:STRING,TAMT:DECIAML,REMARK:STRING";
			gcds_automst.SetDataHeader(s_temp);
			 //alert("P::::::"+p);
		}
	}else if(p=="AUTODTL"){
	
	}
}


/******************************************************************************
	Description : Report Head 설정
******************************************************************************/
function ln_PrtSetDataHeader(){
	if(gcds_print.countrow<1){
		var s_temp = "FDCODE:STRING,FSDAT:STRING,FSNBR:STRING,FSSEQ:STRING,ATCODE:STRING,"
							 + "ATKORNAM:STRING,ATDECR:STRING,REMARK:STRING,CURAMT:STRING,CHAAMT:DECIMAL,"
							 + "DAEAMT:DECIMAL,FOCHAAMT:STRING,FODAEAMT:STRING,FSRVALNM011:STRING,FSRVALNM012:STRING,"
							 + "FSRVALNM013:STRING,FSRVALNM014:STRING,FSRVALNM015:STRING,DETITLE:STRING,CURRENCY:STRING,"
							 + "COST:STRING,FSSTAT:STRING,SSNBR:STRING,DOCUVAL:STRING,CURDT:STRING,CURDT2:STRING,PTITLE:STRING,"
							 + "DATA01:STRING,DATA02:STRING,DATA03:STRING,DATA04:STRING,DATA05:STRING,"
							 + "CHASUM:STRING,DAESUM:STRING,C1:STRING,C2:STRING,C3:STRING,C4:STRING,C5:STRING,C6:STRING,C7:STRING";
		gcds_print.SetDataHeader(s_temp);
	}
}

/******************************************************************************
	Description : readonly
	prameter    : p - f : readonly
******************************************************************************/
function ln_Read(p){
 
	if (p=="f"){
		gcem_fsdat02.ReadOnly = "true";
		gcem_fs02.ReadOnly = "true";
		gcem_fsdat02.ReadOnly = "true";
		gcem_fsnbr02.ReadOnly = "true";
		//gclx_fsknd02.Enable = false;
		//gclx_fswrkdiv02.Enable = false;
		txt_empnmk02.ReadOnly = "true";
		
		gcem_fswrtdat02.ReadOnly = "true";
		gcem_actdat02.ReadOnly = "true";
		txt_deptcd02.ReadOnly = "true";
		txt_deptnm02.ReadOnly = "true";
		//gcem_ts02.ReadOnly = "true";
		//gcem_tsdat02.ReadOnly = "true";
		//gcem_tsnbr02.ReadOnly = "true";
		gclx_fsstat02.Enable = false;
		gcem_fsamt02.ReadOnly = "true";
		//gcem_fsvat02.ReadOnly = "true";
		gcem_remark02.ReadOnly = "true";//적요
		//gcem_detot02.ReadOnly = "true";
		//gcem_crtot02.ReadOnly = "true";
		//gcem_remark02.ReadOnly = "true";
		img_calendar1.ReadOnly = "true";
	}else if (p=="t"){
		gcem_fsdat02.ReadOnly = "false";
		gcem_fs02.ReadOnly = "false";
		gcem_fsdat02.ReadOnly = "false";
		gcem_fsnbr02.ReadOnly = "false";
		//gclx_fsknd02.Enable = true;
		//gclx_fswrkdiv02.Enable = true;
		txt_empnmk02.ReadOnly = "false";
		
		gcem_fswrtdat02.ReadOnly = "false";
		gcem_actdat02.ReadOnly= "false";
		txt_deptcd02.ReadOnly = "false";
		txt_deptnm02.ReadOnly = "false";
		//gcem_ts02.ReadOnly = "false";
		//gcem_tsdat02.ReadOnly = "false";
		//gcem_tsnbr02.ReadOnly = "false";
		//gclx_fsstat02.Enable = true;
		gcem_fsamt02.ReadOnly = "true";
		//gcem_fsvat02.ReadOnly = "true";
		gcem_remark02.ReadOnly = "true";   //적요
		//gcem_detot02.ReadOnly = "true";
		//gcem_crtot02.ReadOnly = "true";
		//gcem_remark02.ReadOnly = "false";
		img_calendar1.ReadOnly = "false";
	}
}

/******************************************************************************
	Description : ln_remark
	prameter    : p - 값
******************************************************************************/
function ln_remark(p){
  gcem_remark02.text=p;
}

/******************************************************************************
	Description : 전표 신규 등록 후 쿼리하면서 키값만 변경함.
	prameter    :	p1 - fdcode 
	              p2 - fsdat
								p3 - fsnbr
******************************************************************************/
function ln_key_change(p1,p2,p3){
   ///alert("p1"+p1+"p2"+p2+"p3"+p3);
	 if (p1!='undefined'&&p2!='undefined'&&p3!='undefined'){
		 gclx_fdcode02.bindcolval=p1;
		 gcem_fs02.text=p2.substring(0,1);
		 gcem_fsdat02.text=p2.substring(1,9);
		 gcem_fsnbr02.text=p3;
	 }
}

/******************************************************************************
	Description : 달력
	prameter    :	    
******************************************************************************/
function ln_Calendar(){

	if(gclx_fsstat02.bindcolval=="Y"){
		alert("결재완료된 전표입니다.");
	}else{
		__GetCallCalendar('gcem_actdat02', 'Text');
	}
}


/******************************************************************************
	Description : 예산금액조회
	prameter    :	    
******************************************************************************/
function ln_BgtFind(){
	
	//alert(""+gcds_dtl.rowposition);
	if(gcds_dtl.rowposition<1){
		alert("데이타를 선택해 주십시요.");
		return;
	}

	if(gclx_fswrkdiv02.bindcolval!="02"){
		alert("예산 적용건이 아닙니다.");
		return;
	}else{
		ln_Bgt_Amt_find(gcds_dtl.rowposition);
	}
	
}

//==========================================================================================================================
/*+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
	Description : 전표입력관련 함수
  +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++*/
//==========================================================================================================================

/******************************************************************************
	Description : 계정코드 찾기
	parameter   : p1 - 계정코드 및 계정명으로 찾기
	              p1 - 01  계정코드,  02 계정명
******************************************************************************/
function ln_Popup_Atcode(p1){
  
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	//if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
  /////if(!ln_Popup_Chk(i)) return; 
  
	/*
	if(gf_Dept_Enable(gs_deptcd,gcds_dept2)){
		arrParam[1]="A";                               // 회계부서
	}else{
		arrParam[1]=gclx_fdcode02.bindcolval;   // 일반부서의 지점
	}
	*/
	
	if(p1=="01"){
		arrParam[0]=gcem_atcode02.text;
	}else{
    	arrParam[0]=gcem_atkornam02.text;
	}
	
    arrParam[1]=gclx_fdcode02.bindcolval;
	strURL = "./actcode_popup_ifrm.jsp";
	strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
	
	if(result != null){
		arrResult = result.split(";");
		ln_Ref_Data_Clear();         //관리항목 Clear();
		ln_Bgt_Amt_Clear();
		//alert("step"+"");
		
		//alert("0000hid_copy_documcd.value:;"+hid_copy_documcd.value);
		ln_Ref_Find(arrResult);     //관리항목찾기
		ln_Fswrkdiv_Setting();      //예산타입 자동 설정
		
    ///////////////////////////////////////////////////////
		//계정코드가 미지급금(법인카드)인 경우 거래처 자동설정
		//2007.07.19 2008.02.01
		if(gcem_atcode02.text=="2100520"){
			 txt_vendcd02.value="I12566";
			 gcem_vendnm02.text = "법인카드공통";
			 gcem_vendnm02.Enable=false;
       
		}else{
       		gcem_vendnm02.Enable=true; 
		}
		//////////////////////////////////////////////////////

		////////////////////////////////////////////////////// 
        //2009.01.29 정영식
		//개인명법인카드적용시 관리항목 LOCK 설정
		if(gcem_atcode02.text=="2100525"){
		  //LOCK 설정 
			ln_Ref_Card_Lock("F",gcds_dtl.rowposition);
			txt_vendcd02.value="";
			gcem_vendnm02.text = "";
			hid_lastref.value = 2; //적요에서 ENTER시 행 추가
		}else{
     // ln_Ref_Card_Lock("T",gcds_dtl.rowposition); 
		}
		////////////////////////////////////////////////////// 
		//2010.04.06 jys  비용수익체크 - 비용계정과 수익계정 입력시 차대 체크
		ln_Chk_Atcode_Amt()
	}
}

/******************************************************************************
	Description : 관리항목설정
	parameter   : arrResult - return 값
******************************************************************************/
function ln_Ref_Find(arrResult){
     hid_lastref.value=""; //마지막관리항목     

	 if(arrResult[0]!=undefined){
			gcem_atcode02.text = arrResult[0];
			gcem_atkornam02.text =arrResult[1];
			
			//++++++++++++++++++++++++++++++++++
			//계정별 관리항목 Setting
			//++++++++++++++++++++++++++++++++++
            //부서
			txt_fsrefcd01.value="0002";
			txt_deptcd02_1.value=arrResult[3];
			
			//거래처
			txt_fsrefcd02.value="0020";
			//세금계산서가 존재할 경우 거래처코드 변경안함.
			//2015.02.24. jys 막음..이게 왜 있는지 모르것음.
			/*
			if(hid_docuval.value==""){
				txt_vendcd02.value=arrResult[5];
			}
			*/
			
			eval("txt_type01").value = arrResult[21];
			eval("txt_type02").value = arrResult[22];
			eval("txt_arbaldiv01").value = arrResult[30];
			eval("txt_arbaldiv02").value = arrResult[31];
      
			//부서, 거래처 두개뿐일 경우
			hid_lastref.value = 2;
			
			for(k=3;k<=9;k++){
				
			    eval("txt_fsrefcd0"+k).value = arrResult[k+k+1];
				eval("txt_fsrefnm0"+k).value = arrResult[k+k+2];
				eval("txt_type0"+k).value = arrResult[k+20];
				eval("txt_arbaldiv0"+k).value = arrResult[k+29];
				
				//관리항목코드가 존재하지 않을 경우 입력항목 Lock 설정
				//alert("k::"+k+"::txt_fsrefcd"+eval("txt_fsrefcd0"+k).value);
				if(eval("txt_fsrefcd0"+k).value==""){
					eval("gcem_fsrvalnm0"+k).enable = false;
          			eval("txt_fsrefval0"+k).disabled = true;
				}else{
					hid_lastref.value = k;
					eval("gcem_fsrvalnm0"+k).enable = true;
        			eval("txt_fsrefval0"+k).disabled = false;
        			
				}	
				//관리항목에서 날짜타입의 경우 Format 설정
				ln_Ref_Date_Money_Format(k);
			}//for
		

			hid_funddiv.value = arrResult[43]; //자금구분
      		hid_atdecr.value=arrResult[40];    //기준차대  
			hid_banjaeyn.value = arrResult[39];//반제
			hid_atcurtype.value = arrResult[45];//금강산 원화환율구분

      //2007.12.26 정영식 추가
			hid_banjaeref.value =  arrResult[44];//반제관리항목			                                    
			//return ;
	 }else{

	 }
     
     //alert("step2");
     
   //복사한 부서, 거래처, 적요등을 붙여넣음.
	 ln_Paste_Dept_Vend_Reamrk(gcds_dtl.rowposition);
}

/******************************************************************************
	Description : 관리항목 찾기
	parameter   : p1 - 관리항목 구분값
	              obj - object명 
******************************************************************************/
function ln_Popup2(p1,obj,strkeycode){

    //alert("p1::"+p1+"obj"+obj+"strkeycode"+strkeycode);
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var strposition="";
	var strpo2="";
	var strpo3="";
	var strPopGubun ="";
	var strPo="";// 관리항목위치
	var divcd="";
	var intp=0; //관리항목 위치

    if(p1=="02_1"){      //부서
		arrParam[0] ="0002";
		arrParam[1] = gcem_deptnm02_1.text;
	}else if(p1=="02"){  //거래처
    	arrParam[0] = "0020";
		arrParam[1] = gcem_vendnm02.text;
	}else{
		arrParam[0] = eval("txt_fsrefcd"+p1).value;
    	arrParam[1] = eval("gcem_fsrvalnm"+p1).text;
	}

    if(p1!="02_1") {
		strPopGubun = ln_PopGubun('1',p1,'txt_fsrefcd'); //자금관련 계정 구분
	}
	
	if(p1=="02_1"){     //부서
		intp=2;
	}else if(p1=="02"){ //거래처
		intp=1;
	}else{
		intp = Number(p1);
	}
	
	//alert("intp::"+intp+":txt_fsrefcd0::"+eval("txt_fsrefcd0"+intp).value +":txt_type0:"+eval("txt_type0"+intp).value);
	//입력항목일 경우 return ==>어음번호는 제외
    if(eval("txt_fsrefcd0"+intp).value!="0967"&&eval("txt_type0"+intp).value=="C"){
		if(eval("gcem_fsrvalnm0"+intp).text!=""){
			ln_Row_Auto_Add(intp,"01");
		}
		return;
	}
	
	
    //2012.02.08 JYS 관광구분 엔터 행추가, F2치면 팝업처리
	if(eval("txt_fsrefcd0"+intp).value=="2195"&&strkeycode=="13"){
		if(eval("gcem_fsrvalnm0"+intp).text==""){
			ln_Row_Auto_Add(intp,"01");
		}
		return;
	}
    
	//2015.11.11 JYS 외상매입금 원가코드 엔터시 다음행  오연주만
	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=="2100110"&&gusrid=="3170009"){
		if(eval("txt_fsrefcd0"+intp).value=="0030"&&strkeycode=="13"){
			if(eval("gcem_fsrvalnm0"+intp).text==""){
				ln_Row_Auto_Add(intp,"01");
			}
			return;
		}
	}
      
	//alert("strPopGubun::"+strPopGubun);
    //팝업체크
    if(!ln_Chk_Popup(intp))return; 
	//2007.06.29
	//2008.02.01  법인카드 거래처의 경우 텍스트로 입력함.(0029를 제외함.)
	if(arrParam[0]=="0020"||arrParam[0]=="0029"){
	//if(arrParam[0]=="0020"){
		strURL = "./gczm_vender_popup.jsp";
		strPos = "dialogWidth:494px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(arrParam[0]=="0002"){
	  
		arrParam[2]="A";
		arrParam[3]="";
		arrParam[4]=gclx_fdcode02.bindcolval;

		//2007.10.08.회계일자 추가(부서 CHGYM 관련)
		var stractdat = gcem_actdat02.text;
		arrParam[5]=stractdat.substring(0,6);
		//****************************
		
		//**수정사항 :: 금강산 개성 부서 가져오기 위해 모두 막음
		/*
        if(gf_Dept_Enable(gs_deptcd,gcds_name)){ //관리부서
            arrParam[2]="A";
			arrParam[3]="";
			arrParam[4]=gclx_fdcode02.bindcolval;
		}else{ //일반부서
			divcd = ln_Find_Divcd(); //본부찾기
			arrParam[2]="B";
			arrParam[3]=divcd;
			arrParam[4]=gclx_fdcode02.bindcolval;
		}
		*/
    
	    strURL = "./hcdept_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(arrParam[0]=="1160"){ //상대계정
	    arrParam[0]=arrParam[1];
        strURL = "./actcode_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(strPopGubun=="1"&&arrParam[0]=="0967"){ //팝업구분 && 어음번호일경우 ===> 발생
	    arrParam[1]=hid_funddiv.value;      //자금구분
		arrParam[2]= "";  //은행
		arrParam[3]= "0"; //처리구분(0-미발행)
        arrParam[4]=gclx_fdcode02.bindcolval;          //지점
		arrParam[5]=gcem_atcode02.text;                //계정
        strURL = "./bill_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
    }else if(strPopGubun=="2"&&arrParam[0]=="0967"){ //팝업구분 && 어음번호일경우 ====>정산
		if(txt_vendcd02.value==""||gcem_vendnm02.text==""){
			alert("거래처를 입력하시요.");
			return;
	    }
		arrParam[1]=hid_funddiv.value;          //자금구분
		arrParam[3]= "0";                       //처리구분(0-처리중)
		arrParam[4]=gclx_fdcode02.bindcolval;   //지점
		arrParam[5]=gcem_atcode02.text;         //계정코드
		arrParam[7]=gcem_atkornam02.text;       //계정명
		
		if(txt_fsrefcd02.value=="0020"){
		  arrParam[2]= txt_vendcd02.value;     //거래처코드
		  arrParam[6]= gcem_vendnm02.text;     //거래처
		}else{
		  arrParam[2]="";
      	  arrParam[6]="";
		}
    	strURL = "./bill_popup_ifrm2.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no"; 
	}else if(arrParam[0]=="0003"){ //예산부서
	  ///alert("step2::"+eval("hid_bgtdiv"+p5).value);
		arrParam[2]=hid_bgtdiv.value;
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(arrParam[0]=="0030"){ //원가코드
	  //^^alert("step2::"+eval("hid_bgtdiv"+p5).value);
		arrParam[2]="";
		/*
		if(gclx_fdcode02.bindcolval=="01"){
			arrParam[2]="02";
		}else{
      		arrParam[2]=gclx_fdcode02.bindcolval;
		}
		*/
		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	}else if(arrParam[0]=="1133"){ //카드번호
	   arrParam[2]="";
       for(p=3;p<=9;p++){
			if(eval("txt_fsrefcd0"+p).value=="1134"){
				arrParam[2]=eval("txt_fsrefval0"+p).value;
				break;
			}
		}
		strURL = "./commdtil_popup_card.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
   
  	//2011.05.09 JYS////////////////////////////////////////////////////////////////////
  	}else if(arrParam[0]=="1135"){ //자산코드번호
	    arrParam[1]=gclx_fdcode02.bindcolval;   //지점
		arrParam[2]=gcem_atcode02.text;         //계정코드
		strURL = "./commdtil_popup_astnbr.jsp";
		strPos = "dialogWidth:600px;dialogHeight:379px;status:no;scroll:no;resizable:no";
  	////////////////////////////////////////////////////////////////////////////////////

  	}else{
	 // alert("arrParam[0]:"+arrParam[0]+":arrParam[1]:"+arrParam[1]+"::");
	  if(arrParam[0]=="0997"||arrParam[0]=="0023"||arrParam[0]=="0022")arrParam[2]="A";    //2016.06.10 jys 0023 추가 

		strURL = "./commdtil_popup_ifrm.jsp";
		strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	  }
	  result = showModalDialog(strURL,arrParam,strPos);	

	  if(result != null) {
		arrResult = result.split(";");
    	if(strPopGubun=="1"){        //자금발생
		  //어음번호
			eval("txt_fsrefval"+p1).value=arrResult[1];
			eval("gcem_fsrvalnm"+p1).text=eval("txt_fsrefval"+p1).value;

			//은행
			strPo="";
			strPo=ln_Ref_position_find("0022");
			eval("txt_fsrefval"+strPo).value =arrResult[2];   //은행코드
			eval("gcem_fsrvalnm"+strPo).text =arrResult[3];   //은행명
			
			////ln_Ref_lock(strPo,'1');
		}else if(strPopGubun=="2"){  //자금정산
		  
			//금액체크1 --받을어음의 경우  대변 금액이 발생금액(차변금액)과 동일해야함.
			//금액체크2 --지급어음의 경우  차변 금액이 발생금액(대변금액)과 동일해야함.
			if(hid_funddiv.value=="50"){
				if(gcem_crtot02.text!=arrResult[8]){
					alert("정산금액이 발생금액과 동일하지 않습니다.");
					////ln_Ref_Fund_Clear("2",p3,p4,p5);
					return ;
				}
			}else if(hid_funddiv.value=="60"){
				if(gcem_detot02.text!=arrResult[9]){
                   alert("정산금액이 발생금액과 동일하지 않습니다.");
					////ln_Ref_Fund_Clear("2",p3,p4,p5);
					return ;
				}
			}

			//어음번호
			eval("txt_fsrefval"+p1).value=arrResult[1];
			eval("gcem_fsrvalnm"+p1).text=eval("txt_fsrefval"+p1).value;

			//거래처
			//strPo = ln_Ref_position_find(p5,"0020");
			//eval("txt_fsrefval"+strPo).value =arrResult[2];  //거래처코드
			//eval("txt_fsrvalnm"+strPo).value =arrResult[3];  //거래처
			//ln_Ref_lock(strPo,'2');

			//은행
			strPo="";
			strPo = ln_Ref_position_find("0022");
			eval("txt_fsrefval"+strPo).value =arrResult[6];   //은행코드
			eval("gcem_fsrvalnm"+strPo).text =arrResult[7];   //은행명
			//ln_Ref_lock(strPo,'2');

			//어음발생일
			strPo="";
			strPo = ln_Ref_position_find("0968");
			eval("txt_fsrefval"+strPo).value =arrResult[4];   //
			eval("gcem_fsrvalnm"+strPo).text =arrResult[4];   //
			//ln_Ref_lock(strPo,'2');

			//어음만기일
			strPo="";
			strPo = ln_Ref_position_find("0969");
			eval("txt_fsrefval"+strPo).value =arrResult[5];   //
			eval("gcem_fsrvalnm"+strPo).text =arrResult[5];   //
			//ln_Ref_lock(strPo,'2');

			//금액 lock
			////ln_Ref_lock(strPo,'3',i); //금액 lock
		}else{                //자금이외
			if(p1=="02_1"){   //부서
				eval("txt_deptcd"+p1).value =arrResult[0];
				eval("gcem_deptnm"+p1).text =arrResult[1];
			}else if(p1=="02"){  //거래처 
			
				//alert("거래처....."+arrResult[7]);
				hid_gredgb.value=arrResult[7];
			
			    //가압류 처리 체크
			    if(arrResult[7]=="1"||arrResult[7]=="2"){
			    	if(!ln_Bond_Attach_Chk(arrResult[0],gcds_dtl.rowposition)){
			    		//alert("888");
			    		eval("txt_vendcd"+p1).value="";
			    		eval("gcem_vendnm"+p1).text="";
			    		return false;
			    	}else{
			    		//alert("999");
			    	}
			    }
	
				eval("txt_vendcd"+p1).value =arrResult[0];
				eval("gcem_vendnm"+p1).text =arrResult[1];
				//alert("strkeycode:"+strkeycode);
				
				//반제일 경우 반제 팝업 자동 설정
				if(gs_userid2="true") {
					if(strkeycode==13||strkeycode==113){ //Tab
						if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")!=""&&gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")!="" ){
							if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD02")=="0020"){      //거래처
								ln_Chk_Banjae_Amt(); //반제계정체크
							}
						}
					}
				}

				//2009.01.29. 법인카드 관련 추가///////////////////////////////////////////////////////////////////////////////////
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=="2100525"){
				   if (!ln_Card_Data_Setting()){
					   //alert("["+gcem_vendnm02.text+"]에 대한 개인명법인카드 정보가 존재하지 않습니다.");
					   alert("개인명법인카드 정보가 존재하지 않습니다.");
				   }
				}
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

			}else{
		        eval("txt_fsrefval"+p1).value =arrResult[0];
		        eval("gcem_fsrvalnm"+p1).text =arrResult[1];
			}
		
			if(arrParam[0]=="0002"){          //부서
				hid_divcd.value = arrResult[3]; //본부
				
				//예산부서 위치찾기
				var spo=ln_Ref_position_find("0003")
				if(spo!=""&&spo!=undefined){
					if (eval("txt_fsrefcd"+spo).value=="0003"){
							eval("txt_fsrefval"+spo).value = arrResult[4]; //예산부서
							eval("gcem_fsrvalnm"+spo).text = arrResult[5]; //예산부서명
							hid_bgtdiv.value =arrResult[6];                //예산본부코드
					} 
				}
			}else if (arrParam[0]=="0003"){  ////예산부서
				hid_bgtdiv.value =arrResult[2]; //예산본부코드
				/******왜 본부가 1000일경우 막는가?
				if(arrResult[2]=="1000"){
				}else{
					hid_bgtdiv.value =arrResult[2]; //예산본부코드
				}
				************/

				if(hid_bgtcnt.value!=0){         //예산계정 세목이 존재하는 경우
					
				}else if(hid_bgtcmtype.value!=""&&hid_bgtcnt.value==0){//예산계정 세목이 존재하지 않을 경우
					////ln_Bgt_Amt_find('','','',p5);
				}
			}else{
				 if(hid_type.value=="B"){    //예산부서의 세목이면 
						if(hid_bgtcnt.value!=0){ //예산계정이 세목이 존재하는 경우
							/////ln_Bgt_Amt_find(p2,p3,p4,p5);       
						}else if(hid_bgtcmtype.value!=""&&hid_bgtcnt.value==0){ //예산계정 세목이 존재하지 않을 경우
							//ln_Bgt_Amt_find('','','',p5);
						}
				 }
			}
		}
    	ln_Row_Auto_Add(intp,"01");
	}else{//Data가 존재하지 않을 경우
		if(strPopGubun=="1"){        //자금발생
			////ln_Ref_Fund_Clear("1",p3,p4,p5);
		}else if(strPopGubun=="2"){  //자금정산
		  ////ln_Ref_Fund_Clear("2",p3,p4,p5);
		}else{
			if(p1=="02_1"){
				eval("txt_deptcd"+p1).value ="";
				eval("gcem_deptnm"+p1).text ="";
			}else if(p1=="02"){
				eval("txt_vendcd"+p1).value ="";
				eval("gcem_vendnm"+p1).text ="";
			}else{
		        eval("txt_fsrefval"+p1).value ="";
		        eval("gcem_fsrvalnm"+p1).text ="";
			}
			if(arrParam[0]=="0002"){
			  //부서가 존재하지 않으면
				hid_divcd.value="";
			}
			if(arrParam[0]=="0003"){
			  //부서가 존재하지 않으면 예산본부도 없음.
				var spo=ln_Ref_position_find("0002");//부서
				if(spo!=""&&spo!=undefined){
					if(eval("txt_fsrefval"+spo).value==""){
						 hid_bgtdiv.value ="";
					}
				}else{
					hid_bgtdiv.value ="";
				}
			}
		}
		return;
	}	
}
	
<%
/******************************************************************************
	Description :  가압류 거래처 체크 
******************************************************************************/
%>
function ln_Bond_Attach_Chk(strVend_cd,strRow){
	
	if(gcds_dtl.namevalue(strRow,"ATCODE")=="1110310"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110610"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110620"||gcds_dtl.namevalue(strRow,"ATCODE")=="1112110"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1112120"
	  ){
		
		//차변<>0  AND 대변=0  이면  BOND_ATTACH_HIS 체크하여 미존재 하면 입력불가   		
		if(gcds_dtl.namevalue(strRow,"CHAAMT")!=0&&gcds_dtl.namevalue(strRow,"DAEAMT")==0){
			//ln_Bond_Attach_His(strVend_cd,gs_userid,'20170302');
			if(!ln_Bond_Attach_His(strVend_cd,gs_userid,gs_date)){
				//alert("strRow:::"+strRow);
				gcds_dtl.rowposition = strRow;
				return false;
			}else{
				return true;
			}
		}else if(gcds_dtl.namevalue(strRow,"CHAAMT")==0&&gcds_dtl.namevalue(strRow,"DAEAMT")!=0){
			return true;
		}else{
			alert("차변금액 또는 대변금액을 입력하십시요. ");
			return false;
		}
	}else if(
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110110"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110120"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110140"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110150"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110160"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110170"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110180"||gcds_dtl.namevalue(strRow,"ATCODE")=="1110190"||
	   gcds_dtl.namevalue(strRow,"ATCODE")=="1110193"
	){
		//차변=0  AND 대변<>0  이면  BOND_ATTACH_HIS 체크하여 미존재 하면 입력불가
		if(gcds_dtl.namevalue(strRow,"CHAAMT")!=0&&gcds_dtl.namevalue(strRow,"DAEAMT")==0){
			return true;
		}else if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")==0&&gcds_dtl.namevalue(strRow,"DAEAMT")!=0){
			if(!ln_Bond_Attach_His(strVend_cd,gs_userid,gs_date)){
				return false;
			}else{
				return true;
			}
		}else{
			alert("차변금액 또는 대변금액을 입력하십시요. ");
			return false;
		}
	}else{
		return true;
	}
	
	return false;
}

<%
/******************************************************************************
	Description :  가압류 거래처 HISTORY  확인  
******************************************************************************/
%>
function ln_Bond_Attach_His(strVendcd, strEmpno, strDate){
	gcds_bond_attach_his.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a070023_s3?v_str1="+strVendcd+"&v_str2="+strEmpno+"&v_str3="+strDate;
	//prompt('',gcds_bond_attach_his.DataID);
	gcds_bond_attach_his.Reset();
	
	//alert("gcds_bond_attach_his::"+gcds_bond_attach_his.namevalue(gcds_bond_attach_his.rowposition,"CNT"));
	if(gcds_bond_attach_his.namevalue(gcds_bond_attach_his.rowposition,"CNT")!=0){
		return true;
	}else{
	    alert("해당 거래처는 [채권(가)압류] 업체입니다. \n\n 경영관리팀(내선3838)으로 연락바랍니다. ");
		return false;
	}
}

/******************************************************************************
	Description :  Enter 시 Row 자동 추가
	parameter   :  intp - 현재 관리항목 위치
	               gubun - 01 
								         02 : 적요
******************************************************************************/
function ln_Row_Auto_Add(intp,gubun){
    //alert("ln_Row_Auto_Add::intp:"+intp+"::hid_lastref;"+hid_lastref.value+"gcds_dtl"+gcds_dtl.namevalue(gcds_dtl.rowposition,"LASTREF"));
	//data가 마지막 관리항목일 경우 //addrow();
	if(intp!=2){
		if(intp==gcds_dtl.namevalue(gcds_dtl.rowposition,"LASTREF")){
			if(gcds_dtl.countrow ==gcds_dtl.rowposition){
				if(!ln_Add(99,'')){
					return;
				}
			}
			gcem_atkornam02.Focus();
		}
	}else{ //2인 경우는 적요에서 Enter 칠 경우만 가능함.
		if(gubun=="02"){
			if(gcds_dtl.countrow ==gcds_dtl.rowposition){
				if(!ln_Add(99,'')){
					return;
				}
			}
			gcem_atkornam02.Focus();
		}
	}
}

/******************************************************************************
	Description :  자금관련 계정 구분
	parameter   :  gubun 구분(체크위치,
	               p1 - 관리항목 object
	참     고   : //지급어음 & 차변 =0 대변 <>0 (발생 ==> Popup)
								//지급어음 & 차변<>0 대변 = 0 (정산 ==> Popup)
								//받을어음 & 차변 =0 대변 <>0 (정산 ==> Popup)
								//받을어음 & 차변<>0 대변 = 0 (발생 ==> 입력)
******************************************************************************/
function ln_PopGubun(gubun, p1, obj){
 //alert("gubun::"+gubun+"obj::"+obj+":p1:"+p1+"::"+eval(obj+p1).value);
 //alert("hid_funddiv.value::"+hid_funddiv.value);
	var strPopGb="";
	
	if(gubun=="1"){
		if(eval(obj+p1).value=="0967"&&hid_funddiv.value=="60"&& gcem_detot02.text==0 && gcem_crtot02.text!=0){
			strPopGb="1";
		}else if(eval(obj+p1).value=="0967"&&hid_funddiv.value=="60"&& gcem_detot02.text!=0 && gcem_crtot02.text==0){
			strPopGb="2";
		}else if(eval(obj+p1).value=="0967"&&hid_funddiv.value=="50"&& gcem_detot02.text==0 && gcem_crtot02.text!=0){
			strPopGb="2";
		}
	}else if(gubun=="2"){
		if(hid_funddiv.value=="60"&& gcem_detot02.text==0&&gcem_crtot02.text!=0){
			strPopGb="1";
		}else if(hid_funddiv.value=="60"&& gcem_detot02.text!=0&&gcem_crtot02.text==0){
			strPopGb="2";
		}else if(hid_funddiv.value=="50"&& gcem_detot02.text==0&&gcem_crtot02.text!=0){
			strPopGb="2";
		}
	}
	return strPopGb;
}


/******************************************************************************
	Description :  전표MST 데이타 Clear();
	parameter   :  
******************************************************************************/
function ln_MST_Data_Clear(){
  gcem_remark02.text="";
  gcem_fsamt02.text=0;
}


/******************************************************************************
	Description :  전표입력 데이타 Clear();
	parameter   :  
******************************************************************************/
function ln_Input_Data_Clear(){
	return;
	gcem_fsnum02.text="";
	gcem_atcode02.text="";
	gcem_atkornam02.text="";
	gcem_detot02.text=0;
	gcem_crtot02.text=0;
	gclx_documcd02.bindcolval="";
	gclx_fswrkdiv02.bindcolval="";
	txt_vendcd02.value="";
	gcem_vendnm02.text="";
	txt_deptcd02.value="";
	gcem_deptnm02.text="";
	gcem_remark02_1.text="";

	for(k=3;k<=9;k++){
		eval("gcem_fsrvalnm0"+k).text="";
		eval("txt_fsrefval0"+k).value="";
	}
}

/******************************************************************************
	Description :  관리항목 데이타 Clear();
	parameter   :  
******************************************************************************/
function ln_Ref_Data_Clear(){
	for(k=3;k<=9;k++){
		eval("gcem_fsrvalnm0"+k).text="";
		eval("txt_fsrefval0"+k).value="";
	}
}

/******************************************************************************
	Description : 관리항목 자금관련 clear
	parameter   : gubun - 구분
	              p3 - object (i+j 값)
								p4 - object (열 구분값 1,2,3)
								참고 : p2+p3+p4 - 해당 관리항목 코드 또는 명칭
								p5 - i position

******************************************************************************/
function ln_Ref_Fund_Clear(gubun,p3,p4,p5){ 	

	if(gubun=="1"){
		 //어음번호
		eval("txt_fsrefval"+p3+p4).value="";
		eval("txt_fsrvalnm"+p3+p4).value="";

		 //은행
		strPo="";
		strPo = ln_Ref_position_find("0022");
		eval("txt_fsrefval"+strPo).value ="";   //은행코드
		eval("txt_fsrvalnm"+strPo).value ="";   //은행명
		ln_Ref_lock(strPo,'1');
	}else if(gubun=="2"){
		//어음번호
		eval("txt_fsrefval"+p3+p4).value="";
		eval("txt_fsrvalnm"+p3+p4).value="";
		
		//은행
		strPo="";
		strPo = ln_Ref_position_find("0022");
		eval("txt_fsrefval"+strPo).value ="";   //은행코드
		eval("txt_fsrvalnm"+strPo).value ="";   //은행명
		ln_Ref_lock(strPo,'2');
		//어음발생일
		strPo="";
		strPo = ln_Ref_position_find("0968");
		eval("txt_fsrefval"+strPo).value ="";   //
		eval("txt_fsrvalnm"+strPo).value ="";   //
		ln_Ref_lock(strPo,'2');
		//어음만기일
		strPo="";
		strPo = ln_Ref_position_find("0969");
		eval("txt_fsrefval"+strPo).value ="";   //
		eval("txt_fsrvalnm"+strPo).value ="";   //
		ln_Ref_lock(strPo,'2');
	}
}

/******************************************************************************
	Description : 전표등록 - DTL Data Add
	parameter   : 
******************************************************************************/
function ln_Data_Add_DTL(){
   /*
   return;
	 var temp_fsdat="";
	 var temp_seq=0;
  temp_fsdat = gcem_fsdat02.text;

	//gcds_dtl.ClearAll();
	ln_SetDataHeader("DTL"); 
	gcds_dtl.addrow();

	hid_fsdat.value = gcem_fs02.text+gcem_fsdat02.text;
	temp_seq = Number(gcds_data01.Max(4,0,0))
	temp_seq = Number(temp_seq)+1

  gcds_dtl.namevalue(gcds_dtl.rowposition,"FDCODE")=gs_fdcode;                  //현장코드
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSDAT")=hid_fsdat.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNBR")=gcem_fsnbr02.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")=ln_Seqno_Format(temp_seq,5);
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ATCODE")=gcem_atcode02.text;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"ATKORNAM")=gcem_atkornam02.text;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"ATDECR")="2"; //프로시저에서 생성함.
	gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")=gcem_remark02_1.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")=gcem_detot02.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")=gcem_crtot02.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ01")=txt_fsrefseq01.value;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ02")=txt_fsrefseq02.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ03")=txt_fsrefseq03.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ04")=txt_fsrefseq04.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ05")=txt_fsrefseq05.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ06")=txt_fsrefseq06.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ07")=txt_fsrefseq07.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ08")=txt_fsrefseq08.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFSEQ09")=txt_fsrefseq09.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD01")=txt_fsrefcd01.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD02")=txt_fsrefcd02.value;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD03")=txt_fsrefcd03.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD04")=txt_fsrefcd04.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD05")=txt_fsrefcd05.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD06")=txt_fsrefcd06.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD07")=txt_fsrefcd07.value;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD08")=txt_fsrefcd08.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD09")=txt_fsrefcd09.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL01")=txt_deptcd02_1.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL02")=txt_vendcd02.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL03")=txt_fsrefval03.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL04")=txt_fsrefval04.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL05")=txt_fsrefval05.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL06")=txt_fsrefval06.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL07")=txt_fsrefval07.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL08")=txt_fsrefval08.value;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL09")=txt_fsrefval09.value;
	*/
  /*
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM01")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM02")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM03")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM04")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM05")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM06")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM07")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM08")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFNM09")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM01")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM02")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM03")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM04")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM05")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM06")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM07")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM08")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM09")=;
	*/
	/*
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE01")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE02")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE03")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE04")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE05")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE06")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE07")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE08")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"TYPE09")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV01")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV02")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV03")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV04")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV05")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV06")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV07")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV08")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"ARBALDIV09")=;
	*/
	/*
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"CNT")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMCD")=gclx_documcd02.bindcolval;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUMNM")=;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")=gclx_fswrkdiv02.bindcolval;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"WRDT")=gs_date;	 
	gcds_dtl.namevalue(gcds_dtl.rowposition,"WRID")=gs_userid;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"UPDT")=gs_date; 
	gcds_dtl.namevalue(gcds_dtl.rowposition,"UPID")=gs_userid;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")=;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSTAT")=;
  gcds_dtl.namevalue(gcds_dtl.rowposition,"DOCUVAL")=hid_docuval.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"FSNUM")=gcem_fsnum02.text;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"DIVCD")=txt_deptcd02_1.value;
	gcds_dtl.namevalue(gcds_dtl.rowposition,"BGTDIV")=hid_divcd.value;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"FUNDDIV")=;
	//gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEREF")=;
	
  gcem_fswrtdat02.text=gs_date;  
	*/
}

/******************************************************************************
	Description : 전표등록 - 순번 찾기
	parameter   : 
******************************************************************************/
function ln_Fsnum_Find(){
  var ifsnum=0;
	_out:
	for(k=1;k<=gcds_dtl.countrow;k++){
		if(gcds_dtl.namevalue(k,"FSNUM")==""){
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
	for(k=ipo;k<=gcds_dtl.countrow;k++){
		gcds_dtl.namevalue(k,"FSNUM") = ln_Seqno_Format(Number(k),3);
	}
}

/******************************************************************************
	Description : 세금계산서 및 계산서 등록
	parameter   : p0 - position
				        p1 - 지점코드
	              p2 - 접수일자
                p3 - 접수번호
								p4 - 전표행번호
					
				참 고	:	증빙구분 ( 001-세금계산서, 002-계산서)

	수정 : 2006.03.02 - 증빙명에 대한 프로세스 변경으로 추가됨
	       
******************************************************************************/
function ln_Popup_Tax(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var strDocumcd="";
	var strDocGB="";
	var p1 = gclx_fdcode02.bindcolval;
    var p2 = gcem_fs02.text+gcem_fsdat02.text;
	var p3 = gcem_fsnbr02.text;
	var p4 = "";

	strDocumcd=gclx_documcd02.bindcolval;
	strDocGB=strDocumcd.substring(0,1);

	if(gclx_documcd02.bindcolval==""||gclx_documcd02.bindcolval=="000"){  
		alert("증빙명을 선택하십시요.");
		return;
  }

	if(hid_docuval.value==""){
		arrParam[0]=p1;   //지점코드
		arrParam[1]=p2;   //접수일자
		arrParam[2]=p3;   //접수번호
		arrParam[3]=p4;   //전표행번호
		
		if(txt_fsrefcd02.value=="0020"){
			arrParam[4]=txt_vendcd02.value;   //거래처코드
			arrParam[5]=gcem_vendnm02.text;   //거래처명
		}else{
			arrParam[4]="";   //거래처코드
			arrParam[5]="";   //거래처명
		}
	}else{  //매입매출장 접수번호 존재
	    var strdocuval =hid_docuval.value;
		arrParam[0]=strdocuval.substring(0,1);   //매입매출구분 (A-매입, B-매출)
		arrParam[1]=p1;                          //지점코드
		arrParam[2]=strdocuval.substring(1,11);  //접수번호
	}
  
	//alert("strDocGB"+strDocGB);
	//증빙구분////////////////////////////// 	
	if(strDocGB=="1"){
		arrParam[6]= gclx_documcd02.bindcolval;  
		arrParam[7]= hid_docuval.value;
    	if(hid_docuval.value==""){
		  //2009.09.10 전자세금계산서 적용 
			//strURL = "./Com_Tax_List1.html";
			strURL = "./com_tax_list1_e.jsp";
			strPos = "dialogWidth:830px;dialogHeight:500px;status:no;scroll:no;resizable:no";
		}else{
	  	    //2009.09.10 전자세금계산서 적용 
			//strURL = "./STaxBill_popup.html";
			//strURL = "./STaxBill_popup_e.html";
			//alert("staxbill_popup_ee");
			//strURL = "./staxbill_popup_ee.jsp";
			
			if(arrParam[7].substring(0,1)=="A"||arrParam[7].substring(0,1)=="C"||arrParam[7].substring(0,1)=="E"||arrParam[7].substring(0,1)=="G"||arrParam[7].substring(0,1)=="I"){
				strURL = "./a040110_view_popup.jsp";
			}else if(arrParam[7].substring(0,1)=="B"||arrParam[7].substring(0,1)=="D"||arrParam[7].substring(0,1)=="F"||arrParam[7].substring(0,1)=="H"||arrParam[7].substring(0,1)=="J"){
				strURL = "./a040120_view_popup.jsp";
			}
			
			strPos = "dialogWidth:970px;dialogHeight:635px;status:no;scroll:no;resizable:no";
						
		}
    }else if(strDocGB=="2"){
		//ln_Popup_Tax2(p0);
		return;
	}
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		var stracnbr="";
  		var cnt = arrResult.length/13 //Dtl row 갯수
    
		var chasum=0;
		var daesum=0;
		var k=-1;
		var stracnbr =""//계산서 번호
		hid_copy_documcd.value="";
		hid_copy_docuval.value="";

		if(gcem_remark02_1.text==""){
			gcem_remark02_1.text=arrResult[k+7]; //적요
			gcem_remark02.text=arrResult[k+7]; //적요
		}

		for(m=1;m<=cnt;m++){
		  //Detail 항목 추가
			if(m==1){
			  //alert("m02::"+m)
			}else{
			  //alert("m03::"+m);
				ln_Add('99','TAX');
			}
		
			chasum+=parseInt(arrResult[k+8]);
			daesum+=parseInt(arrResult[k+9]);
		    //parameter   :  p1 - 계정코드,  p2- 계정명,    p3 -거래처코드,   p4-거래처명,  p5 - 부서코드, 
	        //               p6 - 부서명,    p7- 적요,      p8 - 차변,        p9-대변,      p10 - 계산서번호, p11 - 증빙코드
			//               p12 - 본부코드
			ln_Refcode_find(arrResult[k+1],arrResult[k+2], arrResult[k+3],arrResult[k+4], arrResult[k+5],
		                    arrResult[k+6],arrResult[k+7], arrResult[k+8],arrResult[k+9], arrResult[k+10], 
											arrResult[k+11],arrResult[k+12],arrResult[k+13]);
			
			//동일계산서 번호는 한번만 넘김.
			if(stracnbr!=arrResult[k+10]){
				ln_Tax_Data_Save(arrResult[k+10],gs_date,gs_userid,p2);
			}
			stracnbr = arrResult[k+10];
			ln_lock(m,'1');
      
			 //2008.09.02 정영식 - 처음 세금계산서 가져올 때만 상대계정 거래처 수정 가능하게 함.
			if(m==cnt) {
				/**
				txt_vendcd02.disabled=false;
                gcem_vendnm02.Enable=true;	
				**/
				//2010.04.08 jys 미지급금(법인카드)의 경우 거래처 lock함.
				if(gcem_atcode02.text!="2100520"){
					txt_vendcd02.disabled=false;
					gcem_vendnm02.Enable=true;	
				}
			} 
			
			k+=13; //parameter갯수
		}//for
			g_taxval += Number(chasum);
			g_fsknd = "1";
	}else{
    //eval("txt_fsrefval"+p3+p4).value="";
		//eval("txt_fsrvalnm"+p3+p4).value="";
	}
}

/******************************************************************************
	Description : 계정코드로 관리항목 갯수 설정
	parameter   :  p1 - 계정코드, p2- 계정명,    p3 -거래처코드   p4-거래처명   
	               p5 - 부서코드, p6- 부서명,    p7 - 적요,       p8 - 차변,     p9-대변
								 p10 - ((세금)계산서,신용카드,현금소득공제 : 번호)
								 p11 - ((세금)계산서,신용카드,현금소득공제 : 증빙코드)
								 p12 - 본부, p13 - 계산서일자
******************************************************************************/
function ln_Refcode_find(p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13){
	var cnt =0;
	var xcnt=0;
	var j=0;
	var dblcount=0;
	var strfsrefval="";
	var strfsrefvalnm="";
	hid_type.value="";
 
    //alert("DTL"+"p1:"+p1+":p2:"+p2+":p3:"+p3+":p4:"+p4+":p5:"+p5+":p6:"+p6+":p7:"+p7+":p8:"+p8+":p9:"+p9+":p10:"+p10+":p11:"+p11+":p12:"+p12+":p13:"+p13);
	if(p1!=""){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>actcode_s1f?v_str1="+p1+"&v_str2='ATCODE'&v_str3="+gclx_fdcode02.bindcolval;                                               
		//prompt("gcds_code01",gcds_code01.DataID);
		gcds_code01.Reset();
		dblcount = gcds_code01.CountRow;
    
		//2010.03.31
		hid_banjaeyn.value=gcds_code01.namevalue(gcds_code01.rowposition,"ATDEBTYN"); //반제
	}else{
	    dblcount =1;
	    hid_banjaeyn.value="";
	}
  
	gcem_atcode02.text=p1;
	gcem_atkornam02.text=p2;
	gcem_remark02_1.text=p7;
	gcem_detot02.text=p8;
	gcem_crtot02.text=p9;
	hid_docuval.value=p10;
	gclx_documcd02.bindcolval=p11;
	
	//2010.03.31 jys 세금계산서에서 가져올 경우 계정이 없으면 적용안함.
	//hid_banjaeyn.value=gcds_code01.namevalue(gcds_code01.rowposition,"ATDEBTYN"); //반제
	
	hid_divcd.value=p12;                                                          //본부
	hid_funddiv.value = gcds_code01.namevalue(gcds_code01.rowposition,"FUNDDIV"); //자금구분

	//^^alert("hid_atdebtyn:::"+eval("hid_atdebtyn"+g_row).value);
	g_strbanjae = gcds_code01.namevalue(gcds_code01.rowposition,"ATDEBTYN"); //반제유무

	//2007.05.11 정영식 추가 (세금계산서 데이타 가져올 경우 체크)
	hid_atdecr.value = gcds_code01.namevalue(gcds_code01.rowposition,"ATDECR"); //계정차대구분
	
	for(i=1;i<=dblcount;i++){

	  /**
		//거래처 & 부서 
		txt_vendcd02.value=p3;  
		gcem_vendnm02.text=p4;
		**/
		//20061013 세금계산서 가져올경우 부서 생략함.
		//2015.02.24 세금계산서 가져올경우 부서 가져옴
		txt_deptcd02_1.value=p5;
		gcem_deptnm02_1.text=p6;

		//2010.04.08 jys 추가    	
		if(gcem_atcode02.text=="2100520"){
		  txt_vendcd02.value="I12566";  
		  gcem_vendnm02.text="법인카드공통";
		}else{
			//거래처 & 부서 
		  txt_vendcd02.value=p3;  
		  gcem_vendnm02.text=p4;
		}

 	    hid_lastref.value = 2;
		//관리항목가져오기
		for(k=1;k<=9;k++){
			if(gcds_code01.namevalue(i,"CDNAM"+k)!=undefined&&gcds_code01.namevalue(i,"CDNAM"+k)!=""){
				if(k>=3){
					eval("txt_fsrefnm0"+k).value=gcds_code01.namevalue(i,"CDNAM"+k);
					eval("txt_fsrefcd0"+k).value=gcds_code01.namevalue(i,"CDCODE"+k);

					//관리항목에서 날짜타입의 경우 Format 설정
					ln_Ref_Date_Money_Format(k);
				}
				eval("txt_type0"+k).value=gcds_code01.namevalue(i,"TYPE"+k);
				eval("txt_arbaldiv0"+k).value=gcds_code01.namevalue(i,"ARBALDIV"+k);
				hid_lastref.value = k;
			}else{
				if(k>=3){
					eval("txt_fsrefnm0"+k).value="";
					eval("txt_fsrefcd0"+k).value="";
				}
				eval("txt_type0"+k).value="";
				eval("txt_arbaldiv0"+k).value="";
			}

			if(eval("txt_type0"+k).value=="B"){ //계정이 예산타입이면
				hid_type.value="B";
			}
		}

		//계정관리항목에 예산이 존재할 경우 적용
		if(hid_type.value=="B"){
			gclx_fswrkdiv02.bindcolval="02";
		}else{
      		gclx_fswrkdiv02.bindcolval="01";
		}
		
		txt_fsrefcd01.value='0002';
		txt_fsrefcd02.value='0020';
		
		//세금계산서를 가지고 있고 부서관리항목과 거래처 관리항목이 없을경우
		/****************
		if(p10!=""&&gcds_code01.namevalue(i,"CDCODE1")==undefined&&gcds_code01.namevalue(i,"CDNAM1")==undefined
							&&gcds_code01.namevalue(i,"CDCODE2")==undefined&&gcds_code01.namevalue(i,"CDNAM2")==undefined){
			txt_fsrefcd01.value='0002';
			//eval("txt_fsrefnm"+g_row+j+"1").value='부서코드';
			txt_fsrefcd02.value='0020';
			//eval("txt_fsrefnm"+g_row+j+"2").value='거래처코드';
		}
		******************/

		for(k=3;k<=9;k++){
			//계산서 일자가 존재하는 경우 관리항목에 SETTING함.
			if(eval("txt_fsrefcd0"+k).value=="1048"||eval("txt_fsrefcd0"+k).value=="0970"){
				eval("txt_fsrefval0"+k).value=p13;
			    eval("gcem_fsrvalnm0"+k).text=p13;
				return;
			}
			
			/////////////////////////////////////////////////////////////////////////////////////////
			//선급부가세일 경우 증빙구분으로 세목설정 하기 2014.05.29.JYS 
			if(p1=="1112300"&&eval("txt_fsrefcd0"+k).value=="0998"){ 
				
				if(p11=="101"){ //세금계산서 
					strfsrefval= "03"; 
					strfsrefvalnm="세금계산서";
				}else if(p11=="102"){ //계산서
					strfsrefval= ""; 
					strfsrefvalnm="";
				}else if(p11=="103"){ //신용카드(공제)
					strfsrefval= "04"; 
					strfsrefvalnm="기타부가세";
				}else if(p11=="104"){ //현금영수증(공제)
					strfsrefval= "04"; 
					strfsrefvalnm="기타부가세";
				}else if(p11=="201"||p11=="202"||p11=="203"){ //신용카드(불공)//간주공급//간이영수증
					strfsrefval= ""; 
					strfsrefvalnm="";		
				}
				//증빙코드 넣기 
				eval("txt_fsrefval0"+k).value=strfsrefval;
				eval("gcem_fsrvalnm0"+k).text=strfsrefvalnm;
			}		
			
			//선수부가세일 경우 증빙구분으로 세목설정 하기 2014.05.29.JYS 
			if(p1=="2101100"&&eval("txt_fsrefcd0"+k).value=="1017"){ 
				
				if(p11=="101"){ //세금계산서 
					strfsrefval= "03"; 
					strfsrefvalnm="세금계산서";
				}else{ 
					strfsrefval= ""; 
					strfsrefvalnm="";		
				}
				//증빙코드 넣기 
				eval("txt_fsrefval0"+k).value=strfsrefval;
				eval("gcem_fsrvalnm0"+k).text=strfsrefvalnm;
			}			
           /////////////////////////////////////////////////////////////////////////////////////////
		}
	}//for
}

/******************************************************************************
	Description :  세금계산서 테이블에 접수번호 UPDATE
	parameter   :  p1 - 계산서번호, p2 - 일자 , p3 - 생성자 , p4 fsdat
******************************************************************************/
function ln_Tax_Data_Save(p1, p2, p3, p4){
  //alert("p1::"+p1+"::p2::"+ p2+"::p3::"+ p3+"::p4::"+p4);
	//alert("Countrow" + gcds_tax.Countrow);
	if (gcds_tax.Countrow==0){
		ln_SetDataHeader("TAX");
	}
	gcds_tax.AddRow();
  	gcds_tax.namevalue(gcds_tax.rowposition,"TAXNBR")=p1;
	gcds_tax.namevalue(gcds_tax.rowposition,"FDCODE")=gclx_fdcode02.bindcolval;
	gcds_tax.namevalue(gcds_tax.rowposition,"FSDAT")=p4;
	gcds_tax.namevalue(gcds_tax.rowposition,"FSNBR")="";
	gcds_tax.namevalue(gcds_tax.rowposition,"UPDT")=p2;
	gcds_tax.namevalue(gcds_tax.rowposition,"UPID")=p3;
} 

/******************************************************************************
	Description : 행삭제시 계산서 번호 및 전표 번호 저장 
	parameter   : 
******************************************************************************/
function ln_Tax_Del_Row(row){
	if (gcds_tax_del_row.Countrow==0){
		ln_SetDataHeader("TAX_DEL_ROW");
	}
	gcds_tax_del_row.AddRow();
    gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"TAXNBR")=gcds_dtl.namevalue(row,"DOCUVAL");
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"FDCODE")=gclx_fdcode02.bindcolval;
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"FSDAT")=gcds_dtl.namevalue(row,"FSDAT");
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"FSNBR")=gcds_dtl.namevalue(row,"FSNBR");
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"UPDT")="";
	gcds_tax_del_row.namevalue(gcds_tax_del_row.rowposition,"UPID")="";

} 

/******************************************************************************
	Description :  자동기표일경우 입력된 건은 모두 lock으로 표시함.
	parameter   :  p5 - row : position
******************************************************************************/
function ln_lock(row, gubun){
   
	if(gubun=="1"){ //세금계산서
		if(gclx_documcd02.bindcolval!=""){
			gclx_documcd02.Enable=false;
		}else{
			gclx_documcd02.Enable=true;
		}

		for( k=1;k<=9;k++){
			if(eval("txt_fsrefcd0"+k).value=="0002"){       //부서일경우 변경가능
				txt_deptcd02_1.disabled=false;
        		gcem_deptnm02_1.Enable=true;
			}else if(eval("txt_fsrefcd0"+k).value=="0020"){ //거래처일 경우 데이타가 없으면 변경됨
				if(txt_vendcd02.value!=""){
					if(gcem_atcode02.text=="1112120"){//업무선급금일 경우만 거래처를 막지않음.
					    txt_vendcd02.disabled=false;
					}else{
						txt_vendcd02.disabled=true;
					}
				}else{
					txt_vendcd02.disabled=false;
				}
				if(gcem_vendnm02.text!=""){
				  if(gcem_atcode02.text=="1112120"){//업무선급금일 경우만 거래처를 막지않음.
						gcem_vendnm02.Enable=true;	
					}else{
           			gcem_vendnm02.Enable=false;	
					}
				}else{
					gcem_vendnm02.Enable=true;	
				}
			}else{                                         //부서가 아닐경우 데이타가 없으면 변경됨
			  if(k>=3){
					if(eval("txt_fsrefval0"+k).value!=""){
						eval("txt_fsrefval0"+k).disabled=true;
					}else{
						eval("txt_fsrefval0"+k).disabled=false;
					}
						
					if(eval("gcem_fsrvalnm0"+k).text!=""){
						eval("gcem_fsrvalnm0"+k).Enable=false;	
					}else{
						eval("gcem_fsrvalnm0"+k).Enable=true;	
					}
				}
			}
		}//for
	}else{//6반제
		if(gcem_atcode02.text!="") {
			gcem_atcode02.Enable=false;
		}else{
			gcem_atcode02.Enable=true;
		}

		if(gcem_atkornam02.text!=""){
			gcem_atkornam02.Enable=false;
		}else{
			gcem_atkornam02.Enable=true;
		}

		if(gcem_detot02.text!="") {
			gcem_detot02.Enable=false;
		}else{
			gcem_detot02.Enable=true;
		}

		if(gcem_crtot02.text!=""){
			gcem_crtot02.Enable=false;
		}else{
			gcem_crtot02.Enable=true;
		}

		if(gclx_documcd02.bindcolval!=""&&gclx_documcd02.bindcolval!="000"){
			gclx_documcd02.Enable=false;
		}else{
			gclx_documcd02.Enable=true;
		}

		if(gcem_remark02_1.text!="") {
			gcem_remark02_1.Enable=false;
		}else{
			gcem_remark02_1.Enable=true;
		}

		if(gclx_fswrkdiv02.bindcolval!=""){
			gclx_fswrkdiv02.enalbe=false;
		}else{
		
		}

		for( k=1;k<=9;j++){
			if(eval("txt_fsrefcd0"+k).value=="0002"){       //부서일 경우 데이타가 없으면 변경됨
				if(txt_deptcd02_1.value!=""){
					txt_deptcd02_1.disabled=true;
				}else{
					txt_deptcd02_1.disabled=false;
				}
				if(gcem_deptnm02_1.text!=""){
					gcem_deptnm02_1.Enable=false;	
				}else{
					gcem_deptnm02_1.Enable=true;	
				}
			}else if(eval("txt_fsrefcd0"+k).value=="0020"){ //거래처일 경우 데이타가 없으면 변경됨
				if(txt_vendcd02.value!=""){
					txt_vendcd02.value.disabled=true;
				}else{
					txt_vendcd02.value.disabled=false;
				}
				if(gcem_vendnm02.text!=""){
					gcem_vendnm02.Enable=false;	
				}else{
					gcem_vendnm02.Enable=true;	
				}
			}else{                                         //부서가 아닐경우 데이타가 없으면 변경됨
				if(k>=3){
					if(eval("txt_fsrefval0"+k).value!=""){
						eval("txt_fsrefval0"+k).disabled=true;
					}else{
						eval("txt_fsrefval0"+k).disabled=false;
					}

					if(eval("gcem_fsrvalnm0"+k).text!=""){
						eval("gcem_fsrvalnm0"+k).Enable=false;	
					}else{
						eval("gcem_fsrvalnm0"+k).Enable=true;	
					}
				}
			}
		}//for
	}//if gubun
}

/******************************************************************************
	Description : 전체등로시 Lock 해제
******************************************************************************/
function ln_Lock_false(){
 
	gcem_atcode02.Enable=true;
	gcem_atkornam02.Enable=true;
	gcem_detot02.Enable=true;
	gcem_crtot02.Enable=true;
	gclx_documcd02.Enable=true;
	gcem_remark02_1.Enable=true;
	gclx_fswrkdiv02.Enable=false;
	gcem_deptnm02_1.Enable=true;	
	for (k=3;k<=9;k++){
		eval("gcem_fsrvalnm0"+k).Enable=true;	
	}
}
/******************************************************************************
	Description : 예산타입 설정
******************************************************************************/
function ln_Fswrkdiv_Setting(){
		
	var stratcode = gcem_atcode02.text;
	stratcode = stratcode.substring(0,2);
	
	if (stratcode =="43"){ //매출원가 계정 - 예산타입 풀어놓음. 
		//금강산은 예외처리 2007.05.19 정영식
		if(gclx_fdcode02.bindcolval=="03"||gclx_fdcode02.bindcolval=="04"){
			gclx_fswrkdiv02.enable = false;
		}else{
			gclx_fswrkdiv02.enable = true;
		}
	}else{
    	gclx_fswrkdiv02.enable = false;
	}

	for(f=3;f<=9;f++){
	
		if (eval("txt_fsrefcd0"+f).value=="0003"){	
		    //금강산은 예외처리 2007.05.19 정영식
			if(gclx_fdcode02.bindcolval=="03"||gclx_fdcode02.bindcolval=="04"){
        		gclx_fswrkdiv02.bindcolval="01";
			}else{
				if (stratcode =="43"){ //매출원가 계정 - 예산타입 풀어놓음. 
					//2015.05.22 jys - 김인호 대리 요청
					gclx_fswrkdiv02.bindcolval="01"; 
				}else{
					gclx_fswrkdiv02.bindcolval="02";	
				}
				
			}
			return;
			break;
		} 
	}
  gclx_fswrkdiv02.bindcolval="01";
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 체크항목 (Start:::::::::::::::::::::::>>>>>
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/******************************************************************************
	Description : 체크
	parameter   : p1-구분
******************************************************************************/
function ln_Chk(p1){

  if(gclx_fsstat02.bindcolval=="Y"){
		alert("결재완료된 전표입니다.");
		return false;
	}

	if (p1=="02"){
		//차변대변 동일 확인
		if(gcem_detot02.text!=gcem_crtot02.text){
			alert("차변합계와 대변합계가 같지 않습니다.");
			return false;
		}
		return true; 
	}
}
/******************************************************************************
	Description : 저장체크
	parameter   : p1-구분
******************************************************************************/
function ln_Chk_Save(){
    var no1="";
	var no2="";
    var stryymmdd="";
    var stryyyy = "";
	var strmm = "";
	var	strbgtdept= "";
	var	strbgtdiv ="";
	var	stratcode ="";
	var dblamt=0;
	var strBanjaechk="";
	var m=0;
	var strDelChk="";

	stryymmdd = gcem_actdat02.text;

	//자동전표 체크///////////////////////////////////////////////////////////////
    //건설ERP에서 생성된 건은 수정불가 FSKND ='J' 
    //2015.09.01 
    if(gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSKND")=="J") {
    	alert("해당 전표는 건설ERP에서 자동생성된 전표입니다. 수정 불가입니다.");
		return false;
    }
	///////////////////////////////////////////////////////////////////////////

	if(gcds_dtl.countrow<2){
		alert("저장할 수 없습니다.");
		return false;
	}

	//마감체크
	if(gf_Dept_Enable(gs_deptcd,gcds_dept2)){ // 회계부서 전표마감 체크
		 ln_Slip_Close_Query();
		 if(gcds_slip_close.namevalue(gcds_slip_close.rowposition,"SLPCLOSE")=="T"){
				alert("전표 입력이 마감되었습니다. 확인 바랍니다.");
				return false;
		 }
	}else{                                    // 현업전표마감 체크
		 ln_Slip_Close_Query();
		 if(gcds_slip_close.namevalue(gcds_slip_close.rowposition,"WORKCLOSE")=="T"){
				alert("현업 전표 입력이 마감되었습니다. 확인 바랍니다.");
				return false;
		 }
	}

	/*&&&&&&&&&&&&&&
	if(gcds_tax.countrow>0){
		if(g_taxval!=parent.gcem_detot02.text){
			alert("세금계산서금액과 전표금액이 일치하지 않습니다.");
		}
	}
	&&&&&&&&&&&&&&&*/

	//로그인한 사람과 담당자 사번이 같이 않으면 수정 및 저장 못함.
	//alert("gs_userid!"+gs_userid+"txt_empno02.value)"+txt_empno02.value);
    if(gs_userid!=txt_empno02.value){
		alert("작성자와 동일하지 않습니다.");
		return false;
	}else{
		if(gs_userid==""||gs_userid==undefined){
			alert("작성자를 확인하십시요.");
			return false;
		}
	}

	if(gclx_fdcode02.bindcolval==""){
		alert("지점을 선택하십시요.");
		return false;
	}

	if(gclx_fsstat02.bindcolval=="Y"){
		alert("결재완료된 전표입니다.");
		return false;
	}

    if(gclx_fsstat02.bindcolval=="R"){
		alert("결재요청된 전표입니다.");
		return false;
	}

	if(gclx_fsstat02.bindcolval=="C"){
		alert("결재취소된 전표입니다.");
		return false;
	}
  
	if(gcem_fs02.text==""||gcem_fsdat02.text==""){
		alert("접수번호를 확인하십시요.");
		return false;
	}
	
	//차변대변 동일 확인
	if(gcds_dtl.Sum(9,0,0)!=gcds_dtl.Sum(10,0,0)){
		alert("차변합계와 대변합계가 같지 않습니다.");
		return false;
	}

  //DataSet 건별로 체크하기 
	for(i=1;i<=gcds_dtl.countrow;i++){
    //순번만 존재하는 경우는 무시하고 입력되게함.
		if(gcds_dtl.namevalue(i,"FSNUM")!=""&&gcds_dtl.namevalue(i,"ATCODE")==""&&gcds_dtl.namevalue(i,"ATKORNAM")==""&&
		   gcds_dtl.namevalue(i,"CHAAMT")==0&&gcds_dtl.namevalue(i,"DAEAMT")==0){
			 //alert("step1");
			 return true;
		}
	  
    /////////////////////////////////////// 
    //필수항목체크
    /////////////////////////////////////// 
		if(gcds_dtl.namevalue(i,"ATCODE")==""){
		  gcds_dtl.rowposition = i;
			alert("계정코드를 입력하십시요");
			gcem_atcode02.Focus();
			return false;
		}

		if(gcds_dtl.namevalue(i,"ATKORNAM")==""){
		  gcds_dtl.rowposition = i;
			alert("계정명을 입력하십시요");
			gcem_atkornam02.Focus();
			return false;
		}

		if(gcds_dtl.namevalue(i,"CHAAMT")==0&&gcds_dtl.namevalue(i,"DAEAMT")==0){
			gcds_dtl.rowposition = i;
			alert("금액을 입력하십시요");
			gcem_detot02.Focus();
			return false;
		}

		if(gcds_dtl.namevalue(i,"CHAAMT")!=0&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
			gcds_dtl.rowposition = i;
			alert("차변금액과 대변금액을 확인 하십시요");
			gcem_detot02.Focus();
			return false;
		}

		if(gcds_dtl.namevalue(i,"DOCUMCD")=="101"||gcds_dtl.namevalue(i,"DOCUMCD")=="102"||gcds_dtl.namevalue(i,"DOCUMCD")=="103"||gcds_dtl.namevalue(i,"DOCUMCD")=="104"){
			if(gcds_dtl.namevalue(i,"DOCUVAL")==""){
				gcds_dtl.rowposition = i;
				alert("증빙번호가 없습니다. 확인하십시요");
				return false;
			}
		}
		
		//2017.03.03.JYS 채권(가)압류 업체 체크로직반영
		//alert(i+"::CREDGB::"+gcds_dtl.namevalue(i,"CREDGB")+"::::"+gcds_dtl.namevalue(i,"FSREFVAL02"));
		if(gcds_dtl.namevalue(i,"CREDGB")=="1"||gcds_dtl.namevalue(i,"CREDGB")=="2"){
			if(!ln_Bond_Attach_Chk(gcds_dtl.namevalue(i,"FSREFVAL02"),i)){
				return false;
			}
		}
		
		//2015.02.26 JYS (오연주 요청) dhl
		//외상매입금, 미지급금의 일반업체 의 반제 발생인 경우 증빙명 필수 - 계산서 번호 확인
		///////////////////////////////////////////////////////////////////////////////////////////////////////
		if(chkbox_1.checked==false){
		
			//외상매입금 발생전표
			if(gcds_dtl.namevalue(i,"ATCODE")=="2100110"&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
		    	m=0;
				for(k=3;k<=9;k++){
					if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1011"&&gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="02"){
		        
						if(gcds_dtl.namevalue(i,"DOCUVAL")==""){
							gcds_dtl.rowposition = i;
							alert("외상매입금 일반업체는 증빙번호가 필수항목니다.확인하십시요2");
							return false;
						}
				    }
		    	}
		    }
			
			
			//미지급금 발생전표 
			if(gcds_dtl.namevalue(i,"ATCODE")=="2100510"&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
			   	m=0;
				for(k=3;k<=9;k++){
					if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1013"&&gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="008"){
			       
						if(gcds_dtl.namevalue(i,"DOCUVAL")==""){
							gcds_dtl.rowposition = i;
							alert("미지급금 일반업체는 증빙번호가 필수항목입니다. 확인하십시요2");
							return false;
						}
				   }
			   	}
			}
		}
		
	   //2015.09.01. JYS ( 매출원가/접대비의 경우 세목과 증빙 CLOSS 체크)  이예빈 ////////////////////////
	   if(gcds_dtl.namevalue(i,"ATCODE")=="4331700"){
		   	m=0;
			for(k=3;k<=9;k++){
				if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1103"){
					if(gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="002"){ // 계산서
						if(gcds_dtl.namevalue(i,"DOCUMCD")!="102"){ //증빙이 계산서가 아니면 체크 
							alert("증빙명과  접대비구분을 확인하십시요1.");
							return false;
						}
					}else if(gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="002"){ // 세금계산서 
						if(gcds_dtl.namevalue(i,"DOCUMCD")!="101"){ //증빙이 세금계산서가 아니면 체크 
							alert("증빙명과  접대비구분을 확인하십시요2.");
							return false;
						}
					}
				 }
			 }	   	
		}	
	   ///////////////////////////////////////////////////////////////////////////////////////
	   
		
	   //2015.06.22. JYS ( 전표수기 등록시 외상매입금, 미지급금 일반업체는 정산 못하게 막음.)
	   
	   //저장 시점에서 선급부가세, 선수부가세가 아닌경우
	   //외상매입금, 미지급금의 일반업체 의 반제 발생이 아닌 경우는 증빙 및 증빙값 모두 삭제함.
	   /**
	   if(gcds_dtl.namevalue(i,"DOCUVAL")!=""){
		   if(gcds_dtl.namevalue(i,"ATCODE")!="1112300"&&gcds_dtl.namevalue(i,"ATCODE")!="2101100"){
			   
			   if(gcds_dtl.namevalue(i,"ATCODE")=="2100510"&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
				   
				   m=0;
				   for(k=3;k<=9;k++){
					   if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1013"&&gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="008"){
						   strDelChk="1";
					   }
					   
					   if(strDelChk!="1"){
						   gcds_dtl.namevalue(i,"DOCUVAL")="";
						   gcds_dtl.namevalue(i,"DOCUMCD")="000";
						   strDelChk="";
					   }
				   }	   
				   
			   }else if(gcds_dtl.namevalue(i,"ATCODE")=="2100110"&&gcds_dtl.namevalue(i,"DAEAMT")!=0){
				   m=0;
				   for(k=3;k<=9;k++){
					   if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1011"&&gcds_dtl.namevalue(i,"FSREFVAL0"+k)=="02"){
						   strDelChk="2";
					   }
					   if(strDelChk!="2"){
						   gcds_dtl.namevalue(i,"DOCUVAL")="";
						   gcds_dtl.namevalue(i,"DOCUMCD")="000";
						   strDelChk="";
					   }
				   }	   
			   }else{
				   gcds_dtl.namevalue(i,"DOCUVAL")="";
				   gcds_dtl.namevalue(i,"DOCUMCD")="000";
			   }
		   
		   }else{
			   
		   }
	   }else{
		   
	   }
	   **/
	   
	   ///////////////////////////////////////////////////////////////////////////////////////////////////////
		
		
		
     //선수부가세임시20070423
	 /*
    	//계정이 선급부가가치세 차변인경우 세금계산서가 없으면 저장안됨.
		//대변에 입력 될 경우는 체크 안함.
		if(gcds_dtl.namevalue(i,"ATCODE")=="1112300"){
		  if(gcds_dtl.namevalue(i,"CHAAMT")!=0){
				if((gcds_dtl.namevalue(i,"DOCUMCD")=="101"||gcds_dtl.namevalue(i,"DOCUMCD")=="102"||gcds_dtl.namevalue(i,"DOCUMCD")=="103")&&gcds_dtl.namevalue(i,"DOCUVAL")!=""){
				}else{
					gcds_dtl.rowposition = i;
					alert("해당계정은 세금계산서가 존재해야 합니다.");
					return false;
				}
			}
		}
		//계정이 선수부가가치세 대변인경우 세금계산서가 없으면 저장안됨.
		//차변에 입력 될 경우는 체크 안함.



	 if(gcds_dtl.namevalue(i,"ATCODE")=="2101100"){
		  if(gcds_dtl.namevalue(i,"DAEAMT")!=0){
				if((gcds_dtl.namevalue(i,"DOCUMCD")=="101"||gcds_dtl.namevalue(i,"DOCUMCD")=="102"||gcds_dtl.namevalue(i,"DOCUMCD")=="103")&&gcds_dtl.namevalue(i,"DOCUVAL")!=""){
				}else{
					gcds_dtl.rowposition = i;
					alert("해당계정은 세금계산서가 존재해야 합니다.");
					return false;
				}
			}
		}
 */
		//거래처
		if(gcds_dtl.namevalue(i,"ARBALDIV02")=="N"&&(gcds_dtl.namevalue(i,"FSREFVAL02")==""||gcds_dtl.namevalue(i,"FSRVALNM02")=="")){
			gcds_dtl.rowposition = i;
			alert("거래처는 필수항목입니다.");
			gcem_vendnm02.focus(); 
			return false;
		}

		//부서 
		if(gcds_dtl.namevalue(i,"ARBALDIV01")=="N"&&(gcds_dtl.namevalue(i,"FSREFVAL01")==""||gcds_dtl.namevalue(i,"FSRVALNM01")=="")){
			gcds_dtl.rowposition = i;
			alert("부서는 필수항목입니다.");
			gcem_deptnm02_1.focus(); 
			return false;
		}

		//적요
		if(gcds_dtl.namevalue(i,"REMARK")==""){
			gcds_dtl.rowposition = i;
			alert("적요을 입력하십시요");
			gcem_remark02_1.focus();
			return false;
		}

		//관리항목체크
		m=0;
		for(k=3;k<=9;k++){
			if(gcds_dtl.namevalue(i,"ARBALDIV0"+k)=="N"&&(gcds_dtl.namevalue(i,"FSREFVAL0"+k)==""||gcds_dtl.namevalue(i,"FSRVALNM0"+k)=="")){
				//관리항목 (FDREFCD)에  예산부서(0003)이 존재하지만 
				//예산이 미적용인 경우는 필수항목에서 제외함(매출원가의경우)
				if(gcds_dtl.namevalue(i,"FSWRKDIV")=="01"){
					no1 = ln_Bgt_DataSet_Dept_find(i);  //예산부서 찾기0003
					if(no1==""||no1==undefined){                                 //예산부서 미존재
						tempnm = gcds_dtl.namevalue(i,"FSREFNM0"+k);
						alert("관리항목 "+tempnm+"는 필수항목입니다.");
						m=k;
						gcds_dtl.rowposition = i;
						eval("gcem_fsrvalnm0"+m).focus(); 
						return false;
					}else{ //예산부서 존재시 예산부서만 제외하고 필수항목체크
						if(gcds_dtl.namevalue(i,"FSREFCD0"+k)!="0003"){
							tempnm = gcds_dtl.namevalue(i,"FSREFNM0"+k);
							m=k;
							alert("관리항목 "+tempnm+"는 필수항목입니다.");
							gcds_dtl.rowposition = i;
							eval("gcem_fsrvalnm0"+m).focus(); 
							return false;
						}
					}
				}else{
				  m=k;
					tempnm = gcds_dtl.namevalue(i,"FSREFNM0"+k);
					alert("관리항목 "+tempnm+"는 필수항목입니다.");
					gcds_dtl.rowposition = i;
					eval("gcem_fsrvalnm0"+m).focus(); 
					return false;
				}
			}
		}//for k

		//날짜체크
		var strReturn="";
		m=0;
		for(k=3;k<=9;k++){
		  if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="0966"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="0968"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="0969"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="0970"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1044"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1048"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1051"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1052"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1053"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1089"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1098"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1099"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1125"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1126"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1127"||
			 gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1130"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1206"||gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1185"){
        
				if(gcds_dtl.namevalue(i,"FSREFCD0"+k)!=""&&gcds_dtl.namevalue(i,"FSREFCD0"+k)!=undefined){
					strReturn= gf_ChkNumber2(gcds_dtl.namevalue(i,"FSREFVAL0"+k));
					if(strReturn==false){
					  m=k;
					  gcds_dtl.rowposition = i;
						eval("gcem_fsrvalnm0"+m).focus();
						return false;
					}
				}
		   }
		  
		  	 //2012.11.05 JYS 외화 금액이존재 할 경우  콤마는 입력 불가 ////////////////////////////
			if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1045"){  //외화금액일경우
			    strReturn = gcds_dtl.namevalue(i,"FSREFVAL0"+k);
			    
			    //2016.04.05.jys 외환금액  기본값 반영
			    if (strReturn=="-"){
			    	alert("외화금액에는 숫자만 입력하십시요.");
			    	return false;
			    }else if (fn_trim(strReturn)==""){
			    	alert("외화금액이 공백입니다.");
			        return false;
			    }
			    
			    if(parseInt(strReturn)>=0){
			    	
			    	//2016.09.20 jys 현금시제관련 현금(외화)계정은 항상 >0 함.
			    	if(gcds_dtl.namevalue(i,"ATCODE")=="1110120"&&parseInt(strReturn)==0){
			    		alert("현금(외화) 계정은 외화금액이 0 보다 크야 합니다.");
			    		return false;
			    	}
			    	
			    }else if(parseInt(strReturn)<0) {

			    }else{
			    	
			    	if(gs_userid=="2110017"){
			    		//alert("::::"+strReturn+"::::");
			    	}
			    	
			    	alert("외화금액이 숫자 타입이 아닙니다. 확인 바랍니다.");
			    	return false;
			    }
			    
			  
				for(var n=0;n<strReturn.length;n++){
					if(strReturn.charAt(n)==","){
					    m=k;
					    gcds_dtl.rowposition = i;
						eval("gcem_fsrvalnm0"+m).focus();
						alert("외화금액에 콤마를 제외하세요.");
						return false;
					}
				}
			}
			///////////////////////////////////////////////////////////////////////////////////////////
         }//for k                        

		//==================================================================
		//금강산일 경우 관리항목이 외화금액일 경우 체크함.
		//==================================================================
		//2007.05.09 체크방법 변경 
	  //기존 : 계정코드 하드코딩 ==> 변경 : ACTCODE 테이블의 ATCURTYPE이 Y인 건을 체크함.
		var stratcode=gcds_dtl.namevalue(i,"ATCODE");
		stratcode=stratcode.substring(0,3);
		if(gclx_fdcode02.bindcolval=="03"){
			for(b=3;b<=9;b++){
				//if(gcds_dtl.namevalue(i,"ATCODE")=="1112200"||gcds_dtl.namevalue(i,"ATCODE")=="2101000"||stratcode=="112"||stratcode=="122"||stratcode=="123"){
				if(gcds_dtl.namevalue(i,"ATCURTYPE")=="Y"){
					if(gcds_dtl.namevalue(i,"FSREFCD0"+b)=="1045"){  //외화금액일경우(금강산은 외화가 금액임)
						if((gcds_dtl.namevalue(i,"FSREFVAL0"+b)==""||gcds_dtl.namevalue(i,"FSRVALNM0"+b)=="")||
							 (gcds_dtl.namevalue(i,"FSREFVAL0"+b)=="0"||gcds_dtl.namevalue(i,"FSRVALNM0"+b)=="0")||
							 (gcds_dtl.namevalue(i,"FSREFVAL0"+b)=="-"||gcds_dtl.namevalue(i,"FSRVALNM0"+b)=="-")){
							alert("외화금액란에 금액을 입력하십시요.");
							gcds_dtl.rowposition = i;
							eval("gcem_fsrvalnm0"+b).focus(); 
							return false;
						}else{				  
							if(!gf_ChkNumber3(gcds_dtl.namevalue(i,"FSRVALNM0"+b))){
								gcds_dtl.rowposition = i;
								eval("gcem_fsrvalnm0"+b).focus(); 
								return false;
							}
						}
					}
				}
			}//for
		}//03


		/////////////////////////////////////// 
    //예산체크
    /////////////////////////////////////// 
		//예산타입체크
		if(gcds_dtl.namevalue(i,"FSWRKDIV")=="02"){
			strbgtdept="";
			strbgtdiv="";
			stratcode="";
			strrefcd="";
			strrefval="";
			dblamt=0;
			no1="";
			no2="";

			no1 = ln_Bgt_DataSet_Dept_find(i);                 //예산부서 찾기
			no2 = ln_Bgt_DataSet_Type_find(i);                 //세목위치 찾기  
							
			if(no1==""||no1==undefined){
				alert("예산부서가 존재하지 않습니다.");
				return false;
			}

			if(no2==""||no2==undefined){
				alert("예산적용 타입이 존재하지 않습니다.");
				return false;
			}

			//예산부서가 예산관리항목인 경우 세목은 00로 설정
			if(gcds_dtl.namevalue(i,"FSREFCD"+no2)=="0003"){
				strrefcd = gcds_dtl.namevalue(i,"FSREFCD"+no2);
				strrefval="00";	                                //세목  
			}else{
				strrefcd =gcds_dtl.namevalue(i,"FSREFCD"+no2);
				strrefval=gcds_dtl.namevalue(i,"FSREFVAL"+no2); //세목    
			}

			//2007.10.18 정영식 추가
			//회계일자만 변경할 경우 DTL데이타 강제수정함.
			gcds_dtl.namevalue(i,"REMARK")=gcds_dtl.namevalue(i,"REMARK")+" ";
			
			strmm = fn_trim(stryymmdd.substring(4,6));
			stryyyy = fn_trim(stryymmdd.substring(0,4));
			strbgtdept= gcds_dtl.namevalue(i,"FSREFVAL"+no1); //예산부서
			strbgtdiv = gcds_dtl.namevalue(i,"BGTDIV");       //예산본부  
			stratcode = gcds_dtl.namevalue(i,"ATCODE");       //계정과목   
			dblamt = Number(gcds_dtl.namevalue(i,"CHAAMT"))+Number(gcds_dtl.namevalue(i,"DAEAMT")); 
			
			//2014.07.17.jys - 정상원 김용민 채지수 요청으로 예산 체크안함.
	        /***				
			ln_Bgt_Query(stryyyy,strbgtdiv,strbgtdept,stratcode,strrefcd,strrefval,strmm,'02',i);
			
			if(gcds_bgt.countrow>=1){  //
				//alert("JANAMT::"+gcds_bgt.namevalue(gcds_bgt.rowposition,"JANAMT"));
				if(gcds_dtl.SysStatus(i)==1){ //신규입력
					if(gcds_bgt.namevalue(gcds_bgt.rowposition,"JANAMT")< dblamt){
						gcds_dtl.rowposition = i;
						alert("예산잔액이 더 작습니다. 확인 바랍니다.");
						return false;
					}
				}else if(gcds_dtl.SysStatus(i)==3){//수정
				  //잔액+수정전금액 < 수정금액==>수정불가능
					if(gcds_bgt.namevalue(gcds_bgt.rowposition,"JANAMT")+gcds_dtl.OrgNameValue(i,"CHAAMT")+gcds_dtl.OrgNameValue(i,"DAEAMT")<dblamt){
						gcds_dtl.rowposition = i;
						alert("예산잔액이 더 작습니다. 확인 바랍니다.");
						return false;
					}
				}
			}else{
				gcds_dtl.rowposition=i;
				alert("예산이 없습니다.");
				ln_Bgt_Amt_Clear();
				return false;
			}
			***/
			
		}//if 예산

		////////////////////////////////////////////////// 
        //반제체크
		//참조:
		//전체저장시 해당 계정에 대해서 발생이 
		//아닌 정산일 경우 반제로 입력하지 않으면
		//체크함.

		//추가 수정 :
		//반제수정 가능하게 함.

		//추가 수정 : 2010.06.15 김양묵 GJ 요청 
		//반제 발생의 경우 (-) 금액 입력불가 

		//예외처리 : 김양묵 GJ 만 입력가능 ( 김양묵GJ 요청 2011.01.19
        ///////////////////////////////////////////////// 
		//반제데이타 체크(반제계정이면서,
		strBanjanChkAmt=0;
		if(gcds_dtl.namevalue(i,"BANJAEYN")=="Y"){ //반제
			 
			 if(gs_userid!="2060006"&&gs_userid!="6180021"&&gs_userid!="2140004"&&gs_userid!="2080044"){
				 //////////////////////////////////////////////////////////////////
				 //2010.06.15
				 if(gcds_dtl.namevalue(i,"ATDECR")=="1"){ //차변
						if(gcds_dtl.namevalue(i,"CHAAMT")<0){
							alert("해당 반제 발생은 (-) 금액 입력 불가합니다. all ");
							gcds_dtl.rowposition = i;
							return false;
						}
				 }else if(gcds_dtl.namevalue(i,"ATDECR")=="2"){ //대변
						if(gcds_dtl.namevalue(i,"DAEAMT")<0){
							alert("해당 반제 발생은 (-) 금액 입력 불가합니다. all ");
							gcds_dtl.rowposition = i;
							return false;
						}
				 }
				 //////////////////////////////////////////////////////////////////
			 }
	 

			if(gcds_dtl.namevalue(i,"BANJAEMOD")=="Y"){//반제수정건은 모두 수정 가능함.
			   //반제금액과 현재 금액 비교함. 
				 if(gcds_dtl.namevalue(i,"ATDECR")=="1"){ //차변
					 if(!ln_Banjae_Data_Delete(i,'1')){
								gcds_dtl.rowposition = i;
								return false;
					 };
				 }else if(gcds_dtl.namevalue(i,"ATDECR")=="2"){	
						if(!ln_Banjae_Data_Delete(i,'2')){
						  gcds_dtl.rowposition = i;
							return false;
						}
				 }
			}else{ // 일반 반제건은 처음금액과 수정금액이 동일한 경우만 수정 가능함.
				if(gcds_dtl.namevalue(i,"ATDECR")=="1"){ //차변
					if(gcds_dtl.OrgNameValue(i,"DAEAMT")!=gcds_dtl.namevalue(i,"DAEAMT")){
						if(gcds_dtl.namevalue(i,"DAEAMT")!=0&&gcds_dtl.namevalue(i,"DAEAMT")!=""){
							//반제 연결에 순번이 존재하지 않으면
								for(b=1;b<=gcds_banjae.countrow;b++){
									if(gcds_dtl.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
										strBanjaechk="T";
										break;
									}
								}//for

								if(strBanjaechk!="T"){
									gcds_dtl.rowposition = i;
									alert("반제계정입니다. 확인 바랍니다.");	
									return false;
								}else{
									strBanjaechk="";
								}
						}
					}else{//금액이 동일한 경우(신규입력일땐 똑같음 if(gcds_dtl.OrgNameValue(i,"DAEAMT")!=gcds_dtl.namevalue(i,"DAEAMT")){
						//반제금액과 현재 금액 비교함.
						if(gcds_dtl.SysStatus(i)==1){ //신규입력건
							if(!ln_Banjae_Data_Delete(i,'1')){
								gcds_dtl.rowposition = i;
								return false;
							};
						}
					}
				}else if(gcds_dtl.namevalue(i,"ATDECR")=="2"){
					if(gcds_dtl.OrgNameValue(i,"CHAAMT")!=gcds_dtl.namevalue(i,"CHAAMT")){
						if(gcds_dtl.namevalue(i,"CHAAMT")!=0&&gcds_dtl.namevalue(i,"CHAAMT")!=""){
							//반제 연결에 순번이 존재하지 않으면
							for(b=1;b<=gcds_banjae.countrow;b++){
								if(gcds_dtl.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
									strBanjaechk="T";
									break;
								}
							}
							if(strBanjaechk!="T"){
								gcds_dtl.rowposition = i;
								alert("반제계정입니다. 확인 바랍니다.");	
								return false;
							}else{
								strBanjaechk="";
							}
						}
					}else{//금액이 동일한 경우(신규입력일땐 똑같음 //if(gcds_dtl.OrgNameValue(i,"CHAAMT")!=gcds_dtl.namevalue(i,"CHAAMT")){
						//반제금액과 현재 금액 비교함.
						if(gcds_dtl.SysStatus(i)==1){ //신규입력건
							if(!ln_Banjae_Data_Delete(i,'2')){
								gcds_dtl.rowposition = i;
								return false;
							}
						}
					}
				}
			} //if(gcds_dtl.namevalue(row,"BANJAEMOD")=="Y"){//반제수정건
		}//if(gcds_dtl.namevalue(i,"BANJAEYN")=="Y"){ //반제

    //2008.05.17. 정영식 추가 ///////////////////////////////////////////////////////////////////////////////////////////////////
		//계정코드 : 개성지점, 금강산지점일 경우 담당부서가 자재구매팀일 경우 구매품의번호를 체크한다.
		//음...신규건만 체크한다. 수정건은 어떻게 할 도리가 없군.
		if(gcds_dtl.namevalue(i,"ATCODE")=="1250000"||gcds_dtl.namevalue(i,"ATCODE")=="1260000" ){ //금강산지점 개성지점 
			if(txt_deptcd02.value=="C320" ){ //전표작성부서가 구매자재팀일 경우  ***********************************************여긴 조직 변경때마다 바꿔줘야함.
				for(k=3;k<=9;k++){
					if(gcds_dtl.namevalue(i,"FSREFCD0"+k)=="1241"){ //구매품의번호
					   //alert("i::::"+i+":::::체크5"+"k::::"+k+"::::::::"+gcds_dtl.namevalue(i,"FSRVALNM0"+k));
						 if(fn_trim(gcds_dtl.namevalue(i,"FSRVALNM0"+k))==""||fn_trim(gcds_dtl.namevalue(i,"FSRVALNM0"+k))=="-"||fn_trim(gcds_dtl.namevalue(i,"FSRVALNM0"+k))=="0"){
								alert("구매품의번호는 꼭 입력하셔야 합니다.");
								gcds_dtl.rowposition = i;
								return false;
						 }else{
						    if(gcds_dtl.SysStatus(i)==1){ //신규건만 체크
 								  if(!ln_Buy_No_Find(gcds_dtl.namevalue(i,"FDCODE"),gcds_dtl.namevalue(i,"ATCODE"),gcds_dtl.namevalue(i,"FSRVALNM0"+k))){
										 gcds_dtl.rowposition = i;
										 return false;
									}
								}
						 }
					}
				}//for k                     
			}
		}
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    //2011.11.21. jys -  신용카드(공제), 현금영수증(공제) 일 경우
		//선급부가가치세가 기타부가세가 아니면 체크 
		if(gcds_dtl.namevalue(i,"DOCUMCD")=="103"||gcds_dtl.namevalue(i,"DOCUMCD")=="104" ){ 
			for(var x=3;x<=9;x++){
				if(gcds_dtl.namevalue(i,"FSREFCD0"+x)=="0998"){ //선급부가가치세
					if(gcds_dtl.namevalue(i,"FSREFVAL0"+x)!="04"){
					    gcds_dtl.rowposition = i;
						alert("증빙명이 신용카드(공제), 현금영수증(공제)일 경우 선급부가가치세 항목은 기타부가세입니다. ");
						return false;
					}
				}
			}
		}
     //////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    

    //2007.05.11 정영식 추가 : 전표 MST와 DTL 전표번호 체크
    var mstfsdat = gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSDAT1")+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSDAT2") ; 
		//alert("FDCODE::"+gcds_dtl.namevalue(i,"FDCODE")+":"+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE"));
		//alert("FSDAT::"+gcds_dtl.namevalue(i,"FSDAT")+":"+mstfsdat);
		//alert("FSNBR::"+gcds_dtl.namevalue(i,"FSNBR")+":"+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSNBR"));
    if(gcds_dtl.namevalue(i,"FDCODE")==gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE")&&
		   gcds_dtl.namevalue(i,"FSDAT")==mstfsdat &&
			 gcds_dtl.namevalue(i,"FSNBR")==gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSNBR")){
		}else{
			alert("접수번호가 틀립니다.");
			alert("i:::"+i+":::gcds_dtl:::"+gcds_dtl.namevalue(i,"FDCODE")+gcds_dtl.namevalue(i,"FSDAT")+gcds_dtl.namevalue(i,"FSNBR")+":::::mst::"+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE")+mstfsdat+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSNBR"));
			
			if(gusrid=="6070001"){
				alert("i:::"+i+":::gcds_dtl:::"+gcds_dtl.namevalue(i,"FDCODE")+gcds_dtl.namevalue(i,"FSDAT")+gcds_dtl.namevalue(i,"FSNBR")+":::::mst::"+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE")+mstfsdat+gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSNBR"));
			}

			return false;
		}
	}//for i
	return true;
}

/******************************************************************************
	Description : 팝업체크
	parameter   : p1-현재 관리항목 위치
******************************************************************************/
function ln_Chk_Popup(p1){
	//받을어음 & 차변<>0 & 대변 = 0 (발생 ==> 입력)
	//어음번호, 어음 만기일, 어음 발생일은 입력해야함. 팝업없음. 
	if(p1>2){
		if(hid_funddiv.value=="50"&& gcem_detot02.text!=0 && gcem_crtot02.text==0){
			if(eval("txt_fsrefcd0"+p1).value=="0967"||eval("txt_fsrefcd0"+p1).value=="0968"||eval("txt_fsrefcd0"+p1).value=="0969"){
				return false;
			}
		}else{

		}
	}

	//관리항목코드가 없는 경우 return
  if(eval("txt_fsrefcd0"+p1).value=="") return false;

  //어음번호이면서 차변대변이 모두 0일경우는 금액을 체크해야함.
	if(eval("txt_fsrefcd0"+p1).value=="0967"&&gcem_detot02.text==0 && gcem_crtot02.text==0){
		alert("금액을 먼저 입력하십시요.");
		return false;
	}
	return true;
}

/******************************************************************************
	Description : 반제 사용시 체크
	parameter   : 
******************************************************************************/
function ln_Chk_Repay(row){
  if(gcds_dtl.countrow<1||row<1){
		alert("반제 하실 계정을 선택하십시요.");
	}

	//반제계정 체크 - 반제 계정만 가능함. && 거래처 필수 && 차변대변금액 0 체크
	if(gcds_dtl.namevalue(row,"ATCODE")==""||gcds_dtl.namevalue(row,"ATKORNAM"=="")){
		alert("계정이 존재하지 않습니다.");
		return false;
	}
	  
	if(gcds_dtl.namevalue(row,"BANJAEYN")!="Y"){
		//반제계정 재확인
		if(!ln_banjae_atcode_find(gcds_dtl.namevalue(row,"ATCODE"))){
			alert("반제 가능한 계정이 아닙니다.");
			return false;
		}
	}

  /*
	alert("ATDECR::" +gcds_dtl.namevalue(row,"ATDECR"));
	alert("CHAAMT::" +gcds_dtl.namevalue(row,"CHAAMT"));
	alert("DAEAMT::" +gcds_dtl.namevalue(row,"DAEAMT"));
	*/	
	if(gcds_dtl.namevalue(row,"ATDECR")=="1"){  //차변
		if(gcds_dtl.namevalue(row,"CHAAMT")!=0){
			alert("현재 계정은 반제시 차변금액 불가입니다.");
			return false;
		}
	}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){  //대변
		if(gcds_dtl.namevalue(row,"DAEAMT")!=0){
			alert("현재 계정은 반제시 대변금액 불가입니다.");
			return false;
		} 
	}else{
		if(ln_banjae_atcode_find(gcds_dtl.namevalue(row,"ATCODE"))){
			if(gcds_banjae_atcode.namevalue(gcds_banjae_atcode.rowposition,"ATDECR")=="1"){
				if(gcds_dtl.namevalue(row,"CHAAMT")!=0){
					alert("현재 계정은 반제시 차변금액 불가입니다.");
					return false;
				}
			}else if(gcds_banjae_atcode.namevalue(gcds_banjae_atcode.rowposition,"ATDECR")=="2"){
				if(gcds_dtl.namevalue(row,"DAEAMT")!=0){
					alert("현재 계정은 반제시 대변금액 불가입니다.");
					return false;
				} 
			}
		}
	}

	//거래처 확인
	_out:
	for(k=1;k<=9;k++){
		if(gcds_dtl.namevalue(row,"FSREFCD0"+k)=="0020"){
		   //alert("k:"+k+"row:"+row+":"+gcds_dtl.namevalue(row,"FSREFVAL0"+k)+":"+gcds_dtl.namevalue(row,"FSRVALNM0"+k));
			 if(gcds_dtl.namevalue(row,"FSREFVAL0"+k)==""||gcds_dtl.namevalue(row,"FSRVALNM0"+k)==""){
					alert("거래처가 필요합니다.");
					return false;
					break _out;
			 }
		}
	}//k
	
	return true; 
}

/******************************************************************************
	Description : 삭제시 반제체크
	parameter   : p1 - FDCODE,
	              p2 - FSDAT, 
								p3 - FSNBR
******************************************************************************/
function ln_Chk_Del_Banjae(p1,p2,p3){
	if(p1!=""&&p2!=""&&p3!=""){
		gcds_banjae2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s13?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3;	
		//prompt("",gcds_banjae2.DataID);
		gcds_banjae2.Reset();

		if (gcds_banjae2.CountRow>0){  
			return true;
		}else{
			return false; 
		}
	}else{
		return false;
	}
}


/******************************************************************************
	Description : 행삭제시 반제체크 --반제계정일 경우만 체크함
	parameter   : p1 - FDCODE,
	              p2 - FSDAT, 
								p3 - FSNBR,
								p4 - FSSEQ
******************************************************************************/
function ln_Chk_Row_Del_Banjae(p1,p2,p3,p4){
	if(p1!=""&&p2!=""&&p3!=""&&p4!=""){
		gcds_banjae3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s22?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3+"&v_str4="+p4;	
		//prompt("",gcds_banjae3.DataID);
		gcds_banjae3.Reset();

		if(gcds_banjae3.CountRow>0){  //반제데이타가 존재
			return true;
		}else{		
			return false; 
		}
	}else{
		return false;
	}
}


/******************************************************************************
	Description : 반제계정체크
	parameter   : p1-구분
******************************************************************************/
function ln_Chk_Banjae_Amt(){	

  var row = gcds_dtl.rowposition;
	if(row<1)return;

	if(gcds_dtl.namevalue(row,"BANJAEYN")=="Y"){ //반제
		if(gcds_dtl.namevalue(row,"ATDECR")=="1"){ //차변
			if(gcds_dtl.namevalue(row,"DAEAMT")!=0&&gcds_dtl.namevalue(row,"DAEAMT")!=""){
				//거래처 확인
				if(!ln_Vend_Find(row)) return;
				ln_Popup_Repay();
			}
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){
			if(gcds_dtl.namevalue(row,"CHAAMT")!=0&&gcds_dtl.namevalue(row,"CHAAMT")!=""){
				//거래처 확인
				if(!ln_Vend_Find(row)) return;
				ln_Popup_Repay();
			}
		}
	}
}
/******************************************************************************
	Description : 비용수익체크 - 비용계정과 수익계정 입력시 차대 체크
	parameter   : 
******************************************************************************/
function ln_Chk_Atcode_Amt(){

	 var temp = gcem_atcode02.text;
	 var str1char = temp.substring(0,1);
	 var str2char = temp.substring(0,2);
	 var str3char = temp.substring(0,3);

	 if(str1char=="4"){ //비용 수익계정
			if(hid_atdecr.value=="1"){ //차변
				if(gcem_crtot02.text!=0&&gcem_crtot02.text!=""){
					alert("해당계정은 대변에 입력할 수 없습니다.");
					gcem_crtot02.text=0;
					gcem_detot02.focus();
					return;
				}
			}else if(hid_atdecr.value=="2"){//대변
				if(gcem_detot02.text!=0&&gcem_detot02.text!=""){
					alert("해당계정은 차변에 입력할 수 없습니다.");
					gcem_detot02.text=0;
					gcem_crtot02.focus();
					return;
				}
			}
	 }

	if((gcem_detot02.text!=0)&&(gcem_crtot02.text!=0)){
			alert("차변금액과 대변금액을 확인 하십시요");
			gcem_detot02.focus();
			return;
	}
}

/******************************************************************************
	Description :  결재요청 체크.
	parameter   :  
	참       고 :  전표번호가 있으면서, 계정이 둘이상 존재할 경우만 결재요청 가능함.
	               전표상태가 대기중이어야하 함.
******************************************************************************/
function ln_Chk_Confirm(){

	if(gcem_fs02.text!=""&&gcem_fsdat02.text!=""&&gcem_fsnbr02.text!=""){
		if(gcem_fsnbr02.text=="000000"){
			return false;
		}
		if(gcds_dtl.countrow<2){
			return false;
		}
		return true;
	}
}

/******************************************************************************
	Description : 세금계산서체크(전체 삭제시 증빙이 있으면 확인메세지)
	parameter   : 
******************************************************************************/
function ln_Chk_Tax(p1,p2,p3){
	gcds_taxcnt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s14?v_str1="+p1+"&v_str2="+p2+"&v_str3="+p3;	
	gcds_taxcnt.Reset();

	if(gcds_taxcnt.namevalue(gcds_taxcnt.rowposition,"CNT")>0){  
		return true;
	}else{
		return false; 
	}
}

/******************************************************************************
	Description : 행추가시 체크
	parameter   : 
******************************************************************************/
function ln_Chk_Addrow(){
  //alert("ln_Chk_Addrow");
  var tempnm ="";
	var strBanjaechk="";
	var no1="";
  //계정체크
	if(gcem_atcode02.text==""){
		alert("계정코드를 입력하십시요");
    gcem_atcode02.Focus();
		return false;
	}
  
	if(gcem_atkornam02.text==""){
		alert("계정명을 입력하십시요");
    gcem_atkornam02.Focus();
		return false;
	}

  //금액체크
	if(gcem_detot02.text==0&&gcem_crtot02.text==0){
		alert("금액을 입력하십시요");
        gcem_detot02.Focus();
		return false;
	}

	if(gcem_detot02.text!=0&&gcem_crtot02.text!=0){
		alert("차변금액과 대변금액을 확인 하십시요");
        gcem_detot02.Focus();
		return false;
	}
   
	//증빙체크
	if(gclx_documcd02.bindcolval=="101"||gclx_documcd02.bindcolval=="102"||gclx_documcd02.bindcolval=="103"||gclx_documcd02.bindcolval=="104"){
		if(hid_docuval.value==""){
			alert("증빙번호가 없습니다. 확인하십시요");
			return false;
		}
	}
//임시로 부가세신고 20070423
 /*
  //계정이 선급부가가치세 차변인경우 세금계산서가 없으면 저장안됨.
  //대변에 입력 될 경우는 체크 안함.
	if(gcem_atcode02.text=="1112300"){
		if(gcem_detot02.text!=0){
			if((gclx_documcd02.bindcolval=="101"||gclx_documcd02.bindcolval=="102"||gclx_documcd02.bindcolval=="103")&&gclx_documcd02.bindcolval!=""){
			}else{
				alert("해당계정은 세금계산서가 존재해야 합니다.");
				return false;
			}
		}
	}
  //계정이 선수부가가치세, 대변인경우 세금계산서가 없으면 저장안됨.
  //차변에 입력 될 경우는 체크 안함.

	if(gcem_atcode02.text=="2101100"){
		if(gcem_crtot02.text!=0){
			if((gclx_documcd02.bindcolval=="101"||gclx_documcd02.bindcolval=="102"||gclx_documcd02.bindcolval=="103")&&gclx_documcd02.bindcolval!=""){
			}else{
        if(gcem_fsrvalnm03.text=="세금계산서미발행"){}
        else{
          alert("해당계정은 세금계산서가 존재해야 합니다.");
          return false;
        }
			}
		}
	}
 */
	 //거래처
	if(eval("txt_arbaldiv02").value=="N"&&(txt_vendcd02.value==""||gcem_vendnm02.text=="")){
		//tempnm = eval("txt_fsrefnm02").value;
		alert("거래처는 필수항목입니다.");
		gcem_vendnm02.focus(); 
		return false;
	}

  //부서 
	if(eval("txt_arbaldiv01").value=="N"&&(txt_deptcd02_1.value==""||gcem_deptnm02_1.text=="")){
		//tempnm = eval("txt_fsrefnm01").value;
		alert("부서는 필수항목입니다.");
		gcem_deptnm02_1.focus(); 
		return false;
	}

	//적요
	if(gcem_remark02_1.text==""){
		alert("적요을 입력하십시요");
		gcem_remark02_1.focus();
		return false;
	}

  //==================================================================
  //관리항목체크
	//==================================================================
	for(k=3;k<=9;k++){
		if(eval("txt_arbaldiv0"+k).value=="N"&&(eval("txt_fsrefval0"+k).value==""||eval("gcem_fsrvalnm0"+k).text=="")){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")=="01"){ //미적용
				no1 = ln_Bgt_DataSet_Dept_find(gcds_dtl.rowposition);        //예산부서 찾기0003
				if(no1==""||no1==undefined){                                 //예산부서 미존재
					tempnm = eval("txt_fsrefnm0"+k).value;
					alert("관리항목 "+tempnm+"는 필수항목입니다.");
					eval("gcem_fsrvalnm0"+k).focus(); 
					return false;
				}else{ //예산부서 존재시 예산부서만 제외하고 필수항목체크
					if(eval("txt_fsrefcd0"+k).value!="0003"){
						tempnm = eval("txt_fsrefnm0"+k).value;
						alert("관리항목 "+tempnm+"는 필수항목입니다.");
						eval("gcem_fsrvalnm0"+k).focus(); 
						return false;
					}
				}
			}else{	
				tempnm = eval("txt_fsrefnm0"+k).value;
				alert("관리항목 "+tempnm+"는 필수항목입니다.");
				eval("gcem_fsrvalnm0"+k).focus(); 
				return false;
			}
		}
	}//for

  //==================================================================
	//금강산일 경우 관리항목이 외화금액일 경우 체크함.
	//==================================================================
	//2007.05.09 체크방법 변경 
	//기존 : 계정코드 하드코딩 ==> 변경 : ACTCODE 테이블의 ATCURTYPE이 Y인 건을 체크함.
	var stratcode=gcem_atcode02.text;
	stratcode=gcem_atcode02.text.substring(0,3);
	if(gclx_fdcode02.bindcolval=="03"){
		for(b=3;b<=9;b++){
			//if(gcem_atcode02.text=="1112200"||gcem_atcode02.text=="2101000"||stratcode=="112"||stratcode=="122"||stratcode=="123"){
			if(hid_atcurtype.value=="Y"){	
				if(eval("txt_fsrefcd0"+b).value=="1045"){  //외화금액일경우(금강산은 외화가 금액임)
					if((eval("txt_fsrefval0"+b).value==""||eval("gcem_fsrvalnm0"+b).text=="")||
					   (eval("txt_fsrefval0"+b).value=="0"||eval("gcem_fsrvalnm0"+b).text=="0")||
						 (eval("txt_fsrefval0"+b).value=="-"||eval("gcem_fsrvalnm0"+b).text=="-")){
						alert("외화금액란에 금액을 입력하십시요.");
						eval("gcem_fsrvalnm0"+b).focus(); 
				    return false;
					}else{				  
						if(!gf_ChkNumber3(eval("gcem_fsrvalnm0"+b).text)){
						  eval("gcem_fsrvalnm0"+b).focus(); 
							return false;
						}
					}
				}
			}
		}//for
	}
	
	//================================================================== 
	//예산체크
	//==================================================================
	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSWRKDIV")=="02"){
		if(!ln_Bgt_Amt_find(gcds_dtl.rowposition)){
			return false;
		}
	}
  
  //==================================================================
	//반제체크
  //==================================================================
	if(gcds_dtl.namevalue(gcds_dtl.rowposition,"BANJAEYN")=="Y"){ //반제
		if(gcds_dtl.namevalue(gcds_dtl.rowposition,"ATDECR")=="1"){ //차변
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")!=0&&gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")!=""){
				//반제 연결에 순번이 존재하지 않으면
				for(b=1;b<=gcds_banjae.countrow;b++){
					if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
						strBanjaechk="T";
						break;
					}
				}

				if(strBanjaechk!="T"){
					alert("반제계정입니다. 확인 바랍니다.");	
					return false;
				}else{
					strBanjaechk="";
				}
			}

			//2010.06.15 JYS ( 김양묵 GJ 요청 )
			//2011.01.19 JYS ( 김양묵 GJ 요청으로 예외처리 )
			//반제 발생이 (-) 금액 밉력 불가
			if(gs_userid!="2060006"&&gs_userid!="6180021"&&gs_userid!="2140004"&&gs_userid!="2080044"){
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")<0){
					alert("해당 반제 발생은 (-) 금액 입력 불가합니다.");
					gcem_detot02.Focus();
					return false;
				}
			}
		}else if(gcds_dtl.namevalue(gcds_dtl.rowposition,"ATDECR")=="2"){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")!=0&&gcds_dtl.namevalue(gcds_dtl.rowposition,"CHAAMT")!=""){
				//반제 연결에 순번이 존재하지 않으면
				for(b=1;b<=gcds_banjae.countrow;b++){
					if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
						strBanjaechk="T";
						break;
					}
				}
				if(strBanjaechk!="T"){
					alert("반제계정입니다. 확인 바랍니다.");	
					return false;
				}else{
					strBanjaechk="";
				}
			}
			//2010.06.15 JYS ( 김양묵 GJ 요청 )
			//2011.01.19 JYS ( 김양묵 GJ 요청으로 예외처리 )
			//2015.09.24 jys 김양묵 CJ -> 유춘환 BJN
			//반제 발생이 (-) 금액 밉력 불가
			if(gs_userid!="2060006"&&gs_userid!="6180021"&&gs_userid!="2140004"&&gs_userid!="2080044"){
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"DAEAMT")<0){
					alert("해당 반제 발생은 (-) 금액 입력 불가합니다.");
					gcem_crtot02.Focus();
					return false;
				}
			}
		}
	}
	return true;
}


/******************************************************************************
	Description : 결재완료 확인
	prameter    : p- U :조회 후 수정시    I:신규입력시  , D - 
******************************************************************************/
function ln_Chk_Status(p){
  //alert("Status::" + p);
	if (p=="U"){
		if(gclx_fsstat02.bindcolval=="Y"){
			alert("결재완료건은 수정할 수 없습니다.");
			return false;
		}else{
			return true;
		}
	}else if(p=="I"){
	  //alert("gclx_fsstat02::"+gclx_fsstat02.bindcolval);
		if(gclx_fsstat02.bindcolval=="Y"){
		  alert("결재완료건은 수정할 수 없습니다."); 
			return false;
		}else{
			return true;
		}
	}else if(p=="D"){
	  //alert("gclx_fsstat02::"+gclx_fsstat02.bindcolval);
		if(gclx_fsstat02.bindcolval=="Y"||gclx_fsstat02.bindcolval=="C"||gclx_fsstat02.bindcolval=="R"){
		  alert("전표상태가 삭제할 수 없습니다."); 
			return false;
		}else{
			//로그인한 사람과 담당자 사번이 같이 않으면 수정 및 저장 못함.
			//alert("gs_userid!"+gs_userid+"txt_empno02.value)"+txt_empno02.value);
			if(gs_userid!=txt_empno02.value){
				alert("작성자와 동일하지 않습니다.");
				return false;
			}else{
				if(gs_userid==""||gs_userid==undefined){
					alert("작성자를 확인하십시요.");
					return false;
				}
			}
			return true;
		}
	}else if(p=="C"){
		if(gclx_fsstat02.bindcolval=="Y"){
		  alert("결재완료건은 취소할 수 없습니다."); 
			return false;
		}else{
			return true;
		}
	}else{
		
	}
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 체크항목 (End <<<<<<<<<<<<<:::::::::::::::::::::::)
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/******************************************************************************
	Description : 사업소코드 셋팅
******************************************************************************/
function ln_Cocode(strcocode){
	if(strcocode==""||strcocode==undefined){
		if(gclx_fdcode02.bindcolval=="01"){
			strcocode="01";
		}else{
			strcocode="02";
		}
	}
	return strcocode;
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 예산관련 함수 (Start ::::::::::::::::::::::: >>>>>>>>>>>>>>>>>>>>> )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/******************************************************************************
	Description : 관리항목 위치찾기
	parameter   : strValue - 관리항목값
******************************************************************************/
function ln_Ref_position_find(strValue){
  var strposition="";
	for(f=3;f<=9;f++){
	 if (eval("txt_fsrefcd0"+f).value==strValue){  
			strposition ="0"+f;
			return strposition; 
	 }
	}//for f 
	return strposition; 
}

/******************************************************************************
	Description : 세목 찾기
	parameter   : 
******************************************************************************/
function ln_Bgt_Detail_find(){
  var strposition="";
	if(ln_Bgt_position_find()!=""){
		for (g=3;g<=9;g++){
			 if (eval("hid_type"+g).value=="B"){  //예산세목임.
					strposition = g;
					return strposition; 
			 }
		}//for g
	}
	return strposition; 
}

/******************************************************************************
	Description : 예산부서 및 예산본부 위치찾기
	parameter   :
******************************************************************************/
function ln_Bgt_position_find(){
  var strposition="";
	for(f=3;f<=9;f++){
		if (eval("txt_fsrefcd0"+f).value=="0003"){
			strposition = "0"+f;
			return strposition; 
		}
	}//for f
	return strposition
}

/******************************************************************************
	Description : 예산부서 위치찾기
	parameter   : k : Rowposition
******************************************************************************/
function ln_Bgt_DataSet_Dept_find(k){
 var strposition="";
 for(j=1;j<=9;j++){
	if(gcds_dtl.namevalue(k,"FSREFCD0"+j)=="0003"){
		strposition = "0"+j;
		return strposition ; 
	}
 }
 return strposition ;
}

/******************************************************************************
	Description : 예산부서 세목 위치찾기
	parameter   : k : Rowposition
******************************************************************************/
function ln_Bgt_DataSet_Type_find(k){
  var strposition="";
	for(j=1;j<=9;j++){
		if(gcds_dtl.namevalue(k,"TYPE0"+j)=="B"){
			strposition = "0"+j;
			return strposition ; 
		}
	}
	return strposition ; 
}


/******************************************************************************
	Description : 수정전 예산부서 위치찾기
	parameter   : k : Rowposition
******************************************************************************/
function ln_Bf_Bgt_DataSet_Dept_find(k){
 var strposition="";
 for(j=1;j<=9;j++){
	if(gcds_dtl.OrgNameValue(k,"FSREFCD0"+j)=="0003"){
		strposition = "0"+j;
		return strposition ; 
	}
 }
 return strposition ;
}

/******************************************************************************
	Description : 수정전 예산부서 세목 위치찾기
	parameter   : k : Rowposition
******************************************************************************/
function ln_Bf_Bgt_DataSet_Type_find(k){
  var strposition="";
	for(j=1;j<=9;j++){
		if(gcds_dtl.OrgNameValue(k,"TYPE0"+j)=="B"){
			strposition = "0"+j;
			return strposition ; 
		}
	}
	return strposition ; 
}

/******************************************************************************
	Description :  예산금액 조회
	parameter   :  p5 - i 위치(계정의 위치)
******************************************************************************/
function ln_Bgt_Amt_find(p5){

  //alert("ln_Bgt_Amt_find::po::"+p5);
	var stryyyy = gcem_actdat02.text;
	var strmm = fn_trim(stryyyy.substring(4,6));
		 stryyyy = fn_trim(stryyyy.substring(0,4));
	var strbgtdiv="";                                   //예산본부
	var strbgtdept="";                                  //예산부서
	var stratcode = "";                                 //계정과목
	var strrefcd= "";                                   //세목의 관리항목코드
	var strrefval="";                                   //세목값
	var strfswrkdiv="";                                 //예산타입
	var no1="";                                         //관리항목 위치	
	var no2="";                                         //세목
	no1 = ln_Bgt_DataSet_Dept_find(p5);                 //예산부서 찾기
    no2 = ln_Bgt_DataSet_Type_find(p5);                 //세목위치 찾기  
	
	//alert("no1:"+no1+"no2:"+no2);
	                   
	if(no1==""||no1==undefined){
		alert("예산부서가 존재하지 않습니다.");
		return false;
	}

    if(gcds_dtl.namevalue(p5,"CHAAMT")==0||gcds_dtl.namevalue(p5,"CHAAMT")==""){
		alert("금액을 입력하십시요.");
		return false;
	}

  //예산부서가 존재할 경우
	if(no1==no2){//n01 == n02 : 예산부서가 세목인 경우
		strrefcd = gcds_dtl.namevalue(p5,"FSREFCD"+no1);
		strrefval ="00"
	}else{
		if(no2==""||no2==undefined){
			strrefcd="";
			strrefval="";
		}else{
			strrefcd=gcds_dtl.namevalue(p5,"FSREFCD"+no2);
			strrefval=gcds_dtl.namevalue(p5,"FSREFVAL"+no2);	
		}
	}
  
	strbgtdept= gcds_dtl.namevalue(p5,"FSREFVAL"+no1);	

	if(strbgtdept=="1080"){
		strbgtdiv="1000";
	}else{
    strbgtdiv =gcds_dtl.namevalue(p5,"BGTDIV");
	}
	stratcode =gcds_dtl.namevalue(p5,"ATCODE");

	ln_Bgt_Amt_Clear();
	strfswrkdiv = gcds_dtl.namevalue(p5,"FSWRKDIV");
	//alert("strrefcd:"+strrefcd+"strrefval:"+strrefval);
	if(strfswrkdiv!="02"){
		return false;
	}
	
	return true; 
    //^^alert("예산금액조회");
    //2014.07.17.jys 정상원 김용민 채지수 요청 ***
    /***
 	//예산 금액 조회
	if(ln_Bgt_Query(stryyyy,strbgtdiv,strbgtdept,stratcode,strrefcd,strrefval,strmm,strfswrkdiv,p5)){

		gcem_realbgt.text=gcds_bgt.namevalue(gcds_bgt.rowposition,"REALBGT");
		gcem_results.text=gcds_bgt.namevalue(gcds_bgt.rowposition,"RESULTS");
		gcem_bresults.text=gcds_bgt.namevalue(gcds_bgt.rowposition,"BRESULTS");
		gcem_janamt.text=gcds_bgt.namevalue(gcds_bgt.rowposition,"JANAMT");
		
		if(gcds_bgt.countrow>0){
			if(Number(gcds_dtl.namevalue(p5,"CHAAMT"))>Number(gcem_janamt.text)){
				alert("입력하신 금액이 예산 잔액금액보다 많습니다.");
				return false;
			}
			return true;
		}else{
		  alert("예산이 없습니다.");
			ln_Bgt_Amt_Clear();
			return false;
		}
	}else{
	  	alert("예산이 없습니다.");
		gcem_realbgt.text=0;
		gcem_results.text=0;
		gcem_bresults.text=0;
		gcem_janamt.text=0;
		return false;
	}
    ***/
}

/******************************************************************************
	Description :  예산금액 초기화
	parameter   : 
******************************************************************************/
function ln_Bgt_Amt_Clear(){
	gcem_realbgt.text=0;
	gcem_results.text=0;
	gcem_bresults.text=0;
	gcem_janamt.text=0;
}

/******************************************************************************
	Description :  예산조회
	               예산타입이  부서비 기타(05) 공통(15) 경우 년예산 조회
                 그 외 월예산조회
                 ==> 2006.05.15 변경 내용
								 예산부서가 예산본부일경우 년예산조회 (예산본부-substring(2,4) = 00
								 예산부서가 예산부서일경우 월예산조회
	parameter   :  p5 - i position
******************************************************************************/
function ln_Bgt_Query(stryyyy,strbgtdiv,strbgtdept,stratcode,strrefcd,strrefval,strmm,strfswrkdiv,p5){
  //예산조회
	//alert("ln_Bgt_Query + 예산조회");
	//alert("strfswrkdiv:"+strfswrkdiv);
	//alert("stryyyy"+stryyyy+"strbgtdiv"+strbgtdiv+"strbgtdept"+strbgtdept+"stratcode"+stratcode+"strrefcd"+strrefcd+"strrefval"+strrefval+"strmm"+strmm+"strfswrkdiv"+strfswrkdiv);

	if(strfswrkdiv=="02"){ //적용
		//예산 금액 찾기
		//예산본부
	 if(strbgtdiv==""&&strbgtdept!=""){
		gcds_bgtdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0003&v_str2"+strbgtdept;
		gcds_bgtdiv.Reset();
		strbgtdiv = gcds_bgtdiv.namevalue(gcds_bgtdiv.rowposition,"GBCD");
	}


		if(strbgtdept.substring(2,4)=="00"||strbgtdept.substring(2,4)=="10"||strbgtdept=="1080"){  //본부, 공통
		  if(stryyyy!=""&&strbgtdiv!=""&&strbgtdept!=""&&stratcode!=""&&strrefcd!=""&&strrefcd!=""){
				gcds_bgt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s17?v_str1="+gclx_fdcode02.bindcolval
																											 +"&v_str2="+stryyyy
																											 +"&v_str3="+strbgtdiv
																											 +"&v_str4="+strbgtdept
																											 +"&v_str5="+stratcode
																											 +"&v_str6="+strrefcd
																											 +"&v_str7="+strrefval;
																											 //+"&v_str8="+strfswrkdiv;
				//prompt("yyyy",gcds_bgt.DataID);
				gcds_bgt.Reset();
			}
		}else{
		  if(stryyyy!=""&&strbgtdiv!=""&&strbgtdept!=""&&stratcode!=""&&strrefcd!=""&&strrefcd!=""&&strmm!=""){
				gcds_bgt.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s18?v_str1="+gclx_fdcode02.bindcolval
																											 +"&v_str2="+stryyyy
																											 +"&v_str3="+strbgtdiv
																											 +"&v_str4="+strbgtdept
																											 +"&v_str5="+stratcode
																											 +"&v_str6="+strrefcd
																											 +"&v_str7="+strrefval
																											 +"&v_str8="+strmm;
																											 //+"&v_str9="+strfswrkdiv;
				//prompt("yymm",gcds_bgt.DataID);
				gcds_bgt.Reset();
			}
		}
		return true
	}else{ //미적용
		return false;
	}
}

/******************************************************************************
	Description : 전표 전체 삭제시 예산 금액 찾기
	prameter    :
******************************************************************************/
function ln_Del_All_Bgt_find(){
	for(t=1;t<=gcds_dtl.countrow;t++){
		if(gcds_dtl.namevalue(t,"FSWRKDIV")=="02"){  //예산적용
			var no1 = ln_Bgt_DataSet_Dept_find(t);   //예산부서 찾기
			var no2 = ln_Bgt_DataSet_Type_find(t);   //세목위치 찾기  
			if((no1!=""&&no1!=undefined)&&(no2!=""&&no2!=undefined)){
			  //alert("no1:"+no1+"no2:"+no2);
				ln_Del_All_Bgt_Data_Add(t,no1,no2);  //삭제계정추가
			}
		}
	}//for t
}

/******************************************************************************
	Description : 삭제할 예산관련 계정 Data Set 설정
	parameter   : 
******************************************************************************/
function ln_Del_All_Bgt_Data_Add(k,no1,no2){
	if(gcds_bgt_del_all.countrow<=0){
		ln_SetDataHeader("BGTDTL_DEL_ALL");
	}
	gcds_bgt_del_all.Addrow();
	row = gcds_bgt_del_all.rowposition;

	var stractdt3 = gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT");
	gcds_bgt_del_all.namevalue(row,"BGTYY")=stractdt3.substring(0,4);          //변경전예산년도
	gcds_bgt_del_all.namevalue(row,"BGTMM")=stractdt3.substring(4,6);          //변경전예산월  
	gcds_bgt_del_all.namevalue(row,"BGTDIV")=gcds_dtl.OrgNameValue(k,"BGTDIV");//변경전예산본부  
	gcds_bgt_del_all.namevalue(row,"BGTDPT")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no1);   //변경전예산부서  
	gcds_bgt_del_all.namevalue(row,"ATCODE")=gcds_dtl.OrgNameValue(k,"ATCODE");         //변경전계정과목  
	gcds_bgt_del_all.namevalue(row,"FSREFCD")=gcds_dtl.OrgNameValue(k,"FSREFCD"+no2);   //변경전관리항목코드  
	
	//예산부서가 예산관리항목인 경우 세목은 00로 설정
	if(gcds_dtl.OrgNameValue(k,"FSREFCD"+no2)=="0003"){
		gcds_bgt_del_all.namevalue(row,"SATCODE")="00";	 //세목  
	}else{
		gcds_bgt_del_all.namevalue(row,"SATCODE")=gcds_dtl.OrgNameValue(k,"FSREFVAL"+no2);    //변경전세목
  }
		
	gcds_bgt_del_all.namevalue(row,"BGTMACT")=gcds_dtl.OrgNameValue(k,"FSWRKDIV");		      //변경전예산타입 
	gcds_bgt_del_all.namevalue(row,"CHAAMT")=gcds_dtl.OrgNameValue(k,"CHAAMT");             //변경전금액  
	gcds_bgt_del_all.namevalue(row,"ACTDAT")=gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"ACTDAT"); //변경전 회계일자  

	//예산총계정원장 (미승인 실적분)
	gcds_bgt_del_all.namevalue(row,"FDCODE")=gcds_dtl.OrgNameValue(k,"FDCODE");   
	gcds_bgt_del_all.namevalue(row,"COCODE")=ln_Cocode(gcds_data01_2.OrgNameValue(gcds_data01_2.rowposition,"COCODE")); 
	gcds_bgt_del_all.namevalue(row,"FSDAT")=gcds_dtl.OrgNameValue(k,"FSDAT");    
	gcds_bgt_del_all.namevalue(row,"FSNBR")=gcds_dtl.OrgNameValue(k,"FSNBR");     
	gcds_bgt_del_all.namevalue(row,"FSSEQ")=gcds_dtl.OrgNameValue(k,"FSSEQ");  

  //변경 전 예산관리항목원장 (미승인 실적분)
	//예산관리항목원장
	for(j=1;j<=9;j++){
		gcds_bgt_del_all.namevalue(row,"FSREFCD0"+j)=gcds_dtl.OrgNameValue(k,"FSREFCD0"+j);
		gcds_bgt_del_all.namevalue(row,"FSREFVAL0"+j)=gcds_dtl.OrgNameValue(k,"FSREFVAL0"+j);
	}	
}
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 예산관련 함수 (End :::::::::::::::::::::::  <<<<<<<<<<<<<<<<<<<<<< )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/******************************************************************************
Description : 부서,거래처,비고를 행추가시마다 자동 설정함.
              본부코드,예산본부코드,증빙구분코드, 증빙구분값(일반증빙제외) 
parameter   : gubun - TAX 세금계산서에서 가져옴.
******************************************************************************/
function ln_Copy_Dept_Vend_Reamrk(row,gubun){
	var strDocumcd="";
	var strDocGB="";

	hid_copy_remark.value = gcds_dtl.namevalue(row,"REMARK");      //적요 복사

	//일반증빙은 복사하지 않음.
	strDocumcd="";
	strDocumcd=gcds_dtl.namevalue(row,"DOCUMCD");
	strDocGB=strDocumcd.substring(0,1);
	if(strDocGB=="1"&&gubun=="TAX"){
		if(hid_copy_documcd.value==""){
			hid_copy_documcd.value=gcds_dtl.namevalue(row,"DOCUMCD");   //증빙구분 복사
		}
		if(hid_copy_docuval.value==""){
			hid_copy_docuval.value=gcds_dtl.namevalue(row,"DOCUVAL");   //증빙값 복사
		}
	}else{
		hid_copy_documcd.value="";
		hid_copy_docuval.value="";
	}
	
	for(j=1;j<=9;j++){
		//부서
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0002"){
			hid_copy_deptcd.value=gcds_dtl.namevalue(row,"FSREFVAL0"+j); //부서코드 복사
			hid_copy_deptnm.value=gcds_dtl.namevalue(row,"FSRVALNM0"+j); //부서명 복사
			hid_copy_divcd.value=gcds_dtl.namevalue(row,"DIVCD");        //본부코드 복사
		}

		//거래처
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0020"){
			hid_copy_vendcd.value=gcds_dtl.namevalue(row,"FSREFVAL0"+j); //거래처코드 복사
			hid_copy_vendnm.value=gcds_dtl.namevalue(row,"FSRVALNM0"+j); //거래처명 복사
		}

		//예산부서,예산본부
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0003"){
			hid_copy_bgtdept.value=gcds_dtl.namevalue(row,"FSREFVAL0"+j);   //부서명코드 복사
			hid_copy_bgtdeptnm.value=gcds_dtl.namevalue(row,"FSRVALNM0"+j); //부서명코드 복사
			hid_copy_bgtdiv.value=gcds_dtl.namevalue(row,"BGTDIV");         //예산본부코드 복사
		}
	} //for j
}

/******************************************************************************
Description : 부서,거래처,비고를 행추가시마다 자동 설정함.
              본부코드,예산본부코드,증빙구분코드, 증빙구분값(일반증빙제외) 
parameter   : 
******************************************************************************/
function ln_Paste_Dept_Vend_Reamrk(row){

	gcds_dtl.namevalue(row,"REMARK")= hid_copy_remark.value;
	//일반증빙은 복사하지 않음.
	
	//alert("hid_copy_documcd.value:;"+hid_copy_documcd.value);
	var strDocumcd=hid_copy_documcd.value;
	if(strDocumcd!=""){
		var strDocGB=strDocumcd.substring(0,1);
		if(strDocGB="1"){
			gcds_dtl.namevalue(row,"DOCUMCD")=hid_copy_documcd.value;   //증빙구분 복사
			gcds_dtl.namevalue(row,"DOCUVAL")=hid_copy_docuval.value;   //증빙값 복사
		}
	}

	for(j=1;j<=9;j++){
		//부서
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0002"){
			gcds_dtl.namevalue(row,"FSREFVAL0"+j)=hid_copy_deptcd.value; //부서코드 복사
			gcds_dtl.namevalue(row,"FSRVALNM0"+j)=hid_copy_deptnm.value; //부서명 복사
			gcds_dtl.namevalue(row,"DIVCD") = hid_copy_divcd.value;      //본부코드 복사
		}

		//거래처
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0020"){
		    //20061030 - 이강선요청 : 세금계산서 존재시 
		    //2015.03.03. jys 행삽입시 거래처 가져오기
		    //alert("hid_docuval.value:"+hid_docuval.value);
		    //if(hid_docuval.value==""){
				gcds_dtl.namevalue(row,"FSREFVAL0"+j)=hid_copy_vendcd.value; //거래처코드 복사
				gcds_dtl.namevalue(row,"FSRVALNM0"+j)=hid_copy_vendnm.value; //거래처명 복사
			//}
		}

		//예산부서,예산본부
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0003"){
			gcds_dtl.namevalue(row,"FSREFVAL0"+j)=hid_copy_bgtdept.value;   //부서명코드 복사
			gcds_dtl.namevalue(row,"FSRVALNM0"+j)=hid_copy_bgtdeptnm.value; //부서명코드 복사
			gcds_dtl.namevalue(row,"BGTDIV")=hid_copy_bgtdiv.value;         //예산본부코드 복사
		}
	} //for j
}

/******************************************************************************
Description : 부서,거래처,적요 복사할 데이타 초기화
parameter   : 
******************************************************************************/
function ln_Clear_Dept_Vend_Reamrk(){
	hid_copy_deptcd.value="";
	hid_copy_deptnm.value="";
	hid_copy_divcd.value="";
	hid_copy_vendcd.value="";
	hid_copy_vendnm.value="";
	hid_copy_documcd.value="";
	hid_copy_documnm.value="";
	hid_copy_docuval.value="";
	hid_copy_bgtdept.value="";
	hid_copy_bgtdeptnm.value=""; 
	hid_copy_bgtdiv.value="";
	hid_copy_remark.value="";
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 반제관련 함수 (Start :::::::::::::::::::::::  >>>>>>>>>>>>>>>>>>>>>>>>>>> )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
/******************************************************************************
	Description : 반제수정
	parameter   : 
	ref         : 계정별로 반제를 수정 가능해야함.
	              반제한 계정은 행삭제 불가능
								반제 수정은 반제수정 팝업을 띄워서 금액 취소를 해야함.
								적요 관리항목 수정
								//팝업시 해당 계정의 반제 연결을 띄워서 반제 취소하면서
								  반제원장의 데이타도 update 함.
******************************************************************************/
function ln_Popup_Repay_Modify(){
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var stratcode="";
	var stratkornam="";
	var strfsrefval="";
	var strfsrvalnm="";
	var strseq="";
	var temprow="";
	var strbanjaeref="";
	var strbanjaerefval=""; //반제단위값
	var strbanjaerefnm="";  //반제단위명칭
	var chaamt=0;
	var daeamt=0;
	var row = gcds_dtl.rowposition;

	if(!ln_Chk_Row_Del_Banjae(gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FDCODE"),
		                        gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSDAT"),
													  gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSNBR"),
													  gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSSEQ"))){
		
    
		//입력된 데이타 수정 건이 아닌 직접 입력된 경우
		/*
		if(gcds_dtl.namevalue(row,"ATDECR")=="1"){ //차변
			if(!ln_Banjae_Data_Delete(row,'1')){
					gcds_dtl.rowposition = row;
					return false;
			};
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){	
			if(!ln_Banjae_Data_Delete(row,'2')){
				gcds_dtl.rowposition = row;
				return false;
			}
		}	
		*/
	}
	 
	if(!ln_Chk_Repay(row)) return;

	stratcode=gcds_dtl.namevalue(row,"ATCODE"); 
	stratkornam =gcds_dtl.namevalue(row,"ATKORNAM"); 
	strseq = gcds_dtl.namevalue(row,"FSSEQ");   
	
	//거래처
	_out:
	for(j=1;j<=9;j++){
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0020"){
			 strfsrefval = gcds_dtl.namevalue(row,"FSREFVAL0"+j);
			 strfsrvalnm = gcds_dtl.namevalue(row,"FSRVALNM0"+j);
			 break _out;
		}
	}//j
	//////////////////////////////////////////////////////////////////////

  //반제단위 관리항목값을 저장함.
	_out2:
	 for(k=1;k<=9;k++){
			if(gcds_dtl.namevalue(row,"FSREFCD0"+k)==gcds_dtl.namevalue(row,"BANJAEREF")){
				 strbanjaeref = gcds_dtl.namevalue(row,"BANJAEREF");
				 strbanjaerefval = gcds_dtl.namevalue(row,"FSREFVAL0"+k);
				 strbanjaerefnm = gcds_dtl.namevalue(row,"FSRVALNM0"+k);
				 break _out2;
			}
	 }//k	
  
	g_arrParam[0]=stratcode;                         //계정코드
	g_arrParam[1]=stratkornam;                       //계정명
	g_arrParam[2]=strfsrefval;                       //거래처코드
	g_arrParam[3]=strfsrvalnm;                       //거래처명
	g_arrParam[4]=gclx_fdcode02.bindcolval;					 //반제전표 FDCODE
	g_arrParam[5]=gcem_fs02.text+gcem_fsdat02.text;	 //반제전표 FSDAT
	g_arrParam[6]=gcem_fsnbr02.text;						     //반제전표 FSNBR
	g_arrParam[7]=strseq;					                   //전표행번호 seq
	g_arrParam[8]=strbanjaeref;                      //반제단위 관리항목 
	g_arrParam[9]=strbanjaerefval;                   //반제단위값
	g_arrParam[10]=strbanjaerefnm;                   //반제단위값 명칭

	strURL = "./commrepay_popup_modify.jsp";
	strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	//result = showModalDialog(strURL,arrParam,strPos);
	result = showModalDialog(strURL,window,strPos);

	if(gcds_dtl.namevalue(row,"BANJAEMOD")=="Y"){       //반제취소를 했을 경우
		if(gcds_dtl.namevalue(row,"ATDECR")=="1"){
			gcds_dtl.namevalue(row,"DAEAMT")=0;
		}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"){
			gcds_dtl.namevalue(row,"CHAAMT")=0; 
		}
	}

	//////////////////////////////////////////////// 
  //2010.03.15 JYS
	ln_Dtl_Lock(row);
	ln_Dtl_Amt_Lock(row);
	ln_Atcode_Lock(row)
  //2010.03.16 jys : 반제취소 구분자 초기화. 
	gcds_dtl.namevalue(row,"BANJAEMOD")="";
  ////////////////////////////////////////////////
}


/******************************************************************************
	Description : 반제처리
	parameter   : p1 - 지점코드
	              p2 - 접수일자
                p3 - 접수번호
******************************************************************************/
function ln_Popup_Repay(){
  //alert("반제시작");
	var result="";
	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	var stratcode="";
	var stratkornam="";
	var strfsrefval="";
	var strfsrvalnm="";
	var strseq="";
	var temprow="";
	var strbanjaeref="";
	var strbanjaerefval=""; //반제단위값
	var strbanjaerefnm="";  //반제단위명칭
	var chaamt=0;
	var daeamt=0;
	var row = gcds_dtl.rowposition;
	var strBanjaechk="";
	
	if(!ln_Chk_Repay(row)) return;

	stratcode=gcds_dtl.namevalue(row,"ATCODE"); 
	stratkornam =gcds_dtl.namevalue(row,"ATKORNAM"); 
	strseq = gcds_dtl.namevalue(row,"FSSEQ"); 
	
	//해당 계정에 반제 입력값이 존재할 경우 반제팝업 못 띄움.==========================
	if(gcds_dtl.SysStatus(row)==1){//신규입력건
		for(b=1;b<=gcds_banjae.countrow;b++){
			if(gcds_dtl.namevalue(row,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){
				strBanjaechk="T";
				break;
			}
		}//for

		if(strBanjaechk=="T"){
			gcds_dtl.rowposition = row;
			alert("반제적용한 금액입니다. 반제수정 후 가능합니다.");	
			return false;
		}
  }else{
		//이미 반제계정으로 되어 있어도 팝업 안됨
		if(ln_Chk_Row_Del_Banjae(gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FDCODE"),
																gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSDAT"),
																gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSNBR"),
																gcds_dtl.OrgNameValue(gcds_dtl.rowposition,"FSSEQ"))){
			alert("반제가 적용된 계정입니다. 확인바랍니다.");
			return false;
		}
  }
	//====================================================================================
	
	//거래처
	_out:
	for(j=1;j<=9;j++){
		if(gcds_dtl.namevalue(row,"FSREFCD0"+j)=="0020"){
			 strfsrefval = gcds_dtl.namevalue(row,"FSREFVAL0"+j);
			 strfsrvalnm = gcds_dtl.namevalue(row,"FSRVALNM0"+j);
			 break _out;
		}
	}//j
 
  ////////////////////////////////////////////////////////////////////////////////////

  //반제단위 관리항목값을 저장함.
	_out2:
	 for(k=1;k<=9;k++){
			if(gcds_dtl.namevalue(row,"FSREFCD0"+k)==gcds_dtl.namevalue(row,"BANJAEREF")){
				 strbanjaeref = gcds_dtl.namevalue(row,"BANJAEREF");
				 strbanjaerefval = gcds_dtl.namevalue(row,"FSREFVAL0"+k);
				 strbanjaerefnm = gcds_dtl.namevalue(row,"FSRVALNM0"+k);
				 break _out2;
			}
	 }//k	

	g_arrParam[0]=stratcode;                         //계정코드
	g_arrParam[1]=stratkornam;                       //계정명
	g_arrParam[2]=strfsrefval;                       //거래처코드
	g_arrParam[3]=strfsrvalnm;                       //거래처명
	g_arrParam[4]=gclx_fdcode02.bindcolval;					 //반제전표 FDCODE
	g_arrParam[5]=gcem_fs02.text+gcem_fsdat02.text;	 //반제전표 FSDAT
	g_arrParam[6]=gcem_fsnbr02.text;						     //반제전표 FSNBR
	g_arrParam[7]=strseq;					                   //전표행번호 seq
	g_arrParam[8]=strbanjaeref;                      //반제단위 관리항목 
	g_arrParam[9]=strbanjaerefval;                   //반제단위값
	g_arrParam[10]=strbanjaerefnm;                   //반제단위값 명칭

	strURL = "./commrepay_popup.jsp";
	strPos = "dialogWidth:878px;dialogHeight:510px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,window,strPos);

	if (result != null) {
		arrResult = result.split(";");
		if(arrResult[0]!=0){         //차변이 0이 아닐 경우 대변 금액
			gcds_dtl.namevalue(row,"DAEAMT")=arrResult[0];
		}else if(arrResult[1]!=0){   //대변이 0이 아닐 경우 차변 금액
			gcds_dtl.namevalue(row,"CHAAMT")=arrResult[1];
		}

		_out3:
		for(k=1;k<=9;k++) {
			if(gcds_dtl.namevalue(row,"FSREFCD0"+k)==arrResult[2]){
				 gcds_dtl.namevalue(row,"FSREFVAL0"+k)=arrResult[3];
				 gcds_dtl.namevalue(row,"FSRVALNM0"+k)=arrResult[4];
         //관리항목이 카드번호(1133)일 경우 은행을 자동 설정함.
				 if(gcds_dtl.namevalue(row,"FSREFCD0"+k)=="1133"){
						ln_Card_Kind_Find(arrResult[2],arrResult[4]);
				 }
			}

      //2007.06.28 법인카드 
      if(gcds_dtl.namevalue(row,"ATCODE")=="2100520"){  //법인카드일경우
				if(gcds_dtl.namevalue(row,"FSREFCD0"+k)=="0029"){
					gcds_dtl.namevalue(row,"FSREFVAL0"+k)=arrResult[6];
					gcds_dtl.namevalue(row,"FSRVALNM0"+k)=arrResult[8];
				}
			}else{
				if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD0"+k)==arrResult[5]){ //가수금의 입력일자 0020
						gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL0"+k)=arrResult[6];
						gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM0"+k)=arrResult[6];
				}
			}
		}//k		 

		//반제시 적요도 가져옴
		gcds_dtl.namevalue(gcds_dtl.rowposition,"REMARK")= arrResult[7]; //적요
		if(gcds_dtl.rowposition==1&&gcem_remark02.text=="")gcem_remark02.text=arrResult[7];
	}else{
		gcds_dtl.namevalue(row,"CHAAMT")=0;
	  gcds_dtl.namevalue(row,"DAEAMT")=0;
		g_strbanjae="N";
	}

	/////////////////////////
  //2010.03.15 JYS
	ln_Dtl_Lock(row);
	ln_Dtl_Amt_Lock(row);
	ln_Atcode_Lock(row);
	/////////////////////////

	//2014.08.05 이동훈 추가 ////////////////////////////////////////////////////////////////////
	//관리항목 disabled
	//alert(hid_banjaeref.value );
	
	if(hid_banjaeref.value == gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD03")){ //관리항목과 반제단위가 같을 경우

  		//gcem_fsrvalnm03.Enable=false;
	
	}	
	
  /*
  //금액
	i=0;
	chaamt=0;
	daeamt=0;
	for(i=1;i<=g_row;i++){			  
		if(eval("hid_flag"+i+"0").value=="T"){
			if (eval("gcem_chaamt"+i).text=="") eval("gcem_chaamt"+i).text=0;
			if (eval("gcem_daeamt"+i).text=="") eval("gcem_daeamt"+i).text=0;
			chaamt += parseInt(eval("gcem_chaamt"+i).text);
			daeamt += parseInt(eval("gcem_daeamt"+i).text);
		}
	}
	ln_Sum_Amt(chaamt,daeamt);
  */
	//alert("반제끝");
}


/******************************************************************************
	Description : 반제계정확인
******************************************************************************/
function ln_banjae_atcode_find(stratcode){
		gcds_banjae_atcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s21?v_str1="+stratcode;																						
		gcds_banjae_atcode.Reset();
    if(gcds_banjae_atcode.namevalue(gcds_banjae_atcode.rowposition,"ATDEBTYN")=="Y"){
			return true;  //반제계정
		}else{
			return false;
		}
}


/******************************************************************************
Description : 반제구분값
parameter   : p1 - 반제구분값   p3-차변금액
	            p2 - 기준차대     p4-대변금액
******************************************************************************/
function ln_Banjae_yn(p1,p2,p3,p4){

	//^^alert("ln_Banjae_yn :: p1"+p1+"p2"+p2+"p3"+p3+"p4"+p4);
	if(p1=="Y"){
		if(p2=="1"&&p3!=0&&p4==0){       //차변
			return "Y" ;
		}else if(p2=="2"&&p3==0&&p4!=0){ //대변
			return "Y" ;
		}else{
			return p1;
		}
	}else{
		return "N" ;
	}
}

/******************************************************************************
Description : 신규입력시 데이타 셋에서 반제 데이타 삭제(반제원장, 반제연결정산)
parameter   : i - gcds_dtl의 rowposition      
              gubun - 1 : 차변계정
                      2 : 대변계정
******************************************************************************/
function ln_Banjae_Data_Delete(i,gubun){
  var strBanjanChkAmt = 0; //반제금액 

	if(gubun=="1"){
		for(b=1;b<=gcds_banjae.countrow;b++){
			if(gcds_dtl.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){ //반제금액과 현재금액 비교
				strBanjanChkAmt =strBanjanChkAmt+gcds_banjae.namevalue(b,"BJCRAMT");//반제대변금액누적_동일 순번
			}
		}

		if(strBanjanChkAmt!=gcds_dtl.namevalue(i,"DAEAMT")){ // 반제대변금액의 합과 대변금액을 비교
			alert("반제금액이 틀림니다. 반제수정 후 반제를 다시 하십시요.");
			return false;
		}else{
			return true;
		}
		
		//if
	}else if(gubun=="2"){
		for(b=1;b<=gcds_banjae.countrow;b++){
			if(gcds_dtl.namevalue(i,"FSSEQ")==gcds_banjae.namevalue(b,"BTSSEQ")){ //반제금액과 현재금액 비교
				strBanjanChkAmt =strBanjanChkAmt+gcds_banjae.namevalue(b,"BJDEAMT");//반제차변금액누적_동일 순번
			}
		}

		if(strBanjanChkAmt!=gcds_dtl.namevalue(i,"CHAAMT")){ // 반제대변금액의 합과 대변금액을 비교
			alert("반제금액이 틀림니다. 반제수정 후 반제를 다시 하십시요.");
			return false;
		}else{
			return true;
		}
		//if
	}
}

//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
// 반제관련 함수 (End :::::::::::::::::::::::  <<<<<<<<<<<<<<<<<<<<<< )
//+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/******************************************************************************
Description : 관리항목 KillFocus시 발생
parameter   : obj - 관리항목의 gcem object명
******************************************************************************/
function ln_onblur(obj){
  //alert("obj::"+obj);
  var row = gcds_dtl.rowposition;
	if(obj=="gcem_deptnm02_1"){
		if(gcds_dtl.namevalue(row,"TYPE01")=="C"){
			txt_deptcd02_1.value =gcem_deptnm02_1.text; 	
		}
		if(gcem_deptnm02_1.text==""){
			txt_deptcd02_1.value=""; 
		}
	}else if(obj=="gcem_vendnm02"){
		if(gcds_dtl.namevalue(row,"TYPE02")=="C"){
			txt_vendcd02.value =gcem_vendnm02.text; 	
		}
		if(gcem_vendnm02.text==""){
			txt_vendcd02.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm03"){
		if(gcds_dtl.namevalue(row,"TYPE03")=="C"){
			txt_fsrefval03.value =gcem_fsrvalnm03.text; 	
		}
		if(gcem_fsrvalnm03.text==""){
			txt_fsrefval03.value=""; 
		}
	}else if(obj=="gcem_fsrvalnm04"){
		if(gcds_dtl.namevalue(row,"TYPE04")=="C"){
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
	  //alert("TYPE::"+gcds_dtl.namevalue(row,"TYPE06"))
		//alert("row::"+row)
		if(gcds_dtl.namevalue(row,"TYPE06")=="C"){
		  //alert("gcem_fsrvalnm06::"+gcem_fsrvalnm06.text);
			txt_fsrefval06.value =gcem_fsrvalnm06.text; 	
			//alert("txt_fsrefval06::"+txt_fsrefval06.value);
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
}

/******************************************************************************
	Description : 거래처 찾기
	parameter   : p- row
******************************************************************************/
function ln_Vend_Find(row){
	_out:
	for(k=1;k<=9;k++) {
		if(gcds_dtl.namevalue(row,"FSREFCD0"+k)=="0020"){
			 if(gcds_dtl.namevalue(row,"FSREFVAL0"+k)==""){
					alert("거래처가 필요합니다.");
					return false;
					break _out;
			 }				
		}
	}// for k
	return true;
}

/******************************************************************************
	Description : 모든 데이타 셋 Clear
	parameter   :
******************************************************************************/
function ln_DataSet_Clear(){
  gcds_mst.ClearAll();
	gcds_dtl_insert.ClearAll();
	gcds_dtl_update.ClearAll();
	gcds_dtl_del.ClearAll();
	gcds_banjae.ClearAll();
	gcds_banjaemst.ClearAll();
	gcds_tax.ClearAll();
	gcds_bgt_insert.ClearAll();
	gcds_bgt_update.ClearAll();
	gcds_bgt_del.ClearAll();
	gcds_fsnum.ClearAll();
	gcds_fsseq.ClearAll();
	gcds_del02.ClearAll();
	gcds_bgt_del_all.ClearAll();
	gcds_tax_del_row.ClearAll();
	ln_Clear_Dept_Vend_Reamrk(); //hid 값 Clear
}

/******************************************************************************
	Description : 마감확인 조회
	parameter   :
******************************************************************************/
function ln_Slip_Close_Query(){
    var strdate = gcem_actdat02.text;
		var stryyyy=strdate.substring(0,4);
		var strmm = strdate.substring(4,6);
		var strdd = strdate.substring(6,8);
		gcds_slip_close.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s19?v_str1="+gclx_fdcode02.bindcolval
		                                                       +"&v_str2="+stryyyy
																													 +"&v_str3="+strmm
																													 +"&v_str4="+strdd;
	  //prompt("",gcds_slip_close.DataID);																							
		gcds_slip_close.Reset(); 
}

/******************************************************************************
	Description : 관리항목 날짜, 숫자 포맷 설정
	parameter   :
******************************************************************************/
function ln_Ref_Format_Setting(){
	for(k=3;k<=9;k++){
	   eval("gcem_fsrvalnm0"+k).enable = true;
     eval("txt_fsrefval0"+k).disabled = false;
		 eval("gcem_fsrvalnm0"+k).format = "";
		 eval("gcem_fsrvalnm0"+k).GeneralEdit = "true";
		 eval("gcem_fsrvalnm0"+k).Alignment = 0;
		 eval("gcem_fsrvalnm0"+k).IsComma="false";
	}//for
}

/******************************************************************************
	Description : 관리항목 날짜, 숫자 포맷 설정
	parameter   :
******************************************************************************/
function ln_Ref_Date_Money_Format(k){
	if(eval("txt_fsrefcd0"+k).value=="0966"||eval("txt_fsrefcd0"+k).value=="0968"||eval("txt_fsrefcd0"+k).value=="0969"||
		 eval("txt_fsrefcd0"+k).value=="0970"||eval("txt_fsrefcd0"+k).value=="1044"||eval("txt_fsrefcd0"+k).value=="1048"||
		 eval("txt_fsrefcd0"+k).value=="1051"||eval("txt_fsrefcd0"+k).value=="1052"||eval("txt_fsrefcd0"+k).value=="1053"||
		 eval("txt_fsrefcd0"+k).value=="1089"||eval("txt_fsrefcd0"+k).value=="1098"||eval("txt_fsrefcd0"+k).value=="1099"||
		 eval("txt_fsrefcd0"+k).value=="1125"||eval("txt_fsrefcd0"+k).value=="1126"||eval("txt_fsrefcd0"+k).value=="1127"||
		 eval("txt_fsrefcd0"+k).value=="1130"||eval("txt_fsrefcd0"+k).value=="1206"||eval("txt_fsrefcd0"+k).value=="1185"){
		 if(eval("gcem_fsrvalnm0"+k).text==""){
			 eval("gcem_fsrvalnm0"+k).format = "YYYY-MM-DD";
			 eval("gcem_fsrvalnm0"+k).GeneralEdit = "false";
			 eval("gcem_fsrvalnm0"+k).Alignment = 1;
		 }
  
	}else if(eval("txt_fsrefcd0"+k).value=="1045"){ //외화금액의 경우
	   
	   if(eval("gcem_fsrvalnm0"+k).text==""||eval("gcem_fsrvalnm0"+k).text=="0"){
		  
		   eval("gcem_fsrvalnm0"+k).Alignment = 2;
		   eval("gcem_fsrvalnm0"+k).IsComma="true";
		   eval("gcem_fsrvalnm0"+k).format = "";
		  
		   
			//2016.04.05 jys  외화금액은 자동으로 0 설정 
			if(eval("txt_fsrefcd0"+k).value=="1045"){			
				eval("gcem_fsrvalnm0"+k).text=0;
				eval("txt_fsrefval0"+k).value=0;
			}

			/*
			 eval("gcem_fsrvalnm0"+k).format = "";
			 eval("gcem_fsrvalnm0"+k).GeneralEdit = "false";
			 eval("gcem_fsrvalnm0"+k).MaxLength = 12;
			 */
		 }

  //2008.05.17 정영식 추가 
	}else if(eval("txt_fsrefcd0"+k).value=="1241"){ //구매품의번호
	     var temp = eval("gcem_fsrvalnm0"+k).text;
			 eval("gcem_fsrvalnm0"+k).format = "00000000";
			 eval("gcem_fsrvalnm0"+k).GeneralEdit = "false";
			 eval("gcem_fsrvalnm0"+k).Alignment = 1
       eval("gcem_fsrvalnm0"+k).text=temp;

     
	}else{
	   if(eval("gcem_fsrvalnm0"+k).text==""){
			 eval("gcem_fsrvalnm0"+k).format = "";
			 eval("gcem_fsrvalnm0"+k).GeneralEdit = "true";
			 eval("gcem_fsrvalnm0"+k).Alignment = 0;
			 eval("gcem_fsrvalnm0"+k).IsComma="false";
		 }
	}
}

/******************************************************************************
	Description : 카드번호로 카드종류찾기
	parameter   :
******************************************************************************/
function ln_Card_Kind_Find(g_cmtype,scardnum){
	gcds_cardkind.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s4?v_str1="+g_cmtype+"&v_str2="+scardnum+"&v_str3=&v_str4="; 
	//prompt("",gcds_cardkind.DataID);
	gcds_cardkind.Reset();

	if(gcds_cardkind.countrow>0){
		for(j=3;j<=9;j++){
			if(gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFCD0"+j)=="1134"){ //카드종류
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSREFVAL0"+j)= gcds_cardkind.namevalue(gcds_cardkind.rowposition,"GBCD");
				gcds_dtl.namevalue(gcds_dtl.rowposition,"FSRVALNM0"+j)= gcds_cardkind.namevalue(gcds_cardkind.rowposition,"BANKNM");
			}
		}
	}
}

/******************************************************************************
	Description : 구매품의번호 확인
	parameter   : fdcode:지점, atcode:계정, fsrefval:구매품의번호값
	ref         : 2008.05.17 추가 
******************************************************************************/
function ln_Buy_No_Find(fdcode,atcode,fsrefval){
	gcds_buyno.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comm_ref_s1?v_str1="+fdcode+"&v_str2="+atcode+"&v_str3="+fsrefval; 
	//prompt(this,gcds_buyno.DataID);
	gcds_buyno.Reset();

	if(gcds_buyno.namevalue(gcds_buyno.rowposition,"CNT")>0){
	  alert("동일한 구매품의 번호가 존재합니다. 확인 바랍니다.");
		return false;
	}else{
		return true;
	}
}


/******************************************************************************
	Description : 증빙, 거래처 lock설정
	parameter   :
******************************************************************************/
function ln_Dtl_Lock(row){

	//if(hid_docuval.value!=""&&hid_docuval.value!=undefined){
    if(gcds_dtl.namevalue(row,"DOCUVAL")!=""&&gcds_dtl.namevalue(row,"DOCUVAL")!=undefined){
		gclx_documcd02.enable=false;
		if(gcem_atcode02.text=="1112120"){//업무선급금일 경우만 거래처를 막지않음.
			txt_vendcd02.disabled=false;
			gcem_vendnm02.Enable=true;
		}else{
			txt_vendcd02.disabled=true;
			gcem_vendnm02.Enable=false;
		}
	}else{
	  //법인카드일 경우 거래처 lock
		//2008.02.01 정영식
		if(gcem_atcode02.text=="2100520"){
			txt_vendcd02.disabled=true;
			gcem_vendnm02.Enable=false;
		}else{
			
			//2010.03.16 JYS 추가 ////////////////////////////////////////////////////////////////////
			//발생의 경우는 거래처 수정가능
			//정산의 경우는 거래처 수정불가
			//예외 정산인 경우도 거래처가 없는 경우는 활성화 되게함.
			/*
			gclx_documcd02.enable=true;
			txt_vendcd02.disabled=false;
			gcem_vendnm02.Enable=true;
			*/
			if(gcds_dtl.namevalue(row,"BANJAEYN")=="Y"){
				gclx_documcd02.enable=true;
				//차변계정 && 대변!=0 정산
				if(gcds_dtl.namevalue(row,"ATDECR")=="1" &&gcds_dtl.namevalue(row,"DAEAMT")!=0){
					if(gcem_vendnm02.text!=""&&txt_vendcd02.value!=""){
						txt_vendcd02.disabled=true;
						gcem_vendnm02.Enable=false;
					}else{
						txt_vendcd02.disabled=false;
						gcem_vendnm02.Enable=true;		
					}
				//대변계정 && 차변!=0 정산
				}else if(gcds_dtl.namevalue(row,"ATDECR")=="2"&&gcds_dtl.namevalue(row,"CHAAMT")!=0){
					if(gcem_vendnm02.text!=""&&txt_vendcd02.value!=""){
						txt_vendcd02.disabled=true;
						gcem_vendnm02.Enable=false;
					}else{
						txt_vendcd02.disabled=false;
						gcem_vendnm02.Enable=true;		
					}
				}else if(gcds_dtl.namevalue(row,"DAEAMT")==0&&gcds_dtl.namevalue(row,"CHAAMT")==0){
						txt_vendcd02.disabled=false;
						gcem_vendnm02.Enable=true;	
				}else{
					//alert("이건타면 안됨..row."+row+":대변:"+gcds_dtl.namevalue(row,"DAEAMT")+":차변:"+gcds_dtl.namevalue(row,"CHAAMT"));
				}
			}else{
				gclx_documcd02.enable=true;
				txt_vendcd02.disabled=false;
				gcem_vendnm02.Enable=true;
			}
			/////////////////////////////////////////////////////////////////////////////////////////////
		}
	}
}


/******************************************************************************
	Description : 전표 연동 생성 
	parameter   : 
******************************************************************************/
function ln_Slipno_Create(){

    var result="";
	var arrResult	= new Array();
	var strURL="";	
	var strPos="";

	//alert("전표연동");
	
	ln_Add('02','') //초기화 전체등록  
	
	//gcds_automst.AddRow();
	
	strURL = "./autoslip_popup.jsp";
	strPos = "dialogWidth:878px;dialogHeight:460px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
	//result = showModalDialog(strURL,arrParam,strPos);
	result = showModalDialog(strURL,window,strPos);
	
	/*
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FDCODE") = gcds_automst.namevalue(gcds_automst.rowposition,"FDCODE");
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"FSAMT")   =  gcds_automst.namevalue(gcds_automst.rowposition,"TAMT") ;
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"DETOT")   =  gcds_automst.namevalue(gcds_automst.rowposition,"TAMT") ;
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"CRTOT")   =  gcds_automst.namevalue(gcds_automst.rowposition,"TAMT") ;
	gcds_data01_2.namevalue(gcds_data01_2.rowposition,"REMARK") =  gcds_automst.namevalue(gcds_automst.rowposition,"REMARK") ;
	*/
	
}

</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Master -->
<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- Master Save용-->
<comment id="__NSID__"><object  id=gcds_mst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--  -->
<comment id="__NSID__"><object  id=gcds_data02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 지점구분 -->
<comment id="__NSID__"><object  id=gcds_comfield02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--전표Master 복사 -->
<comment id="__NSID__"><object  id=gcds_data01_1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--전표Master 조회 -->
<comment id="__NSID__"><object  id=gcds_data01_2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!--부서로 본부코드 찾기-->
<comment id="__NSID__"><object  id=gcds_divcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 접수번호 채번을 위해 넘기는값 -->
<comment id="__NSID__"><object  id=gcds_input classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표결재요청 -->
<comment id="__NSID__"><object  id=gcds_confirm classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 로그인 부서 체크 -->
<comment id="__NSID__"><object  id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 로그인 사번 체크  -->
<comment id="__NSID__"><object  id=gcds_userid2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- DTL_REF 조회 -->
<comment id="__NSID__"><object  id=gcds_dtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- DTL_REF 신규입력 -->
<comment id="__NSID__"><object  id=gcds_dtl_insert classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- DTL_REF 수정 -->
<comment id="__NSID__"><object  id=gcds_dtl_update classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- DTL_REF 삭제 -->
<comment id="__NSID__"><object  id=gcds_dtl_del classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 증빙코드 -->
<comment id="__NSID__"><object  id=gcds_documcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!--전표 전체삭제 -->
<comment id="__NSID__"><object  id=gcds_del02 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 관리항목명찾기-->
<comment id="__NSID__"><object  id=gcds_name classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 계정코드로 관리항목 가져오기  부가세-->
<comment id="__NSID__"><object  id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 증빙구분 - 매입매출증빙  -->
<comment id="__NSID__"><object  id=gcds_tax classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 증빙구분 - 일반증빙  -->
<comment id="__NSID__"><object  id=gcds_genrst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제정보(연결테이블:history) -->
<comment id="__NSID__"><object  id=gcds_banjae classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제원장(잔액장) -->
<comment id="__NSID__"><object  id=gcds_banjaemst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 예산조회 -->
<comment id="__NSID__"><object  id=gcds_bgt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 예산등록 - 전표등록시 반영 -->
<comment id="__NSID__"><object  id=gcds_bgt_insert classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 예산등록 - 전표수정시 반영-->
<comment id="__NSID__"><object  id=gcds_bgt_update classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 예산등록 - 전표삭제시 반영-->
<comment id="__NSID__"><object  id=gcds_bgt_del classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 예산등록 - 예산총계정원장 반영-->
<comment id="__NSID__"><object  id=gcds_bgt_geled classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 예산등록 - 전표 전체삭제시 반영-->
<comment id="__NSID__"><object  id=gcds_bgt_del_all classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 순번 update함-->
<comment id="__NSID__"><object  id=gcds_fsnum classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전표번호생성 -->
<comment id="__NSID__"><object  id=gcds_slipno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 삭제한 KEY값저장 : FDCODE, FSDAT, FSNBR, FSSEQ ==> FSSEQ의 MAX값을 가져오기 위한 임시 -->
<comment id="__NSID__"><object  id=gcds_fsseq classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제계정찾기-->
<comment id="__NSID__"><object  id=gcds_banjae_atcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 반제연결에 데이타 찾기-->
<comment id="__NSID__"><object  id=gcds_banjae2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 행삭제시 반제연결 및 반제원장 데이타 찾기-->
<comment id="__NSID__"><object  id=gcds_banjae3 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 세금계산서 연결건수  -->
<comment id="__NSID__"><object  id=gcds_taxcnt classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 대체전표 REPORT START -->
<comment id="__NSID__"><object  id=gcds_print classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_prttemp1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_prttemp2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 
<!-- 대체전표 REPORT END -->

<!-- 마감체크-->
<comment id="__NSID__"><object  id=gcds_slip_close classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 예산본부-->
<comment id="__NSID__"><object  id=gcds_bgtdiv classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 


<!-- 카드번호에 따른 종류 찾기-->
<comment id="__NSID__"><object  id=gcds_cardkind classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 행삭제시 세금계산서번호 입력-->
<comment id="__NSID__"><object  id=gcds_tax_del_row classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__">
  <!-- 구매품의번호 중복찾기-->
  <object  id=gcds_buyno classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>

	 <!-- 거래처로 개인명 카드 정보 조회-->
  <object  id=gcds_card classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>
  
   <!-- 전표연동 mst -->
  <object  id=gcds_automst classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  </object>
  
  	 <!-- 전표연동 dtl-->
  <object  id=gcds_autodtl classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
  </object>
  
  <!-- 외상매입금 일반업체 체크 -->
  <object  id=gcds_chk1 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>
  
   <!-- 가압류 거래처 잠금 체크 -->
  <object  id=gcds_bond_attach_his classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
  </object>
  
</comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<!-- 입력/수정 -->
<comment id="__NSID__"><object  id=gctr_data01 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020009_t1(I:USER=gcds_mst,I:USER2=gcds_dtl_insert,I:USER3=gcds_dtl_update,I:USER4=gcds_dtl_del,I:USER6=gcds_banjae,I:USER14=gcds_banjaemst,I:USER7=gcds_tax,I:USER8=gcds_genrst,I:USER9=gcds_bgt_insert,I:USER10=gcds_bgt_update,I:USER11=gcds_bgt_del,I:USER12=gcds_bgt_geled,I:USER13=gcds_fsnum,I:USER15=gcds_tax_del_row,O:USER5=gcds_slipno)">   

</object></comment><script>__ws__(__NSID__);</script> 

<!-- 전체 삭제  -->
<comment id="__NSID__"><object  id=gctr_data02 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t2f(I:USER=gcds_del02,I:USER22=gcds_bgt_del_all)">   
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 결재  -->
<comment id="__NSID__"><object  id=gctr_data06 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t6f(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script>  

<!-- multi 결재  -->
<comment id="__NSID__"><object  id=gctr_data07 classid=clsid:0a2233ad-e771-11d2-973d-00104b15e56f viewastext>
	<param name="keyname"			value="toinb_dataid4">
	<param name="keyvalue"    value="a020001_t7(I:USER=gcds_confirm)">   
</object></comment><script>__ws__(__NSID__);</script>  

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	//window.status="데이타 조회중입니다..잠시만 기다려 주십시오.1";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	//window.status="조회가 완료 되었습니다.";
	ft_cnt.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_data01_2" event="OnLoadStarted()">
</script>

<script language="javascript" for="gcds_data01_2" event="onloadCompleted(row,colid)">
    
    //alert("gcds_data01_2::row::"+row);
	if (row<1){
	    ln_DataSet_Clear();
		//ln_Data_Mst_Setting();

		gclx_fdcode02.bindcolval=hid_b_fdcode.value;
		gcem_fs02.text=hid_b_fs.value; 
		gcem_fsdat02.text=hid_b_fsdat.value; 
		gcem_fsnbr02.text=hid_b_fsnbr.value;
	}
</script>

<script language="javascript" for="gcds_dtl" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.2";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_dtl" event="onloadCompleted(row,colid)">
    //alert("gcds_dtl::row::"+row);
	window.status="조회가 완료 되었습니다.";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1){
	    ln_DataSet_Clear();
		//ln_Data_Mst_Setting();
		alert("검색된 데이터가 없습니다.");
	}
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	if (row>=1){
		gs_deptcd=gcds_dept.namevalue(row,"DEPTCD");
		gs_deptnm=gcds_dept.namevalue(row,"DEPTNM");
	}
</script>

<script language="javascript" for="gcds_divcd" event="onloadCompleted(row,colid)">
		//alert("row::"+row+"::gcds_divcd::"+gcds_divcd.namevalue(gcds_divcd.rowposition,"DIVCD"));
</script>

<script language=JavaScript for=gcds_documcd event=OnLoadCompleted(rowcnt)>
	gcds_documcd.insertrow(1);
	gcds_documcd.namevalue(1,"CDCODE") = "000";
	gcds_documcd.namevalue(1,"CDNAM") = "";
	gclx_documcd02.index = 0;
</script>

<!-- 대체전표 -->
<script language=JavaScript  for=gcds_prttemp1 event=OnLoadCompleted(rowcount)>
	if(rowcount>=1){
	  ln_PrintSubQuery();
	}
</script>

<script language=JavaScript  for=gcds_prttemp2 event=OnLoadCompleted(rowcount)>
	if(rowcount>=1){
	  document.all.LowerFrame.style.visibility="visible";
	  ln_PrintSubQuery2();
		document.all.LowerFrame.style.visibility="hidden";
	}else{
		alert("출력할 정보가 없습니다.");
	}
</script>

<script language=JavaScript for=gcds_dtl event=OnRowPosChanged(row)>

	//세금계산서 번호가 존재할 때만 lock를 설정함.
	ln_Dtl_Lock(row);

	//금액 lock설정함.
	ln_Dtl_Amt_Lock(row);

    /////////////////////////
	//2010.03.16 JYS 계정 lock설정
    ln_Atcode_Lock(row);
    ///////////////////////// 

	////ln_Ref_Format_Setting(row); //관리항목의 날짜, 숫자 항목 설정
	for(k=3;k<=9;k++){
		if(eval("txt_fsrefcd0"+k).value==""){
			eval("gcem_fsrvalnm0"+k).enable = false;
			eval("txt_fsrefval0"+k).disabled = true;
		}else{
			//hid_lastref.value = k;
			eval("gcem_fsrvalnm0"+k).enable = true;
			eval("txt_fsrefval0"+k).disabled = false;
		}	
		ln_Ref_Date_Money_Format(k);
	}

	//2009.01.29 개인명 법인카드
	if(gcds_dtl.namevalue(row,"ATCODE")=="2100525"){
    	ln_Ref_Card_Lock("F",row);
	}
	
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for= gcem_detot02 event=onKillFocus()>
  ln_Chk_Atcode_Amt();
  gcem_fsamt02.text = gcds_dtl.sum(9,0,0);
</script>

<script language=JavaScript for= gcem_crtot02 event=onKillFocus()>
  ln_Chk_Atcode_Amt();
</script>

<script language=JavaScript for= gcem_remark02_1 event=onKillFocus()>
  if(gcds_dtl.rowposition == 1)ln_remark(gcem_remark02_1.text);
</script>

<!-- 부서 / 거래처 / 관리항목 -->
<script language=JavaScript for=gcem_deptnm02_1 event=OnKeyUp()>
  ln_onblur("gcem_deptnm02_1");
</script>

<script language=JavaScript for=gcem_vendnm02 event=OnKeyUp()>
  ln_onblur("gcem_vendnm02");
</script>

<script language=JavaScript for=gcem_fsrvalnm03 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm03");
</script>

<script language=JavaScript for=gcem_fsrvalnm04 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm04");
</script>

<script language=JavaScript for=gcem_fsrvalnm05 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm05");
</script>

<script language=JavaScript for=gcem_fsrvalnm06 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm06");
</script>

<script language=JavaScript for=gcem_fsrvalnm07 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm07");
</script>

<script language=JavaScript for=gcem_fsrvalnm08 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm08");
</script>

<script language=JavaScript for=gcem_fsrvalnm09 event=OnKeyUp()>
  ln_onblur("gcem_fsrvalnm09");
</script>

<script language=JavaScript for=gcem_remark02_1 event=onKeyDown(kcode,scode)>
	if(kcode==13){
		if(hid_lastref.value==2){
		  if(gcem_remark02.text=="") ln_remark(gcem_remark02_1.text);
			ln_Row_Auto_Add(hid_lastref.value,"02");
		}else{
			gcem_fsrvalnm03.Focus();
		}
	}
</script> 

<script language=JavaScript for=gcem_atcode02 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup_Atcode('01');
</script>

<script language=JavaScript for=gcem_atkornam02 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup_Atcode('02');
</script>

<script language=JavaScript for=gcem_deptnm02_1 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('02_1','gcem_deptnm02_1',kcode);
</script>

<script language=JavaScript for=gcem_vendnm02 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('02','gcem_vendnm02',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm03 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('03','gcem_fsrvalnm03',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm04 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('04','gcem_fsrvalnm04',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm05 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('05','gcem_fsrvalnm05',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm06 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('06','gcem_fsrvalnm06',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm07 event=onKeyDown(kcode,scode)>
  //2008.07.03 법인카드 미지급금인경우
	if(gcem_atcode02.text=="2100520"){
		if(gcem_fsrvalnm07.Text.length>=9) {
			alert("법인카드 거래처명을 8자까지 입력가능합니다.");
      gcem_fsrvalnm07.Text ="";
			gcem_fsrvalnm07.Focus();
  	} 
	}
	if (kcode==13||kcode==113)ln_Popup2('07','gcem_fsrvalnm07',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm08 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('08','gcem_fsrvalnm08',kcode);
</script>

<script language=JavaScript for=gcem_fsrvalnm09 event=onKeyDown(kcode,scode)>
	if (kcode==13||kcode==113)ln_Popup2('09','gcem_fsrvalnm09',kcode);
</script>

<script language=JavaScript for=gclx_fswrkdiv02 event=OnSelChange()>
	if(gclx_fswrkdiv02.bindcolval=="01"){ //미적용일 경우 예산부서 Clear
		for(k=3;k<=9;k++){
			if(eval("txt_fsrefcd0"+k).value=="0003"){
				 eval("gcem_fsrvalnm0"+k).text="";
         		 eval("txt_fsrefval0"+k).value="";
				 break;
			}
		}
	}
</script>


<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data01" event="onsuccess()">
    var temp="";
    gclx_fdcode02.bindcolval = gcds_slipno.namevalue(gcds_slipno.rowposition,"FDCODE");
	temp = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSDAT");
    gcem_fs02.text = temp.substring(0,1);
	gcem_fsdat02.text = temp.substring(1,9);
	gcem_fsnbr02.text = gcds_slipno.namevalue(gcds_slipno.rowposition,"FSNBR");
																								
	alert("작업이 성공적으로 완료되었습니다.");

	gcds_mst.ClearData();
	gcds_dtl_update.ClearData();
	gcds_dtl_insert.ClearData();
	gcds_dtl_del.ClearData();
	gcds_banjae.ClearData();
</script>


<script language="javascript" for="gctr_data06" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
	gclx_fsstat02.bindcolval = "R";
	gcds_confirm.ClearData();
</script>

<script language="javascript" for="gctr_data06" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	//alert("Error Code : " + gcds_confirm.ErrorCode + "\n" + "Error Message : " + gcds_confirm.ErrorMsg + "\n");
	gcds_confirm.ClearData();
</script>

</HEAD>

<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>

<!-- 전표입력=========================================================================================================== -->

			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr> 
					<td><img src="../img/a020001_1_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
						<!-- <img src="../../common/img/btn/com_b_exit.gif"  style="cursor:hand" onclick="ln_Cancel('02')"> -->
						<span id=sp4 >
						<img src="../../Common/img/btn/com_b_slipsts.gif"   style="cursor:hand" onclick="ln_Popup('09')">	
						<img src="../../Common/img/btn/com_b_print.gif"   style="cursor:hand" onclick="ln_Print('02')">
					 	<img src="../../Common/img/btn/com_b_sanctionreq.gif"	style="cursor:hand" onClick="ln_Popup_Confirm()" > 
						<img src="../../Common/img/btn/com_btn_slipdel.gif"	style="cursor:hand" onClick="ln_Delete_All()" >
          <!--  <img src="../../common/img/btn/com_btn_actdel.gif"	style="cursor:hand" onClick="ln_Delete('99')" > -->
						<img src="../../Common/img/btn/com_b_insert.gif"  style="cursor:hand" onclick="ln_Add('02','')">
						<img src="../../Common/img/btn/com_b_save.gif"		style="cursor:hand" onClick="ln_Save()">
						</span>
						<img src="../../Common/img/btn/com_b_query.gif"   style="cursor:hand" onclick="ln_Query('03');ln_Query('01')">
					
					</td>
				</tr>
			</table>

			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab15" align=center><nobr>&nbsp;전표번호</nobr></td>
								<td class="tab18" style="width:160px;"><nobr>&nbsp;<comment id="__NSID__">
                  <object  id=gcem_ss02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:15px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Border        value=true>
														<param name=Format        value="#">
														<param name=PromptChar    value="_">
														<param name=UpperFlag     value=1>
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
									<comment id="__NSID__"><object  id=gcem_ssdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										-&nbsp;
									 <comment id="__NSID__"><object  id=gcem_ssnbr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="######">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>

                <td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;지점</nobr></td>
								<td class="tab18" style="width:160px;" ><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_fdcode02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:145px;">
											<param name=ComboDataID    value="gcds_comfield02">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value="FDNAME">
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="FDNAME^0^150">								
											<param name=BindColumn		 value="FDCODE">
									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr>
								</td>

                <td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;전표상태&nbsp;</nobr></td>
								<td class="tab18" style="width:130px;"><nobr>&nbsp;<comment id="__NSID__">	
									<object  id=gclx_fsstat02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
											<param name=CBData			   value="Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			     value=false>
											<param name=ListExprFormat value="NAME^0^110">								
											<param name=BindColumn		 value="CODE">
											<param name=Enable         value=false>

									</object></comment><script>__ws__(__NSID__);</script> 
									</nobr> 
								</td>
                
                <td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;담당부서&nbsp;</nobr></td>
								<td class="tab18" style="width:120px;"><nobr>&nbsp;	
									<input id="txt_deptcd02" type="hidden" class="txtbox" style= "width:50px;height:20px;position:relative;left:-4px"  readOnly="true";> 
									<input id="txt_deptnm02" type="text"   class="txtbox" style= "width:120px;height:20px;position:relative;left:-8px;background-color:#d7d7d7"  readOnly="true";></nobr>	
								</td>
							</tr>

							<tr width="876px"> 
                <td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center><nobr>&nbsp;접수번호</nobr></td>
								<td class="tab19" style="width:160px;"><nobr>&nbsp;<comment id="__NSID__">
                  <object  id=gcem_fs02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:15px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Border        value=true>
														<param name=Format        value="#">
														<param name=PromptChar    value="_">
														<param name=UpperFlag     value=1>
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
									<comment id="__NSID__"><object  id=gcem_fsdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
										-&nbsp;
									 <comment id="__NSID__"><object  id=gcem_fsnbr02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:50px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="######">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>
								
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;회계일자&nbsp;</nobr></td>
								<td class="tab19" style="width:120px;"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_actdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative;top:2px;width:70px;height:20px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=PromptChar	  value="_">
											</object></comment><script>__ws__(__NSID__);</script> 
											<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="ln_Calendar()" style="position:relative;width:20px;left:2px;cursor:hand;"></nobr>
											
											<comment id="__NSID__"><object  id=gcem_fswrtdat02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
											style="position:relative;top:2px;width:1px;height:20px;">
											<param name=Alignment			value=0>
											<param name=Border	      value=true>
											<param name=Format	      value="YYYY/MM/DD">
											<param name=Visible        value="false">
											<param name=PromptChar	  value="_">
										</object></comment><script>__ws__(__NSID__);</script> 
										<input type=hidden  id=hid_actdat02  value=''>
										<input type=hidden  id=hid_cocode02  value=''>
								</td>
								<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;금액&nbsp;</nobr></td>
								<td class="tab19" style="width:130px;"><nobr>&nbsp;<comment id="__NSID__">	
									<object  id=gcem_fsamt02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20px;position:relative;left:0px;top:3px">				
											<param name=Text					value="">
											<param name=Border        value=true>
									    <param name=Alignment     value=2>
                      <param name=Numeric       value="true">
                      <param name=IsComma       value=true>
											<param name=MaxLength     value=12>
											<param name=ReadOnly      value="true">
											<param name=BackColor     value="#CCCCCC">
                      <param name=ReadOnlyBackColor   value="#D7D7D7">
											<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> </nobr>	
								</td>

								<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;담당자&nbsp;</nobr></td>
								<td class="tab19" style="width:130px;"><nobr>&nbsp;
								 <input id="txt_empno02" type="hidden" class="txtbox"  style= "width:50px;height:20px;position:relative;left:-4px"  readOnly="true";>
								 <input id="txt_empnmk02" type="text" class="txtbox"   style= "width:120px;height:20px;position:relative;left:-8px;background-color:#d7d7d7" readOnly="true";>
									</nobr>
								</td>
							</tr>
              
							<tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center><nobr>&nbsp;적요</nobr></td>
								<td colspan=7 class="tab19" style="width:795px;" ><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gcem_remark02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:795px;height:20px;position:relative;left:0px;top:3px">				
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=GeneralEdit   value="true">
										<param name=ReadOnly      value="true">
										<param name=BackColor     value="#CCCCCC">
										<param name=ReadOnlyBackColor   value="#D7D7D7">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
									<input id="txt_fsknd02" type="hidden" class="txtbox" style= "width:10px;height:20px;position:relative;left:-4px"  readOnly="true";> 
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
             				<tr width=876px  >			
							   <td width="476px" align=left >
							   	<span id=sp1 >
							      <font style="position:relative;top:-4px;left:0px">* 외상매입금(일반업체) 증빙 체크 안함</font>
						          <input type=checkbox  id=chkbox_1  style="width:15px;position:relative;left:0px;top:-5px;color:#CCFFCC";>&nbsp;&nbsp;
		      			        </span> 
							   
							   </td>
							   <td width="460px" align=right > 
								    
								    <!--<img src="../../Common/img/btn/com_b_bgtcon.gif"	 style="cursor:hand;position:" onClick="ln_Slipno_Create()">-->
								
									<img src="../../Common/img/btn/com_b_bgtcon.gif"	 style="cursor:hand;position:" onClick="ln_BgtFind()">
								  <span id=sp0>
									<img src="../../Common/img/btn/com_btn_repay.gif"	 style="cursor:hand;position:" onClick="ln_Popup_Repay()">
									<img src="../../Common/img/btn/com_btn_repay_md.gif"	 style="cursor:hand;position:" onClick="ln_Popup_Repay_Modify()"> 
								  </span>
								  
								  <span id=sp3 >
									<img src="../../Common/img/btn/com_b_rowdel.gif"	 style="cursor:hand;position:" onClick="ln_Delete('dis')">
									<img src="../../Common/img/btn/com_b_rowadd.gif"   style="cursor:hand;position:" onclick="ln_Add('99','')">
									<img src="../../Common/img/btn/com_btn_insert_add.gif"   style="cursor:hand;position:" onclick="ln_Insert()">
								  </span>
								</td>
							</tr>
						</table>
						<table width=876px cellpadding=0 cellspacing=0 border=0 style=position:relative;left:0px>
							<tr>
								<td style="width:280" ALIGN=LEFT VALIGN=TOP>
									<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp02  
										style="position:relative;left:-1px;width:875px; height:240px; border:1 solid #708090;display:block;" viewastext>
											<PARAM NAME="DataID"			VALUE="gcds_dtl">
											<PARAM NAME="IndWidth"		VALUE ='0'>
											<PARAM NAME="BorderStyle" VALUE="0">
											<PARAM NAME="Fillarea"		VALUE="true">
											<PARAM NAME="Sortview"		VALUE="left">
											<param name="ViewSummary"	value=1>
											<param name="ColSizing"   value="true">
											<param name="Editable"    value="false">
											<param name="ColSelect"		value=false>
                                            <param name=SelectionColor  value="
												<SC>Type='CurRow',       BgColor='#0660B9',  TextColor='White'</SC>	
												<SC>Type='FocusCurCol',  BgColor='#0660B9',  TextColor='White'</SC>
											">

											<PARAM NAME="Format"			VALUE=" 
											  <FC>Name='순번'		   ID=FSNUM 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=26	  align=center   SumBgColor=#C3D0DB </FC> 
												<FC>Name='계정코드'	 ID=ATCODE 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=51   align=left	 edit=none  SumBgColor=#C3D0DB </FC> 
												<FC>Name='계정명'		 ID=ATKORNAM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=170	align=left	 edit=none  SumBgColor=#C3D0DB SumText='합   계'</FC> 
												<FC>Name='차변금액'	 ID=CHAAMT 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=95   align=right	 edit=none  SumBgColor=#C3D0DB SumText=@sum  color =#0000FF  sumcolor =#0000FF</FC> 
												<FC>Name='대변금액'	 ID=DAEAMT 	      HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=right  edit=none  SumBgColor=#C3D0DB SumText=@sum  color =#FF0000  sumcolor =#FF0000</FC> 
												<C> Name='증빙명'	   ID=DOCUMCD 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=95	  align=left   edit=none  SumBgColor=#C3D0DB SumText='차변-대변'  EditStyle=Combo Data='000:,101:세금계산서,102:계산서,103:신용카드(공제),104:현금영수증(공제),201:신용카드(불공),202:간주공급,203:간이영수증'</C> 
												<C> Name='적요'			 ID=REMARK        HeadAlign=Center HeadBgColor=#B9D4DC Width=205	align=left	 edit=none  SumBgColor=#C3D0DB SumText={sum(CHAAMT)-sum(DAEAMT)} SumTextAlign=right </C> 
												<C> Name='예산'		   ID=FSWRKDIV 	    HeadAlign=Center HeadBgColor=#B9D4DC Width=40	  align=center edit=none  SumBgColor=#C3D0DB EditStyle=Combo Data='01:미적용,02:적용'</C> 
												<C> Name='거래처'		 ID=FSRVALNM02 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100 	align=left   edit=none  SumBgColor=#C3D0DB </C> 
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
								 <table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px">
										<tr><td style="height:2px;"> </td></tr>
								 </table>
					
								  <table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
										<tr>
												<td style="width:24px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab15 ><nobr>순번</nobr></td>
												<td style="width:51px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>계정코드</nobr></td>
												<td style="width:170px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;계정명&nbsp;</nobr></td>
												<td style="width:95px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;차변금액&nbsp;</nobr></td>
												<td style="width:95px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;대변금액&nbsp;</nobr></td>
												<td style="width:125px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;증빙명&nbsp;</nobr></td>
												<!-- <td style="width:355px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>&nbsp;적요&nbsp;</nobr></td> -->
												<td style="width:165px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>거래처</nobr></td>
												<td style="width:140px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>부서</nobr></td>
										</tr>	
										<tr><!--순번-->
										<td class="tab15" style="width:24px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsnum02  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:20px;height:20px;position:relative;top:3px;">				
											<param name=Text					value="">
											<param name=Border        value=false>
										  <param name=Format            value="00">
											<param name=Enable          value=false>
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false> 
										</object></comment><script>__ws__(__NSID__);</script>
										</td><!--계정코드-->
										<td class="tab18" style="width:51px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_atcode02  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:47px;height:20px;position:relative;top:3px;" tabindex=1>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Numeric       value=false>
											<param name=Format        value="0000000">
											<param name=PromptChar    value="">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</td><!--계정명-->
										<td class="tab18" style="width:170px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_atkornam02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:165px;height:20px;position:relative;top:3px;font-size:12px;ime-mode:active;" tabindex=2>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script>
										</td><!--차변-->
										<td class="tab18" style="width:95px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_detot02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#0000ff;position:relative;top:4px;left:-2px;width:90px;" tabindex=3>				
													<param name=Text					value=0>
													<param name=Border        value=false>
													<param name=Alignment     value=2>
													<param name=Numeric       value="true">
													<param name=IsComma       value=true>
													<param name=MaxLength     value=12>
													<param name=SelectAll     value=true>
													<!-- <param name=BackColor     value="#C3D0DB"> -->
													<param name=ReadOnlyForeColor  value="#0000FF">
													<param name=InheritColor  value=true>
											</object></comment><script>__ws__(__NSID__);</script>
										</td><!--대변-->
										<td class="tab18" style="width:95px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object id=gcem_crtot02 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="color:#ff0000;position:relative;top:4px;left:-2px;width:90px;" tabindex=4>				
													<param name=Text					value=0>
													<param name=Border        value=false>
													<param name=Alignment     value=2>
													<param name=Numeric       value="true">
													<param name=IsComma       value=true>
													<param name=MaxLength     value=12>
													<param name=SelectAll     value=true>
													<!-- <param name=BackColor     value="#C3D0DB"> -->
													<param name=ReadOnlyForeColor   value="#FF0000">
													<param name=InheritColor  value=true>
											</object></comment><script>__ws__(__NSID__);</script>
										</td><!--증빙-->
										<td class="tab18" style="width:125px;"><nobr>&nbsp;<comment id="__NSID__">
										<object  id=gclx_documcd02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
											style="position:relative;left:-3px;top:2px;font-size:12px;width:105px;">
												<param name=ComboDataID    value="gcds_documcd">
												<param name=CBDataColumns	 value="CDCODE,CDNAM">
												<param name=SearchColumn	 value=FDNAME>
												<param name=Sort			     value=false>
												<param name=ListExprFormat value="CDNAM^0^100">								
												<param name=BindColumn		 value="CDCODE">
										</object></comment><script>__ws__(__NSID__);</script>
										<img src='../img/plus.gif' value='plus2.gif' id=img_plus1  onclick=ln_Popup_Tax() style="position:relative;width:16px;left:-3px;top:0px;cursor:hand;">
										</td>
                    <!--거래처--> 
										<td class="tab18" style="width:165px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_vendnm02  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:164px;height:20px;position:relative;top:3px;" tabindex=5>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_vendcd02    value=''>
										<input type=hidden  id=txt_fsrefnm02   value='거래처'>
										<input type=hidden  id=txt_fsrefcd02   value='0020'>
										<input type=hidden  id=txt_fsrefseq02  value=''>
										<input type=hidden  id=txt_type02      value=''>
										<input type=hidden  id=txt_arbaldiv02  value=''>
										</td>

                     <!--부서-->
										<td class="tab18" style="width:140px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_deptnm02_1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:135px;height:20px;position:relative;top:3px;" tabindex=6>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_deptcd02_1   value=''>
										<input type=hidden  id=txt_fsrefnm01    value='부서'>
										<input type=hidden  id=txt_fsrefcd01    value='0002'>
										<input type=hidden  id=txt_fsrefseq01   value=''>
										<input type=hidden  id=txt_type01       value=''>
										<input type=hidden  id=txt_arbaldiv01   value=''>
										</td>
									</tr>	
								</table> 

								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
										<tr>
												<td style="width:75px;height:20px;text-align:center"  bgcolor="#C3D0DB"  class=tab15 ><nobr>적요</nobr></td>
												<td class="tab18" style="width:653px;"><nobr>&nbsp;<comment id="__NSID__">
												 <object  id=gcem_remark02_1  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:650px;height:20px;position:relative;top:3px;" tabindex=7>				
													<param name=Text					value="">
													<param name=Alignment     value=0>
													<param name=Border        value=false>
													<param name=Format        value="">
													<param name=GeneralEdit   value="true">
													<param name=BackColor     value="#CCCCCC">
													<param name=InheritColor  value=false>
												</object></comment><script>__ws__(__NSID__);</script>
												</td>

												<!--예산-->
												<td style="width:69px;height:20px;text-align:center"  bgcolor="#C3D0DB"  class=tab18 ><nobr>예산</nobr></td>
												<td class="tab18" style="width:70px;"><nobr>&nbsp;<comment id="__NSID__">
												<object  id=gclx_fswrkdiv02 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
													style="position:relative;left:-3px;top:2px;font-size:12px;width:65px;">
														<param name=CBData			   value="01^미적용,02^적용">
														<param name=CBDataColumns	 value="CODE,NAME">
														<param name=SearchColumn	 value=NAME>
														<param name=Sort			     value=false>
														<param name=ListExprFormat value="NAME^0^65">								
														<param name=BindColumn		 value="CODE">
												</object></comment><script>__ws__(__NSID__);</script> 	
												</td>
										</tr>	
								</table> 

								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
										<tr>
												<td style="width:116px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab15 ><nobr>
													<input type=text    id=txt_fsrefnm03 value="관리항목1"  class=txt41 style="position:relative;top:1px;width:114px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd03 value=''>
													<input type=hidden  id=txt_fsrefseq03 value=''>
													<input type=hidden  id=txt_type03     value=''>
													<input type=hidden  id=txt_arbaldiv03 value=''>
												</nobr></td>
												<td style="width:116px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm04 value="관리항목2"  class=txt41 style="position:relative;top:1px;width:114px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd04 value=''>
													<input type=hidden  id=txt_fsrefseq04 value=''>
													<input type=hidden  id=txt_type04     value=''>
													<input type=hidden  id=txt_arbaldiv04 value=''>
												</nobr></td>
												<td style="width:116px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm05 value="관리항목3"  class=txt41 style="position:relative;top:1px;width:114px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd05 value=''>
													<input type=hidden  id=txt_fsrefseq05 value=''>
													<input type=hidden  id=txt_type05     value=''>
													<input type=hidden  id=txt_arbaldiv05 value=''>
												</nobr></td>
												<td style="width:116px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm06 value="관리항목4"  class=txt41 style="position:relative;top:1px;width:114px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd06 value=''>
													<input type=hidden  id=txt_fsrefseq06 value=''>
													<input type=hidden  id=txt_type06     value=''>
													<input type=hidden  id=txt_arbaldiv06 value=''>
												</nobr></td>
												<td style="width:96px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm07 value="관리항목5"  class=txt41 style="position:relative;top:1px;width:94px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd07 value=''>
													<input type=hidden  id=txt_fsrefseq07 value=''>
													<input type=hidden  id=txt_type07     value=''>
													<input type=hidden  id=txt_arbaldiv07 value=''>
												</nobr></td>
												<td style="width:96px;height:20px;"  bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm08 value="관리항목6"  class=txt41 style="position:relative;top:1px;width:94px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd08 value=''>
													<input type=hidden  id=txt_fsrefseq08 value=''>
													<input type=hidden  id=txt_type08     value=''>
													<input type=hidden  id=txt_arbaldiv08 value=''>
												</nobr></td>
												<td style="width:96px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_fsrefnm09 value="관리항목7"  class=txt41 style="position:relative;top:1px;width:94px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
													<input type=hidden  id=txt_fsrefcd09 value=''>
													<input type=hidden  id=txt_fsrefseq09 value=''>
													<input type=hidden  id=txt_type09     value=''>
													<input type=hidden  id=txt_arbaldiv09 value=''>
												</nobr></td>
												<td style="width:96px;height:20px;" bgcolor="#C3D0DB" align=center class=tab18 ><nobr>
													<input type=text    id=txt_enter value=""  class=txt41 style="position:relative;top:1px;width:94px;height:17px;background-color:#C3D0DB;text-align:center;" readonly tabindex=-1>
												</nobr></td>
										</tr>	
										<tr>
										<td class="tab15" style="width:116px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm03  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:114px;height:20px;position:relative;top:3px;" tabindex=8>				
											<param name=Text					value="">
											<param name=Border        value=false>
										  <param name=Format        value="">
											<!-- <param name=PromptChar    value="">	 -->
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval03   value=''>
										</td>
										<td class="tab18" style="width:116px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm04   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:114px;height:20px;position:relative;top:3px;left:-2" tabindex=9>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval04   value=''>
										</td>
										<td class="tab18" style="width:116px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm05   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:114px;height:20px;position:relative;top:3px;" tabindex=10>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval05   value=''>
										</td>
										<td class="tab18" style="width:116px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm06   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:114px;height:20px;position:relative;top:3px;" tabindex=11>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval06   value=''>
										</td>
										
										<td class="tab18" style="width:96px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm07   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:94px;height:20px;position:relative;top:3px;" tabindex=12>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval07   value=''>
										</td>
										<td class="tab18" style="width:96px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm08   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:94px;height:20px;position:relative;top:3px;" tabindex=13>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval08   value=''>
										</td>
										<td class="tab18" style="width:96px;"><nobr>&nbsp;<comment id="__NSID__">
										 <object  id=gcem_fsrvalnm09   classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="color:#990000;width:94px;height:20px;position:relative;top:3px;" tabindex=14>				
											<param name=Text					value="">
											<param name=Alignment     value=0>
											<param name=Border        value=false>
											<param name=Format        value="">
											<param name=GeneralEdit   value="true">
											<param name=BackColor     value="#CCCCCC">
											<param name=InheritColor  value=true>
										</object></comment><script>__ws__(__NSID__);</script>
										<input type=hidden  id=txt_fsrefval09   value=''>
										
										<input type=hidden  id=hid_atdeptyn     value=''>
										<input type=hidden  id=hid_atdecr       value=''>
										<input type=hidden  id=hid_bgtcmtype    value=''>
										<input type=hidden  id=hid_bgtdiv       value=''><!--예산본부-->
										<input type=hidden  id=hid_funddiv      value=''>
										<input type=hidden  id=hid_banjaeref    value=''><!--반제단위-->
										<input type=hidden  id=hid_divcd        value=''><!--본부코드-->
										<input type=hidden  id=hid_type         value=''><!--예산타입-->
										<input type=hidden  id=hid_fdcode       value=''>
										<input type=hidden  id=hid_fsdat        value=''><!--접수번호9자리(구분값+YYYYMMDD-->
                    					<input type=hidden  id=hid_fsnbr        value=''>
										<input type=hidden  id=hid_fsseq        value=''>
										<input type=hidden  id=hid_docuval      value=''>
										<input type=hidden  id=hid_cnt          value=0>
										<input type=hidden  id=hid_banjaeyn     value=''>
										<input type=hidden  id=hid_fsstat       value=''>
										<input type=hidden  id=hid_bgtcnt       value=0><!--예산세목건수-->
										<input type=hidden  id=hid_lastref      value=0><!--관리항목 마지막란-->
										<input type=hidden  id=hid_banjaemod    value=''><!--반제수정구분-->
                                        <!--입력시마다 복사해서 사용함.-->
										<input type=hidden  id=hid_copy_deptcd  value=""><!--부서복사-->
										<input type=hidden  id=hid_copy_deptnm  value=""><!--부서복사-->
										<input type=hidden  id=hid_copy_divcd   value=""><!--본부복사-->
										<input type=hidden  id=hid_copy_vendcd  value=""><!--거래처복사-->
										<input type=hidden  id=hid_copy_vendnm  value=""><!--거래처복사-->
										<input type=hidden  id=hid_copy_documcd value=""><!--증빙구분복사-->
										<input type=hidden  id=hid_copy_documnm value=""><!--증빙구분복사-->
										<input type=hidden  id=hid_copy_docuval value=""><!--증빙값복사-->
										<input type=hidden  id=hid_copy_bgtdept value=""><!--예산부서복사-->
										<input type=hidden  id=hid_copy_bgtdeptnm value=""><!--예산부서복사-->
										<input type=hidden  id=hid_copy_bgtdiv  value=""><!--예산본부복사-->
										<input type=hidden  id=hid_copy_remark  value=""><!--적요복사-->
										<!-- <input type=hidden  id=hid_arbaldiv     value=0> --><!--관리항목필수선택구분-->
										<input type=hidden  id=hid_atcurtype  value=""><!--금강산 환율원화적용-->
										<input type=hidden  id=hid_gredgb  value="">   <!--채권(가)압류 거래처체크-->
										
										</td>

										<td class="tab18" style="width:96px;" align=center><nobr>
										   <!--데이타가 존재하지 않을 경우 기존 데이타 복사-->
												<input type=hidden  id=hid_b_fdcode       value=''>
												<input type=hidden  id=hid_b_fs           value=''>
												<input type=hidden  id=hid_b_fsdat        value=''>
											    <input type=hidden  id=hid_b_fsnbr        value=''  style="cursor:hand;position:relative;top:2px;left:3px;" >
										</td>
									</tr>	
								</table> 
								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px">
										<tr><td style="height:3px;"> </td></tr>
								</table>
								<table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
									<tr>
										<td style="width:117px;height:20px;"   align=center class=tab15><nobr>&nbsp;예산&nbsp;</nobr></td>
										<td style="width:116px;height:16px;"   class=tab18><comment id="__NSID__">
										<object  id=gcem_realbgt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:114px;height:16px; tabindex=-1>		
											<param name=Text			     value=0> 
											<param name=Border         value=false>
											<param name=Alignment		   value=2>
											<param name=Numeric			   value=true>
											<param name=IsComma			   value=true>
											<param name=MaxLength		   value=12>
											<param name=ReadOnly       value=true>
											<param name=InheritColor   value=true>
											<param name=ReadOnlyForeColor   value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 										
										</td>
										<td style="width:116px;height:16px;"  align=center class=tab18> <nobr>&nbsp;실적&nbsp;</nobr></td>
										<td style="width:117px;height:16px;"   class=tab18 ><nobr><comment id="__NSID__">
											<object  id=gcem_results  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:114px;height:16px; tabindex=-1>		
											<param name=Text			     value=0> 
											<param name=Border         value=false>
											<param name=Alignment		   value=2>
											<param name=Numeric			   value=true>
											<param name=IsComma			   value=true>
											<param name=MaxLength		   value=12>
                     						<param name=ReadOnly       value=true>
											<param name=InheritColor   value=true>
											<param name=ReadOnlyForeColor   value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 
										
										</nobr></td>
										<td style="width:97px;height:16px;"  align=center class=tab18><nobr>실적(미승인포함)</nobr></td>
										<td style="width:97px;height:16px;"  class=tab18 ><nobr><comment id="__NSID__">
										<object  id=gcem_bresults  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:97px;height:16px; tabindex=-1 >		
											<param name=Text			     value=0> 
											<param name=Border         value=false>
											<param name=Alignment		   value=2>
											<param name=Numeric			   value=true>
											<param name=IsComma			   value=true>
											<param name=MaxLength		   value=12>
											<param name=ReadOnly       value=true>
											<param name=InheritColor   value=true>
											<param name=ReadOnlyForeColor   value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 
										</nobr></td>
										<td style="width:97px;height:16px;"  align=center class=tab18 ><nobr>&nbsp;잔액&nbsp;</nobr></td>
										<td style="width:95px;height:16px;"  class=tab18><nobr><comment id="__NSID__">
										<object  id=gcem_janamt  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:94px;height:16px; tabindex=-1>		
											<param name=Text			     value=0> 
											<param name=Border         value=false>
											<param name=Alignment		   value=2>
											<param name=Numeric			   value=true>
											<param name=IsComma			   value=true>
											<param name=MaxLength		   value=12>
											<param name=ReadOnly       value=true>
											<param name=InheritColor   value=true>
											<param name=ReadOnlyForeColor   value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 
										</nobr></td>
									</tr>		
							 </table>
							 
							 <table width=876px cellpadding=0 cellspacing=0 border=0 style="position:relative;top:2px;left:-1px">
									<tr>
										<td style="width:119px;height:20px;"  align=center class=tab15> <nobr>&nbsp;증빙번호&nbsp;</nobr></td>
										<td style="height:16px;"   class=tab18 colspan=7><nobr><comment id="__NSID__">&nbsp;
											<object  id=gcem_docuval_xx  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  
											style=position:relative;left:0px;top:1px;width:114px;height:16px; tabindex=-1>		
											<param name=Text			   value=''> 
											<param name=Border             value=false>
											<param name=Alignment		   value=0>
											<param name=Format             value="#######-####">
                     						<param name=ReadOnly           value=true>
											<param name=InheritColor       value=true>
											<param name=ReadOnlyForeColor  value=#0000FF>
										</object></comment><script>__ws__(__NSID__);</script> 
										</nobr></td>
									</tr>		
							 </table>
					</td>
				</tr>  
			</table>
 
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>

<!-- 전표등록 -->
<!-- 전표등록 MASTER 조회 후 수정시 사용-->
<comment id="__NSID__"><object  id=gcbn_data01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID    value=gcds_data01_2>
	<param name=BindInfo  value='  
	<C>Col=FDCODE	      Ctrl=gclx_fdcode02	      Param=BindColVal</C>
	<C>Col=FSDAT1       Ctrl=gcem_fs02            Param=Text</C>
	<C>Col=FSDAT2       Ctrl=gcem_fsdat02         Param=Text</C>
	<C>Col=FSNBR	      Ctrl=gcem_fsnbr02		      Param=Text</C>
	<C>Col=FSSTAT	      Ctrl=gclx_fsstat02		    Param=BindColVal</C>
	<C>Col=DEPTCD	      Ctrl=txt_deptcd02	        Param=value</C>
    <C>Col=DEPTNM	      Ctrl=txt_deptnm02	        Param=value</C>
	<C>Col=EMPNO        Ctrl=txt_empno02          Param=value</C>
	<C>Col=EMPNMK       Ctrl=txt_empnmk02         Param=value</C>
	<C>Col=FSWRTDAT     Ctrl=gcem_fswrtdat02		  Param=Text</C>
	<C>Col=ACTDAT       Ctrl=gcem_actdat02		    Param=Text</C>
	<C>Col=FSAMT	      Ctrl=gcem_fsamt02		      Param=Text</C>
	<C>Col=DETOT	      Ctrl=gcem_fsamt02		      Param=Text</C>
	<C>Col=CRTOT	      Ctrl=gcem_fsamt02		      Param=Text</C>
	<C>Col=REMARK       Ctrl=gcem_remark02		    Param=Text</C>
	<C>Col=SSDAT1       Ctrl=gcem_ss02            Param=Text</C>
	<C>Col=SSDAT2       Ctrl=gcem_ssdat02         Param=Text</C>
	<C>Col=SSNBR	      Ctrl=gcem_ssnbr02		      Param=Text</C>
	
	'>
</object></comment><script>__ws__(__NSID__);</script> 


<!-- 전표등록 DTL 조회-->
<comment id="__NSID__"><object  id=gcbn_data02   classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID          value=gcds_dtl>
	<param name=BindInfo  value='  
	<C>Col=FDCODE         Ctrl=hid_fdcode   	     Param=value</C>
	<C>Col=FSDAT          Ctrl=hid_fsdat           Param=value</C>
    <C>Col=FSNBR          Ctrl=hid_fsnbr           Param=value/C>
	<C>Col=FSSEQ          Ctrl=hid_fsseq           Param=value</C>
	<C>Col=ATCODE         Ctrl=gcem_atcode02       Param=Text</C>
	<C>Col=ATKORNAM       Ctrl=gcem_atkornam02		 Param=Text</C>
	<C>Col=ATDECR         Ctrl=hid_atdecr	         Param=value</C>
	<C>Col=REMARK         Ctrl=gcem_remark02_1     Param=Text</C>
	<C>Col=CHAAMT         Ctrl=gcem_detot02  	     Param=Text</C>
	<C>Col=DAEAMT         Ctrl=gcem_crtot02        Param=Text</C>
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
	<C>Col=FSREFCD02      Ctrl=txt_fsrefcd02	   	 Param=value</C>
	<C>Col=FSREFCD03      Ctrl=txt_fsrefcd03     	 Param=value</C>
	<C>Col=FSREFCD04      Ctrl=txt_fsrefcd04	   	 Param=value</C>
	<C>Col=FSREFCD05      Ctrl=txt_fsrefcd05     	 Param=value</C>
	<C>Col=FSREFCD06      Ctrl=txt_fsrefcd06     	 Param=value</C>
	<C>Col=FSREFCD07      Ctrl=txt_fsrefcd07     	 Param=value</C>
	<C>Col=FSREFCD08      Ctrl=txt_fsrefcd08     	 Param=value</C>
	<C>Col=FSREFCD09      Ctrl=txt_fsrefcd09     	 Param=value</C>
	<C>Col=FSREFVAL01     Ctrl=txt_deptcd02_1      Param=value</C>
	<C>Col=FSREFVAL02     Ctrl=txt_vendcd02        Param=value</C>
  <C>Col=FSREFVAL03     Ctrl=txt_fsrefval03      Param=value</C>
	<C>Col=FSREFVAL04     Ctrl=txt_fsrefval04      Param=value</C>
	<C>Col=FSREFVAL05     Ctrl=txt_fsrefval05      Param=value</C>
	<C>Col=FSREFVAL06     Ctrl=txt_fsrefval06		   Param=value</C>
	<C>Col=FSREFVAL07     Ctrl=txt_fsrefval07	     Param=value</C>
	<C>Col=FSREFVAL08     Ctrl=txt_fsrefval08      Param=value</C>
	<C>Col=FSREFVAL09     Ctrl=txt_fsrefval09	     Param=value</C>
	<C>Col=FSREFNM01      Ctrl=txt_fsrefnm01			 Param=value</C>
	<C>Col=FSREFNM02      Ctrl=txt_fsrefnm02			 Param=value</C>
	<C>Col=FSREFNM03      Ctrl=txt_fsrefnm03			 Param=value</C>
	<C>Col=FSREFNM04      Ctrl=txt_fsrefnm04			 Param=value</C>
	<C>Col=FSREFNM05      Ctrl=txt_fsrefnm05			 Param=value</C>
	<C>Col=FSREFNM06      Ctrl=txt_fsrefnm06			 Param=value</C>
	<C>Col=FSREFNM07      Ctrl=txt_fsrefnm07			 Param=value</C>
  <C>Col=FSREFNM08      Ctrl=txt_fsrefnm08			 Param=value</C>
	<C>Col=FSREFNM09      Ctrl=txt_fsrefnm09			 Param=value</C>
	<C>Col=FSRVALNM01     Ctrl=gcem_deptnm02_1     Param=Text</C>
	<C>Col=FSRVALNM02     Ctrl=gcem_vendnm02   		 Param=Text</C>
	<C>Col=FSRVALNM03     Ctrl=gcem_fsrvalnm03	   Param=Text</C>
	<C>Col=FSRVALNM04     Ctrl=gcem_fsrvalnm04     Param=Text</C>
	<C>Col=FSRVALNM05     Ctrl=gcem_fsrvalnm05	   Param=Text</C>
	<C>Col=FSRVALNM06     Ctrl=gcem_fsrvalnm06     Param=Text</C>
	<C>Col=FSRVALNM07     Ctrl=gcem_fsrvalnm07     Param=Text</C>
	<C>Col=FSRVALNM08     Ctrl=gcem_fsrvalnm08     Param=Text</C>
	<C>Col=FSRVALNM09     Ctrl=gcem_fsrvalnm09     Param=Text</C>
	<C>Col=TYPE01         Ctrl=txt_type01				   Param=value</C>
	<C>Col=TYPE02         Ctrl=txt_type02				   Param=value</C>
	<C>Col=TYPE03         Ctrl=txt_type03				   Param=value</C>
    <C>Col=TYPE04         Ctrl=txt_type04				   Param=value</C>
	<C>Col=TYPE05         Ctrl=txt_type05				   Param=value</C>
	<C>Col=TYPE06         Ctrl=txt_type06				   Param=value</C>
	<C>Col=TYPE07         Ctrl=txt_type07				   Param=value</C>
	<C>Col=TYPE08         Ctrl=txt_type08				   Param=value</C>
	<C>Col=TYPE09         Ctrl=txt_type09				   Param=value</C>
	<C>Col=ARBALDIV01     Ctrl=txt_arbaldiv01	     Param=value</C>          
	<C>Col=ARBALDIV02     Ctrl=txt_arbaldiv02      Param=value</C>
	<C>Col=ARBALDIV03     Ctrl=txt_arbaldiv03      Param=value</C>
	<C>Col=ARBALDIV04     Ctrl=txt_arbaldiv04      Param=value</C>
	<C>Col=ARBALDIV05     Ctrl=txt_arbaldiv05      Param=value</C>
	<C>Col=ARBALDIV06     Ctrl=txt_arbaldiv06      Param=value</C>
	<C>Col=ARBALDIV07     Ctrl=txt_arbaldiv07	     Param=value</C>
	<C>Col=ARBALDIV08     Ctrl=txt_arbaldiv08      Param=value</C>
    <C>Col=ARBALDIV09     Ctrl=txt_arbaldiv09      Param=value</C>
	<C>Col=CNT            Ctrl=hid_cnt             Param=value</C>
	<C>Col=DOCUMCD        Ctrl=gclx_documcd02      Param=BindColVal</C>
	<C>Col=FSWRKDIV       Ctrl=gclx_fswrkdiv02	   Param=BindColVal</C>
	<C>Col=BANJAEYN       Ctrl=hid_banjaeyn        Param=value</C>
	<C>Col=FSSTAT         Ctrl=hid_fsstat          Param=value</C>
	<C>Col=DOCUVAL        Ctrl=hid_docuval         Param=value</C>
    <C>Col=FSNUM          Ctrl=gcem_fsnum02	       Param=Text</C>
	<C>Col=DIVCD          Ctrl=hid_divcd           Param=value</C>
    <C>Col=BGTDIV         Ctrl=hid_bgtdiv          Param=value</C>
	<C>Col=FUNDDIV        Ctrl=hid_funddiv         Param=value</C>
	<C>Col=BANJAEREF      Ctrl=hid_banjaeref       Param=value</C>
	<C>Col=LASTREF        Ctrl=hid_lastref         Param=value</C>
	<C>Col=BANJAEMOD      Ctrl=hid_banjaemod       Param=value</C>
	<C>Col=ATCURTYPE      Ctrl=hid_atcurtype       Param=value</C>
	
	<C>Col=DOCUMCD        Ctrl=gcem_documcd_xx     Param=text</C>
	<C>Col=DOCUVAL        Ctrl=gcem_docuval_xx     Param=text</C>
	<C>Col=CREDGB         Ctrl=hid_gredgb          Param=value</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
			R E P O R T   D E F I N I T I O N - 대 체 전 표
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id=gcrp_print  classid=clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F VIEWASTEXT>
	<param NAME="MasterDataID"			VALUE="gcds_print">
	<param NAME="DetailDataID"			VALUE="gcds_print">
	<PARAM NAME="PaperSize"					VALUE="A4">	
	<PARAM NAME="FixPaperSize"			VALUE="true">
	<PARAM NAME="PrintMargine"      VALUE="false">
	<PARAM NAME="LandScape"					VALUE="true">
	<param name="NullRecordFlag"    value="false">
  <PARAM NAME="PrintSetupDlgFlag" VALUE="true">
	<PARAM NAME="PreviewZoom"				VALUE="100">
	<PARAM NAME="Format" VALUE="
<B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=455 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1130 ,top=34 ,right=1969 ,bottom=108 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=2024 ,top=344 ,right=2024 ,bottom=452 </L>
	<L> left=241 ,top=452 ,right=2823 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='Page : #p of #t' ,left=2397 ,top=180 ,right=2818 ,bottom=233 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2823 ,top=344 ,right=2823 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='대    변' ,left=2429 ,top=402 ,right=2815 ,bottom=447 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='차    변' ,left=2032 ,top=402 ,right=2418 ,bottom=447 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=2421 ,top=344 ,right=2421 ,bottom=452 </L>
	<T>id='외화차변' ,left=2032 ,top=349 ,right=2418 ,bottom=394 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='외화대변' ,left=2429 ,top=349 ,right=2815 ,bottom=394 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1445 ,top=344 ,right=1445 ,bottom=452 </L>
	<T>id='관리항목' ,left=1159 ,top=402 ,right=1442 ,bottom=447 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='순번' ,left=246 ,top=349 ,right=341 ,bottom=447 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=241 ,top=344 ,right=241 ,bottom=452 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=344 ,top=344 ,right=344 ,bottom=452 </L>
	<L> left=344 ,top=397 ,right=2823 ,bottom=397 </L>
	<L> left=241 ,top=344 ,right=2823 ,bottom=344 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='증빙명' ,left=1834 ,top=349 ,right=2021 ,bottom=394 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='부서명/원가명' ,left=1159 ,top=349 ,right=1442 ,bottom=394 ,face='굴림' ,size=9 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='CURDT', left=1122, top=291, right=1953, bottom=336 ,mask='회계일자 :     XXXX   년   XX   월   XX   일', face='굴림', size=12, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='관리항목' ,left=1834 ,top=402 ,right=2021 ,bottom=447 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1154 ,top=344 ,right=1154 ,bottom=452 </L>
	<T>id='세목/세세목' ,left=868 ,top=349 ,right=1151 ,bottom=394 ,align='left' ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='적     요' ,left=349 ,top=402 ,right=1151 ,bottom=447 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='계정과목명' ,left=349 ,top=349 ,right=863 ,bottom=394 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<L> left=1828 ,top=344 ,right=1828 ,bottom=452 </L>
	<T>id='관리항목' ,left=1450 ,top=402 ,right=1826 ,bottom=447 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<T>id='거 래 처' ,left=1450 ,top=349 ,right=1826 ,bottom=394 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFBF0</T>
	<C>id='DATA04', left=2514, top=283, right=2823, bottom=336, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='전 표 번 호 :' ,left=2302 ,top=283 ,right=2514 ,bottom=336 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DATA01', left=241, top=132, right=1032, bottom=177, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATA02', left=241, top=177, right=1032, bottom=230, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATA03', left=241, top=230, right=1032, bottom=283, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DATA05', left=241, top=283, right=1032, bottom=336, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<X>left=1122 ,top=21 ,right=1955 ,bottom=101 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<C>id='PTITLE', left=1124, top=24, right=1953, bottom=103, face='HY중고딕', size=16, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#C0C0C0</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=130 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=344 ,top=58 ,right=2823 ,bottom=58 ,penstyle=solid ,penwidth=1 ,pencolor=#A0A0A4 </L>
	<L> left=241 ,top=124 ,right=2823 ,bottom=124 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='{CURROW}', left=246, top=0, right=341, bottom=122 ,mask='XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=241 ,top=0 ,right=241 ,bottom=124 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2823 ,top=0 ,right=2823 ,bottom=124 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2421 ,top=0 ,right=2421 ,bottom=124 </L>
	<L> left=344 ,top=0 ,right=344 ,bottom=124 </L>
	<C>id='FODAEAMT', left=2429, top=0, right=2815, bottom=56, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='{decode(DAEAMT,0,,DAEAMT)}', left=2429, top=61, right=2815, bottom=119, align='right', face='굴림', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='REMARK', left=349, top=66, right=1151, bottom=122, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=349, top=0, right=863, bottom=56, align='left', face='굴림', size=11, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DETITLE', left=868, top=0, right=1151, bottom=56, align='left', face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1154 ,top=0 ,right=1154 ,bottom=124 </L>
	<C>id='FSRVALNM013', left=1159, top=66, right=1442, bottom=122, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSRVALNM011', left=1159, top=0, right=1442, bottom=56, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1445 ,top=0 ,right=1445 ,bottom=124 </L>
	<C>id='FSRVALNM012', left=1450, top=0, right=1826, bottom=56, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1828 ,top=0 ,right=1828 ,bottom=124 </L>
	<C>id='{decode(CHAAMT,0,,CHAAMT)}', left=2032, top=66, right=2418, bottom=122, align='right', face='굴림', size=14, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FOCHAAMT', left=2032, top=0, right=2418, bottom=56, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2024 ,top=0 ,right=2024 ,bottom=124 </L>
	<C>id='', left=1834, top=66, right=2021, bottom=122, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='DOCUVAL', left=1834, top=0, right=2021, bottom=56, face='굴림', size=8, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSRVALNM014', left=1450, top=66, right=1826, bottom=122, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSRVALNM015', left=1834, top=66, right=2021, bottom=122, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1500 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<T>id='합    계' ,left=1482 ,top=16 ,right=1852 ,bottom=77 ,face='굴림' ,size=12 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=241 ,top=8 ,right=241 ,bottom=82 </L>
	<L> left=2823 ,top=8 ,right=2823 ,bottom=82 </L>
	<T>id='─金 :' ,left=246 ,top=16 ,right=558 ,bottom=77 ,face='굴림' ,size=12 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=241 ,top=8 ,right=2823 ,bottom=8 </L>
	<L> left=1474 ,top=8 ,right=1474 ,bottom=82 </L>
	<L> left=2347 ,top=8 ,right=2347 ,bottom=82 </L>
	<L> left=241 ,top=82 ,right=2823 ,bottom=82 </L>
	<L> left=241 ,top=87 ,right=2823 ,bottom=87 </L>
	<L> left=241 ,top=148 ,right=2823 ,bottom=148 </L>
	<L> left=241 ,top=212 ,right=1320 ,bottom=212 </L>
	<T>id='성  명' ,left=246 ,top=153 ,right=434 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='서  명' ,left=445 ,top=153 ,right=664 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확  인' ,left=672 ,top=153 ,right=892 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담  당' ,left=900 ,top=153 ,right=1087 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='확  인' ,left=1098 ,top=153 ,right=1315 ,bottom=209 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1884 ,top=8 ,right=1884 ,bottom=82 </L>
	<L> left=241 ,top=400 ,right=2823 ,bottom=400 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<I>id='../../common/img/icon.jpg' ,left=2447 ,top=402 ,right=2826 ,bottom=484</I>
	<L> left=241 ,top=386 ,right=2823 ,bottom=386 </L>
	<L> left=1090 ,top=151 ,right=1090 ,bottom=386 </L>
	<L> left=1320 ,top=90 ,right=1320 ,bottom=386 </L>
	<L> left=2823 ,top=90 ,right=2823 ,bottom=386 </L>
	<L> left=2580 ,top=90 ,right=2580 ,bottom=386 </L>
	<L> left=2347 ,top=90 ,right=2347 ,bottom=386 </L>
	<L> left=2111 ,top=90 ,right=2111 ,bottom=386 </L>
	<L> left=1884 ,top=90 ,right=1884 ,bottom=386 </L>
	<L> left=1677 ,top=90 ,right=1677 ,bottom=386 </L>
	<L> left=1474 ,top=90 ,right=1474 ,bottom=386 </L>
	<L> left=241 ,top=90 ,right=241 ,bottom=386 </L>
	<L> left=894 ,top=90 ,right=894 ,bottom=386 </L>
	<L> left=667 ,top=90 ,right=667 ,bottom=386 </L>
	<L> left=439 ,top=151 ,right=439 ,bottom=386 </L>
	<C>id='CURDT2', left=246, top=418, right=667, bottom=463, align='left' ,mask='출력일자: XXXX/XX/XX', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C4', left=1326, top=153, right=1471, bottom=265, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='수  령  인' ,left=246 ,top=98 ,right=664 ,bottom=143 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='대표이사' ,left=2604 ,top=98 ,right=2794 ,bottom=143 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='결   재' ,left=1326 ,top=98 ,right=1471 ,bottom=143 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='자      금' ,left=900 ,top=98 ,right=1315 ,bottom=143 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='예  산' ,left=672 ,top=98 ,right=892 ,bottom=143 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='C5', left=1326, top=273, right=1471, bottom=384, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C6', left=1484, top=172, right=2813, bottom=238, align='left', face='굴림체', size=12, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, MargineX=3</C>
	<L> left=1320 ,top=267 ,right=2582 ,bottom=267 </L>
	<C>id='C3', left=2368, top=98, right=2559, bottom=143, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C2', left=2135, top=98, right=2326, bottom=143, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='C1', left=1902, top=98, right=2093, bottom=143, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<T>id='검  토' ,left=1685 ,top=98 ,right=1876 ,bottom=143 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='담  당' ,left=1482 ,top=98 ,right=1672 ,bottom=143 ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='DAESUM', left=2368, top=16, right=2818, bottom=77, align='right', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CHASUM', left=1892, top=16, right=2342, bottom=77, align='right', face='굴림', size=14, bold=true, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
    <C>id='C7', left=1902, top=183, right=2093, bottom=228, face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
     
</B>



">
</object></comment><script>__ws__(__NSID__);</script> 

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 
