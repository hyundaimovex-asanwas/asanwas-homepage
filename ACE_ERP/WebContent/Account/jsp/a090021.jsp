 <%@ page language="java" contentType="text/html;charset=euc-kr" %>
 <!---------------------------------------------------------------------------
+ 시 스 템 명	:  재무회계관리 - 자산조회,등록
+ 프로그램 ID	:  A090001.html
+ 기 능 정 의	:  자산내역조회를 등록, 조회, 출력한다./ 자산내역 상세 내용등록 
+ 작   성  자 :  하민숙
+ 작 성 일 자 :  
-----------------------------------------------------------------------------
+ 수 정 내 용 :  전체적인 수정
+ 수   정  자 :  정영식
+ 수 정 일 자 :  2009.11.11
-----------------------------------------------------------------------------
+ 수 정 내 용 :  전체적인 수정 (연말정산 때문에 연기했던거 다시 작업함.) 
+ 수   정  자 :  정영식
+ 수 정 일 자 :  2010.04.22
----------------------------------------------------------------------------
+ 수 정 내 용 :  운영서버 이관작업 소스 정리와 함께 파일명도 변경함.
+ 수   정  자 :  정영식
+ 수 정 일 자 :  2011.03.28
-----------------------------------------------------------------------------
+ 서 블 릿 명	:
------------------------------------------------------------------------------> 
<%@ page import="Account.common.*" %>

<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>  
<title>자산등록</title>
<!-----------------------------------------------------------------------------
		S T Y L E   S H E E T   L I N K   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<!-----------------------------------------------------------------------------
		C O M M O N   M O D U L E   S C R I P T S( MESSAGE & FUNCTION )
------------------------------------------------------------------------------>
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
var gs_date   = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2  = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_usernm = gusrnm;
var gs_deptcd = gdeptcd;
var gs_deptnm = gdeptnm;
var gs_fdcode = gfdcode;
var gs_cocode = gcocode;
var gstr_fsdat= "";
var tap5      = "";  //1-신규, 2-저장 ( 나중에 모두 삭제하자....필요없음.
var sasan     = "";

var gs_delete_gb=""; //자산등록 MST , BASIC 삭제 구분 

var gstrGubun ="";
var gstrAuthgr="";



/******************************************************************************
	Description : 로딩시 조회
******************************************************************************/
function fnOnLoad(tree_idx){
	fnInit_tree(tree_idx);	//트리초기화 호출

	ln_DispChk(0);	//조회 OR 등록 구분
	ln_Status(0);   //자산상태 - 정상 
	ln_Before();

  /** 사용안함.
	gcds_dept00.DataID = g_servlet+"/Account.a020001_s2?v_str1="+gs_userid;
	gcds_dept00.Reset();
	**/
	if(gclx_sfdcode.Enable==true)     gclx_sfdcode.BindColVal    =  gs_fdcode;		
	if(gclx_sfdcode2.Enable==true)    gclx_sfdcode2.BindColVal   =  gs_fdcode;
    gclx_sys_fr.index=0; //상태구분
	gclx_fsstat.index=0; //전표상태

	chkbox_divide.checked = false;

  //최초 토지일 경우 계정코드 설정
	if(gclx_ast2nd.bindcolval==""||gclx_ast2nd.bindcolval=="11"){
		gcem_atcode.text="1220100";
	}

  //최초자산번호 Display
	ln_S_Astnbr_Display();
  
	//권한체크 
	ln_Query_Authority2();

}


/******************************************************************************
 조회권한 신규
******************************************************************************/
function ln_Query_Authority2(){
	gcds_empno_chk.DataID="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010010_s1?v_str1=&v_str2="+gs_userid+"&v_str3=A1700110&v_str4=Y";
	gcds_empno_chk.Reset();
}


/******************************************************************************
 조회권한 결과 return 
******************************************************************************/
function ln_Authority_Result(row,colid){
  var cnt=0;
  gstrempno="'"+gs_userid+"',";

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

			if(i>=26){
        if(gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))!=""){ //사번존재 
					gstrempno+="'"+gcds_empno_chk.namevalue(row,gcds_empno_chk.ColumnID(i))+"',"				
				}
			}
		}

		if(cnt>0){
		  //2011.03.10 부서 맨앞과 맨뒤의 싱글코디션 제거
			gstrdeptcd=gstrdeptcd.substring(1,gstrdeptcd.length-2);
		}
		//2011.03.10 사번 맨앞과 맨뒤의 싱글코디션 제거
		gstrempno=gstrempno.substring(1,gstrempno.length-1);
	}

	if(gstrAuthgr=="A"){
		gstrGubun = gstrAuthgr;
	}else{
		gstrGubun="";
	}

}



/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 

  /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		1. 자산조회 
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
  //gcem_asq_fr.text = gs_date2 + "01";	    //취득일자 from
	//gcem_asq_fr.text = '19990101';          //취득일자 from
	gcem_asq_fr.text = '20010719';            //취득일자 from
	gcem_asq_to.text = gs_date;	              //취득일자 to 
	
	//지점코드[검색]
	gcds_sfdcode.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode.Reset();

	//자산중분류[검색]
	gcds_asdivcod.DataID ="<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101";  
	gcds_asdivcod.Reset();
  //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  
	/*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		2. 자산등록관리 상위부분
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
  //지점코드[검색]
	gcds_sfdcode2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_sfdcode2.Reset();

	//자산중분류[검색]
	gcds_ast2nd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2101"; 
	gcds_ast2nd.Reset();

  //^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

  /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		3. 자산등록관리 하위부분
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
	//3.1.기본 탭 
  //관리구분
	gcds_bgtgbcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2110";  
	gcds_bgtgbcd.Reset();

	//상태코드
	gcds_sys.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2106";  
	gcds_sys.Reset();

	//리스유무                                                                 
	gcds_bgtgbcd2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2113"; 
	gcds_bgtgbcd2.Reset();       
	
	//자산등급
	gcds_bgtgbcd3.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2112";  
	gcds_bgtgbcd3.Reset();

	//매출원가구분                                                          
	gcds_sys2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2102"; 
  gcds_sys2.Reset();              
	
	//자산구분                                                                   
	gcds_bgtgbcd4.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2111";   
	gcds_bgtgbcd4.Reset()                                                         
	
	//이 밑은 잘 모름
	/*********관리부서(현재사용부서)*///
	//고정자산이동 관리부서[검색]
	/**
	gcds_dept5.DataID =  "/servlet/Person.hcdept_s2?v_str1=";	
	gcds_dept5.Reset();
	**/

  //관리부서[검색]
	gcds_dept2.DataID = "/services/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept2.Reset();

	//관리부서[검색]
	gcds_dept3.DataID = "/services/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept3.Reset();

  //담당부서코드
	gcds_dept.DataID = "/services/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept.Reset();

	//관리부서[검색]
	gcds_dept4.DataID = "/services/servlet/Person.hcdept_s2?v_str1=";
	gcds_dept4.Reset();

	//고정자산이동 사용처
	//gcds_dept6.DataID = "/servlet/Person.hcdept_s2?v_str1=";
	//gcds_dept6.Reset();
  /*********관리부서*///
	
	//소속코드[검색]
	gcds_bfdivtcd.DataID = "/services/servlet/Person.hcdept_s3?v_str1=";
	gcds_bfdivtcd.Reset();

	//소속코드[입력]
	/**
	gcds_bfdivtcd1.DataID = "/servlet/Person.hcdept_s1?v_str1=";
	gcds_bfdivtcd1.Reset();
  **/

	//담당자코드[회계팀]
    gcds_empno.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0003";
	gcds_empno.Reset();

	//취득구분
	gcds_asaqsdiv.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2103";  
	gcds_asaqsdiv.Reset();
		
  /*^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		기타
	^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^*/
  //상각완료구분
	gcds_ASTDEPRST.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2151";  
	gcds_ASTDEPRST.Reset();

   //변경구분
	gcds_CHGTYPE.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2156";  
	gcds_CHGTYPE.Reset();

   //감소구분
	gcds_DECTYPE.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2155";  
	gcds_DECTYPE.Reset();

	 //해지여부
	gcds_CLOSEORNOT.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2158";  
	gcds_CLOSEORNOT.Reset();

	 //임대차구분
	gcds_LEASECLS.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2154";  
	gcds_LEASECLS.Reset();

	 //임차상태
	gcds_LEASESTS.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=2157";  
	gcds_LEASESTS.Reset();

    //거래처
	gcds_vend_cd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s0?v_str1=";  
	gcds_vend_cd.Reset();

   //은행코드
	gcds_bank2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010006_s4?v_str1=";
	gcds_bank2.Reset();  
}

/******************************************************************************
	Description : 자산조회
	Parameter   : 01-자산등록 최초 화면 조회,  그 외 - 자산등록 각 텝 조회 
******************************************************************************/
function ln_Query(s){  
  if(s=='01'){
		gcds_code01.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s1"
											 + "?v_str1="+gclx_sfdcode.BindColVal       //지점코드                                           
											 + "&v_str2="+gcem_asq_fr.text							//취득일자 from                                      
											 + "&v_str3="+gcem_asq_to.text							//취득일자 to                                        
											 + "&v_str4="+gclx_sys_fr.BindColVal				//상태구분 ^전체,0^정상, 1^매각,2^폐기,3^자본적지출  
											 + "&v_str5="+txt_COSTCD_1.value						//원가코드                                 
											 + "&v_str6="+gclx_asdivcod.BindColVal			//자산중분류                                         
											 + "&v_str7="+gclx_asdivcod_2.BindColVal		//자산소분류                                         
											 + "&v_str8="+gclx_sfdcode.BindColVal				//AST1ST ( 지점과 동일함 )                           
											 + "&v_str9="+gcem_jasan_1.text             //자산명코드
											 + "&v_str10="+txt_empno_1.value            //담당자
											 + "&v_str12="+txt_jasan_1.value            //자산명
											 + "&v_str13="+gclx_fsstat.Bindcolval       //전표상태
											 + "&v_str14="+txt_astuser_1.value;          //사용자
		//prompt("",gcds_code01.DataID);
		gcds_code01.Reset(); 
	
    
  //===================== 
  //등록에서 각 텝 조회 
	//=====================
  }else if(s=='02'){
    
      if(gcte_disp.ActiveIndex=='1'){
			  if(!ln_Chk('00')) return;
				ln_Mst_Query(gcem_asnbr_2.text);
				ln_Basic_Query(gcem_asnbr_2.text);
				ln_Buga_Query();
      }else if(gcte_disp.ActiveIndex=='2'){
        ln_Buga_Query();
      }else if(gcte_disp.ActiveIndex=='3'){
        ln_Gamga();
      }else if(gcte_disp.ActiveIndex=='4'){
        ln_Move();
      }else if(gcte_disp.ActiveIndex=='5'){
        ln_Gosuri();
      }else if(gcte_disp.ActiveIndex=='6'){
        ln_Insurance();
      }else if(gcte_disp.ActiveIndex=='7'){
        ln_Rental();
      }else if(gcte_disp.ActiveIndex=='8'){
        ln_Mortgage();
      }else if(gcte_disp.ActiveIndex=='9'){
        ln_Par();
      }
    }
}

/******************************************************************************
	Description : 자산원장 조회 OK 2010.04.29   
	      param : 자산번호  astnbr
******************************************************************************/
function ln_Mst_Query(p){  
	gcds_code00.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s2?v_str1="+p; 
	//prompt('',gcds_code00.DataID);
	gcds_code00.Reset();  
}
/******************************************************************************
	Description : 탭 1    기본정보조회  OK 
	parameter   : p - 자산번호 ( ASTNBR ) 
******************************************************************************/
function ln_Basic_Query(p){  
  if(gcds_code00.countrow>0){
		gcds_code02.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s3?v_str1="+p;   	
		//prompt('',gcds_code02.DataID );
		gcds_code02.Reset(); 	
	}
}

/******************************************************************************
	Description : 부가정보조회  OK 
	parameter   : 
******************************************************************************/
function ln_Buga_Query(){
	if((gclx_ast2nd.BindColVal=='11'||gclx_ast2nd.BindColVal=='12'||gclx_ast2nd.BindColVal=='13')&&gclx_ast3rd.BindColVal==''){
		ln_Buga1();
	}else if(gclx_ast2nd.BindColVal=='14'&&gclx_ast3rd.BindColVal!='') {  
		ln_Buga2();
	}else if(gclx_ast2nd.BindColVal=='15'||gclx_ast2nd.BindColVal=='16'||gclx_ast2nd.BindColVal=='17' ) {  
		ln_Buga3();  
	}
}

/******************************************************************************
	Description : 탭 2  부가정보1 조회   //토지,건물,건축물
******************************************************************************/
function ln_Buga1(){

  //키값6개 체크 해야함....
  //부가정보초기화 
	var str1 =  gclx_sfdcode2.BindColVal;            //지점코드  필수
	var str2 =  gcem_atcode.text;                    //계정코드  필수
	var str3 =  gclx_sfdcode2.BindColVal;            //1구분
	var str4 =  gclx_ast2nd.BindColVal;              //자산중분류  필수
	var str5 =  gclx_ast3rd.BindColVal;              //자산소분류  필수
	var str6 =  gcem_asnbr_2.text;                   //일련번호

	if(str5=="") str5="00";  	else str5 = gclx_ast3rd.BindColVal;
	gcds_code31.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s4"		
										 + "?v_str1="+str1+ "&v_str2="+str2
										 + "&v_str3="+str3+"&v_str4="+str4										
										 + "&v_str5="+str5+"&v_str6="+str6.substring(3,9);
	gcds_code31.Reset();
}

/******************************************************************************
	Description : 탭 2       부가정보2 조회 //차량운반구
******************************************************************************/
function ln_Buga2(){

	//키값6개 체크 해야함....
  //부가정보초기화 
	var str1 =  gclx_sfdcode2.BindColVal;       //지점코드  필수
	var str2 =  gcem_atcode.text;               //계정코드   필수
	var str3 =  gclx_sfdcode2.BindColVal;       //1구분
	var str4 =  gclx_ast2nd.BindColVal;         //자산중분류  필수
	var str5 =  gclx_ast3rd.BindColVal;         //자산소분류  필수
	var str6 =  gcem_asnbr_2.text;              //일련번호
 
  if(str5=="") str5="00";  	else str5 = gclx_ast3rd.BindColVal;
	//if(ln_Chk()){
	gcds_code32.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s11"		
										+ "?v_str1="+str1+"&v_str2="+str2
										+ "&v_str3="+str3+"&v_str4="+str4										
										+ "&v_str5="+str5+"&v_str6="+str6.substring(3,9);
   //prompt("",gcds_code32.DataID);	
	gcds_code32.Reset();
}
/******************************************************************************
	Description : 탭 3        부가정보3 조회 //기계장치,공기구비품,기타유형자산
******************************************************************************/
function  ln_Buga3(){
  //키값6개 체크 해야함....
  //부가정보초기화 
	var str1 =  gclx_sfdcode2.BindColVal;       //지점코드  필수
	var str2 =  gcem_atcode.text;               //계정코드   필수
	var str3 =  gclx_sfdcode2.BindColVal;       //1구분
	var str4 =  gclx_ast2nd.BindColVal;         //자산중분류  필수
	var str5 =  gclx_ast3rd.BindColVal;         //자산소분류  필수
	var str6 =  gcem_asnbr_2.text;              //일련번호

	if(str5=="")   str5="00"; 	else str5 = gclx_ast3rd.BindColVal;     
	//if(ln_Chk()){
	gcds_code33.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s12"		
										+ "?v_str1="+str1+"&v_str2="+str2
										+ "&v_str3="+str3+"&v_str4="+str4										
										+ "&v_str5="+str5+"&v_str6="+str6.substring(3,9);
	//prompt('gcds_code33.DataID ',gcds_code33.DataID );
	gcds_code33.Reset();

}

/******************************************************************************
	Description : 탭 3 감가상각 조회 OK
******************************************************************************/
function ln_Gamga(){
  
//	alert("gcem_asnbr_2:::"+gcem_asnbr_2.text);
	if (gcem_asnbr_2.text=="") return 
	var str1 = gclx_sfdcode2.BindColVal;           //지점코드   필수
	var str2 = gcem_atcode.text;                   //계정코드   필수
	var str3 = gclx_sfdcode2.BindColVal;           //1구분
	var str4 = gclx_ast2nd.BindColVal;             //자산중분류  필수
	var str5 = gclx_ast3rd.BindColVal;             //자산소분류  필수
	var str6 = gcem_asnbr_2.text;                  //일련번호

	if(str5=="") str5="00";
	else str5 = gclx_ast3rd.BindColVal;

	//조건이 없을 경우 조회 안되게 함.
	gcds_code04.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s5"		
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4										
											+ "&v_str5="+str5+"&v_str6="+str6.substring(3,9);

  //prompt('Gamga',gcds_code04.DataID); 
	gcds_code04.Reset();
 
}

/******************************************************************************
	Description : 탭 4   고정자산이동 조회 OK
******************************************************************************/
function ln_Move(){
	if (gcem_asnbr_2.text=="") return 
	var str1 =  gclx_sfdcode2.BindColVal;     //지점코드  필수
	var str2 =  gcem_atcode.text;             //계정코드   필수
	var str3 =  gclx_sfdcode2.BindColVal;     //1구분
	var str4 =  gclx_ast2nd.BindColVal;       //자산중분류  필수
	var str5 =  gclx_ast3rd.BindColVal;       //자산소분류  필수
	var str6 =  gcem_asnbr_2.text;            //일련번호

	if(str5=="") str5="00";
	else str5 = gclx_ast3rd.BindColVal;
	gcds_code12.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s13"		
										 + "?v_str1="+str1+"&v_str2="+str2
										 + "&v_str3="+str3+"&v_str4="+str4										
										 + "&v_str5="+str5+"&v_str6="+str6.substring(3,9);
	//prompt('',gcds_code12.DataID);
	gcds_code12.Reset();
}

/******************************************************************************
	Description : 탭 5 고정자산수리 조회 OK
******************************************************************************/
function ln_Gosuri(){
	if (gcem_asnbr_2.text=="") return 
	var str1 =  gclx_sfdcode2.BindColVal;        //지점코드  필수
	var str2 =  gcem_atcode.text;                //계정코드   필수
	var str3 =  gclx_sfdcode2.BindColVal;        //1구분
	var str4 =  gclx_ast2nd.BindColVal;          //자산중분류  필수
	var str5 =  gclx_ast3rd.BindColVal;          //자산소분류  필수
	var str6 =  gcem_asnbr_2.text;               //일련번호
	
	if(str5=="") str5="00";  	else str5 = gclx_ast3rd.BindColVal;
	gcds_code05.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s6"		
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4										
											+ "&v_str5="+str5+"&v_str6="+str6.substring(3,9);
	//prompt('',gcds_code05.DataID);
	gcds_code05.Reset();
}
 
/******************************************************************************
	Description : 탭 6 보험 조회    OK
******************************************************************************/
function ln_Insurance(){
	
	if (gcem_asnbr_2.text=="") return 
	var str1 =  gclx_sfdcode2.BindColVal;        //지점코드  필수
	var str2 =  gcem_atcode.text;                //계정코드   필수
	var str3 =  gclx_sfdcode2.BindColVal;        //1구분
	var str4 =  gclx_ast2nd.BindColVal;          //자산중분류  필수
	var str5 =  gclx_ast3rd.BindColVal;          //자산소분류  필수
	var str6 =  gcem_asnbr_2.text;               //일련번호

	if(str5=="") str5="00";  	else str5 = gclx_ast3rd.BindColVal;
	gcds_code06.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s7"		
										 + "?v_str1="+str1+"&v_str2="+str2
										 + "&v_str3="+str3+"&v_str4="+str4										
										 + "&v_str5="+str5+"&v_str6="+str6.substring(3,9);
	gcds_code06.Reset();
}
   
/******************************************************************************
	Description : 탭 7 임대/임차 조회 OK
******************************************************************************/
function ln_Rental(){

	if (gcem_asnbr_2.text=="") return 
	var str1 =  gclx_sfdcode2.BindColVal;        //지점코드  필수
	var str2 =  gcem_atcode.text;                //계정코드   필수
	var str3 =  gclx_sfdcode2.BindColVal;        //1구분
	var str4 =  gclx_ast2nd.BindColVal;          //자산중분류  필수
	var str5 =  gclx_ast3rd.BindColVal;          //자산소분류  필수
	var str6 =  gcem_asnbr_2.text;               //일련번호

	if(str5=="") str5="00";  	else str5 = gclx_ast3rd.BindColVal;
	gcds_code13.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s14"		
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4										
											+ "&v_str5="+str5+"&v_str6="+str6.substring(3,9);
	gcds_code13.Reset();

}
/******************************************************************************
	Description : 탭 8 근저당 조회  OK
******************************************************************************/
function ln_Mortgage(){

	if (gcem_asnbr_2.text=="") return 
	var str1 =  gclx_sfdcode2.BindColVal;         //지점코드  필수
	var str2 =  gcem_atcode.text;                 //계정코드   필수
	var str3 =  gclx_sfdcode2.BindColVal;         //1구분
	var str4 =  gclx_ast2nd.BindColVal;           //자산중분류  필수
	var str5 =  gclx_ast3rd.BindColVal;           //자산소분류  필수
	var str6 =  gcem_asnbr_2.text;                //일련번호
 
	if(str5=="") str5="00";  	else str5 = gclx_ast3rd.BindColVal;
	gcds_code08.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s9"		
											+ "?v_str1="+str1+"&v_str2="+str2
											+ "&v_str3="+str3+"&v_str4="+str4										
											+ "&v_str5="+str5+"&v_str6="+str6.substring(3,9);
	
	gcds_code08.Reset();

}

/******************************************************************************
	Description : 탭 9  평가 조회
******************************************************************************/
function ln_Par(){

	if (gcem_asnbr_2.text=="") return 
	var str1 =  gclx_sfdcode2.BindColVal;        //지점코드  필수
	var str2 =  gcem_atcode.text;                //계정코드   필수
	var str3 =  gclx_sfdcode2.BindColVal;        //1구분
	var str4 =  gclx_ast2nd.BindColVal;          //자산중분류  필수
	var str5 =  gclx_ast3rd.BindColVal;          //자산소분류  필수
	var str6 =  gcem_asnbr_2.text;               //일련번호

	if(str5=="") str5="00";  	else str5 = gclx_ast3rd.BindColVal;
	gcds_code07.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s8"		
										 + "?v_str1="+str1+"&v_str2="+str2
										 + "&v_str3="+str3+"&v_str4="+str4										
										 + "&v_str5="+str5+"&v_str6="+str6.substring(3,9);	
	gcds_code07.Reset();
}

/******************************************************************************
	Description : 자산저장버튼 활성화  1:매각, 2:폐기, 0:정상  OK
******************************************************************************/
function ln_Status(p){  
 //alert("p:::::::::::"+p);
	if (p!='0'){
		document.all.btn_save.style.display='none';
		document.all.btn_off_save.style.display='block';
	}else {
		document.all.btn_save.style.display='block';
		document.all.btn_off_save.style.display='none';
	}
}

/******************************************************************************
	Description : 추가
	parameter   : 01 - 자산MST & BASIC
******************************************************************************/
function ln_Add(p){ 
 	
	if (p=='01'){
	  ln_DataSet_Clear();
		ln_DispChk(1);	 
		ln_Status('0');         //자산저장버튼 활성화  정상
		ln_SetDataHeader("00"); //자산MST
    ln_SetDataHeader("02"); //자산BASIC

		gcds_code00.addrow();
		gcds_code02.addrow();
		gcte_disp.ActiveIndex='1';
		gclx_aststat.index = 2 ; 
		
		ln_Initial_Setting();	

		ln_Enable("t");
	}
}

/******************************************************************************
	신규등록시 데이터셋 초기화 OK
******************************************************************************/
function ln_DataSet_Clear(){
	gcds_code00.clearall(); //자산등록
	gcds_code02.clearall(); //자산기본
	gcds_code31.clearall(); //부가정보1
	gcds_code32.clearall(); //부가정보2
	gcds_code33.clearall(); //부가정보3
	gcds_code12.clearall(); //자산이동

}

/******************************************************************************
	신규등록시 초기 셋팅 OK
******************************************************************************/
function ln_Initial_Setting(){
  /**
  if(gclx_sfdcode2.Enable==true){
		gclx_sfdcode2.BindColVal=gs_fdcode;
	}
	**/

  gclx_sfdcode2.BindColVal=gs_fdcode;

  
	//자산중분류
  if(gclx_ast2nd.bindcolval==""){
		gclx_ast2nd.bindcolval="16";    //공기구비품
	}

  //자산소분류 찾기
  ln_Find_Ast3rd();
  
	//자산소분류
  if(gclx_ast3rd.bindcolval==""){
		gclx_ast3rd.bindcolval="04";   //OA기기
	}

	//분할저장, 
	chkbox_divide.checked==false;
	gcem_total.text=0;
    gcem_total.Enable =false;

    //2011.08.31 이종훈GJN 요청으로 막음. 
	//취득일자
	//gcem_asaqsdat.text = gs_date;
	
	
	//담당자, 담당부서 셋팅 
	txt_empnm.value = gusrnm;
	txt_empno.value = gusrid;
	txt_cadeptcd_3.value = gdeptcd;
	txt_cadeptnm_3.value = gdeptnm;

	//자산구분, 취득구분, 상태코드, 등록구분, 상각처리구분
    gclx_goddiv.bindcolval="1";
	gclx_asaqsdiv.bindcolval="1";
	gclx_aststat.bindcolval="0";    //0-정상, 1-매각, 2-폐기
	gclx_regigb.bindcolval="1";
	gclx_deprgb.bindcolval="1";

	//내용연수/취득금액 0
	//gcem_ASTYUSE.text=0.00;
	//gcem_ASTYUSE.text=5.00;
	gcem_ASTAQAMT.text=0;

	//수량 1
	gcem_ASTQTY.text=1;
	gcem_ASTQTY.ReadOnly = true;

    ln_S_Astnbr_Display();  //최초자산번호 display

	gcem_s_astnbr.text="";
	gcem_mordt.text="";

	ln_Find_Atcode();     //계정코드 찾기 
	ln_Durable_Setting(); //내용연수 Default Setting 


	fn_AdInfo_Set(); //부가정보


}

/******************************************************************************
	Description : 평가탭에서 변경되면 기본정보에 자동업데이트

	@@일단보류 : 평가가 감가상각에 미치는 영향 등 고려해서 다시 적용해야함.
******************************************************************************/
function ln_update(){

	var str1  =  gclx_sfdcode2.BindColVal;          //지점코드   필수
	var str3  =  gclx_ast2nd.BindColVal;            //자산중분류 필수
	var str4  =  gclx_ast3rd.BindColVal;            //자산소분류 필수
	var str5  =	 gcem_atcode.text;                  //계정코드   필수
	var str6  =  gcem_asaqsdat.text;                //취득일자 			
	var str22 =  gcem_EVALAMT.text;                 //취득금액
	var str23 =  gcem_EVALAFYEAR.text;              //내용년수
	var str31 =  gcem_asnbr_2.text.substring(3,9);  //일련번호  		
	// if(str20=="") str20 = "0"; else str20= gcem_ASTQTY.text;	
	var IsUpdated = "3";
	if(str4=="") str4="00"; 	else str4 = gclx_ast3rd.BindColVal;

	gctr_code02.KeyValue   = "Account.a090001_t2(I:USER=gcds_code02)";
	gctr_code02.Action     = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t2?";
	gctr_code02.Parameters = "v_str1="+str1+",v_str3="+str3+",v_str4="+str4
	                       +",v_str5="+str5+",v_str6="+str6+",v_str22="+str22
												 +",v_str23="+str23+",v_str31="+str31+",IsUpdated="+IsUpdated;		

	//prompt("",gcds_code02.text);
	gctr_code02.post();	
}

/******************************************************************************
	Description : 자산이동시 자산기본의 관리부서 사용부서 UPDATE
	@@일단보류 : 사용안함.
******************************************************************************/
function ln_Move_update(){

  alert("사용안함.");
	return;

	var str1 =  gclx_sfdcode2.BindColVal;         //지점코드  필수		
	var str2 =  gclx_ast2nd.BindColVal;           //자산중분류  필수
	var str3 =  gclx_ast3rd.BindColVal;           //자산소분류  필수		
	var str4 =  gcem_asnbr_2.text.substring(3,9); //일련번호

  if(str3=="") str3="00"; 	else str3 = gclx_ast3rd.BindColVal;

	gcds_code17.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s19"	
										 + "?v_str1="+str1+"&v_str2="+str2
										 + "&v_str3="+str3+"&v_str4="+str4;
	gcds_code17.Reset();


	if(gcds_code17.countrow>0){

		var str1  = gclx_sfdcode2.BindColVal;            //지점코드  필수
		var str3  = gclx_ast2nd.BindColVal;              //자산중분류  필수
		var str4  = gclx_ast3rd.BindColVal;              //자산소분류  필수
		var str25 = gcds_code17.namevalue(1,"AMNGDEPT"); //관리부서  
		var str26 = gcds_code17.namevalue(1,"AUSEDEPT"); //사용처  
    var str31 = gcem_asnbr_2.text.substring(3,9);    //일련번호  
    var IsUpdated = "4";
 	  
		if(str4=="") str4="00"; 	else str4 = gclx_ast3rd.BindColVal;

		/**
    gctr_code02.KeyValue   =  "Account.a090001_t2(I:USER=gcds_code02)";
	  gctr_code02.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t2?";
		gctr_code02.Parameters =  "v_str1="+str1+ ",v_str3="+str3+",v_str4="+str4+
 	  ",v_str25="+str25+",v_str26="+str26+
	  ",v_str31="+str31+
		",IsUpdated="+IsUpdated;			
		gctr_code02.post();	
		**/
	}
}
/******************************************************************************
	Description : 자산이동첫등록시 ==> 사용안함.
******************************************************************************/
function ln_Move_update2(){

  alert("사용안함.");
	return;

	if(sasan=='0') {	
		gcte_disp.ActiveIndex='1';
		ln_Basic_Query();
		var str1 =   gclx_sfdcode2.BindColVal;               //지점코드  필수
		var str2 =	  gcem_atcode.text;                    //계정코드   필수
		var str3 =   gclx_sfdcode2.BindColVal;            //1구분
		var str4 =   gclx_ast2nd.BindColVal;          //자산중분류  필수
		var str5 =   gclx_ast3rd.BindColVal;       //자산소분류  필수
		var str6 =   gcem_asnbr_2.text.substring(3,9);  //일련번호

		if(str5=="") str5="00"; else str5= gclx_ast3rd.BindColVal; 	

		var str11 = txt_MYPLAN.value;            //이동내역 
		var str12 = "";             //작성일   
		var str13 = "";             //작성자     
		var str7 =  gcem_asaqsdat.text;              //취득일자
		var str8 =  txt_mngdpt.value;     //관리부서 
		var str9 =  txt_usedpt.value;       //사용처 
		var str10 = txt_COSTCD.value;              //원가코드
			 
		var ASTMOVNO ='0000';
			
		var IsUpdated = "4";
		gctr_code12.KeyValue   =  "Account.a090001_t12(I:USER=gcds_code12)";
		gctr_code12.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t12?";
		gctr_code12.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
		",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
		",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+
		",ASTMOVNO="+ASTMOVNO+
		",IsUpdated="+IsUpdated;

		gctr_code12.post();	
		gcte_disp.ActiveIndex='4';

		ln_Move();
	}else if(sasan=='1'){
    ln_Move_update();
    ln_Basic_Query();
	}
}


