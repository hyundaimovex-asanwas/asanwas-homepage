<%@ page language="java" contentType="text/html;charset=euc-kr" %>
<!-------------------------------------------------------------------------------
+ 시 스 템 명	:	매출세금계산서 1차승인 화면 
+ 프로그램 ID	: A041010
+ 기 능 정 의	: 조회|저장|삭제|엑셀
+ 작   성  자	: 이 동 훈 
+ 작 성 일 자 : 2017.07.21 
+ 서 블 릿 명	:
------------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 :  
+ 수 정 일 자 : 
+ 서 블 릿 명	:
------------------------------------------------------------------------------
+ 수 정 내 용 : 
+ 수   정  자 :  
+ 수 정 일 자 : 
+ 서 블 릿 명	:
------------------------------------------------------------------------------>
<%@ page import="Account.common.*" %>
<% String dirPath = request.getContextPath(); //HDASan // ContextPath 변수 설정. %>
<html>
<head>
<jsp:include page="/Account/common/include/head.jsp"/>
<title>매출세금계산서 1차승인</title>

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

var gs_date = gcurdate.substring(0,4) + gcurdate.substring(5,7) + gcurdate.substring(8,10);
var gs_date2 = gcurdate.substring(0,4) + gcurdate.substring(5,7);
var gs_userid = gusrid;
var gs_fdcode = gfdcode;

var gstrempno="";
var gstrdeptcd="";
var gstrGubun ="";
var gstrAuthgr="";
var gstrRowpos="";
var gs_sm_call_status=""; // 호출 asp 구분

/******************************************************************************
 화면 로딩
******************************************************************************/
function fnOnLoad(tree_idx){
	
	fnInit_tree(tree_idx);	//트리초기화 호출
	
    ln_Before();

	sp7.style.display = ""; //세금계산서보기
	
	ln_Query();
	
}

/******************************************************************************
	Description : 선조회
******************************************************************************/
function ln_Before(){ 
		
	gclx_fsstat.index = 0;										//전표상태
	//gclx_cocode.BindColVal	= "02";						//사업소
	gcem_staxdatfr.text			= gs_date2 + "01";			//계산서기간 from
	gcem_staxdatto.text		= gs_date;					//계산서기간 to

	//지점코드
	gcds_fdcode.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a010003_s1?v_str1="; 
	gcds_fdcode.Reset();

	//부가세종류[매입]
	gcds_staxknd.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0013"; 
	gcds_staxknd.Reset();

	//부가세종류[매출]
	gcds_staxknd2.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>commdtil_s1?v_str1=0009"; 
	gcds_staxknd2.Reset();
	

}



/******************************************************************************
	Description : 조회
******************************************************************************/
function ln_Query(){

		var str1 = gclx_staxiodiv.BindColVal;	//매입매출구분
		var str2 = gclx_cocode.BindColVal;		//사업소
		var str3 = gcem_staxdatfr.text;			//계산서기간 from
		var str4 = gcem_staxdatto.text;			//계산서기간 to
		var str5 = gcem_vendcd.text;			//거래처코드
		var str6 = "";		                    	//귀속구분
		var str7 = "";	                      		//부가세종류
		var str8 = "";                      			//발행여부
		var str9 = gclx_fsstat.BindColVal;		//전표상태
		var str10 = gcem_vendnm.text;			//거래처명
		var str11 = gclx_fdcode.BindColVal;	//지점코드
		var str12 = gs_userid;	                	//로그인
		var str17 = "";                        	 	//수정코드
		var gs_chk="";
		var str18 = gclx_gubun.BindColVal;      //전자발행구분
		var str19 = gcem_empno.text;            //작성자
		

		if (str1 =="1") {       //매입
			str1 = "A";
			str7 = gclx_staxknd.BindColVal;
		}else if (str1 =="2") { //매출
			str1 = "B";
			str7 = gclx_staxknd_2.BindColVal;		
  	    }
		
		//부가세 관리자
		str13 = "1";	



    	if(str1 =="A"){         //매입
			//세금계산서 ( 과세 +불공+영세 ) 
			if(str7=="9"){
				str7= "1','2','4";
			}else if (str7=="6"){
				str7= "1','2','4','7','8";
			}
    	}else if(str1 =="B"){  //매출
			if(str7=="9"){  //세금계산서 (과세+영세)
				str7= "1','2";
			}
		}
    	
    	var str20 = txt_costcd.value;         //작성자
    	var str21 = gclx_ebillgb.bindcolval;  //eBill구분
    	var str22 = gclx_taxsts.bindcolval;   //결재상태
    	
    	
    	ln_Grid_Fromat();

		//세금계산서+기타  ( 과세 +불공+영세 + 신용카드 + 현금영수증  ) 
    	gcds_data.DataID = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a041010_s1"
											+"?v_str1="+str1+"&v_str2="+str2
											+"&v_str3="+str3+"&v_str4="+str4
											+"&v_str5="+str5+"&v_str6="+str6
											+"&v_str7="+str7+"&v_str8="+str8
											+"&v_str9="+str9+"&v_str10="+str10
											+"&v_str11="+str11+"&v_str12="+gs_chk
											+"&v_str13="+str12+"&v_str14="+str13
											+"&v_str15="+gstrempno+"&v_str16="+gstrdeptcd
											+"&v_str17="+str17+"&v_str18="+str18
											+"&v_str19="+str19+"&v_str20="+str20
											+"&v_str21="+str21+"&v_str22="+str22;
											
		//prompt('',gcds_data.DataID);
		gcds_data.Reset();
}


