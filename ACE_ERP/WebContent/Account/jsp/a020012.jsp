<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!---------------------------------------------------------------------------
+ 시 스 템 명	:  계정별조회 - 전표관리	
+ 프로그램 ID	:  A020012.html
+ 기 능 정 의	:  전표 계정별로 조회하는 화면으로 적요로 조회가능함.
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
<title>계정별조회</title>

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
get_cookdata();

var gs_date  = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);

<% String gs_userid  = (String)session.getAttribute("vusrid"); %>

var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var gs_InsGubun=""; //조회와 등록 구분
var gs_dept2="";    //경리관련부서

var gstrempno="";
var gstrGubun ="";
var gstrdeptcd="";
var gstrAuthgr="";


function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출


	gcds_dept.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020001_s2?v_str1=<%=gs_userid%>";
	gcds_dept.Reset();

	ln_Before();
	gclx_fsstat.bindcolval="A";
	gcem_fsdat_fr.text=gs_date.substring(0,6)+"01";
	gcem_fsdat_to.text=gs_date; 
  
	//경리관련부서만 열어놓음.
	if(gf_Dept_Enable(gs_deptcd,gcds_dept2)){
          gclx_fdcode.bindcolval=gs_fdcode;
		  gs_dept2="true";
	}else{
		  gclx_fdcode.bindcolval=gs_fdcode;
		  gclx_fdcode.Enable=false;
		  gs_dept2="false";
	}

	//2010.03.24 JYS 권한 조회변경 ( 권한조회 신규테이블 생성)
	//ln_Query_Authority();
	ln_Query_Authority2();
}



/******************************************************************************
 조회권한 신규
******************************************************************************/
function ln_Query_Authority2(){
  //2010.03.24 JYS 부서별 권한 제외 시킴
  /*********************************************
	if(gs_dept2=="true"){
			//gstrGubun="A";  //회계 or 재무팀일 경우만 
     gstrGubun="";
	}else{
		 gstrGubun="";
	}
	*********************************************/
	gcds_empno_chk.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_s1?v_str1=&v_str2=<%=gs_userid%>&v_str3=A0200120&v_str4=Y";
	gcds_empno_chk.Reset();
}


/******************************************************************************
 조회권한 결과 return 
******************************************************************************/
function ln_Authority_Result(row,colid){
  var cnt=0;
  gstrempno="'<%=gs_userid%>',";

	if(row>0){
    //권한그룹
		gstrAuthgr=gcds_empno_chk.namevalue(row,"AUTHGR");
	
    //부서(6-14), 사번(15-19)
		//부서(6-25), 사번(26-30)
    for(i=6;i<=30;i++){
			if(i<=25){		  
				if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //부서존재 
					cnt+=1;
					gstrdeptcd+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"				
				}			
			}

			if(i>=16){
        if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //사번존재 
					gstrempno+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"				
				}
			}
		}

		if(cnt>0){
			gstrdeptcd=gstrdeptcd.substring(0,gstrdeptcd.length-1);
		}
	}
	
	gstrempno=gstrempno.substring(0,gstrempno.length-1);

	if(gstrAuthgr=="A"){
		gstrGubun = gstrAuthgr;
	}else{
		gstrGubun="";
	}
}