/******************************************************************************
	Description : 저장
                분할저장 추가함.             
  Parameter   : 02 - 자산mst, 자산Basic, 부가정보, 감가상각, 자산이동
******************************************************************************/
function ln_Save(e){

	if(e=="02"){
		if(!ln_Chk_Save('01')) return;  //자산MST
		if(!ln_Chk_Save('02')) return;  //자산BASIC
   
		//alert("AST3RD"+gcds_code00.namevalue(gcds_code00.rowposition,"AST3RD"));
    
		if(gcds_code00.namevalue(gcds_code00.rowposition,"AST3RD")==""){
		    gcds_code00.namevalue(gcds_code00.rowposition,"AST3RD") ="00"; 
				gcds_code02.namevalue(gcds_code02.rowposition,"AST3RD") ="00"; 
				gcds_code31.namevalue(gcds_code31.rowposition,"AST3RD") ="00"; 
				gcds_code32.namevalue(gcds_code32.rowposition,"AST3RD") ="00"; 
				gcds_code33.namevalue(gcds_code33.rowposition,"AST3RD") ="00"; 
		}
    
    
		//prompt('M gcds_code00',gcds_code00.text);
		//prompt('M gcds_code02',gcds_code02.text);
		//prompt('M gcds_code31',gcds_code31.text);
		//prompt('M gcds_code32',gcds_code32.text);
		//prompt('M gcds_code33',gcds_code33.text); 
    

		if(gcds_code00.SysStatus(gcds_code00.RowPosition)==0&&gcds_code02.SysStatus(gcds_code02.RowPosition)==0&&
		   gcds_code31.SysStatus(gcds_code31.RowPosition)==0&&gcds_code32.SysStatus(gcds_code32.RowPosition)==0&&
			 gcds_code33.SysStatus(gcds_code33.RowPosition)==0){
			 alert("저장할 데이터가 없습니다.");
			 return false;
		}

		if(gcds_code00.SysStatus(gcds_code00.RowPosition)=="1"){ //신규입력건만 가능
			//분할 저장 ( 1건 입력으로 갯수만큼 저장함.) 
			if(chkbox_divide.checked==true&&gcem_total.text>0){
				if(confirm("총 "+gcem_total.text+" 건으로 [분할저장] 하시겠습니까?")){
					gctr_code00.KeyValue   =  "Account.a090001_t1_m1(I:USER=gcds_code00,I:USER2=gcds_code02,I:USER31=gcds_code31,I:USER32=gcds_code32,I:USER33=gcds_code33,O:USER99=gcds_code99)";
					gctr_code00.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t1_m1?";
					gctr_code00.Parameters =  "v_str1="+gs_date+",v_str2="+gs_userid+",v_str3="+gcem_total.text;
					
					/**
					prompt('M gcds_code00',gcds_code00.text);
					prompt('M gcds_code02',gcds_code02.text);
					prompt('M gcds_code31',gcds_code31.text);
					prompt('M gcds_code32',gcds_code32.text);
					prompt('M gcds_code33',gcds_code33.text);
					**/
					
					gctr_code00.post();
					return;
				}else{
					return;
				}
			}
		}

    
		//수정시 체크 
		if(!ln_Chk_Update()) return;

		//신규입력이 아닌데 분할저장은 입력 못하게 체크해야함.
  	if(confirm("저장 하시겠습니까?")){
			//그냥 저장 ( 1건 저장) 
			gctr_code00.KeyValue   =  "Account.a090001_t1_1(I:USER=gcds_code00,I:USER2=gcds_code02,I:USER31=gcds_code31,I:USER32=gcds_code32,I:USER33=gcds_code33,O:USER99=gcds_code99)";
			gctr_code00.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t1_1?";
			gctr_code00.Parameters =  "v_str1="+gs_date+",v_str2="+gs_userid;

     		/*
			prompt('gcds_code00',gcds_code00.text);
			prompt('gcds_code02',gcds_code02.text);
			prompt('gcds_code31',gcds_code31.text);
			prompt('gcds_code32',gcds_code32.text);
			prompt('gcds_code33',gcds_code33.text);
			prompt('gcds_code99',gcds_code99.text);
			*/
			
			gctr_code00.post();
		}

		/*****************************************
		이체 등록 건만 감가상각 등록 가능하게 함. 
		*****************************************/
      /**
		  if(gcte_disp.ActiveIndex=='3' ){ // 감가상각

		  
      var str1 =   gclx_sfdcode2.BindColVal;         //지점코드  필수
      var str2 =   gcem_atcode.text;                 //계정코드  필수
      var str3 =   gclx_sfdcode2.BindColVal;         //1구분
      var str4 =   gclx_ast2nd.BindColVal;           //자산중분류 필수
      var str5 =   gclx_ast3rd.BindColVal;           //자산소분류 필수
      var str6 =   gcem_asnbr_2.text.substring(3,9); //일련번호
      var str7 =   gcem_ASTAQAMT.text;               //취득금액
      var str8 =   gcem_ASTYUSE2.text;               //내용년수
      var str9 =   gcem_ASTRMAMT.text;               //잔존가액
      var str10=   gclx_ASTDEPRST.BindColVal;        //감가상각완료구분 
      var str11=   gcem_DEPRENDDT.text;              //가상각완료일
      var str13=   gcem_ACDEPRAMT.text;               //전기증가누계액
      var str14=   gcem_ABDECAMT.text;               //기감소누계액
      var str16=   gcem_ABDEPRAMT.text;              //기상각누계액		 
      var str17=   gcem_ABBOOKAMT.text;              //장부가액
      if(str5=="")  str5="00"; 	else str5 = gclx_ast3rd.BindColVal;
      if(str7=="")  str7="0"; 	else str7=  gcem_ASTAQAMT2.text;
      if(str8=="")  str8="0";   else str8=  gcem_ASTYUSE2.text;   
      if(str9=="")  str9="0"; 	else str9=  gcem_ASTRMAMT.text;
      if(str13=="") str13="0"; 	else str13= gcem_ACDEPRAMT.text; 
      if(str14=="") str14="0"; 	else str14= gcem_ABDECAMT.text; 
      if(str16=="") str16="0"; 	else str16= gcem_ABDEPRAMT.text;  
      if(str17=="") str17="0"; 	else str17= gcem_ABBOOKAMT.text;  
      
	  if(gamga=='0'){
        var IsUpdated = "1";
        gctr_code04.KeyValue   =  "Account.a090001_t4(I:USER=gcds_code04)";
        gctr_code04.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t4?";
        gctr_code04.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
        ",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
        ",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+
        ",v_str13="+str13+",v_str14="+str14+
        ",v_str16="+str16+ ",v_str17="+str17+
        ",IsUpdated="+IsUpdated;		
        gctr_code04.post();	  
      }else{
        var IsUpdated = "2";
        gctr_code04.KeyValue   =  "Account.a090001_t4(I:USER=gcds_code04)";
        gctr_code04.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t4?";
        gctr_code04.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
        ",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
        ",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+
        ",v_str13="+str13+",v_str14="+str14+
        ",v_str16="+str16+ ",v_str17="+str17+
        ",IsUpdated="+IsUpdated;	

        gctr_code04.post();	  
				
      }
		}**/
  } ////////////////////////////////////////////////////////////// (e=='02') end
}


/******************************************************************************
	Description : 데이터 수정시 체크
	Parameter 	: 

******************************************************************************/
function ln_Chk_Update(){

	  ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		//alert(":gcds_code00:"+gcds_code00.SysStatus(gcds_code00.RowPosition)+":gcds_code02:"+gcds_code02.SysStatus(gcds_code02.RowPosition));
		//alert(":OrgNameValue:"+gcds_code00.OrgNameValue(gcds_code00.RowPosition,"ASAQSDAT")+":namevalue:"+gcds_code00.namevalue(gcds_code00.RowPosition,"ASAQSDAT"));
		//alert(":OrgNameValue:"+gcds_code00.OrgNameValue(gcds_code00.RowPosition,"ASTNAME")+":namevalue:"+gcds_code00.namevalue(gcds_code00.RowPosition,"ASTNAME"));
		//alert(":OrgNameValue:"+gcds_code02.OrgNameValue(gcds_code02.RowPosition,"COSTCD")+":namevalue:"+gcds_code02.namevalue(gcds_code02.RowPosition,"COSTCD"));
		//수정일 경우 체크 
		//자산MST   : 취득일자, 자산명,   담당자,   담당부서  수정금지
		//자산BASIC : 취득구분, 원가코드, 사용부서, 관리부서, 사용자, 상각처리구분 수정금지..
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

       if(gcds_code00.OrgNameValue(gcds_code00.RowPosition,"ASAQSDAT")!=gcds_code00.namevalue(gcds_code00.RowPosition,"ASAQSDAT")){
			alert("취득일자가 변경되었습니다. 수정할 수 없습니다.");
			return false;  
		}

		if(gcds_code00.OrgNameValue(gcds_code00.RowPosition,"ASTNAME")!=gcds_code00.namevalue(gcds_code00.RowPosition,"ASTNAME")){
			alert("자산명이 변경되었습니다. 수정할 수 없습니다.");
			return false;  
		}

		if(gcds_code00.OrgNameValue(gcds_code00.RowPosition,"EMPNO")!=gcds_code00.namevalue(gcds_code00.RowPosition,"EMPNO")){
			alert("담당자가 변경되었습니다. 수정할 수 없습니다.");
			return false;  
		}

		if(gcds_code00.OrgNameValue(gcds_code00.RowPosition,"DEPTCD")!=gcds_code00.namevalue(gcds_code00.RowPosition,"DEPTCD")){
			alert("담당부서가 변경되었습니다. 수정할 수 없습니다.");
			return false;  
		}

		if(gcds_code02.OrgNameValue(gcds_code02.RowPosition,"COSTCD")!=gcds_code02.namevalue(gcds_code02.RowPosition,"COSTCD")){
			alert("원가코드가 변경되었습니다. 수정할 수 없습니다.");
			return false;  
		}

  		if(gcds_code02.OrgNameValue(gcds_code02.RowPosition,"USEDPT")!=gcds_code02.namevalue(gcds_code02.RowPosition,"USEDPT")){
			alert("사용부서가 변경되었습니다. 수정할 수 없습니다.");
			return false;  
		}

	 	 if(gcds_code02.OrgNameValue(gcds_code02.RowPosition,"ASTUSER")!=gcds_code02.namevalue(gcds_code02.RowPosition,"ASTUSER")){
			alert("사용자가 변경되었습니다. 수정할 수 없습니다.");
			return false;  
		}

		return true;
}

/******************************************************************************
	Description : 기본저장 이외의 저장
	Parameter 	: 저장 구분
	              03-자산수리,  04-보험,  05-평가,  06-근저당,  07-변경
								08-자산이동,  09-임대/임차   

								==> 변경부분은 삭제함.(a090001_t9)
******************************************************************************/
function ln_Save_Rest(e){

	/***고정자산수리 저장부분***e='03'*/
	if(e=='03'){
		var gosu =  gcds_code05.countrow;               // 고정자산수리
		var str1 =  gclx_sfdcode2.BindColVal;           //지점코드  필수
		var str2 =	gcem_atcode.text;                   //계정코드  필수
		var str3 =  gclx_sfdcode2.BindColVal;           //1구분
		var str4 =  gclx_ast2nd.BindColVal;             //자산중분류  필수
		var str5 =  gclx_ast3rd.BindColVal;             //자산소분류  필수
		var str6 =  gcem_asnbr_2.text.substring(3,9);   //일련번호
		var str7 =  gcem_REPAIRDATE.text; 		          //수리일         REPAIRDATE
		var str8 =  txt_REPAIRPART.value;              //수리처         REPAIRPART  
		var str9 =  txt_DEFECTNOTE.value                //불량내용       DEFECTNOTE
		var str10 = gcem_REPAIRAMT.text;                //수리금액       REPAIRAMT
		var str11 = "";                                 //판정           REPAIRJUDG
		var str12 = "";                                 //당기증가여부T  INCORNOT
		var str13 = ""; 	                              //작성일         WRDT
		var str14 = "";                                 //작성자         WRID

		if(str5=="") str5="00"; else str5= gclx_ast3rd.BindColVal; 
		if(str10=="") str10="0"; else str10=gcem_REPAIRAMT.text;

		if(tap5=='1'){ //INSERT
			var IsUpdated = "1";
			gctr_code05.KeyValue   =  "Account.a090021_t5(I:USER=gcds_code05)";
			gctr_code05.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t5?";
			gctr_code05.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
			",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+	",v_str13="+str13+",v_str14="+str14+	
			",IsUpdated="+IsUpdated;	
			gctr_code05.post();	  			
		}else{
			if(gosu!='0'){ //기존 데이터가 존재할 경우 
				var IsUpdated = "2";
				var REPAIRNO = gcds_code05.namevalue(gcds_code05.rowposition,"REPAIRNO");
				var str11 = "";              //판정         REPAIRJUDG
				var str12 = "";    

				gctr_code05.KeyValue   =  "Account.a090021_t5(I:USER=gcds_code05)";
				gctr_code05.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t5?";
				gctr_code05.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
				",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
				",v_str9="+str9+",v_str10="+str10+ ",v_str13="+str13+",v_str14="+str14+	
				",IsUpdated="+IsUpdated+
				",REPAIRNO="+REPAIRNO;	
				gctr_code05.post();	  
			}
		}
			
		tap5="";
	}// (e=='03') end

  /***보험 저장부분***e='04'*/
	if(e=='04'){
		 	 var str1 = gclx_sfdcode2.BindColVal;          //지점코드  필수
			 var str2 =	gcem_atcode.text;                  //계정코드  필수
			 var str3 = gclx_sfdcode2.BindColVal;          //1구분
			 var str4 = gclx_ast2nd.BindColVal;            //자산중분류  필수
			 var str5 = gclx_ast3rd.BindColVal;            //자산소분류  필수
			 var str6 = gcem_asnbr_2.text.substring(3,9);  //일련번호
			 var str7 = gcem_INSUREDATE.text;              //보험일    INSUREDATE
			 var str8 = gcem_INSHEETNO.text;               //보험번호  INSHEETNO
			 var str9 = gcem_INSSTARTDT.text;              //시작일    INSSTARTDT
			 var str10 = gcem_INSENDDT.text;               //만료일    INSENDDT
			 var str11 = gcem_INSTERM.text;                //계약기간  INSTERM
			 var str12 = gcem_INSAMT.text;                 //금액      INSAMT
			 var str13 = gcem_INSEDAMT.text;               //보험금액  INSEDAMT
			 var str14 = txt_INSFIRM.value;               //보험회사  INSFIRM
			 var str15 = txt_INSNOTE.value;                //비고      INSNOTE
			 var str16 = "";                               //작성일    WRDT
       var str17 = "";                               //작성자    WRID

      if(str5=="") str5="00"; else str5= gclx_ast3rd.BindColVal; 
			if(str12=="") str12="0"; else str12=gcem_INSAMT.text;   
			if(str13=="") str13="0"; else str13=gcem_INSEDAMT.text;    

		if(tap5=='1'){ //INSERT
			var IsUpdated = "1";
			gctr_code06.KeyValue   =  "Account.a090021_t6(I:USER=gcds_code06)";
			gctr_code06.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t6?";
			gctr_code06.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
			",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+",v_str14="+str14+	
			",v_str15="+str15+",v_str16="+str16+ ",v_str17="+str17+
			",IsUpdated="+IsUpdated;	
			gctr_code06.post();	  
		}else{
			var IsUpdated = "2";
			var INSURENO = gcds_code06.namevalue(gcds_code06.rowposition,"INSURENO");
			gctr_code06.KeyValue   =  "Account.a090021_t6(I:USER=gcds_code06)";
			gctr_code06.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t6?";
			gctr_code06.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
			",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+",v_str14="+str14+	
			",v_str15="+str15+",v_str16="+str16+ ",v_str17="+str17+
			",IsUpdated="+IsUpdated+
			",INSURENO="+INSURENO;	

			gctr_code06.post();	  
		}
		tap5="";
	}// (e=='04') end

	/***평가 저장부분***e='05*/
	/********************************************
   일단 보류 
	********************************************/
	if(e=='05'){
	  alert("평가 일단보류") ;
		return;
		ln_update();
		var str1 = gclx_sfdcode2.BindColVal;          //지점코드  필수
		var str2 = gcem_atcode.text;                  //계정코드  필수
		var str3 = gclx_sfdcode2.BindColVal;          //1구분
		var str4 = gclx_ast2nd.BindColVal;            //자산중분류  필수
		var str5 = gclx_ast3rd.BindColVal;            //자산소분류  필수
		var str6 = gcem_asnbr_2.text.substring(3,9);  //일련번호
		var str7 = gcem_EVALDATE.text;                //평가일          EVALDATE
		var str8 = gcem_BEVALAMT.text;                //평가전금액      BEVALAMT
		var str9 = gcem_EVALAMT.text;                 //평가금액        EVALAMT
		var str10 =gcem_DIFFAMT.text;                 //평가차액        DIFFAMT
		var str11 =gcem_EVALAFYEAR.text;              //평가후내용년수  EVALAFYEAR
		var str12 ="";                                //작성일          WRDT
		var str13 ="";                                //작성자          WRID

		if(str5=="") str5="00"; else str5= gclx_ast3rd.BindColVal; 
		if(str8=="") str8="0"; else str8=gcem_BEVALAMT.text;  
		if(str9=="") str9="0"; else str9=gcem_EVALAMT.text;      
		if(str10=="") str10="0"; else str10=gcem_DIFFAMT.text;   
		   

		if(tap5=='1'){

			var IsUpdated = "1";

			gctr_code07.KeyValue   =  "Account.a090001_t7(I:USER=gcds_code07)";
			gctr_code07.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t7?";
			gctr_code07.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
			",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+	
			",IsUpdated="+IsUpdated;	

			gctr_code07.post();	  
		}else{

			ln_update();

			var IsUpdated = "2";
      var EVALNO = gcds_code07.namevalue(gcds_code07.rowposition,"EVALNO");
			gctr_code07.KeyValue   =  "Account.a090001_t7(I:USER=gcds_code07)";
			gctr_code07.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t7?";
			gctr_code07.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
			",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+
			",EVALNO="+EVALNO+
			",IsUpdated="+IsUpdated;	
			gctr_code07.post();	  
		}
		tap5="";
	}// (e=='05') end

	/***근저당 저장부분***e='06*/
	if(e=='06'){
		var str1 = gclx_sfdcode2.BindColVal;         //지점코드  필수
		var str2 =	gcem_atcode.text;                //계정코드 필수
		var str3 = gclx_sfdcode2.BindColVal;         //1구분
		var str4 = gclx_ast2nd.BindColVal;           //자산중분류  필수
		var str5 = gclx_ast3rd.BindColVal;           //자산소분류  필수
		var str6 = gcem_asnbr_2.text.substring(3,9); //일련번호
		var str7 = gcem_MORTDATE.text;					     //설정일      
		var str8 = gcem_MORTBANK.value;					     //은행코드       
		var str9 = gclx_CLOSEORNOT.BindColVal;			 //해지여부    
		var str10 = gcem_CLOSEDATE.text;				     //해지일         
		var str11 = gcem_BOOKAMT.text;					     //장부가액         
		var str12 = gcem_MORTSIZE.text;				       //면적            
		var str13 = gcem_MORTJDGDT.text;				     //감정일        
		var str14 = gcem_JUDGAMT.text;					     //감정가액         
		var str15 = gcem_MORTAMT.text;					     //설정금액        
		var str16 = txt_MORTDTL.value;					     //설정내역         
		var str17 = txt_MORTORDER.value;				     //설정순위      
		var str18 = "";					                     //작성일           
		var str19 = "";					                     //작성자            

		if(str5=="") str5="00"; else str5= gclx_ast3rd.BindColVal; 
		if(str11=="") str11="0"; else str11= gcem_BOOKAMT.text;   
		if(str14=="") str14="0"; else str14=gcem_JUDGAMT.text;      
		if(str15=="") str15="0"; else str15=gcem_MORTAMT.text;     
	 
		if(tap5=='1'){
			var IsUpdated = "1";

			gctr_code08.KeyValue   =  "Account.a090021_t8(I:USER=gcds_code08)";
	    gctr_code08.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t8?";
			gctr_code08.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
			",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+
			",v_str14="+str14+",v_str15="+str15+ ",v_str16="+str16+",v_str17="+str17+",v_str18="+str18+",v_str19="+str19+		
			",IsUpdated="+IsUpdated;	

			gctr_code08.post();	  
		}else{
			var IsUpdated = "2";
      var MORTNO = gcds_code08.namevalue(gcds_code08.rowposition,"MORTNO");
			gctr_code08.KeyValue   =  "Account.a090021_t8(I:USER=gcds_code08)";
	    gctr_code08.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t8?";
			gctr_code08.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
			",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+
			",v_str14="+str14+",v_str15="+str15+ ",v_str16="+str16+",v_str17="+str17+",v_str18="+str18+",v_str19="+str19+		
			",MORTNO="+MORTNO+
			",IsUpdated="+IsUpdated;	

			gctr_code08.post();	  
		}
		tap5="";
	}// (e=='06') end


	/*****************************************
	 고정자산이동 저장부분***
	 e='08'
	 *****************************************/
	if(e=='08'){
		var str1 = gclx_sfdcode2.BindColVal;          //지점코드  필수
		var str2 = gcem_atcode.text;                  //계정코드   필수
		var str3 = gclx_sfdcode2.BindColVal;          //1구분
		var str4 = gclx_ast2nd.BindColVal;            //자산중분류  필수
		var str5 = gclx_ast3rd.BindColVal;            //자산소분류  필수
		var str6 = gcem_asnbr_2.text.substring(3,9);  //일련번호
		var str7 = gcem_MOVDATE.text;                 //이동일   
		var str8 = txt_amngdept.value;                //관리부서  
		var str9 = txt_ausedept.value;                //사용처   
		var str10 = txt_ACOSTCD.value;                //원가코드   
		var str11 = txt_MYPLAN.value;                 //이동내역 
		var str12 = "";														    //작성일   
		var str13 = "";														    //작성자     
		if(str5=="") str5="00"; else str5= gclx_ast3rd.BindColVal; 	

		if(tap5=='1'){
      //체크 -- 기존데이터 체크하기... 
		  //alert("자산이동신규");
			var IsUpdated = "1";
			gctr_code12.KeyValue   =  "Account.a090021_t12(I:USER=gcds_code12)";
			gctr_code12.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t12?";
			gctr_code12.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+",v_str5="+str5
			                       + ",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+",v_str9="+str9+",v_str10="+str10
														 + ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+",IsUpdated="+IsUpdated;	
			gctr_code12.post();	
		}else{
		  //alert("자산이동수정");
			var IsUpdated = "2";
      var ASTMOVNO = gcds_code12.namevalue(gcds_code12.rowposition,"ASTMOVNO");
			gctr_code12.KeyValue   =  "Account.a090021_t12(I:USER=gcds_code12)";
	    gctr_code12.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t12?";
			gctr_code12.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+",v_str5="+str5
			                        +",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+",v_str9="+str9+",v_str10="+str10
															+",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+",ASTMOVNO="+ASTMOVNO+",IsUpdated="+IsUpdated;	
			gctr_code12.post();	
			ln_Move(); //자산이동조회
		}
		tap5="";
	}// (e=='08') end


	/***임대/임차   저장부분***e='09*/
	if(e=='09'){
		var str1 = gclx_sfdcode2.BindColVal;          //지점코드  필수
		var str2 = gcem_atcode.text;                  //계정코드  필수
		var str3 = gclx_sfdcode2.BindColVal;          //1구분
		var str4 = gclx_ast2nd.BindColVal;            //자산중분류  필수
		var str5 = gclx_ast3rd.BindColVal;            //자산소분류  필수
		var str6 = gcem_asnbr_2.text.substring(3,9);  //일련번호 
		var str7 = gcem_LEASEDATE.text;               //임대차일
		var str8 = gclx_LEASECLS.BindColVal;          //임대임차구분
		var str9 = txt_LEASEHOLD.value;              //임대차처
		var str10 =gcem_LEASETERM.text;               //임대차기간
		var str11 =gcem_LEASEAMT.text;                //금액
		var str12 =gcem_LEASEGAMT.text;               //보증금
		var str13 =txt_LEASEWHY.value;                //임대차목적/조건
		var str14 =gclx_LEASESTS.BindColVal;          //임대차상태
		var str15 =gcem_LEASEPYUNG.text;              //평수
		var str16 ="";                                //작성일
		var str17 ="";                                //작성자

		if(str5=="") str5="00"; else str5= gclx_ast3rd.BindColVal;
		
		if(tap5=='1'){
			var IsUpdated = "1";
			gctr_code13.KeyValue   =  "Account.a090021_t13(I:USER=gcds_code13)";
	    gctr_code13.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t13?";
			gctr_code13.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
			",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+
			",v_str14="+str14+",v_str15="+str15+ ",v_str16="+str16+",v_str17="+str17+	
			",IsUpdated="+IsUpdated;	

			gctr_code13.post();	  
		}else{
			var IsUpdated = "2";
      var LEASENO = gcds_code13.namevalue(gcds_code13.rowposition,"LEASENO");

			gctr_code13.KeyValue   =  "Account.a090021_t13(I:USER=gcds_code13)";
	    gctr_code13.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t13?";
			gctr_code13.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ ",v_str7="+str7+",v_str8="+str8+
			",v_str9="+str9+",v_str10="+str10+ ",v_str11="+str11+",v_str12="+str12+",v_str13="+str13+
			",v_str14="+str14+",v_str15="+str15+ ",v_str16="+str16+",v_str17="+str17+
			",LEASENO="+LEASENO+
			",IsUpdated="+IsUpdated;	
			gctr_code13.post();	  
		}
		tap5="";
	}// (e=='09') end
}

/******************************************************************************
	Description : 저장시 필수항목 체크
	Parameter 	: 저장 구분
******************************************************************************/
function ln_Chk_Save(p) {

	if(p=="01"){ // 자산MST
		if(gclx_sfdcode2.bindcolval==""){
		  alert("지점은 필수 항목입니다."); return false; 
		}
		if(gclx_ast2nd.bindcolval=="") {
		  alert("자산중분류는 필수 항목입니다."); return false; 
		}
		if(gcem_jasan.text==""){
		  alert("자산명은 필수 항목입니다."); return false; 
		}
		if(gcem_asaqsdat.text=="") {
		  alert("취득일자는 필수 항목입니다."); return false;
		}

    /** 필수항목에서 제외함.
		if(gclx_ast2nd.bindcolval!="11"){ //토지가 아닌 경우 
			if(gcem_taxnbr.text=="") {
				alert("계산서번호는 필수 항목입니다."); return false;
			} 
		}
		**/

		if(txt_empnm.value==""){
			alert("담당자는 필수 항목입니다."); return false; 
		}		
		if(txt_cadeptcd_3.value==""){
			alert("담당부서는 필수 항목입니다."); return false; 
		}
        if(gcem_atcode.text==""){
			alert("자산중분류에 따른 계정코드가 누락되었습니다. 자산중분류를 다시 선택하십시요."); return false; 
		}
		
		if(gclx_regigb.bindcolval=="2" && gcem_s_astnbr.text==""){ //이체등록일 경우 최초자산번호 필수항목임.
			alert("등록구분이 이체등록일 경우 최초자산번호는 필수 항목입니다."); return false;
		}
		
		if(gclx_regigb.bindcolval=="2" && gcem_mordt.text==""){ //이체등록일 경우 이체수신일자 필수항목임.
			alert("등록구분이 이체등록일 경우 이체수신일은 필수 항목입니다."); return false;
		}
		
		//2012.05.02 jys : 이체등록일 경우 감가상각일 체크 안함. 
		if(gclx_regigb.bindcolval!="2"){ //최초등록건
		//2011.09.08 목 JYS 추가 
			//감가상각 마감일과 취득일자 비교 체크
			gcds_closechk.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_s15"
													 + "?v_str1="+gclx_sfdcode2.BindColVal            //지점코드                                           
													 + "&v_str2="+gcem_asaqsdat.text.substring(0,4)   //취득년도
													 + "&v_str3="+gcem_asaqsdat.text.substring(4,6);  //취득월
			//prompt('',gcds_closechk.DataID);
			gcds_closechk.Reset();  

			if(gcds_closechk.namevalue(1,"CNT")!=0){
				
				//alert(gcem_jasan_1.text);
				//2019/06/12 경영지원팀 요청으로 수정함 - 이동훈
				if( gcem_jasan_1.text != "00863" && gcem_jasan_1.text != "00864" && gcem_jasan_1.text != "00865" && gcem_jasan_1.text != "01018" ){
			
					alert("해당 취득일자는 이미 감가상각 작업을 하였습니다.");
					
					return false;
				
				}
				
			}
			
		}

	}else if(p=="02"){
		if(gclx_goddiv.bindcolval==""){
		  alert("자산구분은 필수 항목입니다."); return false; 
		}
		if(gclx_asaqsdiv.bindcolval==""){
		  alert("취득구분은 필수 항목입니다."); return false; 
		}
		if(gclx_aststat.bindcolval==""){
		  alert("상태코드는 필수 항목입니다."); return false; 
		}
		if(gcem_ASTQTY.text==""||gcem_ASTQTY.text==0){
		  alert("수량은 필수 항목입니다."); return false; 
		}

	  if(gclx_ast2nd.bindcolval!="11"){ //토지가 아닌 경우
			if(gcem_ASTYUSE.text==""||gcem_ASTYUSE.text==0){
				alert("내용연수는 필수 항목입니다."); return false; 
			}
			if(txt_COSTCD.value==""){
				alert("원가코드는 필수 항목입니다."); return false; 
			}
		}

		if(gcem_ASTAQAMT.text==""||gcem_ASTAQAMT.text==0){
		  alert("취득금액은 필수 항목입니다."); return false; 
		}

		if(gclx_sfdcode2.bindcolval=="03"&&gcem_ASTAQAMTY.text==0){ //금강산 일경우 외화금액 필수항목 
			alert("외화금액은 필수 항목입니다."); return false; 
		}
	
		if(txt_usedpt.value==""){
		  alert("사용부서는 필수 항목입니다."); return false; 
		}
    if(gcem_astuser.text==""){
		  alert("사용자는 필수 항목입니다."); return false; 
		}

		if(txt_mngdpt.value==""){
		  alert("관리부서는 필수 항목입니다."); return false; 
	  }

		if(gclx_regigb.bindcolval==""){
		  alert("등록구분은 필수 항목입니다."); return false; 
		}

		if(gclx_deprgb.bindcolval==""){
		  alert("상각처리구분은 필수 항목입니다."); return false; 
		}
		//분할 저장의 경우 수량은 1건으로 입력함.
		if(chkbox_divide.checked==true&&gcem_ASTQTY.text!=1){
			alert("분할저장은 수량이 1건 만 입력 가능합니다."); return false; 
		}

    //부외자산인데 상각처리 건은 입력불가
		if(gclx_goddiv.bindcolval=="5"&&gclx_deprgb.bindcolval=="1"){
			alert("부외자산은 상각처리 할 수 없습니다.");
			return false;
		}

		//토지일경우 상각처리구분은 항상 상각미처리
		if(gclx_ast2nd.bindcolval=="11"&&gclx_deprgb.bindcolval=="1"){
			alert("자산중분류 토지는 상각처리 할 수 없습니다.");
			return false;
		}

  }else if(p=="03"){

	}else if(p=="04"){

	}else if(p=="05"){

	}else if(p=="06"){

	}else if(p=="07"){

	}else if(p=="08"){

  }else if(p=="09"){

	}else if(p=="10"){

	}else if(p=="11"){

	}

	return true;	

/**
if(gcem_asaqsdat.text=="")   { alert("취득일자는 필수입니다"); return;
}else if(gclx_aststat.BindColVal=="") { alert("상태코드는 필수입니다"); return;
}else if(gcem_ASTYUSE.text=="")   { alert("내용년수는 필수입니다"); return; 
}else if(gcem_ASTAQAMT.text=="")  {alert("취득금액은 필수입니다"); return; 
}
**/
}
/******************************************************************************
	Description : 삭제 체크
******************************************************************************/
function ln_Chk_Delete(e) {
	if(e=="08"){  //자산이동
	  //alert("MOVENOTE::"+gcds_code12.namevalue(gcds_code12.rowposition,"MOVNOTE"));
		if(gcds_code12.namevalue(gcds_code12.rowposition,"MOVNOTE")=="최초등록"){
			alert("최초등록건은 삭제할 수 없습니다. 전산팀에 문의하십시요.");
			return false;
		}

    if(gcds_code12.namevalue(gcds_code12.rowposition,"MOVNOTE")=="이체등록"){
			alert("이체등록건은 삭제할 수 없습니다. 전산팀에 문의하십시요.");
			return false;
		}
	}

	return true;
  /*
	var str1 = gclx_sfdcode2.BindColVal;          //지점코드  필수
	var str3 = gclx_sfdcode2.BindColVal;          //1구분
	var str4 = gclx_ast2nd.BindColVal;            //자산중분류  필수
	var str5 = gclx_ast3rd.BindColVal;            //자산소분류  필수
	var str6 = gcem_asnbr_2.text.substring(3,9);  //일련번호

	if(str5=="") str5="00"; else str5=gclx_ast3rd.BindColVal;  
	
	gcds_code16.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_s18"
								     + "?v_str1="+str1
							       + "&v_str3="+str3+"&v_str4="+str4
								     + "&v_str5="+str5+"&v_str6="+str6;
		
	gcds_code16.Reset();
	*/
}