function ln_Grid_Fromat(){
	
	if(gclx_gridfix.bindcolval=="1"){
	
	  gcgd_data.format = ""+
                        "<F>ID=CHK,	        Name='선택'			,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=CheckBox BgColor='#f5f5f5' SumBgColor=#C3D0DB </F>"+
						"<F>ID=FDNAME, 	    Name='지점'		    ,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   Edit=none sort=false SumBgColor=#C3D0DB</F>"+
						"<F>ID=FSNUM,		Name='전표번호'		,width=105,HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true mask='XXXXXXXXX-XXXXXX' SumText='합계'  SumBgColor=#C3D0DB</F>"+
						"<F>ID=VEND_CD,	    Name='거래처코드'	    ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true show=false SumBgColor=#C3D0DB</F>"+
						"<F>ID=VEND_NM,	    Name='거래처명'		,width=95, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT,   BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</F>"+
						"<F>ID=VEND_ID,	    Name='사업자번호'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, Edit=none sort=true SumBgColor=#C3D0DB mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XX****X')} </F>"+
						"<C>ID=TAXSUM,		Name='공급가액'		,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>"+
						"<C>ID=TAXVATAMT,   Name='부가세액'		,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>"+
						"<C>ID=TAXTOT,		Name='합계금액'		,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>"+
						"<C>ID=REMARK,		Name='적요'			,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=TAXKNDNM,	Name='종류'	        ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=GUBUN,       Name='발행구분'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='1:전자발행,2:수기발행'</C>"+
						"<C>ID=FSSTAT,		Name='전표상태'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:결재완료,C:결재취소,R:결재요청,N:결재대기,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=DTI_STATUS,  Name='상태'		    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:매출저장,A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>"+
						"<C>ID=TAXPRTYN,	Name='발행여부'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:발행,N:미발행' Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=EMPNMK,		Name='담당자'		    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=DEPTNM,		Name='담당부서'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=COSTCD,	    Name='원가'	        ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center,  align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=COSTNM,	    Name='원가명'	        ,width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=left  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=AMEND_CODE,  Name='수정코드'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB </C>"+
						"<C>ID=TAXCDNBR,    Name='신용카드번호'	,width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center    Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XXXX-XXXX-XXXX'</C>"+
						"<C>ID=TAXDAT,      Name='계산서일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
						"<C>ID=EXTCHK,      Name='외부발행'       ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  </C>"+
						"<C>ID=TAXDIVNM,	Name='귀속구분'		,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=FSDAT,	    Name='접수일자'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=FSNBR,	    Name='접수번호'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=CREATION_DATE,Name='메일발행일시'	,width=150, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=WRDT,        Name='작성일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
						"<C>ID=UPDT,        Name='수정일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
						"<C>ID=DUEDATE,     Name='입금예정일'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
						"<C>ID=TAXSTS,	    Name='결재상태'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='N:대기,R:요청,Y:승인,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>";
	   
						
	}else if(gclx_gridfix.bindcolval=="2"){
		gcgd_data.format = ""+
				        "<F>ID=CHK,	        Name='선택'			,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=CheckBox BgColor='#f5f5f5' SumBgColor=#C3D0DB </F>"+
						"<F>ID=FDNAME, 	    Name='지점'		    ,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   Edit=none sort=false SumBgColor=#C3D0DB</F>"+
						"<F>ID=FSNUM,		Name='전표번호'		,width=105,HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true mask='XXXXXXXXX-XXXXXX' SumText='합계'  SumBgColor=#C3D0DB</F>"+
						"<F>ID=VEND_CD,	    Name='거래처코드'	    ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true show=false SumBgColor=#C3D0DB</F>"+
						"<F>ID=VEND_NM,	    Name='거래처명'		,width=95, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT,   BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</F>"+
						"<F>ID=VEND_ID,	    Name='사업자번호'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, Edit=none sort=true SumBgColor=#C3D0DB mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XX****X')} </F>"+
						"<F>ID=TAXSUM,		Name='공급가액'		,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</F>"+
						"<F>ID=TAXVATAMT,   Name='부가세액'		,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</F>"+
						"<F>ID=TAXTOT,		Name='합계금액'		,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</F>"+
						"<C>ID=REMARK,		Name='적요'			,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=TAXKNDNM,	Name='종류'	        ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=GUBUN,       Name='발행구분'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='1:전자발행,2:수기발행'</C>"+
						"<C>ID=FSSTAT,		Name='전표상태'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:결재완료,C:결재취소,R:결재요청,N:결재대기,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=DTI_STATUS,  Name='상태'		    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:매출저장,A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>"+
						"<C>ID=TAXPRTYN,	Name='발행여부'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:발행,N:미발행' Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=EMPNMK,		Name='담당자'		    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=DEPTNM,		Name='담당부서'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=COSTCD,	    Name='원가'	        ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center,  align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=COSTNM,	    Name='원가명'	        ,width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=left  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=AMEND_CODE,  Name='수정코드'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB </C>"+
						"<C>ID=TAXCDNBR,    Name='신용카드번호'	,width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center    Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XXXX-XXXX-XXXX'</C>"+
						"<C>ID=TAXDAT,      Name='계산서일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
						"<C>ID=EXTCHK,      Name='외부발행'       ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  </C>"+
						"<C>ID=TAXDIVNM,	Name='귀속구분'		,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=FSDAT,	    Name='접수일자'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=FSNBR,	    Name='접수번호'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=CREATION_DATE,Name='메일발행일시'	,width=150, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=WRDT,        Name='작성일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
						"<C>ID=UPDT,        Name='수정일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
						"<C>ID=DUEDATE,     Name='입금예정일'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
	                	"<C>ID=TAXSTS,	    Name='결재상태'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='N:대기,R:요청,Y:승인,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>";
	
	}else if(gclx_gridfix.bindcolval=="3"){		
		gcgd_data.format = ""+
				        "<F>ID=CHK,	        Name='선택'			,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=CheckBox BgColor='#f5f5f5' SumBgColor=#C3D0DB </F>"+
						"<F>ID=FDNAME, 	    Name='지점'		    ,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   Edit=none sort=false SumBgColor=#C3D0DB</F>"+
						"<F>ID=FSNUM,		Name='전표번호'		,width=105,HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true mask='XXXXXXXXX-XXXXXX' SumText='합계'  SumBgColor=#C3D0DB</F>"+
						"<F>ID=VEND_CD,	    Name='거래처코드'	    ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true show=false SumBgColor=#C3D0DB</F>"+
						"<F>ID=VEND_NM,	    Name='거래처명'		,width=95, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT,   BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</F>"+
						"<F>ID=VEND_ID,	    Name='사업자번호'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, Edit=none sort=true SumBgColor=#C3D0DB mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XX****X')} </F>"+
						"<F>ID=TAXSUM,		Name='공급가액'		,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</F>"+
						"<F>ID=TAXVATAMT,   Name='부가세액'		,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</F>"+
						"<F>ID=TAXTOT,		Name='합계금액'		,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</F>"+
						"<F>ID=REMARK,		Name='적요'			,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</F>"+
						"<C>ID=TAXKNDNM,	Name='종류'	        ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=GUBUN,       Name='발행구분'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='1:전자발행,2:수기발행'</C>"+
						"<C>ID=FSSTAT,		Name='전표상태'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:결재완료,C:결재취소,R:결재요청,N:결재대기,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=DTI_STATUS,  Name='상태'		    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:매출저장,A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>"+
						"<C>ID=TAXPRTYN,	Name='발행여부'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:발행,N:미발행' Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=EMPNMK,		Name='담당자'		    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=DEPTNM,		Name='담당부서'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=COSTCD,	    Name='원가'	        ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center,  align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=COSTNM,	    Name='원가명'	        ,width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=left  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=AMEND_CODE,  Name='수정코드'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB </C>"+
						"<C>ID=TAXCDNBR,    Name='신용카드번호'	,width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center    Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XXXX-XXXX-XXXX'</C>"+
						"<C>ID=TAXDAT,      Name='계산서일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
						"<C>ID=EXTCHK,      Name='외부발행'       ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  </C>"+
						"<C>ID=TAXDIVNM,	Name='귀속구분'		,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=FSDAT,	    Name='접수일자'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=FSNBR,	    Name='접수번호'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=CREATION_DATE,Name='메일발행일시'	,width=150, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>"+
						"<C>ID=WRDT,        Name='작성일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
						"<C>ID=UPDT,        Name='수정일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
		                "<C>ID=DUEDATE,     Name='입금예정일'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>"+
		                "<C>ID=TAXSTS,	    Name='결재상태'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='N:대기,R:요청,Y:승인,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>";
	}						
}