/******************************************************************************
	Description : 조회
	parameter   : p - print;일경우
******************************************************************************/
function ln_Query(p){

		ln_SetDataHeader();
		if(p=="print"){
		  //관리항목 선택을 안할 경우
			if(gcem_fsrefval_fr.text==""){
				 gcds_print01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020012_s1?v_str1="+gcem_fsdat_fr.text     //처리기간fr                                            
																						 +"&v_str2="+gcem_fsdat_to.text			//처리기간to                                            
																						 +"&v_str3="+gclx_fsstat.bindcolval	//전표상태                                              
																						 +"&v_str4="+gclx_fdcode.bindcolval	//지점                                                  
																						 +"&v_str5="+gstrGubun								//회계팀/재무팀 구별 "A"                                
																						 +"&v_str6="+txt_atcode_fr.value		//계정FR                                                
																						 +"&v_str7="+txt_atcode_to.value		//계정TO                                                
																						 +"&v_str8="+gstrdeptcd	 	          //부서                                                  
																						 +"&v_str9="+txt_remark.value  		  //적요                                                  
																						 +"&v_str10="+gstrempno;							//empno(회계팀 재무팀이 아닐 경우 자신의 전표만 조회함) 				
																						 gcds_print01.Reset();
      		}else{
				//관리항목 선택을 한 경우
				 gcds_print01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020012_s3?v_str1="+gcem_fsdat_fr.text     //처리기간fr                                            
																						 +"&v_str2="+gcem_fsdat_to.text			//처리기간to                                            
																						 +"&v_str3="+gclx_fsstat.bindcolval	//전표상태                                              
																						 +"&v_str4="+gclx_fdcode.bindcolval	//지점                                                  
																						 +"&v_str5="+gstrGubun								//회계팀/재무팀 구별 "A"                                
																						 +"&v_str6="+txt_atcode_fr.value		//계정FR                                                
																						 +"&v_str7="+txt_atcode_to.value		//계정TO                                                
																						 +"&v_str8="+gstrdeptcd      	 	    //부서                                                  
																						 +"&v_str9="+txt_remark.value  		  //적요                                                  
																						 +"&v_str10="+gstrempno							//empno(회계팀 재무팀이 아닐 경우 자신의 전표만 조회함)
																						 +"&v_str11="+gclx_fsrefcd.bindcolval	//관리항목                                                 
																						 +"&v_str12="+gcem_fsrefval_fr.text     //관리항목값
																						 +"&v_str13="+gcem_fsrefval_to.text;    //관리항목값
																						 gcds_print01.Reset();
			}
			
		}else{
		  //관리항목 선택을 안할 경우
			if(gcem_fsrefval_fr.text==""){
				gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020012_s1?v_str1="+gcem_fsdat_fr.text     //처리기간fr                                            
																					 +"&v_str2="+gcem_fsdat_to.text			//처리기간to                                            
																					 +"&v_str3="+gclx_fsstat.bindcolval	//전표상태                                              
																					 +"&v_str4="+gclx_fdcode.bindcolval	//지점                                                  
																					 +"&v_str5="+gstrGubun								//회계팀/재무팀 구별 "A"                                
																					 +"&v_str6="+txt_atcode_fr.value		//계정FR                                                
																					 +"&v_str7="+txt_atcode_to.value		//계정TO                                                
																					 +"&v_str8="+gstrdeptcd	 	          //부서                                                  
																					 +"&v_str9="+txt_remark.value  		  //적요                                                  
																					 +"&v_str10="+gstrempno;							//empno(회계팀 재무팀이 아닐 경우 자신의 전표만 조회함) 

																					 gcds_data01.Reset();
			}else{
      //관리항목 선택을 했을 경우
			 gcds_data01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020012_s3?v_str1="+gcem_fsdat_fr.text     //처리기간fr                                            
																					 +"&v_str2="+gcem_fsdat_to.text			//처리기간to                                            
																					 +"&v_str3="+gclx_fsstat.bindcolval	//전표상태                                              
																					 +"&v_str4="+gclx_fdcode.bindcolval	//지점                                                  
																					 +"&v_str5="+gstrGubun								//회계팀/재무팀 구별 "A"                                
																					 +"&v_str6="+txt_atcode_fr.value		//계정FR                                                
																					 +"&v_str7="+txt_atcode_to.value		//계정TO                                                
																					 +"&v_str8="+gstrdeptcd      	 	    //부서                                                  
																					 +"&v_str9="+txt_remark.value  		  //적요                                                  
																					 +"&v_str10="+gstrempno  						//empno(회계팀 재무팀이 아닐 경우 자신의 전표만 조회함) 
																					 +"&v_str11="+gclx_fsrefcd.bindcolval	//관리항목                                                 
																					 +"&v_str12="+gcem_fsrefval_fr.text     //관리항목값
																					 +"&v_str13="+gcem_fsrefval_to.text;    //관리항목값

																					 gcds_data01.Reset();

			}
	 }
}

/******************************************************************************
	Description : 엑셀
	parameter   : 
******************************************************************************/
function ln_Excel(){
	gcgd_disp01.GridToExcel("계정별조회","",2);
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

	//alert(gs_date);
  	//지점구분
	gcds_comfield.DataID =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comfield_s1?v_str1="+gs_date;
	//prompt("",gcds_comfield.DataID);
	gcds_comfield.Reset();
}

/******************************************************************************
	Description : 저장시 체크박스값 변환
	prameter : 
******************************************************************************/
function ln_Chkbox(){

}

/******************************************************************************
	Description : 결재 팝업
	parameter   : 
******************************************************************************/
function ln_Popup_Confirm(){
  
}

/******************************************************************************
	Description : 멀리결재
	parameter   : 
******************************************************************************/
function ln_Multi_Confirm(){
  	 
}