/******************************************************************************
	Description : 삭제
******************************************************************************/
function ln_Delete(e) {

	var str1 =gclx_sfdcode2.BindColVal;            //지점코드   필수
	var str2 =gcem_atcode.text;                    //계정코드   필수
	var str3 =gclx_sfdcode2.BindColVal;            //1구분
	var str4 =gclx_ast2nd.BindColVal;              //자산중분류 필수
	var str5 =gclx_ast3rd.BindColVal;              //자산소분류 필수
	var str6 =gcem_asnbr_2.text.substring(3,9);    //일련번호

	var IsUpdated ="3";
	if(str5=="") str5="00"; else str5=gclx_ast3rd.BindColVal;  

	if(!ln_Chk_Delete(e)) return;

/*---------------마스타 /기본 / 삭제---------------------------------*/
	if(e=='02'){    

	  if(gstrAuthgr=="C"){
			alert("삭제 권한이 없습니다. 관리자에게 문의하세요." ) ; 
			return; 
		}
		if(confirm("자산 기본정보, 부가정보, 자산이동 정보까지 삭제됩니다. 삭제하시겠습니까?")){

		  gs_delete_gb="Y";
      
			gcds_code31.deleterow(gcds_code31.rowposition);
			gcds_code32.deleterow(gcds_code32.rowposition);
			gcds_code33.deleterow(gcds_code33.rowposition);
			gcds_code02.deleterow(gcds_code02.rowposition);
			gcds_code00.deleterow(gcds_code00.rowposition);	

			gctr_code00.KeyValue   =  "Account.a090001_t1_1(I:USER=gcds_code00,I:USER2=gcds_code02,I:USER31=gcds_code31,I:USER32=gcds_code32,I:USER33=gcds_code33)";
			gctr_code00.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t1_1?";
			gctr_code00.Parameters =  "v_str1="+gs_date+",v_str2="+gs_userid;
			
			/*
	  	prompt('gcds_code00::',gcds_code00.text);
			prompt('gcds_code02::',gcds_code02.text);
      prompt('gcds_code31::',gcds_code31.text);
			prompt('gcds_code32::',gcds_code32.text);
			prompt('gcds_code33::',gcds_code33.text)
			*/
      
			gctr_code00.post();

			//삭제 완료후 초기화 

		}

	/** JYS 임의로 막음.

			if (confirm("삭제하시겠습니까?")){

			 if(gclx_ast2nd.BindColVal=='11' || gclx_ast2nd.BindColVal=='12' || gclx_ast2nd.BindColVal=='13'){ //부가1 삭제

					var IsUpdated = "3";

					gctr_code03.KeyValue   =  "Account.a090001_t3(I:USER=gcds_code31)";
					gctr_code03.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t3?";
					gctr_code03.Parameters =  "v_str1="+str1+ ",v_str3="+str4+",v_str4="+str5+",v_str5="+""+",v_str6="+str6+",IsUpdated="+IsUpdated;		
					
					gctr_code03.post();	
				 
			 }else if(gclx_ast2nd.BindColVal=='14'){//부가2 삭제
				 var IsUpdated = "3";
					gctr_code10.KeyValue   =  "Account.a090001_t10(I:USER=gcds_code32)";
					gctr_code10.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t10?";
					gctr_code10.Parameters =   "v_str1="+str1+ ",v_str3="+str4+",v_str4="+str5+",v_str5="+""+",v_str6="+str6+",IsUpdated="+IsUpdated;			
					gctr_code10.post();	  
					
			 }else if(gclx_ast2nd.BindColVal=='15' || gclx_ast2nd.BindColVal=='16' || gclx_ast2nd.BindColVal=='17'){
				 var IsUpdated = "3";

					gctr_code11.KeyValue   =  "Account.a090001_t11(I:USER=gcds_code33)";
					gctr_code11.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t11?";
					gctr_code11.Parameters =  "v_str1="+str1+ ",v_str3="+str4+",v_str4="+str5+",v_str5="+""+",v_str6="+str6+",IsUpdated="+IsUpdated;		
					gctr_code11.post();
			 }//if(gclx_ast2nd.BindColVal=='11' || gclx_ast2nd.BindColVal=='12' || gclx_ast2nd.BindColVal=='13'){ //부가1 삭제

				 ///마스타삭제
				 var IsUpdated = "3";  	
				 var str4 =   gclx_ast2nd.BindColVal;    

					gctr_code00.KeyValue   =  "Account.a090001_t1(I:USER=gcds_code00)";
					gctr_code00.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t1?";
					gctr_code00.Parameters =  "v_str1="+str1+",v_str3="+str4+",v_str4="+str5+",v_str12="+str6+",IsUpdated="+IsUpdated;    
				  gctr_code00.post();	
					
				var IsUpdated = "4";  	
					gctr_code02.KeyValue   =  "Account.a090001_t2(I:USER=gcds_code02)";
					gctr_code02.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t2?";
					gctr_code02.Parameters =   "v_str1="+str1+",v_str3="+str4+",v_str4="+str5+",v_str31="+str6+",IsUpdated="+IsUpdated;		
					gctr_code02.post();	
			} //(confirm("삭제하시겠습니까?")){
//		alert("test4");

		}else{  
			
		alert("데이터가 존재해서 삭제할 수없습니다");
//		}

**/

	}//if e==02


/*---------------고정자산수리 삭제---------------------------------*/
	if(e=='03'){

  if (confirm("삭제하시겠습니까?")){	     

    var REPAIRNO = gcds_code05.namevalue(gcds_code05.rowposition,"REPAIRNO");

		gctr_code05.KeyValue   =  "Account.a090021_t5(I:USER=gcds_code05)";
	  gctr_code05.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t5?";
		gctr_code05.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
		",v_str5="+str5+",v_str6="+str6+ ",v_str7="+""+",v_str8="+""+
		",v_str9="+""+",v_str10="+""+ ",v_str11="+""+",v_str12="+""+",v_str13="+""+",v_str14="+""+	
		",IsUpdated="+IsUpdated+
		",REPAIRNO="+REPAIRNO;	

		gctr_code05.post();	  

	}
  }//if e==03

/*---------------보험 삭제---------------------------------*/
if(e=='04'){
    if (confirm("삭제하시겠습니까?")){	

			var INSURENO = gcds_code06.namevalue(gcds_code06.rowposition,"INSURENO");

			gctr_code06.KeyValue   =  "Account.a090021_t6(I:USER=gcds_code06)";
			gctr_code06.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t6?";
			gctr_code06.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ 
			",IsUpdated="+IsUpdated+
			",INSURENO="+INSURENO;	
			gctr_code06.post();	  

		}
  }//if e==04

/*---------------평가 삭제---------------------------------*/
if(e=='05'){
    alert("평가삭제보류 ");
		return;
    if (confirm("삭제하시겠습니까?")){	
       var EVALNO = gcds_code07.namevalue(gcds_code07.rowposition,"EVALNO");

				gctr_code07.KeyValue   =  "Account.a090001_t7(I:USER=gcds_code07)";
				gctr_code07.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t7?";
				gctr_code07.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
				",v_str5="+str5+",v_str6="+str6+ 
				",IsUpdated="+IsUpdated+
				",EVALNO="+EVALNO;	
				gctr_code07.post();	  

		}
  }//if e==05


/*---------------근저당 삭제---------------------------------*/
if(e=='06'){
		if (confirm("삭제하시겠습니까?")){	

			var MORTNO = gcds_code08.namevalue(gcds_code08.rowposition,"MORTNO");
			gctr_code08.KeyValue   =  "Account.a090021_t8(I:USER=gcds_code08)";
			gctr_code08.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t8?";
			gctr_code08.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ 
			",IsUpdated="+IsUpdated+
			",MORTNO="+MORTNO;	
			gctr_code08.post();	  

		}
  }//if e==06

/*---------------변경 삭제---------------------------------*/
if(e=='07'){
    alert("변경삭제보류 ");
		return;
    if (confirm("삭제하시겠습니까?")){	
 
			var CHGNO = gcds_code09.namevalue(gcds_code09.rowposition,"CHGNO");

			gctr_code09.KeyValue   =  "Account.a090001_t9(I:USER=gcds_code09)";
			gctr_code09.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t9?";
			gctr_code09.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ 
			",IsUpdated="+IsUpdated+
			",CHGNO="+CHGNO;	

			gctr_code09.post();	  
		}
  }//if e==07

/*---------------고정자산이동 삭제---------------------------------*/
	if(e=='08'){
		if (confirm("삭제하시겠습니까?")){	
			var ASTMOVNO = gcds_code12.namevalue(gcds_code12.rowposition,"ASTMOVNO");

			gctr_code12.KeyValue   =  "Account.a090021_t12(I:USER=gcds_code12)";
			gctr_code12.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090021_t12?";
			gctr_code12.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
																",v_str5="+str5+",v_str6="+str6+ 
																",IsUpdated="+IsUpdated+
																",ASTMOVNO="+ASTMOVNO;	

			gctr_code12.post();	  
		}
	}//if e==08

/*---------------임대/임차 삭제---------------------------------*/
if(e=='09'){
    if (confirm("삭제하시겠습니까?")){	
 
			var LEASENO = gcds_code13.namevalue(gcds_code13.rowposition,"LEASENO");

			gctr_code13.KeyValue   =  "Account.a090001_t13(I:USER=gcds_code13)";
			gctr_code13.Action     =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_t13?";
			gctr_code13.Parameters =  "v_str1="+str1+ ",v_str2="+str2+",v_str3="+str3+",v_str4="+str4+
			",v_str5="+str5+",v_str6="+str6+ 
			",IsUpdated="+IsUpdated+
			",LEASENO="+LEASENO;	

			gctr_code13.post();	  

		}
  }//if e==09
}


/******************************************************************************
	Description : 취소
******************************************************************************/


/******************************************************************************
	Description : 
******************************************************************************/
function ln_Trim(str){
   
  str = str.replace(/^\s*/,'').replace(/\s*$/, ''); 
  return str; 
} 
/******************************************************************************
	Description : 출력
******************************************************************************/
/*function ln_Print(){

}*/

/******************************************************************************
	Description : 엑셀
******************************************************************************/
function ln_Excel(){
	gcgd_code01.GridToExcel("자산조회","",2);
}

/******************************************************************************
	Description : 입력체크 
	parameter :   01-자산조회, 02-자산등록  
******************************************************************************/
function ln_Chk(e){
  
	if(e=="00"){
		if(gcem_asnbr_2.text==""){
			alert("자산번호 입력 후 조회 가능합니다.99");
			return false;
		}
	}else if(e=='01'){
		if(gclx_sfdcode.BindColVal==""){
			alert("지점코드를 선택하세요");		
			return false; 
		}
    
		//취득일자 
		if(gcem_asq_fr.text==""||gcem_asq_to.text==""){
			alert("취득일자를 입력하십시요");		
			return false; 
		}
	}else if(e=='02'){
		if(gcem_ASTAQAMT.text==""){
			alert("취득금액을 입력해주세요");		
			return false; 	
		}

		if(gcem_ASTYUSE.text==""){
			alert("내용년수를 입력해주세요");		
			return false; 	
		}
	}else{
    if(gclx_sfdcode2.BindColVal==""){
			alert("지점코드를 선택하세요");		
			return false; 
		}
		
		if(gclx_ast2nd.BindColVal==""){
			alert("자산중분류를 선택하세요");		
			return false; 
		}

		if(gclx_ast2nd.BindColVal=='14' && gclx_ast3rd.BindColVal==""){
			alert("자산소분류를 선택하세요");		
			return false; 
		}

		if(gclx_ast2nd.BindColVal=='16' && gclx_ast3rd.BindColVal==""){
			alert("자산소분류를 선택하세요");		
			return false; 
		}
	}
	return true; 
}


/******************************************************************************
	Description : 부서 조회
	parameter   : 00-자산조회 관리부서, 01-자산등록 담당부서, 
	              01-자산등록 기본 사용부서, 03-자산등록 기본 관리부서 
								04-자산등록 이동 사용부서, 05-자산등록 이동 관리부서  
******************************************************************************/
function ln_Popup0(e){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	arrParam[0] = gclx_sfdcode2.bindcolval;

	strURL = "./hcdept_popup4.jsp";
	strPos = "dialogWidth:500px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

  if(e=='00'){  
	  /**
		if(arrResult != null) {
			arrParam = arrResult.split(";");       
  		txt_cadeptcd.value = ln_Trim(arrParam[0]);
			txt_cadeptcdnm.value = ln_Trim(arrParam[1]); 
		} else {
			txt_cadeptcd.value = "";
			txt_cadeptcdnm.value = ""; 
		}
		**/
	}else if(e=='01'){
		if(arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_cadeptcd_3.value = ln_Trim(arrParam[0]);
			txt_cadeptnm_3.value = ln_Trim(arrParam[1]); 
			txt_mngdpt.value = ln_Trim(arrParam[0]);
			txt_mngdptnm.value = ln_Trim(arrParam[1]); 
		} else {
			txt_cadeptcd_3.value = "";
			txt_cadeptnm_3.value = "";
      txt_mngdpt.value = "";
      txt_mngdptnm.value ="";
		}
	}else if(e=='02'){
		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_usedpt.value = ln_Trim(arrParam[0]);
			txt_usedptnm.value = ln_Trim(arrParam[1]); 
		} else {
			txt_usedpt.value = "";
			txt_usedptnm.value = "";
		}
	}else if(e=='03'){
		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_mngdpt.value = ln_Trim(arrParam[0]);
			txt_mngdptnm.value = ln_Trim(arrParam[1]); 
		} else {
			txt_mngdpt.value = "";
			txt_mngdptnm.value = "";
		}	
	}else if(e=='04'){ //자산이동 사용부서
		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_ausedept.value = ln_Trim(arrParam[0]);
			txt_ausedeptnm.value = ln_Trim(arrParam[1]); 
		} else {
			txt_ausedept.value = "";
			txt_ausedeptnm.value = "";
		}	
	}else if(e=='05'){ //자산이동 관리부서 
		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_amngdept.value = ln_Trim(arrParam[0]);
			txt_amngdeptnm.value = ln_Trim(arrParam[1]); 
		} else {
			txt_amngdept.value = "";
			txt_amngdeptnm.value = "";
		}	
	}
}

/******************************************************************************
	Description : 주소 조회  OK
******************************************************************************/
function ln_Popup2(e){
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	strURL = "/Common/jsp/com_zipcd.jsp";
	strPos = "dialogWidth:640px;dialogHeight:410px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);
		
	if(e=='c'){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			gcem_ASTPOST.text=arrParam[0];
			var val = arrParam[1] + arrParam[2] + arrParam[3] + arrParam[4];	
			eval("txt_"+e+"addr01").value = val;				
		}
	}else if(e=='s'){
	}
}

/******************************************************************************************
	Description : 조회 - 관리항목 코드 조회
******************************************************************************************/
/****
function ln_RefQuery(e){ 
  gcds_fsrefcd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010002_s2?v_str1="+e+"&v_str2=B";
	gcds_fsrefcd.Reset();
}
****/

/******************************************************************************
	Description : 성명 찾기 [검색]
	Parameter   : e - txt_empnm : 담당자 ( 등록 )
	                - txt_astusernm : 사용자 ( 등록 ) 
									- txt_empnm0 : 담당자 ( 검색조건 ) 
******************************************************************************/
function ln_Popup5(e){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./empno_popup2.jsp";
	strPos = "dialogWidth:377px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";");
		eval(e).value  = arrParam[0];
		if (e=="txt_empnm"){
      txt_empno.value = arrParam[1];
      txt_cadeptcd_3.value = arrParam[4];
			txt_cadeptnm_3.value = arrParam[2];
    }else if(e=="txt_astusernm"){
      gcem_astuser.text = arrParam[1];
      txt_astusernm.value = arrParam[0];
    }else if(e=="txt_empnm_1"){
      txt_empno_1.value = arrParam[1];
    }else if(e=="txt_astusernm_1"){
      txt_astuser_1.value = arrParam[1];
    }
	} else {
		eval(e).value = "";
		if (e=="txt_empnm"){
      txt_empno.value = "";
    }else if(e=="txt_astusernm"){
      gcem_astuser.text = arrParam[1];
      txt_astusernm.value = arrParam[0];
    }else if(e=="txt_empnm_1"){
      txt_empno_1.value ="";
    }else if(e=="txt_astusernm_1"){
      txt_astuser_1.value ="";
		}
	}
}


/******************************************************************************
	Description : 거래처코드 유무검색	
	parameter   : eval(obj).value = vend_cd 거래처 코드   
	              01 - 수리처,  02- 구입처,  03- 보험회사,  04.임대차처
******************************************************************************/
function ln_Popup_Find(obj,e){

	var  vend = eval(obj).value;

  if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
	gcds_codecode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_s0?v_str1="+eval(obj).value+"&v_str2=";  //거래처조회
	gcds_codecode.Reset();  

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;	      

	if(e=='01'){
		if (gcds_codecode.countrow>0){
			strURL = "./ast_vender_popup.jsp";
			arrParam[0] = ln_Trim(vend);
			strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null){
				arrParam = arrResult.split(";");
				txt_REPAIRPART.value = arrParam[0];
				txt_vend_cd2.value = arrParam[1];
			}else {	
				alert("존재하지 않는 코드입니다"); txt_REPAIRPART.value=""; txt_vend_cd2.value = "";		
			}
		}
	}else if(e=='02'){
		if (gcds_codecode.countrow>0){
			strURL = "./ast_vender_popup.jsp";
			arrParam[0] = ln_Trim(vend);
			strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null){
				arrParam = arrResult.split(";");
				txt_buyfrom.value = arrParam[0];		 
				txt_vend_nm.value = arrParam[1];
			}else {	
				alert("존재하지 않는 코드입니다"); txt_buyfrom.value = "";	txt_vend_nm.value = "";	
			}
		}
	}else if(e=='03'){
		if (gcds_codecode.countrow>0){
			strURL = "./ast_vender_popup.jsp";
			arrParam[0] = ln_Trim(vend);
			strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
				txt_INSFIRM.value = arrParam[0];
				txt_vend_cd3.value = arrParam[1];
			}else {	
				alert("존재하지 않는 코드입니다"); txt_INSFIRM.value = "";		txt_vend_cd3.value = "";
			}
		}
	}else if(e=='04'){   //임대차처 거래처
		if (gcds_codecode.countrow>0){
			strURL = "./ast_vender_popup.jsp";
			arrParam[0] = ln_Trim(vend);
			strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null){
				arrParam = arrResult.split(";");
				txt_LEASEHOLD.value = arrParam[0];		
				txt_vend_cd4.value  = arrParam[1];
			}else {	
				alert("존재하지 않는 코드입니다"); txt_LEASEHOLD.value = "";		txt_vend_cd4.value = "";
			}
		}
	}else if(e=='05'){   //임대차처 거래처
		if (gcds_codecode.countrow>0){
			strURL = "./ast_vender_popup.jsp";
			arrParam[0] = ln_Trim(vend);
			strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null){
				arrParam = arrResult.split(";");
				txt_RELFIRM.value = arrParam[0];		
				txt_RELFIRM2.value  = arrParam[1];
			}else {	
				alert("존재하지 않는 코드입니다"); txt_RELFIRM.value = "";		txt_RELFIRM2.value = "";
			}
		}
	}
}
/******************************************************************************
	Description : 거래처 찾기
******************************************************************************/
function ln_Popup4(e){    

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos; 

	strURL = "./gczm_vender_popup.jsp";
	strPos = "dialogWidth:496px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);

	if(e=='01'){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_buyfrom.value = arrParam[0];
			txt_vend_nm.value = arrParam[1];
		} else {
			txt_buyfrom.value = "";
			txt_vend_nm.value = "";
		}
	}else if(e=='02'){                   //탭 5 고정자산 수리처
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_REPAIRPART.value = arrParam[0];
			txt_vend_cd2.value = arrParam[1];
		} else {
			txt_REPAIRPART.value = "";
			txt_vend_cd2.value = "";
		}
	}else if(e=='03'){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_INSFIRM.value = arrParam[0];		
			txt_vend_cd3.value = arrParam[1];
		} else {
			txt_INSFIRM.value = "";		
			txt_vend_cd3.value = "";
		}
	}else if(e=='04'){
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_LEASEHOLD.value = arrParam[0];		
			txt_vend_cd4.value = arrParam[1];
		} else {
			txt_LEASEHOLD.value = "";		
			txt_vend_cd4.value = "";
		}
	}else if(e=='05'){
	  alert("보류삭제");
		return;
		if (arrResult != null) {
			arrParam = arrResult.split(";");
			txt_RELFIRM.value = arrParam[0];		
			txt_RELFIRM2.value = arrParam[1];
		} else {
			txt_RELFIRM.value = "";		
			txt_RELFIRM2.value = "";
		}
	}
}
/******************************************************************************
	Description : 자산명 팝업
******************************************************************************/
function ln_ProPopup(e){

	if(e=='01'){           //자산명 팝업창

		var row ="";
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var arrParam	= new Array();

		arrParam[0]=gclx_asdivcod.bindcolval;
    arrParam[1]=gclx_asdivcod_2.bindcolval;

		//strURL = "./Atcode_popup_1.jsp";
		strURL = "./astname_popup.jsp";
		strPos = "dialogWidth:596px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";

		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_jasan_1.value = arrParam[1]; 
			gcem_jasan_1.text = arrParam[0];
		} else {
			gcem_jasan_1.text = "";
			txt_jasan_1.value = "";
			gcem_jasan.text = "";
			txt_jasan.value = "";
		}
	}else if(e=='02'){           //자산명 팝업창

		var row ="";
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var arrParam	= new Array();

		arrParam[0]=gclx_ast2nd.bindcolval;
    arrParam[1]=gclx_ast3rd.bindcolval;
		//strURL = "./Atcode_popup_1.jsp";
		strURL = "./astname_popup.jsp";
		strPos = "dialogWidth:596px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_jasan.value = arrParam[1]; 
			gcem_jasan.text = arrParam[0];
		} else {
			gcem_jasan_1.text = "";
			txt_jasan_1.value = "";
			gcem_jasan.text = "";
			txt_jasan.value = "";
		}
	}else if(e=='03'){   //계정명을 입력해서 찾는다
		var row ="";
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var arrParam	= new Array();
		var ls_param = gcem_jasan_1.text;
		strURL = "./atcode_popup.jsp?gstrl="+ls_param ;
		strPos = "dialogWidth:496px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			txt_gunm.value = arrParam[1]; 
			gcem_gunm.text = arrParam[0];
		} else {
			gcem_gunm.text = "";
			txt_gunm.value = "";
		}
	}else if(e=='04'){   //계정명을 입력해서 찾는다
		var row ="";
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var arrParam	= new Array();
		var ls_param = gcem_jasan.text;
		strURL = "./atcode_popup.jsp?gstrl="+ls_param ;
		strPos = "dialogWidth:496px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
		} else {
		}
	}
}

/******************************************************************************
	Description : 계산서 찾기 
	parameter   :              
******************************************************************************/
function ln_Bills_Popup(){
		var row ="";
		var arrResult	= new Array();
		var strURL;	
		var strPos;
		var arrParam	= new Array();
		strURL = "./bills_popup.jsp";
		strPos = "dialogWidth:700px;dialogHeight:380px;dialogTop:220px;dialogLeft:128px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);

		if (arrResult != null) {
			arrParam = arrResult.split(";"); 
			gcem_taxnbr.text = arrParam[0]; 
		} else {
			gcem_taxnbr.text = "";
		}
}


/******************************************************************************
	Description : 은행코드 유무검색	
	parameter   :              
******************************************************************************/
function ln_Bank_Find(obj,e){

	var  vend = eval(obj).value;
	
  if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter 
	gcds_bank.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>comcode_s1?v_str1=0022&v_str2="+eval(obj).value; 
	gcds_bank.Reset();  

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;	

	if(e=='01'){
		if (gcds_bank.countrow>0){
			strURL = "./commdtil_popup_ifrm.jsp";
			arrParam[0]="0022";
			arrParam[1]= txt_MORTBANK.value;
			strPos = "dialogWidth:398px;dialogHeight:379px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null){
				arrParam = arrResult.split(";");
				gcem_MORTBANK.value = arrParam[0];		
				txt_MORTBANK.value = arrParam[1];        
			}else {	
				alert("존재하지 않는 코드입니다");  gcem_MORTBANK.value="";		txt_MORTBANK.value = "";
			}
		}
	}  ///if
		
}  ///function
/******************************************************************************
	Description : 은행코드  팝업
******************************************************************************/
function ln_Popup1(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./commdtil_popup_ifrm.jsp";
	arrParam[0]="0022";
	arrParam[1]=txt_MORTBANK.value;
	strPos = "dialogWidth:398px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";"); 
		gcem_MORTBANK.value = ln_Trim(arrParam[0]);
		txt_MORTBANK.value = ln_Trim(arrParam[1]); 
	} else {
		gcem_MORTBANK.value = "";
		txt_MORTBANK.value = "";
	}

}
/******************************************************************************
	Description : 취소
******************************************************************************/
function ln_Cancel(p){
	if(p=="02"){
    ln_Insert('02');
		ln_DispChk(0);
    gclx_aststat.BindColVal ='0';


	  if(gcte_disp.ActiveIndex=='1'){ 	      ln_Clear('1');
	  }else if(gcte_disp.ActiveIndex=='2'){   ln_Clear('2');
	  }else if(gcte_disp.ActiveIndex=='3'){   ln_Clear('3');
	  }else if(gcte_disp.ActiveIndex=='4'){   ln_Clear('4');
	  }else if(gcte_disp.ActiveIndex=='5'){   ln_Clear('5');
	  }else if(gcte_disp.ActiveIndex=='6'){   ln_Clear('6');
	  }else if(gcte_disp.ActiveIndex=='7'){   ln_Clear('7');
	  }else if(gcte_disp.ActiveIndex=='8'){   ln_Clear('8');
	  }else if(gcte_disp.ActiveIndex=='9'){   ln_Clear('9');
	  }
	
	}
}

/******************************************************************************
	Description :clear 초기화 

******************************************************************************/
function ln_Clear(e){

	if(e=='1'){
		gcds_code02.clearAll();
		gclx_aststat.index =1; //정상
		gcem_ASTAQAMT.text  ="";     
		gclx_mngtype.BindColVal =  "";       
		gclx_ascosdiv.BindColVal =  "";         
		txt_COSTCD.value =  "";             
		gclx_asaqsdiv.BindColVal =  "";      
		gclx_goddiv.BindColVal =  "";      
		gclx_astclass.BindColVal =  "";      
		gclx_astris.BindColVal =  "";      
		txt_ASTUNIT.value =  "";             
		gcem_ASTQTY.text =  "";              
		txt_ASTSTD.value =  "";              
		gcem_ASTAQAMT.text =  "";            
		gcem_ASTYUSE.text =  "";             
		txt_USELOC.value =  "";              
		txt_buyfrom.value =  "";            
		txt_MAKER.value =  "";               
		txt_ASTNOTE.value =  "";             
		gcem_asnbr_2.text =  "";
	}else if(e=='2'){
		gcds_code31.clearAll();
		gcds_code32.clearAll();
		gcds_code33.clearAll();
		txt_ASTSOJE.value   = "";
		gcem_ASTPOST.text    = "";
		txt_ASTCON.value    = "";
		txt_ASTUSE.value    = "";
		gcem_ASTSIZE.text    ="";
		gcem_ASTPYUNG.text   ="";
		gcem_ASTREGYMD.text  = "";
		gcem_ASTREGNO.text   = "";                      
		txt_ACARTYPE.value ="";		
		txt_ACARNO.value   ="";	   		
		txt_ACARBEGI.value ="";			 
		txt_ACARFUEL.value ="";			 
		txt_ACARUSE.value  ="";			  
		gcem_ACARINSDT.text="";	  		
		txt_ACARDRVID.value="";	  		
		gcem_AINSDT2.text  ="";			
		txt_AMMODEL.value  ="";             
		gcem_AMAKEDATE.text="";       
		txt_ASUBSTD.value ="";              
		gcem_AMAKENO.text ="";           
		txt_AMFORM.value  ="";                  
		txt_AMOIL.value   ="";  
	}else if(e=='3'){
		gcem_ASTAQAMT2.text ="";         
		gcem_ASTYUSE2.text  ="";        
		gcem_ASTRMAMT.text  ="";        
		gclx_ASTDEPRST.BindColVal =""; 
		gcem_DEPRENDDT.text   ="";    
		gcem_ACDEPRAMT.text    ="";     
		gcem_ABDECAMT.text    ="";  
		gcem_ABDEPRAMT.text   =""; 
		gcem_ABBOOKAMT.text   =""; 
	}else if(e=='4'){
		gcds_code12.ClearAll();
		gcem_MOVDATE.text =""; 	
		txt_amngdept.value  =""; 
		txt_ausedept.value  =""; 
		txt_MYPLAN.value	 =""; 		
	}else if(e=='5'){
		gcds_code05.ClearAll();
		gcem_REPAIRDATE.text ="";
		txt_REPAIRPART.value="";
		txt_vend_cd2.value   ="";
		txt_DEFECTNOTE.value ="";
		gcem_REPAIRAMT.text  ="";
	}else if(e=='6'){
		gcds_code06.ClearAll();
		gcem_INSUREDATE.text="";
		gcem_INSHEETNO.text ="";		
		gcem_INSSTARTDT.text="";	
		gcem_INSENDDT.text  ="";
		gcem_INSTERM.text   ="";
		gcem_INSAMT.text    ="";	
		gcem_INSEDAMT.text  ="";
		txt_INSFIRM.value  ="";
		txt_vend_cd3.value  ="";
		txt_INSNOTE.value   ="";
	}else if(e=='7'){
		gcds_code13.ClearAll();
		gcem_LEASEDATE.text="";
		gclx_LEASECLS.BindColVal ="";
		txt_LEASEHOLD.text ="";
		txt_vend_cd4.value	="";
		gcem_LEASETERM.value="";
		gcem_LEASEAMT.text	="";
		gcem_LEASEGAMT.text ="";
		txt_LEASEWHY.value	="";
		gclx_LEASESTS.BindColVal ="";
		gcem_LEASEPYUNG.text="";
	}else if(e=='8'){
		gcds_code08.ClearAll();
		gcem_MORTDATE.text="";	
		gcem_MORTBANK.value="";
		txt_MORTBANK.value="";
		gclx_CLOSEORNOT.text="";
		gcem_CLOSEDATE.text="";
		gcem_BOOKAMT.text="";
		gcem_MORTSIZE.text="";	
		gcem_MORTJDGDT.text="";
		gcem_JUDGAMT.text="";
		gcem_MORTAMT.text="";
		txt_MORTDTL.value="";
		txt_MORTORDER.value="";
	}else if(e=='9'){
		gcds_code07.ClearAll();
		gcem_EVALDATE.text="";
		gcem_BEVALAMT.text="";
		gcem_EVALAMT.text="";
		gcem_DIFFAMT.text="";
		gcem_EVALAFYEAR.text="";
	}
}
/******************************************************************************
	Description : 등록 (초기화) 
	Parameter   : 02 - 자산 MST & 자산 BASIC
	              03 -
******************************************************************************/
function ln_Insert(s){

  if(s=="02"){
		ln_Add("01");
		ln_Enable("t");
	}
  
	if(s=='03'){
		gcds_code05.AddRow();
		tap5="1";
  }

	if(s=='04'){ 
		gcds_code06.AddRow();
		tap5="1";
	}

	if(s=='05'){
		gcds_code07.AddRow();
		tap5="1";
	}

	if(s=='06'){
		gcds_code08.AddRow();
		tap5="1";
	}

	if(s=='07'){
		gcds_code09.AddRow();
		tap5="1";
	}

	if(s=='08'){ //고정자산이동
		gcds_code12.AddRow();
		tap5="1";
	}

	if(s=='09'){
		gcds_code13.AddRow();
		tap5="1";
	}
}

/******************************************************************************
 Description : 자산조회에서 그리드 더블클릭시 데이터 넘겨주는 부분(ASTMST 부분)
******************************************************************************/
function ln_Data(row){

  var temp = gcds_code01.NameValue(row,"SEQ2");   // 자산번호(변경전)
  var temp1 = temp.substring(0,2);
  var temp2 = temp.substring(2,4);
  var temp3 = temp.substring(4,6); 	
  var ls_deptcd = "";

  gcem_asnbr_2.text=gcds_code01.namevalue(row,"SEQ");                //자산번호
  txt_jasan.value=gcds_code01.namevalue(row,"CDNAM");                //자산명
  gcem_jasan.text=gcds_code01.namevalue(row,"ASTNAME");              //자산명코드
  gclx_ast2nd.bindcolval=gcds_code01.namevalue(row,"AST2ND");        //자산중분류코드
  //txt_gunm_1.value=gcds_code01.namevalue(row,"ASTUNIT");           //규격명
	//gcem_gunm_1.text=gcds_code01.NameValue(row,"ASTNAME2");          //규격코드
  gcem_asaqsdat.text=gcds_code01.namevalue(row,"ASAQSDAT");           //취득일자
  txt_cadeptcd_3.value=gcds_code01.namevalue(row,"DEPTCD");          //담당부서코드 
  txt_cadeptnm_3.value=gcds_code01.namevalue(row,"DEPTNM");          //담당부서명 
  txt_empnm.value=gcds_code01.namevalue(row,"EMPNMK");               //담당자명
	txt_empno.value=gcds_code01.namevalue(row,"EMPNO");                //담장자사번 (hidden ) 
	txt_modelnm_1.value=gcds_code01.NameValue(row,"ASTNAME3");         //모델명

//gcem_asnbr_2.text= gcds_code01.NameValue(row,"SEQ");  	
//txt_cadeptcd_3.value = gcds_code01.NameValue(row,"MNGDPT");  	
//txt_cadeptnm_3.value = gcds_code01.NameValue(row,"MNGDPTNM");  	
//gcem_jasan.text=gcds_code01.NameValue(row,"ASTNAME");  
//txt_modelnm.value=gcds_code01.NameValue(row,"ASTNAME3");  
//txt_jasan.value=gcds_code01.NameValue(row,"CDNAM");  

  gclx_sfdcode2.BindColVal = temp1;         
  gclx_ast2nd.BindColVal   = temp2;

  if(gclx_ast2nd.BindColVal=='14'){
    gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
    gcds_ast3rd.Reset();
  }else if(gclx_ast2nd.BindColVal=='16'){
    gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
    gcds_ast3rd.Reset();
  }else{
    gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
    gcds_ast3rd.Reset();
  }
  gclx_ast3rd.BindColVal= temp3;
}