/******************************************************************************
	Description : 찾기 - 거래처코드
******************************************************************************/
function ln_Popup(){
		
    var arrVAT	= new Array(); 
	var arrResult	= new Array();
	var strURL;	
	var strPos;

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


/******************************************************************************
	Description : 찾기 - 작성자 
******************************************************************************/
function ln_Popup_Empno(){

	//var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
 
	strURL = "./empno_popup3.jsp";
	strPos = "dialogWidth:480px;dialogHeight:379px;status:no;scroll:no;resizable:no";
	arrResult = showModalDialog(strURL,'',strPos);
 
	if (arrResult != null) {
		arrParam = arrResult.split(";");
        gcem_empno.text    = arrParam[0];
    }else{
        gcem_empno.text    = "";
    }
}

/***********************************************************************************************
	Description : 전표조회
	parameter   : 
**********************************************************************************************/
function ln_Slipno(){
	
	if(gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") != "") {	
		
		var arrParam	= new Array();
		var arrResult	= new Array();
		var strURL="";	
		var strPos="";

		arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"FDCODE");
		arrParam[1] = gcds_data.namevalue(gcds_data.rowposition,"FSDAT");
		arrParam[2] = gcds_data.namevalue(gcds_data.rowposition,"FSNBR");

		strURL = "./slipno_popup.jsp";
		strPos = "dialogWidth:890px;dialogHeight:600px;dialogTop:100px;dialogLeft:68px;status:no;scroll:no;resizable:no";
		arrResult = showModalDialog(strURL,arrParam,strPos);
		
	}else if (gcds_data.namevalue(gcds_data.rowposition,"CHK") == "T" && gcds_data.namevalue(gcds_data.rowposition,"FSNBR") == "") {
		
		alert("발행 된 전표가 없습니다.");
	}
	
}


/******************************************************************************
Description : 원가팝업
parameter   : 
******************************************************************************/
function ln_Costcd_Popup(){
	var result="";
	var arrParam	= new Array();
	var arrResult	= new Array();
	var strURL;	
	var strPos;
	
	arrParam[0]="0030";//원가코드
	arrParam[1]="";

	if(txt_costnm.value==""){
		 arrParam[2]="";
	}else{
	     arrParam[2]=txt_costnm.value;
	}
	
	if(txt_costcd.value==""){
	 arrParam[3]="";
	}else{
	 arrParam[3]=txt_costcd.value;
	}
	
	strURL =  "./commdtil_cost_popup.jsp";
	strPos = "dialogWidth:495px;dialogHeight:379px;status:no;scroll:no;resizable:no";		
	result = showModalDialog(strURL,arrParam,strPos);
	
	if (result != null) {
		arrResult = result.split(";");
		txt_costcd.value =arrResult[0];
		txt_costnm.value = arrResult[1];
	}else{
	    txt_costcd.value="";
		txt_costnm.value="";
	}
}	


/******************************************************************************
Description : 세금계산서 보기
parameter   :            
******************************************************************************/
function ln_Bill_View(){
	
	if(!ln_Bill_Chk()) return;
	
	if (gcds_data.IsUpdated){
		
		gs_sm_call_status="V"; // 계산서보기 tag
		
		ln_Batch_id();
		
	}
	
}

/******************************************************************************
Description : 세금계산서 보기 체크 
parameter   :            
******************************************************************************/
function ln_Bill_Chk(){
	
		var view_chk ="";
		
		//매출 일경우만 가능
		//매출 중 수신승인 또는 수신 미승인만 가능 
		for(var i=1;i<=gcds_data.countrow;i++){
		   if (gcds_data.namevalue(i,"CHK")=="T"){
		   		if(gcds_data.namevalue(i,"SUPBUY_TYPE")=="AR" ){
		   			if(gcds_data.namevalue(i,"DTI_STATUS")=="I"||gcds_data.namevalue(i,"DTI_STATUS")=="C" ){
		   				
		   			}else{
		   			
		   			   alert( i +" 행은 세금계산서 보기가 되지 않습니다. 확인바랍니다.1");
					   return false;
		   			}
		   		}else{
		   		    alert( " 매출세금계산서만 가능합니다. "+ i +" 행은 세금계산서 보기가 되지 않습니다. 확인바랍니다.2");
		   			return false;
		   		}
		   }
		}
		
		return true;
}

/******************************************************************************
Description : Interface_Batch_id 생성 및 사번으로 id, pw 찾기
parameter   :            
******************************************************************************/
function ln_Batch_id(){      

	var strregno ="";
	
	strregno = gs_regno_s;

	gctr_data2.KeyValue = "a040065_t1(I:USER=gcds_data,O:USER2=gcds_return)";
	
	gctr_data2.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040065_t1";
	
	gctr_data2.Parameters = "v_str1="+gusrid+",v_str2="+strregno;

	gctr_data2.post();
	
}


/******************************************************************************
Description : 스마트 모듈 호출 
******************************************************************************/
function ln_SM_Call(strBatchId, strId, strPass){

	var url="";
	
    var v_left = (screen.width-300)/2;
    
    var v_top  = (screen.height-300)/2;
    
	if (gs_sm_call_status=="V"){   //세금계산서 보기 및 출력
		
			url=gs_url+"/callSB_V3/XXSB_DTI_PRINT.asp?BATCH_ID="+strBatchId+"&SORTFIELD=A&SORTORDER=1";		
	
			window.open(url,"", "status=1,  scrollbars=yes, width=300, height=280, left="+v_left+", top="+v_top  );
			
			ln_Query();
			
	}	
	
}