/******************************************************************************
	Description : 
	parameter   : 
******************************************************************************/
function ln_Confirm_Save(){
		
}

/******************************************************************************
	Description : Dataset Head 설정 - 전표 Detail
  parameter   : 
******************************************************************************/
function ln_SetDataHeader(){
 var s_temp="";


	if (gcds_tempmst.countrow<1){
	  s_temp="";
		s_temp = "M_FDCODE:STRING,M_CURDT:STRING,M_CURTI:STRING,M_ACTDAT:STRING";
		gcds_tempmst.SetDataHeader(s_temp);
	}
}


/******************************************************************************
	Description : 달력
	prameter    :	    
******************************************************************************/
function ln_Calendar(){

}

/******************************************************************************
	Description : 
	prameter    :	    
******************************************************************************/
function ln_Print(){
  	var fsdat_fr=gcem_fsdat_fr.text;
	var fsdat_to=gcem_fsdat_to.text;
  
	fsdat_fr = fsdat_fr.substring(0,4)+"/"+fsdat_fr.substring(4,6)+"/"+fsdat_fr.substring(6,8);
	fsdat_to = fsdat_to.substring(0,4)+"/"+fsdat_to.substring(4,6)+"/"+fsdat_to.substring(6,8);

	ln_Query('print');

	gcds_tempmst.addrow();
  	gcds_tempmst.namevalue(1,"M_FDCODE") = "지점 : "+ gclx_fdcode.text;
	gcds_tempmst.namevalue(1,"M_CURDT") = "출력일자 : "+gcurdate.substring(0,4)+"/"+gcurdate.substring(5,7)+"/"+gcurdate.substring(8,10);
	gcds_tempmst.namevalue(1,"M_CURTI") = "";
	gcds_tempmst.namevalue(1,"M_ACTDAT") = "회계일자 : "+fsdat_fr+"~"+fsdat_to;
	gcrp_print.Preview();

}

/******************************************************************************
	Description : 결재 전 계정팝업
  parameter   : 
******************************************************************************/
function ln_Popup_Atcode(p){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./actcode_popup.jsp";
	arrParam[0]="ATUSEYN";
	if(p=="fr"){
		arrParam[1]=txt_atkornam_fr.value;
	}else if(p=="to"){
		arrParam[1]=txt_atkornam_to.value;
	}
	arrParam[2]="";
	strPos = "dialogWidth:495px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(arrResult != null) {
		 arrParam = arrResult.split(";");
		 if(p=="fr") {
				txt_atcode_fr.value = arrParam[0];
				txt_atkornam_fr.value = arrParam[1];
				txt_atcode_to.value = arrParam[0];
				txt_atkornam_to.value = arrParam[1];
		 }else if(p=="to"){
				txt_atcode_to.value = arrParam[0];
				txt_atkornam_to.value = arrParam[1];
		 }
	
		//계정코드로 관리항목 찾기 2007.05.23 추가(정영식)
		gcds_fsrefcd.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a020012_s2?v_str1="+txt_atcode_fr.value+"&v_str2="+txt_atcode_to.value;
		gcds_fsrefcd.Reset();
	
	}else{
		 if(p=="fr") {
				txt_atcode_fr.value = "";
				txt_atkornam_fr.value = "";
				txt_atcode_to.value = "";
				txt_atkornam_to.value = "";
		 }else if(p=="to"){
				txt_atcode_to.text = "";
				txt_atkornam_to.value = "";					
		}
	}
}

/******************************************************************************
	Description : 계정코드 찾기
	parameter   : p1 - 구분,  01-전표일괄 복사(비릿지 ==> 전표)
	                          02-계정
														03-관리항목
	              p2 - Data, row - grid의 rowposition
******************************************************************************/
function ln_Popup(row){
  var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
  var strfsdat = gcds_data01.namevalue(row,"FSDAT");
	var strfsdat1 = strfsdat.substring(0,1);
	var strfsdat2 = strfsdat.substring(1,9);

	arrParam[0]=gcds_data01.namevalue(row,"FDCODE");
	arrParam[1]=strfsdat1;
	arrParam[2]=strfsdat2;
	arrParam[3]=gcds_data01.namevalue(row,"FSNBR");

	strURL = "./a020009_popup.jsp";   
	strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
}