/******************************************************************************
	Description : 자산소분류  2010.04.30 생성함.
	parameter   : p- 중분류코드 
******************************************************************************/
function ln_Luxe_find(p) {
	if(p=='14'){
    gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
    gcds_ast3rd.Reset();
  }else if(p=='16'){
    gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
    gcds_ast3rd.Reset();
  }else{
    gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
    gcds_ast3rd.Reset();
  }
}

/******************************************************************************
	Description : display 적용화면 ....  
******************************************************************************/
function ln_DispChk(index){
  var div_cm = new Array("div_disp1","div_disp2");
	for(var i=0;i<=1;i++)	{
		if(i==index)  {
			eval("document.all."+div_cm[i]+".style.display='block';");	
	  }else{
			eval("document.all."+div_cm[i]+".style.display='none';");		
		}
	}	
}

/******************************************************************************
	Description : 원가코드 찾기
******************************************************************************/
function ln_Popup3(s){             
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	//strURL = "./A090001_popup.jsp";
	//strPos = "dialogWidth:495px;dialogHeight:419px;status:no;scroll:no;resizable:no";
 	//arrResult = showModalDialog(strURL,'',strPos);
  
	arrParam[0]="0030";//원가코드
	arrParam[1]="";
	arrParam[2]="";
	arrParam[3]="";

  strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if(s=='01'){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
				txt_COSTCD.value = arrParam[0];	
				txt_COSTNM.value  = arrParam[1];
		}else{
			  txt_COSTCD.value = "";	
				txt_COSTNM.value  = "";
		}
	}else if(s=='02'){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
				txt_ACOSTCD.value  = arrParam[0];	
				txt_ACOSTNM.value = arrParam[1];	
	  }else{
				txt_ACOSTCD.value  = "";	
				txt_ACOSTNM.value = "";	
		}
	}else if(s=='00'){
		if (arrResult != null) {
				arrParam = arrResult.split(";");
				txt_COSTCD_1.value  = arrParam[0];	
				txt_COSTNM_1.value = arrParam[1];	
	  }else{
				txt_COSTCD_1.value  = "";	
				txt_COSTNM_1.value = "";	
		}
	}
}

/******************************************************************************
	Description : 제작처 조회
******************************************************************************/
function ln_Popup9(){

	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;

	strURL = "./maker_popup.jsp";
	strPos = "dialogWidth:500px;dialogHeight:380px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,arrParam,strPos);

	if (arrResult != null) {
		arrParam = arrResult.split(";"); 
		txt_MAKER.value = ln_Trim(arrParam[0]);
		txt_MAKENM.value = ln_Trim(arrParam[1]); 
	} else {
		txt_MAKER.value = "";
		txt_MAKENM.value = "";
	}
}

/******************************************************************************
	Description : 원가코드 유무검색	
	parameter   :              
******************************************************************************/
function ln_Popup_Find2(obj,e){

	var  vend = eval(obj).value;

	if(event.keyCode!=113&&event.keyCode!=13) return;  //F2 또는 Enter
	gcDs2.DataId =  "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_s00?v_str1="+eval(obj).value+"&v_str2="; 	
	gcDs2.Reset();	
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;	

	if(e=='01'){
		if (gcDs2.countrow>0){
			strURL = "./ast_tr_ifrm.jsp";
			arrParam[0] = ln_Trim(vend);
			strPos = "dialogWidth:395px;dialogHeight:419px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);

			if (arrResult != null) {
				arrParam = arrResult.split(";");
				txt_COSTCD.value = arrParam[0];		
				txt_COSTNM.value = arrParam[1];
			}else {	
				alert("존재하지 않는 코드입니다"); 
				txt_COSTCD.value="";	
				txt_COSTNM.value = "";	
			}
		}
	}else if(e=='02'){
		if (gcDs2.countrow>0){
			strURL = "./ast_tr_ifrm.jsp";
			arrParam[0] = ln_Trim(vend);
			strPos = "dialogWidth:395px;dialogHeight:419px;status:no;scroll:no;resizable:no";
			arrResult = showModalDialog(strURL,arrParam,strPos);
			if (arrResult != null) {
				arrParam = arrResult.split(";");
				txt_ACOSTCD.value = arrParam[0];		  
				txt_ACOSTNM.value = arrParam[1];
			}else {	
				alert("존재하지 않는 코드입니다"); 
				txt_ACOSTCD.value = ""; 
				txt_ACOSTNM.value = "";		
			}
		}
	}		
}
/******************************************************************************
	Description : 면적 계산식 
******************************************************************************/
function ln_search(){
	var cal;
	var cal2 = gcem_ASTPYUNG.text;  
	/// 가로* 세로 평방미터 
	cal = (gcem_ASTSIZE.text) / 3.3058;
	gcem_ASTPYUNG.text = cal;
}

/******************************************************************************
	Description : 계정과목
******************************************************************************/
/****
function ln_search2(){

   if(gcem_atcode.text!=""){

	gcds_castcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_s99?v_str1="+gcem_atcode.text+"&v_str2="+""
	                                                  +"&v_str3="+""; 
//	prompt("gcds_castcode",gcds_castcode.DataID);
	gcds_castcode.Reset();  

   }
   if(txt_empno.value!="") {
	gcds_dam.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a090001_s98?v_str1="+txt_empno.value;
	gcds_dam.Reset();
	}
}
****/

/******************************************************************************
	Description : Dataset Head 설정   OK
	Parameter   : 00 - 자산MST,  02 - 자산BASIC  부가정보 31,32,33,
	              04 - 감가상각, 05 - 자산이동
								99 - 자산번호, 대표자산번호 : OUTPUT
******************************************************************************/
function ln_SetDataHeader(p){
	if(p=='00'){
		if (gcds_code00.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,AST1ST:STRING,AST2ND:STRING,AST3RD:STRING,"
								 + "ASTSEQ:STRING,ASTNAME:STRING,ASAQSDAT:STRING,TAXNBR:STRING,FSDAT:STRING,"
								 + "FSNBR:STRING,FSSEQ:STRING,DEPTCD:STRING,EMPNO:STRING,ASTNAME2:STRING,"
								 + "ASTNAME3:STRING,ASTNBR:STRING,H_ASTNBR:STRING,S_ASTNBR:STRING,ASTNAMENM:STRING,"
								 + "WRDT:STRING,WRID:STRING,UPDT:STRING,UPID:STRING,MORDT:STRING";
			gcds_code00.SetDataHeader(s_temp);
		}
	}else if(p=="02"){
		if (gcds_code02.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,AST1ST:STRING,AST2ND:STRING,AST3RD:STRING,"
								 + "ASTSEQ:STRING,MNGTYPE:STRING,ASTSTAT:STRING,ASCOSDIV:STRING,COSTCD:STRING,"
								 + "ASAQSDIV:STRING,GODDIV:STRING,ASTCLASS:STRING,ASTRIS:STRING,ASTUNIT:STRING,"
								 + "ASTQTY:DECIMAL,ASTSTD:STRING,ASTAQAMT:DECIMAL,ASTYUSE:DECIMAL,ASTVALYMD:STRING,"
								 + "MNGDPT:STRING,USEDPT:STRING,USELOC:STRING,BUYFROM:STRING,MAKER:STRING,"
								 + "ASTNOTE:STRING,ASTAQAMTY:DECIMAL,ASTUSER:STRING,WRDT:STRING,WRID:STRING,"
								 + "UPDT:STRING,UPID:STRING,REGIGB:STRING,DEPRGB:STRING ";
			gcds_code02.SetDataHeader(s_temp);
		}
	}else if(p=="31"){
		if (gcds_code31.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,AST1ST:STRING,AST2ND:STRING,AST3RD:STRING,"
								 + "ASTSEQ:STRING,ASTSOJE:STRING,ASTPOST:STRING,ASTCON:STRING,ASTUSE:STRING,"
								 + "ASTSIZE:STRING,ASTPYUNG:STRING,ASTREGYMD:STRING,ASTREGNO:STRING";
			gcds_code31.SetDataHeader(s_temp);
		}
	}else if(p=="32"){
		if (gcds_code32.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,AST1ST:STRING,AST2ND:STRING,AST3RD:STRING,"
								 + "ASTSEQ:STRING,ACARTYPE:STRING,ACARNO:STRING,ACARBEGI:STRING,ACARFUEL:STRING,"
								 + "ACARUSE:STRING,ACARINSDT:STRING,ACARDRVID:STRING,AINSDT1:STRING,AINSDT2:STRING";
			gcds_code32.SetDataHeader(s_temp);
		}
	}else if(p=="33"){
		if (gcds_code33.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,AST1ST:STRING,AST2ND:STRING,AST3RD:STRING,"
								 + "ASTSEQ:STRING,AMMODEL:STRING,AMAKEDATE:STRING,ASUBSTD:STRING,AMAKENO:STRING,"
								 + "AMWEIGHT:DECIMAL,AMFORM:STRING,AMOIL:STRING";
			gcds_code33.SetDataHeader(s_temp);
		}
	}else if(p=="04"){
		if (gcds_code04.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,AST1ST:STRING,AST2ND:STRING,AST3RD:STRING,"
								 + "ASTSEQ:STRING,ASTAQAMT:DECIMAL,ASTYUSE:DECIMAL,ASTRMAMT:DECIMAL,ASTDEPRST:VARCHAR,"
								 + "DEPRENDDT:VARCHAR,ABINSAMT:DECIMAL,ACINSAMT:DECIMAL,ABDECAMT:DECIMAL,ACDECAMT:DECIMAL,"
								 + "ABDEPRAMT:DECIMAL,ABBOOKAMT:DECIMAL,ACDEPRAMT:DECIMAL";
			gcds_code04.SetDataHeader(s_temp);
		}
  }else if(p=="05"){ //자산이동
		if (gcds_code12.countrow<1){
			var s_temp = "FDCODE:STRING,ATCODE:STRING,AST1ST:STRING,AST2ND:STRING,AST3RD:STRING,"
								 + "ASTSEQ:STRING,ASTMOVNO:VARCHAR,MOVDATE:VARCHAR,AMNGDEPT:VARCHAR,AUSEDPT:VARCHAR,"
								 + "ACOSTCD:VARCHAR,MOVNOTE:VARCHAR,WRDT:VARCHAR,WRID:VARCHAR,"
								 + "ACOSTNM:VARCHAR,AMNGDEPTNM:VARCHAR,AUSEDEPTNM:VARCHAR";
			gcds_code12.SetDataHeader(s_temp);
		}
	}else if(p=="99"){
		if (gcds_code99.countrow<1){
			var s_temp = "ASTNBR:STRING,H_ASTNBR:STRING";					
			gcds_code99.SetDataHeader(s_temp);
		}
	}
}

/******************************************************************************
	Description : 저장 버튼 lock 설정  OK
	Parameter   : 
******************************************************************************/
function ln_Save_Btn_lock(){

  //alert("gclx_aststat::"+gclx_aststat.BindColVal);
	//상태값이 정상이 아닌 경우 저장버튼 비활성화 
  if(gclx_aststat.BindColVal !='0') {   //정상이 아닐경우 ( 매각, 폐기, 이체 ) 
	 document.all.btn_save.style.display='none';
	 document.all.btn_off_save.style.display='block';

	 document.all.btn_save08.style.display='none';
	 document.all.btn_off_save08.style.display='block';

	 document.all.btn_save03.style.display='none';
	 document.all.btn_off_save03.style.display='block';

	 document.all.btn_save04.style.display='none';
	 document.all.btn_off_save04.style.display='block';

	 document.all.btn_save09.style.display='none';
	 document.all.btn_off_save09.style.display='block';

	 document.all.btn_save06.style.display='none';
	 document.all.btn_off_save06.style.display='block';

	 document.all.btn_save05.style.display='none';
	 document.all.btn_off_save05.style.display='block';
	}else {                               //정상인 경우 
	 document.all.btn_save.style.display='block';
	 document.all.btn_off_save.style.display='none';
	 
	 document.all.btn_save08.style.display='block';
	 document.all.btn_off_save08.style.display='none';

	 document.all.btn_save03.style.display='block';
	 document.all.btn_off_save03.style.display='none';

	 document.all.btn_save04.style.display='block';
	 document.all.btn_off_save04.style.display='none';

	 document.all.btn_save09.style.display='block';
	 document.all.btn_off_save09.style.display='none';

	 document.all.btn_save06.style.display='block';
	 document.all.btn_off_save06.style.display='none';

	 document.all.btn_save05.style.display='block';
	 document.all.btn_off_save05.style.display='none';
	}

  /*
	if(document.all.btn_save.style.display=='none'&& document.all.btn_off_save.style.display=='block'){

	}else{
	 
	}
	*/
}

/******************************************************************************
	Description : 분할저장 체크박스 클릭시 적용 ( 분할갯수 활성화 ) OK
	Parameter   : 
******************************************************************************/
function ln_Chkbox_Dvd(){
	if (chkbox_divide.checked ==true ){
		gcem_total.enable = true;
		gcem_total.text=0;
	}else{
	  gcem_total.text="";
    gcem_total.enable = false;
	}
}

/******************************************************************************
	Description : 부가정보 DataSet 설정 최초 저장시만 적용 OK
	Parameter   : 
******************************************************************************/
function fn_AdInfo_Set(){
  
	if(gcds_code00.SysStatus(gcds_code00.RowPosition)=="1"){
		gcds_code31.ClearAll(); 
		gcds_code32.ClearAll(); 
		gcds_code33.ClearAll(); 
	 
		//부가정보 데이터셋 생성//
		if(gclx_ast2nd.bindcolval=="11"||gclx_ast2nd.bindcolval=="12"||gclx_ast2nd.bindcolval=="13"){
			ln_SetDataHeader("31");
			gcds_code31.addrow();
			fn_AdInfo_keySet("31");
		}else if(gclx_ast2nd.bindcolval=="14"){
			ln_SetDataHeader("32");
			gcds_code32.addrow();
			fn_AdInfo_keySet("32");
		}else if(gclx_ast2nd.bindcolval=="15"||gclx_ast2nd.bindcolval=="16"||gclx_ast2nd.bindcolval=="17"){
			ln_SetDataHeader("33");
			gcds_code33.addrow();
			fn_AdInfo_keySet("33");
		}
	}
}

/******************************************************************************
	Description : 부가정보의 key값 가져오기  OK
	Parameter   : 
******************************************************************************/
function fn_AdInfo_keySet(p){

	if(p=="31"){
		gcds_code31.namevalue(gcds_code31.rowposition,"FDCODE")=gclx_sfdcode2.bindcolval;
		gcds_code31.namevalue(gcds_code31.rowposition,"ATCODE")=gcem_atcode.text;
		gcds_code31.namevalue(gcds_code31.rowposition,"AST1ST")=gclx_sfdcode2.bindcolval;
		gcds_code31.namevalue(gcds_code31.rowposition,"AST2ND")=gclx_ast2nd.bindcolval;
		gcds_code31.namevalue(gcds_code31.rowposition,"AST3RD")=gclx_ast3rd.bindcolval;
		gcds_code31.namevalue(gcds_code31.rowposition,"ASTSEQ")=gcem_astseq.text;
	}else if(p=="32"){
	  gcds_code32.namevalue(gcds_code32.rowposition,"FDCODE")=gclx_sfdcode2.bindcolval;
		gcds_code32.namevalue(gcds_code32.rowposition,"ATCODE")=gcem_atcode.text;
		gcds_code32.namevalue(gcds_code32.rowposition,"AST1ST")=gclx_sfdcode2.bindcolval;
		gcds_code32.namevalue(gcds_code32.rowposition,"AST2ND")=gclx_ast2nd.bindcolval;
		gcds_code32.namevalue(gcds_code32.rowposition,"AST3RD")=gclx_ast3rd.bindcolval;
		gcds_code32.namevalue(gcds_code32.rowposition,"ASTSEQ")=gcem_astseq.text;
	}else if(p="33"){
    gcds_code33.namevalue(gcds_code33.rowposition,"FDCODE")=gclx_sfdcode2.bindcolval;
		gcds_code33.namevalue(gcds_code33.rowposition,"ATCODE")=gcem_atcode.text;
		gcds_code33.namevalue(gcds_code33.rowposition,"AST1ST")=gclx_sfdcode2.bindcolval;
		gcds_code33.namevalue(gcds_code33.rowposition,"AST2ND")=gclx_ast2nd.bindcolval;
		gcds_code33.namevalue(gcds_code33.rowposition,"AST3RD")=gclx_ast3rd.bindcolval;
		gcds_code33.namevalue(gcds_code33.rowposition,"ASTSEQ")=gcem_astseq.text;
	}
}

/******************************************************************************
	Description : 계정코드 찾기
	Parameter   : 
******************************************************************************/
function ln_Find_Atcode(){
 
	if(gclx_ast2nd.BindColVal=='11'){
		gcem_atcode.text='1220100';
	} else if(gclx_ast2nd.BindColVal=='12'){
		gcem_atcode.text='1220200';
	} else if(gclx_ast2nd.BindColVal=='13'){
		gcem_atcode.text='1220300';
	} else if(gclx_ast2nd.BindColVal=='14'){
		gcem_atcode.text='1220600';
	} else if(gclx_ast2nd.BindColVal=='15'){
		gcem_atcode.text='1220400';
	} else if(gclx_ast2nd.BindColVal=='16'){
		gcem_atcode.text='1220700';
	} else if(gclx_ast2nd.BindColVal=='17'){
		gcem_atcode.text='1222100';
	}
}


/******************************************************************************
	Description : 중분류에서 소분류 찾기 
	Parameter   : 
******************************************************************************/
function ln_Find_Ast3rd(){
  //중분류에서 소분류 찾기 
	//자산소분류[검색]
	if(gclx_ast2nd.BindColVal=='14'){       //차량운반구
		gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
		gcds_ast3rd.Reset();
	}else if(gclx_ast2nd.BindColVal=='16'){ //공기구비품
		gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
		gcds_ast3rd.Reset();
	}else{                                  //
		gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
		gcds_ast3rd.Reset();
	}
  /**
	if(gclx_ast2nd.BindColVal==""){
		layer2.style.display="block";
		layer2_1.style.display="block";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
	}else if(gclx_ast2nd.BindColVal=='11'){ //토지건물구축물
	  //alert("11");
		layer2_1.style.display="block";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
	}else if(gclx_ast2nd.BindColVal=='12'){ //토지건물구축물
	  //alert("12");
		layer2_1.style.display="block";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
	}else if(gclx_ast2nd.BindColVal=='13'){//토지건물구축물
	  //alert("13");
		layer2_1.style.display="block";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
	}else if(gclx_ast2nd.BindColVal=='14'){//차량운반구
	  //alert("14");
		layer2_1.style.display="none";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="block";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
	}else if(gclx_ast2nd.BindColVal=='15'){//기계장치
	  //alert("15");
		layer2_1.style.display="none";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="block";
		layer2_6.style.display="none";
	}else if(gclx_ast2nd.BindColVal=='16'){ //공기구비품...가전,가구
	  //alert("16");
		layer2_1.style.display="none";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="block";
		layer2_6.style.display="none";
	}else if(gclx_ast2nd.BindColVal=='17'){//기계장치
	  //alert("17");
		layer2_1.style.display="none";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="block";
		layer2_6.style.display="none";
	}
	**/
}


/******************************************************************************
	Description : 부가정보 TAB 지정 함수
	Parameter   : 
******************************************************************************/
function ln_Find_Tab(){
	if(gclx_ast2nd.BindColVal==""){
		layer2.style.display="block";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
		layer2_1.style.display="block";
	}else if(gclx_ast2nd.BindColVal=='11'){ //토지건물구축물
	  //alert("11");
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
		layer2_1.style.display="block";
	}else if(gclx_ast2nd.BindColVal=='12'){ //토지건물구축물
	  //alert("12");
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
		layer2_1.style.display="block";
	}else if(gclx_ast2nd.BindColVal=='13'){//토지건물구축물
	  //alert("13");
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
		layer2_1.style.display="block";
	}else if(gclx_ast2nd.BindColVal=='14'){//차량운반구
	  //alert("14");
		layer2_1.style.display="none";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_5.style.display="none";
		layer2_6.style.display="none";
		layer2_4.style.display="block";
	}else if(gclx_ast2nd.BindColVal=='15'){//기계장치
	  //alert("15");
		layer2_1.style.display="none";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_6.style.display="none";
		layer2_5.style.display="block";
	}else if(gclx_ast2nd.BindColVal=='16'){ //공기구비품...가전,가구
	  //alert("16");
		layer2_1.style.display="none";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_6.style.display="none";
		layer2_5.style.display="block";
	}else if(gclx_ast2nd.BindColVal=='17'){//기계장치
	  //alert("17");
		layer2_1.style.display="none";
		layer2_2.style.display="none";
		layer2_3.style.display="none";
		layer2_4.style.display="none";
		layer2_6.style.display="none";
		layer2_5.style.display="block";
	}
}


/******************************************************************************
	Description : 자산등록 key 값 enable true false
	Parameter   : e = t : 사용, e = f 미사용
	기타        : 자산구분이 유형자산일 경우 감가상각처리 lock
	              그 외는 lock 하지 않음.
******************************************************************************/
function ln_Enable(e){
	if(e=="t"){
		gclx_sfdcode2.Enable  = true;    //지점
    //gcem_asnbr_2.ReadOnly = false;  //자산번호
    gclx_ast2nd.Enable = true;       //중분류
    gclx_ast3rd.Enable = true;       //소분류
   // gcem_ASTQTY.ReadOnly = false;    //수량      
		gcem_ASTYUSE.ReadOnly = false;   //내용연수  
		gcem_ASTAQAMT.ReadOnly = false;  //취득금액  
		gcem_ASTAQAMTY.ReadOnly = false; //외화금액 
		gclx_aststat.Enable = true;      //상태
		gclx_regigb.Enable = true;       //등록구분
		gcem_asaqsdat.ReadOnly = false;  //취득일자
    //gclx_deprgb.Enable = true;       //상각처리구분
		gclx_asaqsdiv.Enable = true;     //취득구분

		ln_Deprgb_lock();

    /**
		if(gclx_goddiv.bindcolval =="1"){ //유형자산일 경우  lock 
			gclx_deprgb.Enable = false;     //상각처리구분
		}else{
			gclx_deprgb.Enable = true;      //상각처리구분
		}
		**/

  }else if(e=="f"){
		gclx_sfdcode2.Enable = false;   //지점
    gcem_asnbr_2.ReadOnly = true;   //자산번호
    gclx_ast2nd.Enable = false;     //중분류
    gclx_ast3rd.Enable = false;     //소분류
    gcem_ASTQTY.ReadOnly = true;    //수량      
		gcem_ASTYUSE.ReadOnly = true;   //내용연수  
		gcem_ASTAQAMT.ReadOnly = true;  //취득금액  
		gcem_ASTAQAMTY.ReadOnly = true; //외화금액 
		gclx_aststat.Enable = false;    //상태
		gclx_regigb.Enable = false;     //등록구분
		gcem_asaqsdat.ReadOnly = true;  //취득일자
		//gclx_deprgb.Enable = false;     //상각처리구분
		gclx_asaqsdiv.Enable = false;   //취득구분

    ln_Deprgb_lock();

    /**
		if(gclx_goddiv.bindcolval =="1"){ //유형자산일 경우  lock 
			gclx_deprgb.Enable = false;     //상각처리구분
		}else{
			gclx_deprgb.Enable = true;      //상각처리구분
		}
		**/
		
		gcem_ASTQTY.ReadOnlyBackColor="#ccffcc";
		gcem_ASTYUSE.ReadOnlyBackColor="#ccffcc";
		gcem_ASTAQAMT.ReadOnlyBackColor="#ccffcc";
		gcem_ASTAQAMTY.ReadOnlyBackColor="#ccffcc";
	}
}


/******************************************************************************
	Description : 현재 존재하는 자산번호 찾기 - 자산번호가 존재하면 수정불가
	Parameter   : 
******************************************************************************/
function ln_Astnbr_Find_Chk(){
	
	//자산번호로 DB 체크하기
	if(gcem_astnbr.text!=""){
		alert("자산번호가 존재합니다. 수정할 수 없습니다.");
		return false;
	}

	return true;
}

/******************************************************************************
	Description : 최초자산번호 Display
	Parameter   :
******************************************************************************/
function ln_S_Astnbr_Display(){
	if(gclx_regigb.bindcolval =="1"){       //최초등록
		sp0.style.display = "none";           //숨김
	}else if(gclx_regigb.bindcolval =="2"){ //이체등록
   		sp0.style.display = "";               //보여줌
	}
}

/******************************************************************************
	Description : 자산 중분류에 따른 내용연수 Default 설정
	              건물, 구축물 : 15년 , 30년 
								차량운반구, 기계장치, 공기구비품 : 5년
								기타유형자산 : 5년 ( 개성은 별도 - 537개월로 한다고 하네...이건 1건이라 예외처리하삼. ) 
								토지 : 감가상각 안함.
	Parameter   : 
******************************************************************************/
function ln_Durable_Setting(){
	if(gclx_ast2nd.bindcolval =="14"||gclx_ast2nd.bindcolval =="15"||gclx_ast2nd.bindcolval =="16"){
		gcem_ASTYUSE.text=5.00;
	}else if(gclx_ast2nd.bindcolval =="12"||gclx_ast2nd.bindcolval =="13"){
    gcem_ASTYUSE.text=15.00;
	}else if(gclx_ast2nd.bindcolval =="17"){
		if(gclx_sfdcode2.bindcolval=="04"){ //개성일경우  537개월
      gcem_ASTYUSE.text=44.75;
		}else{
			gcem_ASTYUSE.text=5.00;
		}
	}else{
		gcem_ASTYUSE.text=0.00;
	}
}



/******************************************************************************
	Description : 자산구분에 따른 상각처리구분 lock 설정
	Parameter   : 
******************************************************************************/
function ln_Deprgb_lock(){
 //자산구분에 따른 상각처리구분 lock 설정
// alert("SysStatus::"+gcds_code02.SysStatus(gcds_code02.RowPosition));

  if(gcds_code02.SysStatus(gcds_code02.RowPosition)=="1"){
			gclx_deprgb.Enable = true;   //상각처리구분
	}else{
		if(gclx_goddiv.bindcolval=="1") {//유형자산
			gclx_deprgb.Enable = false;
			gcds_code02.namevalue(gcds_code02.rowposition,"DEPRGB") = gcds_code02.orgnamevalue(gcds_code02.rowposition,"DEPRGB");
		}else{
			gclx_deprgb.Enable = true;   //상각처리구분
		}
	}
}


 </script> 
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!-- 지점코드 -->
<OBJECT id=gcds_sfdcode classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<OBJECT id=gcds_sfdcode2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 담당부서 -->
<OBJECT id="gcds_dept" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- 관리부서 -->
<OBJECT id=gcds_dept2 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 관리부서 -->
<OBJECT id="gcds_dept3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- 관리부서 -->
<OBJECT id=gcds_dept4 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 자산분류 -->
<OBJECT id="gcds_asdivcod" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- 담당자 -->
<OBJECT id="gcds_empno" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- 상태코드 -->
<OBJECT id="gcds_sys" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- 매출원가구분-->
<OBJECT id="gcds_sys2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--자산중분류-->
<OBJECT id="gcds_ast2nd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

<!--자산소분류-->
<OBJECT id="gcds_ast3rd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

<!--자산소분류-->
<OBJECT id="gcds_asdivcod_2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

<!--관리구분-->
<OBJECT id="gcds_bgtgbcd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--리스유무-->
<OBJECT id="gcds_bgtgbcd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--자산등급-->
<OBJECT id="gcds_bgtgbcd3" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--자산구분-->
<OBJECT id="gcds_bgtgbcd4" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

<!--상각완료-->
<OBJECT id="gcds_ASTDEPRST" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--변경구분-->
<OBJECT id="gcds_CHGTYPE" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--감소구분-->
<OBJECT id="gcds_DECTYPE" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--해지여부-->
<OBJECT id="gcds_CLOSEORNOT" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--임대차구분-->
<OBJECT id="gcds_LEASECLS" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--임차상태-->
<OBJECT id="gcds_LEASESTS" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--자산MST-->
<OBJECT id="gcds_code00" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!--부가정보1-->
<OBJECT id="gcds_code31" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!--부가정보2-->
<OBJECT id="gcds_code32" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!--부가정보3-->
<OBJECT id="gcds_code33" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!--감가상각-->
<OBJECT id="gcds_code04" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--자산수리-->
<OBJECT id="gcds_code05" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--보험-->
<OBJECT id="gcds_code06" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--평가-->
<OBJECT id="gcds_code07" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--근저당-->
<OBJECT id="gcds_code08" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--@@사용안함.-->
<OBJECT id="gcds_code09" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!--자산이동.-->
<OBJECT id=gcds_code12 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!--임대/임차-->
<OBJECT id=gcds_code13 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!--@@사용안함.-->
<OBJECT id=gcds_code17 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!--자산조회-->
<OBJECT id=gcds_code01 classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<param name="syncload" value="false">
	<param name=SuppressOption value="3">
</OBJECT>

<!--자산 BASIC-->
<OBJECT id="gcds_code02" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!-- 소속[검색] -->
<OBJECT id=gcds_bfdivtcd classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</OBJECT>

<!-- 취득구분 -->
<OBJECT id="gcds_asaqsdiv" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

<!-- 거래처 -->
<OBJECT id="gcds_vend_cd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!-- 은행 -->
<OBJECT id="gcds_bank2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false">
</OBJECT>

<!--임대/차 거래처 -->
<OBJECT id="gcds_codecode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

<!--거래처 -->
<OBJECT id="gcds_bank" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

<!--공통 원가코드 -->
<OBJECT id="gcDs2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="true">
</OBJECT>

<!--자산번호 대표자산번호 OUTPUT-->
<OBJECT  id="gcds_code99" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
<PARAM NAME="SyncLoad" VALUE="true">
</OBJECT>

<!--권한체크 OUTPUT-->
<object  id=gcds_empno_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<!--취득일자와 상각마감체크 -->
<object  id=gcds_closechk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<!--자산등록저장-->
<OBJECT id="gctr_code00" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090001_t1(I:USER=gcds_code00)">
</OBJECT>

<!--@@보류자산평가-->
<OBJECT id="gctr_code02" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
  <PARAM NAME="KeyValue" VALUE="a090001_t2(I:USER=gcds_code02)">
</OBJECT>

<!--자산수리-->
<OBJECT id="gctr_code05" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090001_t5(I:USER=gcds_code05)">
</OBJECT>

<!--보험-->
<OBJECT id="gctr_code06" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090001_t6(I:USER=gcds_code06)">
</OBJECT>

<!--평가-->
<OBJECT id="gctr_code07" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090001_t7(I:USER=gcds_code07)">
</OBJECT>

<!--근저당-->
<OBJECT id="gctr_code08" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090001_t8(I:USER=gcds_code08)">
</OBJECT>

<!--@@보류변경-->
<OBJECT id="gctr_code09" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090001_t9(I:USER=gcds_code09)">
</OBJECT>

<!--자산이동-->
<OBJECT id="gctr_code12" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090021_t12(I:USER=gcds_code12)">
</OBJECT>

<!--임대/임차-->
<OBJECT id="gctr_code13" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
	<PARAM NAME="KeyValue" VALUE="a090001_t13(I:USER=gcds_code13)">
</OBJECT>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gcte_disp" event="onselChanged(index)">
var str1 =  gclx_sfdcode2.BindColVal;              //지점코드  필수
var str2 =  gcem_atcode.text;                      //계정코드  필수
var str3 =  gclx_sfdcode2.BindColVal;              //1구분
var str4 =  gclx_ast2nd.BindColVal;                //자산중분류 필수
var str5 =  gclx_ast3rd.BindColVal;                //자산소분류 필수
var str6 =  gcem_asnbr_2.text;                     //일련번호

//alert(":str1::"+str1+":str2::"+str2+":str3::"+str3+":str4::"+str4+":str5::"+str5+":str6::"+str6);
//alert("index:::"+index);