<%
/******************************************************************************
Description : 승인
******************************************************************************/
%>
function ln_Apply(){

		if(!ln_Chk_Status()){
			
			return;
			
		}else if (gcds_data.IsUpdated) {
			
			if (confirm("매출 정보를 1차 승인 하시겠습니까?")){	
				
				gctr_data.KeyValue   = "Account.a041010_t1(I:USER=gcds_data)";
				
				gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a041010_t1";
				
				gctr_data.Parameters = "v_str1="+gs_userid+",v_str2="+gs_date2;
				
				//prompt('',gcds_data.text);
				
				gctr_data.post();
				
				ln_Query();
				
			}	
			
		}
	
}

<%
/******************************************************************************
Description : 입력값 체크
******************************************************************************/
%>
function ln_Chk_Status(){
	

	//결재상태 체크
	 var vcnt=0;
	
		for(var i =1; i<=gcds_data.countrow;i++){
			
		if(gcds_data.namevalue(i,"CHK")=="T"){
			
			if(gcds_data.namevalue(i,"TAXSTS") != ''){
				
				alert("승인 대상 건이 아닙니다.");
				
				return false;
				
			}else{
				
				gcds_data.namevalue(i,"TAXSTS")="Y"; 
				
			}
			
			vcnt+=1;
			
		}
		
	}
	
	if(vcnt==0){
		
		alert("선택된 항목이 존재 하지 않습니다.");
		
		return false;
		
	}
	
	return true;
}

<%
/******************************************************************************
Description : 반송
******************************************************************************/
%>
function ln_SendBack(){
	
	if(!ln_Chk_SendBack_Status())return;
	
	else if (gcds_data.IsUpdated) {
		
		if (confirm("매출 정보를 반송 하시겠습니까?")){	
			
			gctr_data.KeyValue   = "Account.a040058_t5(I:USER=gcds_data)";
			
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040058_t5";
			
			gctr_data.Parameters = "v_str1="+gs_userid;
			
			//prompt('',gcds_data.text);
			
			gctr_data.post();
			
			//ln_Query();
		}	
	}
}

<%
/******************************************************************************
	Description : 입력값 체크
******************************************************************************/
%>
function ln_Chk_SendBack_Status(){
    
	if(txt_vend_cd.value==""){
		alert("거래처코드가 존재하지 않습니다.");
		return false;
	}
	
	if(txt_vend_nm.value==""){
		alert("거래처명이 존재하지 않습니다.");
		return false;
	}
	
	if(gcem_vend_id.text==""){
		alert("등록번호가 존재하지 않습니다.");
		return false;
	}
	
	if(txt_sb_reason.value==""){
		alert("반송사유가 존재하지 않습니다.");
		return false;
	}
	
	i = gcds_data.rowposition;
	
	if(gcds_data.namevalue(i,"TAXSTS")!="R"){
		alert("반송 대상 건이 아닙니다.");
		return false;
	}else{
		gcds_data.namevalue(i,"TAXSTS")="B"; 
	}
	
	return true;
}


<%
/******************************************************************************
	Description :반송사유 저장 
******************************************************************************/
%>
function ln_Sb_Reason_Save(){

	if (gcds_data.IsUpdated ){
		if (confirm("반송사유를  저장하시겠습니까 ?")) {
		  
			gctr_data.KeyValue = "Account.a040058_t6(I:USER=gcds_data)";
			
			gctr_data.Action = "<%=dirPath%><%=HDConstant.PATH_ACCOUNT%>a040058_t6";
			
            gctr_data.Parameters="v_str1="+gusrid;
            
            //prompt('',gcds_data.text);
            
			gctr_data.post();
		}
		
	}
	
}

<%
//파일 다운
%>
function fnFileDown(intno){
	
	var strReal_file="";
	var strSys_file="";
	
	if(gcds_data.rowposition<0){
		alert("해당 거래처를 선택하십시요.");
		return false;
	}

	//alert("(gcds_data.rowposition::"+gcds_data.rowposition+"::REAL_FILE2::"+gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE2"));
		
	if(intno==2){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE2")==""){
			alert("발행승인요청서 첨부파일이 존재하지 않습니다.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE2");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE2");
		}
	}else if(intno==1){
		if(gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE")==""){
			alert("사업자등록번호가 첨부파일이 존재하지 않습니다.");
			return false;
		}else{
			strReal_file = gcds_data.namevalue(gcds_data.rowposition,"REAL_FILE");
			strSys_file  = gcds_data.namevalue(gcds_data.rowposition,"SYS_FILE");
		}
	}
	
	
	location.href ="./a040058_fileDownload.jsp?dir=&filename="+strReal_file+"&sysfilename="+strSys_file; //운영
	
}	
</script>
<!-----------------------------------------------------------------------------
		D A T A S E T   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="gcds_data" classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
    <PARAM NAME="UseFilter" VALUE="true">
</object>

<object  id=gcds_empno_chk classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="true">
</object>

<object  id="gcds_fdcode" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 지점코드[검색] -->
</object> 

<object  id="gcds_staxknd" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 부가세종류[매입] -->
</object> 

<object  id="gcds_staxknd2" classid="clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49" VIEWASTEXT> 
	<PARAM NAME="SYNCLOAD" VALUE="false"><!-- 부가세종류[매출] -->
</object> 

<object id=gcds_return classid=clsid:3267EA0D-B5D8-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="SyncLoad" VALUE="false">
</object>

</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
	  T R A N S A C T I O N   C O M P O N E N T S   D E C L A R A T I O N
------------------------------------------------------------------------------>
<comment id="__NSID__">
<object  id="gctr_data" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object>
<object  id="gctr_data2" classid="clsid:0A2233AD-E771-11D2-973D-00104B15E56F" VIEWASTEXT>
	<PARAM NAME="KeyName"  VALUE="toinb_dataid4">
</object>
</comment><script>__ws__(__NSID__);</script> 

<!-----------------------------------------------------------------------------
					D A T A S E T   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>

<script language="javascript" for="gcds_data" event="OnLoadStarted()">
	window.status="데이타 조회중입니다..잠시만 기다려 주십시오.";
</script>