/******************************************************************************
	Description : 관리항목값 찾기
	parameter   : 
******************************************************************************/
function ln_Popup_fsrefval(p){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	if(gclx_fsrefcd.bindcolval=="0020"){//부서코드나 거래처
		strURL = "./gczm_vender_popup.jsp";
	    strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
  	}else if(gclx_fsrefcd.bindcolval=="0002"){
		strURL = "./hcdept_popup.jsp";
	  strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
		result = showModalDialog(strURL,arrParam,strPos);
	}else{
		if(gcds_fsrefcd.namevalue(gcds_fsrefcd.rowposition,"TYPE")=="C"){//필드입력
       result = null;
		}else{
			arrParam[0] = gclx_fsrefcd.bindcolval;
			arrParam[1] = "";
			  
			if(gclx_fsrefcd.bindcolval=="0003"){//예산 
			  arrParam[2] = "";
			}  
			
			strURL = "./commdtil_popup_ifrm.jsp";
			strPos = "dialogWidth:400px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			result = showModalDialog(strURL,arrParam,strPos);
		}
	}
	
	if (result != null) {
      arrResult = result.split(";");
		if(p=="fr"){
			gcem_fsrefval_fr.text = arrResult[0];
			txt_fsrefvalnm_fr.value = arrResult[1];
			gcem_fsrefval_to.text = arrResult[0];
			txt_fsrefvalnm_to.value = arrResult[1];
		}else{
      gcem_fsrefval_to.text = arrResult[0];
			txt_fsrefvalnm_to.value = arrResult[1];
		}
	} else {
	  if(p=="fr"){
      gcem_fsrefval_fr.text = "";
		  txt_fsrefvalnm_fr.value = "";
			gcem_fsrefval_to.text = "";
		  txt_fsrefvalnm_to.value = "";
		}else{
      gcem_fsrefval_to.text = "";
		  txt_fsrefvalnm_to.value = "";
		}
	}
}
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<comment id="__NSID__"><object  id=gcds_data01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_print01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 지점구분 -->
<comment id="__NSID__"><object  id=gcds_comfield classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_dept classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 로그인 부서 체크 -->
<comment id="__NSID__"><object  id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id="gcds_tempmst" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<!-- 계정에 따른 관리항목 찾기 -->
<comment id="__NSID__"><object  id="gcds_fsrefcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</object></comment><script>__ws__(__NSID__);</script> 

<comment id="__NSID__"><object  id=gcds_empno_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object></comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcds_data01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	document.all.LowerFrame.style.visibility="visible";
</script>