if(str1==""&& str2==""&& str3==""&& str4==""&& str5==""&& str6=="" ){ 
	return;
}else if(str1!=""&& str2!=""&& str3!=""&& str4!=""&& str6!=""){
	if(index=='1')        ln_Basic_Query(str6);
	else if(index=='2')   ln_Buga_Query();
	else if(index=='3')	  ln_Gamga();   	
	else if(index=='4')   ln_Move();
	else if(index=='5')   ln_Gosuri();
	else if(index=='6')   ln_Insurance();
	else if(index=='7')   ln_Rental();
	else if(index=='8')	  ln_Mortgage();
	else if(index=='9')   ln_Par();
	//else if(index=='10')  ln_change();
}
</script>

<!-- 지점코드 -->
<script language="javascript" for="gcds_sfdcode" event="onloadCompleted(row,colid)">
	gcds_sfdcode.InsertRow(1);
	gcds_sfdcode.NameValue(1,"FDCODE")="";
	gcds_sfdcode.NameValue(1,"FDNAME")="";
	gclx_sfdcode.index=0;
</script>

<!-- 자산중분류 (검색)-->
<script language="javascript" for="gcds_asdivcod" event="onloadCompleted(row,colid)">
	gcds_asdivcod.InsertRow(1);
	gcds_asdivcod.NameValue(1,"CDCODE")="";
	gcds_asdivcod.NameValue(1,"CDNAM")="전체";
	gclx_asdivcod.index=0;
</script>

<!-- 자산소분류 (검색)-->
<script language="javascript" for="gcds_asdivcod_2" event="onloadCompleted(row,colid)">
	gcds_asdivcod_2.InsertRow(1);
	gcds_asdivcod_2.NameValue(1,"CDCODE")="";
	gcds_asdivcod_2.NameValue(1,"CDNAM")="";
	gclx_asdivcod_2.index=0;
</script>

<!-- 관리구분  -->
<script language="javascript" for="gcds_bgtgbcd" event="onloadCompleted(row,colid)">
  gcds_bgtgbcd.InsertRow(1);	
  gcds_bgtgbcd.NameValue(1,"CDCODE")="";
	gcds_bgtgbcd.NameValue(1,"CDNAM")="";
	gclx_mngtype.index=0;
</script>

<!-- 리스유무  -->
<script language="javascript" for="gcds_bgtgbcd2" event="onloadCompleted(row,colid)">
  gcds_bgtgbcd2.InsertRow(1);	
  gcds_bgtgbcd2.NameValue(1,"CDCODE")="";
	gcds_bgtgbcd2.NameValue(1,"CDNAM")="";
	gclx_astris.index=0;
</script>

<!-- 자산등급  -->
<script language="javascript" for="gcds_bgtgbcd3" event="onloadCompleted(row,colid)">
  gcds_bgtgbcd3.InsertRow(1);	
  gcds_bgtgbcd3.NameValue(1,"CDCODE")="";
	gcds_bgtgbcd3.NameValue(1,"CDNAM")="";
	gclx_astclass.index=0;
</script>

<!-- 자산구분  -->
<script language="javascript" for="gcds_bgtgbcd4" event="onloadCompleted(row,colid)">
  gcds_bgtgbcd4.InsertRow(1);	
  gcds_bgtgbcd4.NameValue(1,"CDCODE")="";
	gcds_bgtgbcd4.NameValue(1,"CDNAM")="";
	gclx_goddiv.index=0;
</script>

<!-- 상각완료  -->
<script language="javascript" for="gcds_ASTDEPRST" event="onloadCompleted(row,colid)">
  gcds_ASTDEPRST.InsertRow(1);	
  gcds_ASTDEPRST.NameValue(1,"CDCODE")="";
  gcds_ASTDEPRST.NameValue(1,"CDNAM")="";
  gclx_ASTDEPRST.index=0;
</script>

<!-- 변경구분  -->
<script language="javascript" for="gcds_CHGTYPE" event="onloadCompleted(row,colid)">
  gcds_CHGTYPE.InsertRow(1);	
  gcds_CHGTYPE.NameValue(1,"CDCODE")="";
  gcds_CHGTYPE.NameValue(1,"CDNAM")="";
  //gclx_CHGTYPE.index=0;
</script>

<!-- 감소구분  -->
<script language="javascript" for="gcds_DECTYPE" event="onloadCompleted(row,colid)">
  gcds_DECTYPE.InsertRow(1);	
  gcds_DECTYPE.NameValue(1,"CDCODE")="";
  gcds_DECTYPE.NameValue(1,"CDNAM")="";
 // gclx_DECTYPE.index=0;
</script>

<!-- 해지여부 -->
<script language="javascript" for="gcds_CLOSEORNOT" event="onloadCompleted(row,colid)">
  gcds_CLOSEORNOT.InsertRow(1);	
  gcds_CLOSEORNOT.NameValue(1,"CDCODE")="";
  gcds_CLOSEORNOT.NameValue(1,"CDNAM")="";
  gclx_CLOSEORNOT.index=0;
</script>

<!-- 임대차구분-->
<script language="javascript" for="gcds_LEASECLS" event="onloadCompleted(row,colid)">
  gcds_LEASECLS.InsertRow(1);	
  gcds_LEASECLS.NameValue(1,"CDCODE")="";
  gcds_LEASECLS.NameValue(1,"CDNAM")="";
  gclx_LEASECLS.index=0;
</script>

<!-- 임차상태-->
<script language="javascript" for="gcds_LEASESTS" event="onloadCompleted(row,colid)">
  gcds_LEASESTS.InsertRow(1);	
  gcds_LEASESTS.NameValue(1,"CDCODE")="";
  gcds_LEASESTS.NameValue(1,"CDNAM")="";
  gclx_LEASESTS.index=0;
</script>

<script language="javascript" for="gcds_dept" event="onloadCompleted(row,colid)">
	gcds_dept.InsertRow(1);
	gcds_dept.NameValue(1,"DEPTCD")="";
	gcds_dept.NameValue(1,"DEPTNM")="";
//	gclx_fdcode02.index=0;
</script>

<script language="javascript" for="gcds_dept3" event="onloadCompleted(row,colid)">
	gcds_dept3.InsertRow(1);
	gcds_dept3.NameValue(1,"DEPTCD")="";
	gcds_dept3.NameValue(1,"DEPTNM")=" ";
//	gclx_cadeptcd_3.index=0;
</script>

<script language="javascript" for="gcds_dept4" event="onloadCompleted(row,colid)">
	gcds_dept4.InsertRow(1);
	gcds_dept4.NameValue(1,"DEPTCD")="";
	gcds_dept4.NameValue(1,"DEPTNM")="";
	//txt_usedpt.index=0;
</script>

<!--상태코드-->
<script language="javascript" for="gcds_sys" event="onloadCompleted(row,colid)">
	gcds_sys.InsertRow(1);
	gcds_sys.NameValue(1,"CDCODE")="";
	gcds_sys.NameValue(1,"CDNAM")="";
	gclx_aststat.index=0;
</script>

<!--상태코드-->
<script language="javascript" for="gcds_sys2" event="onloadCompleted(row,colid)">
	gcds_sys2.InsertRow(1);
	gcds_sys2.NameValue(1,"CDCODE")="";
	gcds_sys2.NameValue(1,"CDNAM")="";
	gclx_ascosdiv.index=0;
</script>

<script language="javascript" for="gcds_code01" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
	// document.all.LowerFrame.style.visibility="visible";

	ln_Buga_Query();
</script>

<script language="javascript" for="gcds_code31" event="onloadCompleted(row)">
	if (row <1) {
		alert("검색된 데이터가 없습니다.");   
 // alert(gcds_code31.countrow);
		gcds_code31.ClearAll();
 }else{  
 //alert(gcds_code31.NameValue(1,"ASTSOJE"));
	txt_ASTSOJE.value       = gcds_code31.NameValue(1,"ASTSOJE");
	gcem_ASTPOST.text       = gcds_code31.NameValue(1,"ASTPOST");
	txt_ASTCON.value			  = gcds_code31.NameValue(1,"ASTCON");
	txt_ASTUSE.value				= gcds_code31.NameValue(1,"ASTUSE");
	gcem_ASTSIZE.text				= gcds_code31.NameValue(1,"ASTSIZE");
	gcem_ASTPYUNG.text			= gcds_code31.NameValue(1,"ASTPYUNG");
	gcem_ASTREGYMD.text			= gcds_code31.NameValue(1,"ASTREGYMD");
	gcem_ASTREGNO.text			= gcds_code31.NameValue(1,"ASTREGNO");
	//alert("작업이 성공적으로 완료되었습니다.");
 }
</script>

<script language="javascript" for="gcds_code05" event="onloadCompleted(row)">
if (row <1)   alert("검색된 데이터가 없습니다.");  	
</script>


<script language="javascript" for="gcds_code17" event="onloadCompleted(row)">
//alert(gcds_code17.countrow);
</script>

<script language="javascript" for="gcds_code06" event="onloadCompleted(row)">
if (row <1)   alert("검색된 데이터가 없습니다."); 	
</script>

<script language="javascript" for="gcds_code07" event="onloadCompleted(row)">
if (row <1) alert("검색된 데이터가 없습니다."); 
</script>

<script language="javascript" for="gcds_code08" event="onloadCompleted(row)">
if (row <1)   alert("검색된 데이터가 없습니다."); 	
</script>

<script language="javascript" for="gcds_code09" event="onloadCompleted(row)">
if (row <1)   alert("검색된 데이터가 없습니다."); 	
</script>

<script language="javascript" for="gcds_code12" event="onloadCompleted(row)">
//alert(gcds_code12.countrow);
if (row <1) { 
	alert("검색된 데이터가 없습니다."); 
	sasan = 0 ;
}else { 
	sasan = 1 ;
}
</script>

<script language="javascript" for="gcds_code13" event="onloadCompleted(row)">
if (row <1)   alert("검색된 데이터가 없습니다."); 	
</script>

<script language="javascript" for="gcds_code32" event="onloadCompleted(row)">
	if (row <1) {
		alert("검색된 데이터가 없습니다."); 

		txt_ACARTYPE.value="";		
		txt_ACARNO.value="";	   		
		txt_ACARBEGI.value="";			 
		txt_ACARFUEL.value="";			 
		txt_ACARUSE.value="";			  
		gcem_ACARINSDT.text="";	  		
		txt_ACARDRVID.value="";	  		
		gcem_AINSDT2.text="";
	 }else{  
		txt_ACARTYPE.value  = gcds_code32.NameValue(1,"ACARTYPE");          
		txt_ACARNO.value    = gcds_code32.NameValue(1,"ACARNO");             
		txt_ACARBEGI.value  = gcds_code32.NameValue(1,"ACARBEGI");               
		txt_ACARFUEL.value  = gcds_code32.NameValue(1,"ACARFUEL");      
		txt_ACARUSE.value   = gcds_code32.NameValue(1,"ACARUSE");            
		gcem_ACARINSDT.text = gcds_code32.NameValue(1,"ACARINSDT");        
		txt_ACARDRVID.value = gcds_code32.NameValue(1,"ACARDRVID");             
		gcem_AINSDT2.text   = gcds_code32.NameValue(1,"AINSDT2");       
	 }
</script>

<script language="javascript" for="gcds_code33" event="onloadCompleted(row)">
	if (row <1) {
		alert("검색된 데이터가 없습니다."); 
		txt_AMMODEL.value="";             
		gcem_AMAKEDATE.text="";       
		txt_ASUBSTD.value="";              
		gcem_AMAKENO.text="";           
		txt_AMFORM.value="";                  
		txt_AMOIL.value="";           
	}else{  
		txt_AMMODEL.value  = gcds_code33.NameValue(1,"AMMODEL");          
		gcem_AMAKEDATE.text = gcds_code33.NameValue(1,"AMAKEDATE");             
		txt_ASUBSTD.value = gcds_code33.NameValue(1,"ASUBSTD");     			   
		gcem_AMAKENO.text   = gcds_code33.NameValue(1,"AMAKENO");      
		txt_AMFORM.value= gcds_code33.NameValue(1,"AMFORM");  			   
		txt_AMOIL.value = gcds_code33.NameValue(1,"AMOIL");         
	}
</script>

<script language="javascript" for="gcds_code04" event="onloadCompleted(row)">
	if (row <1) {
		alert("검색된 데이터가 없습니다.");
		gcem_ASTAQAMT2.text="";              //취득금액
		gcem_ASTYUSE2.text="";               //내용년수
		gcem_ASTRMAMT.text="";               //잔존가액
		gclx_ASTDEPRST.BindColVal="";        //감가상각완료구분 
		gcem_DEPRENDDT.text="";              //가상각완료일
		gcem_ACDEPRAMT.text="";               //전기증가누계액
		gcem_ABDECAMT.text="";               //기감소누계액
		gcem_ABDEPRAMT.text="";              //기상각누계액		 
		gcem_ABBOOKAMT.text="";              //장부가액
	}else{  
		gcem_ASTAQAMT2.text = gcds_code04.NameValue(1,"ASTAQAMT");          //취득금액
		gcem_ASTYUSE2.text = gcds_code04.NameValue(1,"ASTYUSE");            //내용년수
		gcem_ASTRMAMT.text = gcds_code04.NameValue(1,"ASTRMAMT");           //잔존가액
		gclx_ASTDEPRST.BindColVal = gcds_code04.NameValue(1,"ASTDEPRST");   //감가상각완료구분 
		gcem_DEPRENDDT.text = gcds_code04.NameValue(1,"DEPRENDDT");         //가상각완료일
		gcem_ACDEPRAMT.text = gcds_code04.NameValue(1,"ACDEPRAMT");           //전기증가누계액
		gcem_ABDECAMT.text = gcds_code04.NameValue(1,"ABDECAMT");           //기감소누계액
		gcem_ABDEPRAMT.text = gcds_code04.NameValue(1,"ABDEPRAMT");         //기상각누계액		 
		gcem_ABBOOKAMT.text = gcds_code04.NameValue(1,"ABBOOKAMT");         //장부가액
	}
</script>


<script language="javascript" for="gcds_code01" event="onloadCompleted(row)">

	if(row<1){
		window.status="조회가 완료 되었습니다.";
		ft_cnt01.innerText = "조회건수 : " + row + " 건";
		// // document.all.LowerFrame.style.visibility="hidden";
		alert("검색된 데이터가 없습니다.");   
	}else {
		for(var i=1;i<=gcds_code01.countrow;i++){
			var temp = gcds_code01.NameValue(i,"SEQ");  
			var temp1 =temp.substring(0,2);
			var temp2 =temp.substring(2,4);
			var temp3 =temp.substring(4,6);
			var temp4 = gcds_code01.NameValue(i,"ASTSEQ");
			if(temp1=='01')      temp1='S';
			else if(temp1=='02') temp1='S';
			else if(temp1=='03') temp1='K';
			else if(temp1=='04') temp1='G';

			if(temp2=='11')      temp2='L';
			else if(temp2=='12') temp2='B';
			else if(temp2=='13') temp2='S';
			else if(temp2=='14') temp2='V';
			else if(temp2=='15') temp2='I';
			else if(temp2=='16') temp2='F';
			else if(temp2=='17') temp2='E';

			if(temp3=='01')      temp3='H';
			else if(temp3=='02') temp3='B';
			else if(temp3=='03') temp3='C';
			else if(temp3=='04') temp3='O';
			else if(temp3=='05') temp3='T';
			else if(temp3=='06') temp3='F';
			else if(temp3=='07') temp3='E';
			else if(temp3=='00') temp3='0';
			else if(temp3=='=')  temp3='0';

			var temp5 = "" + temp1 + "" +  temp2 + "" + temp3+ "" + temp4;
			gcds_code01.NameValue(i,"SEQ") = temp5;
		} // for
		window.status="조회가 완료 되었습니다.";
		ft_cnt01.innerText = "조회건수 : " + row + " 건";
		// document.all.LowerFrame.style.visibility="hidden";
		gcgd_code01.Focus();

		if(gclx_ast2nd.BindColVal=='14'){
			gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
			gcds_ast3rd.Reset();
		}else if(gclx_ast2nd.BindColVal=='16'){
			gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
			gcds_ast3rd.Reset();
		}else{
			gcds_ast3rd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
			gcds_ast3rd.Reset();
		}
	}
</script>

<script language="javascript" for="gcds_code00" event="onloadCompleted(row)">
	if (row <1) {
		 alert("검색된 데이터가 없습니다.");   
		 ln_Enable('t');
		 ln_Insert('02');
	}else{
		 //데이터가 존재할 경우 자산 중분류 및 소분류 막음.
		 ln_Enable('f');
	}
</script>

<script language="javascript" for="gcds_code02" event="onloadCompleted(row)">
	ln_Save_Btn_lock();
	ln_S_Astnbr_Display();
</script>

<!-- 취득구분 -->
<script language="javascript" for="gcds_asaqsdiv" event="onloadCompleted(row,colid)">
	gcds_asaqsdiv.InsertRow(1);
	gcds_asaqsdiv.NameValue(1,"CDCODE")="";
	gcds_asaqsdiv.NameValue(1,"CDNAM")="";
	gclx_asaqsdiv.index=0;
</script>

<!-- 권한 -->
<script language="javascript" for="gcds_empno_chk" event="onloadCompleted(row,colid)">
		ln_Authority_Result(row,colid);
</script>


<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for=gcgd_code01  event=OnDblClick(row,colid)>
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";	
	if(row<1) return;	
	ln_DispChk(1);
	gcte_disp.ActiveIndex='1';
	//ln_Data(row);	
  ln_Luxe_find(gcds_code01.namevalue(row,"AST2ND"));
	ln_Mst_Query(gcds_code01.namevalue(row,"ASTNBR")); 
	ln_Basic_Query(gcds_code01.namevalue(row,"ASTNBR"));
	ln_Buga_Query();

	ln_Deprgb_lock();
	//ln_Query('02');	
	//eval("gclx_aststat").BindColVal='0';
	window.status="조회가 완료 되었습니다.";
</script>

<script language=JavaScript for=gclx_asdivcod event=OnSelChange()>
  //자산소분류[검색]
	if(gclx_asdivcod.BindColVal=='14'){
		gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=14";  
		gcds_asdivcod_2.Reset();
	}else if(gclx_asdivcod.BindColVal=='16'){
		gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=16";  
		gcds_asdivcod_2.Reset();
	}else{	
		gcds_asdivcod_2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a0900001_commdtil_s1?v_str1=2141&v_str2=00";    
		gcds_asdivcod_2.Reset();
	}	
</script>

<script language=JavaScript for=gclx_ast2nd event=OnSelChange2()>
  ln_Find_Atcode();     //계정코드 찾기 
	ln_Durable_Setting(); //내용연수 Default Setting 
	
	if(gclx_ast2nd.bindcolval=="11"){ //토지일경우 미상각
		gclx_deprgb.bindcolval="2";
	}
</script>

<script language=JavaScript for=gclx_ast2nd event=OnSelChange()>
  ln_Find_Ast3rd();
  //부가정보 텝 찾기
	ln_Find_Tab();
</script>  

<script language=JavaScript for=gclx_ast2nd event=OnKillFocus()>
	fn_AdInfo_Set(); 
</script>  

<script language=JavaScript for=gclx_ast3rd event=OnKillFocus()>
	fn_AdInfo_Set(); 
</script>  

<script language=JavaScript for=gcte_disp event=OnSelChanged(index)>
  //alert("텝클릭");
	ln_Find_Tab();
	//alert("텝클릭 END");
	if(gcte_disp.ActiveIndex==2&&gcem_asnbr_2.text!=""){ //부가정보
	  //alert("gcte_disp.ActiveIndex::"+gcte_disp.ActiveIndex+"::gcem_asnbr_2.text:::"+gcem_asnbr_2.text);
		ln_Query('02');	
	}
</script>


<script language=JavaScript for=gclx_regigb event=OnSelChange()>
  //최초자산번호 확인
	ln_S_Astnbr_Display();

	//alert("gcds_code00::"+gcds_code00.SysStatus(gcds_code00.RowPosition));
	if(gclx_aststat.bindcolval!=0&&gcds_code00.SysStatus(gcds_code00.RowPosition)=="1"){  //신규입력
		alert("최초등록 및 이체등록시 상태구분은 정상이 되어야 합니다.");
		gclx_aststat.bindcolval="0";
	}
</script>  

<script language=JavaScript for=gclx_goddiv event=OnSelChange()>
  //자산구분에 따른 상각처리구분 lock 설정
	ln_Deprgb_lock();
	/**
	if(gclx_goddiv.bindcolval=="1") {//유형자산
		gclx_deprgb.Enable = false;
    gcds_code02.namevalue(gcds_code02.rowposition,"DEPRGB") = gcds_code02.orgnamevalue(gcds_code02.rowposition,"DEPRGB");
	}else{
		gclx_deprgb.Enable = true;   //상각처리구분
	}
	**/
</script>  


<script language=JavaScript for=gclx_sfdcode2 event=OnSelChange()>
  	//부가정보 데이터셋에 지점 변경//
		if(gclx_ast2nd.bindcolval=="11"||gclx_ast2nd.bindcolval=="12"||gclx_ast2nd.bindcolval=="13"){
			fn_AdInfo_keySet("31");
		}else if(gclx_ast2nd.bindcolval=="14"){
			fn_AdInfo_keySet("32");
		}else if(gclx_ast2nd.bindcolval=="15"||gclx_ast2nd.bindcolval=="16"||gclx_ast2nd.bindcolval=="17"){
			fn_AdInfo_keySet("33");
		}
 
</script> 
 

<!-----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_code00" event="onsuccess()">
  alert("작업이 성공적으로 완료 했습니다.");
  var strParam="";

	if(gs_delete_gb=="Y"){ //삭제건
		strParam="9999999";
	}else{
		if(gcem_asnbr_2.text==""){ //신규건
			gcem_asnbr_2.text = gcds_code99.namevalue(gcds_code99.rowposition,"ASTNBR");
			gcem_h_asnbr_2.text = gcds_code99.namevalue(gcds_code99.rowposition,"H_ASTNBR");
			strParam = gcem_asnbr_2.text;
		}else{ //수정건
			strParam = gcem_asnbr_2.text;
		}
	}
  
	ln_Mst_Query(strParam);
	ln_Basic_Query(strParam);
	ln_Buga_Query();

	gs_delete_gb="";
</script> 

<script language="javascript" for="gctr_code00" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code00.ErrorCode + "\n" + "Error Message : " + gctr_code00.ErrorMsg + "\n");
	gs_delete_gb="";
</script>

</SCRIPT>
<script language="javascript" for="gctr_code02" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code02.ErrorCode + "\n" + "Error Message : " + gctr_code02.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_code02" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>


<script language="javascript" for="gctr_code05" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
  ln_Query('02');
</script>

<script language="javascript" for="gctr_code05" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code05.ErrorCode + "\n" + "Error Message : " + gctr_code05.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_code06" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
  ln_Query('02');
</script>

<script language="javascript" for="gctr_code06" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code06.ErrorCode + "\n" + "Error Message : " + gctr_code06.ErrorMsg + "\n");
</script>


<script language="javascript" for="gctr_code12" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_code12.ErrorCode + "\n" + "Error Message : " + gctr_code12.ErrorMsg + "\n");
</script>

<script language="javascript" for="gctr_code12" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
  ln_Query('02');  
</script>

<script language="javascript" for="gctr_code13" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_code13" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
   ln_Query('02');  
</script>

<script language="javascript" for="gctr_code08" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_code08" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
    ln_Query('02');  
</script>

<script language="javascript" for="gctr_code07" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_code07" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
  ln_Query('02');  
</script>

<script language="javascript" for="gctr_code09" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

<script language="javascript" for="gctr_code09" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
  ln_Query('02');  
</script>


<script language="javascript" for="gctr_code01" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
</script>

<script language="javascript" for="gctr_code01" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
</script>

</HEAD>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<!-----------------------------------------------------------------------------
B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<table id="div_disp1" cellpadding="0" cellspacing="0" border="0" >
	<tr>
		<td>
			<table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
				<tr>      
          <td><img src="../img/a090001_1_head.gif"></td>
					<td width="685" align="right" background="../../Common/img/com_t_bg.gif" style="padding-top:4px;"> 
						<img src="../../Common/img/btn/com_b_excel.gif"	 style="cursor:hand;" onclick="ln_Excel()"> 
						<img src="../../Common/img/btn/com_b_insert.gif" style="cursor:hand;" onClick="ln_Add('01')" >
						<img src="../../Common/img/btn/com_b_query.gif"  style="cursor:hand;" onclick="ln_Query('01')">
					</td>			
				</tr>
			</table>
		</td>
	</tr>
  <tr>  
    <td colspan=2>
		  <!--자산등록조회 -->
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:876px;height:30px;font-size:9pt;background-color:#ffffff;position:relative;left:3px;border:1 solid #708090'> 
		    <tr> 				
 					<td class="tab21" width="80px;" style="" bgcolor="#eeeeee" align="center">지&nbsp;&nbsp;&nbsp;&nbsp;점</td>
					<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " width="160px;" >&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gclx_sfdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
						<param name=ComboDataID         value="gcds_sfdcode">
						<param name=CBDataColumns	      value="FDCODE,FDNAME">
						<param name=SearchColumn	      value="FDNAME">
						<param name=Sort			          value=false>
						<param name=ListExprFormat      value="FDNAME^0^120">								
						<param name=BindColumn		      value="FDCODE">
						<param name=XPStyle             value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 						
					</td> 
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab21" align=center >취득일자</td>
					<td class="tab22" style="width:245px;border-bottom-width:1px;border-right-width:1px;" >&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_asq_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:-3px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_asq_fr', 'Text')" style="position:relative;width:20px;left:-9px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_asq_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:-3px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
				    <img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_asq_to', 'Text')" style="position:relative;width:20px;left:1px;top:1px;cursor:hand;">
					</td> 
					<td class="tab21" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " width="80px;" bgcolor="#eeeeee" align="center">원가명</td>
				  <td style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " >&nbsp;
						<nobr> 
					  <input id="txt_COSTNM_1" type="text"  style= "position:relative;top:-1px;left:-3px; width:130px; height:20px;" class="txtbox" readOnly >			
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-5px;cursor:hand"	 onclick="ln_Popup3('00')">
						<input id=txt_COSTCD_1   type=text    style= "position:relative;top:-1px;left:-5px;width:50px; height:20px;"  class="txtbox"  readOnly >
				    </nobr> 
					</td> 
				</tr>
				<tr width="876px"> 
					<td width="80px" style="border-bottom-width:1px;" bgcolor="#eeeeee" class="tab23" align=center><nobr>자산중분류</nobr></td>
					<td class="tab19" style="width:160px;border-bottom-width:1px;">&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gclx_asdivcod classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
							<param name=ComboDataID			value="gcds_asdivcod">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^120">
							<param name=BindColumn			value="CDCODE">
							<param name=XPStyle         value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 				
					</td>		
					<td width="80px"  style="border-bottom-width:1px;" bgcolor="#eeeeee" class="tab23" align=center><nobr>자산소분류</nobr></td>
					<td class="tab19" style="width:240px;border-bottom-width:1px;"><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gclx_asdivcod_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:120px;border-right-width:0px;right:0px;">
							<param name=ComboDataID			value="gcds_asdivcod_2">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^150">
							<param name=BindColumn			value="CDCODE">
							<param name=XPStyle         value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 			
					</td>								
					<td width="80px"  style="border-right-width:1px;border-bottom-width:1px;" bgcolor="#eeeeee" class="tab23" align=center><nobr>자산명</nobr></td>
					<td class="tab19" style="width:210px;border-bottom-width:1px;border-right-width:0px;"><nobr>&nbsp;
							<input id="txt_jasan_1" type="text" class="txtbox"  style= "width:130px;height:20px;position:relative;top:-1px;left:-3px;" readOnly>
						<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-5px;cursor:hand"	 onclick="ln_ProPopup('01')">
						<comment id="__NSID__">
						<OBJECT id=gcem_jasan_1 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:3px;left:-6px;width:50px">
							<param name=Text				value="">
							<param name=Alignment		value=0>
							<param name=Border			value=true>
							<param name=Format			value="#######">
							<param name=PromptChar	value="_">
							<param name=ReadOnly    value="true">
						</OBJECT></comment><script>__ws__(__NSID__);</script></nobr> 
						
						<!-- <input id="txt_cadeptcdnm" type="text" class="txtbox"  style= "position:relative;top:-1px;left:-6px;width:129px;height:20px;background-color:#ccffcc;" onBlur="bytelength(this,this.value,36);" readOnly>							
						<img name="btn_find" src="../../common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-7px;cursor:hand"	    onclick="ln_Popup0('00')">
						<input id=txt_cadeptcd     type=text   class="txtbox"  style= "position:relative;top:-1px;left:-6px;width:50px;height:20px;background-color:#ccffcc;"  onkeydown="ln_Popup0('00');" readOnly> -->
	
					</td>
				</tr>  
				<!----------------------------------------------------------------------------------------------------------------->
				<tr width="876px"> 
					<td width="80px" style="" bgcolor="#eeeeee" class="tab23" align=center><nobr>상태구분</nobr></td>
					<td class="tab19" style="width:160px;border-bottom-width:0px;">&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gclx_sys_fr classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
							<param name=CBData					value="^전체,0^정상,1^매각,2^폐기,8^이체">
							<param name=CBDataColumns		value="Code, Parm">
							<param name=SearchColumn		value="Parm">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="Parm^0^120">
							<param name=BindColumn			value="Code">
							<param name=XPStyle         value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 						
					</td>		
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab23" align=center><nobr>전표상태</nobr></td>
					<td class="tab19" style="width:240px;border-bottom-width:0px;"><nobr>&nbsp;
					  <comment id="__NSID__">
						<OBJECT id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:120px;">
							<param name=CBData				  value="A^전체,Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
							<param name=CBDataColumns		value="Code, Parm">
							<param name=SearchColumn		value="Parm">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="Parm^0^120">
							<param name=BindColumn			value="Code">
							<param name=XPStyle         value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 		

						<!-- <comment id="__NSID__">
						<OBJECT id=gcem_h_astnbr_fr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:0px;width:65px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="########">
							<param name=UpperFlag     value=1>
							<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;~	&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_h_astnbr_to classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F style="position:relative;top:2px;left:0px;width:65px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="########">
							<param name=UpperFlag     value=1>
							<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> -->
						</nobr>
					</td>								