<script language=JavaScript  for=gcds_data event=OnLoadCompleted(row,colid)>
	ft_cnt1.innerText = "조회건수 : " + row + " 건";
	window.status = "정상적으로 조회되었습니다.";
	if (row<1) alert("검색된 데이터가 없습니다.");
</script>

<script language="javascript" for="gcds_empno_chk" event="onloadCompleted(row,colid)">
	ln_Authority_Result(row,colid);
</script>

<script language="javascript" for="gcds_fdcode" event="onloadCompleted(row,colid)">
	gcds_fdcode.InsertRow(1);
	gcds_fdcode.NameValue(1,"FDCODE")="";
	gcds_fdcode.NameValue(1,"FDNAME")="전체";
	gclx_fdcode.bindcolval=gs_fdcode;
</script>

<script language="javascript" for="gcds_staxknd" event="onloadCompleted(row,colid)">
	gcds_staxknd.InsertRow(1);
	gcds_staxknd.NameValue(1,"CDCODE")="";
	gcds_staxknd.NameValue(1,"CDNAM")="전체";
	
	gcds_staxknd.AddRow();
	gcds_staxknd.NameValue(gcds_staxknd.rowposition,"CDCODE")="9";
	gcds_staxknd.NameValue(gcds_staxknd.rowposition,"CDNAM")="세금계산서";

	gcds_staxknd.AddRow();
	gcds_staxknd.NameValue(gcds_staxknd.rowposition,"CDCODE")="6";
	gcds_staxknd.NameValue(gcds_staxknd.rowposition,"CDNAM")="세금계산서+기타";

	gclx_staxknd.index=0;
</script>

<script language="javascript" for="gcds_staxknd2" event="onloadCompleted(row,colid)">
	gcds_staxknd2.InsertRow(1);
	gcds_staxknd2.NameValue(1,"CDCODE")="";
	gcds_staxknd2.NameValue(1,"CDNAM")="전체";
 
	gcds_staxknd2.AddRow();
	gcds_staxknd2.NameValue(gcds_staxknd2.rowposition,"CDCODE")="9";
	gcds_staxknd2.NameValue(gcds_staxknd2.rowposition,"CDNAM")="세금계산서";

	gclx_staxknd_2.index=0;

</script>

<!-----------------------------------------------------------------------------
					G A U C E   C O M P O N E N T' S
		G E N E R A L   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language=JavaScript for="gclx_staxiodiv" event="OnSelChange2()">
	if (gclx_staxiodiv.bindcolval == "1") {	//부가세종류[매입]
		document.all.gclx_staxknd.style.display='block';
		document.all.gclx_staxknd_2.style.display='none';
	}else if(gclx_staxiodiv.bindcolval == "2") {
		document.all.gclx_staxknd.style.display='none';
		document.all.gclx_staxknd_2.style.display='block';
	}
</script>

<script language="javascript"  for=gcgd_data  event="OnDblClick(Row,Colid)">
	var strURL;
	var strPos;
	var arrParam = new Array();
	var result   = new Array();
	
	var strParam = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR").substring(0,1);
	arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR");

	//arrParam[0] = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR").substring(0,1);
	//arrParam[1] = gcds_data.namevalue(gcds_data.rowposition,"FDCODE");
	//arrParam[2] = gcds_data.namevalue(gcds_data.rowposition,"TAXNBR").substring(1,11);

	//strURL = "./staxbill_popup_2_ee_a.jsp";
	//strPos = "dialogWidth:888px;dialogHeight:650px;status:no;scroll:no;resizable:no";
	
	if(strParam=="A"||strParam=="C"||strParam=="E"||strParam=="G"){
		strURL = "./a040110_popup.jsp";
		
	}else if(strParam=="B"||strParam=="D"||strParam=="F"||strParam=="H"){
		strURL = "./a040120_popup.jsp";
	}
	
	strPos = "dialogWidth:970px;dialogHeight:635px;status:no;scroll:no;resizable:no";
	result = showModalDialog(strURL,arrParam,strPos);
</script>

<!----------------------------------------------------------------------------
				T R A N S A C T I O N   C O M P O N E N T' S
		M A N D A T O R Y   E V E N T S   S P E C I F I C A T I O N
------------------------------------------------------------------------------>
<script language="javascript" for="gctr_data" event="onsuccess()">
	alert("작업이 성공적으로 완료되었습니다.");
	ln_Query();
	gcds_data.rowposition=gstrRowpos;
</script>

<script language="javascript" for="gctr_data" event="onfail()">
	alert("작업이 성공적으로 완료되지 못했습니다.");
	alert("Error Code : " + gctr_data.ErrorCode + "\n" + "Error Message : " + gctr_data.ErrorMsg + "\n");
</script>

<script language=JavaScript for=gctr_data2 event=OnSuccess()>
	ln_SM_Call(gcds_return.namevalue(gcds_return.rowposition,"BATCH_ID"),
	           gcds_return.namevalue(gcds_return.rowposition,"ID"),
			   gcds_return.namevalue(gcds_return.rowposition,"PASS"));
</script>

<script language=JavaScript for=gctr_data2 event=OnFail()>
	alert("Error Code : " + gctr_data2.ErrorCode + "\n" + "Error Message : " + gctr_data2.ErrorMsg + "\n");
</script>
</head>
<!-----------------------------------------------------------------------------
						B O D Y   D E F I N I T I O N
------------------------------------------------------------------------------>
<jsp:include page="/Common/sys/body_s02.jsp"  flush="true"/>
<table width="875" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px">
  <tr> 
		<td><img src="../img/a040058_head.gif"></td>
        <td width="685" align="right" background="../../Common/img/com_t_bg.gif">
			<nobr>
			<img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sungin.gif"	style="cursor:hand" onclick="ln_Apply()">
            <img src="<%=HDConstant.PATH_ACC_COMMON%>img/btn/com_b_sendbak.gif"	style="cursor:hand" onclick="ln_SendBack()">&nbsp;&nbsp;&nbsp;
            
			<span id=sp7 style="display:none;"> <!-- 세금계산서보기 -->
				<img src="../../Common/img/btn/com_b_bill_view.gif"     style="cursor:hand" onclick="ln_Bill_View()">
			</span>
			<img src="../../Common/img/btn/com_b_taxselect.gif"  style="cursor:hand"   onclick="ln_Slipno()">&nbsp;&nbsp;&nbsp;

			<img src="../../Common/img/btn/com_b_query.gif"	     style="cursor:hand"   onclick="ln_Query()">
			</nobr>
		</td>
  </tr>
	<tr><td height=4></td></tr>