<script language="javascript" for="gcds_data01" event="onloadCompleted(row,colid)">
	window.status="조회가 완료 되었습니다.";
	ft_cnt.innerText = "조회건수 : " + row + " 건";
	document.all.LowerFrame.style.visibility="hidden";
	if (row <1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	if (row>=1){
		txt_deptcd.value=gcds_dept.namevalue(row,"DEPTCD");
		txt_deptnm.value=gcds_dept.namevalue(row,"DEPTNM"); 
		gs_deptcd=gcds_dept.namevalue(row,"DEPTCD");
		gs_deptnm=gcds_dept.namevalue(row,"DEPTNM");
	}
</script>

<script language="javascript" for="gcds_comfield" event="onloadCompleted(row,colid)">
		gcds_comfield.insertrow(1);
		gcds_comfield.namevalue(1,"FDCODE") = "";
		gcds_comfield.namevalue(1,"FDNAME") = "전체";
		//gclx_fdcode.index = 0;
</script>


<script language="javascript" for="gcds_fsrefcd" event="onloadCompleted(row,colid)">
		gcds_fsrefcd.insertrow(1);
		gcds_fsrefcd.namevalue(1,"FDCODE") = "";
		gcds_fsrefcd.namevalue(1,"FDNAME") = "";
		//gclx_fdcode.index = 0;
</script>

<script language="javascript" for="gcds_empno_chk" event="onloadCompleted(row,colid)">
		ln_Authority_Result(row,colid);
</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcgd_disp01" event="OnClick(row,colid)">
</script>

<script language=JavaScript for=gcgd_disp01 event=OnDblClick(row,colid)>
  ln_Popup(row);
</script>

<script language=JavaScript for=gclx_fsrefcd event=OnSelChange2()>
  
	gcem_fsrefval_fr.text="";
	txt_fsrefvalnm_fr.value="";
	gcem_fsrefval_to.text="";
	txt_fsrefvalnm_to.value="";

	if(gcds_fsrefcd.namevalue(gcds_fsrefcd.rowposition,"TYPE")=="C"){
		gcem_fsrefval_fr.ReadOnly  = "false";	
		gcem_fsrefval_to.ReadOnly  = "false";
		gcgd_disp01.ColumnProp('FSREFVAL','Name')=gclx_fsrefcd.text;
		gcgd_disp01.ColumnProp('CDNAM', 'Show') = "false";

	}else{
	  
		gcgd_disp01.ColumnProp('FSREFVAL','Name')=gclx_fsrefcd.text;
		gcgd_disp01.ColumnProp('CDNAM', 'Show') = "true";
	
    gcem_fsrefval_fr.ReadOnly = "true";
		gcem_fsrefval_fr.ReadOnlyBackColor ="#d7d7d7"
    gcem_fsrefval_to.ReadOnly = "true";
		gcem_fsrefval_to.ReadOnlyBackColor ="#d7d7d7"
	}

</script>

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
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
					<td><img src="../img/a020012_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_slipsts.gif" style="position:relative;right:5px;cursor:hand" onclick="ln_Popup('09')">	
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_print.gif"		style="position:relative;right:5px;cursor:hand" onClick="ln_Print()">
					  <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_excel.gif"		style="position:relative;right:5px;cursor:hand" onClick="ln_Excel()">
						<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_query.gif"   style="position:relative;right:5px;cursor:hand" onclick="ln_Query('')">
					</td>
				</tr>
			</table>
			<table>
				<tr>
					<td>
						<table  cellpadding="0" cellspacing="0" style="width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
							<tr width="876px"> 
								<td width="100px"  style="" bgcolor="#eeeeee" class="tab15" align=center ><nobr>&nbsp;&nbsp;회계일자&nbsp;</nobr></td>
								<td class="tab18" style="width:250px;"><nobr>&nbsp;<comment id="__NSID__"><object  id=gcem_fsdat_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">		
														<param name=Text					value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
									 </object></comment><script>__ws__(__NSID__);</script> 
									 <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fsdat_fr', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
										~&nbsp;
									 <comment id="__NSID__"><object  id=gcem_fsdat_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:3px">				
														<param name=Text		  value="">
														<param name=Alignment     value=0>
														<param name=Border        value=true>
														<param name=Format        value="YYYY/MM/DD">
														<param name=PromptChar    value="_">
														<param name=BackColor     value="#CCCCCC">
														<param name=InheritColor  value=false>
										</object></comment><script>__ws__(__NSID__);</script> </nobr>
										<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_fsdat_to', 'Text')" style="position:relative;width:20px;left:2px;cursor:hand;">
								</td>        
                				<td width="80px"  style="" bgcolor="#eeeeee" class="tab18" align=center ><nobr>&nbsp;&nbsp;전표상태&nbsp;</nobr></td>
								<td class="tab18" style="width:145px;"><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
											<param name=CBData			 value="A^전체,Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
											<param name=CBDataColumns	 value="CODE,NAME">
											<param name=SearchColumn	 value=NAME>
											<param name=Sort			 value=false>
											<param name=ListExprFormat   value="NAME">								
											<param name=BindColumn		 value="CODE">

									</object></comment><script>__ws__(__NSID__);</script> 	
								</nobr>
								</td> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab18" align=center><nobr>&nbsp;지점구분</nobr></td>
								<td class="tab18" style="width:90px;" align=center><nobr>&nbsp;<comment id="__NSID__">
									<object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:0px;top:2px;font-size:12px;width:80px;">
											<param name=ComboDataID      value="gcds_comfield">
											<param name=CBDataColumns	 value="FDCODE,FDNAME">
											<param name=SearchColumn	 value=FDNAME>
											<param name=Sort			 value=false>
											<param name=ListExprFormat   value="FDNAME">								
											<param name=BindColumn		 value="FDCODE">
											<param name=enable		 value="true">
									</object></comment><script>__ws__(__NSID__);</script> </nobr>
								</td>

							</tr>
							 <tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;계&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;정&nbsp;</nobr></td>
								<td class="tab19" style="width:547px;" colspan=3><nobr>&nbsp;
									<input id="txt_atkornam_fr" type="text" class="txtbox"  style= "position:relative;left:-4px;top:0px;width:170px;height:20px;" maxlength="36" >
									<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:-4px;top:1px" align=center onclick="ln_Popup_Atcode('fr');">
									<input id="txt_atcode_fr" type="text" class="txtbox"  style= "position:relative;left:-4px;top:0px;width:50px;height:20px;" maxlength="6" >				
									~&nbsp;
									<input id="txt_atkornam_to" type="text" class="txtbox"  style= "position:relative;left:-4px;top:0px;width:170px;height:20px;" maxlength="36" >
									<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="계정코드를 검색합니다" style="cursor:hand;position:relative;left:-4px;top:1px" align=center onclick="ln_Popup_Atcode('to');">
									<input id="txt_atcode_to" type="text" class="txtbox"  style= "position:relative;left:-4px;top:0px;width:50px;height:20px;" maxlength="6" >				
									</nobr>
								</td>

								<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align=center ><nobr>&nbsp;&nbsp;담당부서&nbsp;</nobr></td>
								<td class="tab19" style="width:160px;"><nobr>&nbsp;
									<input id="txt_deptcd" type="text" class="txtbox"  style= "width:50px;height:20px;position:relative;left:-4px;background-color:#d7d7d7"  readonly="true";>
									<input id="txt_deptnm" type="text" class="txtbox"  style= "width:110px;height:20px;position:relative;left:-4px;background-color:#d7d7d7"  readonly="true";>
									</nobr>
								</td>
							</tr>

							 <tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;관리항목&nbsp;</nobr></td>
								<td class="tab19" style="width:547px;height:30px" colspan=5><nobr>&nbsp;
									<comment id="__NSID__"><object  id=gclx_fsrefcd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
										style="position:relative;left:-4px;top:5px;font-size:12px;width:170px;">
											<param name=ComboDataID			value="gcds_fsrefcd">
											<param name=CBDataColumns		value="CDCODE,CDNAM">
											<param name=SearchColumn		value=CDNAM>
											<param name=Sort				value=false>
											<param name=ListExprFormat	    value="CDNAM^0^170">
											<param name=BindColumn			value=CDCODE>
									</object></comment><script>__ws__(__NSID__);</script> 

									<comment id="__NSID__"><object  id=gcem_fsrefval_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:95px;height:20px;position:relative;left:0px;top:5px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
								  
									<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="검색합니다" style="cursor:hand;position:relative;left:4px;top:3px" align=center onclick="ln_Popup_fsrefval('fr');">
								  <input id="txt_fsrefvalnm_fr" type="text" class="txtbox"  style= "position:relative;left:1px;top:-2px;width:150px; height:20px;" maxlength="36" disabled>&nbsp;&nbsp;&nbsp;~&nbsp;
									
									<comment id="__NSID__"><object  id=gcem_fsrefval_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:95px;height:20px;position:relative;left:0px;top:5px">		
										<param name=Text					value="">
										<param name=Alignment     value=0>
										<param name=Border        value=true>
										<param name=Numeric       value=false>
										<param name=Format        value="">
										<param name=PromptChar    value="">
										<param name=BackColor     value="#CCCCCC">
										<param name=InheritColor  value=false>
									</object></comment><script>__ws__(__NSID__);</script> 
								  
									<img SRC="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_find.gif" BORDER="0" ALT="검색합니다" style="cursor:hand;position:relative;left:4px;top:3px" align=center onclick="ln_Popup_fsrefval('to');">
								  <input id="txt_fsrefvalnm_to" type="text" class="txtbox"  style= "position:relative;left:1px;top:-2px;width:150px; height:20px;" maxlength="36" disabled>

									</nobr>
								</td>
							</tr>
							 <tr width="876px"> 
								<td width="80px" style="" bgcolor="#eeeeee" class="tab17" align=center ><nobr>&nbsp;&nbsp;적&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;요&nbsp;</nobr></td>
								<td class="tab19" style="width:547px;" colspan=5><nobr>&nbsp;
									<input id="txt_remark" type="text" class="txtbox"  style= "width:800px;height:20px;position:relative;left:-4px" maxlength=30 onkeydown="if(event.keyCode==13) ln_Query('')";>
									</nobr>
								</td>
							</tr>
					 </table>
					</td>
				</tr>  	
			</table>

			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;width:280px;border:0 solid #708090;">
				<tr> 			
					<td style="width:280" ALIGN=LEFT VALIGN=TOP>
						<comment id="__NSID__"><object  classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_disp01  
							style="position:relative;left:3px;width:875px; height:380px; border:1 solid #708090;display:block;" viewastext>
								<PARAM NAME="DataID"		VALUE="gcds_data01">
								<PARAM NAME="IndWidth"		VALUE ='0'>
								<PARAM NAME="BorderStyle"   VALUE="0">
								<PARAM NAME="Fillarea"		VALUE="true">
								<PARAM NAME="Sortview"		VALUE="left">
								<param name="ViewSummary"	value=1>
								<param name="ColSizing"     value="true">
								<param name="Editable"      value="false">
								<PARAM NAME="Format"		VALUE="  
								<C> Name='지점'		 ID=FDCODE	  HeadAlign=Center HeadBgColor=#B9D4DC Width=41	  align=left	 edit=none sort=false SumBgColor=#C3D0DB EditStyle=Combo Data='01:본사,02:서울,03:금강산,04:개성'</C>
								<C> Name='담당자'		 ID=EMPNMK	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60	  align=left	 edit=none sort=true  SumBgColor=#C3D0DB </C> 								
								<C> Name='전표번호'	 ID=SSDTNB	  HeadAlign=Center HeadBgColor=#B9D4DC Width=101	align=center edit=none sort=true  SumBgColor=#C3D0DB BgColor=#CCFFCC </C> 
								<C> Name='접수번호'	 ID=FSDTNB	  HeadAlign=Center HeadBgColor=#B9D4DC Width=101  align=center edit=none sort=true  SumBgColor=#C3D0DB </C> 
								<C> Name='순번'	     ID=FSNUM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=27 	align=center edit=none sort=false SumBgColor=#C3D0DB </C> 
								<C> Name='계정'	     ID=ATKORNAM  HeadAlign=Center HeadBgColor=#B9D4DC Width=98 	align=left   edit=none sort=true  SumBgColor=#C3D0DB </C> 
								<C> Name='적요'		 ID=REMARK    HeadAlign=Center HeadBgColor=#B9D4DC Width=200	align=left	 edit=none sort=true  SumBgColor=#C3D0DB  SumText='합   계'</C> 
								<C> Name='차변'		 ID=DEAMT 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right  edit=none sort=true  SumBgColor=#C3D0DB  SumText=@sum</C> 
								<C> Name='대변'		 ID=CRAMT 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=90	  align=right  edit=none sort=true  SumBgColor=#C3D0DB  SumText=@sum</C> 
								<C> Name='상태'		 ID=FSSTAT 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50	  align=center edit=none SumBgColor=#C3D0DB  EditStyle=Combo Data='Y:결재완료,R:결재요청,N:결재대기,C:결재취소,B:반송' </C> 
								<C> Name='거래처'	 ID=VEND_NM  HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left   edit=none sort=true  SumBgColor=#C3D0DB </C> 
								<C> Name='거래처코드'		 ID=VEND_CD 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left   edit=none sort=true  SumBgColor=#C3D0DB </C> 
								<C> Name='코드'	     ID=FSREFVAL  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left   edit=none sort=true  SumBgColor=#C3D0DB </C> 
								<C> Name='명칭'		 ID=CDNAM 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=left   edit=none sort=true  SumBgColor=#C3D0DB </C> 
								">
						</object></comment><script>__ws__(__NSID__);</script>   
						<fieldset style="position:relative;left:3px;width:877px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>		
<!-- ==================================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
========================================================================================================================-->


<!-----------------------------------------------------------------------------
	출력물 정의부분
------------------------------------------------------------------------------>
<comment id="__NSID__"><object  id="gcrp_print" classid="clsid:37D13B2F-E5EB-11D2-973D-00104B15E56F"> 
  <param NAME="MasterDataID"			VALUE="gcds_tempmst">
	<param NAME="DetailDataID"			VALUE="gcds_print01">
	<PARAM NAME="PaperSize"					    VALUE="A4">	
	<PARAM NAME="LandScape"					    VALUE="true">
  <PARAM NAME="PrintSetupDlgFlag"     VALUE="true">
	<PARAM NAME="PreviewZoom"				    VALUE="100">
	<PARAM NAME="FixPaperSize"					VALUE="true">
	<PARAM NAME="PrintMargine"					VALUE="false">
	<PARAM NAME="NullRecordFlag"		    VALUE="false">
	<!--<PARAM NAME="SuppressColumns"        VALUE="1:PAGESKIP,">-->
  <!--<param name="SuppressColumns"	value="1:pageskip,actdat;2:TOTAL"> -->
	<PARAM NAME="Format"                VALUE="
 <B>id=DHeader ,left=0,top=0 ,right=2871 ,bottom=389 ,face='Arial' ,size=10 ,penwidth=1
	<X>left=1024 ,top=71 ,right=1860 ,bottom=146 ,backcolor=#000000 ,border=true ,penstyle=solid ,penwidth=1</X>
	<X>left=1016 ,top=64 ,right=1852 ,bottom=143 ,backcolor=#C0C0C0 ,border=true ,penstyle=solid ,penwidth=1</X>
	<L> left=2500 ,top=320 ,right=2500 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2191 ,top=320 ,right=2191 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='전표번호' ,left=246 ,top=328 ,right=540 ,bottom=376 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=860 ,top=320 ,right=860 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=550 ,top=320 ,right=550 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=386 ,right=2810 ,bottom=386 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=318 ,right=2810 ,bottom=318 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='접수번호' ,left=558 ,top=328 ,right=849 ,bottom=376 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='차변' ,left=2199 ,top=328 ,right=2490 ,bottom=376 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='Page :#p of #t' ,left=2384 ,top=259 ,right=2807 ,bottom=312 ,align='right' ,face='굴림' ,size=10 ,bold=false ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='M_CURDT', left=2384, top=206, right=2807, bottom=254, align='right', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=238 ,top=320 ,right=238 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='대변' ,left=2508 ,top=328 ,right=2799 ,bottom=376 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=2810 ,top=320 ,right=2810 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='순번' ,left=865 ,top=328 ,right=960 ,bottom=376 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=968 ,top=323 ,right=968 ,bottom=384 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계정' ,left=976 ,top=328 ,right=1273 ,bottom=376 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<T>id='적요' ,left=1283 ,top=328 ,right=2180 ,bottom=376 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<L> left=1275 ,top=320 ,right=1275 ,bottom=381 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='계 정 별 조 회' ,left=1021 ,top=71 ,right=1844 ,bottom=135 ,face='HY중고딕' ,size=14 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#C0C0C0</T>
	<C>id='M_FDCODE', left=238, top=214, right=714, bottom=262, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='M_ACTDAT', left=238, top=265, right=1021, bottom=312, align='left', face='굴림', size=10, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=default ,left=0,top=0 ,right=2871 ,bottom=53 ,face='Arial' ,size=10 ,penwidth=1
	<L> left=2191 ,top=0 ,right=2191 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=968 ,top=0 ,right=968 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=550 ,top=0 ,right=550 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=860 ,top=3 ,right=860 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='SSDTNB', left=246, top=0, right=540, bottom=48, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=238 ,top=0 ,right=238 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=53 ,right=2810 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#A0A0A4 </L>
	<C>id='DEAMT', left=2199, top=3, right=2490, bottom=45, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='CRAMT', left=2508, top=0, right=2799, bottom=48, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF, Dec=0</C>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='FSDTNB', left=558, top=0, right=849, bottom=48, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='FSNUM', left=868, top=3, right=963, bottom=45, face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<C>id='ATKORNAM', left=974, top=5, right=1265, bottom=45, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=1275 ,top=0 ,right=1275 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<C>id='REMARK', left=1283, top=3, right=2180, bottom=45, align='left', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=238 ,top=53 ,right=2810 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2500 ,top=3 ,right=2500 ,bottom=53 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
<B>id=Tail ,left=0,top=0 ,right=2871 ,bottom=66 ,face='Arial' ,size=10 ,penwidth=1
	<C>id='{Sum(CRAMT)}', left=2508, top=0, right=2799, bottom=42, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
	<L> left=2185 ,top=5 ,right=2185 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=241 ,top=0 ,right=241 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=238 ,top=56 ,right=2810 ,bottom=56 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2500 ,top=0 ,right=2500 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<L> left=2810 ,top=0 ,right=2810 ,bottom=50 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
	<T>id='합                            계' ,left=251 ,top=0 ,right=2175 ,bottom=48 ,face='굴림' ,size=10 ,bold=true ,underline=false ,italic=false ,forecolor=#000000 ,backcolor=#FFFFFF</T>
	<C>id='{Sum(DEAMT)}', left=2196, top=0, right=2492, bottom=42, align='right', face='굴림', size=9, bold=false, underline=false, italic=false, forecolor=#000000, backcolor=#FFFFFF</C>
</B>
<B>id=Footer ,left=0 ,top=1884 ,right=2871 ,bottom=2000 ,face='Arial' ,size=10 ,penwidth=1
	<I>id='../../common/img/icon.jpg' ,left=2439 ,top=3 ,right=2818 ,bottom=85</I>
	<L> left=238 ,top=0 ,right=2810 ,bottom=0 ,penstyle=solid ,penwidth=2 ,pencolor=#000000 </L>
</B>
	">
</object></comment><script>__ws__(__NSID__);</script> 
<!-----------------------------------------------------------------------------
						B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 