<!-- 					<td width="80px"  style="height:20px;border:0 solid #708090;border-right-width:1px;border-left-width:0px;padding-left:0px;padding-right:1px;border-bottom-right-left-width:1px;border-bottom-width:0px;" bgcolor="#eeeeee" class="tab23" align=center><nobr>&nbsp;</nobr></td>
					<td class="tab19" style="width:210px;border-bottom-width:0px;border-right-width:0px;"><nobr>&nbsp;
					</td>
 -->				
				  <td width="80px" style="" bgcolor="#eeeeee" class="tab23" align=center><nobr>담당자||사용자</nobr></td>
					<td class="tab19" style="width:240px;border-bottom-width:0px;">&nbsp;
						<input id="txt_empnm_1" name="txt_empnm_1"	style="position:relative;left:-2px;top:0px;width:50px;" class="txtbox" align=left readOnly> 
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="담당자를 검색합니다" style="cursor:hand;left:-12px;" align=center onclick="ln_Popup5('txt_empnm_1');">
						<input id="txt_empno_1" name="txt_empno_1"	type='hidden'	style="width:90px;left:px" class="txtbox" >&nbsp;||&nbsp;


                        <input id="txt_astusernm_1" name="txt_astusernm_1"	style="position:relative;left:-2px;top:0px;width:50px;" class="txtbox" align=left readOnly> 
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="사용자를 검색합니다" style="cursor:hand;left:-12px;" align=center onclick="ln_Popup5('txt_astusernm_1');">
						<input id="txt_astuser_1" name="txt_astuser_1"	type='hidden'	style="width:90px;left:px"  >


						<!-- <comment id="__NSID__">
						<OBJECT id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:-6px;top:2px;font-size:12px;width:120px;">
							<param name=CBData				  value="A^전체,Y^결재완료,R^결재요청,N^결재대기,C^결재취소,B^반송">
							<param name=CBDataColumns		value="Code, Parm">
							<param name=SearchColumn		value="Parm">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="Parm^0^120">
							<param name=BindColumn			value="Code">
							<param name=XPStyle         value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	 -->					
					</td>					
				</tr>  
		 </table>
		</td>
	</tr> 
	<tr>
		<td height="3px" colspan =2 align="left" valign="top"></td>
	</tr>
	<tr>
		<td>
			<table cellpadding="0" cellspacing="0" border="0" style="position:relative;left:0px;top:0px;width:280px;border:0 solid #708090;">
				<tr> 			
					<td>
						<comment id="__NSID__">
						<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code01  style="position:relative;left:3px;width:874px; height:360px; border:1 solid #708090;">
							<PARAM NAME="DataID"		   VALUE="gcds_code01">
							<PARAM NAME="BorderStyle"  VALUE="0">
							<PARAM NAME="Fillarea"		 VALUE="true">
							<PARAM NAME="Sortview"		 VALUE="left">
							<param name="ColSizing"    value="true">
							<param name="Editable"     value="false">
							<PARAM NAME="IndWidth"		 VALUE ='0'>
							<param name=LineColor      value="green">
							<PARAM NAME="Format"			 VALUE="  
							<FC> Name='대표번호'   	 ID=H_ASTNBR  HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center suppress=2</FC> 
							<FC> Name='자산번호'	     ID=ASTNBR    HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center  </FC> 
							<FC> Name='자산번호'	     ID=SEQ  	    HeadAlign=Center HeadBgColor=#B9D4DC Width=60		align=center show=false</FC> 
							<FC> Name='자산번호'	     ID=SEQ2  	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70		align=center show=false  EDIT=NUMBER sort=true</FC> 
							<FC> Name='취득일자'	     ID=ASAQSDAT  HeadAlign=Cente  HeadBgColor=#B9D4DC Width=65   align=center Mask='XXXX/XX/XX'</FC> 
							<FC> Name='자산분류'	     ID=AST2ND    HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=left   EditStyle='lookup' Data='gcds_asdivcod:CDCODE:CDNAM' </FC> 
							<C> Name='자산명'	       ID=CDNAM	    HeadAlign=Center HeadBgColor=#B9D4DC Width=150	align=left   </C> 
							<C> Name='단위'					 ID=ASTUNIT   HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center </C> 
							<C> Name='수량'					 ID=ASTQTY	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=right  </C> 
							<C> Name='취득금액'			 ID=ASTAQAMT  HeadAlign=Center HeadBgColor=#B9D4DC Width=80 	align=right  </C>
							<C> Name='년수'					 ID=ASTYUSE	  HeadAlign=Center HeadBgColor=#B9D4DC Width=30	  align=center  dec=2</C>
							<C> Name='사용부서'			 ID=USEDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=90  	align=left   </C>
							<C> Name='관리부서'			 ID=MNGDPTNM	HeadAlign=Center HeadBgColor=#B9D4DC Width=90   align=left   </C>
							<C> Name='원가'   			 ID=COSTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=90   align=left   </C>
					  	<C> Name='사용자'				 ID=EMPNMK	  HeadAlign=Center HeadBgColor=#B9D4DC Width=45 	align=left   </C>
							<C> Name='상태'				   ID=ASTSTAT	  HeadAlign=Center HeadBgColor=#B9D4DC Width=45 	align=left  EditStyle=Lookup Data='gcds_sys:CDCODE:CDNAM' </C>
							<C> Name='접수일자'			 ID=FSDAT 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=60 	align=center   </C>
							<C> Name='접수번호'			 ID=FSNBR 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=50 	align=center   </C>
							<C> Name='순번' 				 ID=FSSEQ 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=35 	align=center   </C>
							<C> Name='전표상태'			 ID=FSSTAT 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=55 	align=center  EditStyle=Combo, Data='Y:결재완료,C:결재취소,R:결재요청,N:결재대기,B:반송'  </C>
							">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="position:relative;left:3px;width:876px;height:20px;border:1 solid #708090;border-top-width:0px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt01 style="position:relative;top:4px;"></font>
						</fieldset>
				</td>
				</tr>
				</table>
		</td>
	</tr>
</table>	
<!--================================================================================================
						L O A D I N G  B A R   D E F I N I T I O N
==================================================================================================-->
<iframe id="LowerFrame" name="work" style="visibility:hidden;position:absolute;left:280px;top:220px;" FrameBorder="0" src="../../Common/img/flash/loading.swf" width="320px" height="42px">
</iframe> 
<!--자산등록(기본정보)================================================================================== -->
<table id="div_disp2" cellpadding="0" cellspacing="0" border="0" style="display:none">
	<tr>
		<td>
       <table width="876" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px" >
       <tr>      
	      <td  background="../../Common/img/com_t_bg.gif"  align=left><img src="../img/a090001_head.gif">
          <table id="div_dbtn" width="200px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:50px">
						<tr>
							 <td align="right"><nobr>
								<img id="btn_exit"   src="../../Common/img/btn/com_b_exit.gif"       style="position:relative;left:600px;top:-37px;cursor:hand;display:block" onclick="ln_Cancel('02')"></td>
							 
							  <span id=sp1 style="display:none;"> 
							  <td align="right">
							 	<img id="btn_delete" src="../../Common/img/btn/com_b_delete.gif"	   style="position:relative;left:605px;top:-37px;cursor:hand;display:block" onClick="ln_Delete('02')">
								</td>
                </span>

							 <td align="right">
								<img id="btn_insert" src="../../Common/img/btn/com_b_insert.gif"	   style="position:relative;left:610px;top:-37px;cursor:hand;display:block" onClick="ln_Insert('02')"></td>
							 <td align="right">
								<img id="btn_save"   src="../../Common/img/btn/com_b_save.gif"	     style="position:relative;left:615px;top:-37px;cursor:hand;display:block" onClick="ln_Save('02')"></td>
							 <td align="right">	
								 <img id="btn_off_save" src="../../Common/img/btn/com_off_save.gif"	 style="position:relative;left:615px;top:-37px;cursor:hand;display:none" ></td> 
							 <td align="right">	
								<img id="btn_query"  src="../../Common/img/btn/com_b_query.gif" 	   style="position:relative;left:620px;top:-37px;cursor:hand;display:block" onclick="ln_Query('02')"></nobr></td>
					  </tr>
					</table>
		   </td>
		</td>
  </tr>
  <tr>  
    <td colspan=2>
			<table  cellpadding="1" cellspacing="0" border="0"  style='width:876px;height:30px;font-size:9pt;position:absolute;top:50px;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>      
<!---------------------------------------------------------------------------------------------------------------------->	
				<tr width="876px"> 		
					<td class="tab21" style="height:30px;width:80px;border-left-color:ff0000;" bgcolor="#eeeeee" align="left">&nbsp;<font color="#ff0000">*</font>&nbsp;지점</td> 	
					<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " width="115px;" >&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gclx_sfdcode2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 style="position:relative;left:0px;top:2px;font-size:12px;width:115px;">
							<param name=ComboDataID          value="gcds_sfdcode2">
							<param name=CBDataColumns	       value="FDCODE,FDNAME">
							<param name=SearchColumn	       value="FDNAME">
							<param name=Sort			           value=false>
							<param name=ListExprFormat       value="FDNAME^0^120">								
							<param name=BindColumn		       value="FDCODE">
							<param name=XPStyle              value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 				
					 </td> 
					 <td width="80px"  style="" bgcolor="#eeeeee" class="tab21" align="left" >&nbsp;&nbsp;자산번호</td>
					 <td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:1px;text-align;height:30px;font-family:굴림;font-size:9pt; " width="225px;" >&nbsp;
							<comment id="__NSID__">
							<OBJECT id=gcem_asnbr_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:0px;top:2px">	
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="########">
								<param name=PromptChar  value="_">
								<param name=UpperFlag   value=1>
								<param name=ReadOnly    value="true">
								<param name=ReadOnlyBackColor   value="#ccffcc">	
							</OBJECT>&nbsp;&nbsp;             
						  <font style="position:relative;top:-3px;left:0px" color="blue">분할저장</font>&nbsp;
              <input type=checkbox  id=chkbox_divide  style="width:15px;position:relative;left:0px;top:-3px;color=#CCFFCC";  onclick="ln_Chkbox_Dvd()">&nbsp;&nbsp;
							<OBJECT id=gcem_total classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:30px;height:20px;position:relative;left:-6px;top:2px;">	
								<param name=Text				value="">
								<param name=Alignment		value=2>
								<param name=Border		  value=true>
							  <param name=MaxLength   value=4>
								<param name=IsComma	    value=false>
								<param name=Enable      value=false>
							</OBJECT>
							</comment><script>__ws__(__NSID__);</script> 
					 </td> 
	         <!--    </td>			 -->
           <td width="80px"  style="" bgcolor="#eeeeee" class="tab21" align="left">&nbsp;대표자산번호</td>
					 <td class="tab22" style="width:130px;"><nobr>&nbsp;	
							<comment id="__NSID__">
							<OBJECT id=gcem_h_asnbr_2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:70px;height:20px;position:relative;left:-6px;top:2px">	
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="########">
								<param name=PromptChar  value="_">
								<param name=UpperFlag   value=1>
								<param name=ReadOnly    value="true">
								<param name=ReadOnlyBackColor   value="#ccffcc">						
							</OBJECT>
							</comment><script>__ws__(__NSID__);</script></nobr>
						</td>
					</tr>
<!----------------------------------------------------------------------------------------------------------------->
					<tr width="876px"> 
						<td width="80px" style="" bgcolor="#eeeeee" class="tab19" align="left"><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;자산중분류</nobr></td>
						<td class="tab19" style="width:120px;" ><nobr>&nbsp;
							<comment id="__NSID__">
							<OBJECT id=gclx_ast2nd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69	style="position:relative;left:0px;top:2px;font-size:12px;width:115px;">
									<param name=ComboDataID			value="gcds_ast2nd">
									<param name=CBDataColumns		value="CDCODE,CDNAM">
									<param name=SearchColumn		value="CDNAM">
									<param name=Sort						value=false>
									<param name=ListExprFormat	value="CDNAM^0^120">
									<param name=BindColumn			value="CDCODE">
									<param name=XPStyle         value=true>
							</OBJECT>
							</comment><script>__ws__(__NSID__);</script></nobr>
						</td>		
						<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align="left" >&nbsp;&nbsp;&nbsp;자산소분류</td>
						<td class="tab19" style="width:120px;"><nobr>&nbsp;
								<comment id="__NSID__">
								<OBJECT id=gclx_ast3rd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 	style="position:relative;left:0px;top:2px;font-size:12px;width:135px;">
									<param name=ComboDataID			value="gcds_ast3rd">
									<param name=CBDataColumns		value="CDCODE,CDNAM">
									<param name=SearchColumn		value="CDNAM">
									<param name=Sort				    value=false>
									<param name=ListExprFormat	value="CDNAM^0^150">
									<param name=BindColumn			value="CDCODE">
									<param name=XPStyle         value=true>
							  </OBJECT>
								</comment><script>__ws__(__NSID__);</script> 
						</td>
						<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align="left">&nbsp;<font color="#ff0000">*</font>&nbsp;자산명</td>
						<td class="tab22" style="width:120px;"><nobr>&nbsp;	
							<input id="txt_jasan" type="text" class="txtbox"  style= "width:130px;height:20px;position:relative;top:-1px;left:-6px;background-color:#ccffcc;" readOnly>
							<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-10px;cursor:hand"	 onclick="ln_ProPopup('02')">
							<comment id="__NSID__">
							<OBJECT id=gcem_jasan classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:-6px;width:50px">
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#######">
								<param name=PromptChar	value="_">
								<param name=ReadOnly    value="true">
								<param name=ReadOnlyBackColor   value="#ccffcc">							
							</OBJECT>
							</comment><script>__ws__(__NSID__);</script> </nobr>
						</td>
					</tr>              
<!------------------------------------------------------------------------------------------------------------------>
					<tr width="876px"> 
						<td style="height:30px;border:1 solid #708090;border-top-width:0px;padding-left:0px;padding-right:0px;border-bottom-width:1px;border-left-width:0px;height:30px;width:80px;" bgcolor="#eeeeee" align="left">&nbsp;<font color="#ff0000">*</font>&nbsp;취득일자</td>  				
						<td class="tab23" style="height:30px;border:1 solid #708090;border-top-width:0px;padding-left:0px;padding-right:0px;border-bottom-width:1px;border-left-width:0px">
							<comment id="__NSID__">
							<OBJECT id=gcem_asaqsdat classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:8px;width:70px;height:20px;">
								<param name=Alignment			value=0>
								<param name=Border	      value=true>
								<param name=Format	      value="YYYY/MM/DD">
								<param name=PromptChar	  value="_">
								<param name=ReadOnly      value="true">
								<param name=ReadOnlyBackColor   value="#ccffcc">
							</OBJECT>
							</comment><script>__ws__(__NSID__);</script> &nbsp;
							<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_asaqsdat', 'Text')" style="position:relative;width:20px;left:4px;top:1px;cursor:hand;">
						<td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align="left" >&nbsp;&nbsp;&nbsp;계산서번호</td>
				    <td class="tab19" style="width:120px;"><nobr>&nbsp;
							<comment id="__NSID__">
							<OBJECT id=gcem_taxnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:90px;height:20px;position:relative;left:0px;top:2px">		
								<param name=Text					value="">
								<param name=Alignment     value=0>
								<param name=Border        value=true>
								<param name=Numeric       value=false>
								<param name=format        value="#######-####">
								<param name=PromptChar    value="_">
								<param name=ReadOnly      value="true">
								<param name=ReadOnlyBackColor   value="#ccffcc">							
								<param name=InheritColor  value=false>
							</OBJECT>
							</comment><script>__ws__(__NSID__);</script> 
							<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:0px;cursor:hand"	 onclick="ln_Bills_Popup()">
					 </td>
					 <td width="80px"  style="" bgcolor="#eeeeee" class="tab19" align="left">&nbsp;&nbsp;&nbsp;모델명</td>
			     <td class="tab22" style="width:200px;"><nobr>&nbsp;
							<input id="txt_modelnm_1" type="text" class="txtbox"  style= "width:130px;height:20px;position:relative;left:-6px;" MaxLength=30>
 					 </td> 
				</tr>              
<!------------------------------------------>
	     	<tr>
				 
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab23" align="left"><nobr>&nbsp;<font color="#ff0000">*</font>&nbsp;담당자</nobr></td>
					<td class="tab23" style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:0px;padding-left:0px;padding-right:0px;border-bottom-right-left-width:0px"><nobr>&nbsp;
						<input id="txt_empnm" name="txt_empnm"	style="position:relative;left:-5px;top:0px;width:50px;background-color:#ccffcc;" class="txtbox" align=left readOnly> 
						<!-- <img SRC="../../common/img/btn/com_b_find.gif" BORDER="0" ALT="성명을 검색합니다" style="cursor:hand;left:-12px;" align=center  onclick="ln_Popup5('txt_empnm');"> -->
						<input id="txt_empno" name="txt_empno"	type='hidden'	style="width:90px;left:px" class="txtbox" ></nobr>
					</td>	
					<td width="80px" style="" bgcolor="#eeeeee" class="tab23" align="left">&nbsp;<font color="#ff0000">*</font>&nbsp;담당부서</td>
					<td class="tab23" style="width:160px;" ><nobr>&nbsp;
						<input id=txt_cadeptcd_3  type=text   style= "position:relative;top:0px;left:-4px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  onkeydown="ln_Popup0('01');" readOnly>
						<!-- <img name="btn_find" src="../../common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-7px;cursor:hand"	 onclick="ln_Popup0('01')"> -->
  					<input id="txt_cadeptnm_3" type="text" style= "position:relative;top:0px;left:-10px;width:100px; height:20px;background-color:#ccffcc;" class="txtbox"  readOnly>			
  					</nobr>
					</td>
					<td width="80px"  style="" bgcolor="#eeeeee" class="tab23" align="left"><nobr>&nbsp;</nobr></td>
					<!-- <td width="80px"  style="" bgcolor="#eeeeee" class="tab23" align="left"><nobr>&nbsp;회계접수번호</nobr></td> -->
			    <td class="tab23" style="height:30px;border:0 solid #708090;border-right-width:0px;border-left-width:0px;padding-left:0px;padding-right:0px;border-bottom-right-left-width:0px;width:200px;"><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_fsnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:46px;height:20px;position:relative;left:-4px;top:2px">	
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=format        value="######">
							<param name=PromptChar    value="_">
							<param name=PromptChar    value="">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Visible       value="false">
						</OBJECT>
						</comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__">
						<OBJECT id=gcem_atcode classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:54px;height:20px;position:relative;left:0px;top:2px">	
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=format        value="#######">
							<param name=PromptChar    value="_">
							<param name=PromptChar    value="">
							<param name=BackColor     value="#CCCCCC">
							<param name=InheritColor  value=false>
							<param name=Visible       value="false">
 						 </OBJECT>
						 <OBJECT id=gcem_astseq classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:54px;height:20px;position:relative;left:0px;top:2px">	
							<param name=Text					value="">
							<param name=Alignment     value=0>
							<param name=Border        value=true>
							<param name=Numeric       value=false>
							<param name=format        value="#####">
							<param name=Visible       value="false">
 						 </OBJECT>
						 </comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>              
			</table>

      <!-- 텝메뉴 -->
			<table border="0" cellpadding="0" cellspacing="0" style="position:relative;top:18px;left:4px;">	
				<tr>
					<td>	
						<comment id="__NSID__">
						<OBJECT id=gcte_disp classid=clsid:ED382953-E907-11D3-B694-006097AD7252 style="position:absolute;top:90px;left:-4px;width:660px;height:20px">
								<PARAM NAME="BackColor"					VALUE="#cccccc">
								<PARAM NAME="titleHeight"				VALUE="20px">
								<PARAM NAME="DisableBackColor"	VALUE="#eeeeee">
								<PARAM NAME="Format"				  	VALUE="
									<T>divid=layer1  title='기본'</T>									
									<T>divid=layer2  title='부가정보'</T>
									<T>divid=layer3  title='감가상각'</T>
									<T>divid=layer4  title='자산이동'</T>
									<T>divid=layer5  title='자산수리'</T>
									<T>divid=layer6  title='보험'</T>
									<T>divid=layer7  title='임대/임차'</T>
									<T>divid=layer8  title='근저당'</T>
									<T>divid=layer9  title='평가'</T>				
								">
						 </OBJECT>
						 </comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
			</table>			

<!---------[TAB 1] 기본정보 ----------->
<div id="layer1" style="position:absolute;top:226px;">
 <table style="border:0 solid #708090;border-bottom-width:0px;position:absolute;top:-29px;" cellpadding=0 cellspacing=0 width="876">		
	<tr> 	
    <td>
		<table cellpadding=0 cellspacing=0 style='position:relative;left:0px;top:3px;width:876px;height:285px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
     <!-------------------------------------------------------------->
			<tr>
			 <td width="84"  style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;자산구분</td>
       <td width="150" Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" >&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gclx_goddiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="width:120px;height:100;position:relative;top:2px;left:0;" >
						<param name=ComboDataID			value="gcds_bgtgbcd4">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
						<param name=XPStyle         value=true>
					</OBJECT>
					</comment><script>__ws__(__NSID__);</script> 							
				</td>

				<td style="height:25px;width:70px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;취득구분</td>
                <td Style="height:25px;width:120px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gclx_asaqsdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="width:85px;height:200;position:relative;top:1px;left:0;" >
						<param name=ComboDataID			value="gcds_asaqsdiv">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				    value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
						<param name=XPStyle         value=true>
					</OBJECT>
					</comment><script>__ws__(__NSID__);</script> 					
				</td>

				<td width="90" style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;상태구분</td>
				<td width="370" Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gclx_aststat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="width:150px;height:200;position:relative;top:2px;left:0;" >
						<param name=ComboDataID			value="gcds_sys">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=SortColumn      value="CDCODE">
						<param name=Sort				    value="true">
						<param name=ListExprFormat	value="CDNAM^0^150">
						<param name=BindColumn			value="CDCODE">
						<param name=XPStyle         value=true>
					</OBJECT>
					</comment><script>__ws__(__NSID__);</script> 					
				</td>
			</tr>
    	<!-------------------------------------------------------------->
			<tr>	
			  <td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;수량</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" >&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gcem_ASTQTY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:0;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=10>
						<param name=IsComma	      value=true>
					</OBJECT>
					</comment><script>__ws__(__NSID__);</script> 							
				</td>

				<td style="height:25px;width:70px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;내용년수</td>
        <td Style="height:25px;width:120px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" >&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gcem_ASTYUSE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:0;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=5>
						<param name=MaxDecimalPlace   value=2>
						<param name=IsComma	      value=true>
					</OBJECT>
					</comment><script>__ws__(__NSID__);</script> 							
				</td>
				<td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;&nbsp;&nbsp;자산등급</td>
        <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gclx_astclass classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="width:150px;height:100;position:relative;top:1px;left:0;" >
						<param name=ComboDataID			value="gcds_bgtgbcd3">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn	  value="CDNAM">
						<param name=Sort			      value="false">
						<param name=ListExprFormat	value="CDNAM^0^150">
						<param name=BindColumn			value="CDCODE">
						<param name=XPStyle         value=true>
					</OBJECT>
					</comment><script>__ws__(__NSID__);</script> 			
				</td>
			</tr>
      <!-------------------------------------------------------------->
			<tr>					
				<td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;취득금액</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gcem_ASTAQAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:0;" >
						<param name=Text          value=0>
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=13>
						<param name=IsComma	      value=true>
           </OBJECT>
					 </comment><script>__ws__(__NSID__);</script>
				</td>
				<td style="height:25px;width:70px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;외화금액($)</td>
				<td Style="height:25px;width:120px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gcem_ASTAQAMTY classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:85px;height:20;position:relative;top:1px;left:0;" >
						<param name=Text             value=0>
						<param name=Alignment			   value=2>
						<param name=Border	         value=true>
						<param name=Numeric	         value=true>
						<param name=MaxLength        value=6>
						<param name=MaxDecimalPlace  value=4>
						<param name=IsComma	         value=true>
          </OBJECT>
				</comment><script>__ws__(__NSID__);</script> 	
        </td>
				<td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;&nbsp;&nbsp;단위&nbsp;/&nbsp;규격</td>
        <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;						
					<input id="txt_ASTUNIT" type="text" class="txtbox"  style= "width:150px;height:20px;position:relative;left:0px;" MaxLength=10>&nbsp;/&nbsp;	
					<input id="txt_ASTSTD" type="text" class="txtbox"  style= "width:150px;height:20px;position:relative;left:0px;" MaxLength=30>		
				</td>
			</tr>
			<tr>					
				<td width="84"   style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;원가코드</td>
        <td width="340"  Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
					<input id=txt_COSTCD   type=text    style= "position:relative;top:-1px;left:12px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  maxlength=7 onkeydown="ln_Popup_Find2('txt_COSTCD','01');" readOnly>
					<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:9px;cursor:hand"	 onclick="ln_Popup3('01')">
					<input id="txt_COSTNM" type="text"  style= "position:relative;top:-1px;left:5px; width:220px; height:20px;background-color:#ccffcc;" class="txtbox"  readOnly>			
				</td>

				<td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;&nbsp;&nbsp;매출원가구분</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					 <comment id="__NSID__">
					 <OBJECT id=gclx_ascosdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="width:150px;height:200;position:relative;top:1px;left:0;" >
							<param name=ComboDataID			value="gcds_sys2">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^150">
							<param name=BindColumn			value="CDCODE">
							<param name=XPStyle         value=true>
						</OBJECT>
						</comment><script>__ws__(__NSID__);</script> 						
				</td>
			</tr>			
			<tr>
			 <td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;사용부서</td>
       <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>&nbsp;
					<input id=txt_usedpt  type=text   class="txtbox"  style="position:relative;top:-1px;left:0px;width:50px; height:20px;background-color:#ccffcc;"  onkeydown="ln_Popup0('02');" readOnly >
					<img   name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-3px;cursor:hand"	 onclick="ln_Popup0('02')">
					<input id="txt_usedptnm" type="text" class="txtbox"  style="position:relative;top:-1px;left:-6px;width:220px; height:20px;background-color:#ccffcc;"  readOnly >			
			 </td>
			 <td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;사용자</td>
        <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<comment id="__NSID__">
          <OBJECT id=gcem_astuser classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:5px;left:0px;width:50px;height:20px;">
						<param name=Alignment	 value=0>
						<param name=Border	   value=true>
						<param name=PromptChar value="_">
						<param name=Format		 value="#######">
						<param name=ReadOnly 	 value=true >
            <param name=ReadOnlyBackColor   value="#ccffcc">
					</OBJECT>
					</comment><script>__ws__(__NSID__);</script> 				
          <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="성명을 검색합니다" style="cursor:hand;position:relative;left:2px;" align=center onclick="ln_Popup5('txt_astusernm');">
          <input id="txt_astusernm" name="txt_astusernm"	type='text'	style="position:relative;top:0px;width:90px;background-color:#ccffcc;" class="txtbox" readOnly >
        </td>
			 				
			</tr>
			<tr>					
       <td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;관리부서</td>
       <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>&nbsp;
					<input id=txt_mngdpt  type=text  style="position:relative;top:-1px;left:0px;width:50px; height:20px;background-color:#ccffcc;"   class="txtbox"  maxlength=7; onkeydown="ln_Popup0('txt_mngdpt','txt_mngdptnm');" readOnly>
					<img name="btn_find"      style="position:relative;top:3px;left:-3px;cursor:hand"	  src="../../Common/img/btn/com_b_find.gif"	 onclick="ln_Popup0('03')">
					<input id="txt_mngdptnm" type=text  style="position:relative;top:-1px;left:-6px;width:220px; height:20px;background-color:#ccffcc;" class="txtbox"  maxlength="36"  readOnly>		
				</td>
			 <td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;&nbsp;&nbsp;구입처</td>
       <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
				<input id=txt_buyfrom  type=text   style= "position:relative;top:2px;left:12px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  maxlength=7; onkeydown="ln_Popup_Find('txt_buyfrom','02');" readOnly>
 			  <img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:9px;top:0px" align=center onclick="ln_Popup4('01');">
				<input id="txt_vend_nm" type="text" style= "position:relative;top:2px;left:6px;width:220px; height:20px;background-color:#ccffcc;" class="txtbox"  maxlength="36"  readOnly>	
			 </td>
		 </tr>
		 <tr>					
			<td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;&nbsp;&nbsp;제작처</td>
             <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>&nbsp;
				<input id=txt_MAKER  type=text    style= "position:relative;top:-1px;left:0px;width:50px; height:20px;background-color:#ccffcc;"  class="txtbox"  maxlength=7;  readOnly>
				<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-3px;cursor:hand"	 onclick="ln_Popup9()">
				<input id="txt_MAKENM" type="text"  style= "position:relative;top:-1px;left:-6px;width:220px; height:20px;background-color:#ccffcc;"class="txtbox"  maxlength="36"  readOnly>			
			</td>
			<td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;등록구분</td>
			<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
				<comment id="__NSID__">
				<OBJECT id=gclx_regigb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="width:85px;height:200;position:relative;top:2px;left:0;" >
					<param name=CBData    			value="1^최초등록,2^이체등록">
					<param name=CBDataColumns		value="CDCODE,CDNAM">
					<param name=SearchColumn		value="CDNAM">
					<param name=Sort				    value="false">
					<param name=ListExprFormat	value="CDNAM^0^85">
					<param name=BindColumn			value="CDCODE">
					<param name=XPStyle         value=true>
				</OBJECT>	
				</comment><script>__ws__(__NSID__);</script> 		
				

        	   <span id=sp0>
					<FONT style="position:relative;top:-2px;" class="txtbox" >&nbsp;<font color="#ff0000">*</font>&nbsp;최초자산번호</FONT>
					<comment id="__NSID__">
					<OBJECT id=gcem_s_astnbr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:55px;height:20px;position:relative;left:0px;top:2px">	
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="########">
						<param name=PromptChar  value="_">
						<param name=UpperFlag   value=1>
					</OBJECT>          
					</comment><script>__ws__(__NSID__);</script>	
					
					<FONT style="position:relative;top:-2px;left:3px;" class="txtbox" ><font color="#ff0000">*</font>이체일</FONT>
					<comment id="__NSID__">
					<OBJECT id=gcem_mordt classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:65px;height:20px;position:relative;left:3px;top:2px">	
						<param name=Text				value="">
						<param name=Alignment		value=0>
						<param name=Border			value=true>
						<param name=Format			value="YYYY/MM/DD">
						<param name=PromptChar  value="_">
						<param name=UpperFlag    value=1>
					</OBJECT>&nbsp;&nbsp;             
					</comment><script>__ws__(__NSID__);</script>	
				</span>

			</td>
		 </tr>
		 <tr>					
				<td style="height:25px; border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:0px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;&nbsp;&nbsp;관리구분</td>
				<td Style="height:25px; border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gclx_mngtype classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="width:120px;height:200;position:relative;top:2px;left:0;" >
						<param name=ComboDataID			value="gcds_bgtgbcd">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				    value="false">
						<param name=ListExprFormat	value="CDNAM^0^120">
						<param name=BindColumn			value="CDCODE">
						<param name=XPStyle         value=true>
					</OBJECT>
					</comment><script>__ws__(__NSID__);</script> 
				</td>
				<td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;<font color="#ff0000">*</font>&nbsp;상각처리구분</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gclx_deprgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="width:85px;height:200;position:relative;top:2px;left:0;" >
						<param name=CBData    			value="1^상각처리,2^상각미처리">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				    value="false">
						<param name=ListExprFormat	value="CDNAM^0^85">
						<param name=BindColumn			value="CDCODE">
						<param name=XPStyle         value=true>
					</OBJECT>	
					</comment><script>__ws__(__NSID__);</script> 						
				</td>			
		 </tr>
		 <tr>					
				<td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;&nbsp;&nbsp;리스유무</td>
        <td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan="3">&nbsp;
					<comment id="__NSID__">
						<OBJECT id=gclx_astris classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="width:120px;height:120;position:relative;top:1px;left:0;" >
							<param name=ComboDataID			value="gcds_bgtgbcd2">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				    value="false">
							<param name=ListExprFormat	value="CDNAM^0^120">
							<param name=BindColumn			value="CDCODE">
							<param name=XPStyle         value=true>
						</OBJECT>
						</comment><script>__ws__(__NSID__);</script> 				
				</td>
				<td style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align="left" class="txtbox">&nbsp;&nbsp;&nbsp;설치장소</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<input id="txt_USELOC" type="text" class="txtbox"  style= "width:315px;height:20px;position:relative;left:0px;"MaxLength=30>			
				</td>		
 		 </tr>
		 <tr> 
				<td style="border:0 solid #708090;border-left-width:0px;border-right-width:1px;border-top-width:0px;border-bottom-width:0px;text-align;height:30px;font-family:굴림;font-size:9pt; " bgcolor="#eeeeee" class="tab19" align="left">&nbsp;&nbsp;&nbsp;비고</td>
				<td colspan=5 class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:0px;text-align;height:30px;font-family:굴림;font-size:9pt; " ><nobr>&nbsp;
					<textarea id="txt_ASTNOTE" class="txtbox"  style= "width:760px; height:40px; overflow:auto;position:relative;left:5px" maxlength="50" onBlur="bytelength(this,this.value,50);"></textarea>
				</td>
		 </tr>
		 </table>
		</td>
	</tr>
	<tr>
		<td height=90px>
			<font color="#ff0000">*</font> 표시는 필수 입력 항목입니다.
				<BR>&nbsp;&nbsp;분할 저장시 수량, 취득금액은 1건의 수량, 금액을 입력합니다.
				<BR>&nbsp;&nbsp;건물,구축물에 대한 내용연수는 확인 후 저장하십시요.
				<BR>&nbsp;&nbsp;자산번호 및 대표자산번호는 저장 시점에서 자동 생성됩니다.
				<BR>&nbsp;&nbsp;이체등록시 최초자산번호는 입력해야 합니다.
		</td>
  </tr>