</table>

<table border="0" cellpadding=0 cellspacing=0 style="position:relative;left:0px;">
	<tr>
		<td>
			<table cellpadding="1" cellspacing="0" border="0" style='position:relative;left:3px;width:877px;font-size:9pt;background-color:#ffffff;BORDER-LEFT-WIDTH:1px;border:1 solid #708090'>
        <tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>지점코드</nobr></td>
					<td width="115px;" class="tab21">
						<comment id="__NSID__"><object  id=gclx_fdcode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;width:100px;height:110px;">
							<param name=ComboDataID			value="gcds_fdcode">
							<param name=CBDataColumns		value="FDCODE,FDNAME">
							<param name=SearchColumn		value="FDNAME">
							<param name=Sort				value=false>
              				<param name=Enable              value="true">
							<param name=ListExprFormat	    value="FDNAME^0^100">
							<param name=BindColumn			value="FDCODE">
							<param name=Index               value="2">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>  
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;사업소&nbsp;</nobr></td>
					<td width="115px;" class="tab21">
            			<nobr>
						<comment id="__NSID__"><object  id=gclx_cocode classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="^전체,01^고성,02^서울,04^홍성">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;계산서기간&nbsp;</nobr></td>
					<td width="407px"class="tab22" colspan=3><nobr>&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatfr classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar1 OnClick="__GetCallCalendar('gcem_staxdatfr', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">~&nbsp;
						<comment id="__NSID__"><object  id=gcem_staxdatto classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F 
							style="position:relative;left:0px;top:2px; width:68px; height:20px;" class="txtbox">
							<param name=Alignment	  value=0>
							<param name=Border	      value=true>
							<param name=Format	      value="YYYY/MM/DD">
							<param name=PromptChar	  value="_">
							<param name=Enable		  value="true">
						</object></comment><script>__ws__(__NSID__);</script> 
						<img src="../img/calender.gif" value="calender.gif" id=img_calendar2 OnClick="__GetCallCalendar('gcem_staxdatto', 'Text')" style="position:relative;width:20px;left:3px;top:1px;cursor:hand;">&nbsp;</nobr>
					</td>