</table>
</div>
<!---------[TAB 2] 부가정보----------->
<div id="layer2" style="position:absolute;top:226px;">  
<!------------TAB2-------부가정보-----1.---토지/건물/구축물------------------------------------------------------>
<div id=layer2_1 style="display:none">
<table style="border:0 solid #708090;border-bottom-width:0px;position:absolute;top:-1px;" cellpadding=0 cellspacing=0 border=0  width="876">		
	<tr> 			
	<td>
		<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:-25px;width:876px;height:200px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>	
		<!-------------------------------------------------------------->
			<tr>
				<td style="height:25px;width:86px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;우편번호&nbsp;</td>		
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gcem_ASTPOST classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative; left:0px;top:2px; width:50px; height:20px; font-family:굴림; font-size:9pt;z-index:2; " class=txtbox>
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="000-000">
						<param name=PromptChar	  value="_">
						<param name=ReadOnly      value="true">
						<param name=ReadOnlyBackColor   value="#ccffcc">	
					</OBJECT>
					</comment><script>__ws__(__NSID__);</script> 
					<img alt=우편번호조회  id='img_search1' name='img_search1' style="position:relative;left:7px;top:2px;cursor:hand" src='../../Common/img/btn/com_b_search.gif'  onclick="ln_Popup2('c')">&nbsp;&nbsp;
   				<input type="text" id=txt_ASTSOJE class="txt11"  style="width:400px;position:relative;left:0px;top:-3px;" MaxLength=30>
				</td> 
			</tr>
		<!---------------------------------------------------------->
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;구조&nbsp;</td>	
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<input type="text" id=txt_ASTCON class="txt11" style="width:100px;position:relative; left:0px" MaxLength=20>						
				</td>
			</tr>	
		<!------------------------------------------------->
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;용도(지목)&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
					<input type="text" id=txt_ASTUSE class="txt11" style="width:100px;position:relative; left:0px" MaxLength=30>	
				</td>
			</tr>
		<!------------------------------------------------------------>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;면적&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gcem_ASTSIZE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:0;"  onKeydown="if(event.keyCode==13) ln_search()">
						<param name=Text          value="">
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=20>
						<param name=IsComma	      value=true>
					</OBJECT></comment><script>__ws__(__NSID__);</script> 							
				</td>
			</tr>
		<!----------------------------------------------------------->
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;평수&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gcem_ASTPYUNG  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:0;"  >
						<param name=Text          value="">
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=VisibleMaxDecimal   value="true">
						<PARAM NAME="MaxDecimalPlace" VALUE=1>
						<param name=MaxLength     value=20>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 		
				</nobr>
				</td>
			</tr>			
		<!----------------------------------------------------------->
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;등기일&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_ASTREGYMD classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 		style="position:relative;top:2px;left:0px;width:80px;height:20px;">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	   value="_">
					</OBJECT></comment><script>__ws__(__NSID__);</script> 
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_ASTREGYMD', 'Text')" style="position:relative;width:20px;left:0px;top:1px;cursor:hand;">					
					</nobr>
				</td>
			</tr>	
		<!----------------------------------------------------------->
  		<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;등기번호&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px"><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_ASTREGNO  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:0;"  >
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="##########">
						<param name=PromptChar	  value="_">
						<param name=MaxLength     value=10>
					</OBJECT></comment><script>__ws__(__NSID__);</script> 		
					</nobr>
				</td>
			</tr>			
	</table>
 </td>
 </tr>		
</table>
</div><!---------[TAB 2_1] --------->

<!-------------TAB2------------부가정보-----2.---차량운반구인경우----------------------------------------->
<div id=layer2_2 style="display:none">
</div><!---------[TAB 2_2] --------->
<!-------------TAB2------------부가정보-------------------------------------------------------->
<div id=layer2_3 style="display:none">
</div><!---------[TAB 2_3] --------->
<!------------///////////////////////부가정보22222222/////////////////////////////////////////----------------------------------->
<!-------------TAB2------------부가정보-----2.---차량운반구인경우----------------------------------------->
<div id=layer2_4 style="display:block">

<table style="border:0 solid #708090;border-bottom-width:0px;position:absolute;top:-1px;" cellpadding=0 cellspacing=0 border=0  width="876">	
	<tr> 			
	<td>
		<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:-25px;width:876px;height:210px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>			
			<tr>
				<td style="height:25px;width:86px; border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;차종&nbsp;</td>		
				<td class="tab18"  Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;">
					<input id="txt_ACARTYPE" type="text" class="txtbox"  style= "width:170px;height:20px;position:relative;left:8px;" MaxLength=30>
				</td> 
			</tr>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;차량번호&nbsp;</td>		
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" MaxLength=20>
					<input type="text" class="txt11" id="txt_ACARNO" style="width:170px;height:20px;" maxlength="10">
				</td> 
			</tr>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;차대번호&nbsp;</td>		
				<td class="tab18"  Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;">
					<input id="txt_ACARDRVID" type="text" class="txtbox"  style= "width:170px;height:20px;position:relative;left:8px;" MaxLength=25>
				</td> 
			</tr>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;배기량&nbsp;</td>	
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
					<input id="txt_ACARBEGI" type="text" class="txtbox"  style= "width:170px;height:20px;position:relative;left:8px;"MaxLength=10>
				</td>
			</tr>	
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;연료&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
					<input id="txt_ACARFUEL" type="text" class="txtbox"  style= "width:170px;height:20px;position:relative;left:8px;" MaxLength=10>
				</td>
			</tr>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;용도&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
					<input id="txt_ACARUSE" type="text" class="txtbox"  style= "width:170px;height:20px;position:relative;left:8px;" MaxLength=20>
				</td>
			</tr>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;검사기간&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gcem_ACARINSDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:170px;height:20;position:relative;top:1px;left:-3px;"  >
					<param name=Text          value="">
					<param name=Alignment	    value=1>
					<param name=Border	      value=true>
					<param name=Numeric	      value=false>
          <param name=format	      value="########~########">
					<param name=MaxLength     value=20>
				</OBJECT></comment><script>__ws__(__NSID__);</script> 		
				</nobr>
				</td>
			</tr>			
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;종합보험기간&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px"><nobr>&nbsp;
				<comment id="__NSID__"><OBJECT id=gcem_AINSDT2  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:170px;height:20;position:relative;top:1px;left:-3px;"  >
					<param name=Text          value="">
					<param name=Alignment	   value=2>
					<param name=Border	      value=true>
					<param name=Numeric	      value=false>
					<param name=MaxLength     value=20>
					</OBJECT></comment><script>__ws__(__NSID__);</script> 		
				</nobr>
				</td>
			 </tr>						
		</table>
	 </td>
	</tr>	
</table>
</div><!---------[TAB 2_4] --------->

<!--//////////////////////////////////////////////////////////////////////////////////-->
<!-------------TAB2------------부가정보-----5.---기계장치인경우------------------------------------------------------>
<div id=layer2_5 style="display:none">
<table style="border:0 solid #708090;border-bottom-width:0px;position:absolute;top:-1px;" cellpadding=0 cellspacing=0 border=0  width="876">	
	<tr > 			
	<td>
		<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:-25px;width:876px;height:150px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>			
			<tr>
				<td style="height:25px;width:86px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;모델(규격)&nbsp;</td>		
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
					<input id="txt_AMMODEL" type="text" class="txtbox"  style= "width:120px;height:20px;position:relative;left:6px;" MaxLength=20>		</td> 
			</tr>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;제작일&nbsp;</td>		
				<td class="tab18"  Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;">
					<comment id="__NSID__"><OBJECT id=gcem_AMAKEDATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:80px;height:20px;">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
					<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_AMAKEDATE', 'Text')" style="position:relative;width:20px;left:4px;top:1px;cursor:hand;">
				</td> 
			</tr>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;포함규격&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
					<input id="txt_ASUBSTD" type="text" class="txtbox"  style= "width:120px;height:20px;position:relative;left:6px;" MaxLength=7>
				</td>
			</tr>			
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;제작번호&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_AMAKENO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:-6;"  >
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="####################">
						<param name=MaxLength     value=20>
						<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 					
				</td>
			</tr>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;형식&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
					<input id="txt_AMFORM" type="text" class="txtbox"  style= "width:120px;height:20px;position:relative;left:6px;" MaxLength=30>
				</td>
			</tr>			
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;주유유종&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px">	
					<input id="txt_AMOIL" type="text" class="txtbox"  style= "width:120px;height:20px;position:relative;left:6px;"MaxLength=16>
				</td>
			</tr>	
		</table>
	</td>
</tr>	
</table>
</div><!---------[TAB 2_5] --------->

<!-------------TAB2------------부가정보-----6.------------------------------------------------------->
<div id=layer2_6 style="display:none">
</div><!---------[TAB 2_6] --------->

</div>  <!--tba2 -----부가정보 1div끝-->

<!---------[TAB 3] 감가상각----------->
<div id="layer3" style="position:absolute;top:226px;">
<table style="border:0 solid #708090;border-bottom-width:0px;position:absolute; top:-29px;"  cellpadding=0 cellspacing=0 border=0  width="876">		
	<tr>
		<td>
			<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:3px;width:876px;height:270px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>		
				<tr>		
					<td width=120 style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=left class="txtbox">&nbsp;&nbsp;&nbsp;감가상각완료구분</td>
          <td width=256 Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gclx_ASTDEPRST classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=20 width=120 style="position:relative;left:1px;top:3px" class="txtbox" >
							<param name=ComboDataID			value="gcds_ASTDEPRST">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^120">
							<param name=BindColumn			value="CDCODE">
							<param name=Enable          value="false">
						</OBJECT></comment><script>__ws__(__NSID__);</script>
					</td>
          <td align="right" class="tab22" width="500px"><nobr>&nbsp;
						<!-- 임의로 막음. 
						<img id="btn_Delete039"   src="../../common/img/btn/com_b_delete.gif"   onclick="ln_Delete('03')">
						<img id="btn_Insert039"   src="../../common/img/btn/com_b_insert.gif"	  onClick="ln_Insert('03')">
						<img id="btn_save039"     src="../../common/img/btn/com_b_save.gif" 	  onclick="ln_Save('03')"> -->
						</nobr>
					</td>	
				</tr>
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=left class="txtbox">&nbsp;&nbsp;&nbsp;내용년수</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=2><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_ASTYUSE2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:1;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>							
							<param name=MaxLength     value=5>
							<param name=MaxDecimalPlace   value=2>
							<param name=IsComma	      value=true>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
						</nobr>
					</td>
				</tr>			
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=left class="txtbox">&nbsp;&nbsp;&nbsp;취득금액</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=2>&nbsp;
					<comment id="__NSID__">
					<OBJECT id=gcem_ASTAQAMT2 classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:0;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 						
					</td>
				</tr>
				<tr>
					<td  style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=left class="txtbox">&nbsp;&nbsp;&nbsp;전기상각누계액</td>
					<td  Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=2>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_ABDEPRAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:0;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 				
					</td>
				</tr>
				<tr>
					<td  style="height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=left class="txtbox">&nbsp;&nbsp;&nbsp;전기장부가액</td>
					<td  Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=2>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_ABBOOKAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:0;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 					
					</td>
				</tr>
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=left class="txtbox">&nbsp;&nbsp;&nbsp;당기상각비</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=2><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_ACDEPRAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:0;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
					 </nobr>
				  </td>
			  </tr>			
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=left class="txtbox">&nbsp;&nbsp;&nbsp;장부가액(잔존가액)</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=2><nobr>&nbsp;
					<comment id="__NSID__"><OBJECT id=gcem_ASTRMAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:1;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
						</nobr>
					</td>
				</tr>	
        <tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=left class="txtbox">&nbsp;&nbsp;&nbsp;감가상각완료일</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=2>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_DEPRENDDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:0px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
				</tr>
        <tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=left class="txtbox">&nbsp;&nbsp;&nbsp;전기감소누계액</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" colspan=2>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_ABDECAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:0;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
							<param name=ReadOnly      value="true">
							<param name=ReadOnlyBackColor   value="#ccffcc">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 					
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</div><!---------[TAB 3] --------->

<!----//////////////////////////////////////////////////////////////////////-------->
<!---------[TAB 4] 고정자산이동----------->

<div id="layer4" style="position:absolute;top:226px;">
 <table style="border:0 solid #708090;border-bottom-width:0px;position:absolute;top:-26px;" cellpadding=0 cellspacing=0 border=0  width="876">		
	<tr>
   <td>
		<comment id="__NSID__">
		<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code12 style="position:relative;left:0px;width:600px; height:300px; border:1 solid #708090;">
			<PARAM NAME="DataID"			VALUE="gcds_code12">
			<PARAM NAME="BorderStyle" VALUE="0">
			<PARAM NAME="Indwidth"		VALUE="0">
			<PARAM NAME="Fillarea"		VALUE="true">
			<PARAM NAME="sortview"		VALUE="left">
			<PARAM NAME="ColSizing"		VALUE="true">
			<Param Name="Editable"    VALUE="false"> 
			<PARAM NAME="Format"			VALUE=" 
				<C> Name='이동일'	      ID=MOVDATE	 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=70	 align=center Sort=true  Mask=XXXX-XX-XX  </C> 
				<C> Name='사용부서'    	ID=AUSEDEPTNM   HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left   Sort=true  Edit=none </C> 
				<C> Name='관리부서'     ID=AMNGDEPTNM  	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=left  	Sort=true  Edit=none </C> 
				<C> Name='원가명'	      ID=ACOSTNM	   	HeadAlign=Center HeadBgColor=#B9D4DC Width=170 align=left   Sort=true</C>		
				<C> Name='이동내역'	    ID=MOVNOTE	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=140 align=left   Sort=true</C>	
				<C> Name='이동이력순번'	ID=ASTMOVNO	  	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	 align=left 	show=false</C>
			">
		</OBJECT></comment><script>__ws__(__NSID__);</script> 
	</td> 
	<td>
	<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:0px;width:270px;height:302px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>			
<!---------------------------------------------------->
	<tr>
		<td  width="200" style="border:0 solid ;border-right-width:0px;border-bottom-width:1px" bgcolor="" align= class="" colspan=2 height="30">
			<table id="div_dbtn" width="200px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:30px">
				<tr>
					<td align="right"><nobr>
						<img id="btn_Delete08" src="../../Common/img/btn/com_b_delete.gif"    style="position:relative;left:72px;top:0px;cursor:hand;display:block" onclick="ln_Delete('08')"></td>
					<td align="right">
						<img id="btn_Insert08" src="../../Common/img/btn/com_b_insert.gif"	 style="position:relative;left:52px;top:0px;cursor:hand;display:block" onClick="ln_Insert('08')"></td>
					<td align="right">	
						<img id="btn_off_save08" src="../../Common/img/btn/com_off_save.gif"	 style="position:relative;left:30px;top:0px;cursor:hand;display:none" ></td>
					<td align="right">	
						<img id="btn_save08" src="../../Common/img/btn/com_b_save.gif" 	 style="position:relative;left:30px;top:0px;cursor:hand;display:block" onclick="ln_Save_Rest('08')"></nobr></td>
				 </tr>
			</table>	
		</td>								
	</tr>
	<tr>
		<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;이동일&nbsp;</td>		
		<td class="tab18"  Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;">
			<comment id="__NSID__"><OBJECT id=gcem_MOVDATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:6px;width:70px;height:20px;">
			<param name=Alignment	    value=0>
			<param name=Border	      value=true>
			<param name=Format	      value="YYYY/MM/DD">
			<param name=PromptChar	  value="_">
			</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
			<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_MOVDATE', 'Text')" style="position:relative;width:20px;left:px;top:1px;cursor:hand;">
		</td> 
	</tr>
	<tr>
		<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" rowspan=2 >&nbsp;사용부서&nbsp;</td>
		<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
			<input id="txt_ausedept"   type=text   class="txtbox"  style="position:relative;top:-1px;left:6px;width:50px; height:20px;background-color:#ccffcc;"  onkeydown="ln_Popup0('04');" readOnly >
			<img   name="btn_find"     src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:-3px;cursor:hand"	 onclick="ln_Popup0('04')">
    </td>
  </tr>
	<tr>
		<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
			<input id="txt_ausedeptnm" type="text" class="txtbox"  style="position:relative;top:-1px;left:6px;width:180px; height:20px;background-color:#ccffcc;"  readOnly >			
		</td>
	</tr>

		<!-- <td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
			<comment id="__NSID__"><OBJECT id=gclx_ausedept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=140 style="position:relative;left:6px;top:3px" class="txtbox" >
			<param name=ComboDataID			value="gcds_dept6">
			<param name=CBDataColumns		value="DEPTCD,DEPTNM">
			<param name=SearchColumn		value="DEPTNM">
			<param name=Sort				    value=false>
			<param name=ListExprFormat	value="DEPTNM^0^140">
			<param name=BindColumn			value="DEPTCD">
			</OBJECT></comment><script>__ws__(__NSID__);</script> 							
		</td> -->

	
	<tr>
		<td style="width:74px;height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox" rowspan=2>&nbsp;관리부서&nbsp;</td>
		<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
			<input id="txt_amngdept"   type=text   class="txtbox"  style="position:relative;top:-1px;left:6px;width:50px; height:20px;background-color:#ccffcc;"  onkeydown="ln_Popup0('05');" readOnly>
			<img   name="btn_find"     src="../../Common/img/btn/com_b_find.gif"    style="position:relative;top:3px;left:-3px;cursor:hand"	 onclick="ln_Popup0('05')">		
    </td>
	</tr>	
	<tr>
		<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
			<input id="txt_amngdeptnm"  type=text   class="txtbox"  style="position:relative;top:-1px;left:6px;width:180px; height:20px;background-color:#ccffcc;"   readOnly>		
		</td>
	</tr>

		<!-- <td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
			<comment id="__NSID__"><OBJECT id=gclx_amngdept classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=140 style="position:relative;left:6px;top:3px" class="txtbox" >
				<param name=ComboDataID			value="gcds_dept5">
				<param name=CBDataColumns		value="DEPTCD,DEPTNM">
				<param name=SearchColumn		value="DEPTNM">
				<param name=Sort				value=false>
				<param name=ListExprFormat	   value="DEPTNM^0^140">
				<param name=BindColumn			value="DEPTCD">
				</OBJECT></comment><script>__ws__(__NSID__);</script> 	
		</td> -->

	
	<tr>
		<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox" rowspan=2>&nbsp;원가코드&nbsp;</td>
		<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
			<input type=text  id=txt_ACOSTCD style= "position:relative;top:-1px;left:6px;width:50px;height:20px;background-color:#ccffcc;"  class="txtbox"  maxlength=7; onkeydown="ln_Popup_Find2('txt_ACOSTCD','02');">
			<img name="btn_find" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:3px;left:3px;cursor:hand;"	 onclick="ln_Popup3('02')"  >
		</td>
	</tr>
	<tr>
		<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
			<input id="txt_ACOSTNM" type="text" class="txtbox"  style= "width:180px;height:20px;position:relative;left:6px;top:-1px;background-color:#ccffcc;" readOnly>	
		</td>
	</tr>
	<tr>
		<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;이동내역&nbsp;</td>
		<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
			<input id="txt_MYPLAN" type="text" class="txtbox"  style= "width:180px;height:20px;position:relative;left:6px;"MaxLength=30>	
		</td>
	</tr>			
	<tr>
		<td colspan=6 style="height:100%;border:0 solid #708090;">&nbsp;</td>
	</tr>
	</table>
</td>
</tr>
<tr>
	<td>
		&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>
  </td>					
</tr>	
</table>
</div><!---------[TAB 4] --------->

<!---------[TAB 5] 고정자산수리----------->
<div id="layer5" style="position:absolute;top:226px;">
<table style="border:0 solid #708090;border-bottom-width:0px;position:absolute;  top:-26px;"  cellpadding=0 cellspacing=0 border=0  width="876">		
	<tr > 			
		<td >		
			<comment id="__NSID__">
			<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code05  style="position:relative;left:0px;width:600px; height:300px; border:1 solid #708090;">
			<PARAM NAME="DataID"			VALUE="gcds_code05">	
			<PARAM NAME="BorderStyle" VALUE="0">
			<PARAM NAME="Indwidth"		VALUE="0">
			<PARAM NAME="Fillarea"		VALUE="true">
			<PARAM NAME="sortview"		VALUE="left">
			<Param Name="Editable"    VALUE="false"> 
			<PARAM NAME="Format"			VALUE=" 						
				<C> Name='수리일'			  ID=REPAIRDATE	HeadAlign=Center HeadBgColor=#B9D4DC Width=70	  align=center	Mask=XXXX-XX-XX Sort=true</C> 
				<C> Name='수리처'		    ID=REPAIRPART HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=left    EditStyle=Lookup Data='gcds_vend_cd:vend_cd:vend_nm'  Sort=true</C>
				<C> Name='불량내용'	    ID=DEFECTNOTE HeadAlign=Center HeadBgColor=#B9D4DC Width=390	align=left    Sort=true </C> 
				<C> Name='자산수리순번'	ID=REPAIRNO	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center	show=false</C>
			">  
			</OBJECT></comment><script>__ws__(__NSID__);</script> 
		</td>
    <td>
			<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:0px;width:270px;height:300px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>		
				<tr>
					<td  width="200" style="border:0 solid ;border-right-width:0px;border-bottom-width:1px" bgcolor="" align= class="" colspan=2 height="30">
						<table id="div_dbtn" width="200px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:30px">
							<tr>
								<td align="right"><nobr>
									<img id="btn_Delete03" src="../../Common/img/btn/com_b_delete.gif"    style="position:relative;left:72px;top:0px;cursor:hand;display:block" onclick="ln_Delete('03')"></td>
								<td align="right">
									<img id="btn_Insert03" src="../../Common/img/btn/com_b_insert.gif"	 style="position:relative;left:52px;top:0px;cursor:hand;display:block" onClick="ln_Insert('03')"></td>
								<td align="right">	
									<img id="btn_off_save03" src="../../Common/img/btn/com_off_save.gif"	 style="position:relative;left:30px;top:0px;cursor:hand;display:none" ></td>
								<td align="right">	
									<img id="btn_save03" src="../../Common/img/btn/com_b_save.gif" 	 style="position:relative;left:30px;top:0px;cursor:hand;display:block" onclick="ln_Save_Rest('03')"></nobr></td>
							</tr>
						</table>			
					</td>								
				</tr>
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;수리일&nbsp;</td>		
					<td class="tab18"  Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;">
						<comment id="__NSID__">
						<OBJECT id=gcem_REPAIRDATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:6px;width:70px;height:20px;">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_REPAIRDATE', 'Text')" style="position:relative;width:20px;left:px;top:1px;cursor:hand;">
					</td> 
				</tr>
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;수리처&nbsp;</td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
						<input type=text   id=txt_REPAIRPART style= "position:relative;top:3px;left:6px;width:50px; height:20px;"  class="txtbox"  maxlength=7; onKeydown="if(event.keyCode==13) ln_Popup_Find('txt_REPAIRPART','01');">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:1px" align=center onclick="ln_Popup4('02');">
						<input id="txt_vend_cd2" type="text" class="txtbox"  style= "position:relative;top:3px;width:100px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>
					</td>
				</tr>	
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;불량내용&nbsp;</td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
						<input id="txt_DEFECTNOTE" type="text" class="txtbox"  style= "width:196px;height:20px;position:relative;left:-6px;" MaxLength=30>
					</td>
				</tr>
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;수리금액&nbsp;</td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;<comment id="__NSID__"><OBJECT id=gcem_REPAIRAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:0;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;border-bottom-width:1px" bgcolor="" align=center class="txtbox"></td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
					</td>
				</tr>
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-left-width:1px;border-bottom-width:1px" bgcolor="" align=center class="txtbox"></td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">						
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr>
		<td>
			&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>
		</td>					
	</tr>	
</table>
</div><!---------[TAB 5] --------->

<!---------[TAB 6] 보험----------->
<div id="layer6" style="position:absolute;top:226px;">
<table style="border:0 solid #708090;border-bottom-width:0px;position:absolute; top:-26px;" cellpadding=0 cellspacing=0 border=0  width="876">		
	<tr> 			
		<td>
			<comment id="__NSID__">
			<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code06 style="position:relative;left:0px;width:560px; height:321px; border:1 solid #708090;">
				<PARAM NAME="DataID"			 VALUE="gcds_code06">
				<PARAM NAME="IndWidth"		 VALUE ='0'>
				<PARAM NAME="BorderStyle"  VALUE="0">
				<PARAM NAME="Fillarea"		 VALUE="true">
				<PARAM NAME="Sortview"		 VALUE="left">
				<PARAM NAME="Format"			 VALUE="  
				<C> Name='보험일'		    ID=INSUREDATE	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center	Mask=XXXX-XX-XX Sort=true</C> 
				<C> Name='보험번호'		  ID=INSHEETNO   HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center  Sort=true   </C> 
				<C> Name='계약기간'		  ID=INSTERM	 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=70	align=center	Sort=true</C> 
				<C> Name='금액'		      ID=INSAMT   	 HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=right   Sort=true </C> 
				<C> Name='보험금액'	    ID=INSEDAMT	 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=100	align=right   Sort=true</C>	
				<C> Name='보험회사'	    ID=INSFIRM	 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=left  	EditStyle=Lookup Data='gcds_vend_cd:vend_cd:vend_nm'  Sort=true</C>
				<C> Name='자산수리순번'	ID=INSURENO	 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	show=false</C>
			">
			</OBJECT></comment><script>__ws__(__NSID__);</script> 
		</td>
		<td>
			<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:0px;width:310px;height:270px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>			
				<tr>
					<td  width="200" style="border:0 solid ;border-right-width:0px;border-bottom-width:1px" bgcolor="" align= class="" colspan=2 height="30">
						<table id="div_dbtn" width="200px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:70px">
							<tr>
								<td align="right"><nobr>
									<img id="btn_Delete04" src="../../Common/img/btn/com_b_delete.gif"    style="position:relative;left:72px;top:0px;cursor:hand;display:block" onclick="ln_Delete('04')"></td>
								<td align="right">
									<img id="btn_Insert04" src="../../Common/img/btn/com_b_insert.gif"	 style="position:relative;left:52px;top:0px;cursor:hand;display:block" onClick="ln_Insert('04')"></td>
								<td align="right">	
									<img id="btn_off_save04" src="../../Common/img/btn/com_off_save.gif"	 style="position:relative;left:30px;top:0px;cursor:hand;display:none" ></td>
								<td align="right">	
									<img id="btn_save04" src="../../Common/img/btn/com_b_save.gif" 	 style="position:relative;left:30px;top:0px;cursor:hand;display:block" onclick="ln_Save_Rest('04')"></nobr></td>
							</tr>
						</table>
					</td>								
				</tr>
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;보험일&nbsp;</td>		
					<td class="tab18"  Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;">
						<comment id="__NSID__">
						<OBJECT id=gcem_INSUREDATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:6px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_INSUREDATE', 'Text')" style="position:relative;width:20px;left:px;top:1px;cursor:hand;">
					</td> 
				</tr>
				<tr>
						<td style="width:74px;height:25px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;보험번호&nbsp;</td>
						<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
							<comment id="__NSID__">
							<OBJECT id=gcem_INSHEETNO classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;" >
								<param name=Text				value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="####################">
	              <param name=MaxLength   value=20>
								<param name=PromptChar	value="_">						
							</OBJECT></comment><script>__ws__(__NSID__);</script> 
						</td>
				</tr>	
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;시작일&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
						<comment id="__NSID__">
						<OBJECT id=gcem_INSSTARTDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 	style="position:relative;top:2px;left:6px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_INSSTARTDT', 'Text')" style="position:relative;width:20px;left:px;top:1px;cursor:hand;">
					</td>
				</tr>
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;만료일&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
						<comment id="__NSID__">
						<OBJECT id=gcem_INSENDDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:6px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_INSENDDT', 'Text')" style="position:relative;width:20px;left:px;top:1px;cursor:hand;">		
					</td>
				</tr>
<!----------------------------------------------------------->
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;계약기간&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_INSTERM  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>		
								<param name=MaxLength     value=20>
								<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</nobr>
					</td>
				</tr>			
<!----------------------------------------------------------->
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;금액&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_INSAMT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</nobr>
					</td>
				</tr>			
<!----------------------------------------------------------->
				<tr>
					<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;보험금액&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;<comment id="__NSID__"><OBJECT id=gcem_INSEDAMT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:0;"  >
								<param name=Text          value="">
								<param name=Alignment	    value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=Format	      value="000,000,000">
								<param name=MaxLength     value=13>
								<param name=IsComma	      value=true>
								</OBJECT></comment><script>__ws__(__NSID__);</script> 		
					</nobr>
				</td>
			</tr>		
<!----------------------------------------------------------->
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;보험회사&nbsp;</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
					<input type=text   id=txt_INSFIRM style= "position:relative;top:2px;left:6px;width:50px; height:20px;"  class="txtbox"  maxlength=7; onkeydown="ln_Popup_Find('txt_INSFIRM','03');">
					<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('03');">
					<input id="txt_vend_cd3" type="text" class="txtbox"  style= "position:relative;top:2px;width:125px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>
					</nobr>
				</td>
			</tr>	
      <tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">비고</nobr></td>
				<td class="tab22" style="border:0 solid #708090;border-left-width:0px;border-right-width:0px;border-top-width:0px;border-bottom-width:1px;text-align;height:25px;font-family:굴림;font-size:9pt; " ><nobr>&nbsp;
					<textarea id="txt_INSNOTE" class="txtbox"  style= "width:221px; height:30px; overflow:auto;position:relative;left:-2px" maxlength="30" onBlur="bytelength(this,this.value,30);"></textarea></td>
			</tr>
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="" align=center class="txtbox"></td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px">	</td>
			</tr>			
		
			<tr>
				<td style="height:25px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="" align=center class="txtbox"></td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px"><nobr>&nbsp;
				</td>
			</tr>
<!----------------------------------------------------------->			
		</table>
	</td>
</tr>		
</table>
</div><!---------[TAB 6] --------->
								
<!---------[TAB 7] 임대/임차----------->

<div id="layer7" style="position:absolute;top:226px;">
<table style="border:0 solid #708090;border-bottom-width:0px;position:absolute; top:-26px;" cellpadding=0 cellspacing=0 border=0  width="876">		
	<tr > 			
		<td >
			<comment id="__NSID__">
			<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code13  style="position:relative;left:0px;width:600px; height:311px; border:1 solid #708090;">
			<PARAM NAME="DataID"			VALUE="gcds_code13">
			<PARAM NAME="IndWidth"		VALUE ='0'>
			<PARAM NAME="BorderStyle" VALUE="0">
			<PARAM NAME="Fillarea"		VALUE="true">
			<PARAM NAME="Sortview"		VALUE="left">
			<PARAM NAME="Format"			VALUE="  
			<C> Name='임대차일'			ID=LEASEDATE	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	Mask=XXXX-XX-XX Sort=true</C> 
			<C> Name='구분'	        ID=LEASECLS    HeadAlign=Center HeadBgColor=#B9D4DC Width=50  align=center  EditStyle=Combo Data='0:임대,1:임차'	Sort=true</C> 
			<C> Name='임대차처'			ID=LEASEHOLD	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=left  	Sort=true EditStyle=Lookup Data='gcds_vend_cd:vend_cd:vend_nm'</C> 
			<C> Name='기간'		      ID=LEASETERM   HeadAlign=Center HeadBgColor=#B9D4DC Width=60	align=center  Sort=true </C> 
			<C> Name='금액'			    ID=LEASEAMT 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right	  Sort=true </C> 			
			<C> Name='보증금'			  ID=LEASEGAMT	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=right	  Sort=true </C>
			<C> Name='목적/조건'		ID=LEASEWHY	   HeadAlign=Center HeadBgColor=#B9D4DC Width=90	align=left   	Sort=true </C>
			<C> Name='임대차상태'   ID=LEASESTS	   HeadAlign=Center HeadBgColor=#B9D4DC Width=90 	align=center  EditStyle=Combo Data='0:진행중,1:완료' Sort=true</C>
			<C> Name='평수'			    ID=LEASEPYUNG	 HeadAlign=Center HeadBgColor=#B9D4DC Width=50	align=right	  Sort=true </C>
			<C> Name='자산수리순번'	ID=LEASENO	 	 HeadAlign=Center HeadBgColor=#B9D4DC Width=80	align=center	show=false</C>
			">
			</OBJECT></comment><script>__ws__(__NSID__);</script> 
		</td>
		<td>
			<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:0px;width:270px;height:312px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>			
<!---------------------------------------------------->
				<tr>
					<td  width="200" style="border:0 solid ;border-right-width:0px;border-bottom-width:1px" bgcolor="" align= class="" colspan=2 height="30">
						<table id="div_dbtn" width="200px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:30px">
							<tr>
								<td align="right"><nobr>
									<img id="btn_Delete09" src="../../Common/img/btn/com_b_delete.gif"    style="position:relative;left:72px;top:0px;cursor:hand;display:block" onclick="ln_Delete('09')"></td>
								<td align="right">
									<img id="btn_Insert09" src="../../Common/img/btn/com_b_insert.gif"	 style="position:relative;left:52px;top:0px;cursor:hand;display:block" onClick="ln_Insert('09')"></td>
								<td align="right">	
									<img id="btn_off_save09" src="../../Common/img/btn/com_off_save.gif"	 style="position:relative;left:30px;top:0px;cursor:hand;display:none" ></td>
								<td align="right">	
									<img id="btn_save09" src="../../Common/img/btn/com_b_save.gif" 	 style="position:relative;left:30px;top:0px;cursor:hand;display:block" onclick="ln_Save_Rest('09')"></nobr></td>
							</tr>
						</table>	
					</td>								
				</tr>
				<!-------------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;임대차일&nbsp;</td>		
					<td class="tab18"  Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;">
						<comment id="__NSID__">
						<OBJECT id=gcem_LEASEDATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:6px;width:70px;height:20px;">
							<param name=Alignment			value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_LEASEDATE', 'Text')" style="position:relative;width:20px;left:px;top:1px;cursor:hand;">
					</td> 
				</tr>
				<!-------------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;임대임차구분&nbsp;</td>		
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
						<comment id="__NSID__"><OBJECT id=gclx_LEASECLS classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;left:6px;top:0px" class="txtbox" >
						<param name=ComboDataID			value="gcds_LEASECLS">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				value="false">
						<param name=ListExprFormat	 value="CDNAM^0^100">
						<param name=BindColumn			value="CDCODE">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td> 
				</tr>
				<!---------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;임대차처&nbsp;</td>	
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
						<input type=text   id=txt_LEASEHOLD style= "position:relative;top:2px;left:6px;width:50px; height:20px;"  class="txtbox"  maxlength=7 onKeydown="if(event.keyCode==13) ln_Popup_Find('txt_LEASEHOLD','04');">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="거래처를 검색합니다" style="cursor:hand;position:relative;left:3px;top:0px" align=center onclick="ln_Popup4('04');">
						<input id="txt_vend_cd4" type="text" class="txtbox"  style= "position:relative;top:2px;width:60px;height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>
					</td>
				</tr>	
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;임대/임차기간&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_LEASETERM classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>							
							<param name=MaxLength     value=20>
							<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 							
					</td>
				</tr>
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;금액&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_LEASEAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 						
					</td>
				</tr>
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;보증금&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_LEASEGAMT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</nobr>
					</td>
				</tr>			

				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;임대차목적/조건&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
						<input id="txt_LEASEWHY" type="text" class="txtbox"  style= "width:155px;height:20px;position:relative;left:6px;" MaxLength=20>
					</td>
				</tr>	

				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;임차상태&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
						<comment id="__NSID__">
						<OBJECT id=gclx_LEASESTS classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=100 style="position:relative;left:6px;top:0px" class="txtbox" >
						<param name=ComboDataID			value="gcds_LEASESTS">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort				value="false">
						<param name=ListExprFormat	    value="CDNAM^0^100">
						<param name=BindColumn			value="CDCODE">
						</OBJECT></comment><script>__ws__(__NSID__);</script> 	
					</td>
				</tr>			
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;평수&nbsp;</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px"><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_LEASEPYUNG  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;"  >
								<param name=Text          value="">
								<param name=Alignment	  value=2>
								<param name=Border	      value=true>
								<param name=Numeric	      value=true>
								<param name=MaxLength     value=5>
								<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 		
					</nobr>
				</td>
			</tr>	
		</table>
	</td>
	</tr>
	<tr>
		<td >
			&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>	
	 </td>					
	</tr>	
</table>
</div><!---------[TAB 7] --------->

<!---------[TAB 8] 근저당----------->
<div id="layer8" style="position:absolute;top:226px;">
<table style="border:0 solid #708090;border-bottom-width:0px;position:absolute; top:-26px;"  cellpadding=0 cellspacing=0 border=0  width="876">		
	<tr> 			
		<td>
			<comment id="__NSID__">
			<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code08  style="position:relative;left:0px;width:550px; height:305px; border:1 solid #708090;">
				<PARAM NAME="DataID"			VALUE="gcds_code08">
				<PARAM NAME="IndWidth"		VALUE ='0'>
				<PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<PARAM NAME="Sortview"		VALUE="left">
				<PARAM NAME="Format"			VALUE="  
				<C> Name='설정일'			  ID=MORTDATE	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=65	 align=center	Sort=true Mask=XXXX-XX-XX </C> 
				<C> Name='은행코드'	    ID=MORTBANK   HeadAlign=Center HeadBgColor=#B9D4DC Width=75  align=center Sort=true EditStyle=Lookup Data='gcds_bank2:BANCOD:BANNAM' show=false</C> 
				<C> Name='은행'	        ID=CDNAM      HeadAlign=Center HeadBgColor=#B9D4DC Width=75  align=left   Sort=true </C> 
				<C> Name='해지여부'	    ID=CLOSEORNOT HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center	Sort=true EditStyle=Combo Data='0:설정,1:해지' </C> 
				<C> Name='해지일'		    ID=CLOSEDATE  HeadAlign=Center HeadBgColor=#B9D4DC Width=80  align=center Sort=true Mask=XXXX-XX-XX  </C> 
				<C> Name='장부가액'			ID=BOOKAMT	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=100 align=right	Sort=true </C> 			
				<C> Name='면적'			    ID=MORTSIZE	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=50	 align=right  Sort=true	</C>
				<C> Name='설정금액'			ID=MORTAMT	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=90	 align=right	Sort=true </C>
				<C> Name='자산수리순번'	ID=EVALNO	 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	 align=center	show=false</C>
				">
			</OBJECT></comment><script>__ws__(__NSID__);</script> 
		</td>
		<td>
			<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:0px;width:320px;height:305px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
			<!---------------------------------------------------->
			<tr>
				<td  width="200" style="border:0 solid ;border-right-width:0px;border-bottom-width:1px" bgcolor="" align= class="" colspan=4 height="29">
					<table id="div_dbtn" width="200px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:80px">
						<tr>
							<td align="right"><nobr>
								<img id="btn_Delete06" src="../../Common/img/btn/com_b_delete.gif"    style="position:relative;left:72px;top:0px;cursor:hand;display:block" onclick="ln_Delete('06')"></td>
							<td align="right">
								<img id="btn_Insert06" src="../../Common/img/btn/com_b_insert.gif"	 style="position:relative;left:52px;top:0px;cursor:hand;display:block" onClick="ln_Insert('06')"></td>
							<td align="right">	
								<img id="btn_off_save06" src="../../Common/img/btn/com_off_save.gif"	 style="position:relative;left:30px;top:0px;cursor:hand;display:none" ></td>
							<td align="right">	
								<img id="btn_save06" src="../../Common/img/btn/com_b_save.gif" 	 style="position:relative;left:30px;top:0px;cursor:hand;display:block" onclick="ln_Save_Rest('06')"></nobr></td>
						</tr>
					</table>		
				</td>								
			</tr>
			<!-------------------------------------------------------------->
			<tr>				
				<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">설정일</td>
				<td  width="35"  Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
					<comment id="__NSID__">
					<OBJECT id=gcem_MORTDATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
					style="position:relative;top:2px;left:6px;width:67px;height:20px;">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					</OBJECT></comment><script>__ws__(__NSID__);</script>					
				</td>
				<td  width="75" style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">감정일</td>
				<td width="35" Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
					<comment id="__NSID__">
					<OBJECT id=gcem_MORTJDGDT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F
					style="position:relative;top:2px;left:6px;width:70px;height:20px;">
					<param name=Alignment			value=0>
					<param name=Border	      value=true>
					<param name=Format	      value="YYYY/MM/DD">
					<param name=PromptChar	  value="_">
					</OBJECT></comment><script>__ws__(__NSID__);</script>					
					</nobr>
				</td>
				</tr>
				<!-------------------------------------------------------------->
				<tr>				
					<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">해지여부</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gclx_CLOSEORNOT classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 height=200 width=67 style="position:relative;left:-6px;top:3px" class="txtbox" >
						<param name=ComboDataID			value="gcds_CLOSEORNOT">
						<param name=CBDataColumns		value="CDCODE,CDNAM">
						<param name=SearchColumn		value="CDNAM">
						<param name=Sort						value="false">
						<param name=ListExprFormat	value="CDNAM^0^67">
						<param name=BindColumn			value="CDCODE">
						</OBJECT></comment><script>__ws__(__NSID__);</script>				
					</td>
					<td style="height:30px;border:0 solid #708090;border-bottom-width:1px;border-right-width:1px;border-left-width:1px;" bgcolor="#eeeeee" align=center class="txtbox">해지일</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">
						<comment id="__NSID__">
						<OBJECT id=gcem_CLOSEDATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:6px;width:67px;height:20px;">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script>					
					</td>
				</tr>
        <!------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">장부가액</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_BOOKAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:-6;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 								
					</td>
				</tr>
				<!------------------------------------------------------------>
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">면적</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_MORTSIZE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:-6;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=MaxLength     value=20>
							<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 						
					</td>
				</tr>
				<!----------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">은행코드</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
					  <input type=text   id=gcem_MORTBANK style= "position:relative;top:0px;left:6px;width:50px; height:20px;"  class="txtbox"  maxlength=7; onkeydown="ln_Bank_Find('gcem_MORTBANK','01');">
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="은행명을 검색합니다"  style="cursor:hand;position:relative;left:2px;top:5px"  onclick="ln_Popup1();">	
						<input id="txt_MORTBANK" type="text" class="txtbox"  style= "position:relative;top:0px;width:130px;left:0px; height:20px;" maxlength="36" onBlur="bytelength(this,this.value,36);" disabled>										  		
					</td>
				</tr>			
        <!----------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">감정가액</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_JUDGAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:-6;"  >
						<param name=Text          value="">
						<param name=Alignment	    value=2>
						<param name=Border	      value=true>
						<param name=Numeric	      value=true>
						<param name=Format	      value="000,000,000">
						<param name=MaxLength     value=13>
						<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</nobr>
					</td>
				</tr>			
        <!----------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">설정금액</td>
					<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_MORTAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:120px;height:20;position:relative;top:1px;left:-6;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 		
					</nobr>
				</td>
			</tr>			
			<!----------------------------------------------------------->
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">설정내역</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px" colspan=3>
					<input id="txt_MORTDTL" type="text" class="txtbox"  style= "width:220px;height:20px;position:relative;left:6px;" MaxLength=20>	
					</nobr>
				</td>
			</tr>	
			<!----------------------------------------------------------->
			<tr>
				<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:0px" bgcolor="#eeeeee" align=center class="txtbox">설정순위</td>
				<td Style="height:25px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" colspan=3>
					<input id="txt_MORTORDER" type="text" class="txtbox"  style= "width:50px;height:20px;position:relative;left:6px;" MaxLength=2>	
					</nobr>
				</td>
			</tr>	
		</table>
	</td>
</tr>
<tr>
	<td>
		&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>
	</td>					
</tr>	
</table>
</div><!---------[TAB 8] --------->

<!---------[TAB 9] 평가---------->
<div id="layer9" style="position:absolute;top:226px;">
<table style="border:0 solid #708090;border-bottom-width:0px;position:absolute;  top:-26px;"  cellpadding=0 cellspacing=0 border=0  width="876">		
	<tr> 
		<td>
			<comment id="__NSID__">
			<OBJECT classid=clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49 id=gcgd_code07 style="position:relative;left:0px;width:600px; height:300px; border:1 solid #708090;">
				<PARAM NAME="DataID"			VALUE="gcds_code07">
				<PARAM NAME="IndWidth"		VALUE ='0'>
				<PARAM NAME="BorderStyle" VALUE="0">
				<PARAM NAME="Fillarea"		VALUE="true">
				<PARAM NAME="Sortview"		VALUE="left">
				<PARAM NAME="Format"			VALUE="  
				<C> Name='평가일'		      ID=EVALDATE	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center	Mask=XXXX-XX-XX Sort=true</C> 
				<C> Name='평가전금액'		  ID=BEVALAMT   HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=right   Sort=true </C> 
				<C> Name='평가금액'		    ID=EVALAMT   	HeadAlign=Center HeadBgColor=#B9D4DC Width=130	align=right   Sort=true  </C> 
				<C> Name='평가차액'			  ID=DIFFAMT	 	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=right	  Sort=true </C> 	
				<C> Name='평가후내용년수'	ID=EVALAFYEAR	HeadAlign=Center HeadBgColor=#B9D4DC Width=120	align=center  Sort=true</C>
				<C> Name='자산수리순번'		ID=EVALNO	 	  HeadAlign=Center HeadBgColor=#B9D4DC Width=80	  align=center	show=false</C>
			">
			</OBJECT></comment><script>__ws__(__NSID__);</script> 
		</td>
		<td>
			<table border= "0" cellpadding=0 cellspacing=0  border=0  style='position:relative;left:0px;top:0px;width:270px;height:302px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
				<!---------------------------------------------------->
				<tr>
					<td  width="200" style="border:0 solid ;border-right-width:0px;border-bottom-width:1px" bgcolor="" align= class="" colspan=2 height="30">
						<table id="div_dbtn" width="200px" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:30px">
							<tr>
								<td align="right"><nobr>
									<img id="btn_Delete05" src="../../Common/img/btn/com_b_delete.gif"    style="position:relative;left:72px;top:0px;cursor:hand;display:block" onclick="ln_Delete('05')"></td>
								<td align="right">
									<img id="btn_Insert05" src="../../Common/img/btn/com_b_insert.gif"	 style="position:relative;left:52px;top:0px;cursor:hand;display:block" onClick="ln_Insert('05')"></td>
								<td align="right">	
									<img id="btn_off_save05" src="../../Common/img/btn/com_off_save.gif"	 style="position:relative;left:30px;top:0px;cursor:hand;display:none" ></td>
								<td align="right">	
									<img id="btn_save05" src="../../Common/img/btn/com_b_save.gif" 	 style="position:relative;left:30px;top:0px;cursor:hand;display:block" onclick="ln_Save_Rest('05')"></nobr>
								</td>
							</tr>
						</table>		
					</td>								
				</tr>
<!-------------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;평가일&nbsp;</td>		
					<td class="tab18"  Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px;">
						<comment id="__NSID__">
						<OBJECT id=gcem_EVALDATE classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:6px;width:70px;height:20px;">
						<param name=Alignment			value=0>
						<param name=Border	      value=true>
						<param name=Format	      value="YYYY/MM/DD">
						<param name=PromptChar	  value="_">
						</OBJECT></comment><script>__ws__(__NSID__);</script> &nbsp;
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_EVALDATE', 'Text')" style="position:relative;width:20px;left:px;top:1px;cursor:hand;">
					</td> 
				</tr>
<!---------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;평가전금액&nbsp;</td>	
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_BEVALAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;" >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>	
<!------------------------------------------------------------>	
				<tr>

					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;평가금액&nbsp;</td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px">&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_EVALAMT classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;" >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 
					</td>
				</tr>
<!----------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;평가차액&nbsp;</td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_DIFFAMT  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;"  >
							<param name=Text          value="">
							<param name=Alignment	  value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=Format	      value="000,000,000">
							<param name=MaxLength     value=13>
							<param name=IsComma	      value=true>
						</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</nobr>
					</td>
				</tr>
<!----------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:1px;border-bottom-width:1px" bgcolor="#eeeeee" align=center class="txtbox">&nbsp;평가후내용년수&nbsp;</td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:1px"><nobr>&nbsp;
						<comment id="__NSID__">
						<OBJECT id=gcem_EVALAFYEAR  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="width:100px;height:20;position:relative;top:1px;left:-6;"  >
							<param name=Text          value="">
							<param name=Alignment	    value=2>
							<param name=Border	      value=true>
							<param name=Numeric	      value=true>
							<param name=MaxLength     value=3>
							<param name=IsComma	      value=true>
							</OBJECT></comment><script>__ws__(__NSID__);</script> 		
						</nobr>
					</td>
				</tr>			
<!----------------------------------------------------------->	
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="" align=center class="txtbox">&nbsp;&nbsp;</td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px">
					</td>
				</tr>	
<!----------------------------------------------------------->
				<tr>
					<td style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px" bgcolor="" align=center class="txtbox">&nbsp;&nbsp;</td>
					<td Style="height:30px;border:0 solid #708090;border-right-width:0px;border-bottom-width:0px">			
					</td>
				</tr>	
			</table>
		</td>
	</tr>
	<tr>
		<td>
			&nbsp;	<font id=ft_cnt1 style="position:relative;top:4px;"></font>&nbsp;</font>		
		</td>					
 </tr>	
</table>
</div>
<!---------[TAB 9] --------->
</td>
</tr>
</table>

<!-----------------------------------------------------------------------------
			B I N D   D E F I N I T I O N
------------------------------------------------------------------------------>
<!--------자산원장 OK------->
<comment id="__NSID__">
  <object  id=gcbn_astmst classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		   value=gcds_code00>
	<param name=ActiveBind   value=true>
	<param name=BindInfo	   value='
		<C>Col=FDCODE     Ctrl=gclx_sfdcode2     Param=bindcolval </C>	
		<C>Col=ASTNBR     Ctrl=gcem_asnbr_2      Param=text </C>
		<C>Col=ASTNAMENM  Ctrl=txt_jasan         Param=value </C>	
		<C>Col=ASTNAME    Ctrl=gcem_jasan        Param=text </C>
		<C>Col=AST1ST     Ctrl=gclx_sfdcode2     Param=bindcolval </C>
		<C>Col=AST2ND     Ctrl=gclx_ast2nd       Param=bindcolval </C>		
		<C>Col=AST3RD     Ctrl=gclx_ast3rd       Param=bindcolval </C>
    <C>Col=ASTSEQ     Ctrl=gcem_astseq       Param=text  </C>
    <C>Col=ASAQSDAT   Ctrl=gcem_asaqsdat     Param=text </C>	
		<C>Col=TAXNBR     Ctrl=gcem_taxnbr       Param=text </C>	
		<C>Col=ASTNAME3   Ctrl=txt_modelnm_1     Param=value </C>	
		<C>Col=DEPTCD     Ctrl=txt_cadeptcd_3    Param=value </C>	
		<C>Col=DEPTNM     Ctrl=txt_cadeptnm_3    Param=value </C>	
    <C>Col=EMPNO      Ctrl=txt_empno         Param=value </C>	
    <C>Col=EMPNMK     Ctrl=txt_empnm         Param=value </C>	
    <C>Col=ATCODE     Ctrl=gcem_atcode       Param=text </C>	
		<C>Col=H_ASTNBR   Ctrl=gcem_h_asnbr_2    Param=text </C>	
		<C>Col=S_ASTNBR   Ctrl=gcem_s_astnbr     Param=text </C>	
		<C>Col=MORDT        Ctrl=gcem_mordt     Param=text </C>	
		
	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>

<!--------ASTBASIC OK------->
<comment id="__NSID__">
  <object id=gcbn_astbasic classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		   value=gcds_code02>
	<param name=ActiveBind   value=true>
	<param name=BindInfo	   value='
	  <C>Col=FDCODE	   Ctrl=gclx_sfdcode2   Param=bindcolval </C>	
		<C>Col=ATCODE	   Ctrl=gcem_atcode     Param=text </C>	
		<C>Col=AST1ST	   Ctrl=gclx_sfdcode2   Param=bindcolval </C>	
		<C>Col=AST2ND	   Ctrl=gclx_ast2nd     Param=bindcolval </C>	
		<C>Col=AST3RD	   Ctrl=gclx_ast3rd     Param=bindcolval </C>	
		<C>Col=ASTSEQ	   Ctrl=gcem_astseq     Param=text </C>	
		<C>Col=GODDIV	   Ctrl=gclx_goddiv     Param=bindcolval </C>	
    <C>Col=ASAQSDIV	 Ctrl=gclx_asaqsdiv   Param=bindcolval </C>
    <C>Col=ASTSTAT	 Ctrl=gclx_aststat    Param=bindcolval </C>	
    <C>Col=ASTQTY 	 Ctrl=gcem_ASTQTY     Param=text </C>
    <C>Col=ASTYUSE	 Ctrl=gcem_ASTYUSE    Param=text </C>	
		<C>Col=ASTUNIT	 Ctrl=txt_ASTUNIT     Param=value </C>	
    <C>Col=ASTAQAMT	 Ctrl=gcem_ASTAQAMT   Param=text </C>
    <C>Col=ASTAQAMTY Ctrl=gcem_ASTAQAMTY  Param=text </C>	
    <C>Col=ASTSTD 	 Ctrl=txt_ASTSTD      Param=value </C>
    <C>Col=COSTCD 	 Ctrl=txt_COSTCD      Param=value </C>	
		<C>Col=COSTNM 	 Ctrl=txt_COSTNM      Param=value </C>	
    <C>Col=ASCOSDIV	 Ctrl=gclx_ascosdiv   Param=bindcolval </C>
    <C>Col=USEDPT 	 Ctrl=txt_usedpt      Param=value </C>	
    <C>Col=USEDPTNM	 Ctrl=txt_usedptnm    Param=value </C>
    <C>Col=ASTUSER	 Ctrl=gcem_astuser    Param=text </C>	
		<C>Col=ASTUSERNM Ctrl=txt_astusernm   Param=value </C>	
    <C>Col=MNGDPT 	 Ctrl=txt_mngdpt      Param=value </C>
    <C>Col=MNGDPTNM	 Ctrl=txt_mngdptnm    Param=value </C>	
    <C>Col=BUYFROM	 Ctrl=txt_buyfrom     Param=value </C>
    <C>Col=VEND_NM	 Ctrl=txt_vend_nm     Param=value </C>	
		<C>Col=MAKER	   Ctrl=txt_MAKER       Param=value </C>	
		<C>Col=MAKERNM	 Ctrl=txt_MAKENM      Param=value </C>	
		<C>Col=ASTCLASS	 Ctrl=gclx_astclass   Param=bindcolval </C>	
		<C>Col=MNGTYPE	 Ctrl=gclx_mngtype    Param=bindcolval </C>	
		<C>Col=USELOC 	 Ctrl=txt_USELOC      Param=value </C>	
		<C>Col=ASTRIS 	 Ctrl=gclx_astris     Param=bindcolval </C>	
		<C>Col=ASTNOTE 	 Ctrl=txt_ASTNOTE     Param=value </C>	
		<C>Col=REGIGB 	 Ctrl=gclx_regigb     Param=bindcolval </C>	
		<C>Col=DEPRGB 	 Ctrl=gclx_deprgb     Param=bindcolval </C>	
  	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>

<!--------부가정보1 OK------->
<comment id="__NSID__">
  <object id=gcbn_astadinfo1 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		   value=gcds_code31>
	<param name=ActiveBind   value=true>
	<param name=BindInfo	   value='
		<C>Col=ASTSOJE  	   Ctrl=txt_ASTSOJE     Param=value </C>	
		<C>Col=ASTPOST  	   Ctrl=gcem_ASTPOST    Param=text </C>	
		<C>Col=ASTCON   	   Ctrl=txt_ASTCON      Param=value </C>	
		<C>Col=ASTUSE   	   Ctrl=txt_ASTUSE      Param=value </C>	
		<C>Col=ASTSIZE  	   Ctrl=gcem_ASTSIZE    Param=text </C>	
		<C>Col=ASTPYUNG 	   Ctrl=gcem_ASTPYUNG   Param=text </C>	
		<C>Col=ASTREGYMD	   Ctrl=gcem_ASTREGYMD  Param=text </C>	
		<C>Col=ASTREGNO 	   Ctrl=gcem_ASTREGNO   Param=text </C>	
  	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>

<!--------부가정보2 OK------->
<comment id="__NSID__">
  <object id=gcbn_astadinfo2 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		   value=gcds_code32>
	<param name=ActiveBind   value=true>
	<param name=BindInfo	   value='
		<C>Col=ACARTYPE 	   Ctrl=txt_ACARTYPE    Param=value </C>	
		<C>Col=ACARNO   	   Ctrl=txt_ACARNO      Param=value </C>	
		<C>Col=ACARBEGI 	   Ctrl=txt_ACARBEGI    Param=value </C>	
		<C>Col=ACARFUEL 	   Ctrl=txt_ACARFUEL    Param=value </C>	
		<C>Col=ACARUSE  	   Ctrl=txt_ACARUSE     Param=value </C>	
		<C>Col=ACARINSDT	   Ctrl=gcem_ACARINSDT  Param=text </C>	
		<C>Col=ACARDRVID	   Ctrl=txt_ACARDRVID   Param=value </C>	
		<C>Col=AINSDT2  	   Ctrl=gcem_AINSDT2    Param=text </C>	
  	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>

<!--------부가정보3 OK------->
<comment id="__NSID__">
  <object id=gcbn_astadinfo3 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		   value=gcds_code33>
	<param name=ActiveBind   value=true>
	<param name=BindInfo	   value='
		<C>Col=AMMODEL  	   Ctrl=txt_AMMODEL     Param=value </C>	
		<C>Col=AMAKEDATE	   Ctrl=gcem_AMAKEDATE  Param=text </C>	
		<C>Col=ASUBSTD  	   Ctrl=txt_ASUBSTD     Param=value </C>	
		<C>Col=AMAKENO  	   Ctrl=gcem_AMAKENO    Param=text </C>	
		<C>Col=AMFORM   	   Ctrl=txt_AMFORM      Param=value</C>	
		<C>Col=AMOIL    	   Ctrl=txt_AMOIL       Param=value </C>	
  	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>

<!--------감가상각 OK------->
<comment id="__NSID__">
  <object id=gcbn_astdepr  classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID		   value=gcds_code04>
	<param name=ActiveBind   value=true>
	<param name=BindInfo	   value='
		<C>Col=ASTAQAMT 	   Ctrl=gcem_ASTAQAMT2  Param=text </C>	
		<C>Col=ASTYUSE  	   Ctrl=gcem_ASTYUSE2   Param=text </C>	
		<C>Col=ASTRMAMT 	   Ctrl=gcem_ASTRMAMT   Param=text </C>	
		<C>Col=ASTDEPRST	   Ctrl=gclx_ASTDEPRST  Param=bindcolval </C>	
		<C>Col=DEPRENDDT	   Ctrl=gcem_DEPRENDDT  Param=text </C>	
		<C>Col=ACDEPRAMT 	   Ctrl=gcem_ACDEPRAMT   Param=text </C>	
		<C>Col=ABDECAMT 	   Ctrl=gcem_ABDECAMT   Param=text </C>	
		<C>Col=ABDEPRAMT	   Ctrl=gcem_ABDEPRAMT  Param=text </C>	
		<C>Col=ABBOOKAMT	   Ctrl=gcem_ABBOOKAMT  Param=text </C>	
  	'>											 
  </object>
</comment><script>__ws__(__NSID__);</script>

<!--------고정자산이동------->
<comment id="__NSID__">
  <object  id=gcbn_code07 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			 value=gcds_code12>
	<param name=ActiveBind   value=true>
	<param name=BindInfo	   value='
		<C>Col= MOVDATE     Ctrl=gcem_MOVDATE          Param=text    </C>	
		<C>Col= AMNGDPT     Ctrl=txt_amngdept          Param=value   </C>
		<C>Col= AMNGDEPTNM  Ctrl=txt_amngdeptnm        Param=value   </C>
		<C>Col= AUSEDPT     Ctrl=txt_ausedept          Param=value   </C>	
		<C>Col= AUSEDEPTNM  Ctrl=txt_ausedeptnm        Param=value   </C>	
		<C>Col= ACOSTCD     Ctrl=txt_ACOSTCD           Param=value   </C>
		<C>Col= MOVNOTE     Ctrl=txt_MYPLAN            Param=value	 </C>		
    <C>Col= ACOSTNM     Ctrl=txt_ACOSTNM           Param=value   </C>	
	'>
  </object>
</comment><script>__ws__(__NSID__);</script>

<!--------고정자산수리------->

<comment id="__NSID__"><object  id=gcbn_code01 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			  value=gcds_code05>
	<param name=ActiveBind    value=true>
	<param name=BindInfo	    value='
		<C>Col= REPAIRDATE    Ctrl=gcem_REPAIRDATE    Param=text  </C>	
		<C>Col= REPAIRPART    Ctrl=txt_REPAIRPART     Param=value </C>		
		<C>Col= DEFECTNOTE    Ctrl=txt_DEFECTNOTE     Param=value	</C>	
		<C>Col= REPAIRAMT     Ctrl=gcem_REPAIRAMT     Param=text	</C>  
		<C>Col= WRDT          Ctrl=gcem_WRDT          Param=text  </C>
		<C>Col= WRID          Ctrl=txt_WRID           Param=value	</C>
		<C>Col= VEND_NM       Ctrl=txt_vend_cd2       Param=value	</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 			

<!-------보험----------->

<comment id="__NSID__"><object  id=gcbn_code02 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			  value=gcds_code06>
	<param name=ActiveBind    value=true>
	<param name=BindInfo	    value='
		<C>Col=INSUREDATE   Ctrl=gcem_INSUREDATE    Param=text    </C>	
		<C>Col=INSHEETNO    Ctrl=gcem_INSHEETNO     Param=text		</C>		
		<C>Col=INSSTARTDT   Ctrl=gcem_INSSTARTDT    Param=text		</C>	
		<C>Col=INSENDDT     Ctrl=gcem_INSENDDT      Param=text		</C>
    <C>Col=INSTERM      Ctrl=gcem_INSTERM       Param=text	  </C>
		<C>Col=INSAMT       Ctrl=gcem_INSAMT        Param=text		</C>	
		<C>Col=INSEDAMT     Ctrl=gcem_INSEDAMT      Param=text		</C>
    <C>Col=INSFIRM      Ctrl=txt_INSFIRM        Param=value	  </C>
		<C>Col=INSNOTE      Ctrl=txt_INSNOTE        Param=value		</C>	
    <C>Col=WRDT         Ctrl=gcem_WRDT2         Param=text	  </C>
		<C>Col=WRID         Ctrl=txt_WRID2          Param=value		</C>
		<C>Col=VEND_NM      Ctrl=txt_vend_cd3       Param=value		</C>

	'>
</object></comment><script>__ws__(__NSID__);</script> 		

<!-------평가----------->
<comment id="__NSID__"><object  id=gcbn_code03 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			  value=gcds_code07>
	<param name=ActiveBind    value=true>
	<param name=BindInfo	    value='
		<C>Col=  EVALDATE   Ctrl=gcem_EVALDATE     Param=text  </C>	
		<C>Col= BEVALAMT    Ctrl=gcem_BEVALAMT     Param=text	 </C>
		<C>Col= EVALAMT     Ctrl=gcem_EVALAMT      Param=text	 </C>
    <C>Col= DIFFAMT     Ctrl=gcem_DIFFAMT      Param=text	 </C>
		<C>Col= EVALAFYEAR  Ctrl=gcem_EVALAFYEAR   Param=text	 </C>
    <C>Col= WRDT        Ctrl=gcem_WRDT3        Param=text	 </C>
		<C>Col=WRID         Ctrl=txt_WRID3         Param=value </C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 		

<!-------근저당----------->
<comment id="__NSID__"><object  id=gcbn_code04 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			  value=gcds_code08>
	<param name=ActiveBind    value=true>
	<param name=BindInfo	    value='
		<C>Col=MORTDATE         Ctrl=gcem_MORTDATE      Param=text  </C>	
		<C>Col=MORTBANK         Ctrl=gcem_MORTBANK      Param=value	</C>
		<C>Col=CLOSEORNOT       Ctrl=gclx_CLOSEORNOT    Param=BindColVal	</C>
    <C>Col=CLOSEDATE        Ctrl=gcem_CLOSEDATE     Param=text	</C>
		<C>Col=BOOKAMT          Ctrl=gcem_BOOKAMT       Param=text	</C>
		<C>Col=MORTSIZE         Ctrl=gcem_MORTSIZE      Param=text  </C>	
		<C>Col=MORTJDGDT        Ctrl=gcem_MORTJDGDT     Param=text	</C>
		<C>Col=JUDGAMT          Ctrl=gcem_JUDGAMT       Param=text	</C>
    <C>Col=MORTAMT          Ctrl=gcem_MORTAMT       Param=text	</C>
		<C>Col=MORTDTL          Ctrl=txt_MORTDTL        Param=value	</C>
		<C>Col=MORTORDER        Ctrl=txt_MORTORDER      Param=value	</C>
		<C>Col=WRDT             Ctrl=gcem_WRDT4         Param=text	</C>
		<C>Col=WRID             Ctrl=txt_WRID4          Param=value	</C>
    <C>Col=CDNAM            Ctrl=txt_MORTBANK       Param=value	</C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 	


<!-------임대/임차---------->
<comment id="__NSID__"><object  id=gcbn_code06 classid=CLSID:9C9AB433-EA85-11D2-A4F9-00608CEBEE49> 
	<param name=DataID			  value=gcds_code13>
	<param name=ActiveBind    value=true>
	<param name=BindInfo	    value='
		<C>Col=LEASEDATE        Ctrl=gcem_LEASEDATE       Param=text       </C>	
		<C>Col= LEASECLS        Ctrl=gclx_LEASECLS        Param=BindColVal </C>
		<C>Col= LEASEHOLD       Ctrl=txt_LEASEHOLD        Param=value	     </C>
         <C>Col=LEASETERM        Ctrl=gcem_LEASETERM       Param=text	     </C>
		<C>Col=LEASEAMT         Ctrl=gcem_LEASEAMT        Param=text	     </C>
		<C>Col=LEASEGAMT        Ctrl=gcem_LEASEGAMT       Param=text       </C>	
		<C>Col=LEASEWHY         Ctrl=txt_LEASEWHY         Param=value	     </C>
		<C>Col=LEASESTS         Ctrl=gclx_LEASESTS        Param=BindColVal </C>
        <C>Col=LEASEPYUNG       Ctrl=gcem_LEASEPYUNG      Param=text       </C>
		<C>Col=WRDT             Ctrl=gcem_WRDT7           Param=text	     </C>
		<C>Col=WRID             Ctrl=txt_WRID7            Param=value	     </C>
		<C>Col=VEND_NM          Ctrl=txt_vend_cd4         Param=value	     </C>
	'>
</object></comment><script>__ws__(__NSID__);</script> 	

<!--<iframe id="LowerFrame" name="work" style="visibility:hidden; 	position:absolute; left:280px; top:220px;" FrameBorder="0" src="../../common/img/flash/loading.swf" width="320px" height="42px"> </iframe> -->

</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/>	