<!-- 			<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;발행여부&nbsp;</nobr></td>
					<td width="115px" class="tab22">
						<comment id="__NSID__"><object  id=gclx_taxprtyn2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData					value="^전체,Y^발행,N^미발행">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value=false>
							<param name=ListExprFormat	value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index						value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
 -->				
        		</tr>
				<tr> 
					<td width="80px" class="tab11" bgcolor="#eeeeee"><nobr>거래처코드</nobr></td>
					<td width="170px;" class="tab21" colspan="5"><nobr>
						<comment id="__NSID__"><object  id=gcem_vendnm classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:250px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit     value="true">
								<param name=PromptChar	    value="_">
							</object></comment><script>__ws__(__NSID__);</script> &nbsp;&nbsp;<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup()">
						<comment id="__NSID__"><object  id=gcem_vendcd classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:90px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=Format			value="#############">
								<param name=PromptChar	    value="_">
							</object></comment><script>__ws__(__NSID__);</script> 
							<img name="btn_clear" src="../../Common/img/btn/com_b_clear.gif"	style="position:relative;top:1px;left:8px;cursor:hand"	 onclick="gcem_vendnm.text='';gcem_vendcd.text='';">
							
					</td>
					
					<td width="80px"  class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;작성자&nbsp;</nobr></td>
					<td width="180px" class="tab22"  ><nobr>
						<comment id="__NSID__">
						   <object  id=gcem_empno  classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F	style="position:relative;top:2px;left:5px;width:150px">
								<param name=Text			value="">
								<param name=Alignment		value=0>
								<param name=Border			value=true>
								<param name=GeneralEdit     value="true">
								<param name=Enable          value=false>
								<param name=PromptChar	    value="_">
							</object>
						</comment><script>__ws__(__NSID__);</script> &nbsp;
						<img name="btn_find2" src="../../Common/img/btn/com_b_find.gif"	style="position:relative;top:2px;left:-2px;cursor:hand"	 onclick="ln_Popup_Empno()">
					</td>
				</tr>
				<tr> 
					<td width="80px"   class="tab11" bgcolor="#eeeeee"><nobr>매입매출구분</nobr></td>
					<td width="110px;" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxiodiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="2^매출">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>  
					<td width="80px"  class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;부가세종류&nbsp;</nobr></td>
					<td width="110px" class="tab21"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxknd classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:block">
							<param name=ComboDataID			value="gcds_staxknd"><!-- 매입구분:0013 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxknd_2 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;height:150px;display:none">
							<param name=ComboDataID			value="gcds_staxknd2"><!-- 매출구분:0009 -->
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value=CDNAM>
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
					<!-- <td width="80px"  class="tab12" bgcolor="#eeeeee"><nobr>&nbsp;귀속구분&nbsp;</nobr></td>
					<td width="200px" class="tab23"><nobr>
						<comment id="__NSID__"><object  id=gclx_staxdiv classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:block">
							<param name=ComboDataID			value="gcds_staxdiv">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^130">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script> 
						<comment id="__NSID__"><object  id=gclx_staxdiv_3 classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:130px;display:none">
							<param name=ComboDataID			value="gcds_staxdiv2">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort						value="false">
							<param name=ListExprFormat	value="CDNAM^0^130">
							<param name=BindColumn			value="CDCODE">
						</object></comment><script>__ws__(__NSID__);</script></nobr>
					</td> -->
					<td width="80px"  class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;전표상태&nbsp;</nobr></td>
					<td width="110px" class="tab21" ><nobr>
						<comment id="__NSID__"><object  id=gclx_fsstat classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^전체,Y^결재완료,C^결재취소,R^결재요청,N^결재대기,B^반송,X^결재완료이외">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>

					<td width="80px"   class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;발행구분&nbsp;</nobr></td>
					<td width="180px"  class="tab22" ><nobr>
						<comment id="__NSID__"><object  id=gclx_gubun classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="^전체,1^전자발행,2^수기발행">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
				</tr>
				
				<tr> 
					<td width="100px"  class="tab11"  bgcolor="#eeeeee"><nobr>원가</nobr></td>
					<td width="149px;" class="tab21" colspan =3>
						<nobr>
						<input id="txt_costnm" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:175px;height:20px;" maxlength="36" >
						<img SRC="../../Common/img/btn/com_b_find.gif" BORDER="0" ALT="원가코드를 검색합니다" style="cursor:hand;position:relative;left:5px;top:1px" align=center onclick="ln_Costcd_Popup();">				
						<input id="txt_costcd" type="text" class="txtbox"  style= "position:relative;left:5px;top:0px;width:50px;height:20px;" maxlength="6"  readOnly=true>	
						</nobr>
					</td>
					<td width="100px"  class="tab11"  bgcolor="#eeeeee"><nobr>eBill구분</nobr></td>
					<td width="149px;" class="tab21" >
						<comment id="__NSID__"><object  id=gclx_ebillgb classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
							<param name=CBData				value="^전체,1^스마트빌,2^트러스빌,9^기타">
							<param name=CBDataColumns		value="CDCODE,CDNAM">
							<param name=SearchColumn		value="CDNAM">
							<param name=Sort				value=false>
							<param name=ListExprFormat	    value="CDNAM^0^100">
							<param name=BindColumn			value="CDCODE">
							<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> 
					</td>
					
					
					<td width="80px"   class="tab11" bgcolor="#eeeeee"><nobr>&nbsp;그리드고정&nbsp;</nobr></td>
					<td width="180px"  class="tab22"  ><nobr>
						<comment id="__NSID__"><object  id=gclx_gridfix classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69 
							style="position:relative;left:5px;top:0px;font-size:12px;width:100px;">
								<param name=CBData				value="1^사업자번호,2^금액,3^적요">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value=false>
								<param name=ListExprFormat	    value="CDNAM^0^100">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
						</object></comment><script>__ws__(__NSID__);</script> </nobr>
					</td>
						
				</tr> 
				
        		<tr> 
					<td width="80px" class="tab12" bgcolor="#eeeeee"><nobr>결재상태</nobr></td>
					<td width="370px;"  colspan="6"><nobr>
						<comment id="__NSID__">
							<object  id=gclx_taxsts classid=clsid:60109D65-70C0-425C-B3A4-4CB001513C69  style="position:relative;left:5px;top:1px;font-size:12px;width:100px;height:100px;">
								<param name=CBData			    value="^전체,N^대기,R^요청,Y^승인,B^반송">
								<param name=CBDataColumns		value="CDCODE,CDNAM">
								<param name=SearchColumn		value="CDNAM">
								<param name=Sort				value="false">
								<param name=Enable				value="true">
								<param name=ListExprFormat	    value="CDNAM^0^90">
								<param name=BindColumn			value="CDCODE">
								<param name=index				value="0">
							</object>
						</comment><script>__ws__(__NSID__);</script>
						</nobr>
					</td>
					<td align = right>
					  <nobr>
						<span id=sp0 style="display:none;">
							<img name="btn_p0_2" src="../../common/img/btn/com_b_save.gif"	style="position:relative;cursor:hand"	onclick="ln_Sb_Reason_Save()"> 
						</span>
						</nobr>
					</td>
				</tr>
				
				
			</table>
		</td>
  </tr>
  <tr><td height=3></td></tr>
  <tr> 
    <td colspan="2"> 
      <table width="865" cellpadding="0" cellspacing="0" border="0" style="position:relative;left:3px;">
        <tr> 
          <td style="width:865" class="tab32">
						<comment id="__NSID__"><object  id="gcgd_data"  classid="clsid:1F57AEAD-DB12-11D2-A4F9-00608CEBEE49" 
							style="height:355;width:875" >
              				<PARAM NAME="DataID"		VALUE="gcds_data">
							<PARAM NAME="Editable"		VALUE="true">
							<PARAM NAME="viewSummary"   VALUE="1">
							<PARAM NAME="ColSizing"		VALUE="true">
							<PARAM NAME="SortView"		VALUE="left">
							<PARAM NAME="BorderStyle"   VALUE="0">
							<param name="IndWidth"      value="0">
							<param name="Fillarea"		VALUE="true">
							<Param Name="UsingOneClick" value="1">
							<PARAM NAME="Format"		VALUE=" 
							<F>ID=CHK,			Name='선택'			,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, EditStyle=CheckBox BgColor='#f5f5f5' SumBgColor=#C3D0DB</F>
							<F>ID=FDNAME, 	    Name='지점'		    ,width=30, HeadBgColor=#B9D4DC,HeadAlign=center, align=left,   Edit=none sort=false SumBgColor=#C3D0DB</F>
							<F>ID=FSNUM,		Name='전표번호'		,width=105,HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true mask='XXXXXXXXX-XXXXXX' SumText='합계'  SumBgColor=#C3D0DB</F>
							<C>ID=VEND_CD,	    Name='거래처코드'	    ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, BgColor='#f5f5f5' Edit=none sort=true show=false SumBgColor=#C3D0DB</C>
							<C>ID=VEND_NM,	    Name='거래처명'		,width=95, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT,   BgColor='#f5f5f5' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=VEND_ID,	    Name='사업자번호'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center, Edit=none sort=true SumBgColor=#C3D0DB mask={decode(VEND_ID_LEN,10,'XXX-XX-XXXXXX',13,'XXXXXX-XX****X')} </C>
							<C>ID=TAXSUM,		Name='공급가액'		,width=85, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=TAXVATAMT,    Name='부가세액'		,width=70, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=TAXTOT,		Name='합계금액'		,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=right   Edit=none sort=true SumBgColor=#C3D0DB SumText=@sum</C>
							<C>ID=REMARK,		Name='적요'			,width=135,HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=TAXKNDNM,	    Name='종류'	        ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=GUBUN,        Name='발행구분'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='1:전자발행,2:수기발행'</C>
							<C>ID=FSSTAT,		Name='전표상태'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:결재완료,C:결재취소,R:결재요청,N:결재대기,B:반송' Edit=none sort=true SumBgColor=#C3D0DB</C>
                            <C>ID=DTI_STATUS,   Name='상태'		    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB EditStyle=Combo Data='S:매출저장,A:매입저장,V:역발행요청,I:수신미승인,C:수신승인,M:발행취소요청(공급받는자),N:발행취소요청(공급자),R:수신거부,O:취소완료,T:역발행거부,W:역발행요청 취소'</C>
							<C>ID=TAXPRTYN,	    Name='발행여부'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  EditStyle=Combo, Data='Y:발행,N:미발행' Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=EMPNMK,		Name='담당자'		    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
							<C>ID=DEPTNM,		Name='담당부서'		,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB</C>
							<C>ID=COSTCD,	    Name='원가'	        ,width=45, HeadBgColor=#B9D4DC,HeadAlign=center,  align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=COSTNM,	    Name='원가명'	        ,width=100, HeadBgColor=#B9D4DC,HeadAlign=center, align=left  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=AMEND_CODE,   Name='수정코드'	    ,width=75, HeadBgColor=#B9D4DC,HeadAlign=center, align=left    Edit=none sort=true show=true SumBgColor=#C3D0DB </C>
							<C>ID=TAXCDNBR,     Name='신용카드번호'	,width=130, HeadBgColor=#B9D4DC,HeadAlign=center, align=center    Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XXXX-XXXX-XXXX'</C>
							<C>ID=TAXDAT,       Name='계산서일자'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  mask='XXXX-XX-XX'</C>
							<C>ID=EXTCHK,       Name='외부발행'       ,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true SumBgColor=#C3D0DB  </C>
							<C>ID=TAXDIVNM,	    Name='귀속구분'		,width=80, HeadBgColor=#B9D4DC,HeadAlign=center, align=LEFT    Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=FSDAT,	    Name='접수일자'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=FSNBR,	    Name='접수번호'		,width=60, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=CREATION_DATE,Name='메일발행일시'	,width=150, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true SumBgColor=#C3D0DB</C>
							<C>ID=DUEDATE,      Name='입금예정일'	    ,width=90, HeadBgColor=#B9D4DC,HeadAlign=center, align=center  Edit=none sort=true show=true mask='XXXX-XX-XX'</C>
							
							">
            </object></comment><script>__ws__(__NSID__);</script> 
						<fieldset style="width:875;height:20px;;border:0 solid #708090;border-top-width:1px;border-bottom-width:1px;text-align:left;">
							&nbsp;<font id=ft_cnt1 style="position:relative;top:4px;"></font>
						</fieldset>
					</td>
        </tr>
      </table>
    </td>
  </tr>
  
  <tr>
  	<td>
  
		<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:3px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
		 <tr height='10px'>
		       <td  ><b><font size="2" color="blue">[반송사유 등록]</font></b></td>
		       <td align=right  >
				<img id="btn_save08"     src="../../Common/img/btn/com_b_save.gif" 	    style="cursor:hand;position:relative;top:2px;" onclick="ln_Sb_Reason_Save()">
			  </td>
		  </tr>
		</table>
 	 </td>
  </tr>
  <tr>
  	<td>
  		<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:0px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
			<tr> 
				<td width="80px"    class="tab25"  bgcolor="#eeeeee" align=center>거래처</td>
				<td width="350px"  class="tab24"  >&nbsp;
					<comment id="__NSID__">
					<input id="txt_vend_cd" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:50px;height:20px;" readOnly >
					<input id="txt_vend_nm" type="text" class="txtbox"  style= "position:relative;left:0px;top:-3px;width:180px;height:20px;" readOnly>&nbsp;&nbsp;
					<object id=gcem_vend_id classid=CLSID:E6876E99-7C28-43AD-9088-315DC302C05F  style="position:relative;left:0px;top:3px;width:90px;height:20px;">
						<param name=Text             value="">
						<param name=Alignment	    value=1>
						<param name=Border	        value=True>
						<param name=Format	        value="000-00-00000">
						<param name=PromptChar	    value="_">
						<param name=BackColor       value="#CCCCCC">
						<param name=InheritColor    value=false>
						<param name=ReadOnly        value=true> 
					</object>
		            </comment><script>__ws__(__NSID__);</script></nobr>
				</td>
				<td width="80px"    class="tab24"  bgcolor="#eeeeee" align=center>반송사유</td>
				<td width="310px"  class="tab24" >&nbsp;
					<comment id="__NSID__">
					<input id="txt_sb_reason" type="text" class="txtbox"  style= "position:relative;left:0px;top:0px;width:280px;height:20px;" maxlength="50" >
					</comment><script>__ws__(__NSID__);</script>
				</td> 
			</tr>
		</table>
  	
  	</td>
  </tr>
  
  <tr>
  	<td>
  		<table cellpadding="0" cellspacing="0" border=0 style="position:relative;left:0px;width:876px;height:30px;font-size:9pt;background-color:#ffffff;">
		    <tr height='30px'>
		          <td colspan=2 ><b><font size="2" color="blue">[첨부파일]</font></b></td>
		    </tr>
		    
		    <tr>
				<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>발행승인요청서</nobr></td>
				<td class="tab18" style="text-align:left"><nobr>
					<input type="text" name='txt_real_file2' id="txt_real_file2" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
		            <img src="<%=dirPath%>/Omsm/images/download.gif"             style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('2')" >
					</nobr> 
				</td>
			</tr>
		    
		    
		    <tr>
				<td width="80px" height="25px" bgcolor="#eeeeee" class="tab37" align=left ><nobr>사업자등록번호</nobr></td>
				<td class="tab18" style="text-align:left"><nobr>
					<input type="text" name='txt_real_file' id="txt_real_file" style="position:relative;left:5px;top:0px;width:350px;" class='input01'   readOnly="readonly">
		            <img src="<%=dirPath%>/Omsm/images/download.gif"           style="position:relative;left:5px;top:0px;cursor:hand"  onClick="fnFileDown('1')" >
					</nobr> 
				</td>
			</tr>
		</table>
  	</td>
  </tr>
 
</table>


<comment id="__NSID__">
<OBJECT id=gcbn_code01  classid=clsid:9C9AB433-EA85-11D2-A4F9-00608CEBEE49 VIEWASTEXT>
	<PARAM NAME="DataID"     VALUE="gcds_data">
	<PARAM NAME="BindInfo"   VALUE="
		<C>Col=VEND_CD		  Ctrl=txt_vend_cd		Param=value</C>
		<C>Col=VEND_NM		  Ctrl=txt_vend_nm		Param=value</C>
		<C>Col=VEND_ID		  Ctrl=gcem_vend_id	    Param=Text</C>
		<C>Col=SB_REASON      Ctrl=txt_sb_reason  	Param=value</C>
		<C>Col=REAL_FILE      Ctrl=txt_real_file 	Param=value</C>
		<C>Col=REAL_FILE2     Ctrl=txt_real_file2  	Param=value</C>
	"> 
</OBJECT>
</comment><script>__ws__(__NSID__);</script>


</body>
</html>
<jsp:include page="/Common/sys/body_e.jsp"  flush="true"/> 